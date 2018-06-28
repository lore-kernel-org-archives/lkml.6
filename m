Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661DCC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC8326197
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HTydpI44";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CVBMSXbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC8326197
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbeF1DqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 23:46:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48110 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752057AbeF1DqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 23:46:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2963E60B6B; Thu, 28 Jun 2018 03:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530157580;
        bh=Z4LOTTo8aSEEVRpqfRal8HcZDzCfC9iTsc6Mx6N9KfQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HTydpI44cI/HEv0I3lroQ5RAVcpSm/AOi/6ItAyUwZjsdAqUuIgRHt5lrtr5NqRaK
         ASVBbNwC7rGlh3VVn6uT1Oy/WasotGPvl3H2QVFlXY/Y4CtXNddmistDaRkZyTpq6n
         ZVZ95v3SGb+vEsc7JlXJn6qAGp67m48qL4pB5c90=
Received: from [10.206.25.22] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CF8C860B19;
        Thu, 28 Jun 2018 03:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530157576;
        bh=Z4LOTTo8aSEEVRpqfRal8HcZDzCfC9iTsc6Mx6N9KfQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CVBMSXbCg2wmxtpY0HvJ/VULIK7eaKDfsmfYNPiCLj132RJdMJYoDUJlDj2n1R1m8
         Dwuom/TXGHW07yyPYJG/aKFci9Daid4p5pSThCsE92GdlrFsNDqcrv+R+lXUosgK3H
         m9VcYl9MYNU+7HadltQdPgtmVWTKNJw7tvf2Vt3Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CF8C860B19
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH v7 3/4] phy: Add QMP phy based UFS phy support for sdm845
To:     Can Guo <cang@codeaurora.org>, subhashj@codeaurora.org,
        asutoshd@codeaurora.org, vivek.gautam@codeaurora.org,
        kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20180619083647.10116-1-cang@codeaurora.org>
 <20180619083647.10116-4-cang@codeaurora.org>
From:   Manu Gautam <mgautam@codeaurora.org>
Message-ID: <996e8b41-9090-7961-45c0-fdf6fc83c30a@codeaurora.org>
Date:   Thu, 28 Jun 2018 09:16:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619083647.10116-4-cang@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/19/2018 2:06 PM, Can Guo wrote:
> +static int qcom_qmp_phy_poweron(struct phy *phy)
> +{
> +	struct qmp_phy *qphy = phy_get_drvdata(phy);
> +	struct qcom_qmp *qmp = qphy->qmp;
> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +	void __iomem *pcs = qphy->pcs;
> +	void __iomem *status;
> +	unsigned int mask, val;
> +	int ret = 0;
> +
> +	if (cfg->type != PHY_TYPE_UFS)
> +		return 0;
> +
> +	/*
> +	 * For UFS PHY that has not software reset control, serdes start
> +	 * should only happen when UFS driver explicitly calls phy_power_on
> +	 * after it deasserts software reset.
> +	 */

Instead of relying on UFS glue driver to assert/de-assert PHY
which requires UFS PHY initialization to be split in init() and
poweron(), we can rather register reset_controller from ufs-qcom
driver.
PHY driver can then assert/de-assert as per UFS PHY requirement
in init() function itself and there won't be any need to have
poweron() routine for UFS as init can perform complete PHY
initialization without any dependency on ufs-qcom glue driver.

-Manu

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
