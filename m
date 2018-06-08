Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fcbjHqIlGluKdgAAmS7hNA
	; Fri, 08 Jun 2018 06:46:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CF1A36089E; Fri,  8 Jun 2018 06:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528440366;
	bh=wEgGyY31CNWlDIO1+auh0/3RG8TqpFjApAsKhWLJiEw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=AbBVEGGCCAcLEk+hScLy4nyr7opfbW0DUwfzkYLarIndWsEB+fFCSFqsBSF/jkq7W
	 lQ7qMI0K22bZmEc9IDDKv2HH4/eWn28rWC4YmZ03jYLghHUn1obkjj+v+J562jcgcJ
	 4H7VSdXYLvsykSd9Pa7kpgkuIRY18v2heXV5/RdE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4920160275;
	Fri,  8 Jun 2018 06:46:06 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OzqfgFxf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OzqfgFxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4920160275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752693AbeFHGqE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 02:46:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51158 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeFHGqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 02:46:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9EBC66074D; Fri,  8 Jun 2018 06:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528440361;
        bh=wEgGyY31CNWlDIO1+auh0/3RG8TqpFjApAsKhWLJiEw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OzqfgFxfL5D+e4ySBHUChkDwFsdl5HweXuS+IgsSB+3dGhJHSTLcAsDaVeVplKpQv
         0iPhyfNbOYh4K3xIq/l6Q9OYKatEvFEBQ+2qRlObX7yhFiuoUOckomIKYa8Y4YZkcm
         vL9S1ABoUh2SAp2SD69m18/Yo3McKdGePkYcOFbY=
Received: from [10.206.25.22] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 06FB96074D;
        Fri,  8 Jun 2018 06:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528440361;
        bh=wEgGyY31CNWlDIO1+auh0/3RG8TqpFjApAsKhWLJiEw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OzqfgFxfL5D+e4ySBHUChkDwFsdl5HweXuS+IgsSB+3dGhJHSTLcAsDaVeVplKpQv
         0iPhyfNbOYh4K3xIq/l6Q9OYKatEvFEBQ+2qRlObX7yhFiuoUOckomIKYa8Y4YZkcm
         vL9S1ABoUh2SAp2SD69m18/Yo3McKdGePkYcOFbY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06FB96074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH v6 1/3] phy: Update PHY power control sequence
To: Can Guo <cang@codeaurora.org>, subhashj@codeaurora.org,
        asutoshd@codeaurora.org, vivek.gautam@codeaurora.org,
        kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20180529043751.10580-1-cang@codeaurora.org>
 <20180529043751.10580-2-cang@codeaurora.org>
From: Manu Gautam <mgautam@codeaurora.org>
Message-ID: <9954c362-c144-9e5f-8b06-687c856ed25a@codeaurora.org>
Date: Fri, 8 Jun 2018 12:15:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180529043751.10580-2-cang@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/29/2018 10:07 AM, Can Guo wrote:
> All PHYs should be powered on before register configuration starts. And
> only PCIe PHYs need an extra power control before deasserts reset state.
>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 97ef942..f779b0f 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -982,6 +982,8 @@ static int qcom_qmp_phy_com_init(struct qcom_qmp *qmp)
>  	if (cfg->has_phy_com_ctrl)
>  		qphy_setbits(serdes, cfg->regs[QPHY_COM_POWER_DOWN_CONTROL],
>  			     SW_PWRDN);
> +	else
> +		qphy_setbits(pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);

We should power-up PHYs after following dp_com_ctrl programming which
powers-off USB-DP combo PHY when it brings DP_COM block out of reset reset.


>  
>  	if (cfg->has_phy_dp_com_ctrl) {
>  		qphy_setbits(dp_com, QPHY_V3_DP_COM_POWER_DOWN_CTRL,
> @@ -1127,7 +1129,8 @@ static int qcom_qmp_phy_init(struct phy *phy)
>  	 * Pull out PHY from POWER DOWN state.
>  	 * This is active low enable signal to power-down PHY.
>  	 */
> -	qphy_setbits(pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
> +	if (cfg->type == PHY_TYPE_PCIE)
> +		qphy_setbits(pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
>  
>  	if (cfg->has_pwrdn_delay)
>  		usleep_range(cfg->pwrdn_delay_min, cfg->pwrdn_delay_max);

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
