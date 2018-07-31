Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0490C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53386208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqlcJKrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53386208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbeGaIkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:40:12 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56021 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729774AbeGaIkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:40:12 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so1794513wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 00:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UNQctpEO9zEsfTCw2pV1Hyu9BvLz31x+cCDytQ/Dc4k=;
        b=RqlcJKrmkgel/3KOoljSYnkH0LSsajM89V2Rc8kk/FKqFTPvg0TQvwQKvHzAjYAW63
         Pqa+4mdkDm9SRekUpZZv55jOygEBm2sNE+vB4+jweY8HsqsXVNVEOy+6oKG+I7SWZWTL
         8IuPksFDuF/2RYuhQBWRmWYMbsSeszCx4t06Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UNQctpEO9zEsfTCw2pV1Hyu9BvLz31x+cCDytQ/Dc4k=;
        b=kWmaFPhsVgizb7pzZB0TSZXYfHuYpYqCoK1xYAxL6Nnw+2Oitp6t7EQwnfj7ptMIAQ
         IW+BihST7GhlYuzycAGJDBlP5Nx9kUikjfMm+GLRu9URHJPL8BbIS8isNsiHVueS6PRk
         6cjI7w6CpA/XBaie5dUuHfx0pGqePk2oOwmQgRLLhitv+FMNls002/HpdD2LDvGpJsKD
         a6UzIHiQSt4d+49efhGDSdeA4rB7ZDOAIK4rUqtA3RSV6Gp8+rMnhEJ/VeDVVnWcgPn/
         NqP8wGU3z3AaleR0LIH0485ruvrs1bwnwQwnMYpR6s56xdmYb1A9QHdLsHeXjn7lrOl/
         oowA==
X-Gm-Message-State: AOUpUlG/2v2uiQDWhX7bYspeRSt73fjezueVwO2rOOWfB9hF2c6WpMG/
        /yA9RhAVfV6eD5YHRGpPnyjJdA==
X-Google-Smtp-Source: AAOMgpc7xJWMXNsD+pF7fOiWBjaPuY/WmMLKvh72/GFKROWyCN+KAXWRZ8EdbHSeAp/TU4wj3TpSsQ==
X-Received: by 2002:a1c:32c4:: with SMTP id y187-v6mr1319248wmy.31.1533020480964;
        Tue, 31 Jul 2018 00:01:20 -0700 (PDT)
Received: from dell ([95.149.160.4])
        by smtp.gmail.com with ESMTPSA id r140-v6sm3393588wmd.7.2018.07.31.00.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 00:01:20 -0700 (PDT)
Date:   Tue, 31 Jul 2018 08:01:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        darrick.wong@oracle.com, sandeen@redhat.com,
        Arnd Bergmann <arnd@arndb.de>, Wu Hao <hao.wu@intel.com>,
        kusumi.tomohiro@gmail.com, bryantly@linux.vnet.ibm.com,
        fbarrat@linux.vnet.ibm.com, David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Vinod <vkoul@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>,
        david.kershner@unisys.com,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Johan Hovold <johan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, jgross@suse.com,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        James Feist <james.feist@linux.intel.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Subject: Re: [PATCH v7 08/12] mfd: intel-peci-client: Add PECI client MFD
 driver
Message-ID: <20180731070117.GE4662@dell>
References: <20180723214751.1733-1-jae.hyun.yoo@linux.intel.com>
 <20180723214751.1733-9-jae.hyun.yoo@linux.intel.com>
 <20180727082611.GE4628@dell>
 <acffdfef-cb20-4208-5297-d94bac5ecb1b@linux.intel.com>
 <CAL_JsqL7WkDOaegwmBDqLkRh0JfCo7O2krONVstjWMUsLiJMrg@mail.gmail.com>
 <7ab43253-1154-6e2f-b216-69b0d44b470a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ab43253-1154-6e2f-b216-69b0d44b470a@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018, Jae Hyun Yoo wrote:

