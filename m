Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F626C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59152086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Age0dHDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59152086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeIKWTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:19:48 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41850 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbeIKWTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:19:48 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8BHJ57C080211;
        Tue, 11 Sep 2018 12:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536686345;
        bh=G/7VGqi1rFlhqIKMBTA+KsBERCvp2xGLVWe2ysfFKVM=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=Age0dHDwajrupu39b4eCMwtpnvp05bEwZhFAbTeRxbFmHPtMQ5Lmk/xQH+nWXR8Yl
         5fclHey/jlKpVYWZVIalZd5GIRv8rSXFd6psG6GEBffnYyNVjFGB5nQOcaOCQ5bJAL
         gic2VToi8gW3O2cD3HijFqmuwlSsMvvZOl3rjMzc=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8BHJ5A0002207;
        Tue, 11 Sep 2018 12:19:05 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 11
 Sep 2018 12:19:05 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 11 Sep 2018 12:19:05 -0500
Received: from [172.22.156.248] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8BHJ4TZ030912;
        Tue, 11 Sep 2018 12:19:04 -0500
Subject: Re: [PATCH] mfd: ti-lmu: constify mfd_cell tables
From:   Dan Murphy <dmurphy@ti.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <tony@atomide.com>, <sre@kernel.org>,
        <nekit1000@gmail.com>, <mpartap@gmx.net>, <merlijn@wizzup.org>
References: <20180829093108.GB22065@amd> <20180907093954.GA26364@amd>
 <e10bdc74-8138-055e-c829-7befbc7161b4@ti.com> <20180911155355.GD4185@dell>
 <a74f7980-08bf-5ef0-106b-1e3f4e90b0e6@ti.com>
Message-ID: <e8423cfb-2a23-1332-955f-6af5b0ddaecd@ti.com>
Date:   Tue, 11 Sep 2018 12:18:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a74f7980-08bf-5ef0-106b-1e3f4e90b0e6@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee

On 09/11/2018 12:08 PM, Dan Murphy wrote:
> Lee
> 
> On 09/11/2018 10:57 AM, Lee Jones wrote:
>> On Fri, 07 Sep 2018, Dan Murphy wrote:
>>
>>> Pavel
>>>
>>> On 09/07/2018 04:39 AM, Pavel Machek wrote:
>>>> On Wed 2018-08-29 11:31:08, Pavel Machek wrote:
>>>>> From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>>>>>
>>>>> mfd: ti-lmu: constify mfd_cell tables
>>>>>     
>>>>> Add const attribute to all mfd_cell structures.
>>>>>     
>>>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>>>>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>>>>
>>>> Lee, I guess this is for you to apply. Any news there?
>>>>
>>>> There are more patches ready,
>>>
>>> As I stated in another email thread.  I don't see the need for this level of LMU framework.
>>>
>>> Here is the reference thread
>>>
>>> https://lore.kernel.org/patchwork/patch/982550/
>>
>> This driver has been present for 1.5 years.
>>
>> Is that a NACK for *this* patch or are you hijacking? :)
>>
> 
> Its a NACK for adding this.  I am pushing a new series for the LM3697 and will end up
> sending LED drivers for the non-MFD devices contained within. I will try to match the
> feature set the best I can.
> 

Sorry it is a NACK for adding the backlight series.  This patch is fine.

Dan

-- 
------------------
Dan Murphy
