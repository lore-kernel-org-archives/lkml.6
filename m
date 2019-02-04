Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1631EC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93B32082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ntsfjvmK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ntsfjvmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfBDSIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:08:40 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41022 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbfBDSIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:08:40 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C545460740; Mon,  4 Feb 2019 18:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549303718;
        bh=VEGEPppYtp4tksljMvn+7wO6QreTIClSrETCcYlkXiE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ntsfjvmKDpi/TPpGDovh3fpJnO34LKuhEGzN127i5hj0ftq055dXm3/VnRyqDDIks
         GTZhrHie5kHSGTF9aCdvtsYQq6tEFf6pYUFFNwirp05Yks9au6VUXkf/a/xP7j5dPv
         SBWfD7w38ZKUQJSlCaQC4Xh61H3pC/JRrDE3YBbA=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 820E56030D;
        Mon,  4 Feb 2019 18:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549303718;
        bh=VEGEPppYtp4tksljMvn+7wO6QreTIClSrETCcYlkXiE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ntsfjvmKDpi/TPpGDovh3fpJnO34LKuhEGzN127i5hj0ftq055dXm3/VnRyqDDIks
         GTZhrHie5kHSGTF9aCdvtsYQq6tEFf6pYUFFNwirp05Yks9au6VUXkf/a/xP7j5dPv
         SBWfD7w38ZKUQJSlCaQC4Xh61H3pC/JRrDE3YBbA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 820E56030D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v3 3/5] dt-bindings: phy-qcom-qmp: Add
 qcom,msm8998-qmp-ufs-phy
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        DT <devicetree@vger.kernel.org>
References: <e3c82a49-c601-effc-348f-f768656c659f@free.fr>
 <73f65f2d-2137-1d2b-be19-eae77773ccc1@free.fr>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <5c18d9c4-a65c-1dbb-dc19-34db9717a33a@codeaurora.org>
Date:   Mon, 4 Feb 2019 11:08:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <73f65f2d-2137-1d2b-be19-eae77773ccc1@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/2019 10:38 AM, Marc Gonzalez wrote:
> Add compatible string for QMP UFS phy on msm8998.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>   Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> index 41a1074228ba..6ec278f5af86 100644
> --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> @@ -9,6 +9,7 @@ Required properties:
>   	       "qcom,ipq8074-qmp-pcie-phy" for PCIe phy on IPQ8074
>   	       "qcom,msm8996-qmp-pcie-phy" for 14nm PCIe phy on msm8996,
>   	       "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996,
> +	       "qcom,msm8998-qmp-ufs-phy" for UFS QMP phy on msm8998,
>   	       "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
>   	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845,
>   	       "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845.
> 

I think this needs to be based on phy-next, otherwise I forsee a merge 
conflict.

Also, I would expect changes to the rest of the file as well (what 
clocks are required, etc).

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
