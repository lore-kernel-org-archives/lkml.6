Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF698C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70172267D1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="J/G64Gr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70172267D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933853AbeFZJbu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:31:50 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37027 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932558AbeFZJbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:31:47 -0400
Received: by mail-it0-f65.google.com with SMTP id j129-v6so1356354ita.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QAv+Wc+vGVHrF87X/+IXHVfExpu3kNJslqoKsf44TTA=;
        b=J/G64Gr/4ms8zoXrDQx6iGH8TKR5wripiln0WbK+m1r3lspqHX/3AfLtfDIbLjxgc1
         sLCJsnKRM5IuEe2m6D3V+oylJtmkHqPx0Drbrsrbo1NMVLmQn9lSgzc81CNb1r4YTuSE
         m1F+Cr6kKCsM7qEQom/nrVBn0FOMHtWidhWrsjkwoZkWWt+w8IDYB3hgjvxc/ceiSoEp
         X0TInaUFAhdSfm7Gn/RraRoksGzu8gvLT++P2cJdY9VZv4/XPfIl7ANNCvB8elva3gsR
         imKOvDWs52/TEuoog9Qfr/iHA5p3KSe6oiY6hcQb9/qFIvHMgzbAk3S3YzEnULHHGUy5
         IC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QAv+Wc+vGVHrF87X/+IXHVfExpu3kNJslqoKsf44TTA=;
        b=Eo/4D//pn0mYNq8wY3utpz+l8bjHOidp3RJXV57DsGi/DH29XltodxmYs9WrMFxxsp
         DwDB6WcVAO1qN4qrayLcbD/PquMkwIiXcQkGLKJzp7E1sTM1nMek3F/veu7LuYArzHPP
         tzP0osU0AwShdYqzjrw90bUHWoZECwDkzsg/eVhNlyZfKKTUZyduifPvBZQ9rQHx+RCg
         nGbtlRJH8JE1jXkLywvwvcMs95LUdAlcIio1+YxXdQ6GTC9RN/5LXkFF975OubLPCnt1
         9VR3b9sXqNkI7XQ/2S9ZP/x5oKeRZL+K+kFFTJ8r0pPvtBG95wOPAP6lnSD+LaPOWfkK
         LO1g==
X-Gm-Message-State: APt69E0z0eWG+Rw2MSBglzvx/nbz7H5XJz1qKaDK+4vseexJ6x2dJyCu
        sTg0i1kXvCwcbxCCpwYTyw6UC1GUzArtrleAuRV7KA==
X-Google-Smtp-Source: ADUXVKKSg0RO3g2YSgerGU7jNVQpijI6smOqH11G2JOF/sJWZWOgUdt6S9QtAjdYYCt0pPo7JFrS08wLRa8sJU63yYg=
X-Received: by 2002:a24:ddc5:: with SMTP id t188-v6mr777125itf.125.1530005506759;
 Tue, 26 Jun 2018 02:31:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:9c51:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 02:31:46
 -0700 (PDT)
In-Reply-To: <20180626083823.GA28068@lunn.ch>
References: <20180625155025.12567-1-brgl@bgdev.pl> <20180625174024.GB17417@lunn.ch>
 <CAMRc=MdEn74G5SJAaGLAfNSS7Zy7wqH04aN5CMZ45UXqhu_58g@mail.gmail.com>
 <20180625180237.GC17417@lunn.ch> <CAMRc=MejDn=t6EPbKOfhMfRAb_O-5hxtWRyjAWH1mb5BUySrDA@mail.gmail.com>
 <20180626083823.GA28068@lunn.ch>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 26 Jun 2018 11:31:46 +0200
Message-ID: <CAMRc=Mdvh+1enpD3qDoamhPfaBPin2v3amneQELApgoC0bS2FQ@mail.gmail.com>
Subject: Re: [PATCH 00/14] ARM: davinci: step towards removing at24_platform_data
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-26 10:38 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
> On Tue, Jun 26, 2018 at 09:44:19AM +0200, Bartosz Golaszewski wrote:
>> 2018-06-25 20:02 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
>> >> With my patch 1/14 you'll get -EPROBE_DEFER from nvmem_cell_get() if
>> >> the nvmem provider is not yet registered. Will that help in your case?
>> >
>> > I don't think so. My driver instantiates the AT24 device. So if i get
>> > -EPROBE_DEFER, i need to cleanup the probe, and return -EPROBDE_DEFER
>> > to the code. Which means i need to remove the AT24 device...
>> >
>> >        Andrew
>>
>> Are you sure this is the correct approach? I understand that you want
>> to use something like board files for your machine? Wouldn't it be
>> better to register a platform device for at24, register a cell lookup
>> and then depend on that cell from your driver?
>
> Hi Bartosz
>
> The machine is based around a Kontron Com Express module, with an
> intel Ivy Bridge CPU. This is then placed into a custom carrier board,
> which has a number of i2c devices.
>
> I have a platform driver which matches on the DMI system ID for the
> Kontron module.
>
> The Com Express module has a PLD which implements i2c, gpio,
> etc. There is an MFD for this, which instantiates the i2c-kempld i2c
> bus driver.
>
> My platform driver finds this i2c-kempld bus driver. If it does not
> exist yet, it return -EPROBE_DEFER. If it is found it instantiates an
> at24 device on it. I need to look at the content of the EEPROM to
> determine the hardware revision, plus do a checksum.  From that, i
> need to instantiates 1 or 2 additional AT24, up to 4 GPIO expanders,
> and i2c to spi converter, add some gpio-leds on the gpio expanders,
> create a bit-banging MDIO bus, instantiate an Ethernet switch on the
> MDIO bus, maybe add an Ethernet switch to the SPI bus, etc.
>
> As you can see, i have a chain of events. I cannot move onto the next
> part of the chain until i know the probe for the previous part has
> finished. e.g. i cannot add gpio-leds until i know the gpio expander
> has probed. But the gpio expander provides a call back, similar to the
> at24 setup(). The MDIO bus and the SPI bus has a mechanism to register
> an info structure, just like you have done for NVMEM cells. So that
> works out.
>
> The weak link in this chain is that first at24 probe, and knowing when
> i can access the nvmem cells for the revision and checksum
> information. -EPROBE_DEFER does not help me here. I need either some
> sort of blocking wait for the cells to become available, or a callback
> in a context which allows me to instantiate more devices.
>
> I also have some steps which cannot be undone. You don't provide a
> mechanism to unregister the nvmem info structure. The I2C and MDIO
> equivalent also does not provide an unregister for bus info. So once i
> register the first info structure, i'm past the point of no return. I
> cannot return -EPROBE_DEFER because i cannot unregister the info
> structures, so that i can register them again the next time the
> platform driver gets probed.
>
>          Andrew
>

I see. I see it this way: the setup callback comes from the time when
we didn't have nvmem and should go away. I will protest loud whenever
someone will try to use it again and will work towards removing it as
soon as possible.

I will give your problem a thought and will try to get back with some
proposals - maybe we should, as you suggested, extend nvmem even
further to allow to remove nvmem info entries etc.

Best regards,
Bartosz Golaszewski
