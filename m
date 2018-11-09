Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DE9C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5178620827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5178620827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbeKIVca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 16:32:30 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14639 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727662AbeKIVca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 16:32:30 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E47E64BD03711;
        Fri,  9 Nov 2018 19:52:06 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Fri, 9 Nov 2018
 19:52:05 +0800
Subject: Re: [PATCH v4 2/2] scsi: ufs: Add UFS platform driver for Cadence UFS
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Janek Kotas <jank@cadence.com>
References: <C77CE2E3-F88A-4B1E-BECB-5D031E2930E3@global.cadence.com>
 <1A428C77-982A-4EB8-8FDD-A33979753660@global.cadence.com>
 <yq1tvkt1vly.fsf@oracle.com>
 <38D3DEAD-C318-4BE2-8605-102FF572AD45@global.cadence.com>
 <yq1tvkrvvad.fsf@oracle.com>
CC:     "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c4937848-8459-1201-5ec1-2f453df15e1e@huawei.com>
Date:   Fri, 9 Nov 2018 11:51:59 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <yq1tvkrvvad.fsf@oracle.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 02:28, Martin K. Petersen wrote:
>
> Janek,
>
>>> Rob reviewed the dt binding patch but has it been merged or should I
>>> take both patches through SCSI?
>
> Applied to 4.21/scsi-queue. Thank you!
>


Hi Martin,

I am building your 4.21 queue today, and it seems to be broken from this 
patch:

https://kernel.googlesource.com/pub/scm/linux/kernel/git/mkp/scsi/+/b3874a425510d1164fd3428ab99273c07d210d82

You seemed to miss adding the c-file:
make[3]: *** No rule to make target `drivers/scsi/ufs/cdns-pltfrm.o', 
needed by `drivers/scsi/ufs/built-in.a'. Stop

Or am I missing something?

John

