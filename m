Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21B2C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9D02084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9D02084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeJDUwU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:52:20 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39696 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeJDUwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:52:19 -0400
Received: by mail-qk1-f194.google.com with SMTP id q5-v6so5774718qki.6;
        Thu, 04 Oct 2018 06:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OwxIbrSa7/wCHrKfpuJEJ1buXU3clGTQHZffoxEVnkg=;
        b=Hg4SNUWpx8bNin6ibjS3COaSwnovNMJ3/Q7mKEm2vRdh5pHipB2Pp3ApVTER9K9/SV
         C577fDxVuYbOfG6J6ZAmDpzbNbvN5LEsMcd4pGIVzym3PQuLFXdTjNP+fLYx2f9TXiDz
         WJUmhpsTHKA31iBafXsa2DYNzMEOVrifxgysItp1OO6jk8D9HaM5RmKwwJXj9KVETTE7
         jiw6MWMPZWF6EshJaeQV3+CTmekBjYhVX4Gjre/wAsTDNmaAaAXZ1NyK+UgTO5Sutubd
         j2IYhylFM0La+leuby+fpgcQPk5hYShS+baqvfzxymOd+VNnEXRzBnuL3KH8V/rjyRMu
         bTKA==
X-Gm-Message-State: ABuFfohflh2gUagvQ1Db0TPKI5W3zaxee1cbT3spTOa3mwxaNdhFDkNK
        C1xp3W6VXaKcOWGYvF/vw9yFqh6mmYYloLVlQQo=
X-Google-Smtp-Source: ACcGV63oH+dXpQFTES6lC3c7Cp7AD+G/kYeeXqUZvG4AIXy7aIuiAPMUnWgvTGItHtISSGqMBjyB3UsNAvjukhVvdHA=
X-Received: by 2002:a37:7347:: with SMTP id o68-v6mr5300016qkc.291.1538661532950;
 Thu, 04 Oct 2018 06:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180810080526.27207-1-brgl@bgdev.pl> <20180831194643.GA62862@ban.mtv.corp.google.com>
 <CAMRc=MejZLV1EQ7uAddsxLY0MTUF8WyiBn=F0ZhkWQJpET0EDQ@mail.gmail.com>
 <a4c2e6cf-749a-83a1-0bda-43ddb7e744cd@gmail.com> <CAMRc=MfwM7vODsnuV9eKS4Uf7M5ac59u7ao7KvyaxKzPv5FRvw@mail.gmail.com>
In-Reply-To: <CAMRc=MfwM7vODsnuV9eKS4Uf7M5ac59u7ao7KvyaxKzPv5FRvw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Oct 2018 15:58:36 +0200
Message-ID: <CAK8P3a1LufzR1_6mXH=1zDb34VQStLywGM1w5x5CDAMh_7uMyA@mail.gmail.com>
Subject: Re: [PATCH v2 00/29] at24: remove at24_platform_data
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        gregkh <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        naren.kernel@gmail.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        ivan.khoronzhuk@linaro.org, svendev@arcx.com, pabeni@redhat.com,
        Alban Bedel <albeu@free.fr>, Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Norris <briannorris@chromium.org>,
        Sowmini Varadhan <sowmini.varadhan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 1:06 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> śr., 3 paź 2018 o 23:04 Florian Fainelli <f.fainelli@gmail.com> napisał(a):
