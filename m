Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEF9C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA3820866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2BZtdfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA3820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbeIKA3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 20:29:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38077 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbeIKA3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 20:29:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id t25-v6so22588988wmi.3;
        Mon, 10 Sep 2018 12:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rEyHzTrIrqiNIiEBN196L1DaBJEai2aMxkS4E+rpYMc=;
        b=Y2BZtdfgLR3cSW09dkr8zcjLlU4X3pNZnOt6tFWWgFJ1DZuCt9dnriKo78rokIPzem
         xp/yOJlxhHu/af0o/t5dSY6DNvXI1hVVtb5ScnMpBsgREemdBVZ+XY8+OjOU3mI8MiQE
         oM6u4vZq9gdWrCqztEin18tPz8mWeRip8ZozBfaT/kAe9m7oBhCMm3LM6xnyXzBlhi8R
         /WRiBSfcrQg48C9iXqRJBRC8gnRdv9YRb7y4vm2I1vLruov4EBFFfJ+CguROoBYQJfbu
         hzW5OP46rrYmMAjUJnumX5iFWEbze6GW/5pee9H8XmIlkjd0bgOeD2Zbj7ETEXJWiraM
         QJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rEyHzTrIrqiNIiEBN196L1DaBJEai2aMxkS4E+rpYMc=;
        b=m/NCr63/GkG3Gb3DdXIQ2rX72fQZn2gP5+d42Qcl5lRJfqJo3RATY6bxeD/4xLqohh
         GerysH/mYAJZ88btaCxOOKG0TgQPNhO6Wr9drZhAvEBykNRC+dqhmuPGMNDddk8E7YMD
         Em8BXqKatdp6p3Z5hlFi/6I3Kp5V8XqeQScEu2r3Z8tkrN4bXu8LD9ryzUyVL+cbaOq4
         YgSh9RDJlnsHl67k1JAdDEwRxRz+O6e+06xL5O5abj3sHxDexhbo4edWpFcEqGBrRIkK
         b4pORZosjld7tcx9LTPhIc57/Yf31rCOi165kGJsULSEDCcAKn8iVP4LmfCeOCPbH2fz
         D6JQ==
X-Gm-Message-State: APzg51CiA7uDlwSFqaWQRBNgqE2yJS/E0BJ22vQ22P+qa0Ln0GJdJ8XC
        /0M4ArEeVHKlcTILQqQTKO0k1XNN
X-Google-Smtp-Source: ANB0Vdatt2efKsVxVOgW24PbBqurgMYi1hO94qResIeMLxqNZgODCZGzRs5sUrrMi7kaG9C6NKq4sw==
X-Received: by 2002:a1c:d98a:: with SMTP id q132-v6mr1779531wmg.78.1536608035897;
        Mon, 10 Sep 2018 12:33:55 -0700 (PDT)
Received: from [192.168.1.18] (dlx100.neoplus.adsl.tpnet.pl. [83.24.53.100])
        by smtp.gmail.com with ESMTPSA id v5-v6sm14563671wru.60.2018.09.10.12.33.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 12:33:55 -0700 (PDT)
Subject: Re: [PATCH v5 0/2] Panasonic AN30259A support
To:     Simon Shields <simon@lineageos.org>, linux-leds@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180909103826.17793-1-simon@lineageos.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <3bafc642-db6c-e872-cca5-8f654f38224a@gmail.com>
Date:   Mon, 10 Sep 2018 21:33:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180909103826.17793-1-simon@lineageos.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

Thank you for the updated set.

On 09/09/2018 12:38 PM, Simon Shields wrote:
> Hi,
> 
> This patch series adds DT bindings (patch #1) and the corresponding driver
> (patch #2) for the Panasonic AN30259A 3-channel LED driver. AN30259A
> uses an internal clock for controlling brightness/on-off cycles, but
> also supports using an external PWM/clock input. This patch series only
> implements support for the former.
> 
> The AN30259A is connected using I2C, and the datasheet is freely
> available[0].
> 
> Changes since v4 (mistakenly sent as v3):
> * Rebased on v4.19-rc2
> * Namespace all macros with AN30259A_ prefix
> * Fix trivial compiler/checkpatch --strict warnings
> 
> Changes since v3:
> * Rebased on v4.18-rc3.
> * Drop unnecessary DUTYMAX/MID calculations when blinking:
>  previously I'd thought that the PWM duty values were expressed
>  as a percentage of the maximum current output, but in reality
>  they're a percentage of the current set in the LEDxCC registers.
> This simplifies the code quite a bit.
> * Corrected MODULE_LICENSE declaration.
> * Return -EINVAL from set_blink if the blink rate is unsupported in
>  hardware.
> * Fix more checkpatch --strict issues.
> 
> Changes since v2:
> * Drop "an30259a:" prefix from bindings and add it in the device driver
>  instead.
> * Use led-controller instead of leds for sample DT binding.
> * Use ":indicator" instead of ":notification" in sample DT binding.
> * Merge an30259a_led_set and an30259a_brightness to
>  an30259a_brightness_set (and same for blink functions).
> * Explain the range limitations of the AN30259A's sloping mode
>  in the code - the AN30259A only has a 7-bit PWM range in slope mode,
>  and the bottom 3 bits are always set.
> 
> Changes since v1:
> * Documentation formatting/grammar fixes.
> * Use reg property instead of led-sources for leds.
> * Add default-state support.
> * Fix auto-probing when built as a module.
> * Simplified DT parsing code.
> * Use devm version of led_class_register().
> * Fix LED naming scheme.
> * Fixed checkpatch --strict issues.
> 
> Cheers,
> Simon
> 
> [0]: https://www.alliedelec.com/m/d/a9d2b3ee87c2d1a535a41dd747b1c247.pdf
> 
> Simon Shields (2):
>   dt-bindings: leds: document Panasonic AN30259A bindings
>   leds: add Panasonic AN30259A support
> 
>  .../bindings/leds/leds-an30259a.txt           |  43 ++
>  drivers/leds/Kconfig                          |  10 +
>  drivers/leds/Makefile                         |   1 +
>  drivers/leds/leds-an30259a.c                  | 368 ++++++++++++++++++
>  4 files changed, 422 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-an30259a.txt
>  create mode 100644 drivers/leds/leds-an30259a.c
> 

Applied to the for-next branch of linux-leds.git.

-- 
Best regards,
Jacek Anaszewski
