Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05BDC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763B3204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Uy67dr9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763B3204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeJIOsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:48:46 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38178 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeJIOsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:48:45 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w997X40u027885;
        Tue, 9 Oct 2018 02:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539070384;
        bh=ckoYC9dMIavsd3sNi2wJ9sd7zlN+XfwAfNGdGMDo9yE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Uy67dr9c3ga7mUYh+86lwd0dpx732aj6cvFKaxA4798G6fpRokALktz2yZo6HcGuf
         RgGuvE5CVA8mnbqv+HcPVAupc5VWzhMwqlSXUtL1B5knfhi2cwSEZiGMSGdHh5G/U8
         CvPImo+/iu+3+dQAdUKCMplY8vh3TfrI+WS+IMAU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w997X2r3026762;
        Tue, 9 Oct 2018 02:33:04 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 9 Oct
 2018 02:33:03 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 9 Oct 2018 02:33:03 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w997X0XK008844;
        Tue, 9 Oct 2018 02:33:01 -0500
Subject: Re: [PATCH 5/6] mmc: sdhci-of-arasan: Add Support for AM654 MMC and
 PHY
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Kishon <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20181004111451.9539-1-faiz_abbas@ti.com>
 <20181004111451.9539-6-faiz_abbas@ti.com>
 <CAPDyKFpRU1bQB6LMt30c8hGhTYnYp7FBVOz092TEzkiXfoDdgQ@mail.gmail.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <f1979ee5-404b-4397-8acb-837fbda83eec@ti.com>
Date:   Tue, 9 Oct 2018 13:05:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpRU1bQB6LMt30c8hGhTYnYp7FBVOz092TEzkiXfoDdgQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uffe,

On Tuesday 09 October 2018 01:00 PM, Ulf Hansson wrote:
> On 4 October 2018 at 13:14, Faiz Abbas <faiz_abbas@ti.com> wrote:
>> The current arasan sdhci PHY configuration isn't compatible
>> with the PHY on TI's AM654 devices.
>>
>> Therefore, add a new compatible, AM654 specific quirks
>> and a new AM654 specific set_clock function which
>> configures the PHY in a sane way.
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> 
> Applied for next, thanks!
> 

Do I need to repost these in the v2 ?

Thanks,
Faiz
