Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDD9C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8805A20684
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbfAVNwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:52:13 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43329 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfAVNwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:52:12 -0500
Received: by mail-vs1-f66.google.com with SMTP id x1so14706219vsc.10;
        Tue, 22 Jan 2019 05:52:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KcDFAfFc7EsqJTg783tpvFYSuv3o+l1WYw+Ppm1hEvI=;
        b=OCy+p1gpDFqK8awmpjIaGPEeLa7JcTht8XdIWaZj9L+j4pkacPIQI89Mt1K5YHkdsV
         pWJP8DF119m01MVQdrSjw9IrZahol+IWOQ2/jxRBwz7NLX9BmDHd5sbcusIhaCh8zyWD
         5iPS6NI0E52tI7kEjU3o8a8vVvy14C6jqBGqq9sXv36xai4sxrjmppfkoDF+X4KC38va
         Q2Sr++mSzEZb9MHOxT6GRmwSNBGDi4t/2qb+u10RX5NpMAT+01GqE2dtMkdoLeQ1lbOQ
         ohbhaS1gIMlYwQn1EF4IedBpIr1WNJTb95fiqlhSjfi3cVdLSNZJ1xkQ7aXqmR7K2MnY
         P5xQ==
X-Gm-Message-State: AJcUukcopoW2v4q+opE6VQQ/XEMJUlnv+L78Jn6lVlTBuCv4lYhDnrqY
        RRnWomjaEonkrsaL3K65vmS5pbyFUxF/LSuufMI=
X-Google-Smtp-Source: ALg8bN6c22dYFsVRGpMa59s/KE5nkBHTAEWeY7ZXm0O6YfV0fhNcm/uNPbKipDrSQyf15xnpm7+wc8n56TswjgTcVvQ=
X-Received: by 2002:a67:c202:: with SMTP id i2mr13578963vsj.11.1548165130536;
 Tue, 22 Jan 2019 05:52:10 -0800 (PST)
MIME-Version: 1.0
References: <CAJKOXPdHhUGoQmrX8_23MfbibozipkAzXA_5woVSFJSK9BvbXw@mail.gmail.com>
 <CAJKOXPe7ot9TLajErKJjSAkbs2vObMJfATzEFwxpT16aFdXHqg@mail.gmail.com> <67560e58-93b3-2bfa-9d5d-5956dae47806@gmail.com>
In-Reply-To: <67560e58-93b3-2bfa-9d5d-5956dae47806@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Jan 2019 14:51:58 +0100
Message-ID: <CAMuHMdUz6J2cG-NCYPTRyS=1QZHGBWUFZPqj4ShEdioQLqu9qw@mail.gmail.com>
Subject: Re: [BUG bisect] Missing Micrel driver on VF50 (net: phy: check
 return code when requesting PHY driver module)
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stefan Agner <stefan@agner.ch>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiner,

On Fri, Jan 18, 2019 at 9:58 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> On 18.01.2019 09:48, Krzysztof Kozlowski wrote:
> > On Fri, 18 Jan 2019 at 09:39, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >> On today's next (next-20190118) my Colibri VF50 board fails to boot up
> >> from network (DHCP, NFSv4 root). Looks like missing network adapter.
> >> Expected:
> >> [ 3.041773] Micrel KSZ8041 400d1000.ethernet-1:00: attached PHY driver
> >> [Micrel KSZ8041] (mii_bus:phy_addr=400d1000.ethernet-1:00, irq=POLL)
> >>
> >> Result:
> >> [ 15.614964] Root-NFS: no NFS server address
> >> [ 15.619353] VFS: Unable to mount root fs via NFS, trying floppy.
> >> [ 15.626762] VFS: Cannot open root device "nfs" or unknown-block(2,0): error -6
> >> [ 15.634252] Please append a correct "root=" boot option; here are the
> >> available partitions:
> >> [ 15.642791] 0100 16384 ram0
> >> [ 15.642804] (driver?)
> >> [ 15.649076] Kernel panic - not syncing: VFS: Unable to mount root fs
> >> on unknown-block(2,0)
> >> [ 15.657423] ---[ end Kernel panic - not syncing: VFS: Unable to mount
> >> root fs on unknown-block(2,0) ]---
> >>
> >> Bisect pointed to:
> >>     net: phy: check return code when requesting PHY driver module
> >
> > I see now in the logs:
> > [ 2.436822] mdio_bus 400d1000.ethernet-1:00: error -2 loading PHY
> > driver module for ID 0x00221513
> > which is kind of misleading. There is no initramfs so there is no
> > usermod library at this point. It is not needed. This seems to break
> > all DHCP/NFS root boots without initrd/initramfs.
> >
> Thanks for the report. Could you please provide your kernel config
> and the syslog of a boot before or w/o the patch in question?
>
> If you boot via nfs then I'd expect that the PHY driver is built-in and
> not a module. Therefore it's not fully clear to me yet why
> request_module() returns -ENOENT.

I'm seeing the same booting nfsroot on several Renesas boards.
E.g. on r8a7791/koelsch:

    mdio_bus ee700000.ethernet-ffffffff:01: error -2 loading PHY
driver module for ID 0x00221537
    sh-eth ee700000.ethernet: MDIO init failed: -2

This failure happens only when CONFIG_MODULES=y.
Reverting commit 13d0ab6750b20957 ("net: phy: check return code when
requesting PHY driver module") fixes the issue.

phy_request_driver_module() tries to load module
"mdio:00000000001000100001010100110111", which fails.
When CONFIG_MODULES=n, the error is ignored, and everything works fine.

0b00000000001000100001010100110111 == 0x00221537 == PHY_ID_KSZ8041RNLI,
which is served by drivers/net/phy/micrel.c.
Interestingly, CONFIG_MICREL_PHY=y, so I'm wondering why the PHY subsystem
tries to load a module for a driver which is already present in the first
place?

Oh, the following comment tries to explain:

        /* Request the appropriate module unconditionally; don't
         * bother trying to do so only if it isn't already loaded,
         * because that gets complicated. A hotplug event would have
         * done an unconditional modprobe anyway.

Hence request_module() failures are normal.

       ret = request_module(MDIO_MODULE_PREFIX MDIO_ID_FMT,
                            MDIO_ID_ARGS(phy_id));
       /* we only check for failures in executing the usermode binary,
        * not whether a PHY driver module exists for the PHY ID
        */
       if (IS_ENABLED(CONFIG_MODULES) && ret < 0) {
               phydev_err(dev, "error %d loading PHY driver module for
ID 0x%08x\n",
                          ret, phy_id);
               return ret;
       }

However:

    /**
     * __request_module - try to load a kernel module
     * @wait: wait (or not) for the operation to complete
     * @fmt: printf style format string for the name of the module
     * @...: arguments as specified in the format string
     *
     * Load a module using the user mode module loader. The function returns
     * zero on success or a negative errno code or positive exit code from
     * "modprobe" on failure.

So perhaps the check should be for "ret > 0"?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
