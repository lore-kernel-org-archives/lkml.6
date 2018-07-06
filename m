Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53199C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B5C22BE8
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B5C22BE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753683AbeGFVHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:07:34 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37744 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753075AbeGFVHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:07:32 -0400
Received: by mail-oi0-f65.google.com with SMTP id k81-v6so25869802oib.4;
        Fri, 06 Jul 2018 14:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qf4bxYUVz29Y4RoV3dIzJyKb3aTx4fBPmoTpPZQNHTs=;
        b=r88A0LcvQo7c6MBdqLzcK0M2aorC6Hs0ierCXvADRC/k4D0TsHwwlmApmCToeFU3MO
         xyZw757xRttofz7GmfQwLbQ+ObHvupLj4WHWWwZGsogPpaeyPl5vpuU7okqO4RFo3mBF
         L8c8K4olWYErN42EeRQStUElzQRvNsJSlWZ9Z9Vqgpg7SF1NyQdKFCoWZCu1cxheq725
         dZFV71YwLLwYYzlE5fnHrI70yirJjvQXmiDAqa+Vh7Ix1CDDQ1Fv6g0lJwIqQ9tJgh4h
         33EVAOVL6qcoyZDQ588HIOe2g4TJaVxUAwIx/Ux9ewhZ1HINNlIZ3ehFXmrcvTFN6TOq
         sPrQ==
X-Gm-Message-State: APt69E14p/UnGxklnusZHUTOD6i35FkTDLCwpixLJzhnm6or2R7FFXlT
        iHYiioAZDGmr4nvdv0uGNw==
X-Google-Smtp-Source: AAOMgpc/OL7MJY9xTrC9xcey13rHSdg/av64n195MYSpsjQyQmjFDyLncwNUjlNYP5i17M/zFPid/w==
X-Received: by 2002:aca:f58f:: with SMTP id t137-v6mr13865003oih.244.1530911251349;
        Fri, 06 Jul 2018 14:07:31 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id g136-v6sm10082134oic.32.2018.07.06.14.07.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 14:07:30 -0700 (PDT)
Date:   Fri, 6 Jul 2018 15:07:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sayali Lokhande <sayalil@codeaurora.org>
Cc:     subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, asutoshd@codeaurora.org,
        evgreen@chromium.org, riteshh@codeaurora.org,
        linux-scsi@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Mathieu Malaterre <malat@debian.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 1/2] scsi: ufs: set the device reference clock setting
Message-ID: <20180706210729.GA22391@rob-hp-laptop>
References: <1530858040-13971-1-git-send-email-sayalil@codeaurora.org>
 <1530858040-13971-2-git-send-email-sayalil@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530858040-13971-2-git-send-email-sayalil@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 11:50:39AM +0530, Sayali Lokhande wrote:
> From: Subhash Jadavani <subhashj@codeaurora.org>
> 
> UFS host supplies the reference clock to UFS device and UFS device
> specification allows host to provide one of the 4 frequencies (19.2 MHz,
> 26 MHz, 38.4 MHz, 52 MHz) for reference clock. Host should set the
> device reference clock frequency setting in the device based on what
> frequency it is supplying to UFS device.
> 
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> ---
>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |  7 +++
>  drivers/scsi/ufs/ufs.h                             |  9 ++++
>  drivers/scsi/ufs/ufshcd-pltfrm.c                   |  2 +
>  drivers/scsi/ufs/ufshcd.c                          | 62 ++++++++++++++++++++++
>  drivers/scsi/ufs/ufshcd.h                          |  2 +
>  5 files changed, 82 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> index c39dfef..bc20f59 100644
> --- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> +++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> @@ -41,6 +41,12 @@ Optional properties:
>  -lanes-per-direction	: number of lanes available per direction - either 1 or 2.
>  			  Note that it is assume same number of lanes is used both
>  			  directions at once. If not specified, default is 2 lanes per direction.
> +- assigned-clock-rates 	: Specify the device reference clock frequency, must be one of the following:
> +			  0: 19.2 MHz
> +			  1: 26 MHz
> +			  2: 38.4 MHz
> +			  3: 52 MHz
> +			  Defaults to 26 MHz if not specified.

Sigh. You obviously did not read the definition of assigned-clock-rates 
and understand how it works. I don't think you want the frequency to be 
0-3 Hz.


