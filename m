Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECBBC468C6
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 08:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A2C20854
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 08:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jANj8r9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A2C20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbeGNJJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 05:09:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42947 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeGNJJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 05:09:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id e7-v6so7624645wrs.9;
        Sat, 14 Jul 2018 01:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TR5WoN4MqEoL6A/euEVgnYiCZHz4Pg9tUXjM00AjVmg=;
        b=jANj8r9/DAb2TSpGMDZYMySSL99HesZH+QDKO9AA6IW3Wg83v7jHK4/Jp6VDLlivmd
         LYKJNz65XzlHRiQGEV39bgQoLPj5tOIbr0A50IVkVc/AyqTmPYnXyQoFImoFRw/uxNJs
         N2Z7sJauY39eXVGgK4CYoXU7XbkUM/FjJmRIXdKfyBCfmCF8/q2wcKxLWI2X19jnMPQ2
         +pp++RTaUw3Thid1jzung8wm7uzScoa+P5MYmwG8Ari57FgPmfxPuidNkr0KbqQMPdbx
         CsSTlue4WV6FEmfQ+2ZZNpgoWiodJYxteEm3oq/sP0cgcM5QEZCTzlSUVaw34vXIKAcG
         lebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TR5WoN4MqEoL6A/euEVgnYiCZHz4Pg9tUXjM00AjVmg=;
        b=LanFvv/3hb0J7+kffen+HJHMZHjnMVOQ81kszXuKjrQmnLhjWNmOh76NI0EC2KFcdK
         IPEMqs+LBjc9OHKd1JZP1p4zhbbIkIBBQJDL58qVI3hwgnAdBbqajNCmB+vi1TVV8KA1
         OUdREx4ODmniPJC3W3JKqtne/uUWKBNpIut1ckfvqRFKedcF1ZuiBN6ChabT/igLgtPg
         TT54oTM6km6Yj/SZ5SuEvJxXa3ATyRnibZwjtEbdT5YUq/fvsSkANfp4uwQVhgy2gCVf
         nPAfDuGiE5xokM35EOUX6VvbgpOQEvASc5YwCCbjwNqvbImq5SXuJrH4u3deYvgTh1Lu
         salQ==
X-Gm-Message-State: AOUpUlEyOTkL3YiyM26wE7GgfbMBts/yTStXzSOB4bnHkumk7ZgivvYi
        qiwTq7FE6zfOe6OIKib6Mo3PKd2b
X-Google-Smtp-Source: AAOMgpepVEs+eXY1osPuEAoJoCtsJ5HmCKNW401MYR9zMZW6RHBJyBXNjMSOyZ+ABtNRnPCxL9UUgw==
X-Received: by 2002:adf:ec04:: with SMTP id x4-v6mr6638720wrn.245.1531558280453;
        Sat, 14 Jul 2018 01:51:20 -0700 (PDT)
Received: from localhost ([195.46.23.67])
        by smtp.gmail.com with ESMTPSA id x7-v6sm11006922wre.94.2018.07.14.01.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Jul 2018 01:51:19 -0700 (PDT)
Date:   Wed, 4 Jul 2018 16:21:58 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        mylene.josserand@free-electrons.com,
        thomas.petazzoni@free-electrons.com,
        maxime.ripard@free-electrons.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 0/2] Input: Add Cypress Gen5 Touchscreen driver
Message-ID: <20180704162158.euiw2v3hyv3hzofn@penguin>
References: <20180703094309.18514-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180703094309.18514-1-mylene.josserand@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mylène,

On Tue, Jul 03, 2018 at 11:43:07AM +0200, Mylène Josserand wrote:
> Hello,
> 
> Here is a V6 series to add the driver of the touchscreen Cypress,
> TrueTouch Generation 5.
> Based on v4.18-rc3.
> 
> This patch series has already been posted in several iterations:
>     - v1: Sent on 2017/05/29
>     - v2: Sent on 2017/08/18
>     - v3: Sent on 2017/09/27
>     - v4: Sent on 2017/12/01
>     - v5: Sent on 2017/12/20
> 
> I did not have any comments the last 4 versions.
> And no reviews on my v5 during 6 months. Could I have any updates
> or feedback on my series to know why it is not merged (to be able to
> correct what is wrong)?

Sorry, I must have missed the v5, sorry about that.

I probably asked this question before, but just to make sure - I see
references to HID in the patch - the device is really not HID
compatible? Is there any hope it could be made work with i2c-hid +
hid-multitouch?

Thanks.

-- 
Dmitry
