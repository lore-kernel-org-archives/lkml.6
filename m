Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88572C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BBB2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M2LBYenJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BBB2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeIZDE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:04:59 -0400
Received: from mail-yb1-f170.google.com ([209.85.219.170]:41352 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbeIZDE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:04:59 -0400
Received: by mail-yb1-f170.google.com with SMTP id d14-v6so5310030ybs.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=qFseKUhM3eKp/JWVBO0kXlgIFuOwb6MbzSydBW25Q2I=;
        b=M2LBYenJk7O3fFq/LFKPerUTTzA00B8M3ruDDCsU7s0L0kpT8SwfP6C0ShxIOijK4L
         zp4r732wRWSkp6Dv2+/89yE9PzOCOBYs8ZRDwShG1q/I7Cm242LIFW/1x+964R5dCxJ8
         WOActt3N0afbDZxOJTu97rdqdHMAu4Q4TB40pkCjA4PHKcspt5I/6EkTzpbGAVkKa8x9
         g33XAgMEc3ThX78nPDibMRZVWu/JAypz1vqtng6Pg41mAVeVnXtmXUUHGaexq76LuTtZ
         yPS/5vRkpiraULWsJttS3kiCf+JVqnslbuQ/dxyerEF75hnIeyKAg1JBGHmkquXEa2I1
         SRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qFseKUhM3eKp/JWVBO0kXlgIFuOwb6MbzSydBW25Q2I=;
        b=fbQ4GFL6scz8oyLiOmRKa4bgQ/YyKLZqE7epUMzQwwVaEqLHVTg3EKWjFtZZmM8pN+
         SuiIvdAmMrJDZWTeqJv4FNP2BiRAUD8iLwikgt55qAL1ySq0Z5sBHvl3J23+x4ACkEDf
         ujEbpzJdiIiBcHSeUHjFQIrqP798pt5cUT2ImWbTpAEvzt5e7m5ltIVFL6xq8flaNbHz
         9MRw+f5DmfgiXJoiy1H7DwqB1nLrVOxKwd7JR/euWRB5cajaT6uJsKECMwYaeNqgZhqW
         nQAgHOlveiZYFRiimlHeDWpPcRzZPrD315i4xZb3jwCTAGCSTYsthuQDUOHNtFDQW5gp
         AYwQ==
X-Gm-Message-State: ABuFfohLEE1YlRTYMIKbXx34CodGqDElWhl/bPiYsEdXa9DyK2S+HDKD
        wjndA8EW8JSGccWOidJl91Wx6xZ8ersNBl9H9FLvuSxvYc0=
X-Google-Smtp-Source: ACcGV61pZjFgL3laNZcebMdA5wBz/FbXdIIldZQnGgppnodH8ZqdKxFSNNytf8DqpwMKHAAmq4t6DtHswGLRPL02TEs=
X-Received: by 2002:a25:fc05:: with SMTP id v5-v6mr1631879ybd.58.1537908933778;
 Tue, 25 Sep 2018 13:55:33 -0700 (PDT)
MIME-Version: 1.0
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 25 Sep 2018 13:54:57 -0700
Message-ID: <CACK8Z6Ebo0giDifRHBg13pe_mO18vb1n0+LGMoMjkLai6X9MNg@mail.gmail.com>
Subject: sdhci driver card-detect is broken because gpiolib can't fallback to _CRS?
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dtor@google.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With commit f10e4bf6632b5b ("gpio: acpi: Even more tighten up ACPI
GPIO lookups"), the gpio lookups were tightened up such that _CRS
method will *only* be tried for lookup, if the ACPI node for the
device does not contain any _DSD properties, AND con_id=NULL:

bool acpi_can_fallback_to_crs(struct acpi_device *adev, const char *con_id)
{
        /* Never allow fallback if the device has properties */
        if (adev->data.properties || adev->driver_gpios)
                return false;

        return con_id == NULL;
}

From the commit log of the said commit, the following types of cases
were identified:

    Case 1: (I think this represents the modern BIOS, because this is
what we want everyone to use i.e. we want to be able to lookup using
_DSD preferably:)

        Device (DEVX)
        {
            ...
            Name (_CRS, ResourceTemplate ()
            {
                GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
                        "\\_SB.GPO0", 0, ResourceConsumer) {15}
            })
            Name (_DSD, Package ()
            {
                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                Package ()
                {
                    Package () {"some-gpios", Package() {^DEVX, 0, 0, 0 }},
                }
            })
        }

    Case 2: (I think this represents the Legacy BIOS, because this is
what has been in use historically, i.e. need to lookup via the _CRS):

        Device (DEVX)
        {
            ...
            Name (_CRS, ResourceTemplate ()
            {
                GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
                        "\\_SB.GPO0", 0, ResourceConsumer) {27}
            })
        }

Ideally a driver should be able to support both legacy and modern BIOS
(i.e. both the above cases). But it seems to me that as per the
current code, the driver has to be aware of what kind of BIOS it is,
because it needs to deal with them differently:

* Use con_id=NULL if it is dealing with a legacy BIOS (i.e. no _DSD
properties in the ACPI).
* Use con_id=<actual string> if it is dealing with a modern BIOS (i.e.
which provides _DSD for the <string> property)

Questions:

1) Is the above a correct understanding of what the gpiolib expects?
So it seems to be that _CRS is not really a "fallback option" anymore
at the gpiolib end anymore (i.e. if a driver wants to support both the
cases (legacy and modern), then it would need to do the fallback
explicitly?)

2) If so, it seems that the the sdhci driver is broken for modern BIOS
as it uses con_id = NULL when calling mmc_gpiod_request_cd(). We can
possibly fix this by either relaxing.the rules to allow _CRS fallback
in gpiolib, or change the sdhci driver to try first using "cd" and
then NULL as the con_id. What do you think?

This is what I see on my system (running 4.19-rc3'ish):

sdhci-pci 0000:00:14.5: SDHCI controller found [8086:34f8] (rev 0)
sdhci-pci 0000:00:14.5: GPIO lookup for consumer (null)
sdhci-pci 0000:00:14.5: using ACPI for GPIO lookup
acpi device:03: GPIO: looking up gpios
acpi device:03: GPIO: looking up gpio
sdhci-pci 0000:00:14.5: using lookup tables for GPIO lookup
sdhci-pci 0000:00:14.5: No GPIO consumer (null) found
sdhci-pci 0000:00:14.5: failed to setup card detect gpio

This is how my ACPI looks for the device:

    Scope (\_SB.PCI0.SDXC)
    {
        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            GpioInt (Edge, ActiveBoth, SharedAndWake, PullNone, 0x2710,
                "\\_SB.PCI0.GPIO", 0x00, ResourceConsumer, ,
                )
                {   // Pin list
                    0x0005
                }
        })
        Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
        {
            ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device
Properties for _DSD */,
            Package (0x01)
            {
                Package (0x02)
                {
                    "cd-gpio",
                    Package (0x04)
                    {
                        \_SB.PCI0.SDXC,
                        Zero,
                        Zero,
                        One
                    }
                }
            }
        })
    }

Thanks,

Rajat
