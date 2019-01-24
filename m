Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31CFC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C94C218AD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oix5Mh0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfAXLqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 06:46:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43299 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfAXLq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 06:46:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so6096742wrs.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 03:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u/hxwd3aLudVCV+7dHhBf5Fuo0S7UsIZLFxfnhMLOnI=;
        b=Oix5Mh0IGcA9Wp4PBSavHuqpSeZY+PLlcWk1F8Lxr89vLWeICRkMvrhrl469jdkXh7
         Mq5ggON62cYoGvH8WLgvT71sp4T33WLm6YoalHcg7CA0ccCxxRoTX7AYa5VlgwMZ6oD/
         PlI5z7DbMSJOl2H8WIrEObjVngS0IyiqAmmWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u/hxwd3aLudVCV+7dHhBf5Fuo0S7UsIZLFxfnhMLOnI=;
        b=dXAInhhAuDgARLLVLcON9gVisoswhBjC7G69hQVcJMUAtNuBRNRhE0Fty/a4oGp77j
         IR0Gjhwq7vnB5qRU0vSYZnNXo+g4gzUzRi7XkHeS01L52680zgNmnjV1jrwr/P++c+4U
         K+MmeTE3x4Lc59K8aIGg7+EI/Q8QwHCz3azNBLhtIf5frh3kgakd1xsHZuTXoKJPfXWM
         I5Ox4ast+eAQ6oBCEZBm7T63x7pWN9Mc18XFCkYnss+I2XN605VE0cFWS1ReIK/EaqJA
         X7zQDtuTFStxrql/+t0+P1qxLfsl+2tFtTKJNtinoUyw6qVgus6HWhhDBkWrxcBfx2h4
         UlhQ==
X-Gm-Message-State: AJcUukeVbXcmuD3KJNIfhRld8P+BvEZXPDs45+Kr+Q0HEs6edB+QHWh4
        FiWtle8qvvLQAo4QTpqit/6a4EB8kEY=
X-Google-Smtp-Source: ALg8bN7DDU2N+cqmwOYbi3BpPxDvtvV+Y0JZA8llf/1kuo7FzMoxwUY7Pi+KAmkBHGJOOu7bTA1M5Q==
X-Received: by 2002:adf:b201:: with SMTP id u1mr6731423wra.165.1548330384549;
        Thu, 24 Jan 2019 03:46:24 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id x10sm124994257wrn.29.2019.01.24.03.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 03:46:23 -0800 (PST)
Subject: Re: [<PATCH v1> 1/1] scsi: qcom-ufs: Add support for bus voting using
 ICB framework
To:     Asutosh Das <asutoshd@codeaurora.org>, subhashj@codeaurora.org,
        cang@codeaurora.org, vivek.gautam@codeaurora.org,
        rnayak@codeaurora.org, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1548312692.git.asutoshd@codeaurora.org>
 <d6aa4d9bd29bbb2c3ee78e6635d4704e4113a26e.1548312692.git.asutoshd@codeaurora.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <e91d4007-edab-da66-e241-bdf55bcf58aa@linaro.org>
Date:   Thu, 24 Jan 2019 13:46:22 +0200
MIME-Version: 1.0
In-Reply-To: <d6aa4d9bd29bbb2c3ee78e6635d4704e4113a26e.1548312692.git.asutoshd@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Asutosh,

Thanks for the patch!

On 1/24/19 09:01, Asutosh Das wrote:
> Adapt to the new ICB framework for bus bandwidth voting.

It's actually called interconnect API or interconnect framework.

> This requires the source/destination port ids.
> Also this requires a tuple of values.
> 
> The tuple is for two different paths - from UFS master
> to BIMC slave. The other is from CPU master to UFS slave.
> This tuple consists of the average and peak bandwidth.
> 
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> ---

You can put here (below the --- line) the text from the cover letter.
Usually people do not add separate cover letters for single patches.

>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |  12 ++
>  drivers/scsi/ufs/ufs-qcom.c                        | 234 ++++++++++++++++-----
>  drivers/scsi/ufs/ufs-qcom.h                        |  20 ++
>  3 files changed, 218 insertions(+), 48 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> index a99ed55..94249ef 100644
> --- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> +++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> @@ -45,6 +45,18 @@ Optional properties:
>  Note: If above properties are not defined it can be assumed that the supply
>  regulators or clocks are always on.
>  
> +* Following bus parameters are required:
> +interconnects
> +interconnect-names

Is the above really required? Are the interconnect bandwidth requests
required to enable something critical to UFS functionality?
Would UFS still work without any bandwidth scaling, although for example
slower? Could you please clarify.

