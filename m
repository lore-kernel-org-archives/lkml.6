Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396B8ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D8A21480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EXESQGXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D8A21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbeIYMtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 08:49:18 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33590 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeIYMtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 08:49:18 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8P6h5aF070985;
        Tue, 25 Sep 2018 01:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537857785;
        bh=zPQ8IGZqUdsRUMH/XUBuraPPRWqifK06qT+lKuuV+4M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EXESQGXP24jOnmUTg4lAK/wPBFVXIzSViqHNtF10YAscmqv18xElWWC5vR7r81DeR
         dFEc81W323dNsnJhwNJiHTgr2iD29GF38zW0UGARj6h9rvixJX7HVDFkS5oCn+GNJ5
         5BqBr3ukDUI6t+8Xr3tRASC/FmI9fe7/tNUeQdEw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8P6h5er027403;
        Tue, 25 Sep 2018 01:43:05 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 25
 Sep 2018 01:43:05 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 25 Sep 2018 01:43:05 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8P6h1Tn013954;
        Tue, 25 Sep 2018 01:43:02 -0500
Subject: Re: [PATCH 0/3] scsi: ufs-qcom: Remove all direct calls to qcom-ufs
 phy
To:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        <vinholikatti@gmail.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
CC:     <subhashj@codeaurora.org>, <bjorn.andersson@linaro.org>,
        <evgreen@chromium.org>, <linux-arm-msm@vger.kernel.org>
References: <20180904101719.18049-1-vivek.gautam@codeaurora.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <75d4820c-d154-cc5c-e7b6-72defdfdce5e@ti.com>
Date:   Tue, 25 Sep 2018 12:12:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904101719.18049-1-vivek.gautam@codeaurora.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

On Tuesday 04 September 2018 03:47 PM, Vivek Gautam wrote:
> Cleaning up the ufs-qcom host further to remove all direct calls
> into qcom-ufs driver.
> Only phy-qcom-ufs-qmp-20nm phy handles these direct calls from ufs host
> and this phy is not used in any supported qcom platform in current kernel.
> So, while we free up the host from all the ufs_qcom_phy_*() API calls
> we should declare 20nm phy as broken.
> For this we fork out couple of configs from PHY_QCOM_UFS -
> PHY_QCOM_UFS_14NM and PHY_QCOM_UFS_20NM out of which we declare
> PHY_QCOM_UFS_20NM as 'broken'.
> 
> This series helps in a clean use of ufs phy support for sdm845
> and further SoCs that will also use phy-qcom-qmp phy driver.

I think this entire series should go via linux-phy tree. I need ACK from UFS
MAINTAINER for the second patch.

Thanks
Kishon
