Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952B9C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C51E206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C51E206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbeIENni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:43:38 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:52130 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726272AbeIENni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:43:38 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w859A4Xc009548;
        Wed, 5 Sep 2018 11:13:56 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2m7ghtwpk2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 05 Sep 2018 11:13:56 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E7A7E38;
        Wed,  5 Sep 2018 09:13:54 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BD026279F;
        Wed,  5 Sep 2018 09:13:54 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.49) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 5 Sep
 2018 11:13:53 +0200
Subject: Re: [PATCH 00/14] mmc: mmci: prepare dma callbacks with mmci_host_ops
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <1533116221-380-1-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFqArwShaUZAit4fHa7F6UNC_z7Yc1GMpBuQcrkkwrB84g@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <5e9e5114-40d0-d178-4fdc-edfd5963c170@st.com>
Date:   Wed, 5 Sep 2018 11:13:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqArwShaUZAit4fHa7F6UNC_z7Yc1GMpBuQcrkkwrB84g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/04/2018 12:00 PM, Ulf Hansson wrote:
> On 1 August 2018 at 11:36, Ludovic Barre <ludovic.Barre@st.com> wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch series prepares and adds callbacks for dma transfert at
>> mmci_host_ops. This series is composed of 3 parts:
>> -Internalize specific needs of legacy dmaengine.
>> -Create and setup dma_priv pointer
>> -Create generic callbacks  which share some features
>> (like cookie...) and call specific needs
> 
> I have now reviewed part of this series and provided you with some
> comments, but will stop at this point.

thanks for your review

> 
> Overall, the comments are about renaming and picking better function
> names. Those comments should be easy to address in a new version.

yes, there is no problem for the naming, I will change following your
recommendations.

> 
> However, the other more important point is the number of variant
> callbacks you are adding. It's of course a balance to pick the right
> level, to get both flexibility but also to avoid open coding. In the
> end we don't want to get too many callbacks, but then it's better to
> share common mmci code for variants, through mmci.h.
> 
> Finally, I would like to see a patch on top adding the support for the
> new ST variant, so I can see how the callbacks and changes really are
> being used. Can you please add that?
> 

yes, I prepare a patch with sdmmc variant to show how callbacks are used.

About comment on patch 07/14:
 > So, having callbacks for dealing with dma_map|unmap() kind of
 > operations, becomes rather fine-grained and not very flexible.
 > Instead, what do you think of allowing the variant init function to
 > dynamically assign the ->pre_req() and the ->post_req() callbacks in
 > the struct mmc_host_ops. Common mmci functions to manage these
 > operations can instead be shared via mmci.h and called by the
 > variants.

I think we have the same goal or idea, regroup the common needs to avoid
too much specific drift.

I will try to describe the functions which are commons and the link to 
specific mmci_host_ops callbacks.

(I use function names of this series, but it's just for this example)

commons function used by mmci core:
-mmci_pre_request:
  check data and cookie, call common mmci_validate_data
  and mmci_prepare_data.

-mmci_post_request:
  check data and cookie then call common mmci_unprepare_data

-mmci_validate_data:
  check the common constraint of variants, call specific
  validate_data if defined.

-mmci_prepare_data:
  setup common next cookie, call specific prepare data if defined

-mmci_unprepare_data:
  clear the common cookie, call specific unprepare data if defined

-mmci_get_next_data:
  check cookie, call specific get_next_data if defined

-mmci_dma_setup:
  initialize common next_cookie, call specific dma_setup if defined

-mmci_dma_release
  just call dma_release if defined

-mmci_dma_start
  call common prepare data if not yet done (by next)
  call specific dma_start
  write common registers to start transfer and setup mmci mask

-mmci_dma_finalize:
  just call dma_finalize if defined

-mmci_dma_error
  just call dma_error if defined

mmci_host_ops specific:
struct mmci_host_ops
validate_data: 	could be use to check specific constraint of variant.
  		sdmmc has constraints on base & size for each element
		excepted the last element which has no constraint on
		size.
prepare_data: 	specific needs to prepare current or next data request.
		mmci: dma_map_sg on channel, use dmaengine api
		"dmaengine_prep_slave_sg" to queue a transfer
		sdmmc: dma_map_sg on sdmmc device and prepare the link
		list of internal dma
		
unprepare_data: specific needs to unprepare the data of request
		mmci: dma_unmap_sg on channel, use dmaengine api to
		terminate transfert.
		sdmmc: just unmap on sdmmc device.

get_next_data: 	manage specific needs to move on next data
		mmci: get next dmaengine descriptor and channel
		sdmmc: today, nothing

dma_setup: 	setup specific need if you use a Direct Memory Access
		mmci: use dmaengine api to request slave channel.
		sdmmc: alloc memory for link list, and define specific
		mmc->max_segs and mmc->max_seg_size.

dma_release: 	release specific resource if you use a Direct Memory
		access.
		mmci: use dmaengine api to release channel
		sdmmc: nothing

dma_start: 	set specific needs to start dma request
		mmci: use dmaengine api to submit and pending a dma
		transfert.
		sdmmc: set specific sdmmc registers to start an internal
		dma transfert

dma_finalize: 	set specific needs to finalize a request
		mmci: specific check on fifo status and
		channel/descriptor management.
		sdmmc: just clear a specific register of sdmmc

dma_error: 	specific error management.
		mmci: dmaengine api to terminate a transfer
		sdmmc: nothing

BR
Ludo

>>
>> This patch series must be applied on top of
>> "mmc: mmci: Add and implement a ->dma_setup() callback for qcom dml"
>>
>> Ludovic Barre (14):
>>    mmc: mmci: fix qcom dma issue during mmci init with new dma_setup
>>      callback
>>    mmc: mmci: internalize dma map/unmap into mmci dma functions
>>    mmc: mmci: internalize dma_inprogress into mmci dma functions
>>    mmc: mmci: introduce dma_priv pointer to mmci_host
>>    mmc: mmci: move mmci next cookie to mci host
>>    mmc: mmci: merge prepare data functions
>>    mmc: mmci: add prepare/unprepare_data callbacks
>>    mmc: mmci: add get_next_data callback
>>    mmc: mmci: modify dma_setup callback
>>    mmc: mmci: add dma_release callback
>>    mmc: mmci: add dma_start callback
>>    mmc: mmci: add dma_finalize callback
>>    mmc: mmci: add dma_error callback
>>    mmc: mmci: add validate_data callback
>>
>>   drivers/mmc/host/mmci.c          | 458 ++++++++++++++++++++++++---------------
>>   drivers/mmc/host/mmci.h          |  45 ++--
>>   drivers/mmc/host/mmci_qcom_dml.c |  15 +-
>>   3 files changed, 322 insertions(+), 196 deletions(-)
>>
>> --
>> 2.7.4
>>
> 
> Kind regards
> Uffe
> 
