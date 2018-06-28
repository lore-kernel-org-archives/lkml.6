Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D59C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9085327A1E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LaIPmVt4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KtDGYTaq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9085327A1E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967369AbeF1W0q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 18:26:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47516 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966506AbeF1W0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 18:26:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6FCAE60791; Thu, 28 Jun 2018 22:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530224801;
        bh=n8mTteEHkotxEwdpI/F2k791Sx8FcUiCs4pS6VjOn8Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LaIPmVt4b+f/+Qxt7UY3bpb6LpEpOKiGnCDo54MPhTZvYsnD4BBpbXl7Zq9JdPI6z
         x2rBfPPr86IHyiodUrm/5AGRcE/hdAzqt8MY6K12p+qaFfGBaSpO0ALl9fA+YxUInj
         4rmifd48LOCV38Fsu28TrHPpDLrZp7WTQyhGvRnM=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 108D26071C;
        Thu, 28 Jun 2018 22:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530224800;
        bh=n8mTteEHkotxEwdpI/F2k791Sx8FcUiCs4pS6VjOn8Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KtDGYTaqI8uO8iZXUFPWgataeG+1btKJ8S9rz/wJKaXbht1c61saE1GqHeaoiPqMs
         WjEhKvT2XnMy3Np/alrYWstJHxPaZo/Kb5fD0kapkFGpdy0YslLUU59SWOSvV2wMPP
         +ArxcZsYCfqqtN4Xk2z9Ffn3iA2ka1k9xS9U7NEU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 28 Jun 2018 15:26:40 -0700
From:   Subhash Jadavani <subhashj@codeaurora.org>
To:     Asutosh Das <asutoshd@codeaurora.org>
Cc:     cang@codeaurora.org, vivek.gautam@codeaurora.org,
        rnayak@codeaurora.org, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi-owner@vger.kernel.org
Subject: Re: [PATCH v2 09/10] scsi: ufs: fix irq return code
In-Reply-To: <25908e040c7c797e8a5c1bb6b00df4497bdd7b60.1525343531.git.asutoshd@codeaurora.org>
References: <cover.1525343531.git.asutoshd@codeaurora.org>
 <25908e040c7c797e8a5c1bb6b00df4497bdd7b60.1525343531.git.asutoshd@codeaurora.org>
