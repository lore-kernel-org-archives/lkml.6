Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DE0E4C004E4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85BA6208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nR8qjG4z";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HYt/BnUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85BA6208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935843AbeFNBOd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 21:14:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43150 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935532AbeFNBOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 21:14:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8CE6760717; Thu, 14 Jun 2018 01:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528938871;
        bh=zGCzNGGu5eiX2EdHSOgxpmNvjxoaz5UH8fP5UMNuMUk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nR8qjG4zVeCSltx/jus5b7BHLE0OCoJbXHpZ7qTheU9Lhn5jS7ZpawM7ThnhSiWNM
         2uYjM7jK+5/R1ESJ2NEZKjT/kYF6jvQi0L8+AoilLAkLaM2J34WacosGmYyxIUjHB6
         DVLwhtDkf8yDddBI0tddUtLPqNE859xveo7NYePI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id D42B46055D;
        Thu, 14 Jun 2018 01:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528938870;
        bh=zGCzNGGu5eiX2EdHSOgxpmNvjxoaz5UH8fP5UMNuMUk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HYt/BnUvtNEkD/0Sz5ora6hlAHvbxpTU+7vJXPDCKAMVLkTyg1bp8nL17mfEGLges
         +Wzpfz8eouyh7YxA3/AbeWJ9q3hxMu2AAT35gaUYwfAiSukfy7w6vIF/HWIk1ojRzZ
         plXNYuMK/mhu1UD52aYz8P5JJK/eJYHwLjIISLAc=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 14 Jun 2018 09:14:30 +0800
From:   cang@codeaurora.org
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        mgautam@codeaurora.org, kishon@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/3] phy: Update PHY power control sequence
In-Reply-To: <261d2697-ed21-1562-0e6b-f9858108f2b4@codeaurora.org>
References: <20180529043751.10580-1-cang@codeaurora.org>
 <20180529043751.10580-2-cang@codeaurora.org>
 <261d2697-ed21-1562-0e6b-f9858108f2b4@codeaurora.org>
Message-ID: <c891f513544f26eec480ebe91f257617@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-12 19:34, Vivek Gautam wrote:
> Hi Can,
> 
> 
> On 5/29/2018 10:07 AM, Can Guo wrote:
>> All PHYs should be powered on before register configuration starts. 
>> And
>> only PCIe PHYs need an extra power control before deasserts reset 
>> state.
>> 
>> Signed-off-by: Can Guo <cang@codeaurora.org>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c 
>> b/drivers/phy/qualcomm/phy-qcom-qmp.c
>> index 97ef942..f779b0f 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
>> @@ -982,6 +982,8 @@ static int qcom_qmp_phy_com_init(struct qcom_qmp 
>> *qmp)
>>   	if (cfg->has_phy_com_ctrl)
>>   		qphy_setbits(serdes, cfg->regs[QPHY_COM_POWER_DOWN_CONTROL],
>>   			     SW_PWRDN);
>> +	else
>> +		qphy_setbits(pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
> 
> No definition of 'pcs' in this function. You are doing that in the 
> second patch.
> But, we should add this definition here.
> 
> Also instead of having the change like this:
> 
> +	struct qmp_phy *qphy = qmp->phys[0];
>  	void __iomem *serdes = qmp->serdes;
> +	void __iomem *pcs = qphy->pcs;
> 
> Let's pass 'struct qmp_phy' to qcom_qmp_phy_com_init(), and then get
> 'struct qcom_qmp' and 'void __iomem *pcs' from that.
> 
> So,
> 
> -static int qcom_qmp_phy_com_init(struct qcom_qmp *qmp)
> +static int qcom_qmp_phy_com_init(struct qmp_phy *qphy)
>  {
> +       struct qcom_qmp *qmp = qphy->qmp;
>         const struct qmp_phy_cfg *cfg = qmp->cfg;
>         void __iomem *serdes = qmp->serdes;
>         void __iomem *dp_com = qmp->dp_com;
> +       void __iomem *pcs = qphy->pcs;
> 
> and
> 
> -       ret = qcom_qmp_phy_com_init(qmp);
> +       ret = qcom_qmp_phy_com_init(qphy);
> 
> That looks cleaner than extracting from the 0th phys.
> 
> BRs
> Vivek

Sure Vivek

>>     	if (cfg->has_phy_dp_com_ctrl) {
>>   		qphy_setbits(dp_com, QPHY_V3_DP_COM_POWER_DOWN_CTRL,
>> @@ -1127,7 +1129,8 @@ static int qcom_qmp_phy_init(struct phy *phy)
>>   	 * Pull out PHY from POWER DOWN state.
>>   	 * This is active low enable signal to power-down PHY.
>>   	 */
>> -	qphy_setbits(pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
>> +	if (cfg->type == PHY_TYPE_PCIE)
>> +		qphy_setbits(pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
>>     	if (cfg->has_pwrdn_delay)
>>   		usleep_range(cfg->pwrdn_delay_min, cfg->pwrdn_delay_max);
