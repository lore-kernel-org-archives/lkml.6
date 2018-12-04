Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA1DC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810902081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y72teU7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810902081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbeLDP3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:29:52 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34172 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeLDP3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:29:51 -0500
Received: by mail-yw1-f66.google.com with SMTP id g75so7127231ywb.1;
        Tue, 04 Dec 2018 07:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=d+9Jat98lHJAzylhYxkRz8Ja8D102mwMIn9o5dUCPh0=;
        b=Y72teU7F9vmDNLanoNgISIu9kITxV4bimO6bYmh5v9Y3Zq6ouwosg7y/LJqMxmIdez
         bfmIAWzpScYW6Qx5am6Q5025YDGNVPIoVadFkOgFaT2pf4rOCTMDkQA6B2GBvJMnXubQ
         0dM3DNtpRDLlet2sD0iJaCPZ0Au33GDQ74VpU5TF/t3+IFuk+Jy3t6zE/NJnLZHcViFI
         mwdxZr7ntxyErnNj3XbipPAgFNQjgw7X56MkXxs0LtjhzICVJCGjEMXlo/5In9+eHuxT
         VI5RlBvkLIP1ItfMoYlGYr2PxpY3QHhnFF5rAAy5q7R/1nE+v247YT4NdR/uancT+qy9
         Ya1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=d+9Jat98lHJAzylhYxkRz8Ja8D102mwMIn9o5dUCPh0=;
        b=lPBHGPAKYKyTCCRk5D7q7hsuTjvNUCv5gjJxb2m0VUIVGPJATlVslEIAzc0KsZS/iN
         GUdGdbkna880yWwbObq1Ls6LdNCLlqF2HiVu636rRCx9j7awp/X6KO9x6Ao3tGhLUWgQ
         uSiPn2dXSLNAZ1OYcGd3HoyWwPycRanShVYWBU8vk0YPUBPl34ge5s0/CfLawd04gbp3
         /wo27OU2T62WvtvU7hWTq6VKWnKrH3HYf/H7iUXQIJGYNWAX45IaMvg0bfZVaQeCKC8Y
         jF2tVrG5ZOl0hKQPRKKG4Il5MDZRxfqG1QdkwQRCE+7lfxDCqLWTxJ/tcMNPQyzhAUQt
         ziVQ==
X-Gm-Message-State: AA+aEWZ+pFrs1CNMO0V3eoUOFzknXT4Z3IxC0DegY4k8sWiGufBfhjkn
        smoUW7lHdSJXHjn5QpF2uA==
X-Google-Smtp-Source: AFSGD/XuB6jZecDtBiazCjMIy6xjteFAzdWn5XpnuYvIsoc2kaCstCBPwMhIBc0aCFjg9scLtq6K3w==
X-Received: by 2002:a81:e30b:: with SMTP id q11mr20762097ywl.490.1543937389206;
        Tue, 04 Dec 2018 07:29:49 -0800 (PST)
Received: from 960 ([130.254.104.55])
        by smtp.gmail.com with ESMTPSA id p71sm1376686ywg.98.2018.12.04.07.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 07:29:48 -0800 (PST)
Message-ID: <5d47df50508c040a029bee55161571522b69f307.camel@gmail.com>
Subject: Re: [PATCH v9 2/3] x86: add support for Huawei WMI hotkeys.
From:   ayman.bagabas@gmail.com
To:     Randy Dunlap <rdunlap@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        alsa-devel@alsa-project.org
Date:   Tue, 04 Dec 2018 10:29:47 -0500
In-Reply-To: <9d6d8211-6fdf-bfe4-82b5-272d67fbae23@infradead.org>
References: <20181203185344.3521-1-ayman.bagabas@gmail.com>
         <20181203185344.3521-3-ayman.bagabas@gmail.com>
         <9d6d8211-6fdf-bfe4-82b5-272d67fbae23@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-03 at 11:41 -0800, Randy Dunlap wrote:
> On 12/3/18 10:53 AM, Ayman Bagabas wrote:
> > This driver adds support for missing hotkeys on some Huawei
> > laptops.
> > Laptops such as the Matebook X have non functioning hotkeys.
> > Whereas
> > newer laptops such as the Matebook X Pro come with working hotkeys
> > out
> > of the box.
> > 
> > Old laptops, such as the Matebook X, report hotkey events through
> > ACPI
> > device "\WMI0". However, new laptops, such as the Matebook X Pro,
> > does not have this WMI device.
> > 
> > All the hotkeys on the Matebook X Pro work fine
> > without this patch except (micmute, wlan, and huawei key). These
> > keys
> > and the brightness keys report events to "\AMW0" ACPI device. One
> > problem is that brightness keys on the Matebook X Pro work without
> > this
> > patch. This results in reporting two brightness key press
> > events one is captured by ACPI and another by this driver.
> > 
> > A solution would be to check if such event came from the "\AMW0"
> > WMI driver
> > then skip reporting event. Another solution would be to leave this
> > to
> > user-space to handle. Which can be achieved by using "hwdb" tables
> > and
> > remap those keys to "unknown". This solution seems more natural to
> > me
> > because it leaves the decision to user-space.
> > 
> > Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
> > ---
> >  drivers/platform/x86/Kconfig      |  16 +++
> >  drivers/platform/x86/Makefile     |   1 +
> >  drivers/platform/x86/huawei-wmi.c | 226
> > ++++++++++++++++++++++++++++++
> >  3 files changed, 243 insertions(+)
> >  create mode 100644 drivers/platform/x86/huawei-wmi.c
> > 
> > diff --git a/drivers/platform/x86/Kconfig
> > b/drivers/platform/x86/Kconfig
> > index 87f70e8f4dd0..27db3ce7a1e1 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -1292,6 +1292,22 @@ config INTEL_ATOMISP2_PM
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called intel_atomisp2_pm.
> >  
> > +config HUAWEI_WMI
> > +	tristate "Huawei WMI hotkeys driver"
> > +	depends on ACPI_WMI
> > +	depends on INPUT
> > +	select INPUT_SPARSEKMAP
> > +	select LEDS_CLASS
> 
> but LEDS_CLASS is only available if NEW_LEDS is set/enabled, so it
> either
> depends on LEDS_CLASS... or it needs to select NEW_LEDS, which is
> what other
> drivers in this Kconfig file do, even though our b.d. has said a few
> times
> that any one driver should not "select" => enable an entire
> subsystem,
> so they all should be "depends on NEW_LEDS" IMHO.

Noted, I'll select NEW_LEDS just like other drivers in Kconfig.

> 
> > +	select LEDS_TRIGGERS
> > +	select LEDS_TRIGGER_AUDIO
> > +	help
> > +	  This driver provides support for Huawei WMI hotkeys.
> > +	  It enables the missing keys and adds support to the micmute
> > +	  LED found on some of these laptops.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called huawei-wmi.
> > +
> >  endif # X86_PLATFORM_DEVICES
> >  
> >  config PMC_ATOM
> 
> 

