Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C75DC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1EF20846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIFn1cRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1EF20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933229AbeFULho (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:37:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50840 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933009AbeFULhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:37:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id e16-v6so4625542wmd.0;
        Thu, 21 Jun 2018 04:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=i0SIBGq8xU/51yMqaBrsuBeLMp0XJCc4t+4qPZTEPP8=;
        b=IIFn1cRVtgP13I8cKdkDYhQNQ4tHDBIi5RRxVivfdwM5iOf6o/elcZjLYAJZM11cmL
         mc9ABbg6fqhJhv6SeX2uEHYIeiep/LOXAh17DoSzE7DE+iF67MWQctrvPS5sI8jEy9td
         2Sp6cguTAvHBKWbuM1LgLJzznuLKMcdtIH7pUViw9tITdZb51LnTXxqf7gfy7YphcoHN
         ajmpaTcVUr+1qcF97TiDk8pY7UeAt42vBLLzsDaCOuyROOjpGAQURfKEls3iJJAfp3SV
         zijv/IC1vpTGiwiUz/dz192juvScm+y1DuHTJ+j9lTTeFkUAiSoJKtDt3sPlohFEse5a
         sI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=i0SIBGq8xU/51yMqaBrsuBeLMp0XJCc4t+4qPZTEPP8=;
        b=D2W/OQiEtkM2jVF9SZqWKqsW5i4d1ijlz5820cW+D0/Eu9HEes1o4RAdpgVWOjWRnO
         kPzb+kmeFRxvF7jWenOy5shXSDi/GGZsu/0qUp6wNHiquuu8rOnLDzZI8VeGI3WgNNrr
         9vluHPLs8Jl+xc3Q643aUiBzeNC5F7tXHH1LC0zMFhCeq7NLN7ZZkqXaFw0Ewy+gNWIr
         CdhQiTIGfBVlvGk/LDB8HinZ21xWGpMUU6Rt/oekONTQNt1jKwD7yED5NDh94M2T4rIZ
         cGYPk7xETGUink+15/XcnIch+1qokPODwVCjCnq63xTfb4PSxQPYCs0tTuOQHwHK71Zr
         Disw==
X-Gm-Message-State: APt69E2qQqVt37rWt9B2MHkQNvoKntQbH4dP8ntUgwTCTc6aUQefE5Dc
        ZOB6AOCGoSFcQ43UugYEgv0=
X-Google-Smtp-Source: ADUXVKKjrFLm0GyuwZ3uyWE+G512k5R+Cp0nfhr9YRjvXRFcYPw6GwDK019wW80vWyzFm/CvAAbzrw==
X-Received: by 2002:a1c:d509:: with SMTP id m9-v6mr5075549wmg.69.1529581061075;
        Thu, 21 Jun 2018 04:37:41 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id j184-v6sm6997379wmb.26.2018.06.21.04.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 04:37:40 -0700 (PDT)
Date:   Thu, 21 Jun 2018 13:37:39 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Alex Hung <alex.hung@canonical.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Takashi Iwai <tiwai@suse.de>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ThinkPad T480s & LED_MUTE, LED_MICMUTE
Message-ID: <20180621113739.24smnyxma2g2yjdt@pali>
References: <20180608111057.4wxpg7m7nm7suf6n@pali>
 <20180615112606.GA3986@amd>
 <20180615113728.h7snxhe2juaqvjyx@pali>
 <20180615123007.nxsymdvr3nj3it5i@khazad-dum.debian.net>
 <20180615190915.cdntdeesc52ei35u@pali>
 <20180615233628.gy2ffgupctheyqof@khazad-dum.debian.net>
 <20180618101144.l5azlrg5jq32fpbf@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180618101144.l5azlrg5jq32fpbf@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 June 2018 12:11:44 Pali Rohár wrote:
> On Friday 15 June 2018 20:36:28 Henrique de Moraes Holschuh wrote:
> > On Fri, 15 Jun 2018, Pali Rohár wrote:
> > > means set. What is SHDA doing, I have not figured out. It does not
> > 
> > Look at the HDA mixer state, SHDA is likely to be directly messing with
> > it.
> 
> Now I found following email thread between you and Alex with patch which
> configures HDA mixer via that SHDA method:
> 
> https://www.spinics.net/lists/platform-driver-x86/msg03206.html
> 
> But looks like that patch was never included into mainline kernel...
> 
> Seems it would be needed in some part (to not break older Thinkpads) for
> that LED support in alsa mixer about which Takashi Iwai wrote.

Hi Alex, do you have other details or documentation for your patch
"thinkpad_acpi: added BIOS mute interfaces for volume" (linked above)
which you sent to platform-driver-x86 list 6 years ago?

It calls SHDA thinkpad ACPI function and I would like to know more what
is this function doing...

-- 
Pali Rohár
pali.rohar@gmail.com
