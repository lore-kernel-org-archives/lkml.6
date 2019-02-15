Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683BBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3548921929
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nRrFNkH4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437000AbfBOMZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 07:25:26 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46101 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733121AbfBOMZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 07:25:26 -0500
Received: by mail-ed1-f67.google.com with SMTP id f2so7761634edy.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 04:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=kaYhpM3K1lORUrG4TIL1K2D+s9nWHtiHPzXDKda8A0E=;
        b=nRrFNkH4Rf5YL6oIfpcUZxZDrnILQ/wVBi0OglfDxNwG3jevICe+YCnXBUKUIlWcLd
         C3A1rh9wOGdBpMs10ko4HdFZtAbREng0aKZp/WG/fW9BP2hsSNLOsVdpIqhyawKYAW+T
         UqSXXeU+TH+02NhJnZ6YY7WiP5G0uU9rJTO3iAKregSBEHy1F5aI7knhYPU28dR1Xbzc
         zMZTme+eZH1NwlJ/TkiBSRPyTbaEwahPugkN9FBEdSZmFFTt9Kxp/fz/kW61tNBlsTyV
         2UFidFtkZzXvFO/ia6scjaivvj6GpkZeJRtLlXBp4PH/9dZiZFGtp0yrFUzsjp6DtVnJ
         tezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=kaYhpM3K1lORUrG4TIL1K2D+s9nWHtiHPzXDKda8A0E=;
        b=VOpZW4+iHZqUSPE0pJ31DD9xLV6PRHjUtK0jOtn6LzHtOGZhi5uS640/fIwJDSZaSs
         ZTMtoA2rtGsEzChHqytQOpjG/c+xSueTwBgPl6vsgQwQB4+BmAvWBHsACuuJrXjLMs31
         iYMtB9S7HBQ9MVH1Nfz7m1E5XE9P1FpYdGQoyEawx6vArbtcSHFDkrn9p91cME7lnELU
         FOGXWpt+DgHaG4TqMopyw+AS4qZa/7czcpSWFiw9GNnzEjquguDG5y+UkSEmWqyHOdGP
         7ZkX/2R5HRWuKfjU25l53cofmmrS/Q+JyEr34JqHswiCHGu/NdGKWOKnX4fWuJCqhHQ7
         zMyA==
X-Gm-Message-State: AHQUAuby8JK+B25xUcnwQYb5RbiibzslgowaL8trX5Vb0Sgp2cxTXfZG
        LbM3RMqJ+cnLwqZVpoGEtQAp9g==
X-Google-Smtp-Source: AHgI3Ia/AePt867GBuhHiFAwymq6ydcEdV1qGEvztO6A8kE+RS2ElAgaOZuQ6A1eaTnIiBYuvDB0pg==
X-Received: by 2002:a17:906:32c7:: with SMTP id k7mr6496809ejk.180.1550233524020;
        Fri, 15 Feb 2019 04:25:24 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:2b])
        by smtp.gmail.com with ESMTPSA id c25sm512455ejx.59.2019.02.15.04.25.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 04:25:23 -0800 (PST)
References: <1550070569-18588-1-git-send-email-lollivier@baylibre.com> <1550070569-18588-5-git-send-email-lollivier@baylibre.com> <20190214100019.GA4197@Red> <20190214101212.GJ28278@localhost>
User-agent: mu4e 1.0; emacs 25.3.2
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Loys Ollivier <lollivier@baylibre.com>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/4] gnss: add driver for mediatek receivers
In-reply-to: <20190214101212.GJ28278@localhost>
Date:   Fri, 15 Feb 2019 13:25:20 +0100
Message-ID: <86d0ntfdcf.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 14 Feb 2019 at 10:12, Johan Hovold <johan@kernel.org> wrote:

> On Thu, Feb 14, 2019 at 11:00:19AM +0100, Corentin Labbe wrote:
>> On Wed, Feb 13, 2019 at 04:09:29PM +0100, Loys Ollivier wrote:
>> > Add driver for serial-connected Mediatek-based GNSS receivers.
>> > 
>> > These devices typically boot transmitting vendor specific NMEA output
>> > sequences. The serial port bit rate is read from the device tree
>> > "current-speed".
>> > 
>> > Note that the driver uses the generic GNSS serial implementation and
>> > therefore essentially only manages power abstracted into three power
>> > states: ACTIVE, STANDBY, and OFF.
>> > 
>> > For mediatek receivers with a main supply and no enable-gpios, this simply
>> > means that the main supply is disabled in STANDBY and OFF (the optional
>> > backup supply is kept enabled while the driver is bound).
>> > 
>> > Note that the timepulse-support is left unimplemented.
>> > 
>> > Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
>
>> > +static int mtk_set_active(struct gnss_serial *gserial)
>> > +{
>> > +	struct mtk_data *data = gnss_serial_get_drvdata(gserial);
>> > +	int ret;
>> > +
>> > +	ret = regulator_enable(data->vcc);
>> > +	if (ret)
>> > +		return ret;
>> > +
>> > +	return 0;
>> > +}
>> 
>> Hello
>> 
>> This could be simplified to return regulator_enable(data->vcc);
>
> Indeed, but I prefer this style which clearly separates the error path
> from the success path while making the success return value explicit.
>

It respects the coding style/standard and I prefer the original version.
It's also easier to debug if you want to add extra code on error.

>> Furthermore, after this simplification, the function seems useless.
>
> Why do you think so? You still need to retrieve the regulator from the
> driver data. Sure, this could be folded into mtk_set_power(), but that
> would be less ideal if there are more resources that need to be managed
> (e.g. an external lna supply).

I would be in favor to keep mtk_set_active. It clearly shows when the
regulator is enabled.
It also seems logic to have an enable/standby function in the driver.
Even if those are trivial (for now).

>
> Thanks,
> Johan


-- 
-L
