Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0304ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 02:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D14A20870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 02:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D14A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeGPCex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 22:34:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727008AbeGPCex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 22:34:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7DAF401C7E8;
        Mon, 16 Jul 2018 02:09:50 +0000 (UTC)
Received: from [10.72.12.29] (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BA212156893;
        Mon, 16 Jul 2018 02:09:45 +0000 (UTC)
Subject: Re: [PATCH v4 0/3] uio: fix potential crash bug
To:     Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "jannh@google.com" <jannh@google.com>,
        "pkalever@redhat.com" <pkalever@redhat.com>,
        "pkarampu@redhat.com" <pkarampu@redhat.com>,
        "atumball@redhat.com" <atumball@redhat.com>,
        "sabose@redhat.com" <sabose@redhat.com>,
        "mchristi@redhat.com" <mchristi@redhat.com>
References: <1530929139-13652-1-git-send-email-xiubli@redhat.com>
 <7c0ae0c9-2af6-c7c3-49b0-24302584a24d@alliedtelesis.co.nz>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <095acd45-675d-b9c3-244a-d1b6cdc1e8f0@redhat.com>
Date:   Mon, 16 Jul 2018 10:09:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7c0ae0c9-2af6-c7c3-49b0-24302584a24d@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 16 Jul 2018 02:09:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 16 Jul 2018 02:09:50 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'xiubli@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/13 4:34, Hamish Martin wrote:
> Hi Xiubo,
>
> Tested-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
>
> I see these were already merged into Linus' tree but I wanted to let you
> know that I tested v4.18-rc4 (which contains these three patches) and
> the issue which led to my original series is still fixed and this patch
> series of yours has caused no regression in our scenario. This was
> tested on PPC 64 bit system (NXP T2081).
Hi Hamish,

Cool and thanks very much for your testing about this.

BRs
Xiubo


> Thanks for resolving that.
>
> Regards,
> Hamish M.
>
> On 07/07/2018 02:05 PM, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> V2:
>> - resend it with some small fix
>>
>> V3:
>> - switch to use request_threaded_irq
>>
>> V4:
>> - remove useless checking code, Thanks Mike.
>> - Thanks very much for the review from Hamish and Mike.
>>
>>
>> Xiubo Li (3):
>>     uio: use request_threaded_irq instead
>>     uio: change to use the mutex lock instead of the spin lock
>>     uio: fix crash after the device is unregistered
>>
>>    drivers/uio/uio.c          | 139 +++++++++++++++++++++++++++++++++------------
>>    include/linux/uio_driver.h |   2 +-
>>    2 files changed, 104 insertions(+), 37 deletions(-)
>>