> Hi Rob,
> 
> On 7/30/2018 3:10 PM, Rob Herring wrote:
> > On Fri, Jul 27, 2018 at 11:36 AM Jae Hyun Yoo
> > <jae.hyun.yoo@linux.intel.com> wrote:
> > > 
> > > Hi Lee,
> > > 
> > > On 7/27/2018 1:26 AM, Lee Jones wrote:
> > > > On Mon, 23 Jul 2018, Jae Hyun Yoo wrote:
> > > > 
> > > > > This commit adds PECI client MFD driver.
> > > > > 
> > > > > Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> > > > > Cc: Lee Jones <lee.jones@linaro.org>
> > > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > > Cc: Andrew Jeffery <andrew@aj.id.au>
> > > > > Cc: James Feist <james.feist@linux.intel.com>
> > > > > Cc: Jason M Biils <jason.m.bills@linux.intel.com>
> > > > > Cc: Joel Stanley <joel@jms.id.au>
> > > > > Cc: Vernon Mauery <vernon.mauery@linux.intel.com>
> > > > > ---
> > > > >    drivers/mfd/Kconfig                   |  14 ++
> > > > >    drivers/mfd/Makefile                  |   1 +
> > > > >    drivers/mfd/intel-peci-client.c       | 182 ++++++++++++++++++++++++++
> > > > >    include/linux/mfd/intel-peci-client.h |  81 ++++++++++++
> > > > >    4 files changed, 278 insertions(+)
> > > > >    create mode 100644 drivers/mfd/intel-peci-client.c
> > > > >    create mode 100644 include/linux/mfd/intel-peci-client.h
> > > > > 
> > > > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > > > index f3fa516011ec..e38b591479d4 100644
> > > > > --- a/drivers/mfd/Kconfig
> > > > > +++ b/drivers/mfd/Kconfig
> > > > > @@ -595,6 +595,20 @@ config MFD_INTEL_MSIC
> > > > >         Passage) chip. This chip embeds audio, battery, GPIO, etc.
> > > > >         devices used in Intel Medfield platforms.
> > > > > 
> > > > > +config MFD_INTEL_PECI_CLIENT
> > > > > +    bool "Intel PECI client"
> > > > > +    depends on (PECI || COMPILE_TEST)
> > > > > +    select MFD_CORE
> > > > > +    help
> > > > > +      If you say yes to this option, support will be included for the
> > > > > +      multi-funtional Intel PECI (Platform Environment Control Interface)
> > > > > +      client. PECI is a one-wire bus interface that provides a communication
> > > > > +      channel from PECI clients in Intel processors and chipset components
> > > > > +      to external monitoring or control devices.
> > > > > +
> > > > > +      Additional drivers must be enabled in order to use the functionality
> > > > > +      of the device.
> > > > > +
> > > > >    config MFD_IPAQ_MICRO
> > > > >       bool "Atmel Micro ASIC (iPAQ h3100/h3600/h3700) Support"
> > > > >       depends on SA1100_H3100 || SA1100_H3600
> > > > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > > > > index 2852a6042ecf..29e2cacc58bd 100644
> > > > > --- a/drivers/mfd/Makefile
> > > > > +++ b/drivers/mfd/Makefile
> > > > > @@ -203,6 +203,7 @@ obj-$(CONFIG_MFD_INTEL_LPSS)     += intel-lpss.o
> > > > >    obj-$(CONFIG_MFD_INTEL_LPSS_PCI)   += intel-lpss-pci.o
> > > > >    obj-$(CONFIG_MFD_INTEL_LPSS_ACPI)  += intel-lpss-acpi.o
> > > > >    obj-$(CONFIG_MFD_INTEL_MSIC)       += intel_msic.o
> > > > > +obj-$(CONFIG_MFD_INTEL_PECI_CLIENT) += intel-peci-client.o
> > > > >    obj-$(CONFIG_MFD_PALMAS)   += palmas.o
> > > > >    obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
> > > > >    obj-$(CONFIG_MFD_RC5T583)  += rc5t583.o rc5t583-irq.o
> > > > > diff --git a/drivers/mfd/intel-peci-client.c b/drivers/mfd/intel-peci-client.c
> > > > > new file mode 100644
> > > > > index 000000000000..d7702cf1ea50
> > > > > --- /dev/null
> > > > > +++ b/drivers/mfd/intel-peci-client.c
> > > > > @@ -0,0 +1,182 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +// Copyright (c) 2018 Intel Corporation
> > > > > +
> > > > > +#include <linux/bitfield.h>
> > > > > +#include <linux/mfd/core.h>
> > > > > +#include <linux/mfd/intel-peci-client.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/peci.h>
> > > > > +#include <linux/of_device.h>
> > > > > +
> > > > > +enum cpu_gens {
> > > > > +    CPU_GEN_HSX = 0, /* Haswell Xeon */
> > > > > +    CPU_GEN_BRX,     /* Broadwell Xeon */
> > > > > +    CPU_GEN_SKX,     /* Skylake Xeon */
> > > > > +};
> > > > > +
> > > > > +static struct mfd_cell peci_functions[] = {
> > > > > +    {
> > > > > +            .name = "peci-cputemp",
> > > > > +            .of_compatible = "intel,peci-cputemp",
> > > > > +    },
> > > > > +    {
> > > > > +            .name = "peci-dimmtemp",
> > > > > +            .of_compatible = "intel,peci-dimmtemp",
> > > > > +    },
> > > > > +};
> > > > 
> > > > The more I look at this driver, the less I think it fits into MFD.
> > > > 
> > > > What's stopping you from registering these devices directly from DT?
> > > > 
> > > 
> > > Because DT doesn't allow 2 nodes at the same address so Rob suggested
> > > MFD for this case.
> > 
> > Only after I first suggested you create cpu and dimm sensors from a
> > single hwmon driver. Perhaps you should figure out how to fix the
> > problem with delayed registration. Perhaps you can register the
> > sensor, but just delay returning actual data until it is ready.
> > 
> 
> The actual reason why I divided the single hwmon driver into two is for
> using recommended hwmon API set which doesn't allow incremental
> creation of sysfs attributes at run time - using of
> 'devm_hwmon_device_register_with_info' is suggested by Guenter instead
> of using other deprecated APIs.
> 
> The reason why the delayed registration is needed is, BMC kernel cannot
> know how many DIMM are installed in remote machine before the machine
> completing memory training and testing in POST. So dimm temp driver
> cannot create hwmon attributes in advance.
> 
> My thought is, this way is the best to address these requirements.

As I've previously explained, I do not think this is a good fit for
MFD.  Since this whole PECI piece is a bit, let's say 'niche', perhaps
it's better to contain the client within the PECI subsystem too.  You
can then use the platform_device_add() API to register devices as and
when required.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
