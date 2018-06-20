Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D268C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F4C20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F4C20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754069AbeFTEp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:45:29 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50545 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeFTEp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:45:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id e16-v6so3686554wmd.0;
        Tue, 19 Jun 2018 21:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qhGeovMExrkRCSSumA01oeA+do1nOFbiBwg8XwyIbNY=;
        b=uZ4fYqj9kHRjl2SjY4K+O13kNRrXOlg/oQyy/p3RH2/pdrPPN/MR4C5ycN1uJ2VZTT
         j8aUje1sk7YXlMh8sVXnvAOGOhz6NcwOGuUV6TfbLKu37cnWojlJdJZl0iJi1Cd+sKMN
         c594HzxvrJ62rBRxPV0RoWfwFgFKhL0+r/HmojgRQ1ouJxhtQEfR37VmRzs83LG6V2BL
         RHhEuwBsT+F0hXrvz/yNO8o6ePRk3ecpHajL48PdfiuFIPk0ChvMQvy9VbyfMIlxoOR7
         raGETXP1gDrfBs4r3M95OUuNFRMM3jFjEdA2xYIvdkrLCI898ThlVSwQrKvyoQCOZQ+3
         +feQ==
X-Gm-Message-State: APt69E24qW37gY+UyyPMONiCdfqwKpHeZPSXiYGn8fbSJYoOGT1Mvi9j
        lLmrWMUx4+fuPdSabzXogwGuEOvsja8=
X-Google-Smtp-Source: ADUXVKJaMU/RqSq4d9x5M4ehJ20uov2wXxE9fsft4cZCD4HeuiI+Tzx2hoCUkEe7bKXthhEyEqu9fQ==
X-Received: by 2002:a50:9818:: with SMTP id g24-v6mr16773188edb.31.1529469924733;
        Tue, 19 Jun 2018 21:45:24 -0700 (PDT)
Received: from mail-wr0-f174.google.com (mail-wr0-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id v37-v6sm692796edm.0.2018.06.19.21.45.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 21:45:24 -0700 (PDT)
Received: by mail-wr0-f174.google.com with SMTP id l8-v6so189370wrr.2;
        Tue, 19 Jun 2018 21:45:23 -0700 (PDT)
X-Received: by 2002:adf:ae09:: with SMTP id x9-v6mr16198062wrc.19.1529469923783;
 Tue, 19 Jun 2018 21:45:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a158:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 21:45:03
 -0700 (PDT)
In-Reply-To: <20180530091934.tbd6xbyr5s3ipn3v@paasikivi.fi.intel.com>
References: <20180517090224.u3ygdzjr77im2mmp@flea> <20180529095757.qkz7jyuxza7movbc@flea.home>
 <20180530091934.tbd6xbyr5s3ipn3v@paasikivi.fi.intel.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 20 Jun 2018 12:45:03 +0800
X-Gmail-Original-Message-ID: <CAGb2v67RP8bjObBJu_1JsREUo64hnEzptG_n-aYMn4Dcd_Zo-g@mail.gmail.com>
Message-ID: <CAGb2v67RP8bjObBJu_1JsREUo64hnEzptG_n-aYMn4Dcd_Zo-g@mail.gmail.com>
Subject: Re: [PATCH v10 0/2] Initial Allwinner V3s CSI Support
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Yong Deng <yong.deng@magewell.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Thierry Reding <treding@nvidia.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 5:19 PM, Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
> On Tue, May 29, 2018 at 11:57:57AM +0200, Maxime Ripard wrote:
>> On Thu, May 17, 2018 at 11:02:24AM +0200, Maxime Ripard wrote:
>> > On Fri, May 04, 2018 at 02:44:08PM +0800, Yong Deng wrote:
>> > > This patchset add initial support for Allwinner V3s CSI.
>> > >
>> > > Allwinner V3s SoC features two CSI module. CSI0 is used for MIPI CSI-2
>> > > interface and CSI1 is used for parallel interface. This is not
>> > > documented in datasheet but by test and guess.
>> > >
>> > > This patchset implement a v4l2 framework driver and add a binding
>> > > documentation for it.
>> > >
>> > > Currently, the driver only support the parallel interface. And has been
>> > > tested with a BT1120 signal which generating from FPGA. The following
>> > > fetures are not support with this patchset:
>> > >   - ISP
>> > >   - MIPI-CSI2
>> > >   - Master clock for camera sensor
>> > >   - Power regulator for the front end IC
>> >
>> > I tested it on my H3 with a parallel camera, and it still works. Thanks!
>> >
>> > Hans, Sakari, any chance this might land in 4.18?
>>
>> Ping?
>
> I'll try to look into this soonish but it seems to be too late for 4.18.
> Sorry about that.

Can we get this into 4.19?

Thanks
ChenYu
