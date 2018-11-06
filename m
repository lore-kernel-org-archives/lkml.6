Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3760C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638D52085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638D52085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389650AbeKGCsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:48:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46682 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388987AbeKGCsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:48:18 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so6086116pgp.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 09:22:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q+aywkzd2zyvGu5y8HvDgUVkRiJC94jYOGjo8y4e77s=;
        b=d4YZjmByDKOJ4iu3W7BmNQVYnDWqWDzMf3gvIqw/pGNBtmi6MWTTNc741Iw+KuBnU3
         Q2tgifpmJS4b4lEYL3yzrii1esd5xR9SIlQOuNO/r+jec24Xrl2bwhVG/M102yV4cwd1
         UmXJBUTl39MW3lNoeZdtfjLeBeG3KdCq02+1jBaaEAuu80Nbo78uliFZSEOuWQ1QODE2
         l604WUxtSySsw2YRBqL03PTvoszGWcH9062C6Cw9UK2KMT1pnPxku+ozddPacN3L3h8w
         HEObEt9xBUgMcDKlbUPJ73TybAMlfdqtv5yNwYyNNB2twCFox6/VFrmJcCmMUJ7EN2g7
         SS7Q==
X-Gm-Message-State: AGRZ1gIIxlui+/ekcpou+bevUKpeFON8uOi8Zq+ZaQVqt08XqKc6IJUD
        y1UxpobINEdjSdbuqAN7NpUDjQ==
X-Google-Smtp-Source: AJdET5c+Dy/ixXyDFF/ur50TOIIE1vAXu8Iz0hb1bnwX57k5M12MsvvEuzmXBrIbDX0X2sGSXP7eBQ==
X-Received: by 2002:a65:4646:: with SMTP id k6mr24137334pgr.153.1541524924783;
        Tue, 06 Nov 2018 09:22:04 -0800 (PST)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id z13sm16088247pgf.84.2018.11.06.09.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 09:22:03 -0800 (PST)
Date:   Tue, 6 Nov 2018 09:22:02 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     richard.gong@linux.intel.com
Cc:     gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will.deacon@arm.com, dinguyen@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org,
        arnd@arndb.de, corbet@lwn.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, todd.riffel@intel.com,
        richard.gong@intel.com
Subject: Re: [PATCHv10 8/8] firmware: add remote status update client support
Message-ID: <20181106172202.GA4042@archbook>
References: <1541523172-5171-1-git-send-email-richard.gong@linux.intel.com>
 <1541523172-5171-9-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541523172-5171-9-git-send-email-richard.gong@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Tue, Nov 06, 2018 at 10:52:52AM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Extend Intel Stratix10 service layer to support the second service layer
