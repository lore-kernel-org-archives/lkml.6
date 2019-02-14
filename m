Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5B3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5A021B18
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438317AbfBNV4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:56:18 -0500
Received: from smtprelay08.ispgateway.de ([134.119.228.98]:11747 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438056AbfBNV4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:56:17 -0500
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Feb 2019 16:56:16 EST
Received: from [77.22.253.72] (helo=[192.168.1.154])
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <jan@schnhrr.de>)
        id 1guOrr-0006wI-Ft; Thu, 14 Feb 2019 22:48:27 +0100
Subject: Re: [PATCH 1/2] x86/tsc: Allow quick PIT calibration despite
 interruptions
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     bp@alien8.de, mingo@redhat.com, x86@kernel.org,
        pmenzel@molgen.mpg.de, Thomas.Lendacky@amd.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
References: <20190129102329.27610-1-jan@schnhrr.de>
 <20190129102329.27610-2-jan@schnhrr.de> <5C50558B.8060405@schnhrr.de>
 <alpine.DEB.2.21.1901292327090.1950@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1902121257400.3710@nanos.tec.linutronix.de>
From:   =?UTF-8?Q?Jan_H=2e_Sch=c3=b6nherr?= <jan@schnhrr.de>
Message-ID: <993ab528-c06f-607c-438d-ec11b47427bf@schnhrr.de>
Date:   Thu, 14 Feb 2019 22:48:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902121257400.3710@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Df-Sender: am5Ac2Nobmhyci5kZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 12.02.19 um 12:57 schrieb Thomas Gleixner:
> On Tue, 29 Jan 2019, Thomas Gleixner wrote:
>> On Tue, 29 Jan 2019, Jan H. Schönherr wrote:
>>
>>> Am 29.01.2019 um 11:23 schrieb Jan H. Schönherr:
>>>> +calibrate:
>>>> +	/*
>>>> +	 * Extrapolate the error and fail fast if the error will
>>>> +	 * never be below 500 ppm.
>>>> +	 */
>>>> +	if (d1 + d1 >= (delta * MAX_QUICK_PIT_ITERATIONS) >> 11) {
>>>> +		pr_info("Fast TSC calibration failed (wouldn't work)\n");
>>>> +		return 0;
>>>> +	}
>>>
>>> I messed this check up. "delta" is not the actual tsc delta between the
>>> first two successful reads at this point.
>>>
>>> (If it were, it might also correspond to more than one iteration; not
>>> sure if we care about that aspect, though.)
>>
>> I rather go for correct and if only for the reason that me/you/whoelse
>> doesn't have to scratch the head for an hour when looking at this half a
>> year from now.
> 
> Any update on this?

Second version is out.

Regards
Jan
