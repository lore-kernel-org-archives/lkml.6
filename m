Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AA5C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1BF23FCF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1BF23FCF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932724AbeGFMEv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:04:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753652AbeGFMEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:04:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 41A77407446D;
        Fri,  6 Jul 2018 12:04:50 +0000 (UTC)
Received: from [10.72.12.18] (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB50D2026D68;
        Fri,  6 Jul 2018 12:04:44 +0000 (UTC)
Subject: Re: [PATCH v3 0/3] uio: fix potential crash bug
To:     Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "jannh@google.com" <jannh@google.com>,
        "pkalever@redhat.com" <pkalever@redhat.com>,
        "pkarampu@redhat.com" <pkarampu@redhat.com>,
        "atumball@redhat.com" <atumball@redhat.com>,
        "sabose@redhat.com" <sabose@redhat.com>,
        "mchristi@redhat.com" <mchristi@redhat.com>
References: <1530845836-49101-1-git-send-email-xiubli@redhat.com>
 <0002b0fb-4612-b371-d929-bf64aa877225@alliedtelesis.co.nz>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <060d9f68-6d73-a38a-98a5-b0670ee18907@redhat.com>
Date:   Fri, 6 Jul 2018 20:04:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <0002b0fb-4612-b371-d929-bf64aa877225@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 06 Jul 2018 12:04:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 06 Jul 2018 12:04:50 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'xiubli@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/6 11:31, Hamish Martin wrote:
> Hi Xiubo,
>
> Thanks for your patch that addresses the regression found with my
> earlier commit.
>
> I will take your code and run it in our scenario that showed the bug
> that led to my commit. Unfortunately I won't be able to get that done
> until mid-next week. I intend to report back to you by July 13th.
Hi Hamish,

Thanks verrrry much for your quickly review and reply about this. Take 
your time :-)

BRs
Xiubo


> Thanks,
> Hamish M
>
> On 07/06/2018 02:57 PM, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> The V2 patch set maybe not post successfully, so post it again
>> with one new updation.
>>
>> V2:
>> - resend it with some small fix
>>
>> V3:
>> - switch to use request_threaded_irq
>>
>>
>> Xiubo Li (3):
>>     uio: use request_threaded_irq instead
>>     uio: change to use the mutex lock instead of the spin lock
>>     uio: fix crash after the device is unregistered
>>
>>    drivers/uio/uio.c          | 151 ++++++++++++++++++++++++++++++++++-----------
>>    include/linux/uio_driver.h |   2 +-
>>    2 files changed, 115 insertions(+), 38 deletions(-)
>>

