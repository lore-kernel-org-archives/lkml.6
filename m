Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 901FBC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4032C208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hmh.eng.br header.i=@hmh.eng.br header.b="iDfyKSje";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fHOMc0V7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4032C208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hmh.eng.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756155AbeFOMaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 08:30:14 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41665 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756133AbeFOMaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 08:30:11 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id BC84421AC0;
        Fri, 15 Jun 2018 08:30:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 15 Jun 2018 08:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmh.eng.br; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=ItZOvyUjLEfpHjDx8AluSd3x7RLik
        +4jwXIKBNMCUGE=; b=iDfyKSjezByML7IQb5GySofjiaJfjVSzmr3+RgAO0xEWZ
        su4rhCzHsZSZdqvwTMMfAxpwmxbcEMe0F4/OfCxXHr09rXoD6PTUt5ib4unkJ3Kz
        3CTES+oukM4R5afmg7Y93YZWlNw8snonraVXd6yLXp1PANWL/cl+vecHGCcqQMLI
        dRbrqmRBQ1hDBEoWoZWK0vmjusUeYHgFRPIgUMdwrDEs1MOYNHgQXOyQ++88AlFV
        ppA1+i2yGtQjLhBVBCUz8xUbUWOh1aphKKLi1gZq2UiBdp9A5/0TSJKwgCCiuiIz
        FLRfedWoqpHJlLGXmjXKG2ytl7mdcy0zDefQqTA0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ItZOvy
        UjLEfpHjDx8AluSd3x7RLik+4jwXIKBNMCUGE=; b=fHOMc0V7SaHM6M7UurWkEJ
        2fBbqCK0S0/FvwC/Tie9JjvP6BZEndWupNAYZI71XcXg7v7v8/RLdqDBLlmSyGjm
        cWzBgtcHvnUHt9zvPJFjzEFKwaoT0KSq6ed9dGEGcUET1SvKHm5qjVIuqoWtZf7+
        9ye0WuSb4VPYHCjB+eB1nICAFwzj/jfWtDTy31zkO0s0IxJeTzT8sskadNx6J1cQ
        WcMRBJA06L9gP2fFx4uzP2di5AU0vqDpxeqrBzqiVRGdiMC4EykPjGq8yP+XkGpD
        sIDLSL50wrXuxtY8g9kSV0uKldzdwjEXECYwfvHX5iWEMaFsAolFP11AP2jCcuvw
        ==
X-ME-Proxy: <xmx:UrEjWwnP63xeR2sGDHnBu5-fSk3Alk0UQRhMbMAAwseYg38dKrZz_A>
    <xmx:UrEjWzoRav5pIx6Kw0_8AWRmc7J0daXyFek5VLTOy5S7x60QbkLcKQ>
    <xmx:UrEjW3vRaB7D5NBzluOqP0y-FIr2of6YOTPXQLwmU4AniQDzW3RWsg>
    <xmx:UrEjWwEPFFpXReWslQFAtDnVnRmUjrtTuuRSRWdsXcgrX7ldbSSELg>
    <xmx:UrEjW4ZEWqHQyPKFj2QSa8keZjat-3el9A9B2-_Q401zGEUeSC0KQg>
    <xmx:UrEjW-lAKattB_tPm2cmALQVko2yswM09FdRlhxwbdYNmVAqKWRzsA>
X-ME-Sender: <xms:UrEjWxeDLZJkZgOVxO2O1Nc8I0mNs3XC4yenlLNrdQosAzcc-dYPBg>
Received: from khazad-dum.debian.net (unknown [201.53.245.99])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4AC0510273;
        Fri, 15 Jun 2018 08:30:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by localhost.khazad-dum.debian.net (Postfix) with ESMTP id 89D5F3400BEA;
        Fri, 15 Jun 2018 09:30:08 -0300 (-03)
X-Virus-Scanned: Debian amavisd-new at khazad-dum.debian.net
Received: from khazad-dum.debian.net ([127.0.0.1])
        by localhost (khazad-dum2.khazad-dum.debian.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Mq-NmPNcgPW4; Fri, 15 Jun 2018 09:30:07 -0300 (-03)
Received: by khazad-dum.debian.net (Postfix, from userid 1000)
        id 9D3753400436; Fri, 15 Jun 2018 09:30:07 -0300 (-03)
Date:   Fri, 15 Jun 2018 09:30:07 -0300
From:   Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ThinkPad T480s & LED_MUTE, LED_MICMUTE
Message-ID: <20180615123007.nxsymdvr3nj3it5i@khazad-dum.debian.net>
References: <20180608111057.4wxpg7m7nm7suf6n@pali>
 <20180615112606.GA3986@amd>
 <20180615113728.h7snxhe2juaqvjyx@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180615113728.h7snxhe2juaqvjyx@pali>
X-GPG-Fingerprint1: 4096R/0x0BD9E81139CB4807: C467 A717 507B BAFE D3C1  6092
 0BD9 E811 39CB 4807
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2018, Pali Rohár wrote:
> Henrique, any idea why there are no exported led classes for mute and
> micmute? And how are suppose to be controlled?

I have to look into the code, it was contributed by someone who had
access to the proper hardware to test it.

But the way *I* would like it to work is this:

1. When implemented in *hardware* or *EC*, let the hardware and EC take
   full control, and never allow the operating system to mess with it.
   So, it becomes much harder for that LED to "lie".

2. Otherwise implement it in-kernel, so that userspace cannot unmute
   when the human has activated the "mute" switch, and the LED cannot be
   controlled by userspace to lie (report mute when it is not mute).

It might, or might not be possible to achieve the above.

> > With thinkpad_acpi.ko unloaded, hardware drives the LEDs, so nothing
> > for us to do...
> 
> So somehow tell thinkpad_acpi.ko to let hardware control those LEDs when
> thinkpad_acpi.ko is loaded?

I.e. look into the DSDT and XSDT, to find out what it is doing.  It will
be there: it is very rare for the thinkpad EC itself to implement these
behavior changes.

-- 
  Henrique Holschuh
