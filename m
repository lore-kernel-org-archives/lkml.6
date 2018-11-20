Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47872C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21CB20672
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rhjaDhdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21CB20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbeKTXY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:24:28 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44028 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeKTXY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:24:27 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAKCtP44125091;
        Tue, 20 Nov 2018 06:55:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542718525;
        bh=IQiSkezBe/fENw/oC9Zuiv7lHcp6g+QOmYfTS8x9BWM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rhjaDhdH4w/8AmwanU+zRXYqi/MqJFa698KPtUUbsRP9xeEmED9Luy1FTa4gk3amB
         l+WJYezWe8a6bWRVByRYKVbo198TelaZYdaM1La9pylvlQRf4TAUaPteJiPZXngjCT
         6LdWOV7bQ5bxFUymMal4Tz7Cki9BEcbrhRG2dcFY=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAKCtPj0085029
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Nov 2018 06:55:25 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 20
 Nov 2018 06:55:25 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 20 Nov 2018 06:55:25 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAKCtNtH027779;
        Tue, 20 Nov 2018 06:55:23 -0600
Subject: Re: [PATCH 2/4] mmc: sdhci-omap: Add variable to indicate host is
 tuning
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Kishon <kishon@ti.com>, Adrian Hunter <adrian.hunter@intel.com>
References: <20181119111618.2745-1-faiz_abbas@ti.com>
 <20181119111618.2745-3-faiz_abbas@ti.com>
 <CAPDyKFqkscm9ZhJhk7SWFc_tmqqqXSx5_t2tzEL-DV6aE+Q=KA@mail.gmail.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <c3379377-54d3-b9bf-c910-11b8987b7e2c@ti.com>
Date:   Tue, 20 Nov 2018 18:28:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqkscm9ZhJhk7SWFc_tmqqqXSx5_t2tzEL-DV6aE+Q=KA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uffe,

On 19/11/18 6:48 PM, Ulf Hansson wrote:
> On 19 November 2018 at 12:16, Faiz Abbas <faiz_abbas@ti.com> wrote:
>> Add a variable in sdhc_omap_host to indicate whether a tuning
>> operation is ongoing.
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> 
> Please squash this into patch3 as it seems a bit silly to keep this a
> separate change.
> 

Ok. Squashing 2 and 3.

Thanks,
Faiz
