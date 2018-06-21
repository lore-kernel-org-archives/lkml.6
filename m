Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E69C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B079204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SuV1S+sO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IxzPOTZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B079204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932739AbeFUJLh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 05:11:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57312 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932534AbeFUJLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 05:11:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2365C60B11; Thu, 21 Jun 2018 09:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529572292;
        bh=QQ3ilhMuBJkMxb7XGbZ2L6yL7sKjQHDBHQA5EBObAP4=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=SuV1S+sORh/aQHdi9mRT4NI9Yy7dp13Fi4IDqm4s+RodKfXUAPiNQS7guuecxH113
         ucm8oR+sCkUpA9EeW9w8PaL4wbruZYLcLHzVKYIKY5+tTRpPCZgkuEbEQ41w9wbfQv
         MRSE3q5dOcpvXCOPi1/5vo4Hc8gPbPyCnpivRNh4=
Received: from SAYALIL (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D7AB26021A;
        Thu, 21 Jun 2018 09:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529572290;
        bh=QQ3ilhMuBJkMxb7XGbZ2L6yL7sKjQHDBHQA5EBObAP4=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=IxzPOTZwtHN/yA40y4WdPjJG35ZMY0g8ZZed5eTyVzQPHNDHN/SBaFUlm1EXgk0Zq
         hkFrtdZfYWWoeJSynpTV9Mh88cua9StYRud8m7N1WwXWtEQcMfzhl4f2Nw//NKLqKi
         0QJ3xcS7zRjtj2Aa0PZCY3WOwMT+M1/GHmQ4pZ2Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D7AB26021A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
From:   "sayali" <sayalil@codeaurora.org>
To:     "'Adrian Hunter'" <adrian.hunter@intel.com>,
        <subhashj@codeaurora.org>, <cang@codeaurora.org>,
        <vivek.gautam@codeaurora.org>, <rnayak@codeaurora.org>,
        <vinholikatti@gmail.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>, <asutoshd@codeaurora.org>,
        <evgreen@chromium.org>, <riteshh@codeaurora.org>
Cc:     <linux-scsi@vger.kernel.org>, "'Rob Herring'" <robh+dt@kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Mathieu Malaterre'" <malat@debian.org>,
        "'open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS'" 
        <devicetree@vger.kernel.org>,
        "'open list'" <linux-kernel@vger.kernel.org>
References: <1528981432-23065-1-git-send-email-sayalil@codeaurora.org> <1528981432-23065-2-git-send-email-sayalil@codeaurora.org> <bf87ec58-69c0-fe59-cfa1-8dc7dc80ca46@intel.com>
In-Reply-To: <bf87ec58-69c0-fe59-cfa1-8dc7dc80ca46@intel.com>
Subject: RE: [PATCH V3 1/3] scsi: ufs: set the device reference clock setting
Date:   Thu, 21 Jun 2018 14:41:21 +0530
Message-ID: <002a01d4093f$d6f33640$84d9a2c0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQHqrwfiTmcauPZKO5758rWQ5wPzzwJm9mzqAyY2Ga2kELQDwA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

Please check my comment inline.

Thanks,
Sayali
-----Original Message-----
From: Adrian Hunter [mailto:adrian.hunter@intel.com]=20
Sent: Wednesday, June 20, 2018 12:56 PM
To: Sayali Lokhande <sayalil@codeaurora.org>; subhashj@codeaurora.org; =
cang@codeaurora.org; vivek.gautam@codeaurora.org; rnayak@codeaurora.org; =
vinholikatti@gmail.com; jejb@linux.vnet.ibm.com; =
martin.petersen@oracle.com; asutoshd@codeaurora.org; =
evgreen@chromium.org; riteshh@codeaurora.org
Cc: linux-scsi@vger.kernel.org; Rob Herring <robh+dt@kernel.org>; Mark =
Rutland <mark.rutland@arm.com>; Mathieu Malaterre <malat@debian.org>; =
open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS =
<devicetree@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 1/3] scsi: ufs: set the device reference clock =
setting

