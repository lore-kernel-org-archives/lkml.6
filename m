Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28C3C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7D820811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="txAP1hNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7D820811
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbeLKL6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:58:08 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50512 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbeLKL6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:58:08 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBBBvxWp079391;
        Tue, 11 Dec 2018 05:57:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544529479;
        bh=187Rsf4EelGv9DlRifQPc+KEenFEMf8MbAizh0anMr4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=txAP1hNZTuoaQH7LGACPLPO9ldref4wGLd+sqnT7rnXR69Wg+nUAlDydA1Ar4An+s
         lvk+JhJbFec4rm+7ldsGs8E4BRRf69xjL2YP/2t4TISSec9RiNAM2Yto6O5g+ytyGq
         XO35RqMO/LWwXW4vc2bTlsNBsb38yqBW/vjtWmZg=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBBBvxK5096841
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Dec 2018 05:57:59 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 11
 Dec 2018 05:57:59 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 11 Dec 2018 05:57:59 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBBBvv01013686;
        Tue, 11 Dec 2018 05:57:57 -0600
Subject: Re: [PATCH] mmc: sdhci-omap: Workaround errata regarding SDR104/HS200
 tuning failures (i929)
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Kishon <kishon@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20181129190503.6040-1-faiz_abbas@ti.com>
 <cb1e8e88-4c9d-741d-79cd-57b03c5e0808@ti.com>
 <c4704766-7a58-8aa4-6bc0-b9373b15096c@ti.com>
 <CAPDyKFqMW+tMaVsS_c=kPztZRjX97Nzr2W0egvDkyzkpWckHRA@mail.gmail.com>
 <d1ae4e93-4b17-9574-00b1-bfa268cb7574@ti.com>
 <CAPDyKFrLzEfGKkC3K9znjJUKO1MUjdBpaL0HEtHYOzbAgNO-fg@mail.gmail.com>
 <e19a5c39-028e-8dda-aa0a-3968a213cd47@ti.com>
 <CAPDyKFoO7tn1Xdu9ROqRVjZ1SZnzXcxduB97OQtmz2d2E_epUQ@mail.gmail.com>
 <218be2af-8f81-47b4-f782-b774e10642c1@ti.com>
 <CAPDyKFou7hSELknyOV-eP+6ROJozwc-7vPBy2Rkb7hSdL37Pqg@mail.gmail.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <4d893ae8-f0a2-2e67-8100-b934340f4e4a@ti.com>
Date:   Tue, 11 Dec 2018 17:30:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFou7hSELknyOV-eP+6ROJozwc-7vPBy2Rkb7hSdL37Pqg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/12/18 10:26 PM, Ulf Hansson wrote:
> On Mon, 10 Dec 2018 at 17:43, Faiz Abbas <faiz_abbas@ti.com> wrote:
>>
>> Hi,
>>
>> On 10/12/18 8:55 PM, Ulf Hansson wrote:
>>> On Mon, 10 Dec 2018 at 15:04, Faiz Abbas <faiz_abbas@ti.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 10/12/18 7:15 PM, Ulf Hansson wrote:
>>>>> On Mon, 10 Dec 2018 at 14:23, Faiz Abbas <faiz_abbas@ti.com> wrote:
>>>>>>
>>>>>> Hi Uffe,
>>>>>>
>>>>>> On 05/12/18 7:20 PM, Ulf Hansson wrote:
>>>>>>> On Fri, 30 Nov 2018 at 06:53, Faiz Abbas <faiz_abbas@ti.com> wrote:
>>>>>>>>
>>>>>>>> Hi Kishon,
>>>>>>>>
>>>>>>>> On 30/11/18 10:10 AM, Kishon Vijay Abraham I wrote:
>>>>>>>>> Hi Faiz,
>>>>>>>>>
>>>>>>>>> On 30/11/18 12:35 AM, Faiz Abbas wrote:
>>>>>>>>>> Errata i929 in certain OMAP5/DRA7XX/AM57XX silicon revisions
>>>>>>>>>> (SPRZ426D - November 2014 - Revised February 2018 [1]) mentions
>>>>>>>>>> unexpected tuning pattern errors. A small failure band may be present
>>>>>>>>>> in the tuning range which may be missed by the current algorithm.
>>>>>>>>>> Furthermore, the failure bands vary with temperature leading to
>>>>>>>>>> different optimum tuning values for different temperatures.
>>>>>>>>>>
>>>>>>>>>> As suggested in the related Application Report (SPRACA9B - October 2017
>>>>>>>>>> - Revised July 2018 [2]), tuning should be done in two stages.
>>>>>>>>>> In stage 1, assign the optimum ratio in the maximum pass window for the
>>>>>>>>>> current temperature. In stage 2, if the chosen value is close to the
>>>>>>>>>> small failure band, move away from it in the appropriate direction.
>>>>>>>>>>
>>>>>>>>>> References:
>>>>>>>>>> [1] http://www.ti.com/lit/pdf/sprz426
>>>>>>>>>> [2] http://www.ti.com/lit/pdf/SPRACA9
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>>>>>>>>> ---
>>>> ...
>>>>>>>>>
>>>>>>>>> Can't we get thermal zone once during probe?
>>>>>>>>>
>>>>>>>>
>>>>>>>> Tuning is also (ideally) supposed to happen only once per enumeration.
>>>>>>>> Also it doesn't make sense to get a thermal zone for lower speed systems
>>>>>>>> that won't do tuning.
>>>>>>>
>>>>>>> Currently sdhci-omap calls pm_runtime_get_sync() during probe, and
>>>>>>> then keeps the host device runtime resumed until ->remove() is called
>>>>>>> on it. I assume you are going to change that, at some point!?
>>>>>>>
>>>>>>> In other words, what will happen to the host device when it becomes
>>>>>>> runtime suspended? Is re-tuning needed when it gets runtime resumed,
>>>>>>> which is the case for many other sdhci variants?
>>>>>>
>>>>>> There are no plans to support runtime_suspend()/resume() any time in the
>>>>>> near future. If its ok with you, I would like to get this patch in
>>>>>> without any changes. We can change it in case a need for
>>>>>> runtime_suspend()/_resume() does arise.
>>>>>
>>>>> Right, I am okay with that. Due to recent changes to sdhci-omap
>>>>> $subject patch doesn't apply, can you please rebase!?
>>>>>
>>>>> Additionally, I realized that we should fold in patch updating the DT
>>>>> doc for sdhci-omap, adding the property for the thermal zone. I
>>>>> regards to that, I am wondering if "cpu_thermal", is really the
>>>>> correct name of the zone. The point is, I am guessing the zone could
>>>>> change along with the SoCs/platforms.
>>>>>
>>>>
>>>> As you have probably noticed, we are introducing a new driver
>>>> (sdhci_am654) for newer platforms. I don't foresee using sdhci-omap
>>>> driver with any other platforms. In case we do use it, we can add the dt
>>>> property at that point of time and default to "cpu_thermal" to maintain
>>>> dt compatibility.
>>>>
>>>> Will rebase and send v2 if you are ok with above.
>>>
>>> I see, but you still need to update the DT doc for sdhci-omap.
>>>
>>
>> I didn't get you. There are no changes in dt. What changes should I
>> document?
> 
> Well, you are fetching a thermal zone using a specific name. It's
> quite similar to how we document other resources (pinctrls for
> example) that sdhci omap depends on, so that needs to be document too.
> 

Ok. Will add a note for "cpu_thermal" in the documentation.

Thanks,
Faiz
