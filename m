Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F5AC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 12:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA46A21522
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 12:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA46A21522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbeIVSpB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 14:45:01 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:40590 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbeIVSpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 14:45:01 -0400
Received: from [10.145.248.251] (82-132-247-97.dab.02.net [82.132.247.97])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id A78299E7639;
        Sat, 22 Sep 2018 13:51:29 +0100 (BST)
Date:   Sat, 22 Sep 2018 13:51:22 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20180922114849.GA3890@himanshu-Vostro-3559>
References: <1537447238-18674-2-git-send-email-eugen.hristev@microchip.com> <201809211544.zop1vk8B%fengguang.wu@intel.com> <20180922113616.2d849fb0@archlinux> <20180922114849.GA3890@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 2/2] iio: adc: at91: fix wrong channel number in triggered buffer mode
To:     Himanshu Jha <himanshujha199640@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Eugen Hristev <eugen.hristev@microchip.com>,
        ludovic.desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, nicolas.ferre@microchip.com,
        Maxime Ripard <maxime.ripard@bootlin.com>
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <83D84516-8721-4712-B24B-7B1199FAFCC4@jic23.retrosnub.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22 September 2018 12:48:49 BST, Himanshu Jha <himanshujha199640@gmail.com> wrote:
>On Sat, Sep 22, 2018 at 11:36:16AM +0100, Jonathan Cameron wrote:
>> On Fri, 21 Sep 2018 15:26:03 +0800
>> kbuild test robot <lkp@intel.com> wrote:
>> 
>> > Hi Eugen,
>> This one is leaving me stumped...
>> 
>> Anyone care to point out what I'm missing that is wrong here?
>> 
>> Also Eugen, please don't cc stable on a patch directly.  It is fine
>to send
>> a backport request once a patch has hit mainline, but before that
>it's just
>> adding noise to a list as they won't take it directly anyway.
>
>Song is correct on this one.
>
>So, just replace the declaration to:
>
>	struct iio_chan_spec const *chan;
>
>and then warning goes away...

Good point. Not enough coffee this morning..

Obvious now :)
>
>Another thing, its better not to reply the automated bot and instead to
>the author by changing "From" address. :)
>
>That is what I do often when replying to that thread.
>
>https://lore.kernel.org/lkml/20180921182616.GA2077@himanshu-Vostro-3559/
>
>And it nests properly in the given thread avoiding any noise to kbuild
>bot.



-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
