Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C0FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37F420874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVJpFJSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37F420874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388550AbeGXPYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:24:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388430AbeGXPYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:24:37 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14A1D20874;
        Tue, 24 Jul 2018 14:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532441876;
        bh=Nw2bSGUb/2/f3TzEPlMU0g3EWVftZBqp2+aWA7//EPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DVJpFJSgQOCrNXgs2cRZiywRC9KmPYKuALOntra9oCgdlD21cQIjs/CXeZsRe6kEm
         +cAxe63fvna3KjtKetmgHNfGRZnxmDafn3t7Nt2JPCKBKil8CjGP7VJ8ocLDSF9iDO
         PgF9NgeMdqKZtaz06VY9Y2DIBwRyZMLwCbPtq25U=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 8E3CE140260; Tue, 24 Jul 2018 11:17:51 -0300 (-03)
Date:   Tue, 24 Jul 2018 11:17:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf test: Fix subtest number when showing results
Message-ID: <20180724141751.GC13220@kernel.org>
References: <20180724134858.100644-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724134858.100644-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 24, 2018 at 03:48:58PM +0200, Thomas Richter escreveu:
> Perf test 40 for example has several subtests numbered 1-4 when
> displaying the start of the subtest. When the subtest results
> are displayed the subtests are numbered 0-3.
> 
> Use this command to generate trace output:
> [root@s35lp76 perf]# ./perf test -Fv 40 2>/tmp/bpf1
> 
> Fix this by adjusting the subtest number when show the
> subtest result.

Thanks, applied.

- Arnaldo
