Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8A3C8C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBA3208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MHYl0tLV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MHYl0tLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBA3208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754341AbeFLLe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 07:34:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55362 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752806AbeFLLeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 07:34:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D9717602BD; Tue, 12 Jun 2018 11:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528803264;
        bh=xGTAYXGGWT7YxfXrF4M/0s9mR5yQ6HfFWSCkKV7QiH4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MHYl0tLVetOoL5choXHh2/nbBM3njDHwI/WJOsyOaV8TAMy1bkrrFdoz7E8CeFJ0I
         iXlyCsqI3/MH/NeVHP/fRJGL8/lM2vV3hngsPAblfLOYerbb28Yq+DZYaFrK/opaqM
         RHCH0hUSJtr+PUUlDHiJCf8Fg6BXqdnqscwfJrnk=
Received: from [10.79.40.126] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7C5B2602BD;
        Tue, 12 Jun 2018 11:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528803264;
        bh=xGTAYXGGWT7YxfXrF4M/0s9mR5yQ6HfFWSCkKV7QiH4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MHYl0tLVetOoL5choXHh2/nbBM3njDHwI/WJOsyOaV8TAMy1bkrrFdoz7E8CeFJ0I
         iXlyCsqI3/MH/NeVHP/fRJGL8/lM2vV3hngsPAblfLOYerbb28Yq+DZYaFrK/opaqM
         RHCH0hUSJtr+PUUlDHiJCf8Fg6BXqdnqscwfJrnk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C5B2602BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH v6 1/3] phy: Update PHY power control sequence
To:     Can Guo <cang@codeaurora.org>, subhashj@codeaurora.org,
        asutoshd@codeaurora.org, mgautam@codeaurora.org, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20180529043751.10580-1-cang@codeaurora.org>
 <20180529043751.10580-2-cang@codeaurora.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <261d2697-ed21-1562-0e6b-f9858108f2b4@codeaurora.org>
Date:   Tue, 12 Jun 2018 17:04:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180529043751.10580-2-cang@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Can,


On 5/29/2018 10:07 AM, Can Guo wrote:
> All PHYs should be powered on before register configuration starts. And
> only PCIe PHYs need an extra power control before deasserts reset state.
>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 97ef942..f779b0f 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -982,6 +982,8 @@ static int qcom_qmp_phy_com_init(struct qcom_qmp *qmp)
>   	if (cfg->has_phy_com_ctrl)
>   		qphy_setbits(serdes, cfg->regs[QPHY_COM_POWER_DOWN_CONTROL],
>   			     SW_PWRDN);
> +	else
> +		qphy_setbits(pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);

No definition of 'pcs' in this function. You are doing that in the 
second patch.
But, we should add this definition here.

Also instead of having the change like this:

+	struct qmp_phy *qphy = qmp->phys[0];
  	void __iomem *serdes = qmp->serdes;
+	void __iomem *pcs = qphy->pcs;

Let's pass 'struct qmp_phy' to qcom_qmp_phy_com_init(), and then get
'struct qcom_qmp' and 'void __iomem *pcs' from that.

So,

-static int qcom_qmp_phy_com_init(struct qcom_qmp *qmp)
+static int qcom_qmp_phy_com_init(struct qmp_phy *qphy)
  {
+       struct qcom_qmp *qmp = qphy->qmp;
         const struct qmp_phy_cfg *cfg = qmp->cfg;
         void __iomem *serdes = qmp->serdes;
         void __iomem *dp_com = qmp->dp_com;
+       void __iomem *pcs = qphy->pcs;

and

-       ret = qcom_qmp_phy_com_init(qmp);
+       ret = qcom_qmp_phy_com_init(qphy);

That looks cleaner than extracting from the 0th phys.

BRs
Vivek
>   
>   	if (cfg->has_phy_dp_com_ctrl) {
>   		qphy_setbits(dp_com, QPHY_V3_DP_COM_POWER_DOWN_CTRL,
> @@ -1127,7 +1129,8 @@ static int qcom_qmp_phy_init(struct phy *phy)
>   	 * Pull out PHY from POWER DOWN state.
>   	 * This is active low enable signal to power-down PHY.
>   	 */
> -	qphy_setbits(pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
> +	if (cfg->type == PHY_TYPE_PCIE)
> +		qphy_setbits(pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
>   
>   	if (cfg->has_pwrdn_delay)
>   		usleep_range(cfg->pwrdn_delay_min, cfg->pwrdn_delay_max);

