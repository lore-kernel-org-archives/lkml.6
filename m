Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F97C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E239B2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JEjsbkRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E239B2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeIKWJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:09:08 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41128 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbeIKWJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:09:06 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8BH8UHF078130;
        Tue, 11 Sep 2018 12:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536685710;
        bh=48BnGsqpufZsLuTGJjEBer/VX5ZFoOsc0ipQLKqoKUI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JEjsbkRm9Qvw4afHu69ZFqA2bB/5lSnoXLllv9Dj7lHIgyj7T2qDAcltTrSfHHRoc
         NyLGTFk6NWReKtmKIIHdlF/MOI+ax9utBJq7h2b7JhpDmatTtjg4/tmNjVNsLzs3jf
         XZQCCpH3wYCaEnWtDp5zRtmIDnkW1PZgf2gATilg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8BH8Uls031333;
        Tue, 11 Sep 2018 12:08:30 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 11
 Sep 2018 12:08:30 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 11 Sep 2018 12:08:30 -0500
Received: from [172.22.156.248] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8BH8TT8015215;
        Tue, 11 Sep 2018 12:08:29 -0500
Subject: Re: [PATCH] mfd: ti-lmu: constify mfd_cell tables
To:     Lee Jones <lee.jones@linaro.org>
CC:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <tony@atomide.com>, <sre@kernel.org>,
        <nekit1000@gmail.com>, <mpartap@gmx.net>, <merlijn@wizzup.org>
References: <20180829093108.GB22065@amd> <20180907093954.GA26364@amd>
 <e10bdc74-8138-055e-c829-7befbc7161b4@ti.com> <20180911155355.GD4185@dell>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <a74f7980-08bf-5ef0-106b-1e3f4e90b0e6@ti.com>
Date:   Tue, 11 Sep 2018 12:08:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911155355.GD4185@dell>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee

On 09/11/2018 10:57 AM, Lee Jones wrote:
> On Fri, 07 Sep 2018, Dan Murphy wrote:
> 
>> Pavel
>>
>> On 09/07/2018 04:39 AM, Pavel Machek wrote:
>>> On Wed 2018-08-29 11:31:08, Pavel Machek wrote:
>>>> From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>>>>
>>>> mfd: ti-lmu: constify mfd_cell tables
>>>>     
>>>> Add const attribute to all mfd_cell structures.
>>>>     
>>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>>>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>>>
>>> Lee, I guess this is for you to apply. Any news there?
>>>
>>> There are more patches ready,
>>
>> As I stated in another email thread.  I don't see the need for this level of LMU framework.
>>
>> Here is the reference thread
>>
>> https://lore.kernel.org/patchwork/patch/982550/
> 
> This driver has been present for 1.5 years.
> 
> Is that a NACK for *this* patch or are you hijacking? :)
> 

Its a NACK for adding this.  I am pushing a new series for the LM3697 and will end up
sending LED drivers for the non-MFD devices contained within. I will try to match the
feature set the best I can.

-- 
------------------
Dan Murphy