> +- Please refer to Documentation/devicetree/bindings/interconnect/
> +  for more details on the above.
> +qcom,msm-bus,name - string describing the bus path
> +qcom,msm-bus,num-cases - number of configurations in which ufs can operate in
> +qcom,msm-bus,num-paths - number of paths to vote for
> +qcom,msm-bus,vectors-KBps - Takes a tuple <ib ab>, <ib ab> (2 tuples for 2 num-paths)
> +			    The number of these entries *must* be same as
> +			    num-cases.

DT bindings should be submitted as a separate patch. Anyway, people
frown upon putting configuration data in DT. Could we put this data into
the driver as a static table instead of DT? Also maybe use ab/pb for
average/peak bandwidth.

> +
>  Example:
>  	ufshc@0xfc598000 {
>  		compatible = "jedec,ufs-1.1";
> diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
> index 2b38db2..213e975 100644
> --- a/drivers/scsi/ufs/ufs-qcom.c
> +++ b/drivers/scsi/ufs/ufs-qcom.c
> @@ -16,6 +16,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/phy/phy.h>
> +#include <linux/interconnect.h>
>  #include <linux/phy/phy-qcom-ufs.h>

Alphabetical order?

>  
>  #include "ufshcd.h"
> @@ -27,6 +28,10 @@
>  #define UFS_QCOM_DEFAULT_DBG_PRINT_EN	\
>  	(UFS_QCOM_DBG_PRINT_REGS_EN | UFS_QCOM_DBG_PRINT_TEST_BUS_EN)
>  
> +#define UFS_DDR "ufs-ddr"
> +#define CPU_UFS "cpu-ufs"

Not sure if it's really useful to have them as #defines. Also maybe use
"ufs-mem" instead of "ufs-ddr" to be more consistent with other users.

> +
> +
>  enum {
>  	TSTBUS_UAWM,
>  	TSTBUS_UARM,
> @@ -714,7 +719,6 @@ static int ufs_qcom_get_pwr_dev_param(struct ufs_qcom_dev_params *qcom_param,
>  	return 0;
>  }
>  
> -#ifdef CONFIG_MSM_BUS_SCALING
>  static int ufs_qcom_get_bus_vote(struct ufs_qcom_host *host,
>  		const char *speed_mode)
>  {
> @@ -768,24 +772,83 @@ static void ufs_qcom_get_speed_mode(struct ufs_pa_layer_attr *p, char *result)
>  	}
>  }
>  
> +static int ufs_qcom_get_ib_ab(struct ufs_qcom_host *host, int index,
> +			      struct qcom_bus_vectors *ufs_ddr_vec,
> +			      struct qcom_bus_vectors *cpu_ufs_vec)
> +{
> +	struct qcom_bus_path *usecase;
> +
> +	if (!host->qbsd)
> +		return -EINVAL;
> +
> +	if (index > host->qbsd->num_usecase)
> +		return -EINVAL;
> +
> +	usecase = host->qbsd->usecase;
> +
> +	/*
> +	 *
> +	 * usecase:0  usecase:0
> +	 * ufs->ddr   cpu->ufs
> +	 * |vec[0&1] | vec[2&3]|
> +	 * +----+----+----+----+
> +	 * | ab | ib | ab | ib |
> +	 * |----+----+----+----+
> +	 * .
> +	 * .
> +	 * .
> +	 * usecase:n  usecase:n
> +	 * ufs->ddr   cpu->ufs
> +	 * |vec[0&1] | vec[2&3]|
> +	 * +----+----+----+----+
> +	 * | ab | ib | ab | ib |
> +	 * |----+----+----+----+
> +	 */
> +
> +	/* index refers to offset in usecase */
> +	ufs_ddr_vec->ab = usecase[index].vec[0].ab;
> +	ufs_ddr_vec->ib = usecase[index].vec[0].ib;
> +
> +	cpu_ufs_vec->ab = usecase[index].vec[1].ab;
> +	cpu_ufs_vec->ib = usecase[index].vec[1].ib;
> +
> +	return 0;
> +}
> +
>  static int ufs_qcom_set_bus_vote(struct ufs_qcom_host *host, int vote)
>  {
>  	int err = 0;
> +	struct qcom_bus_scale_data *d = host->qbsd;
> +	struct qcom_bus_vectors path0, path1;
> +	struct device *dev = host->hba->dev;
>  
> -	if (vote != host->bus_vote.curr_vote) {
> -		err = msm_bus_scale_client_update_request(
> -				host->bus_vote.client_handle, vote);
> -		if (err) {
> -			dev_err(host->hba->dev,
> -				"%s: msm_bus_scale_client_update_request() failed: bus_client_handle=0x%x, vote=%d, err=%d\n",
> -				__func__, host->bus_vote.client_handle,
> -				vote, err);
> -			goto out;
> -		}
> +	err = ufs_qcom_get_ib_ab(host, vote, &path0, &path1);
> +	if (err) {
> +		dev_err(dev, "Error: failed (%d) to get ib/ab\n",
> +			err);
> +		return err;
> +	}
>  
> -		host->bus_vote.curr_vote = vote;
> +	dev_dbg(dev, "Setting vote: %d: ufs-ddr: ab: %llu ib: %llu\n", vote,
> +		path0.ab, path0.ib);
> +	err = icc_set_bw(d->ufs_ddr, path0.ab, path0.ib);
> +	if (err) {
> +		dev_err(dev, "Error: (%d) failed setting (%s) bus vote\n", err,
> +			UFS_DDR);
> +		return err;
>  	}
> -out:
> +
> +	dev_dbg(dev, "Setting: cpu-ufs: ab: %llu ib: %llu\n", path1.ab,
> +		path1.ib);
> +	err = icc_set(d->cpu_ufs, path1.ab, path1.ib);
> +	if (err) {
> +		dev_err(dev, "Error: (%d) failed setting (%s) bus vote\n", err,
> +			CPU_UFS);
> +		return err;
> +	}
> +
> +	host->bus_vote.curr_vote = vote;
> +
>  	return err;
>  }
>  
> @@ -807,6 +870,7 @@ static int ufs_qcom_update_bus_bw_vote(struct ufs_qcom_host *host)
>  		dev_err(host->hba->dev, "%s: failed %d\n", __func__, err);
>  	else
>  		host->bus_vote.saved_vote = vote;
> +
>  	return err;
>  }
>  
> @@ -837,34 +901,114 @@ static int ufs_qcom_update_bus_bw_vote(struct ufs_qcom_host *host)
>  	return count;
>  }
>  
> +static struct qcom_bus_scale_data *ufs_qcom_get_bus_scale_data(struct device
> +							       *dev)
> +
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct device_node *of_node = dev->of_node;
> +	struct qcom_bus_scale_data *qsd;
> +	struct qcom_bus_path *usecase = NULL;
> +	int ret = 0, i = 0, j, num_paths, len;
> +	const uint32_t *vec_arr = NULL;

