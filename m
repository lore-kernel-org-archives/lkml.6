Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B33C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717D920684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ngv+saBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717D920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeJDDyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 23:54:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46042 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeJDDyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 23:54:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id t70-v6so2084156pgd.12;
        Wed, 03 Oct 2018 14:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eT1z7kCaPNGd1B8QQr3yYO0fQSZS6ql4og4wbPEH0pE=;
        b=Ngv+saBEi757gu59/zsVBhNl8Dw8bgJoPAjQYA+/5V27qHYea3LO5lfTJBCobAD0YV
         4dL2g/fU74cCN/U5TFetx+Rf7OJxzGY4ol1194P7KUupGE7G+1OmQh9UvhM2EyUqoIE8
         MB+uXHWpGM+Em5zloHz/0yzmHTxP3AJb7ZwOQmgpOW2JKB63Fsd8I0W6QWtPN0uRdfYX
         Ys3j5f8qP8ui6rVLkn2SGEpdxGo5hWIawgMns9o9516gT5j4tw46O3iUJ3rwvOXty2E7
         zxsJvOlRplHRRxSJ9Z7GsE8ODreHTLpRHQDQYhQpmzDRDr+yTLwNl8KiMXRqkgkQDe6Q
         hmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eT1z7kCaPNGd1B8QQr3yYO0fQSZS6ql4og4wbPEH0pE=;
        b=clz6mjKvSu9N9CIdasj8WG428XcY236R0KpYpa0HUjmjEKOF4qnjUsVVyXESSLY5js
         pa46s/qHFDc+yH7A3iVZ9EMqet6BcdQi7J+S/sUpY1PwWwdskuvhPszURWLxToJYDOcQ
         pCWM9dSdOcXaxMXoRSKJXPxRZeaPCRRM33tS7Y/5PaWvw5fTJp1gAoedzRaGV4EkQb68
         4OsW/nNhi5sYPwfJeYhLX+w8y3Df8FksgAl/K1IrW7Fv922+LeLh7tvVJy6SPXRGxrj6
         6WtZIQORhnDrHG2MzlaJc5ymR5NcnQFoc3nXCZUf+F+CHHP3hsLeSG5o/rYvIWzpkv0Z
         Vm2A==
X-Gm-Message-State: ABuFfojgaVnNHIDfcwmv55Cw+RYrUCtwfKvvl8L+VZsWfL1qCVUifpDf
        JeWzYcgeb5SMYAHOL+grP54=
X-Google-Smtp-Source: ACcGV63r7lBrjqtmQnZ6ViwGWA6GXWACF2TQT3mMsHME7Ir+3FnMipnY1MTfeufDXEGVoWFx/21rcg==
X-Received: by 2002:a63:f05:: with SMTP id e5-v6mr2840555pgl.84.1538600657175;
        Wed, 03 Oct 2018 14:04:17 -0700 (PDT)
Received: from [10.69.78.41] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id y4-v6sm3199749pfm.137.2018.10.03.14.04.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 14:04:15 -0700 (PDT)
Subject: Re: [PATCH v2 00/29] at24: remove at24_platform_data
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Brian Norris <computersforpeace@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Alban Bedel <albeu@free.fr>,
        Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Norris <briannorris@chromium.org>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180831194643.GA62862@ban.mtv.corp.google.com>
 <CAMRc=MejZLV1EQ7uAddsxLY0MTUF8WyiBn=F0ZhkWQJpET0EDQ@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a4c2e6cf-749a-83a1-0bda-43ddb7e744cd@gmail.com>
Date:   Wed, 3 Oct 2018 14:04:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=MejZLV1EQ7uAddsxLY0MTUF8WyiBn=F0ZhkWQJpET0EDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/3/2018 1:15 PM, Bartosz Golaszewski wrote:
> pt., 31 sie 2018 o 21:46 Brian Norris <computersforpeace@gmail.com> napisał(a):
>>
>> Hi,
>>
>> On Fri, Aug 10, 2018 at 10:04:57AM +0200, Bartosz Golaszewski wrote:
>>> Most boards use the EEPROM to store the MAC address. This series adds
>>> support for cell lookups to the nvmem framework, registers relevant
>>> cells for all users, adds nvmem support to eth_platform_get_mac_address(),
>>> converts davinci_emac driver to using it and replaces at24_platform_data
>>> with device properties.
>>
>> We already have:
>>
>> of_get_nvmem_mac_address() (which does exactly what you're adding,
>> except it's DT specific)
>> of_get_mac_address()
>> fwnode_get_mac_address()
>> device_get_mac_address()
>>
>> and now you've taught me that this exists too:
>>
>> eth_platform_get_mac_address()
>>
>> These mostly don't share code, and with your series, they'll start to
>> diverge even more as to what they support. Can you please help rectify
>> that, instead of widening the gap?
>>
>> For instance, you can delete most of eth_platform_get_mac_address() and
>> replace it with device_get_mac_address() [1]. And you could add your new
>> stuff to fwnode_get_mac_address().
>>
>> And important part to note here is that you code isn't just useful for
>> ethernet -- it could be useful for Wifi devices too. So IMO, sticking it
>> only in an "eth" function is the wrong move.
>>
>> Brian
>>
>> [1] arch_get_platform_mac_address() is the only part I wouldn't want to
>> replicate into a truly generic helper. The following should be a no-op
>> refactor, AIUI:
>>
> 
> The only user of arch_get_platform_mac_address() is sparc. It returns
> an address that seems to be read from some kind of EEPROM. I'm not
> familiar with this arch though. I'm wondering if we could somehow
> seamlessly remove this call and then convert all users of
> eth_platform_get_mac_address() to using device_get_mac_address()?
> 
> David: I couldn't find a place in sparc code where any ethernet device
> would be registered, so is there a chance that nobody is using it?

SPARC uses a true Open Firmware implementation, so it would register 
drivers through the CONFIG_OF infrastructure.
-- 
Florian
