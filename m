Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4A9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E9320851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E9320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeKTUhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:37:43 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:48435 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeKTUhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:37:42 -0500
Received: from [192.168.178.52] ([109.104.39.179]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MxE5Y-1fVoqA1a1I-00xZ39; Tue, 20 Nov 2018 11:08:58 +0100
Subject: Re: [PATCH 00/16] staging: vchiq: dead code removal & misc fixes
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        eric@anholt.net, linux-rpi-kernel@lists.infradead.org,
        dave.stevenson@raspberrypi.org,
        linux-arm-kernel@lists.infradead.org
References: <20181114125942.25163-1-nsaenzjulienne@suse.de>
 <1128999886.40745.1542556549581@email.ionos.de>
 <20181120095751.GB17738@kroah.com>
 <17a08397268fddb774ca0d1620d67ca38633a284.camel@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <fae40a52-34cc-65a2-09d3-936cf122f8c0@i2se.com>
Date:   Tue, 20 Nov 2018 11:08:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <17a08397268fddb774ca0d1620d67ca38633a284.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:3c4sjDHsaEyS76kRe36tm10JS+Tl8bMW2CfVI+AwSD0ztBcE4u7
 0d6ntkXlSeoeZ+/bqXks5PSfLGBvvL702ckjwmg53zkf1t8tN7DWAr9Mx4u0NjANlGV+qR9
 BwaJ3f07X92njOlFhUNYSxrO/Avc2zJ6k5V0gkBieuzuUVEQpSvSCyYXkLo5l2Jt5ysm+Cf
 ySKI0d/HP5OzVxWtdv3vA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cfknC8PUjLU=:zKA/KVXuS6ACQ+gT/4a0cg
 3FSNlODldfJGHwHZbjhnz7FcHjb9v2McTdtpSgWrjlncst0Vz5kNCndowyeYX4/lkRZEV8TfX
 eKt+zQwfkA/F+UzTqMqGgw2egxqyf3elmxUoy0DSx1Q4c3LDVMQPK1QKt7Z4v700JIV6aw+FB
 VJxWc7ob6HHvm67mEwBIjSQn0mzlD2dWbGH+m4bj4O6VKGQNVqLs3Yrvo1QbDT5JO9gQMq1Yh
 adxwp9aAUANbdP4XAt4z8J5U1uxVjTj+6cedhHmesdovBIcG83/Z5aYEo33/bT+sQ5vXXgSUn
 oo/jShgNfvxK0381d6jRJ0PjkTMZYqdfmQmM+JGbJgZGLm0XuIW4TaHfUoE627+N+ZnLEt3c9
 Cl8A+p6J6A+nRvRuDZL137GBdPq1AavC0EHpy8k1dr03TGGzjU9eKDe0FlG6zIcilrBq23W+q
 N4fVY9DTTXsFb+VdGgGoAKvDPdWjggmHGLfHi5ltPo+dA2A7pcNsND7VRiUWl01AHeENEFnpo
 r8P3kCWiTXJKbMY4tgt8XmBx9DkM1v6zXO/VBb41RYSeVrD/M1IJ/7DPrmpHMmUvU+bc1uusr
 jOP+XsZdlpZ9ttm+txzct1GA7kF+fyyiLiQV+pGd1PrWCTfaUPhwsYO0opRC3LwoRsTtMUGIc
 uj83z2opul4mpRxl5bfIAcmadx4GFmdzw91ZIn5kRPg4YCsuzLyZpPaPmUfTjyWekym4yutM0
 o+Hcrzvek1CiPfT44kDoCuZxjVwGKUYei6ixjDXceZ+xxrfYOJ/M6MONCmc10+c+4J6focFgQ
 NJQu8taAjV4YcJ/UN7j1G+NgW88bQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.11.18 um 11:04 schrieb Nicolas Saenz Julienne:
> On Tue, 2018-11-20 at 10:57 +0100, Greg KH wrote:
>> On Sun, Nov 18, 2018 at 04:55:49PM +0100, Stefan Wahren wrote:
>>> Hi Nicolas,
>>>
>>>
>>> without a changelog i won't start a review.
>> What do you mean by this?  The individual patches have a "changelog"
>> in
>> them, this is just a summary of the overall changes.
>>
>> What do you feel is missing here?
> Hi Greg,
> I did send an RFC version of this, to which Stephan made several
> comments. I should have added the changelog to the proper series
> submission. I've been busy with work, but I'll send the updated version
> during the day.
Thanks Stefan
>
> Regards,
> Nicolas
>
>> thanks,
>>
>> greg k-h
