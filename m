Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EAFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EB92075B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0HtnwUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfBTU2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:28:42 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46501 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfBTU2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:28:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id i16so19292435wrs.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 12:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tiU47Yv+LYbPSU5QMhVpZIeuq/gYpz+H5dwVwC0OpJE=;
        b=s0HtnwUBSVFBjhq2FSIaltER2CWMSJK+/Fd27/RSWmwogtJToyInachxOQZGZCaADF
         IPXMimU/2yYX/+s7znqyHHuXZL7Ui8K8ss5QVUOJL+baIbvvehilDT0IZYtz+SGvtut9
         PMO8Z/VoM6917ao7t/WpuOxoPk4elCS0FbDDwKfMZTafIrGWveSY/wRulDBkPj1tXoin
         KTQf9v0HZUwkc87qxmIUqGxxX6OdGLxmExNsngABqTA93+i50SQVKPm7svynkDB5Nh47
         ZNwuN+y7JKhPTi7E2yVj6nULGIr7CYfcORkVLRqWHsVgTKaTLzqGDOPZj8LQCKk/JJwt
         mkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tiU47Yv+LYbPSU5QMhVpZIeuq/gYpz+H5dwVwC0OpJE=;
        b=Msw7Ch0sg3qV9cCRQfK7dQBT69n7JHUaivJDZZzZ9YZsPCzSJ8yojd4Xokma4PRvEP
         Zl+CzKxu1S7UAXr6bYfxMleI1QisIxr276JKjVVda/HFXBujOh+L4UQWmkkz8Q2u9fDh
         zR40UbYaywBIUNnm3JRkb1aZfRwjA5vH23YpirbDp1AvG9h6icM/luCdh0eAUMCi8jSS
         /TQZWDsyrVP0EYfk0m5+qDHkjO8Q1baxM0wTxyG/VQ2kcxD20j3UqWOhmmRWlM14MVhI
         nKQOC8FsYEmQdjmTJkh4pJUQ5oOWfGEMsbqklJfcQqEjbTa+hP2YylStbO3okU2gKJ/m
         R8cQ==
X-Gm-Message-State: AHQUAuZCZkwr1a2dcLE5+Jpyz8TLcZYlkCC8smv3wsUaXdwTaQIubqJS
        85vJMsv+AgkH4YQQYXUxX3I=
X-Google-Smtp-Source: AHgI3IYCiCcO4e1E4ANn2vJcNlWpPKEKvfJjAxkOiQMk//duHlOUxmakTbcbgJ2Kk4nn7s4k9HXlHQ==
X-Received: by 2002:a05:6000:10c1:: with SMTP id b1mr24521433wrx.275.1550694519545;
        Wed, 20 Feb 2019 12:28:39 -0800 (PST)
Received: from localhost.localdomain ([46.216.128.67])
        by smtp.gmail.com with ESMTPSA id i192sm6477109wmg.7.2019.02.20.12.28.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 12:28:38 -0800 (PST)
Received: from [127.0.0.1] (helo=jeknote.loshitsa1.net)
        by localhost.localdomain with esmtp (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1gwYTs-0006IJ-Ok; Wed, 20 Feb 2019 23:28:36 +0300
Date:   Wed, 20 Feb 2019 23:28:36 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] extcon intel-cht-wc: Enable external charger
Message-ID: <20190220202836.GA23567@jeknote.loshitsa1.net>
References: <20190210203649.21691-1-jekhor@gmail.com>
 <20190210203649.21691-3-jekhor@gmail.com>
 <1b2f04fc-05a0-4f09-c84e-dc7adc63ec63@redhat.com>
 <20190215063250.GB30250@jeknote.loshitsa1.net>
 <20190217215242.GA12656@jeknote.loshitsa1.net>
 <416a0e12-aa0e-e781-2ef2-f11b97ba77a0@redhat.com>
 <CAKWEGV7r_026NhT96AiXJUT_9WOTy_=DC3Kx9qVNRfjWmMkEBA@mail.gmail.com>
 <8e3d9949-4bd3-f229-ace4-196a5f08fad3@redhat.com>
 <20190219202005.GA3699@jeknote.loshitsa1.net>
 <6a7be360-8da3-f1e6-6ca7-f55b3b2c60df@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a7be360-8da3-f1e6-6ca7-f55b3b2c60df@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 05:42:28PM +0100, Hans de Goede wrote:
> > > The input-current-limit only specifies how much current the charger may
> > > draw from the micro-usb for both supplying the laptop as well as for
> > > charging the battery combined. You can safely set this as high as
> > > the charger can handle (2A for a dedicated charger).
> > > 
> > > The BQ25892 should have a *separate* setting for the max current to
> > > use while charging the battery (assuming that the input current allows
> > > drawing enough current in the first place). I would hope that those bits
> > > have some sane value set from the firmware...
> > 
> > Yes, the charger has separate battery current limit but firmware doesn't
> > change its default value (2048 mA) while Lenovo's software driver does.
> > It set battery charging limit to 4 A and input limit to 2 A (it makes
> > sense because Lenovo adapter and BQ25892 both support voltage increasing
> > upto 12V).
> 
> Hmm, I guess your device uses a separate power-barrel charging conector
> then? 12v over micro-usb requires special negotiation which the Whiskey Cove
> PMIC does not support AFAIK.

The Yoga Book supports kind of quick charging by negotiate voltage with
'current pulse protocol' supported by BQ25892 and Lenovo's wall cube.
I think that PMIC is not connected to VBUS directly. After charging
started, BQ25892 driver can ask power adapter to increase voltage
number of times upto 12V. See
https://github.com/jekhor/yogabook-linux-kernel/blob/master/drivers/power/supply/bq25890_charger.c#L918
for example.

> 
> In either case if you want to increase the max battery current to 4A
> in the kernel, then this will have to be guarded by a DMI check.

Yes.

> 
> I beieve the way to do this wuld be throuh a device-property on the
> charger which gets set from drivers/i2c/busses/i2c-cht-wc.c, but as
> said this needs to be behind a DMI check, e cannot just g and boost
> the max charge current to 4A everywhere.

Yes, I use such method already in the my kernel:
https://github.com/jekhor/yogabook-linux-kernel/blob/master/drivers/i2c/busses/i2c-cht-wc.c#L247

Anyway, charger tweaking will be next iteration, now I want to complete
current extcon stuff/

> Regards,
> 
> Hans

-- 
Yauhen Kharuzhy
