Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB22C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B7920837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5phekq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B7920837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933186AbeFULag (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:30:36 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35255 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932947AbeFULae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:30:34 -0400
Received: by mail-wr0-f195.google.com with SMTP id l8-v6so2821110wrr.2;
        Thu, 21 Jun 2018 04:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Nf6xFkDF6TmSAc7t3o4UNOl+30sbqhAIIKkh2yf4e2U=;
        b=i5phekq1r9D0nNu2BoCTxHLCjg8/RWEavI2XpG2BHqcFHIulKFYTTDSIrDbswrsAFJ
         asZUiqKIRshJKMKCQKqkizVhLDAUpKE/yYV1wcVM48jT4x+/Cm0YsMuKXWDhz1JMTQzA
         GBrUZC4EVq3Nev05WBbPwaY1p9wTuTJP2E/uYPfNRAYJzT/L7O9VewpxDonS6RbrfHZI
         xHGFwsQA6sQWBGQODeuFoAVtSrrx1WHs9E4gcrCB8K31l8tapvgRd+p/IN7hk9vyoe85
         wcK1xkWNlFKZc0gtCDrgxzj9PlkhP/9dNnd6nQ6HB+Os26LXuaUr7KG1/o52Hs4ab1Gq
         JvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Nf6xFkDF6TmSAc7t3o4UNOl+30sbqhAIIKkh2yf4e2U=;
        b=QEzNn7ZlCCGJdHO+60zHYkBKyl8+4M7zCp1IO8AxPiYVi6Be0af06nW4V3zep2aGDf
         lp22a5EY94Jr9g4+89Wznu0GMy2nCt/4s5jkPSIlNJQGU8liK5dI0ugOin5faUyyzuDS
         7Cf23cESHsW6jGUsPvhOdjLGQ6HANMIDsqpWG7fQwGiPDttVT3Zu9o4glXV7YS5hT4Hi
         uAs0wY3qW/Lu0p9b+HiTu/wfHZbfvT7EJZy9ZvkRjR+Tp0xfymOxgkYt1pGF8RxS+E+D
         aaMEtJKp1zB7pPXJrpxRyLnie2K2Pglw5T2oAh/IfgKWIVYRKCTVIvNALYwcvTy956EU
         cEbw==
X-Gm-Message-State: APt69E2ZI1S0RxVRYz2zFHM6uhJcgsWpXYv6DIZLei9Xb/h6MySZKTjW
        whM7BdhO4iiIkOndFW7MweU=
X-Google-Smtp-Source: ADUXVKJYdA5XX/q5DD/R1+a+V5ZacnJQniWwhc+Fzxmj+1iBKoHDQk/LJjS5I7ZNDc2ygmN2+ik0Fw==
X-Received: by 2002:adf:f391:: with SMTP id m17-v6mr20600546wro.279.1529580633524;
        Thu, 21 Jun 2018 04:30:33 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id n14-v6sm4979236wrm.23.2018.06.21.04.30.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 04:30:32 -0700 (PDT)
Date:   Thu, 21 Jun 2018 13:30:31 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ThinkPad T480s & LED_MUTE, LED_MICMUTE
Message-ID: <20180621113031.gv53yv3g46uaetwm@pali>
References: <s5hk1r01acc.wl-tiwai@suse.de>
 <20180615190959.pqipwnm6a3tf3lxc@pali>
 <s5hmuvvtdmi.wl-tiwai@suse.de>
 <20180616154309.ualrx2py6ndr5xgz@pali>
 <s5hh8m2u3cp.wl-tiwai@suse.de>
 <20180618102806.vwm4rhvxhn6hi43z@pali>
 <s5ha7rsz8i8.wl-tiwai@suse.de>
 <20180618112121.cl76a3oozsbbbqnb@pali>
 <20180618112618.hcwiacfzzu4swwd2@pali>
 <s5h1sd4xg3t.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <s5h1sd4xg3t.wl-tiwai@suse.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 June 2018 17:35:18 Takashi Iwai wrote:
> On Mon, 18 Jun 2018 13:26:18 +0200,
> Pali Rohár wrote:
> > 
> > On Monday 18 June 2018 13:21:21 Pali Rohár wrote:
> > > Now I see that in Debian backports is some 4.16.12 kernel version. I can
> > > try this one (and later compile one from Linus tree).
> > 
> > Tested, this version is working fine and leds works as expected. And now
> > also snd_hda_codec_realtek is loaded.
> 
> Good to hear :)
> 
> Below are test patches to allow user choosing the mic mute LED
> behavior on Thinkpad, too.  Note: totally untested!
> 
> Let me know if these work for you.

I applied them to Debian's kernel (with slightly modification) and they
are working fine. Via "alsamixer -c 0" I can change "Mic Mute-LED Mode"
to "Follow Capture" and then led is ON only when microphone is ON.
Recording from microphone is working in both configurations.

If testing with Debian's kernel is enough, you can add my:

Tested-by: Pali Rohár <pali.rohar@gmail.com>

Anyway, (this question is also for Henrique), what can we do with MUTE
led to work? Support for controlling it was there, but was revered in
commit 3530febb5c7636f6b26d15637f68296804d26491.

-- 
Pali Rohár
pali.rohar@gmail.com
