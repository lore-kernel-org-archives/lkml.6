Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF2FC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDA620854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YaQZJYZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCDA620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbeIJTbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:31:51 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37632 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbeIJTbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:31:51 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8AEbNjT041922;
        Mon, 10 Sep 2018 09:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536590243;
        bh=CDOscDd714ORF/o0IDB/qJD9QkVZyLDJzsVqNDrT8LA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YaQZJYZS1Om1BbCICJJEwU/yB1IA619esCCG+40MdJ59K3hK9n3xXfFs7bXCII6/M
         uO22AbJgdJGiTnaqYgFjBO5dJuPtgZaett3Gq9Rz/iamvtZupDnjE+v4Lz9dwVPMoc
         ZPmBmPC3CbIumxZxZuppiOBBnQPrJC7ScUwpdw4M=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8AEbNbm003398;
        Mon, 10 Sep 2018 09:37:23 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 10
 Sep 2018 09:37:23 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 10 Sep 2018 09:37:22 -0500
Received: from [172.22.137.130] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8AEbMpi024173;
        Mon, 10 Sep 2018 09:37:22 -0500
Subject: Re: [PATCH v6 1/2] dt-bindings: leds: Add bindings for lm3697 driver
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20180906135005.6718-1-dmurphy@ti.com>
 <20180906211617.GB16899@amd> <b8ac9d52-f16d-5fc4-0e9a-9246b9f984c5@ti.com>
 <20180907133228.GA16297@amd> <70f7506c-6a3d-3830-59a4-a246dc6163f7@ti.com>
 <226b8770-7041-39a4-5a06-6002a7c1225f@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <20a814ce-a4c5-0649-6677-6b85a5fd2321@ti.com>
Date:   Mon, 10 Sep 2018 09:37:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <226b8770-7041-39a4-5a06-6002a7c1225f@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 09/08/2018 02:53 PM, Jacek Anaszewski wrote:
> Dan,
> 
> On 09/07/2018 03:52 PM, Dan Murphy wrote:
> [...]
>>>
>>>> And I think Jacek pointed out that the bindings references in this bindings
>>>> don't even exist.
>>>>
>>>> I am thinking we need to deprecate this MFD driver and consolidate these drivers
>>>> in the LED directory as we indicated before.  I did not find any ti-lmu support
>>>> code.
>>>>
>>>> ti-lmu common core code and then the LED children appending the feature differentiation.
>>>
>>>> Need some maintainer weigh in here.
>>>
>>> Hehe. I'm maintnainer. Fun.
>>
>> I know.  I want to see if there was any other opinion.  Especially for the LED driver.
>>
> [...]
> 
> I have a question - is this lm3697 LED controller a cell of some MFD
> device? Or is it a self-contained chip?
> 

This is a self contained chip.  And the LM3697 only function is a LED driver.
It does not have any other special functions like the LM363X drivers for GPIO and Regulator support.


Dan

-- 
------------------
Dan Murphy
