Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EDBC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC51208B6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eT6SUEab";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fugRzMLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC51208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbeGFICA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:02:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40662 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbeGFIB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:01:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0397560B27; Fri,  6 Jul 2018 08:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530864118;
        bh=Wo/Hp44k3vtY/ijKXUsCrqX9e90itET84COIYMqBkKs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eT6SUEabGLylVyp22XiURzMYE+6RzAbYV72wX2PhtxxUJ7UYTB7p4vmOQN981aSc/
         T4jwhu/9LJDI8iY5+AFtx1FxNvl45/+vV2R9XXCk4AO5NTNT291lUPc0qPj1zqJa06
         UkMqkI5D6pv+r9/yaZl8DAmbnZJoPxlTW6CLUbsg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id EA41860646;
        Fri,  6 Jul 2018 08:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530864117;
        bh=Wo/Hp44k3vtY/ijKXUsCrqX9e90itET84COIYMqBkKs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fugRzMLPIU4tUWKFqSq6mzcvO8zbh138QmhI5RlIxlrdjP1SKy3pi3316qnuSgx2I
         YibK6Gzmyrr1mv6kYNRVyJn0w0bBAkQQKxj8mO6PQmKrGrfPy1VORxlVupMZDMYkAN
         lGoaVoS0LF3A0dHcIFsUYpscnRqnWp0C9NqBAq6I=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 06 Jul 2018 16:01:56 +0800
From:   cang@codeaurora.org
To:     Evan Green <evgreen@chromium.org>
Cc:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, Manu Gautam <mgautam@codeaurora.org>,
        kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 3/4] phy: Add QMP phy based UFS phy support for sdm845
In-Reply-To: <CAE=gft4153GviYtYuoREgyPkwxwnejHG+t+H8MB+Jv1TXTouSA@mail.gmail.com>
References: <20180619083647.10116-1-cang@codeaurora.org>
 <20180619083647.10116-4-cang@codeaurora.org>
 <CAE=gft4153GviYtYuoREgyPkwxwnejHG+t+H8MB+Jv1TXTouSA@mail.gmail.com>
