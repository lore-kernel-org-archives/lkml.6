Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2BEC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A5F2064C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJxIJVGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A5F2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeJ2Bhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 21:37:48 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44041 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeJ2Bhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 21:37:48 -0400
Received: by mail-qk1-f196.google.com with SMTP id n12so3536046qkh.11;
        Sun, 28 Oct 2018 09:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0Ob1SxHjZHBVGMX0NNAPJL0siXAyvQsxoYjE1n3y6AU=;
        b=AJxIJVGpA3iA0CKfJUuVsYmRlXJ8pJaxO8tMmoriDig6TWitEdDw5iCqxumscmL4i6
         SAovwbPzlVghggVVs9gD6PhAYC4S2YCfQHZqUu54UqpWZdAXjFcLbNDuMdjkdx+wrZ1W
         Lp+LA7CXW7DWJnrEnm29vTpnOE4V94UmjMOgSKTdbmxJUfl4LT28zmxZlotey2C5lR+N
         QElIgn2pBCQ+pzqs18EOeYUdKJ742CdzRjyCwIfOtwo+QmPBgOwPDZVBVlHqhMdb3c3m
         LKIEPmUTa06d2Nr5ZUnXGGsJ98Fsb7mbj4S9Ov8vTueoL5PmAKF/Dz9b6CCZqjZWsugy
         dU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Ob1SxHjZHBVGMX0NNAPJL0siXAyvQsxoYjE1n3y6AU=;
        b=N1aOyqWZWranVcARw9LTGxR38AD729D/xyo0POn8L0kViyg6B82T/frqg/OvBCo5Ye
         az000w692TgtHbgM8EnJycirZJP9WX7uuZm7wFc/J3I2zcNxNgrcNFdhlcXD4CvZOnfw
         gh/CNIRcsdFNRwiuWg4PztdOh1GTt/xlN3E5DDhEwgwS3m1yo4efJpboMfhJ6gD+9X6s
         Sdx7nR0oZQeYFav1LNPzSQy48zK7v+X7zaE1lbSEJtdfvRQeWt/Q9Ve8wWSfk7mBFo0y
         UAMRseFiEL7qYOHtriXn9N6V5CPuaMuM7kfOpcBrgNa5wT5DpRUM05JjJYkrwNMQv/NV
         8pHw==
X-Gm-Message-State: AGRZ1gLCOo9JHrm/+llQ2z2bYU4ucEXaSuxDemV8p6LuxKE4wudTiZ55
        E3b212vzK4GZro/S7EQdQlQ=
X-Google-Smtp-Source: AJdET5ckra0naG+JoJJaZUAn3xydQ6IXMqSAXuMhajAlaTZrbRCwGNz8zMwGtSKHnGNOVg4pEWX3oQ==
X-Received: by 2002:a37:62d3:: with SMTP id w202mr4641645qkb.357.1540745558129;
        Sun, 28 Oct 2018 09:52:38 -0700 (PDT)
Received: from renatolg ([186.220.2.26])
        by smtp.gmail.com with ESMTPSA id m188-v6sm4934000qkb.24.2018.10.28.09.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 09:52:37 -0700 (PDT)
From:   Renato Lui Geh <renatogeh@gmail.com>
X-Google-Original-From: Renato Lui Geh <renatogeh@renatolg>
Date:   Sun, 28 Oct 2018 13:52:32 -0300
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Renato Lui Geh <renatogeh@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, alexandru.Ardelean@analog.com,
        stefan.popa@analog.com, giuliano.belinassi@usp.br,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 1/2] staging: iio: ad7780: update voltage on read
Message-ID: <20181028165231.2det3cq3u7r6qoxj@renatolg>
References: <cover.1540506298.git.renatogeh@gmail.com>
 <1f7b2c6ee0e18b1c43a8b27f482b08313c52d4e9.1540506298.git.renatogeh@gmail.com>
 <20181028155611.67abeafb@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20181028155611.67abeafb@archlinux>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Thank you for the review.

>> +		voltage_uv = regulator_get_voltage(st->reg);
>> +		if (voltage_uv)
>> +			st->int_vref_mv = voltage_uv/1000;
>>  		*val = st->int_vref_mv * st->gain;
>Is there actually a reason (now) to have the stashed value
>of int_vref_mv in the state structure?

From probe:

if (voltage_uv)
	st->int_vref_mv = voltage_uv / 1000;
else
	dev_warn(&spi->dev, "Reference voltage unspecified\n");

So the idea was to, when voltage_uv = 0, return the previous voltage.
Should I instead handle this as an error the same way as in probe?

Thanks,
Renato
