Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B204ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90D6214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fUzdLKSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90D6214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbeIQXlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:41:11 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47340 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbeIQXlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:41:10 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8HICOvS091987;
        Mon, 17 Sep 2018 13:12:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537207944;
        bh=z2sguqsEepGTGtaSXOncUZGhVAMDDfAqS89RmyecpZc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fUzdLKSl5vKWZ7v0e6xNygGxsx0MgHjo70+fekg/4SDbis+5/8imFc92lR1uVuBRY
         cdTWdBul2KvcvwZp/MrtstXXXsvp28Zbhwarmu+c+wNOtBhD/EqrhwpVVlhqS8qV2h
         21Mbu4RcTldvva2CmR0PUdoeh4o7ofV4aZh1COhs=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8HICOAZ000872;
        Mon, 17 Sep 2018 13:12:24 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 17
 Sep 2018 13:12:24 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 17 Sep 2018 13:12:23 -0500
Received: from [172.22.219.242] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8HICJao006260;
        Mon, 17 Sep 2018 13:12:20 -0500
Subject: Re: [PATCH v3 0/4] pci-dra7xx: Enable errata i870 workaround for RC
 mode
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Tony Lindgren <tony@atomide.com>
CC:     KISHON VIJAY ABRAHAM <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180724173150.2701-1-vigneshr@ti.com>
 <20180808165700.GB486@e107981-ln.cambridge.arm.com>
 <ba428a15-77bf-e09c-3bd7-b5a0eae7ee13@ti.com>
 <20180907170009.GJ5662@atomide.com>
 <20180917094736.GA7072@e107981-ln.cambridge.arm.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <d4c7751b-6950-d16b-9435-61935a6f511d@ti.com>
Date:   Mon, 17 Sep 2018 23:42:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917094736.GA7072@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo,

On 17-Sep-18 3:17 PM, Lorenzo Pieralisi wrote:
> On Fri, Sep 07, 2018 at 10:00:09AM -0700, Tony Lindgren wrote:
>> * Vignesh R <vigneshr@ti.com> [180810 10:10]:
>>>
[...]
>>>>> Tony,
>>>>>
>>>>> If you are okay with the series, could you pick this via omap tree?
>>>>> All ACKs are in place and Lorenzo is okay with PCIe bits to go along with
>>>>> rest of DTS changes.
>>>>
>>>> I think we have missed the v4.19 merge window by now - 
>>>
>>> Right. I didn't get any response from Tony.
>>
>> Sorry catching up with pending mails.. I try hard to not touch
>> anything except fixes around -rc6 time.
>>
>>>> please let me know if I can drop this series from the PCI patch queue.
>>>>
>>>
>>> Ok, I will resend the patch after 4.19-rc. Thanks!
>>
>> FYI, I'm untagging this thread too. Please post the dts
>> changes separately once the dependencies (if any) have
>> cleared.
> 
> Ok, Vignesh: I shall drop this series from the PCI patches queue,
> waiting for your new version, let me know how you want to handle this
> then please.
> 

Thanks for the response!
I have sent v4 dropping DT changes (will send after driver patches have
made it upstream). If possible, consider the patches for next rc as they
are fixes.

Regards
Vignesh
