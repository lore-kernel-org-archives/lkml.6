Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18369C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AD8214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="EtpFfkfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfBTQs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:48:56 -0500
Received: from vern.gendns.com ([98.142.107.122]:32778 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbfBTQsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IkoDWKsx69eeASFUk0VZnoFbek30b+h9rUbZRZVnz7w=; b=EtpFfkfAnoGL4Wq7oN6KzSxwGW
        2u7OVwiKyHeL9vQ3gecF2zZJnSX/t/+1LlhDSNv0t5+uvmWjGBkf/IGOdMvjaIfKugDxQdLDaRlBt
        hpgd4PbARhBw0OvpMJ5NzEtnwnblCkloeNiQGkkZbtWzwA3Ml87KksPlumXNLmQFBM/RmjacPWMzS
        BtOREBxbcrkA8LYk6b9znqrktT4y8jHk1HdUkbnUuFtYDb6xxQnvci+D3g35DTycd06diQFuEgo7X
        lFepsxEV1Cs/DvqqGeKnU7Cf3ulUbUkVJEwoa1Fdu50KwtLBtNQr2neytb2Elx/HUi1AgFc2e1PG+
        s/FY/kKQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:36472 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gwV2w-0001Hi-HB; Wed, 20 Feb 2019 11:48:34 -0500
Subject: Re: [PATCH v3] iio: adc: ti-ads7950: add GPIO support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     justinpopo6@gmail.com, linux-iio@vger.kernel.org,
        linux-gpio@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        f.fainelli@gmail.com, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org
References: <1550030242-5241-1-git-send-email-justinpopo6@gmail.com>
 <9e0a8a08-9636-906b-08cf-d99947d6f51a@lechnology.com>
 <20190220120021.65c91b83@archlinux>
From:   David Lechner <david@lechnology.com>
Message-ID: <96ec33f3-6e58-325f-9c55-4f1a92f635f7@lechnology.com>
Date:   Wed, 20 Feb 2019 10:48:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190220120021.65c91b83@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/19 6:00 AM, Jonathan Cameron wrote:
> On Wed, 13 Feb 2019 09:10:53 +0100
> David Lechner <david@lechnology.com> wrote:
> 
>> On 2/12/19 9:57 PM, justinpopo6@gmail.com wrote:
>>> From: Justin Chen <justinpopo6@gmail.com>
>>>
>>> The ADS79XX has GPIO pins that can be used. Add support for the GPIO
>>> pins using the GPIO chip framework.
>>>
>>> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
>>> ---
>>
>> It will be better to split this up into two patches[1]. One to replace
>> all uses of indio_dev->mlock with the new local lock and then another to
>> add GPIO support.
>>
>> How are you using/testing this patch? Do we need device tree bindings?
>>
>> It will also help reviewers if you add a note about what you changed in
>> each revision of the patch when you resubmit. The usual way to do this
>> is something like:
>>
>>       v3 changes:
>>
>>       - Fixed unlocking mutex too many times in ti_ads7950_init_gpio()
>>
>> It also is nice to wait a few days at least before submitting the next
>> revision to give people some time to respond.
> 
> Agreed with all comments except the endian one.
> SPI doesn't define an endianness of data on the wire, so we may need
> to convert to match whatever ordering the ti chip expects.
> I would expect things to be thoroughly broken if we remove those
> conversions - particularly as I doubt this is being tested with a
> big endian host!
> 
> Jonathan

I'm a bit confused then. I got this idea from include/linux/spi.h, which
says:

  * In-memory data values are always in native CPU byte order, translated
  * from the wire byte order (big-endian except with SPI_LSB_FIRST).  So
  * for example when bits_per_word is sixteen, buffers are 2N bytes long
  * (@len = 2N) and hold N sixteen bit words in CPU byte order.


And in the most recent patches to the ti-ads7950 driver where we switched
from 8-bit words to 16-bit words, I had to remove the calls to cpu_to_be16()
to keep things working.

I realize that I am only using one SPI controller, so I may be making a bad
assumption here, but it seems to me that it is up to the SPI controller to
make sure the bits get sent over the wire in the correct order and we
shouldn't have to worry about it here. We are implicitly telling the SPI
controller that we need big-endian over the wire by omitting the SPI_LSB_FIRST
flag here:

	spi->bits_per_word = 16;
	spi->mode |= SPI_CS_WORD;
	ret = spi_setup(spi);

