Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC560ECDFBD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1F02084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1F02084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeGTIHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:07:17 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:49614 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbeGTIHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:07:16 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 41X2N80Jpqz1qvyy;
        Fri, 20 Jul 2018 09:20:24 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 41X2N76pRQz20xT2;
        Fri, 20 Jul 2018 09:20:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id MXovyqyzbz2G; Fri, 20 Jul 2018 09:20:22 +0200 (CEST)
X-Auth-Info: ahZVuOL76DKvek2OY/P+lmV/Xhii6qwY5qSujVbyL/L9Ql12yVG44UctlbGgLuAr
Received: from igel.home (ppp-188-174-158-212.dynamic.mnet-online.de [188.174.158.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 20 Jul 2018 09:20:22 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id C2E912C1EAC; Fri, 20 Jul 2018 09:20:21 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: m68k allmodconfig build errors
References: <28ebe45d-3dbd-2a82-f537-b0725f7a2bcf@infradead.org>
X-Yow:  I just remembered something about a TOAD!
Date:   Fri, 20 Jul 2018 09:20:21 +0200
In-Reply-To: <28ebe45d-3dbd-2a82-f537-b0725f7a2bcf@infradead.org> (Randy
        Dunlap's message of "Thu, 19 Jul 2018 15:39:50 -0700")
Message-ID: <878t66idai.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 19 2018, Randy Dunlap <rdunlap@infradead.org> wrote:

> block/partitions/ldm.o: In function `ldm_partition':
> ldm.c:(.text+0x1900): undefined reference to `strcmp'
> ldm.c:(.text+0x1964): undefined reference to `strcmp'
> drivers/rtc/rtc-proc.o: In function `is_rtc_hctosys':
> rtc-proc.c:(.text+0x290): undefined reference to `strcmp'
> drivers/watchdog/watchdog_pretimeout.o: In function `watchdog_register_governor':
> (.text+0x142): undefined reference to `strcmp'

GCC has optimized strncmp to strcmp, but at a stage where macros are no
longer available.  I think the right fix is to use strcmp directly,
since strncmp doesn't make sense here.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
