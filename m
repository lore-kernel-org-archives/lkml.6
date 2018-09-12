Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166F1C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF431213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF431213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbeIMAHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:07:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727047AbeIMAHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:07:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 92C9740201BD;
        Wed, 12 Sep 2018 19:01:13 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-27.phx2.redhat.com [10.3.112.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DD4FF2026D76;
        Wed, 12 Sep 2018 19:01:12 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 8208811A; Wed, 12 Sep 2018 16:01:07 -0300 (BRT)
Date:   Wed, 12 Sep 2018 16:01:07 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tools: Remove conflicting BITS_PER_LONG define
Message-ID: <20180912190107.GA5502@redhat.com>
References: <20180912170232.25258-1-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912170232.25258-1-alexander.sverdlin@nokia.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 12 Sep 2018 19:01:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 12 Sep 2018 19:01:13 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'acme@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 12, 2018 at 07:02:32PM +0200, Alexander Sverdlin escreveu:
>   CC       .../tools/objtool/builtin-check.o
>   ...
> In file included from .../tools/arch/x86/include/uapi/asm/bitsperlong.h:11:0,
>                  from .../tools/include/asm-generic/bitops/__ffs.h:6,
>                  from .../tools/include/asm-generic/bitops.h:16,
>                  from .../tools/include/linux/bitops.h:35,
>                  from .../tools/include/linux/hashtable.h:13,
>                  from elf.h:24,
>                  from check.h:22,
>                  from builtin-check.c:30:
> .../tools/include/asm-generic/bitsperlong.h:8:0: error: "BITS_PER_LONG" redefined [-Werror]
>  #define BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
> 
> Include <asm/bitsperlong.h> instead as other headers do.

Please try test building all tools in tools/

This broke make -C tools/perf/

- Arnaldo
