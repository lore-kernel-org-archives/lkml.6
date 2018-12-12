Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7042EC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F70E2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F70E2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbeLLLFl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:05:41 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:42360 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbeLLLFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:05:39 -0500
Received: from [10.202.226.243] (unknown [185.176.76.27])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id EB43C9E74BE;
        Wed, 12 Dec 2018 11:05:36 +0000 (GMT)
Date:   Wed, 12 Dec 2018 11:05:26 +0000
User-Agent: K-9 Mail for Android
In-Reply-To: <20181212083132.GJ3116@kadam>
References: <20181212005503.28054-1-jeremyfertic@gmail.com> <20181212005503.28054-11-jeremyfertic@gmail.com> <20181212083132.GJ3116@kadam>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 10/11] staging: iio: adt7316: change interpretation of write to dac update mode
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jeremy Fertic <jeremyfertic@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>, devel@driverdev.osuosl.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <B4C0AE27-E400-471D-88F5-703B5A994146@jic23.retrosnub.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12 December 2018 08:31:32 GMT, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>On Tue, Dec 11, 2018 at 05:55:02PM -0700, Jeremy Fertic wrote:
>> Based on the output of adt7316_show_all_DAC_update_modes() and
>> adt7316_show_DAC_update_mode(), adt7316_store_DAC_update_mode()
>should
>> expect the user to enter an integer input from 0 to 3. The user input
>is
>> currently expected to account for the actual bit positions in the
>register.
>> For example, choosing option 3 would require a write of 0x30
>(actually 48
>> since it expects base 10). To address this inconsistency, create a
>shift
>> macro to be used in the valid input check as well as the calculation
>for
>> the register write.
>> 
>> Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
>> ---
>> I'm not sure if this patch is appropriate since it's making a user
>visible
>> change. I've included it since the driver is still in staging.
>
>We don't want to break user space, but I agree with you that applying
>this patch is probably the right thing.
>
>regards,
>dan carpenter

This driver breaks the standard abi in loads of ways. It is going to change userspace interface
 a lot before it is ready to move out of staging. That includes this particular interface almost
 certainly being completely replaced.  Hence good to move towards something sensible.  Don't worry at all
 about userapace ABI breaks in this one!

Jonathan

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
