Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32D9C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BBDF20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TZzewEeG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BBDF20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbeLKK0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:26:42 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37654 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLKK0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:26:42 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBBAQWbg056290;
        Tue, 11 Dec 2018 04:26:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544523992;
        bh=L5gU2CnGhylx1EcelkJad5vEp7e18dyf5E3gjQ9DWA4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TZzewEeG39gwSaFJxc0SLgjjlzl60CHOl+WlZc2Qa9Dn+n4a6pPXkuPK1WQ8Unb5t
         flaNYkxpbDpBc3RhNYouKJ7FaGV3TDI2fxCrQXBsHZOj1VJlxNhu9nfuCik+9P2PJL
         EGxAd1CYWajia5OOnm0M321yY4gfRdSLcr1pseyQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBBAQWjS011081
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Dec 2018 04:26:32 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 11
 Dec 2018 04:26:32 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 11 Dec 2018 04:26:31 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBBAQRgY015978;
        Tue, 11 Dec 2018 04:26:28 -0600
Subject: Re: [PATCH v7 0/5] arm64: dts: qcom: sdm845: Add UFS DT nodes
To:     Evan Green <evgreen@chromium.org>,
        Andy Gross <andy.gross@linaro.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, Can Guo <cang@codeaurora.org>,
        <linux-kernel@vger.kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-soc@vger.kernel.org>
References: <20181210192826.241350-1-evgreen@chromium.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <1d00081d-7ef5-20fb-b04b-3b51ca9cd6da@ti.com>
Date:   Tue, 11 Dec 2018 15:56:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210192826.241350-1-evgreen@chromium.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/18 12:58 AM, Evan Green wrote:
> Update the device tree bindings for the QMP PHY to properly
> specify the registers for dual-lane PHYs. Update the driver to use
> those new registers. Add the DT nodes for UFS on SDM845 and MTP.
> Finally, fix up the USB3 PHY on SDM845, which also has a dual-lane phy
> 
> This series is now based on phy/next, and given that the changes stack,
> I guess that means Kishon will take the whole thing?

No. I'll take only the phy changes. The dts changes can probably be taken by
Andy during the early 4.21 -rc cycle.

Thanks
Kishon
> 
> Changes in v7:
>  - Rebased on top of phy/next
> 
> Changes in v6:
> - Removed resets and reset-names (Bjorn)
> - Renamed nodes (Bjorn)
> - Fix renamed nodes in MTP (Bjorn)
> 
> Changes in v5:
> - Fix incorrect register value in example, copied from real life!
> 
> Changes in v4:
> - Remove "status" from DT binding example (Rob)
> 
> Changes in v3:
>  - Removed erroneous fixup for USB UniPro PHY, which is not dual lane (Doug)
> 
> Changes in v2:
> - Added dt bindings change, corresponding driver fixup, and USB PHY fixup
> - Renamed ufsphy to phy (Vivek)
> - Removed #clock-cells (Vivek)
> 
> Can Guo (1):
>   arm64: dts: qcom: sdm845: Add UFS nodes for sdm845-mtp
> 
> Evan Green (4):
>   dt-bindings: phy-qcom-qmp: Fix register underspecification
>   phy: qcom-qmp: Utilize fully-specified DT registers
>   arm64: dts: qcom: sdm845: add UFS controller
>   arm64: dts: qcom: sdm845: Add USB PHY lane two
> 
>  .../devicetree/bindings/phy/qcom-qmp-phy.txt  | 69 +++++++++++++++++--
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts       | 14 ++++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 68 +++++++++++++++++-
>  drivers/phy/qualcomm/phy-qcom-qmp.c           | 51 ++++++++++----
>  4 files changed, 181 insertions(+), 21 deletions(-)
> 
