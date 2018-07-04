Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F88C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 05:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BCE204EC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 05:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SakZvt9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BCE204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932774AbeGDFSf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 01:18:35 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:37359 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751768AbeGDFSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 01:18:33 -0400
Received: by mail-it0-f49.google.com with SMTP id p17-v6so6325634itc.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 22:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6KQxFv5m+SixAm3/A+Rw4gGWASDThOn9w82kKZfPCxc=;
        b=SakZvt9C7i1eUCPKTbaSRMRMCCh5tWNwrgq7AExXFnCtSBQk39rrY21XrsNFUom276
         BHyFfkuXW6Y6TZguHGL1Morm9SeUTVKGkOQ6oBq2J2DFojCD6rv/WuVsQzCklZ3jRouz
         6FZ0J8Ts0sT+6tNDQMaJv+YRXcynRk8iPgrbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6KQxFv5m+SixAm3/A+Rw4gGWASDThOn9w82kKZfPCxc=;
        b=fgb+nm6Dssqh9UNzs9GYDWvtOxoabpLRW7SiGZDt7G6ap2/qrLHtXpUfUEzKK15GKl
         VHjIx8lhsemegmWBecJU/J4M3yI3DRwKKQmKYWV8VYYimeHubyC14XFVL2j1j3tJsyKQ
         zzXADDwLAFN4Bzrm5+YFkJogHzIjpbxWbZZJNuQhQFnzcylrwTyC46sh3OR0QqZLLOa4
         LmegfjR+miSZaGMMhyMW2TBfFkyq/6dayX3Awj9NF0KkaVbixXlOBlPXFaaI2EoB8XrM
         Vu1VLu4L7EfzZOYC1zKryklkZ8Ld3Hj9/PP0FpFm+xvW6JPlu7GO9tXbVafEX8Q3G8kd
         0PsA==
X-Gm-Message-State: APt69E06z1FMG5G9AR/TMgytP96fbgxu8cg+y69TYi9S2SMYF8Je64uB
        E6VSabxXE7TPm5GueK7FWLM9Y36+K10h8EGhRbn14A==
X-Google-Smtp-Source: AAOMgpesdvFBVvwv+5VTj4Vk/OCRxfNDFE5fEKNlxInWJwDjPvA9Zkj81OPf/ceUg9XhSkqYfgKl8RbSiKUWMyc7iOg=
X-Received: by 2002:a02:943:: with SMTP id f64-v6mr405833jad.31.1530681512788;
 Tue, 03 Jul 2018 22:18:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:a785:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 22:18:32 -0700 (PDT)
In-Reply-To: <20180703184117.GC5611@w540>
References: <CAMty3ZAMjCKv1BtLnobRZUzp=9Xu1gY5+R3Zi-JuobAJZQrXxg@mail.gmail.com>
 <20180531190659.xdp4q2cjro33aihq@pengutronix.de> <CAMty3ZCeR3uEx8oy18-Ur7ma7pciKUf_myDk6_SpWvxc6DvygQ@mail.gmail.com>
 <CAOMZO5AOpOSAx=L4tOU1Na6hm8Tex3PHNxCYDB81C0+NPHzTZQ@mail.gmail.com> <20180703184117.GC5611@w540>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 4 Jul 2018 10:48:32 +0530
Message-ID: <CAMty3ZCWztkM2oEaKQRVmMkA0C1V6b9Oj59DBX9XAWAybZbRAw@mail.gmail.com>
Subject: Re: i.MX6 MIPI-CSI2 OV5640 Camera testing on Mainline Linux
To:     jacopo mondi <jacopo@jmondi.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Philipp Zabel <pza@pengutronix.de>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Discussion of the development of and with GStreamer 
        <gstreamer-devel@lists.freedesktop.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 12:11 AM, jacopo mondi <jacopo@jmondi.org> wrote:
> Hi Fabio,
>   thanks for pointing Jagan to my series, but..
>
> On Fri, Jun 29, 2018 at 06:46:39PM -0300, Fabio Estevam wrote:
>> Hi Jagan,
>>
>> On Fri, Jun 1, 2018 at 2:19 AM, Jagan Teki <jagan@amarulasolutions.com> wrote:
>>
>> > I actually tried even on video0 which I forgot to post the log [4].
>> > Now I understand I'm trying for wrong device to capture look like
>> > video0 which is ipu1 prepenc firing kernel oops. I'm trying to debug
>> > this and let me know if have any suggestion to look into.
>> >
>> > [   56.800074] imx6-mipi-csi2: LP-11 timeout, phy_state = 0x000002b0
>> > [   57.369660] ipu1_ic_prpenc: EOF timeout
>> > [   57.849692] ipu1_ic_prpenc: wait last EOF timeout
>> > [   57.855703] ipu1_ic_prpenc: pipeline start failed with -110
>>
>> Could you please test this series from Jacopo?
>> https://www.mail-archive.com/linux-media@vger.kernel.org/msg133191.html

Will verify this on my board and let you know the result.

>>
>> It seems that it would fix this problem.
>
> ... unfortunately it does not :(
>
> I've been able to test on the same platform where Jagan has reported
> this issue, and the CSI-2 bus still fails to startup properly...
>
> I do not have CSI-2 receiver driver documentation for the other platform
> I am testing on and where my patches improved stability, but the i.MX6 error
> reported by Jagan could be useful to help debugging what's wrong with the
> serial bus initialization on that platform.
>
> The error comes from register MIPI_CSI_PHY_STATE of the i.MX6 MIPI_CSI-2
> interface and reads as:
>
> 0x2b0 : BIT(9) -> clock in ULPS state
>         BIT(7) -> lane3 in stop state
>         BIT(5) -> lane1 in stop state
>         BIT(4) -> lane0 in stop state
>
> The i.MX6 driver wants instead that register to be:
>
> 0x430 : BIT(10) -> clock in stop state
>         BIT(5) -> lane1 in stop state
>         BIT(4) -> lane0 in stop state
>
> So indeed it represents a useful debugging tool to have an idea of what's going
> on there.
>
> I'm a bit puzzled by the BIT(7) as lane3 is not connected, as ov5640 is a 2
> lanes sensor, and I would have a question for Jagan here: has the sensor been
> validated with BSP/vendor kernels on that platform? There's a flat cable
> connecting the camera module to the main board, and for high speed
> differential signals that's maybe not the best possible solution...

Yes, I've validated through engicam Linux, [1] before verifying to
Mainline. I have similar board which posted on the website on J5 point
20-Polig connector attached to bus to sensor[2]

[1] https://github.com/engicam-stable/engicam-kernel-4.1.15/blob/som_release/arch/arm/boot/dts/icoremx6q-icore-mipi.dts
[2] https://www.engicam.com/vis-prod/101145

Jagan.

-- 
Jagan Teki
Senior Linux Kernel Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
