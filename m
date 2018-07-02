Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC43BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4B1246B6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RE4hB6dj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A4B1246B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752755AbeGBQlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:41:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44926 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752201AbeGBQlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TLYE6hmft3niRkIASpGm/OJ+6s6ycotD/wQM5F58KOE=; b=RE4hB6djjuBTPq6e0kapaKoFt
        Zi4ebF3tg1iDgol6xjm0+MY1RJ0UkNUbbfslNXOE0bDqFnH/o47LamGt7kxag++OVPG1CMooN99Gw
        9P5gjjGhMAUGB3WSfHUzypxGIePj95djAVTHU7OnnxNz/WCvRCXL+om7mC2Eda3l21ZxMEJJYvmEl
        FflLdAY/rDu1xoHUBzvSfShf9mAe5lsc4uWe+Ry+63gONy+rjDsKjzytuxZhOhoaVezuYQtVMw000
        JTkjTvcGCEHop21dY9NHfyHE1lzoHg8++FfLmKRU7XpSeqHgxXpNDlkfRmbkANtqz6cNa2KjZHQsI
        cHO6mWnPg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fa1t7-0007Rj-EH; Mon, 02 Jul 2018 16:41:17 +0000
Subject: Re: linux-next: Tree for Jul 2 (sound/soc/pxa/)
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org
References: <20180702145158.10190101@canb.auug.org.au>
 <2276786f-3f50-0740-0500-68a26a49704a@infradead.org>
Message-ID: <c12cc7c4-03d0-4b0b-d02f-7e72b8a135d4@infradead.org>
Date:   Mon, 2 Jul 2018 09:41:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <2276786f-3f50-0740-0500-68a26a49704a@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[add other maintainers]

On 07/02/18 09:09, Randy Dunlap wrote:
> On 07/01/18 21:51, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20180629:
>>
> 
> on i386 or x86_64:
> 
> builtin:
> sound/soc/pxa/pxa-ssp.o:(.rodata+0x228): undefined reference to `pxa2xx_soc_pcm_new'
> sound/soc/pxa/pxa-ssp.o:(.rodata+0x22c): undefined reference to `pxa2xx_pcm_free_dma_buffers'
> sound/soc/pxa/pxa-ssp.o:(.rodata+0x250): undefined reference to `pxa2xx_pcm_ops'
> /home/rdunlap/lnx/next/linux-next-20180702/Makefile:1023: recipe for target 'vmlinux' failed
> 
> modular:
> ERROR: "pxa2xx_pcm_ops" [sound/soc/pxa/snd-soc-pxa-ssp.ko] undefined!
> ERROR: "pxa2xx_pcm_free_dma_buffers" [sound/soc/pxa/snd-soc-pxa-ssp.ko] undefined!
> ERROR: "pxa2xx_soc_pcm_new" [sound/soc/pxa/snd-soc-pxa-ssp.ko] undefined!
> 
> 
> x86_64 [modular] randconfig file is attached.
> 


-- 
~Randy