Please use u32 instead of uint32_t.

> +	bool mem_err = false;
> +
> +	if (!pdev) {
> +		dev_err(dev, "Null platform device!\n");
> +		return NULL;
> +	}
> +
> +	qsd = devm_kzalloc(dev, sizeof(struct qcom_bus_scale_data), GFP_KERNEL);
> +	if (!qsd)
> +		return NULL;
> +
> +	ret = of_property_read_string(of_node, "qcom,msm-bus,name", &qsd->name);
> +	if (ret) {
> +		dev_err(dev, "Error: (%d) Bus name missing!\n", ret);
> +		return NULL;
> +	}
> +
> +	ret = of_property_read_u32(of_node, "qcom,msm-bus,num-cases",
> +		&qsd->num_usecase);
> +	if (ret) {
> +		pr_err("Error: num-usecases not found\n");
> +		goto err;
> +	}
> +
> +	usecase = devm_kzalloc(dev, (sizeof(struct qcom_bus_path) *
> +				   qsd->num_usecase), GFP_KERNEL);
> +	if (!usecase)
> +		return NULL;
> +
> +	ret = of_property_read_u32(of_node, "qcom,msm-bus,num-paths",
> +				   &num_paths);
> +	if (ret) {
> +		pr_err("Error: num_paths not found\n");
> +		return NULL;
> +	}
> +
> +	vec_arr = of_get_property(of_node, "qcom,msm-bus,vectors-KBps", &len);
> +	if (vec_arr == NULL) {
> +		pr_err("Error: Vector array not found\n");
> +		return NULL;
> +	}
> +
> +	for (i = 0; i < qsd->num_usecase; i++) {
> +		usecase[i].num_paths = num_paths;
> +		usecase[i].vec = devm_kzalloc(dev, num_paths *
> +					      sizeof(struct qcom_bus_vectors),
> +					      GFP_KERNEL);
> +		if (!usecase[i].vec) {
> +			mem_err = true;
> +			dev_err(dev, "Error: Failed to alloc mem for vectors\n");
> +			goto err;
> +		}
> +
> +		for (j = 0; j < num_paths; j++) {
> +			int idx = ((i * num_paths) + j) * 2;
> +
> +			usecase[i].vec[j].ab = (uint64_t)
> +				be32_to_cpu(vec_arr[idx]);
> +			usecase[i].vec[j].ib = (uint64_t)
> +				be32_to_cpu(vec_arr[idx + 1]);
> +		}
> +	}
> +
> +	qsd->usecase = usecase;
> +	return qsd;
> +err:
> +	if (mem_err) {
> +		for (; i > 0; i--)
> +			kfree(usecase[i].vec);
> +	}
> +	return NULL;
> +}

We wouldn't need all the above DT parsing if we add a sdm845 bandwidth
usecase table. Could you give it a try?

Thanks,
Georgi
