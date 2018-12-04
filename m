Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66083C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF13214C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nPX2GalW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF13214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbeLDIM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:12:57 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37522 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeLDIM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:12:56 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB48Cn9v044541;
        Tue, 4 Dec 2018 02:12:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543911169;
        bh=VnLDPRlFbSndgkpoOhFLnNVtv3bJvYd90Bxx1XjxpoA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nPX2GalWKLP2n+O860jAcqiyCBy2eSSM7GL5HxpVlwOywDTSS+gqDMPqkx6FBEiLS
         0XFXpcZIFbHjZZIgPSua24quSdJzxd4gvLjvCFXXOaGB0gR0+OIAjpruXQr05aPQ6o
         aAbuRHn/NXpod+pAIMgJqqGlLbIaBe4pWLUXF5sI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB48Cn5o122555
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Dec 2018 02:12:49 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 4
 Dec 2018 02:12:49 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 4 Dec 2018 02:12:49 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB48CjQX027889;
        Tue, 4 Dec 2018 02:12:45 -0600
Subject: Re: [PATCH v1 0/4] phy: qcom-qmp: Fix clock-cells binding and
 provider
To:     Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        David Brown <david.brown@linaro.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, Can Guo <cang@codeaurora.org>,
        <linux-kernel@vger.kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-soc@vger.kernel.org>
References: <20181129221357.67417-1-evgreen@chromium.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <62461d1d-2269-37f7-8d08-a116e470ad89@ti.com>
Date:   Tue, 4 Dec 2018 13:42:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129221357.67417-1-evgreen@chromium.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy Gross, David Brown, Vivek,

On 30/11/18 3:43 AM, Evan Green wrote:
> This series fixes the QMP PHY bindings, which had specified #clock-cells
> in the parent node, and had set it to 1. Putting it in the parent node is
> wrong because the clock providers are the child nodes, so this change
> moves it there. Having it set to 1 is also wrong, since nothing is ever
> specified as to what should go in that cell. So this changes it to zero.
> Finally, this change completes a little bit of code to actually allow these
> exposed clocks to be pointed at in DT.
> 
> I had no idea how to fix up ipq8074.dtsi. It seems to be completely wrong in
> that it doesn't specify #clock-cells at all, has no child nodes, and
> specifies clock-output-names in the parent node. As far as I can tell this
> doesn't work at all. But I can't add the child nodes myself because I don't know
> 1) how many there are, and 2) the registers in them. I also have no way to test it.
> 
> Speaking of testing, I was able to test this on sdm845, but haven't tested msm8996.

Can someone help test this series in msm8996?

Thanks
Kishon

> 
> This patch sits atop the UFS device nodes series [1].
> 
> [1] https://lore.kernel.org/lkml/20181026173544.136037-1-evgreen@chromium.org/
> 
> 
> 
> Evan Green (4):
>   dt-bindings: phy-qcom-qmp: Move #clock-cells to child
>   arm64: dts: qcom: msm8996: Fix QMP PHY #clock-cells
>   arm64: dts: qcom: sdm845: Fix QMP PHY #clock-cells
>   phy: qcom-qmp: Expose provided clocks to DT
> 
>  .../devicetree/bindings/phy/qcom-qmp-phy.txt  | 11 ++++-----
>  arch/arm64/boot/dts/qcom/msm8996.dtsi         |  6 +++--
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          |  4 ++--
>  drivers/phy/qualcomm/phy-qcom-qmp.c           | 23 ++++++++++++++++++-
>  4 files changed, 33 insertions(+), 11 deletions(-)
> 
