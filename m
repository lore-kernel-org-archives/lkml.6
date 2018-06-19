Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDBEC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660C9205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7l56xo/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660C9205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757275AbeFSOr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:47:56 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41907 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756467AbeFSOry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:47:54 -0400
Received: by mail-oi0-f65.google.com with SMTP id a141-v6so18379173oii.8;
        Tue, 19 Jun 2018 07:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=I2sM0YaYmMFHnc35YNdq3AtrXExTndEZydHq79pLR2E=;
        b=J7l56xo/iyinZgbzOeyzHlLAwtnk7IKhvrtmLzIw2MrneJZZau73ZFWkHWSMwl2YiY
         B/5i0Samy4oMBCcEekgOVaXfLtxz2EmOHWrG6AAUsZqDElWh7Erm/uraqindbVnVQDfN
         7QMxD6MBdaTe/v2BwIp648XLNrvtOzQvy02ux0FGgMBNMVnWjZUu0tppcdxVbHTdOFz6
         CLCVg6pKPJshT8Ww/WH1mVMBycXV0oBD+ovyry01Q3Crxekvhq//b+eQKp3ikRqu84dH
         JhcVsJn0cGeT7r/Uq8PDWq7cYimfr5kG2fctKvpYcDdr0RmFA3p2zEqJPNeWYJWHpbWi
         /S0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=I2sM0YaYmMFHnc35YNdq3AtrXExTndEZydHq79pLR2E=;
        b=bPaI1q4HQLfiPdtZ7pgvvRxkeY6PhpuaF0TUZ1DahYhA6BKYOuNx/UzPmCbN6lIO5H
         /Sd103eC/UxPxU0++jchwFVUqlbiYw/nIRsSwiiBNQlvra9Kk9aPK/Pbm/w5H9NsrbRO
         g6c9oa9g6bSd8+8MzEi2h0KbBkBv2w8HECfx6EqmJsFAVHfMQorIA6U1go4jlRsIyBMt
         3E0d11PUhpgbL4XDzuh66Zd2qgpFHhRNGH/G13GT/tjZJscB2iDsnUebEDL9M0EaKZEY
         lOZCUFp+oCYefa7kQgi+zKM6KWLJdqF7ZkD5FqqFK8OyE0yUmi2ZsqXYnxxg8zU/mK87
         Bpyw==
X-Gm-Message-State: APt69E1W8o8bGtqfw1m7jIjtCgpfMdeXEbycXb3yFW1AKALovf1cX07b
        kCLq/cTrAHQlztSwa7CH/tIuW8PdizifZRZx4rM=
X-Google-Smtp-Source: ADUXVKKxzAsoBiR90tKulvZIaTN9CBpEICHSJbVVpJ/qKyMPNMYmsN5c/RjooLJnarYHFDnx1cZyRVTHy0gAr8SoRnY=
X-Received: by 2002:aca:e143:: with SMTP id y64-v6mr9142638oig.282.1529419673425;
 Tue, 19 Jun 2018 07:47:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 07:47:52
 -0700 (PDT)
In-Reply-To: <20180619135518.8990-2-geert+renesas@glider.be>
References: <20180619135518.8990-1-geert+renesas@glider.be> <20180619135518.8990-2-geert+renesas@glider.be>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Jun 2018 16:47:52 +0200
X-Google-Sender-Auth: 2N7BgKp5NJpylGzVoaZWs-RUVyE
Message-ID: <CAJZ5v0gGuTDCf8Bsefyj5R6mF=SXZDrt7JacNU5vBZOf84QsvA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PM / wakeup: Add callback for wake-up change notification
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 3:55 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Add a callback to inform a device that its wake-up setting has been
> changed.  This allows a device to synchronize device configuration with
> an external user action.
>
> E.g. on systems using a Rohm BD9571MWV PMIC and a toggle accessory power
> switch, the system suspend/resume procedure is:
>   1. Configure PMIC for DDR backup mode (by software), which changes the
>      role of the accessory power switch from a power to a wake-up
>      switch,
>   2. Switch accessory power switch off (manually), to prepare for system
>      suspend,
>   3. Suspend system (by software),
>   4. Switch accessory power switch on (manually), to wake up the system.
>
> As step 2 involves a manual operation, step 1 cannot be combined
> with step 3 and performed in the PMIC's suspend callback (unlike on
> systems with a momentary power switch).
>
> Adding the new callback allows to move step 1 to the new callback, to be
> performed in response to the user writing "enabled" to the PMIC's
> "wakeup" virtual file in sysfs.

I still don't quite understand this TBH.

In particular, why do you want a write to "wakeup" trigger this
instead of having a special sysfs attr for that exposed by your PMIC
driver?

Writing "enabled" to "wakeup" for the PMIC should enable the PMIC
itself to wake up the system, which isn't quite the case, or is it?

Thanks,
Rafael
