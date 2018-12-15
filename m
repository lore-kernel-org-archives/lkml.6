Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00431C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 10:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9362084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 10:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbeLOK1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 05:27:40 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36990 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbeLOK1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 05:27:40 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 9D5A1276C74
Subject: Re: gtucker/kernelci-stable boot bisection: v4.19.9 on
 meson-gxbb-p200
To:     Kevin Hilman <khilman@baylibre.com>,
        "kernelci.org bot" <bot@kernelci.org>, tomeu.vizoso@collabora.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        broonie@kernel.org, matthew.hart@linaro.org,
        enric.balletbo@collabora.com
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
References: <5c14545e.1c69fb81.d4568.5d80@mx.google.com>
 <7hwooblgj8.fsf@baylibre.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <7f70fc6c-93c8-2618-1ecf-d7730c61b057@collabora.com>
Date:   Sat, 15 Dec 2018 10:27:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <7hwooblgj8.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/12/2018 01:34, Kevin Hilman wrote:
> "kernelci.org bot" <bot@kernelci.org> writes:
> 
>> gtucker/kernelci-stable boot bisection: v4.19.9 on meson-gxbb-p200
>>
>> Summary:
>>   Start:      be53d23e68c2 Linux 4.19.9
>>   Details:    https://kernelci.org/boot/id/5c13e85d59b5144a340a819d
>>   Plain log:  https://storage.kernelci.org//gtucker/kernelci-stable/v4.19.9/arm64/defconfig/lab-baylibre/boot-meson-gxbb-p200.txt
>>   HTML log:   https://storage.kernelci.org//gtucker/kernelci-stable/v4.19.9/arm64/defconfig/lab-baylibre/boot-meson-gxbb-p200.html
>>   Result:     be53d23e68c2 Linux 4.19.9
>>
>> Checks:
>>   revert:     PASS
>>   verify:     PASS
>>
>> Parameters:
>>   Tree:       gtucker
>>   URL:        https://gitlab.collabora.com/gtucker/linux.git
>>   Branch:     kernelci-stable
>>   Target:     meson-gxbb-p200
>>   CPU arch:   arm64
>>   Lab:        lab-baylibre
>>   Config:     defconfig
>>   Test suite: boot
>>
>> Breaking commit found:
>>
>> -------------------------------------------------------------------------------
>> commit be53d23e68c29900da6b6ce486b5ab8507de94b1
>> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Date:   Thu Dec 13 09:16:23 2018 +0100
>>
>>     Linux 4.19.9
>>
>> diff --git a/Makefile b/Makefile
>> index 34bc4c752c49..8717f34464d5 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1,7 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  VERSION = 4
>>  PATCHLEVEL = 19
>> -SUBLEVEL = 8
>> +SUBLEVEL = 9
>>  EXTRAVERSION =
>>  NAME = "People's Front"
>> -------------------------------------------------------------------------------
> 
> This is pretty clearly a bug in the automation toolling.
> 
> If this patch broke the kernel on that board (which I maintain, BTW) I
> would be very impressed.

Indeed, sorry about the noise.  This is a new kind of bisection
error I've never seen before...  I think it was due to some lab
infrastructure error but in principle that should have been
filtered out, we'll investigate.

Guillaume