> > On 10/3/2018 1:15 PM, Bartosz Golaszewski wrote:
> > > pt., 31 sie 2018 o 21:46 Brian Norris <computersforpeace@gmail.com> napisał(a):
> > >>
> > >> Hi,
> > >>
> > >> On Fri, Aug 10, 2018 at 10:04:57AM +0200, Bartosz Golaszewski wrote:
> > >>> Most boards use the EEPROM to store the MAC address. This series adds
> > >>> support for cell lookups to the nvmem framework, registers relevant
> > >>> cells for all users, adds nvmem support to eth_platform_get_mac_address(),
> > >>> converts davinci_emac driver to using it and replaces at24_platform_data
> > >>> with device properties.
> > >>
> > >> We already have:
> > >>
> > >> of_get_nvmem_mac_address() (which does exactly what you're adding,
> > >> except it's DT specific)
> > >> of_get_mac_address()
> > >> fwnode_get_mac_address()
> > >> device_get_mac_address()
> > >>
> > >> and now you've taught me that this exists too:
> > >>
> > >> eth_platform_get_mac_address()
> > >>
> > >> These mostly don't share code, and with your series, they'll start to
> > >> diverge even more as to what they support. Can you please help rectify
> > >> that, instead of widening the gap?
> > >>
> > >> For instance, you can delete most of eth_platform_get_mac_address() and
> > >> replace it with device_get_mac_address() [1]. And you could add your new
> > >> stuff to fwnode_get_mac_address().
> > >>
> > >> And important part to note here is that you code isn't just useful for
> > >> ethernet -- it could be useful for Wifi devices too. So IMO, sticking it
> > >> only in an "eth" function is the wrong move.
> > >>
> > >> Brian
> > >>
> > >> [1] arch_get_platform_mac_address() is the only part I wouldn't want to
> > >> replicate into a truly generic helper. The following should be a no-op
> > >> refactor, AIUI:
> > >>
> > >
> > > The only user of arch_get_platform_mac_address() is sparc. It returns
> > > an address that seems to be read from some kind of EEPROM. I'm not
> > > familiar with this arch though. I'm wondering if we could somehow
> > > seamlessly remove this call and then convert all users of
> > > eth_platform_get_mac_address() to using device_get_mac_address()?
> > >
> > > David: I couldn't find a place in sparc code where any ethernet device
> > > would be registered, so is there a chance that nobody is using it?
> >
> > SPARC uses a true Open Firmware implementation, so it would register
> > drivers through the CONFIG_OF infrastructure.
> > --
>
> I'm seeing that there are only six callers of
> eth_platform_get_mac_address() (the only function which calls
> arch_get_platform_mac_address()).
>
> Of these six callers four are intel ethernet drivers and two are usb
> ethernet adapter drivers.
>
> Is it even possible that sparc wants to get the mac address for a usb
> adapter from some memory chip? Maybe we *can* safely remove that
> function completely? That would allow us to simplify a lot of code.

The calls are not even that old, and clearly added intentionally for sparc,
see commit ba94272d08a7 ("i40e: use eth_platform_get_mac_address()")
which added the first one.

Before that commit, the driver did the same as a couple of sun
specific ones that access the idprom directly:

drivers/net/ethernet/aeroflex/greth.c:
macaddr[i] = (unsigned int) idprom->id_ethaddr[i];
drivers/net/ethernet/amd/sun3lance.c:        dev->dev_addr[i] =
idprom->id_ethaddr[i];
drivers/net/ethernet/amd/sunlance.c:            dev->dev_addr[i] =
idprom->id_ethaddr[i];
drivers/net/ethernet/broadcom/tg3.c:    memcpy(dev->dev_addr,
idprom->id_ethaddr, ETH_ALEN);
drivers/net/ethernet/i825xx/sun3_82586.c:            dev->dev_addr[i]
= idprom->id_ethaddr[i];
drivers/net/ethernet/sun/sunbmac.c:             dev->dev_addr[i] =
idprom->id_ethaddr[i];
drivers/net/ethernet/sun/sungem.c:              addr = idprom->id_ethaddr;
drivers/net/ethernet/sun/sunhme.c:
memcpy(dev->dev_addr, idprom->id_ethaddr, ETH_ALEN);
drivers/net/ethernet/sun/sunhme.c:
memcpy(dev->dev_addr, idprom->id_ethaddr, ETH_ALEN);
drivers/net/ethernet/sun/sunqe.c:       memcpy(dev->dev_addr,
idprom->id_ethaddr, ETH_ALEN);

      Arnd
