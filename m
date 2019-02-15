Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69DDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 06:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D7221872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 06:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B04iRfeP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387830AbfBOGc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 01:32:56 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37967 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfBOGcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 01:32:55 -0500
Received: by mail-yb1-f194.google.com with SMTP id x9so3394849ybj.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 22:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R8czxiR1he33hUYRGBsWMwIEe9AFbbDzEgbN/Xc7Jmw=;
        b=B04iRfePccbtSW+Oq0fZuq11ge49KBaCjwckQQdleO4NYokh3+C8w+JikuLz+UBEtP
         BPNTxSK9Knd7g7evzUS2Ez4yl48ev3y8H3R4qqWQ5coI+4lBqNfiH+ZDgLOdJPCEObNm
         aQ12wcSXL3W0/QrDcKPFfz1LBnCjF0FRqOjSjjQfDjWd8GQV9njJ1UU4b42LgTJLpqxY
         0KvHrCLNI14Dy5W9vL7YaH+DDxCwVVhsYGksyfanlYFcrwrV1NaEUnRdynsTeYpmaFuT
         ih+wcdFI8Qa5plO3d9WisqxYHg88pqYgEMXX3AJTz+ygnT0hgbJRUso86IhkNspLZXT9
         IsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R8czxiR1he33hUYRGBsWMwIEe9AFbbDzEgbN/Xc7Jmw=;
        b=bPOdr84qFbaCMu+bolAA9Miqd2zH2TQah/yNEZizNF0HNolkROud3BuPFz59xtPCmM
         VJlqyc9J0UzmYGKyIBYoucIKUc5xKL0vBE2O1T82QdfoH6QPhOhBXplKfTTxI4jlpBOy
         wmGvtuN17HU66hPYpXUv30ax+nbFuVJSLulLHu4a305U9eYp1MmlPl+/9Dbn/ZiRTPi1
         kyq2aQ+7sYi2McRD4uDcC0u5CqV3blZzya1coegU91qnDJl1fDPjtmk0xk2rTMC3I+Vl
         yXVw+bygDn1oCEcrtjZuYeambpLHhJXb5VYMHUPPsp9TARcREb5PCwn2qP1fLd4ziL6z
         W2ZA==
X-Gm-Message-State: AHQUAuYPOvoEVYoSpMT58bl5OB3bO5NwfoJRil4gEERfLspR0uHuTX2K
        TwiP8aNo4UMxEBx5/8NKpS8=
X-Google-Smtp-Source: AHgI3Ib0rW8QYfv43FE4j9tPO1YRGlIic7b4BH3aqc54vcB3P4FrCRWFEuxAh011Hg9HAe41xH7QKw==
X-Received: by 2002:a25:9d8a:: with SMTP id v10mr6837815ybp.103.1550212374158;
        Thu, 14 Feb 2019 22:32:54 -0800 (PST)
Received: from localhost.localdomain ([46.216.144.99])
        by smtp.gmail.com with ESMTPSA id i128sm1553894ywb.82.2019.02.14.22.32.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 22:32:52 -0800 (PST)
Received: from [127.0.0.1] (helo=jeknote.loshitsa1.net)
        by localhost.localdomain with esmtp (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1guX3K-0001sZ-F6; Fri, 15 Feb 2019 09:32:50 +0300
Date:   Fri, 15 Feb 2019 09:32:50 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] extcon intel-cht-wc: Enable external charger
Message-ID: <20190215063250.GB30250@jeknote.loshitsa1.net>
References: <20190210203649.21691-1-jekhor@gmail.com>
 <20190210203649.21691-3-jekhor@gmail.com>
 <1b2f04fc-05a0-4f09-c84e-dc7adc63ec63@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b2f04fc-05a0-4f09-c84e-dc7adc63ec63@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 05:31:48PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 10-02-19 21:36, Yauhen Kharuzhy wrote:
> > In some configuration external charge "#charge enable" signal is
> > connected to PMIC. Enable it at device probing to allow charging.
> > 
> > Tested at Lenovo Yoga Book (YB1-X91L).
> > 
> > Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> > ---
> >   drivers/extcon/extcon-intel-cht-wc.c | 33 ++++++++++++++++++++++++++++
> >   1 file changed, 33 insertions(+)
> > 
> > diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
> > index 4f6ba249bc30..00cb3084955e 100644
> > --- a/drivers/extcon/extcon-intel-cht-wc.c
> > +++ b/drivers/extcon/extcon-intel-cht-wc.c
> > @@ -57,6 +57,11 @@
> >   #define CHT_WC_USBSRC_TYPE_OTHER	8
> >   #define CHT_WC_USBSRC_TYPE_DCP_EXTPHY	9
> > +#define CHT_WC_CHGDISCTRL		0x5e2f
> > +#define CHT_WC_CHGDISCTRL_CCSM_DIS	0x11
> > +#define CHT_WC_CHGDISCTRL_CCSM_EN	0x00
> 
> Hmm, the enable mask here does not match the enable mask from:
> 
> https://github.com/01org/ProductionKernelQuilts/blob/master/uefi/cht-m1stable/patches/EM-Charger-Disable-battery-charging-in-S3-and-enable.patch
> 
> Which has:
> 
> #define CHGDISFN_EN_CCSM_VAL           0x50
> #define CHGDISFN_DIS_CCSM_VAL          0x11
> #define CHGDISFN_CCSM_MASK             0x51
> 
> Where as on my hardware, the PMIC comes up with 0x50
> in the 0x5e2f register, exactly matching the values
> from that patch.
> 
> Why did you change this value ?

Good question... I found this values in Lenovo's sources and use them
'as is':
https://github.com/jekhor/yogabook-linux-android-kernel/blob/b7aa015ab794b516da7b6cb76e5e2d427e3b8b0c/drivers/power/intel_pmic_ccsm.h#L255

I don't remember if charger worked with Intel's value, I need to
re-check this.

(...why does Intel close documentation for this piece of HW?...)

> 
> It would be interesting to get a dump of the
> charger's i2c registers using i2cdump before
> and after writing this new value to register
> 0x5e2f. Note you can simply leave the patch adding
> the write out of the kernel, and then do:
> 
> i2cdump <charger>
> i2cget -y -f 6 0x5e 0x2f
> # check 0x00 is the correct val
> i2cset -y -f 6 0x5e 0x2f 0x00
> i2cdump <charger>
> 
> To see if any reg values of the charger-ic have changed.
> 
> Note bus 6 is the right bus for the PMIC on my systems,
> but it might be different, to find the right bus do:
> 
> ls -l /sys/bus/devices/i2c-INT34D3:00
> 
> And look at what the i2c bus-number is in that symlink.
> 
> 
> Also can you please provide i2cdump output for the
> 0x5e and 0x6e devices of the PMIC, preferably from a
> clean boot, without your patches, so that we can
> see what the value of the 0x5e2f register is before
> your code modifies it.
> 
> i2cdump -y -f 6 0x5e
> i2cdump -y -f 6 0x6e

OK, I will send this dumps soon. I used i2get/i2cset for checking this
values and PMIC behaviour already but don't remember exactly results.


-- 
Yauhen Kharuzhy
