Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E3C14C004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9536D208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ftjh0LwE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="B4/8vu2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9536D208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934761AbeFLA1i (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:27:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51666 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934716AbeFLA1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:27:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2E91A606FA; Tue, 12 Jun 2018 00:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528763255;
        bh=8bRmaUZJ8/S1WMiqrWwYATODjR54CvfGZiiPPGgZOR4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ftjh0LwExmn0mcZa+9JaxTxX7jjJtlGkuSZtI8bthbUTbSXqTcEiZfgAs6TLfilo6
         NOfiVOrIp6rQUqS+4mSk29xjKVJxu2xjcE7xkb2/0FnQBeDrZ5PGtua7Niu4P13USi
         IEdGDeeq8vXRAChWPBvlDqAye4Si7+40ORBJzuKQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7694160351;
        Tue, 12 Jun 2018 00:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528763254;
        bh=8bRmaUZJ8/S1WMiqrWwYATODjR54CvfGZiiPPGgZOR4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B4/8vu2NZe/soEPbljXKgJdfn8zgYFgSvhgr7wKl2CC/BbHjbB2RXZzpTYRI7ZsJ5
         P6JOseik9lZPyNvoO/wy6fPu0F+5IU+dcbpn2rvYn2i8kBwkHezub9mBuYZ1a+PsxM
         91rBD/XKqETaoVALG4K4wlf6JZ3xsWEgZ7Y0haSQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 12 Jun 2018 08:27:34 +0800
From:   cang@codeaurora.org
To:     Manu Gautam <mgautam@codeaurora.org>
Cc:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, kishon@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/3] phy: Update PHY power control sequence
In-Reply-To: <9954c362-c144-9e5f-8b06-687c856ed25a@codeaurora.org>
References: <20180529043751.10580-1-cang@codeaurora.org>
 <20180529043751.10580-2-cang@codeaurora.org>
 <9954c362-c144-9e5f-8b06-687c856ed25a@codeaurora.org>
Message-ID: <7b5f62c60cc3a2c3b9d7c4e99dcde01b@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-08 14:45, Manu Gautam wrote:
> Hi,
> 
> On 5/29/2018 10:07 AM, Can Guo wrote:
>> All PHYs should be powered on before register configuration starts. 
>> And
>> only PCIe PHYs need an extra power control before deasserts reset 
>> state.
>> 
>> Signed-off-by: Can Guo <cang@codeaurora.org>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qmp.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c 
>> b/drivers/phy/qualcomm/phy-qcom-qmp.c
>> index 97ef942..f779b0f 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
>> @@ -982,6 +982,8 @@ static int qcom_qmp_phy_com_init(struct qcom_qmp 
>> *qmp)
>>  	if (cfg->has_phy_com_ctrl)
>>  		qphy_setbits(serdes, cfg->regs[QPHY_COM_POWER_DOWN_CONTROL],
>>  			     SW_PWRDN);
>> +	else
>> +		qphy_setbits(pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
> 
> We should power-up PHYs after following dp_com_ctrl programming which
> powers-off USB-DP combo PHY when it brings DP_COM block out of reset 
> reset.
> 
> 

Sure Manu

>> 
>>  	if (cfg->has_phy_dp_com_ctrl) {
>>  		qphy_setbits(dp_com, QPHY_V3_DP_COM_POWER_DOWN_CTRL,
>> @@ -1127,7 +1129,8 @@ static int qcom_qmp_phy_init(struct phy *phy)
>>  	 * Pull out PHY from POWER DOWN state.
>>  	 * This is active low enable signal to power-down PHY.
>>  	 */
>> -	qphy_setbits(pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
>> +	if (cfg->type == PHY_TYPE_PCIE)
>> +		qphy_setbits(pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
>> 
>>  	if (cfg->has_pwrdn_delay)
>>  		usleep_range(cfg->pwrdn_delay_min, cfg->pwrdn_delay_max);
