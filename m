Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2221C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4B024032
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UCDMNSD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4B024032
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933687AbeFVKMb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:12:31 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:52673 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932960AbeFVKM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:12:29 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllnx209.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5MACJcc020219;
        Fri, 22 Jun 2018 05:12:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529662339;
        bh=2ou+EPywWhoyogjmD16qunZRoc7broNhuLb976kGkOk=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=UCDMNSD3HtbgPaJ8t7Ymy3PS42uq9Swj+RO4rSzSYRWq0WvFOfXNFo8babgdnmqWr
         MnCPb+bO+fW/4e4kQXK92JNxY359sowNGSmDs+I1DQ9csKR6g7KQHrEODLjEeWfHLI
         zObUD0rywPB1U8U2dwV3v6oz6Vfy2U3wHwKezj1w=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5MACJ49004280;
        Fri, 22 Jun 2018 05:12:19 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 22
 Jun 2018 05:12:19 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 22 Jun 2018 05:12:19 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5MACGo0028159;
        Fri, 22 Jun 2018 05:12:17 -0500
Subject: Re: [PATCH 0/3] K2G: mmc: Update mmc dt node to use sdhci-omap
To:     "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
References: <20180425132746.13911-1-kishon@ti.com>
 <fc5f3498-62fd-15d3-90df-206c51649cb4@oracle.com>
 <0481f6f0-539e-4809-63cd-1134367a7b78@ti.com>
 <de0bd46a-21d4-14de-9695-9b0f3996dacb@oracle.com>
 <e4b70bab-d3bd-7071-aefa-2934c20a3e30@ti.com>
 <d7ec2aed-028f-4d0d-fc31-ecc798b0ef14@oracle.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <8b13f8df-c6bd-cdca-c339-8cd3cda04e89@ti.com>
Date:   Fri, 22 Jun 2018 15:42:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <d7ec2aed-028f-4d0d-fc31-ecc798b0ef14@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Santosh,

On Friday 04 May 2018 09:16 PM, santosh.shilimkar@oracle.com wrote:
> On 5/4/18 1:06 AM, Kishon Vijay Abraham I wrote:
>> Hi Santosh,
>>
>> On Friday 04 May 2018 12:22 AM, santosh.shilimkar@oracle.com wrote:
>>> On 5/3/18 4:57 AM, Kishon Vijay Abraham I wrote:
>>>> Hi Santosh,
>>>>
>>>> On Wednesday 25 April 2018 11:10 PM, Santosh Shilimkar wrote:
>>>>> On 4/25/2018 6:27 AM, Kishon Vijay Abraham I wrote:
>>>>>> Update mmc dt node to use sdhci-omap binding instead of omap_hsmmc
>>>>>> binding.
>>>>>>
>>>>>> I've also updated keystone_defconfig to enable CONFIG_MMC_SDHCI_OMAP.
>>>>>> Everyone who use a custom .config should also enable
>>>>>> CONFIG_MMC_SDHCI_OMAP for MMC to work.
>>>>>>
>>>>>> This series should be merged only after [1]
>>>>>> [1] -> https://marc.info/?l=linux-kernel&m=152465820531802&w=2
>>>>>>
>>>>> Keep me posted once the dependency gets merged.
>>>>
>>>> Ulf has merged the sdhci part and has shared an immutable branch
>>>>
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git sdhci_omap
>>>> with his signed tag sdhci-omap-v4.17-rc3.
>>>>
>>>> Can you use it as a base for merging this series?
>>>>
>>> How about I apply only DTS patches and exlude config file update ?
>>> You can send the config patch after the merge window. Are the DTS
>>> changes also going to break anything without basing of this sdhci
>>> branch ?
>>
>> Yes, the bindings has changed for sdhci-omap.
>> It should also be fine if this entire series can be merged during the 4.18 -rc
>> cycle since the dependent patches would have been already merged then.
>>
> I see. In that, lets wait for 4.18-rcx for all the dependencies to make
> it. This series won't qualify for fixes but at least we can get that
> into next early in the cycle so that it becomes usable.
> 
> Thanks for followup Kishon !!

All the dependent patches has got merged. This series applies on latest linus
-master as is without any conflicts. I've also verified MMC works with this series.

This should be good to get merged. Let me know if you want me to repost the series.

Thanks
Kishon
