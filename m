Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A061C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CB420857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=awxrd.com header.i=@awxrd.com header.b="R1+et/R6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MrefzjkD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CB420857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=awxrd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbeGaAdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:33:41 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46997 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732024AbeGaAdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:33:40 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id EA78A21BBA;
        Mon, 30 Jul 2018 18:56:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 30 Jul 2018 18:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=awxrd.com; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=QhNqhmOKJBWPwpitIHau8djmJ/ZHC
        gNFhaVeCbg5SdI=; b=R1+et/R6938E0N+nBaIuMZvDGYNMiWVnvvTYYpgkwjamS
        c5KPq65WR6eYwnuIPdj0xQ86/ZUP1Exv3sVzB278x84jHgNXh6D9HWGaWlEZwYSN
        PY8+tv0/U0JtHuhECf0CPQb4dAyl2fJH4aSStPZ2MUk01zv3uWyaKL2VmhSuXyTP
        2phrwv7+pUu2cQ52eFXbjokq82bHVO0qeOH4B8RmN3K5OJfPWvMfsluxSyn8pMu7
        1rWOgtM3jPeK+mJ2L9vszLCb08dNHAtbo1U+zqOl6UBcyemdmgQjljUvkgg65C/w
        IN6n+IHHgay0zLUDoPmTv7hUljm/6Ui7jbu+aPXNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=QhNqhm
        OKJBWPwpitIHau8djmJ/ZHCgNFhaVeCbg5SdI=; b=MrefzjkDPuQ/cM9h9jDggG
        EB0hVUO7jcMzfhktGEXdnc5mDp9mI5yCoPbJUmq5nYtpMetj3NPs1hEaKPzc32Kg
        I55/vz3cYUkH3vCWM2U+vflLjyaImqm6GWL9m59d6fZ3TXbbQ+3CMrA/PJnZLcAy
        ze91dmJfonxRzSSzdwyfirQpDbcXSZsOmt/1P01tKSxz0ZqGAp29XbrgO7Pkp2US
        fYLkSu3g2ecLzBe5luvfzUT4IrCyiJJkfyS+d8HhAnciu4dnWHjRE4X4IDez8f4s
        c8SR3J8hGJg61DBW5kTs27AX//sXxGi+qUkecahtUSKCgt7kQ84ZC41WenhcIONA
        ==
X-ME-Proxy: <xmx:m5dfWxhuiVFcGy5PycEnF7BgOOH0tF4h6Y--qNnJ7eJPL_osO7XxDQ>
    <xmx:m5dfWzlM0WnkTG6S21zMfSLdP0kHTpzN73ZNg5nB2nEeVRx1PO5kug>
    <xmx:m5dfW3gY1FlRqGgFufrIUCG9S_aJhYeTTpzyXbxtnoYTcsPue1MFCA>
    <xmx:m5dfW30Pn7MHw0gEIayK1aIXC5FR_7QcwAC_GkitPf2Ngu-6Hwzscg>
    <xmx:m5dfWwJGLWLlNdR0vJDsbbwkJTe4UF-j6Xk5YBFSmJsDVpSB-Ssheg>
    <xmx:m5dfW5gOKtLQhzxmkX1vWMcqgYEa1IsLV4gWViia_0UutSVDVMtkoA>
X-ME-Sender: <xms:m5dfW2OFsvtgqub3H6DZ_P0t8GV1GIT0WKFzqQrO1kXQbekLFEivYQ>
Received: from allworx.com (unknown [24.213.148.66])
        by mail.messagingengine.com (Postfix) with ESMTPA id B9605E4116;
        Mon, 30 Jul 2018 18:56:26 -0400 (EDT)
Date:   Mon, 30 Jul 2018 18:56:25 -0400
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
Message-ID: <20180730185625.14c0feca.drivshin@awxrd.com>
In-Reply-To: <920A2836-9266-46F8-9A3F-111C01999C9E@goldelico.com>
References: <20180728165914.15871-1-andreas@kemnade.info>
        <20180728203501.GA16194@lenoch>
        <BE83C4E8-55B0-4EA7-8FF6-756460464264@goldelico.com>
        <20180729180804.GA18468@lenoch>
        <920A2836-9266-46F8-9A3F-111C01999C9E@goldelico.com>
Organization: Allworx
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jul 2018 20:19:08 +0200
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> Hi,
> 
> > Am 29.07.2018 um 20:08 schrieb Ladislav Michl <ladis@linux-mips.org>:
> > 
> > On Sun, Jul 29, 2018 at 08:32:41AM +0200, H. Nikolaus Schaller wrote:  
> >> Hi,
> >>   
> >>> Am 28.07.2018 um 22:35 schrieb Ladislav Michl <ladis@linux-mips.org>:
> >>> 
> >>> Hi Andreas,
> >>> 
> >>> On Sat, Jul 28, 2018 at 06:59:14PM +0200, Andreas Kemnade wrote:  
> >>>> I got this in the kernel log:
> >>>> [    0.756042] omap-dmtimer-pwm dmtimer-pwm: dmtimer pdata structure NULL
> >>>> [    0.756134] omap-dmtimer-pwm: probe of dmtimer-pwm failed with error -22
> >>>> 
> >>>> the probe function has to wait until omap_dm_timer_probe() in
> >>>> clocksource/timer-ti-dm.c has initialized pdata, so defer probing  
> >>> 
> >>> There already is a patch by David Rivshin addressing the same issue...  
> >> 
> >> Here it is:
> >> 
> >> https://patchwork.ozlabs.org/patch/943148/
> >> 
> >> but hasn't arrived in linux-next.  
> > 
> > That's because there'll be v3.
> >   
> >> But it is questionable if a driver should dev_info() about doing deferred probing.
> >> IMHO, it should just do it which is how Andreas' patch works.  
> > 
> > See here: https://patchwork.ozlabs.org/patch/949659/  
> 
> Ah, I see (neither Andreas nor me did follow the original discussions
> and therefore came up independently with the same thoughts).

Seems a lot of us have tripped over this problem at roughly the same 
time. I'm hoping Thierry picks it up in time for the 4.19 merge window.

> So we will wait for the v3.

FYI, v3 has been posted: https://patchwork.ozlabs.org/patch/951299/
Let me know if you feel strongly enough about having no message
(vs dev_dbg) for me to spin a quick v4. Seems like each additional 
pair of eyes leans in that direction.

Ladislav, I realized just after I sent that I forgot to add your ack
to the commit message. Sorry for the oversight.

> 
> BR and thanks,
> Nikolaus
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pwm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

