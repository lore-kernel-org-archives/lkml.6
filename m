Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F386C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7CE2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbfBLOzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:55:17 -0500
Received: from mout.gmx.net ([212.227.15.18]:33415 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730534AbfBLOzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:55:15 -0500
Received: from [10.0.0.4] ([113.116.50.220]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LwaMR-1h9amx0Ru3-018Lcx; Tue, 12
 Feb 2019 15:55:08 +0100
Subject: Re: [PATCH] mei: expand minor range when registering chrdev region
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tomas.winkler@intel.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
References: <20190212060252.8948-1-cgxu519@gmx.com>
 <20190212092902.GD27450@kroah.com>
From:   cgxu519 <cgxu519@gmx.com>
Message-ID: <03e93235-9fc8-dbc5-49e4-45be8e715398@gmx.com>
Date:   Tue, 12 Feb 2019 22:55:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212092902.GD27450@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:AIrixuBjTVkp14BkG/iQ6wUjF6Bn4jUQ7Q6JQtO0Id7wo4fD5c6
 NBWgvq/FpkVVpYOjjRvdbSn/rnAhCSTMd4KGuIiVLjHkQ0BKmIXq+UC0v28LjFRrsFTSy5B
 uKwmRka9NcCWydRMw2dkB/GdybpLg9QB5/0lfsHtIqOpexcPgVO89NuUv62e65EN5ePjqsW
 PH5nUTGXEWr1MLG0BRfdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2cGxVbKRY5c=:ZWR4rpNyX8BxtGKooyy1Qr
 Sh7qf4Haw97/UuttTCgd1qiyxbP00OZRWa+tF/F57X0KXYRpm2m72t6uaFyMKvubOOahPB1Qw
 w86AuX+iMOQuV8cRMewJcd6UXXtkLtH20+g68uIZJ8epbmRHUSUT7PMc0WCGt9K5QbPeTqP4d
 LZ900w9bWKtkV6o/3AbVVtERH9rYQ5phA4q0e8UbyVhAJjbqRMtZKXJS125YDZ78wttugmvuk
 LCUI2paU2cPzQwVQozW/hEGxv5l+QLXx6veYWC4XN/EpXaNd2biOiDjswvcHFjxOOtAe6VSCO
 hpyMwhYmyzcaMBsGZSyS53rkeqBufhctbmASGez45x4SBiNgvO8gIZ3H8mGEV6m6yyMqgixdF
 Q/3YBlxyWvnmulFfJNLEWTNbjm9Yz95oxD1qky3IuGKK+lYxRquCb1n9s3Fmq9W+Xd0x2cV1w
 SwpI0birPeNDjZZZXysxlXu43RfHMF8znXvDEDPP6h5nbg1OW2Wj6DtX4eJaTVzwfaJXlWUcp
 KxRvz0XrblFB253QQdsrWUZqf7ekL/qs/tVoe5n+j8lLhFhS9CzMJG/b6zmVtyDbi4c2TeIoz
 qn2i/8yPGxfAN/aBvCOcjC1eecNRFFyG/DSQJZZybwCWiPLRw4g/5VwXiPGEnjCXyzXf1Y+LP
 GmegrT7iBu91/dq5GRSXrPXO1szuA9ksZz+xzSApLtelMBocLhssVgo94OVIudNHMXNVzedP7
 3ljU25VNk3KY7+7KCUMrJ9QHsg1BJBPQL724rMMrgJAi1Fvy9MQEQ4jOLoQTOxJIhABD4Srbt
 7O34HaHiDWCl62SnPTV/Kq1/K3Eb4M1XdLPuMXWBMrqCvTDf08dj4XS91RYQjyAJstUwdoMBH
 vnLG+JndZjsODXBR0v9F9edmLrfkC0L+LSKKKfTdrbmCJuP1LiAMng5CQZgoA0URNI0OmnVQl
 I5gmv7WZJwQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/19 5:29 PM, Greg KH wrote:
> On Tue, Feb 12, 2019 at 02:02:52PM +0800, Chengguang Xu wrote:
>> Actually, total amount of available minor number
>> for a single major is MINORMARK + 1. So expand
>> minor range when registering chrdev region.
>>
>> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
>> ---
>>   drivers/misc/mei/main.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
>> index 87281b3695e6..3df54f1e1a8b 100644
>> --- a/drivers/misc/mei/main.c
>> +++ b/drivers/misc/mei/main.c
>> @@ -869,7 +869,7 @@ static const struct file_operations mei_fops = {
>>   
>>   static struct class *mei_class;
>>   static dev_t mei_devt;
>> -#define MEI_MAX_DEVS  MINORMASK
>> +#define MEI_MAX_DEVS  (MINORMASK + 1)
> Why is this needed?  Have you really run out of that many minor nodes
> for this driver?

Not really, practically maybe we cannot reach to the limit.
I was just curious why only one minor number left there and assumed
that was from a mistake(since I've seen similar mistake in other driver).
However, if it explicitly sets to MINORMASK for some reasons, then it's
better to keep as is.

Thanks




