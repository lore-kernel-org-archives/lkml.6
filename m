Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F40ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AD5208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jKFb867F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3AD5208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbeGMSPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 14:15:54 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:44813 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbeGMSPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 14:15:54 -0400
Received: by mail-io0-f196.google.com with SMTP id q19-v6so32055470ioh.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 11:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FBxFggsTk6+AE31MdG6lwBMi3W0q1vsEDThYgPWB+A0=;
        b=jKFb867FTIJRA4baBU13sO5Q3e/LyLo2mXOZDghchUjZbX8SZhUBQpEiwPlJ/Bs3MA
         XVG+LWp0s9soUSId/x0nFjlAbtkbOOD7QJMz4P0qLY3LAA+cR2FbSTOdAH6o4/tDgfbQ
         8r0rxZdIjaj/qhz3FmfAACT/nCkFtqKAwUiiGGsMbQwmH+RSZmHrLXcfITte99HVDqSA
         EUEAOeoxiusMcGeEdJEh3Em+kRmNNlBQryDrjGgeRdowYduu8bOO+f9K6toi4iuVUqK9
         IrsIveTrRTHzKa0hgeGKjIS1bflQc1pSbP9zJ7A2O7AMArZLOLIO+JFOM6xFFMop0aiv
         //9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FBxFggsTk6+AE31MdG6lwBMi3W0q1vsEDThYgPWB+A0=;
        b=pjVwnXIuXKpVghq6VLsg1km0/jI88C2NgbcVpUSog8tnWcIMSEQxjLlQi+/Ho/Xixs
         raab5Xx5hFHXQGNbOUdJj4FSoVDrx+yyAdN1c9uFXuY2XHaNcv1mDkTe0Z5gmS2L0K6V
         OE2xmDS3NMK9HRm9ieO2MKOLR/WqVLJ9V5K4Na2Gfk1iE418sq+IHcgEeAGKiC40wqV5
         4ASe8qLgI0N1PyPBibutoBOayBM4YrpEhSAEquvyTJesSTHu2X3WGfoPz+4SWSOjX4cU
         9ZK9PduEmSuKwfp6lX4M7RfSx7E6dsSoHrGx4t9MRAOpaF27Vy4HUmj81ehYwLFMNol2
         ZnEA==
X-Gm-Message-State: AOUpUlE3VYNusoZQ323WS6MQVAz0l0ekrnHuRfWL5xR3ed6KxE82b34H
        kYhgeilKg6ACmOeIkrbt56oS5/UZxUebD5T7Va/rjQ==
X-Google-Smtp-Source: AAOMgpfdI5WyvamEqrI/stQOh4S11vFWssHCE5MenT5vpGCA2SdG4mx1gScfYrJl8KhPho5jiOlP/Qh6aFEhpkVxj1g=
X-Received: by 2002:a5e:8d07:: with SMTP id m7-v6mr8860991ioj.258.1531504813722;
 Fri, 13 Jul 2018 11:00:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 11:00:13
 -0700 (PDT)
In-Reply-To: <c0ffc590-8064-3b02-9b5c-fcc24628d390@ti.com>
References: <20180629094039.7543-1-brgl@bgdev.pl> <20180629094039.7543-9-brgl@bgdev.pl>
 <03b77e24-9ab9-fa01-2387-9de0408a9942@gmail.com> <20180704070919.GA14051@lenoch>
 <CAMRc=McOYG9=naT2=4c4hnhJwxcqBCATEZOGXXv9u9zuvXyDXw@mail.gmail.com> <c0ffc590-8064-3b02-9b5c-fcc24628d390@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 13 Jul 2018 20:00:13 +0200
Message-ID: <CAMRc=McO8H9Aw8a7h318a=hJjKBOgeC+9_hreBnOY3Tc3Fh7sg@mail.gmail.com>
Subject: Re: [PATCH v4 08/18] net: davinci_emac: potentially get the MAC
 address from MTD
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Ladislav Michl <ladis@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-04 11:04 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
> On Wednesday 04 July 2018 01:59 PM, Bartosz Golaszewski wrote:
>> 2018-07-04 9:09 GMT+02:00 Ladislav Michl <ladis@linux-mips.org>:
>>> On Tue, Jul 03, 2018 at 09:39:51AM -0700, Florian Fainelli wrote:
>>>>
>>>>
>>>> On 06/29/2018 02:40 AM, Bartosz Golaszewski wrote:
>>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>>
>>>>> On da850-evm board we can read the MAC address from MTD. It's currently
>>>>> done in the relevant board file, but we want to get rid of all the MAC
>>>>> reading callbacks from the board file (SPI and NAND). Move the reading
>>>>> of the MAC address from SPI to the emac driver's probe function.
>>>>
>>>> This should be made something generic to all drivers, not just something
>>>> the davinci_emac driver does, something like this actually:
>>>>
>>>> https://lkml.org/lkml/2018/3/24/312
>>>
>>> ...and that's would also make it work when MAC address is stored
>>> in 24c08 EEPROM, which is quite common.
>>>
>>
>> This is what the second patch for davinci_emac in this series does. I
>> agree that this should become more generic at some point - we should
>> probably have a routine somewhere in net that would try to get the MAC
>> address from all possible sources (nvmem, of etc.). This is somewhat
>> related to the work I want to do on nvmem to make the at24 setup()
>> callback more generic.
>>
>> Unfortunately we don't have it yet and I will not have time to work on
>> it before v4.20 so if there are no serious objections, I'd like to get
>> this series merged for v4.19 and then we can refactor the MAC reading
>> later.
>>
>> How does it sound?
>
> I don't think the series introduces any regressions. We need to have MTD
> and SPI flash built into the kernel even today to get mac address on
> DA850 EVM. So from that perspective, I don't have objections (I need to
> actually test still).
>
> OTOH, it will be nice to do the conversion once and not piecemeal. That
> way there is less churn and scope for regressions.
>
> So from a mach-davinci perspective, I don't have a very strong position
> either way.
>
> Thanks,
> Sekhar

We're getting close to rc5 so I'd like to make a case for this series again.

I understand that there's more to do than just the changes introduced
here, but we shouldn't try to fix several problems in many different
places at once. There's just too many moving pieces. I'd rather start
merging small improvements right away.

The idea behind this series is to remove (almost) all users of
at24_platform_data. The davinci_emac patches are there only because we
need to remove some MAC adress reading stuff from the board files.
Having this code there and calling it back from EEPROM/MTD drivers is
already wrong and we should work towards using nvmem for that anyway.

Currently for MTD the nvmem support series seems to be dead and it's
going to take some time before anything gets upstream.

So I'd like to again ask you to consider picking up the patches from
this series to your respective trees or at the very least: I'd like to
ask Srinivas to pick up the nvmem patches and Sekhar to take the
first, non-controversial batch of davinci platform changes so that
we'll have less code to carry for the next release.

Best regards,
Bartosz Golaszewski
