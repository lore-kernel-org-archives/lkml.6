Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B9FC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 14:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A7F20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 14:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y56NHMN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A7F20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeIBSjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 14:39:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41558 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeIBSjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 14:39:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id b12-v6so7472082plr.8;
        Sun, 02 Sep 2018 07:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jBCxuiPT7EJUzl4lZaxX7o5iT5P1K+Wl9qFxMfOjLeE=;
        b=Y56NHMN+A+CgCXngmf+E+9nyS9eHfT72pZog/gLoX69DilnaLMVgjDvwNYZpKWANVl
         E5TL0F4Ct805pvSoVWh8qDSeIfu7yo6k8vJvinuu3oc2GM+2IhVSb5twn/6Vw7veVqCU
         WF6lk7y8aszkqIFvDlF2YMjfj6HtPHcxhqen5xtJF4tpNpmYPhPu5qwRtDWpJQSjAqus
         sxuzpmBMFOKZNY8eoVMUsOYnuP28FBGhYj1rCEIielWz4hVzUemY7CERPji6fYdLLFtQ
         8oBUnHV/MTOLmlNpDQyP7ocEO+PMdvWLsKqjaL1t0ufTlyBVr3uuZGdmvm0WkuvQzb55
         Ay3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jBCxuiPT7EJUzl4lZaxX7o5iT5P1K+Wl9qFxMfOjLeE=;
        b=tNlDVAgQH9fF2maaHJlXQJUXbyyDSwCAPxGB+CdxSrJW9QXIwVdEv6L4rWiWUPSVco
         LXT/cc1LtJUB3CwkQTYxILw7cBkm+WK+5fg7BaFDIVq6Hbflm4IbDPafJcf4Pa16fmTX
         BqL7eejytUy5KLGEHL2A1W0lKJIcSKstgDfvE+ODbBQuQEf5zbwGUi+sfAgUbnLlsDCE
         K3p4csZgPTOrcKN/ixL+SjtMevOGTqLbCoCCrhgT4EmwhSZZKIvy4G+Rw+q5cSv8Jo6S
         SSfDtNvG4Wbe9ygi//Np0w+s6tEipDE3vKYJ6kWcENVEYFgN4zhuQEdO5lfGJpXhQOHq
         16wA==
X-Gm-Message-State: APzg51CDC+mRSXdPNzRCYZTT2Pr2vhYVdzFaahDafvYeuV29kkAq6kcL
        3xEJhBnZXcz9bb/QF3MwIor7AP7w
X-Google-Smtp-Source: ANB0VdbhyboSxOhlQqgeTohgCFw8lnUm2gsc91h/2YOPIf0Oc4n66cpThlJR+jkhBj2FJklawlI4EA==
X-Received: by 2002:a17:902:b7c3:: with SMTP id v3-v6mr24197265plz.238.1535898224408;
        Sun, 02 Sep 2018 07:23:44 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id x2-v6sm31574827pfi.166.2018.09.02.07.23.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 07:23:43 -0700 (PDT)
Subject: Re: [PATCH RFC 0/2] hwmon: Add RPi PoE HAT fan driver
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Phil Elwell <phil@raspberrypi.org>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1535887251-29515-1-git-send-email-stefan.wahren@i2se.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <99ca4f6d-d2b2-36e7-9f27-189df379cfaf@roeck-us.net>
Date:   Sun, 2 Sep 2018 07:23:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535887251-29515-1-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2018 04:20 AM, Stefan Wahren wrote:
> This series is an early stage of the hwmon driver for the fan on the
> Raspberry Pi Power over Ethernet HAT [1]. At the end this should use a
> Device Tree Overlay.
> 
> Changes by Stefan based on [2]:
> - reformat the downstream patches for submission
> - drop reboot notification
> - fix remaining checkpatch issues
> - add COMPILE_TEST to Kconfig
> 
> The driver is mostly copy & paste from pwm-fan, which isn't good. Personally
> i see two options:
> 
> 1) integrate the driver function into the pwm-fan driver (new compatible)
> 2) implement the core function as a PWM driver and use the pwm-fan driver on top
> 

I don't really see the point of thise driver. Why not implement either of those ?
2) sounds like a perfect fit to me.

Guenter

> [1] - https://www.raspberrypi.org/products/poe-hat/
> [2] - https://github.com/raspberrypi/linux/commit/0f937c8dc3201ebffa6c617c616fd7c65db65959
> 
> Serge Schneider (2):
>    dt-bindings: hwmon: Add RPi PoE HAT documentation
>    hwmon: Add RPi PoE HAT fan driver
> 
>   .../devicetree/bindings/hwmon/rpi-poe-fan.txt      |  55 +++
>   Documentation/hwmon/rpi-poe-fan                    |  15 +
>   drivers/hwmon/Kconfig                              |  11 +
>   drivers/hwmon/Makefile                             |   1 +
>   drivers/hwmon/rpi-poe-fan.c                        | 414 +++++++++++++++++++++
>   include/soc/bcm2835/raspberrypi-firmware.h         |   2 +
>   6 files changed, 498 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/rpi-poe-fan.txt
>   create mode 100644 Documentation/hwmon/rpi-poe-fan
>   create mode 100644 drivers/hwmon/rpi-poe-fan.c
> 

