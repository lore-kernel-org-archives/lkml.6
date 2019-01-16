Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C68C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD67B20866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WumqRMnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392679AbfAPLvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:51:10 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49034 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732464AbfAPLvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:51:09 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0GBovwx062270;
        Wed, 16 Jan 2019 05:50:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547639457;
        bh=tYxDA4HmGnz/KpCENLcL9weSRRCin0yaGYKicFcaemM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WumqRMnPHIpAzO6PmLh+ftDQIdJlfWdlu15xDscX69kHRZ3SNQ2gYeYhFII6FQY/I
         sCY54YR3opZXjz+itkOFLN8OHi+i6SOHskWaJ4hb+LMdGrzTcEyQsyS//hrSr7KGqr
         jAoJti9dx966BcjACI8xtN+ykDD6QQcLJqGwxOjo=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0GBov0D093970
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 05:50:57 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 16
 Jan 2019 05:50:56 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 16 Jan 2019 05:50:56 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0GBoqdT000338;
        Wed, 16 Jan 2019 05:50:53 -0600
Subject: Re: [PATCH v1] phy: qcom-ufs: Use iopoll.h readl_poll_timeout macro
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
CC:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Matt Wagantall <mattw@codeaurora.org>,
        Mitchel Humpherys <mitchelh@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <88cd3a2e-2acc-02ff-9f27-284d3b679d10@free.fr>
 <20181228160546.GC25288@hector.attlocal.net>
 <839a30f7-b3fa-739a-52b4-5438e8573dc3@free.fr>
 <01b81f00-dc33-cc33-53e6-c937548aa7ab@ti.com>
 <94402bb7-2bc3-96fc-f37e-c0e57698cdc7@free.fr>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <482c70fc-859f-47c0-ec7e-d8e200294f1d@ti.com>
Date:   Wed, 16 Jan 2019 17:20:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <94402bb7-2bc3-96fc-f37e-c0e57698cdc7@free.fr>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/01/19 4:00 PM, Marc Gonzalez wrote:
> On 16/01/2019 10:24, Kishon Vijay Abraham I wrote:
> 
>> On 16/01/19 2:40 PM, Marc Gonzalez wrote:
>>
>>> Would this patch go through your tree or Kishon's tree?
>>
>> I've merged this in phy -next.
> 
> Thanks Kishon.
> 
> Do you mean here?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git/log/?h=next

yes.

Thanks
Kishon
