Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E48EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87CD208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=awxrd.com header.i=@awxrd.com header.b="REdscCXX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RpWHRGI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87CD208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=awxrd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732414AbeGaQQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:16:09 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37965 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732231AbeGaQQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:16:08 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 629EC21BA5;
        Tue, 31 Jul 2018 10:35:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 31 Jul 2018 10:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=awxrd.com; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=6pwWLaDWsvhtFm4Sm/5XTekT8dKVG
        Gn59783sYKb3D4=; b=REdscCXXoYrbYtgFyj7FkdO7FWhdhyoVH7q+z5BW6DJjR
        0N9grg6d6KsbMfSgGIf5yvwBE6UkiyeE5/JHW28QlRbs+oUuHaoViVBRrheKRpd1
        3w0Sy/u/V0qV6r9sGsJzcB1ep3xGbiXjFn+lduOVpYHEWoZV/k01aUUh1efp+FNx
        tlXH8acsmr81oni25hNSiRtuLFrRODHuoksrNAjp7dph3RULoemgt1A1WD5DURci
        g15zM0O+nqOJQA7Haz9tOb0U+8ze9cp17tRYyEaQQcjR9DeEdLpod0u+rnKtHcxi
        pZ9zFjuFxE71ansDBbh8mP3QEXSht0MGKxQNPADQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=6pwWLa
        DWsvhtFm4Sm/5XTekT8dKVGGn59783sYKb3D4=; b=RpWHRGI39+bkDhljwikpNB
        +0ftBcRz/DYK909dR4VrOrZCTNpoWec7SHD9fwbwqim35yzkuL0uxh46xVdaXuWY
        lr2Sw7zBp+xHKTjcUnUzOFOgTRP0zrypUlyXP1KZq3ZNkttaMMb/odfTMfq/CIbu
        hjYo4m3q+HbNk5TJHKLlADKzqa4BYjq95i8uCN/dvt0F7JtE2aynx4VAZel+jmwq
        NgaxElKI1QbVf7dRnpfdERP2RRoG3nQlN4hCXYp1ex6WtF9sXiAy4mW2VGSPjoLT
        ybgGAAXJLy/tOecbe/haGgfvvxxxRittQiDSUfnBC/msEYk3F2hzpvCsVSj5HXfQ
        ==
X-ME-Proxy: <xmx:sHNgW_1HED0UZPjRXh6mdpWQC1Qr4zF0PWLi6z25n7BYi_6Ky_pKZQ>
    <xmx:sHNgW6M_tm5e3_lsMBybQLnk6ynI1W4q2je8r3yvqj83SoSXciQl3w>
    <xmx:sHNgW5KmXqJWpkZ3wqbHpj83Iyyk4KO9MlpWLW248mi-F40QEbBLkw>
    <xmx:sHNgWz59b6qWdLBfOg6lvMILnsBx6Mhez3kuHpUWyyq9Yp5lnBlPdg>
    <xmx:sHNgW2T-pUuyTuqutMd7Wu9VhDZcPWTd_NkMzfH22Q2crWCFDPDtwg>
    <xmx:sXNgW7v69pnBbIOouRe8pDlsZjh1FxTv_33Z6irOIilJvNEf1ywybw>
X-ME-Sender: <xms:sHNgWz0LLe3NKTU0Jbm7-FNLPIPzZIsw0URrLY21hCFb-xRTooIShA>
Received: from allworx.com (unknown [24.213.148.66])
        by mail.messagingengine.com (Postfix) with ESMTPA id C3722E425A;
        Tue, 31 Jul 2018 10:35:27 -0400 (EDT)
Date:   Tue, 31 Jul 2018 10:35:25 -0400
From:   David Rivshin <drivshin@awxrd.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Ladislav Michl <ladis@linux-mips.org>,
        David Rivshin <drivshin@allworx.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-pwm@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH] pwm: pwm-omap-dmtimer: fix probing problems by
 returning EPROBE_DEFER
