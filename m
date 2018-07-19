Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A144ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15B820673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QhsmszxF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15B820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbeGSXZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:25:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59884 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731262AbeGSXZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZOJSTMJLP9xgbn2hDj7CZA/eucDzlu2wj24y7mMpG6c=; b=QhsmszxFW/G50tjiT1oTd2hTY
        h+BEu71wnuCmdRzIRuSzfdDni39hputOlyfcNeEHWJ13BNKX3CfHO2j0452RNz1ETad/fMv+Egnz8
        eb82bE/tIl3o7AorB+qqA7F7FOscg4OnDWi+cD9xbHwlYHU7rwBpzvj8vtRykz+xvIyJoMgeUghrZ
        sH3v7SM1g9PpEsIPcKvD0h+w+p62R/+u/ktHZAOfX66jrHMjCWVNq8XvU5DhJCCv5hHx4x0algsZI
        aj/XnIPL43rAtbsQPRilQC+rBzCxggyrdec8Z0BHiXcGmAKIGX1U/X3WTFiMLnV/g6ZB+YxP2jlsY
        YGCZR1TpA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgHaR-0006j6-78; Thu, 19 Jul 2018 22:39:51 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: m68k allmodconfig build errors
Message-ID: <28ebe45d-3dbd-2a82-f537-b0725f7a2bcf@infradead.org>
Date:   Thu, 19 Jul 2018 15:39:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

I am seeing a few errors when cross-building m68k on x86_64, using the
toolchain at https://mirrors.edge.kernel.org/pub/tools/crosstool/ (thanks, Arnd).
(so this is gcc 8.1.0)

block/partitions/ldm.o: In function `ldm_partition':
ldm.c:(.text+0x1900): undefined reference to `strcmp'
ldm.c:(.text+0x1964): undefined reference to `strcmp'
drivers/rtc/rtc-proc.o: In function `is_rtc_hctosys':
rtc-proc.c:(.text+0x290): undefined reference to `strcmp'
drivers/watchdog/watchdog_pretimeout.o: In function `watchdog_register_governor':
(.text+0x142): undefined reference to `strcmp'


Adding #include <linux/string.h> does not help.

Is this a toolchain problem or drivers or something else?

help?

thanks,
-- 
~Randy