On 14/06/18 16:03, Sayali Lokhande wrote:
> From: Subhash Jadavani <subhashj@codeaurora.org>
>=20
> UFS host supplies the reference clock to UFS device and UFS device=20
> specification allows host to provide one of the 4 frequencies (19.2=20
> MHz,
> 26 MHz, 38.4 MHz, 52 MHz) for reference clock. Host should set the=20
> device reference clock frequency setting in the device based on what=20
> frequency it is supplying to UFS device.
>=20
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>

I have repeated my V2 comments below.  Please address these when you =
post V4.  Also please provide a change log for each patch version.

> ---
>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |  7 +++
>  drivers/scsi/ufs/ufs.h                             |  9 ++++
>  drivers/scsi/ufs/ufshcd-pltfrm.c                   | 24 ++++++++++
>  drivers/scsi/ufs/ufshcd.c                          | 52 =
++++++++++++++++++++++
>  drivers/scsi/ufs/ufshcd.h                          |  1 +
>  5 files changed, 93 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt=20
> b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> index c39dfef..4522434 100644
> --- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> +++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> @@ -41,6 +41,12 @@ Optional properties:
>  -lanes-per-direction	: number of lanes available per direction - =
either 1 or 2.
>  			  Note that it is assume same number of lanes is used both
>  			  directions at once. If not specified, default is 2 lanes per =
direction.
> +- dev-ref-clk-freq	: Specify the device reference clock frequency, =
must be one of the following:
> +			  0: 19.2 MHz
> +			  1: 26 MHz
> +			  2: 38.4 MHz
> +			  3: 52 MHz
> +			  Defaults to 26 MHz if not specified.
> =20
>  Note: If above properties are not defined it can be assumed that the=20
> supply  regulators or clocks are always on.
> @@ -66,4 +72,5 @@ Example:
>  		freq-table-hz =3D <100000000 200000000>, <0 0>, <0 0>;
>  		phys =3D <&ufsphy1>;
>  		phy-names =3D "ufsphy";
> +		dev-ref-clk-freq =3D <0>; /* reference clock freq: 19.2 MHz */
>  	};
> diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h index=20
> 14e5bf7..e15deb0 100644
> --- a/drivers/scsi/ufs/ufs.h
> +++ b/drivers/scsi/ufs/ufs.h
> @@ -378,6 +378,15 @@ enum query_opcode {
>  	UPIU_QUERY_OPCODE_TOGGLE_FLAG	=3D 0x8,
>  };
> =20
> +/* bRefClkFreq attribute values */
> +enum ref_clk_freq {
> +	REF_CLK_FREQ_19_2_MHZ	=3D 0x0,
> +	REF_CLK_FREQ_26_MHZ	=3D 0x1,
> +	REF_CLK_FREQ_38_4_MHZ	=3D 0x2,
> +	REF_CLK_FREQ_52_MHZ	=3D 0x3,
> +	REF_CLK_FREQ_MAX	=3D REF_CLK_FREQ_52_MHZ,
> +};
> +
>  /* Query response result code */
>  enum {
>  	QUERY_RESULT_SUCCESS                    =3D 0x00,
> diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c=20
> b/drivers/scsi/ufs/ufshcd-pltfrm.c
> index e82bde0..6c877f3 100644
> --- a/drivers/scsi/ufs/ufshcd-pltfrm.c
> +++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
> @@ -221,6 +221,28 @@ static int ufshcd_parse_regulator_info(struct =
ufs_hba *hba)
>  	return err;
>  }
> =20
> +static void ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba) {
> +	struct device *dev =3D hba->dev;
> +	struct device_node *np =3D dev->of_node;
> +	int ret;
> +
> +	if (!np)
> +		return;
> +
> +	ret =3D of_property_read_u32(np, "dev-ref-clk-freq",
> +				   &hba->dev_ref_clk_freq);

This setting is useful for any UFSHC driver.  Please move it to ufshcd.c =
and use device_property_read_u32().
[Sayali]: Ok. Will update this in next patch set.

> +	if (ret ||
> +	    (hba->dev_ref_clk_freq < 0) ||

u32 cannot be < 0
[Sayali]: Will remove this check.

> +	    (hba->dev_ref_clk_freq > REF_CLK_FREQ_52_MHZ)) {
> +		dev_err(hba->dev,
> +		"%s: invalid ref_clk setting =3D %d, set to default\n",
> +		__func__, hba->dev_ref_clk_freq);
> +		/* default setting */
> +		hba->dev_ref_clk_freq =3D REF_CLK_FREQ_26_MHZ;

No, the default must be to leave the value unchanged.
[Sayali]: As per UFS device specification , bRefClkFreq attribute's =
default value corresponds to 26 MHz (Manufacturer Default Value). Thus =
we should set it to default (26MHz) if it's not already set.

> +	}
> +}
> +
>  #ifdef CONFIG_PM
>  /**
>   * ufshcd_pltfrm_suspend - suspend power management function @@=20
> -343,6 +365,8 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
>  	pm_runtime_set_active(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
> =20
> +	ufshcd_parse_dev_ref_clk_freq(hba);
> +
>  	ufshcd_init_lanes_per_dir(hba);
> =20
>  	err =3D ufshcd_init(hba, mmio_base, irq); diff --git=20
> a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c index=20
> c5b1bf1..4abc7ae 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -6297,6 +6297,53 @@ static void ufshcd_def_desc_sizes(struct=20
> ufs_hba *hba)  }
> =20
>  /**
> + * ufshcd_set_dev_ref_clk - set the device bRefClkFreq
> + * @hba: per-adapter instance
> + *
> + * Read the current value of the bRefClkFreq attribute from device=20
> +and update it
> + * if host is supplying different reference clock frequency than one=20
> +mentioned
> + * in bRefClkFreq attribute.
> + *
> + * Returns zero on success, non-zero error value on failure.
> + */
> +static int ufshcd_set_dev_ref_clk(struct ufs_hba *hba) {
> +	int err =3D 0;
> +	int ref_clk =3D -1;
> +	static const char * const ref_clk_freqs[] =3D {"19.2 MHz", "26 MHz",
> +						     "38.4 MHz", "52 MHz"};
> +
> +	err =3D ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
> +			QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0, &ref_clk);
> +
> +	if (err) {
> +		dev_err(hba->dev, "%s: failed reading bRefClkFreq. err =3D %d\n",
> +			 __func__, err);
> +		goto out;
> +	}
> +
> +	if (ref_clk =3D=3D hba->dev_ref_clk_freq)
> +		goto out; /* nothing to update */
> +
> +	err =3D ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
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
> +out:
> +	return err;
> +}
> +
> +/**
>   * ufshcd_probe_hba - probe hba to detect device and initialize
>   * @hba: per-adapter instance
>   *
> @@ -6361,6 +6408,11 @@ static int ufshcd_probe_hba(struct ufs_hba =
*hba)
>  			"%s: Failed getting max supported power mode\n",
>  			__func__);
>  	} else {
> +		/*
> +		 * Set the right value to bRefClkFreq before attempting to
> +		 * switch to HS gears.
> +		 */
> +		ufshcd_set_dev_ref_clk(hba);
>  		ret =3D ufshcd_config_pwr_mode(hba, &hba->max_pwr_info.info);
>  		if (ret) {
>  			dev_err(hba->dev, "%s: Failed setting power mode, err =3D %d\n",=20
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h=20
> index 8110dcd..b026ad8 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -548,6 +548,7 @@ struct ufs_hba {
>  	void *priv;
>  	unsigned int irq;
>  	bool is_irq_enabled;
> +	u32 dev_ref_clk_freq;
> =20
>  	/* Interrupt aggregation support is broken */
>  	#define UFSHCD_QUIRK_BROKEN_INTR_AGGR			0x1
>=20


