Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEA8C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BCA218A3
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ln75HulD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbfAGQWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:22:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44300 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbfAGQWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:22:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so998104wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 08:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=2cCUr7PlaXmiRjtgfpz3Nae1G4BEEyhXg8rSKqZZ88E=;
        b=Ln75HulD8kMo5118jQgIXCZQlJUcI3zzOfGV84h9A+YsQGyAuRom1MI3NByIeZOEbx
         I8CYyid/j/wWWwAlfA7uGvHTXdmzU/AZPcljWcOSJj88jTak20ZGXSFwqS7CCf2fIJpl
         IjXL74DmjHKYgfuffzbNbk3mFjArmI8lpYLF5G3KHMiJLqyjCWqChh1BMyR/6ioqQNJm
         H1nT5DZZC7dyPQh5PUioBLtOOocZvDk634WZjHOm+5m1XTnQPXl4lqrRzsR3LX4++jGA
         EXTHsdOU8V/uswf4btvMnxZrNjoUBUHEUd/oDaGunuQ9Rjs61VUWC8k4lcUxdMtxeA+d
         a7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=2cCUr7PlaXmiRjtgfpz3Nae1G4BEEyhXg8rSKqZZ88E=;
        b=ZuNfXbzIzyH2DQooNiNc7Ag3x0ZUOTwvD/wiKTGtCLjm9B+GAWC1u0qEoX6cirhDSA
         AQarDf/knjGA8JIIj1YsAfuVUgwI4BSC344laCOpX4kDrukdBDJY/yaD04j/lpxlZvnN
         IQbua6ce+LI1E1eg3rbXtxPvta85qEP239B3Fr5VKpEGYW3mW0y5ymLzTs8EexGboq5P
         hIUFuynjaifP49jsxEafEFVKqAsbqRIBpPqRKcvJN4du4WCJeDftPcru2of3bb8bjoI2
         RetynsYmSTelPXf/CpWGuU5qGKjpdYnSIy6P3UZj/p2RRc327njV2uhmZ5Ch2kdg8fn8
         Qz7Q==
X-Gm-Message-State: AJcUukdjWVoX9fpBx8Cf1uYrgz+9nb7pioFPzujmzTxLxVxQBd5iAD/f
        F7WhagbGgHQHBY+euaIYGVIiVw==
X-Google-Smtp-Source: ALg8bN6Xo4Re/va2IqW4tTrg+DLn7mq9r7Vs2LxOISxe2uenpNQHJZSwLoa0ZCbXvWIA4iKPOPiOKw==
X-Received: by 2002:a5d:6105:: with SMTP id v5mr50787171wrt.63.1546878120518;
        Mon, 07 Jan 2019 08:22:00 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:9696])
        by smtp.gmail.com with ESMTPSA id y185sm6216760wmg.34.2019.01.07.08.21.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 08:21:59 -0800 (PST)
References: <1545994235-8309-1-git-send-email-lollivier@baylibre.com> <86bm4x6830.fsf@baylibre.com> <20190104091937.GA4737@localhost>
User-agent: mu4e 1.0; emacs 25.3.2
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Loys Ollivier <lollivier@baylibre.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/4] Add driver for globaltop GNSS receivers
In-reply-to: <20190104091937.GA4737@localhost>
Date:   Mon, 07 Jan 2019 17:21:58 +0100
Message-ID: <86ftu41lqx.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 04 Jan 2019 at 09:19, Johan Hovold wrote:

> On Thu, Jan 03, 2019 at 05:04:35PM +0100, Loys Ollivier wrote:
>> 
>> As suggested by Neil Armstrong - this GNSS device seems to behave like
>> most generic GNSS receivers.
>> I'll send a v2 with a generic driver that works for both GlobalTop and
>> u-blox.
>
> That doesn't sound right to me. Judging from a quick look, this device
> appears to be based on a mediatek chipset, so I suggest reworking
> (renaming) this as a Mediatek driver (gnss type would be MTK, reflecting
> the vendor protocol) even if it happens to look a lot like the current
> u-blox driver.
>
OK, agreed - will rename the driver as Mediatek.
Would you recommend keeping any reference to Globaltop ? Such as in the
devicetree gnss bindings.
Or only keep "mediatek,mt3339" for any solution based on that chipset.
> If we ever add more features, like support for some part of the vendor
> protocol or maybe 1pps, things will start diverging. As you noticed you
> already have the generic serial gnss implementation to handle a lot of
> the common bits.
Yes, I would like indeed to look into 1pps after that patch series.
>
>> Loys Ollivier writes:
>> 
>> > Hello !
>> >
>> > This patch series adds a new GNSS driver for the globaltop GNSS
>> > receivers.  These receivers transmits NMEA output sequence as soon
>> > as they have booted.  Power management can be done via the main
>> > supply and optional backup supply as defined in the device tree.
>> >
>> > The driver has been tested using a GlobalTop pa6h chipset on a
>> > Libretech-cc board using the expansion header. Changes made in the
>> > board device tree can be found below for reference and testing.
>
> Thanks,
> Johan

Will send a v2.

-- 
-L
