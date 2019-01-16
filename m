Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BDDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E4720578
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NswJKaXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405603AbfAPRPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:15:02 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35647 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfAPRPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:15:02 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so3108477pgs.2;
        Wed, 16 Jan 2019 09:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lq/DUbYJ2G6nWARSimae4t5AcHSSmR9jaE2ZCZNOeyo=;
        b=NswJKaXP96srKj6mL04AQNXVJ0GO4Q7ogamuulOO8UkxvWGxCd29gSvY/b5BySi+qO
         txGECtT3zsFVrIces0pGsi80tttg3STSvp8hgi49YlTTtzvrU/rtMdWuGIGy6NNkYDds
         erzfe1DULAcRe/JXasWPiUk2F9F9WY63ttdQrd6vwBCaSdm0VO5Ib1eFcA0NifhxSgF+
         cVfSnszZajSjGZIJemzGhAzWv+RamFdvOhIpsnxZT+1TZPF1OW1n3NIMWxmd4bWH9Ms1
         RFrasXM9iGO02h30Rjsf95cq+s9vCZkCzNlwGbdwS+nLuFUW9tM9x1HRnD3/JscMqQrN
         W0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lq/DUbYJ2G6nWARSimae4t5AcHSSmR9jaE2ZCZNOeyo=;
        b=ZHCp7VGrCfAfI4zQTBlcVK/2OC33ky/u6kXvom3En5P1yTG8f3aHPKSY4vBUUvAkVV
         FquSszELGLIvn0X+/Nn+BNUgq0xD4jKd6hlIaEbq8F/Oq8l7pATegaAB8b9O84ZUdi8X
         LAl8tSuhXNfNoFVhWsvIMaIxlCVbTfOxLMDJLLucazBHF5g0UWgrIpc/0w5L4C2Mu5Hc
         fdgOUCv4uuZCTpdg5l6KV6WgKbIYNu/mHOYOqaxBDRQrQm8yNFrPfmvcnl1lR0DgC8Q+
         j795tB1d0C9gZ7Nit5wp9GpbySZtMDlXmaK6MfPkMNXOt/SQ9DppPkTgnoIRNH20iW1E
         MMXQ==
X-Gm-Message-State: AJcUukfz/xGEWUiaKRJhSfrHhTX6vsxv6o8UAgL8pfEpuhoWChxSZ1kd
        RGUEquG+30fEza8H1SHI05o=
X-Google-Smtp-Source: ALg8bN6uO7Cbz0ysCikhTWkQs8GPT2JgjTLVdGVZK6SdyIwbuPaPlQb+yEOsEH8Gxxh7vLLQB9gwPA==
X-Received: by 2002:a63:c904:: with SMTP id o4mr9705041pgg.331.1547658900519;
        Wed, 16 Jan 2019 09:15:00 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id 4sm11137509pfq.10.2019.01.16.09.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 09:14:59 -0800 (PST)
Date:   Wed, 16 Jan 2019 22:44:50 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org,
        Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>,
        linux-fbdev@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Felix Siegel <felix.siegel@stud.uni-hannover.de>,
        Matthias Wolf <der_wolf_@web.de>, linux-kernel@vger.kernel.org,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Radek =?utf-8?Q?Dost=C3=A1l?= <radek.dostal@streamunlimited.com>,
        Renato Soma <renatoys08@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Tim Cofala <cofala@stud.uni-hannover.de>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] Staging: fbtft: Switch to the gpio descriptor
 interface
Message-ID: <20190116171447.GA27175@nishad>
References: <20190115044704.GA20989@nishad>
 <20190115150231.GA3418@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115150231.GA3418@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 04:02:31PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 15, 2019 at 10:17:09AM +0530, Nishad Kamdar wrote:
> > This switches the fbtft driver to use GPIO descriptors
> > rather than numerical gpios:
> > 
> > Utilize the GPIO library's intrinsic handling of OF GPIOs
> > and polarity. If the line is flagged active low, gpiolib
> > will deal with this.
> > 
> > Remove gpios from platform device structure. Neither assign
> > statically numbers to gpios in platform device nor allow
> > gpios to be parsed as module parameters.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > Changes in v2:
> >  - Merge all patches in a single patch. This is because the
> >    first patch changes par->gpio from an int to a pointer
> >    so all the checks have to be updated in the same patch.
> >    Otherwie it breaks 'git bisect'.
> 
> The "v2" information goes below the --- line please.
> 
> Also, I got 2 copies of this, both different, so I have no idea which to
> apply.  Please fix up and resend a v3.
> 
Sorry for the confusion. I'll fix and resend.

> thanks,
> 
> greg k-h

Thanks for the review.

Regards,
Nishad
