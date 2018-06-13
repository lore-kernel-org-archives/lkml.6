Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E5353C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9817F208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=edited-us.20150623.gappssmtp.com header.i=@edited-us.20150623.gappssmtp.com header.b="G8+wbRCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9817F208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=edited.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935721AbeFMST4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:19:56 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46401 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935163AbeFMSTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:19:53 -0400
Received: by mail-lf0-f66.google.com with SMTP id j13-v6so5360658lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 11:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edited-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oJRRJov7NzEr6QGNG0x5ZI0dAG9crArWNGj8O/mJRDg=;
        b=G8+wbRCig46QoOuwNOeypQLX0OwxeWhf26xeFvTbuszu2PxWOzcaSQf+2+CfQx05CR
         w3/x4LTzT7M7JWZ3aYzVGMZohJpUqIrH9OwisotgEr+c6VKoqIOazf0nspFMi/CjFkmR
         oGbtmS12D0aplj/pQQavYkMp+muEy3GR66BwZ4aZl6tfVw4R9NfhVzVY36wz8OvKfFpL
         CqspSvhgmLhGRJbaKtv6K0KsMpmtFBCIgN1YXyGpAx7w5a/8D2p8XlpRHCekaS/+9yRV
         EA0kxZ5SWnAmbTW+J7EhdNKpqEM7JSxfTwHn+RmrvfnL2sfUhr/iqDnqzUdK4cqX/fOl
         1vEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oJRRJov7NzEr6QGNG0x5ZI0dAG9crArWNGj8O/mJRDg=;
        b=X+GN8I5nc1ohvdfqhZJgVlxXvXg5piS+6thT1jUUEwr+FsqIGBVZxjjjaMGtAVEF0x
         Dz/zJIdYYPpbccUf4G21ktrgc7IkFxb/8Iu6Jog0dlHCLoBhDm8oQwMKyO/pBqdH7qMd
         iyoaen9+ViJPcDeMXmgc6cmmdgYjm46m3JKwDehJ0Eg+mfLpv/gp3i8+h7d+2NYNXxRR
         QH6PK1wjIeTz7YdbQ6H+/YsxJGQRRFFOw1Uh7+U91sTOByFGO6ztB58/6XKZYaaxMNOk
         +ggFaXpBkLi5+TlB1wMGJONs42UQRZLScjC0xNZSE7cGWgQ6fBG6b3yVrMSIf3D/qKW4
         HMpw==
X-Gm-Message-State: APt69E0bxbwKIJToNKlFv/rTSafYF8XQCq6L+XUQzslcrZgUlWkHoFZ1
        DwP9aABIKbcjFn3Gj4rAWuciQGJspLpVvRZo/ZjWrw==
X-Google-Smtp-Source: ADUXVKK7FWChCoLT0PlRFNG6mtUpV5yKjllmULOpwXjisaZCq7ems69QuJGaSpqRcgpVfuRXXJJ0Thnn7RoN3Xb4fGQ=
X-Received: by 2002:a19:aa0f:: with SMTP id t15-v6mr3957515lfe.58.1528913992145;
 Wed, 13 Jun 2018 11:19:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:59c8:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 11:19:51
 -0700 (PDT)
In-Reply-To: <521dd38a-29b8-5670-4296-84b300921b3d@arm.com>
References: <20180613151305.17240-1-ryan@edited.us> <521dd38a-29b8-5670-4296-84b300921b3d@arm.com>
From:   Ryan Grachek <ryan@edited.us>
Date:   Wed, 13 Jun 2018 13:19:51 -0500
Message-ID: <CAGoBSJqg0nzk-2UPcoZE7mJ2mykoD7wiO2YTPHw9RijZRHTCOw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: hikey: Define wl1835 power capabilities
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On Wed, Jun 13, 2018 at 12:34 PM, Valentin Schneider
<valentin.schneider@arm.com> wrote:
> Hi,
>
> On 13/06/18 16:13, Ryan Grachek wrote:
>> These properties are required for compatibility with runtime PM.
>> Without these properties, MMC host controller will not be aware
>> of power capabilities. When the wlcore driver attempts to power
>> on the device, it will erroneously fail with -EACCES.
>>
>
> I don't have a hikey620 to test this, but the hikey960 is suffering from the
> same issue (see [1]). I added these properties to the dwmmc2 node of the
> hikey960 (see snippet) and wlan0 does show up. Would you mind sending a
> similar patch for that board ?
>
> Thanks !
>
> Valentin
>
> [1]: https://lkml.org/lkml/2018/6/12/930
>
> --->8
>
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> index 85aadf1b..c706f70 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -613,6 +613,8 @@
>         vmmc-supply = <&wlan_en>;
>         ti,non-removable;
>         non-removable;
> +       cap-power-off-card;
> +       keep-power-in-suspend;
>         #address-cells = <0x1>;
>         #size-cells = <0x0>;
>         status = "ok";

Not a problem. The patch can be found here:
https://patchwork.kernel.org/patch/10462767/

Ryan
