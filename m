Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7AAC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F118216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F118216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbeI0WTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:19:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8977 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727410AbeI0WTo (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:19:44 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38EDD308FF30;
        Thu, 27 Sep 2018 16:00:49 +0000 (UTC)
Received: from krava (ovpn-116-113.ams2.redhat.com [10.36.116.113])
        by smtp.corp.redhat.com (Postfix) with SMTP id DDA1B3022846;
        Thu, 27 Sep 2018 16:00:45 +0000 (UTC)
Date:   Thu, 27 Sep 2018 18:00:42 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     acme@kernel.org, jolsa@kernel.org, yao.jin@linux.intel.com,
        namhyung@kernel.org, Linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Sandipan Das <sandipan@linux.ibm.com>
Subject: Re: [PATCH 2/3] perf report: use the offset address to find inline
 frames
Message-ID: <20180927160042.GA6916@krava>
References: <20180926135207.30263-1-milian.wolff@kdab.com>
 <20180926135207.30263-2-milian.wolff@kdab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926135207.30263-2-milian.wolff@kdab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 27 Sep 2018 16:00:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 03:52:06PM +0200, Milian Wolff wrote:
> To correctly find inlined frames, we have to use the file offset
> instead of the virtual memory address. This was already fixed for
> displaying srcline information while displaying in commit
> 2a9d5050dc84fa20 ("perf script: Show correct offsets for DWARF-based
> unwinding"). We just need to use the same corrected address also when
> trying to find inline frames.
> 
> This is another follow-up to commit 19610184693c ("perf script: Show
> virtual addresses instead of offsets").
> 
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> Cc: Sandipan Das <sandipan@linux.ibm.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
