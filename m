Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B73C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A205E24738
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Yc8fh+Pr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A205E24738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753062AbeGDG50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:57:26 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36493 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933664AbeGDG5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:57:24 -0400
Received: by mail-io0-f193.google.com with SMTP id k3-v6so3938258iog.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 23:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s8Rp56sTOfzybD+AMzqYniwV8tPcdqGWGcUIafgdSuo=;
        b=Yc8fh+PrdkQrOV/huWRtC5AMqXLAw0skNf7JZVijy/kscpogHG+EyFZVRm7Do1HnJ9
         3tyQPMKqedM2aAts9nCagrnc3bSZHSQXC6P/atMcu8OEGAn9hLuj6m9LvT31B7/9g7tH
         ddC4Nc99mzZlI4EtuP3eU6du5tcsFGV2voqYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s8Rp56sTOfzybD+AMzqYniwV8tPcdqGWGcUIafgdSuo=;
        b=tu4r/S2dHofFVnTfiGegXiUGL7PODe6iZ48BGzt3QNXEL5h6hJveptvdAdimGIVNom
         wo1XO42ININLiuLpyqPwFYUmvmAm0dreq1j2R0DYCv6tpitxdehrahpiBXNvhWfBBq9v
         ss2NE95wyKxxVlUbplspAv6KdVjD56vwkMKPEn15JF4uOvhtZOmK7yJcjOGzqO6PldYe
         nooEt5P/g+Be5kMwUV5SKGOJO5O6NG97SlHV4lzryCAYzjQrQmhmh5U9laRlB9yWrKQg
         zURXtoDHBUco7EpUGU5jrp3M1NlHF/IlisfCqru4yq2toK2LKb/JP61OZ5kXHkX9oowr
         YcvQ==
X-Gm-Message-State: APt69E2cEC/GuKgvB08T7MOq65vpyNUjBXmxd6fR/JvbHPrPu49nNUcO
        kCRCfTjKyYnukEd0gya3zRosI5pdkpSnuaxGZSk06Q==
X-Google-Smtp-Source: AAOMgpcgZNsFE8YYSY1AO/dYR4JsNe2LIh8rtmbHGjsJeSLy6z5OivEmh30PV9wJHWuVVBlg6VTyb/WiLkjY8C0X09M=
X-Received: by 2002:a6b:8f4e:: with SMTP id r75-v6mr609053iod.252.1530687443465;
 Tue, 03 Jul 2018 23:57:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:a785:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 23:57:23 -0700 (PDT)
In-Reply-To: <CAMty3ZCWztkM2oEaKQRVmMkA0C1V6b9Oj59DBX9XAWAybZbRAw@mail.gmail.com>
References: <CAMty3ZAMjCKv1BtLnobRZUzp=9Xu1gY5+R3Zi-JuobAJZQrXxg@mail.gmail.com>
 <20180531190659.xdp4q2cjro33aihq@pengutronix.de> <CAMty3ZCeR3uEx8oy18-Ur7ma7pciKUf_myDk6_SpWvxc6DvygQ@mail.gmail.com>
 <CAOMZO5AOpOSAx=L4tOU1Na6hm8Tex3PHNxCYDB81C0+NPHzTZQ@mail.gmail.com>
 <20180703184117.GC5611@w540> <CAMty3ZCWztkM2oEaKQRVmMkA0C1V6b9Oj59DBX9XAWAybZbRAw@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 4 Jul 2018 12:27:23 +0530
Message-ID: <CAMty3ZCLwqBs46z5TJ+rqtuWA+-ickBf94jrJpy+b-QA1pYGDw@mail.gmail.com>
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

On Wed, Jul 4, 2018 at 10:48 AM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> On Wed, Jul 4, 2018 at 12:11 AM, jacopo mondi <jacopo@jmondi.org> wrote:
>> Hi Fabio,
>>   thanks for pointing Jagan to my series, but..
>>
>> On Fri, Jun 29, 2018 at 06:46:39PM -0300, Fabio Estevam wrote:
>>> Hi Jagan,
>>>
>>> On Fri, Jun 1, 2018 at 2:19 AM, Jagan Teki <jagan@amarulasolutions.com> wrote:
>>>
>>> > I actually tried even on video0 which I forgot to post the log [4].
>>> > Now I understand I'm trying for wrong device to capture look like
>>> > video0 which is ipu1 prepenc firing kernel oops. I'm trying to debug
>>> > this and let me know if have any suggestion to look into.
>>> >
>>> > [   56.800074] imx6-mipi-csi2: LP-11 timeout, phy_state = 0x000002b0
>>> > [   57.369660] ipu1_ic_prpenc: EOF timeout
>>> > [   57.849692] ipu1_ic_prpenc: wait last EOF timeout
>>> > [   57.855703] ipu1_ic_prpenc: pipeline start failed with -110
>>>
>>> Could you please test this series from Jacopo?
>>> https://www.mail-archive.com/linux-media@vger.kernel.org/msg133191.html
>
> Will verify this on my board and let you know the result.

I have similar issue, it doesn't work.