> client, Remote Status Update (RSU).
> 
> RSU is used to provide our customers with protection against loading bas
Nit: 'bas' -> 'bad'
> bitstreams onto their devices when those device are booting from flash.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
> v7: this patch is added in patch set version 7
> v8: no change
> v9: add case for COMMAND_RSU_UPDATE at svc_thread_recv_status_ok() at
>     stratix10-svc.c file
>     add RSU related definitions at stratix10-smc.h file
> v10: s/misc/firmware at commit header
> ---
>  drivers/firmware/stratix10-svc.c                   | 35 +++++++++++++++-
>  include/linux/firmware/intel/stratix10-smc.h       | 47 ++++++++++++++++++++++
>  .../linux/firmware/intel/stratix10-svc-client.h    | 20 ++++++++-
>  3 files changed, 98 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> index 898e588..ae99221 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -34,7 +34,7 @@
>   * timeout is set to 30 seconds (30 * 1000) at Intel Stratix10 SoC.
>   */
>  #define SVC_NUM_DATA_IN_FIFO			32
> -#define SVC_NUM_CHANNEL				1
> +#define SVC_NUM_CHANNEL				2
>  #define FPGA_CONFIG_DATA_CLAIM_TIMEOUT_MS	200
>  #define FPGA_CONFIG_STATUS_TIMEOUT_SEC		30
>  
> @@ -271,7 +271,7 @@ static void svc_thread_cmd_config_status(struct stratix10_svc_controller *ctrl,
>   * @cb_data: pointer to callback data structure to service client
>   * @res: result from SMC or HVC call
>   *
> - * Send back the correspond status to the service client (FPGA manager etc).
> + * Send back the correspond status to the service clients.
>   */
>  static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
>  				      struct stratix10_svc_cb_data *cb_data,
> @@ -295,6 +295,9 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
>  	case COMMAND_RECONFIG_STATUS:
>  		cb_data->status = BIT(SVC_STATUS_RECONFIG_COMPLETED);
>  		break;
> +	case COMMAND_RSU_UPDATE:
> +		cb_data->status = BIT(SVC_STATUS_RSU_OK);
> +		break;
>  	default:
>  		pr_warn("it shouldn't happen\n");
>  		break;
> @@ -373,6 +376,16 @@ static int svc_normal_to_secure_thread(void *data)
>  			a1 = 0;
>  			a2 = 0;
>  			break;
> +		case COMMAND_RSU_STATUS:
> +			a0 = INTEL_SIP_SMC_RSU_STATUS;
> +			a1 = 0;
> +			a2 = 0;
> +			break;
> +		case COMMAND_RSU_UPDATE:
> +			a0 = INTEL_SIP_SMC_RSU_UPDATE;
> +			a1 = pdata->arg[0];
> +			a2 = 0;
> +			break;
>  		default:
>  			pr_warn("it shouldn't happen\n");
>  			break;
> @@ -389,6 +402,19 @@ static int svc_normal_to_secure_thread(void *data)
>  			 (unsigned int)res.a1, (unsigned int)res.a2);
>  		pr_debug(" res.a3=0x%016x\n", (unsigned int)res.a3);
>  
> +		if (pdata->command == COMMAND_RSU_STATUS) {
> +			if (res.a0 == INTEL_SIP_SMC_RSU_ERROR)
> +				cbdata->status = BIT(SVC_STATUS_RSU_ERROR);
> +			else
> +				cbdata->status = BIT(SVC_STATUS_RSU_OK);
> +
> +			cbdata->kaddr1 = &res;
> +			cbdata->kaddr2 = NULL;
> +			cbdata->kaddr3 = NULL;
> +			pdata->chan->scl->receive_cb(pdata->chan->scl, cbdata);
> +			continue;
> +		}
> +
>  		switch (res.a0) {
>  		case INTEL_SIP_SMC_STATUS_OK:
>  			svc_thread_recv_status_ok(pdata, cbdata, res);
> @@ -941,6 +967,11 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
>  	chans[0].name = SVC_CLIENT_FPGA;
>  	spin_lock_init(&chans[0].lock);
>  
> +	chans[1].scl = NULL;
> +	chans[1].ctrl = controller;
> +	chans[1].name = SVC_CLIENT_RSU;
> +	spin_lock_init(&chans[1].lock);
> +
>  	list_add_tail(&controller->node, &svc_ctrl);
>  	platform_set_drvdata(pdev, controller);
>  
> diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
> index a109e4c..5be5dab 100644
> --- a/include/linux/firmware/intel/stratix10-smc.h
> +++ b/include/linux/firmware/intel/stratix10-smc.h
> @@ -67,6 +67,12 @@
>   *
>   * INTEL_SIP_SMC_FPGA_CONFIG_STATUS_ERROR:
>   * There is error during the FPGA configuration process.
> + *
> + * INTEL_SIP_SMC_REG_ERROR:
> + * There is error during a read or write operation of the protected registers.
> + *
> + * INTEL_SIP_SMC_RSU_ERROR:
> + * There is error during a remote status update.
>   */
>  #define INTEL_SIP_SMC_RETURN_UNKNOWN_FUNCTION		0xFFFFFFFF
>  #define INTEL_SIP_SMC_STATUS_OK				0x0
> @@ -74,6 +80,7 @@
>  #define INTEL_SIP_SMC_FPGA_CONFIG_STATUS_REJECTED       0x2
>  #define INTEL_SIP_SMC_FPGA_CONFIG_STATUS_ERROR		0x4
>  #define INTEL_SIP_SMC_REG_ERROR				0x5
> +#define INTEL_SIP_SMC_RSU_ERROR				0x7
>  
>  /**
>   * Request INTEL_SIP_SMC_FPGA_CONFIG_START
> @@ -262,4 +269,44 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
>  #define INTEL_SIP_SMC_REG_UPDATE \
>  	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_REG_UPDATE)
>  
> +/*
> + * Request INTEL_SIP_SMC_RSU_STATUS
> + *
> + * Request remote status update boot log, call is synchronous.
> + *
> + * Call register usage:
> + * a0 INTEL_SIP_SMC_RSU_STATUS
> + * a1-7 not used
> + *
> + * Return status
> + * a0: Current Image
> + * a1: Last Failing Image
> + * a2: Version | State
> + * a3: Error details | Error location
> + *
> + * Or
> + *
> + * a0: INTEL_SIP_SMC_RSU_ERROR
> + */
> +#define INTEL_SIP_SMC_FUNCID_RSU_STATUS 11
> +#define INTEL_SIP_SMC_RSU_STATUS \
> +	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_STATUS)
> +
> +/*
> + * Request INTEL_SIP_SMC_RSU_UPDATE
> + *
> + * Request to set the offset of the bitstream to boot after reboot, call
> + * is synchronous.
> + *
> + * Call register usage:
> + * a0 INTEL_SIP_SMC_RSU_UPDATE
> + * a1 64bit physical address of the configuration data memory in flash
> + * a2-7 not used
> + *
> + * Return status
> + * a0 INTEL_SIP_SMC_STATUS_OK
> + */
> +#define INTEL_SIP_SMC_FUNCID_RSU_UPDATE 12
> +#define INTEL_SIP_SMC_RSU_UPDATE \
> +	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_UPDATE)
>  #endif
> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
> index f2fda7e..e521f17 100644
> --- a/include/linux/firmware/intel/stratix10-svc-client.h
> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
> @@ -10,8 +10,10 @@
>   * Service layer driver supports client names
>   *
>   * fpga: for FPGA configuration
> + * rsu: for remote status update
>   */
>  #define SVC_CLIENT_FPGA			"fpga"
> +#define SVC_CLIENT_RSU			"rsu"
>  
>  /**
>   * Status of the sent command, in bit number
> @@ -36,6 +38,9 @@
>   *
>   * SVC_COMMAND_STATUS_RECONFIG_ERROR:
>   * Error encountered during FPGA configuration.
> + *
> + * SVC_STATUS_RSU_OK:
> + * Secure firmware accepts the request of remote status update (RSU).
>   */
>  #define SVC_STATUS_RECONFIG_REQUEST_OK		0
>  #define SVC_STATUS_RECONFIG_BUFFER_SUBMITTED	1
> @@ -43,7 +48,8 @@
>  #define SVC_STATUS_RECONFIG_COMPLETED		3
>  #define SVC_STATUS_RECONFIG_BUSY		4
>  #define SVC_STATUS_RECONFIG_ERROR		5
> -
> +#define SVC_STATUS_RSU_OK			6
> +#define SVC_STATUS_RSU_ERROR			7
>  /**
>   * Flag bit for COMMAND_RECONFIG
>   *
> @@ -56,9 +62,11 @@
>  /**
>   * Timeout settings for service clients:
>   * timeout value used in Stratix10 FPGA manager driver.
> + * timeout value used in RSU driver
>   */
>  #define SVC_RECONFIG_REQUEST_TIMEOUT_MS         100
>  #define SVC_RECONFIG_BUFFER_TIMEOUT_MS          240
> +#define SVC_RSU_REQUEST_TIMEOUT_MS              300
>  
>  struct stratix10_svc_chan;
>  
> @@ -81,13 +89,21 @@ struct stratix10_svc_chan;
>   * @COMMAND_RECONFIG_STATUS: check the status of the configuration, return
>   * status is SVC_STATUS_RECONFIG_COMPLETED, or  SVC_STATUS_RECONFIG_BUSY, or
>   * SVC_STATUS_RECONFIG_ERROR
> + *
> + * @COMMAND_RSU_STATUS: request remote system update boot log, return status
> + * is log data or SVC_STATUS_RSU_ERROR
> + *
> + * @COMMAND_RSU_UPDATE: set the offset of the bitstream to boot after reboot,
> + * return status is SVC_STATUS_RSU_OK or SVC_STATUS_RSU_ERROR
>   */
>  enum stratix10_svc_command_code {
>  	COMMAND_NOOP = 0,
>  	COMMAND_RECONFIG,
>  	COMMAND_RECONFIG_DATA_SUBMIT,
>  	COMMAND_RECONFIG_DATA_CLAIM,
> -	COMMAND_RECONFIG_STATUS
> +	COMMAND_RECONFIG_STATUS,
> +	COMMAND_RSU_STATUS,
> +	COMMAND_RSU_UPDATE
>  };
>  
>  /**
> -- 
> 2.7.4
> 

Thanks,
Moritz
