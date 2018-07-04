Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535D5C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099A32446A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099A32446A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934197AbeGDISv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:18:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933813AbeGDISs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:18:48 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 74463E70892F1;
        Wed,  4 Jul 2018 16:18:34 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.382.0; Wed, 4 Jul 2018
 16:18:29 +0800
Subject: Re: [RFC] scsi: switch to scsi-mq by default
To:     Bart Van Assche <Bart.VanAssche@wdc.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
References: <20180703065413.6098-1-jthumshirn@suse.de>
 <7ab21471b799d2a60ccfd8579b2548f58915568a.camel@wdc.com>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hare@suse.de" <hare@suse.de>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        chenxiang <chenxiang66@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <282521f4-762c-86a5-5ac8-f8cc33b050cc@huawei.com>
Date:   Wed, 4 Jul 2018 09:18:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <7ab21471b799d2a60ccfd8579b2548f58915568a.camel@wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2018 00:21, Bart Van Assche wrote:
> On Tue, 2018-07-03 at 08:54 +0200, Johannes Thumshirn wrote:
>> It has been more than one year since we tried to change the default
>> from legacy to multi queue in SCSI. Back then we had to retract the
>> change because of performance issues with rotating disks.
>>
>> In the meantime there have been a substantial amount of performance
>> improvements, thus we can re-enable scsi-mq without a significant
>> performance penalty.
>
> Hello Johannes,
>
> Please include references to commits cbe7dfa26eee ("Revert "scsi:
> default to scsi-mq"") and 5c279bd9e406 ("scsi: default to scsi-mq").
> I think it's a good idea to mention that suspend/resume now works
> with scsi-mq.
>
> Bart.

We were seeing performance drops previously for hisi_sas when originally 
enabled by default, but results on 4.18 seem almost identical with and 
without MQ default.

FWIW,

Acked-by: John Garry <john.garry@huawei.com>

>
>
>
>
>
>
>
>


