Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98BFECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999142080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999142080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbeKAB0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:26:45 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:47720 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbeKAB0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:26:45 -0400
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:58960 helo=[192.168.10.175])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gHtLc-0007vN-3f; Wed, 31 Oct 2018 17:28:00 +0100
Subject: Re: [PATCH 0/3] drm: tinydrm driver for adafruit PiTFT 3.5"
 touchscreen
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <20181024184313.2967-1-eric@anholt.net>
 <87h8harnv4.fsf@anholt.net>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <0566ac0e-6060-6b46-b75a-32c63ef9dbe2@tronnes.org>
Date:   Wed, 31 Oct 2018 17:27:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87h8harnv4.fsf@anholt.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 25.10.2018 18.29, skrev Eric Anholt:
> Eric Anholt <eric@anholt.net> writes:
>
>> I was going to start working on making the vc4 driver work with
>> tinydrm panels, but it turned out tinydrm didn't have the panel I had
>> previously bought.  So, last night I ported the fbtft staging
>> driver over to DRM.
>>
>> It seems to work (with DT at
>> https://github.com/anholt/linux/commits/drm-misc-next-hx8357d) --
>> fbdev works great including rotated, and so does modetest.  However,
>> when X11 comes up at 16bpp, I get:
>>
>> https://photos.app.goo.gl/8tuhzPFFoDGamEfk8
>>
>> If I have tinydrm set a preferred bpp of 24, X looks great.  Noralf,
>> any ideas?
> Also, with these patches and the format modifier patch I just sent, mesa
> with vc4 is now working with this driver on this branch:
>
> https://gitlab.freedesktop.org/anholt/mesa/commits/kmsro
>
> Now I wonder how we can improve performance of the SPI updates.

I just remembered that tinydrm does a full flush on page flips. And if
the dirtyfb ioctl is also used you end up with two flushes. This could
explain bad performance. I have been waiting for the dirtyfb through
atomic work to come to fruition, but nothing merged yet. That would give
dirty tracking on page flips.

Noralf.