Message-ID: <af9adedb9312955c58f9fcf14b43d03b@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-28 04:17, Evan Green wrote:
> On Tue, Jun 19, 2018 at 1:38 AM Can Guo <cang@codeaurora.org> wrote:
>> 
>> Add UFS PHY support to make SDM845 UFS work with common PHY framework.
>> 
>> Signed-off-by: Can Guo <cang@codeaurora.org>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qmp.c | 173 
>> +++++++++++++++++++++++++++++++++++-
>>  drivers/phy/qualcomm/phy-qcom-qmp.h |  15 ++++
>>  2 files changed, 187 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c 
>> b/drivers/phy/qualcomm/phy-qcom-qmp.c
>> index 9be9754..852792d 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> ...
>>  static void qcom_qmp_phy_configure(void __iomem *base,
>>                                    const unsigned int *regs,
>>                                    const struct qmp_phy_init_tbl 
>> tbl[],
>> @@ -1131,6 +1249,15 @@ static int qcom_qmp_phy_init(struct phy *phy)
>>         qcom_qmp_phy_configure(pcs, cfg->regs, cfg->pcs_tbl, 
>> cfg->pcs_tbl_num);
>> 
>>         /*
>> +        * UFS PHY requires the deassert of software reset before 
>> serdes start.
>> +        * For UFS PHY that has not software reset control bits in its 
>> address
> 
> This line of the comment is unclear. Maybe:
> "For UFS PHYs that do not have software reset control bits, defer
> starting serdes until the power on callback"
> 

Sure, thank you.

>> +        * space, it should skip starting serdes here. UFS PHY Serdes 
>> shall
>> +        * start when UFS explicitly calls PHY power on.
>> +        */
>> +       if ((cfg->type == PHY_TYPE_UFS) && cfg->no_pcs_sw_reset)
>> +               goto out;
>> +
>> +       /*
>>          * Pull out PHY from POWER DOWN state.
>>          * This is active low enable signal to power-down PHY.
>>          */
>> @@ -1159,6 +1286,7 @@ static int qcom_qmp_phy_init(struct phy *phy)
>>         }
>>         qmp->phy_initialized = true;
>> 
>> +out:
>>         return ret;
>> 
>>  err_pcs_ready:
>> @@ -1181,7 +1309,8 @@ static int qcom_qmp_phy_exit(struct phy *phy)
>>         clk_disable_unprepare(qphy->pipe_clk);
>> 
>>         /* PHY reset */
>> -       qphy_setbits(qphy->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
>> +       if (!cfg->no_pcs_sw_reset)
>> +               qphy_setbits(qphy->pcs, cfg->regs[QPHY_SW_RESET], 
>> SW_RESET);
>> 
>>         /* stop SerDes and Phy-Coding-Sublayer */
>>         qphy_clrbits(qphy->pcs, cfg->regs[QPHY_START_CTRL], 
>> cfg->start_ctrl);
>> @@ -1199,6 +1328,44 @@ static int qcom_qmp_phy_exit(struct phy *phy)
>>         return 0;
>>  }
>> 
>> +static int qcom_qmp_phy_poweron(struct phy *phy)
>> +{
>> +       struct qmp_phy *qphy = phy_get_drvdata(phy);
>> +       struct qcom_qmp *qmp = qphy->qmp;
>> +       const struct qmp_phy_cfg *cfg = qmp->cfg;
>> +       void __iomem *pcs = qphy->pcs;
>> +       void __iomem *status;
>> +       unsigned int mask, val;
>> +       int ret = 0;
>> +
>> +       if (cfg->type != PHY_TYPE_UFS)
>> +               return 0;
>> +
>> +       /*
>> +        * For UFS PHY that has not software reset control, serdes 
>> start
>> +        * should only happen when UFS driver explicitly calls 
>> phy_power_on
>> +        * after it deasserts software reset.
>> +        */
>> +       if (cfg->no_pcs_sw_reset && !qmp->phy_initialized &&
>> +           (qmp->init_count != 0)) {
>> +               /* start SerDes and Phy-Coding-Sublayer */
>> +               qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], 
>> cfg->start_ctrl);
>> +
>> +               status = pcs + cfg->regs[QPHY_PCS_READY_STATUS];
>> +               mask = cfg->mask_pcs_ready;
>> +
>> +               ret = readl_poll_timeout(status, val, !(val & mask), 
>> 1,
>> +                                        PHY_INIT_COMPLETE_TIMEOUT);
>> +               if (ret) {
>> +                       dev_err(qmp->dev, "phy initialization 
>> timed-out\n");
>> +                       return ret;
>> +               }
>> +               qmp->phy_initialized = true;
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>>  static int qcom_qmp_phy_set_mode(struct phy *phy, enum phy_mode mode)
>>  {
>>         struct qmp_phy *qphy = phy_get_drvdata(phy);
>> @@ -1428,6 +1595,7 @@ static int phy_pipe_clk_register(struct qcom_qmp 
>> *qmp, struct device_node *np)
>>  static const struct phy_ops qcom_qmp_phy_gen_ops = {
>>         .init           = qcom_qmp_phy_init,
>>         .exit           = qcom_qmp_phy_exit,
>> +       .power_on       = qcom_qmp_phy_poweron,
> 
> The USB pipe clk discussion earlier this year got me on the lookout
> for asymmetric phy init functions. If we're flipping on START_CTRL in
> phy_poweron, shouldn't we be flipping it back off in phy_poweroff?
> From the comments, it seems like this was done so that some sort of
> UFS reset step could happen. Would that sequencing still happen
> correctly if the PHY did:
> 
> phy_init
> phy_power_on
> (phy_power_off)
> phy_power_on
> 
> I'm unsure. Does suspend/resume work?
> 
> -Evan

Hi Evan,

Thank you for your comments. As there is no phy_power_off
implemented,phy_power_off actually does nothing.Back to your question,
above sequence does not have issue here with current patch, as the
PHY is initialized already (qmp->phy_initialized is TRUE), the
START_CTRL shall not be set again.

+       if (cfg->no_pcs_sw_reset && !qmp->phy_initialized &&
+           (qmp->init_count != 0)) {

I am working with Vivek and Manu internally to re-fine the patch.
As Manu commented, we want to find a way to remove the poweron
method as it is only used by SDM845 UFS PHY.

- Can