Message-ID: <71bfee86ad846cf62f848d1db71ceeef@codeaurora.org>
X-Sender: subhashj@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-03 04:07, Asutosh Das wrote:
> From: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> 
> Return IRQ_HANDLED only if the irq is really handled, this will
> help in catching spurious interrupts that go unhandled.
> 
> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> ---
>  drivers/scsi/ufs/ufshcd.c | 137 
> ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 101 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 09b7a3f..557d538 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -211,7 +211,7 @@ enum {
>  	END_FIX
>  };
> 
> -static void ufshcd_tmc_handler(struct ufs_hba *hba);
> +static irqreturn_t ufshcd_tmc_handler(struct ufs_hba *hba);
>  static void ufshcd_async_scan(void *data, async_cookie_t cookie);
>  static int ufshcd_reset_and_restore(struct ufs_hba *hba);
>  static int ufshcd_eh_host_reset_handler(struct scsi_cmnd *cmd);
> @@ -4609,19 +4609,29 @@ static int ufshcd_task_req_compl(struct
> ufs_hba *hba, u32 index, u8 *resp)
>   * ufshcd_uic_cmd_compl - handle completion of uic command
>   * @hba: per adapter instance
>   * @intr_status: interrupt status generated by the controller
> + *
> + * Returns
> + *  IRQ_HANDLED - If interrupt is valid
> + *  IRQ_NONE    - If invalid interrupt
>   */
> -static void ufshcd_uic_cmd_compl(struct ufs_hba *hba, u32 intr_status)
> +static irqreturn_t ufshcd_uic_cmd_compl(struct ufs_hba *hba, u32 
> intr_status)
>  {
> +	irqreturn_t retval = IRQ_NONE;
> +
>  	if ((intr_status & UIC_COMMAND_COMPL) && hba->active_uic_cmd) {
>  		hba->active_uic_cmd->argument2 |=
>  			ufshcd_get_uic_cmd_result(hba);
>  		hba->active_uic_cmd->argument3 =
>  			ufshcd_get_dme_attr_val(hba);
>  		complete(&hba->active_uic_cmd->done);
> +		retval = IRQ_HANDLED;
>  	}
> 
> -	if ((intr_status & UFSHCD_UIC_PWR_MASK) && hba->uic_async_done)
> +	if ((intr_status & UFSHCD_UIC_PWR_MASK) && hba->uic_async_done) {
>  		complete(hba->uic_async_done);
> +		retval = IRQ_HANDLED;
> +	}
> +	return retval;
>  }
> 
>  /**
> @@ -4675,8 +4685,12 @@ static void __ufshcd_transfer_req_compl(struct
> ufs_hba *hba,
>  /**
>   * ufshcd_transfer_req_compl - handle SCSI and query command 
> completion
>   * @hba: per adapter instance
> + *
> + * Returns
> + *  IRQ_HANDLED - If interrupt is valid
> + *  IRQ_NONE    - If invalid interrupt
>   */
> -static void ufshcd_transfer_req_compl(struct ufs_hba *hba)
> +static irqreturn_t ufshcd_transfer_req_compl(struct ufs_hba *hba)
>  {
>  	unsigned long completed_reqs;
>  	u32 tr_doorbell;
> @@ -4694,7 +4708,12 @@ static void ufshcd_transfer_req_compl(struct
> ufs_hba *hba)
>  	tr_doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
>  	completed_reqs = tr_doorbell ^ hba->outstanding_reqs;
> 
> -	__ufshcd_transfer_req_compl(hba, completed_reqs);
> +	if (completed_reqs) {
> +		__ufshcd_transfer_req_compl(hba, completed_reqs);
> +		return IRQ_HANDLED;
> +	} else {
> +		return IRQ_NONE;
> +	}
>  }
> 
>  /**
> @@ -5220,16 +5239,21 @@ static void ufshcd_update_uic_reg_hist(struct
> ufs_uic_err_reg_hist *reg_hist,
>  /**
>   * ufshcd_update_uic_error - check and set fatal UIC error flags.
>   * @hba: per-adapter instance
> + *
> + * Returns
> + *  IRQ_HANDLED - If interrupt is valid
> + *  IRQ_NONE    - If invalid interrupt
>   */
> -static void ufshcd_update_uic_error(struct ufs_hba *hba)
> +static irqreturn_t ufshcd_update_uic_error(struct ufs_hba *hba)
>  {
>  	u32 reg;
> +	irqreturn_t retval = IRQ_NONE;
> 
>  	/* PHY layer lane error */
>  	reg = ufshcd_readl(hba, REG_UIC_ERROR_CODE_PHY_ADAPTER_LAYER);
>  	/* Ignore LINERESET indication, as this is not an error */
>  	if ((reg & UIC_PHY_ADAPTER_LAYER_ERROR) &&
> -			(reg & UIC_PHY_ADAPTER_LAYER_LANE_ERR_MASK)) {
> +			(reg & UIC_PHY_ADAPTER_LAYER_ERROR_CODE_MASK)) {
>  		/*
>  		 * To know whether this error is fatal or not, DB timeout
>  		 * must be checked but this error is handled separately.
> @@ -5240,57 +5264,73 @@ static void ufshcd_update_uic_error(struct 
> ufs_hba *hba)
> 
>  	/* PA_INIT_ERROR is fatal and needs UIC reset */
>  	reg = ufshcd_readl(hba, REG_UIC_ERROR_CODE_DATA_LINK_LAYER);
> -	if (reg)
> +	if ((reg & UIC_DATA_LINK_LAYER_ERROR) &&
> +	    (reg & UIC_DATA_LINK_LAYER_ERROR_CODE_MASK)) {
>  		ufshcd_update_uic_reg_hist(&hba->ufs_stats.dl_err, reg);
> -
> -	if (reg & UIC_DATA_LINK_LAYER_ERROR_PA_INIT)
> -		hba->uic_error |= UFSHCD_UIC_DL_PA_INIT_ERROR;
> -	else if (hba->dev_quirks &
> -		   UFS_DEVICE_QUIRK_RECOVERY_FROM_DL_NAC_ERRORS) {
> -		if (reg & UIC_DATA_LINK_LAYER_ERROR_NAC_RECEIVED)
> -			hba->uic_error |=
> -				UFSHCD_UIC_DL_NAC_RECEIVED_ERROR;
> -		else if (reg & UIC_DATA_LINK_LAYER_ERROR_TCx_REPLAY_TIMEOUT)
> -			hba->uic_error |= UFSHCD_UIC_DL_TCx_REPLAY_ERROR;
> +		if (reg & UIC_DATA_LINK_LAYER_ERROR_PA_INIT) {
> +			hba->uic_error |= UFSHCD_UIC_DL_PA_INIT_ERROR;
> +		} else if (hba->dev_quirks &
> +			   UFS_DEVICE_QUIRK_RECOVERY_FROM_DL_NAC_ERRORS) {
> +			if (reg & UIC_DATA_LINK_LAYER_ERROR_NAC_RECEIVED)
> +				hba->uic_error |=
> +					UFSHCD_UIC_DL_NAC_RECEIVED_ERROR;
> +			else if (reg &
> +				UIC_DATA_LINK_LAYER_ERROR_TCx_REPLAY_TIMEOUT)
> +				hba->uic_error |=
> +					UFSHCD_UIC_DL_TCx_REPLAY_ERROR;
> +		}
> +		retval |= IRQ_HANDLED;
>  	}
> 
>  	/* UIC NL/TL/DME errors needs software retry */
>  	reg = ufshcd_readl(hba, REG_UIC_ERROR_CODE_NETWORK_LAYER);
> -	if (reg) {
> +	if ((reg & UIC_NETWORK_LAYER_ERROR) &&
> +	    (reg & UIC_NETWORK_LAYER_ERROR_CODE_MASK)) {
>  		ufshcd_update_uic_reg_hist(&hba->ufs_stats.nl_err, reg);
>  		hba->uic_error |= UFSHCD_UIC_NL_ERROR;
> +		retval |= IRQ_HANDLED;
>  	}
> 
>  	reg = ufshcd_readl(hba, REG_UIC_ERROR_CODE_TRANSPORT_LAYER);
> -	if (reg) {
> +	if ((reg & UIC_TRANSPORT_LAYER_ERROR) &&
> +	    (reg & UIC_TRANSPORT_LAYER_ERROR_CODE_MASK)) {
>  		ufshcd_update_uic_reg_hist(&hba->ufs_stats.tl_err, reg);
>  		hba->uic_error |= UFSHCD_UIC_TL_ERROR;
> +		retval |= IRQ_HANDLED;
>  	}
> 
>  	reg = ufshcd_readl(hba, REG_UIC_ERROR_CODE_DME);
> -	if (reg) {
> +	if ((reg & UIC_DME_ERROR) &&
> +	    (reg & UIC_DME_ERROR_CODE_MASK)) {
>  		ufshcd_update_uic_reg_hist(&hba->ufs_stats.dme_err, reg);
>  		hba->uic_error |= UFSHCD_UIC_DME_ERROR;
> +		retval |= IRQ_HANDLED;
>  	}
> 
>  	dev_dbg(hba->dev, "%s: UIC error flags = 0x%08x\n",
>  			__func__, hba->uic_error);
> +	return retval;
>  }
> 
>  /**
>   * ufshcd_check_errors - Check for errors that need s/w attention
>   * @hba: per-adapter instance
> + *
> + * Returns
> + *  IRQ_HANDLED - If interrupt is valid
> + *  IRQ_NONE    - If invalid interrupt
>   */
> -static void ufshcd_check_errors(struct ufs_hba *hba)
> +static irqreturn_t ufshcd_check_errors(struct ufs_hba *hba)
>  {
>  	bool queue_eh_work = false;
> +	irqreturn_t retval = IRQ_NONE;
> 
>  	if (hba->errors & INT_FATAL_ERRORS)
>  		queue_eh_work = true;
> 
>  	if (hba->errors & UIC_ERROR) {
>  		hba->uic_error = 0;
> -		ufshcd_update_uic_error(hba);
> +		retval = ufshcd_update_uic_error(hba);
>  		if (hba->uic_error)
>  			queue_eh_work = true;
>  	}
> @@ -5327,6 +5367,7 @@ static void ufshcd_check_errors(struct ufs_hba 
> *hba)
>  			}
>  			schedule_work(&hba->eh_work);
>  		}
> +		retval |= IRQ_HANDLED;
>  	}
>  	/*
>  	 * if (!queue_eh_work) -
> @@ -5334,40 +5375,58 @@ static void ufshcd_check_errors(struct ufs_hba 
> *hba)
>  	 * itself without s/w intervention or errors that will be
>  	 * handled by the SCSI core layer.
>  	 */
> +	return retval;
>  }
> 
>  /**
>   * ufshcd_tmc_handler - handle task management function completion
>   * @hba: per adapter instance
> + *
> + * Returns
> + *  IRQ_HANDLED - If interrupt is valid
> + *  IRQ_NONE    - If invalid interrupt
>   */
> -static void ufshcd_tmc_handler(struct ufs_hba *hba)
> +static irqreturn_t ufshcd_tmc_handler(struct ufs_hba *hba)
>  {
>  	u32 tm_doorbell;
> 
>  	tm_doorbell = ufshcd_readl(hba, REG_UTP_TASK_REQ_DOOR_BELL);
>  	hba->tm_condition = tm_doorbell ^ hba->outstanding_tasks;
> -	wake_up(&hba->tm_wq);
> +	if (hba->tm_condition) {
> +		wake_up(&hba->tm_wq);
> +		return IRQ_HANDLED;
> +	} else {
> +		return IRQ_NONE;
> +	}
>  }
> 
>  /**
>   * ufshcd_sl_intr - Interrupt service routine
>   * @hba: per adapter instance
>   * @intr_status: contains interrupts generated by the controller
> + *
> + * Returns
> + *  IRQ_HANDLED - If interrupt is valid
> + *  IRQ_NONE    - If invalid interrupt
>   */
> -static void ufshcd_sl_intr(struct ufs_hba *hba, u32 intr_status)
> +static irqreturn_t ufshcd_sl_intr(struct ufs_hba *hba, u32 
> intr_status)
>  {
> +	irqreturn_t retval = IRQ_NONE;
> +
>  	hba->errors = UFSHCD_ERROR_MASK & intr_status;
>  	if (hba->errors)
> -		ufshcd_check_errors(hba);
> +		retval |= ufshcd_check_errors(hba);
> 
>  	if (intr_status & UFSHCD_UIC_MASK)
> -		ufshcd_uic_cmd_compl(hba, intr_status);
> +		retval |= ufshcd_uic_cmd_compl(hba, intr_status);
> 
>  	if (intr_status & UTP_TASK_REQ_COMPL)
> -		ufshcd_tmc_handler(hba);
> +		retval |= ufshcd_tmc_handler(hba);
> 
>  	if (intr_status & UTP_TRANSFER_REQ_COMPL)
> -		ufshcd_transfer_req_compl(hba);
> +		retval |= ufshcd_transfer_req_compl(hba);
> +
> +	return retval;
>  }
> 
>  /**
> @@ -5375,8 +5434,9 @@ static void ufshcd_sl_intr(struct ufs_hba *hba,
> u32 intr_status)
>   * @irq: irq number
>   * @__hba: pointer to adapter instance
>   *
> - * Returns IRQ_HANDLED - If interrupt is valid
> - *		IRQ_NONE - If invalid interrupt
> + * Returns
> + *  IRQ_HANDLED - If interrupt is valid
> + *  IRQ_NONE    - If invalid interrupt
>   */
>  static irqreturn_t ufshcd_intr(int irq, void *__hba)
>  {
> @@ -5399,14 +5459,19 @@ static irqreturn_t ufshcd_intr(int irq, void 
> *__hba)
>  			intr_status & ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
>  		if (intr_status)
>  			ufshcd_writel(hba, intr_status, REG_INTERRUPT_STATUS);
> -		if (enabled_intr_status) {
> -			ufshcd_sl_intr(hba, enabled_intr_status);
> -			retval = IRQ_HANDLED;
> -		}
> +		if (enabled_intr_status)
> +			retval |= ufshcd_sl_intr(hba, enabled_intr_status);
> 
>  		intr_status = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
>  	} while (intr_status && --retries);
> 
> +	if (retval == IRQ_NONE) {
> +		dev_err(hba->dev, "%s: Unhandled interrupt 0x%08x\n",
> +			__func__, intr_status);
> +		ufshcd_hex_dump("host regs: ", hba->mmio_base,
> +				UFSHCI_REG_SPACE_SIZE);
> +	}
> +
>  	spin_unlock(hba->host->host_lock);
>  	return retval;
>  }


Looks good to me.
Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
