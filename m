Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C129C71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6246320895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6246320895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeJMVIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 17:08:12 -0400
Received: from gateway30.websitewelcome.com ([50.116.127.1]:13578 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726255AbeJMVIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 17:08:12 -0400
X-Greylist: delayed 1369 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Oct 2018 17:08:11 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 2F5AE12D14
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 08:08:17 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id BJeTgSJUVaSeyBJeTgnikw; Sat, 13 Oct 2018 08:08:17 -0500
X-Authority-Reason: nr=8
Received: from lputeaux-656-1-34-183.w80-15.abo.wanadoo.fr ([80.15.51.183]:40388 helo=[10.88.108.42])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gBJeS-000n8L-DK; Sat, 13 Oct 2018 08:08:16 -0500
To:     Jonathan Cameron <jic23@kernel.org>, Peter Rosin <peda@axentia.se>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181008173528.GA31787@embeddedor.com>
 <ded46d23-0ec9-3fc8-3fc2-fa8003639272@axentia.se>
 <20181013133831.7dbd31e8@archlinux>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Subject: Re: [PATCH] iio: dpot-dac: mark expected switch fall-through
Message-ID: <1f64449a-ef19-20c8-f8cb-7e629f8fe71b@embeddedor.com>
Date:   Sat, 13 Oct 2018 15:08:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181013133831.7dbd31e8@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 80.15.51.183
X-Source-L: No
X-Exim-ID: 1gBJeS-000n8L-DK
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: lputeaux-656-1-34-183.w80-15.abo.wanadoo.fr ([10.88.108.42]) [80.15.51.183]:40388
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/18 2:38 PM, Jonathan Cameron wrote:
> On Mon, 8 Oct 2018 20:42:41 +0000
> Peter Rosin <peda@axentia.se> wrote:
> 
>> On 2018-10-08 19:35, Gustavo A. R. Silva wrote:
>>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>>> where we are expecting to fall through.  
>>
>> The way I see it, it is pretty well marked up as is. So, this paragraph
>> is not describing the change.
>>
>>>
>>> Notice that in this particular case, I replaced "...and fall through."
>>> with a proper "fall through", which is what GCC is expecting to find.  
>>
>> What is not "proper" about the existing comment? Yes yes, I *know* that
>> GCC is not very intelligent about it and requires hand-holding, but
>> blaming the existing comment for not *properly* marking an intentional
>> fall through is ... rich.
>>
>>>
>>> Addresses-Coverity-ID: 1462408 ("Missing break in switch")
>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>> ---
>>>  drivers/iio/dac/dpot-dac.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iio/dac/dpot-dac.c b/drivers/iio/dac/dpot-dac.c
>>> index a791d0a..e353946 100644
>>> --- a/drivers/iio/dac/dpot-dac.c
>>> +++ b/drivers/iio/dac/dpot-dac.c
>>> @@ -78,7 +78,7 @@ static int dpot_dac_read_raw(struct iio_dev *indio_dev,  
>>
>> Adding some more context here.
>>
>> 		case IIO_VAL_INT:
>> 			/*
>> 			 * Convert integer scale to fractional scale by
>> 			 * setting the denominator (val2) to one...
>>>  			 */
>>>  			*val2 = 1;
>>>  			ret = IIO_VAL_FRACTIONAL;
>>> -			/* ...and fall through. */
>>> +			/* fall through */
>>>  		case IIO_VAL_FRACTIONAL:
>>>  			*val *= regulator_get_voltage(dac->vref) / 1000;
>>>  			*val2 *= dac->max_ohms;
>>>   
>>
>> Considering the above added context, I have to say that this mindless
>> change is not an improvement, as you have just destroyed the continued
>> sentence from the previous comment. You must have noticed that this
>> was the end of a continued sentence, as you even quoted it in the commit
>> message. The big question is why you did not stop to think and consider
>> the context?
>>
>> Yes, I'm annoyed by mindless changes. Especially mindless changes aimed
>> at improving readability while in fact making things less readable.
>>
>> TL;DR, if you are desperate to fix "the problem" with this fall through
>> comment, please do so in a way that preserves overall readability. And
>> it would be nice to not blame the existing code for brain damage in GCC
>> and various other static analyzers.
>>
>> Cheers,
>> Peter
> I agree with you in principle Peter and have tweaked the patch description
> to make it clearer that we are doing this to make GCC static analysis more
> helpful (suppressing a false warning is a worthwhile if you are dealing with
> lots of them).
> 
> However, nice though it is to have elegant comment structure I think we
> should still have this patch in place.  This effort to 'fix' these
> warnings has already identified a few places where it was wrong so
> I'm keen to see it applied by default even if it isn't perfect.
> 

Thanks, Jonathan. Below are some examples of cases in which the fall-through
warning turned out to be an actual bug:

commit c24bfa8f21b59283580043dada19a6e943b6e426
commit ad0eaee6195db1db1749dd46b9e6f4466793d178
commit 9ba8376ce1e2cbf4ce44f7e4bee1d0648e10d594
commit dc586a60a11d0260308db1bebe788ad8973e2729
commit a8e9b186f153a44690ad0363a56716e7077ad28c
commit 4e57562b4846e42cd1c2e556f0ece18c1154e116
commit 7c92e5fbf4dac0dd4dd41a0383adc54f16f403e2
commit c5b974bee9d2ceae4c441ae5a01e498c2674e100
commit 2c930e3d0aed1505e86e0928d323df5027817740
commit 882518debc8487147d618d5f26f4bb0bea1cc05b
commit f745e9cc7e40c4570ab5e8d5ef32bfaa6e8ced46
commit 5dc874252faa818426480a7c00fa05738fe05402
commit 4a00aa057759d713e1296ecbc614fa560d569977
commit 6d3f06a0042ebd59a5e9d4ba6e8a85596901e140
commit 827d240a232d27cc12e9657d012f2e5ba953e98a
commit a28b259b43914b04746184cec318c67bded7234c
commit 9e7b319e1d1e6cba41ae96f791789a7806b29584
commit d393be3ed0bebb30a4666d7f5ed4486cd6b31716
commit 680682d4d537565e2c358483e1feeca30a8cf3d4
commit 06af9b0f4949b85b20107e6d75f5eba15111d220

So, yeah. This effort is worth it.

Thanks
--
Gustavo