>  Note: If above properties are not defined it can be assumed that the supply
>  regulators or clocks are always on.
> @@ -66,4 +72,5 @@ Example:
>  		freq-table-hz = <100000000 200000000>, <0 0>, <0 0>;
>  		phys = <&ufsphy1>;
>  		phy-names = "ufsphy";
> +		assigned-clock-rates = <0>; /* reference clock freq: 19.2 MHz */
>  	};
> diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
> index 14e5bf7..e15deb0 100644
> --- a/drivers/scsi/ufs/ufs.h
> +++ b/drivers/scsi/ufs/ufs.h
> @@ -378,6 +378,15 @@ enum query_opcode {
>  	UPIU_QUERY_OPCODE_TOGGLE_FLAG	= 0x8,
>  };
>  
> +/* bRefClkFreq attribute values */
> +enum ref_clk_freq {
> +	REF_CLK_FREQ_19_2_MHZ	= 0x0,
> +	REF_CLK_FREQ_26_MHZ	= 0x1,
> +	REF_CLK_FREQ_38_4_MHZ	= 0x2,
> +	REF_CLK_FREQ_52_MHZ	= 0x3,
> +	REF_CLK_FREQ_MAX	= REF_CLK_FREQ_52_MHZ,
> +};
> +
>  /* Query response result code */
>  enum {
>  	QUERY_RESULT_SUCCESS                    = 0x00,
> diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
> index e82bde0..0953563 100644
> --- a/drivers/scsi/ufs/ufshcd-pltfrm.c
> +++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
> @@ -343,6 +343,8 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
>  	pm_runtime_set_active(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
>  
> +	ufshcd_parse_dev_ref_clk_freq(hba);
> +
>  	ufshcd_init_lanes_per_dir(hba);
>  
>  	err = ufshcd_init(hba, mmio_base, irq);
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index c5b1bf1..455a6ad 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -6296,6 +6296,62 @@ static void ufshcd_def_desc_sizes(struct ufs_hba *hba)
>  	hba->desc_size.hlth_desc = QUERY_DESC_HEALTH_DEF_SIZE;
>  }
>  
> +void ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba)
> +{
> +	struct device *dev = hba->dev;
> +	int ret;
> +
> +	if (!dev)
> +		return;
> +
> +	ret = device_property_read_u32(dev, "assigned-clock-rates",
> +				   &hba->dev_ref_clk_freq);
> +	if (ret ||
> +	    (hba->dev_ref_clk_freq > REF_CLK_FREQ_52_MHZ)) {
> +		dev_err(hba->dev,
> +		"%s: invalid ref_clk setting = %d\n",
> +		__func__, hba->dev_ref_clk_freq);
> +		hba->dev_ref_clk_freq = REF_CLK_FREQ_MAX + 1;
> +	}
> +}
> +
> +static int ufshcd_set_dev_ref_clk(struct ufs_hba *hba)
> +{
> +	int err = 0;
> +	int ref_clk = -1;
> +	static const char * const ref_clk_freqs[] = {"19.2 MHz", "26 MHz",
> +						     "38.4 MHz", "52 MHz"};
> +
> +	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
> +			QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0, &ref_clk);
> +
> +	if (err) {
> +		dev_err(hba->dev, "%s: failed reading bRefClkFreq. err = %d\n",
> +			 __func__, err);
> +		goto out;
> +	}
> +
> +	if (ref_clk == hba->dev_ref_clk_freq)
> +		goto out; /* nothing to update */
> +
> +	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
> +			QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0,
> +			&hba->dev_ref_clk_freq);
> +
> +	if (err)
> +		dev_err(hba->dev, "%s: bRefClkFreq setting to %s failed\n",
> +			__func__, ref_clk_freqs[hba->dev_ref_clk_freq]);
> +	/*
> +	 * It is good to print this out here to debug any later failures
> +	 * related to gear switch.
> +	 */
> +	dev_dbg(hba->dev, "%s: bRefClkFreq setting to %s succeeded\n",
> +			__func__, ref_clk_freqs[hba->dev_ref_clk_freq]);
> +

I still don't understand how you think this is supposed to work. All 
this does is copy whatever freq setting you put into DT to this 
device attr. That does nothing to actually set the frequency of the 
ref_clk. It's frequency could be anything before and after this 
function.

Also, according to the spec, isn't QUERY_ATTR_IDN_REF_CLK_FREQ 
write-once? So if you can read the value, wouldn't that mean you can't 
set it.

Rob