Message-ID: <20180731103525.7d4c5b47.drivshin@awxrd.com>
In-Reply-To: <BC0B4EAD-6DC1-4338-9185-FA319F998D41@goldelico.com>
References: <20180728165914.15871-1-andreas@kemnade.info>
        <20180728203501.GA16194@lenoch>
        <BE83C4E8-55B0-4EA7-8FF6-756460464264@goldelico.com>
        <20180729180804.GA18468@lenoch>
        <920A2836-9266-46F8-9A3F-111C01999C9E@goldelico.com>
        <20180730185625.14c0feca.drivshin@awxrd.com>
        <BC0B4EAD-6DC1-4338-9185-FA319F998D41@goldelico.com>
Organization: Allworx
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jul 2018 08:35:26 +0200
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> > Am 31.07.2018 um 00:56 schrieb David Rivshin <drivshin@awxrd.com>:
> > 
> > On Sun, 29 Jul 2018 20:19:08 +0200
> > "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
> >   
> >> Hi,
> >>   
> >>> Am 29.07.2018 um 20:08 schrieb Ladislav Michl <ladis@linux-mips.org>:
> >>> 
> >>> On Sun, Jul 29, 2018 at 08:32:41AM +0200, H. Nikolaus Schaller wrote:    
> >>>> Hi,
> >>>>   
> >>>>> Am 28.07.2018 um 22:35 schrieb Ladislav Michl <ladis@linux-mips.org>:
> >>>>> 
> >>>>> Hi Andreas,
> >>>>> 
> >>>>> On Sat, Jul 28, 2018 at 06:59:14PM +0200, Andreas Kemnade wrote:    
> >>>>>> I got this in the kernel log:
> >>>>>> [    0.756042] omap-dmtimer-pwm dmtimer-pwm: dmtimer pdata structure NULL
> >>>>>> [    0.756134] omap-dmtimer-pwm: probe of dmtimer-pwm failed with error -22
> >>>>>> 
> >>>>>> the probe function has to wait until omap_dm_timer_probe() in
> >>>>>> clocksource/timer-ti-dm.c has initialized pdata, so defer probing    
> >>>>> 
> >>>>> There already is a patch by David Rivshin addressing the same issue...    
> >>>> 
> >>>> Here it is:
> >>>> 
> >>>> https://patchwork.ozlabs.org/patch/943148/
> >>>> 
> >>>> but hasn't arrived in linux-next.    
> >>> 
> >>> That's because there'll be v3.
> >>>   
> >>>> But it is questionable if a driver should dev_info() about doing deferred probing.
> >>>> IMHO, it should just do it which is how Andreas' patch works.    
> >>> 
> >>> See here: https://patchwork.ozlabs.org/patch/949659/    
> >> 
> >> Ah, I see (neither Andreas nor me did follow the original discussions
> >> and therefore came up independently with the same thoughts).  
> > 
> > Seems a lot of us have tripped over this problem at roughly the same 
> > time. I'm hoping Thierry picks it up in time for the 4.19 merge window.  
> 
> Well, if possible it should be backported to 4.18 and 4.17.

Agreed. I have a Fixes: and CC:stable in the commit message, so it should
get backported shortly after getting merged to mainline. I assume it's too 
late for 4.18-rcX since it's not in linux-next yet, which is why I said 
hopefully 4.19-rc1.

> 
> >   
> >> So we will wait for the v3.  
> > 
> > FYI, v3 has been posted: https://patchwork.ozlabs.org/patch/951299/
> > Let me know if you feel strongly enough about having no message
> > (vs dev_dbg) for me to spin a quick v4.  
> 
> I am fine with dev_dbg.
> 
> > Seems like each additional 
> > pair of eyes leans in that direction.
> > 
> > Ladislav, I realized just after I sent that I forgot to add your ack
> > to the commit message. Sorry for the oversight.
> >   
> 
> BR and thanks,
> Nikolaus
> 

