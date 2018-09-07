Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C779C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328642075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="uMr9P1GO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328642075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbeIGPS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:18:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32936 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeIGPS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:18:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id s7-v6so6826546pgc.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 03:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OqyIANnJcnh1Xd+x6lSFfwsATPb69RTTxXH6fXhMBnk=;
        b=uMr9P1GOd7+Vtv2dNrUQmdDXl2eXjnmm3RDHnpaQhvmvizpaN6A9aaNrpvNxO7x3wD
         4vIDeWtBbscH28Yiw7pHbSS1yqKqMTIVu9Suy3evxrNe5giJv1q+lXf+E38Q07TllDdb
         YHiT/Cobw38HqxerqPJcde2BQNgjufN3jmCCl0uGkez0l1HF+fIEQrjF9bvbQlJnhADf
         QEtWMuhX06SadYfaW33nDEsShxj3zmz7+7gQTxrOLroE6fECF+NMUJjDYOh3p5BdJTcS
         AhJKofpeTLTaRgIwE6V7yKM4WHHTuYBkzMZj9NMD/uGOwoPgHuEHs0qX3UwV3wt53DWR
         aoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OqyIANnJcnh1Xd+x6lSFfwsATPb69RTTxXH6fXhMBnk=;
        b=pHg0E69cSq4mmd6bB5hCIqvewVlY+A2Suven63n2WUfD2Sh6vrpRUz92j51bVZgoES
         YOfqxoYdPJ9gX/zPz+9fGKejrNq7c5easct2Maf01QBOPwMajnVnjsGSpJmcntipGBoq
         sKF2HJ058YFL1uIPj4yAg4sTpH0n9eSDHHAWmGb+48h9MFgn/dcHtIqh+hqxwn3FMVQ0
         8Y/DYs9f6JWhu/rNwKE7W201ErdRCKMD21wHhuvQ6kw3uigy155OBSkPIyCVvFyIbhlz
         azjOkTkVfbPwUvW9rS1FIIWryUk5K7FKyEQE1Ll3Rr8FsJFNDLayofD4EHeT0iX/JqLZ
         AkbA==
X-Gm-Message-State: APzg51Au7xpt01NshxuNXbFzhSHmNaUB3AfKJRdHTIUZ22oZ+MwgH5Wr
        uLbFiOP72cH57Yn0HDJxl2tuKg==
X-Google-Smtp-Source: ANB0VdZawNFGlsOEj0upWlHmbvDrcX4KFOOPy91Frl/pgpJ8xTusxeQ87GTD/qUdUvbMY28ucvkh1w==
X-Received: by 2002:a65:6086:: with SMTP id t6-v6mr7578931pgu.424.1536316715268;
        Fri, 07 Sep 2018 03:38:35 -0700 (PDT)
Received: from [10.86.62.183] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id o10-v6sm8284285pgp.70.2018.09.07.03.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 03:38:34 -0700 (PDT)
Subject: Re: [PATCH 1/3] lightnvm: use internal allocation for chunk log page
To:     javier@javigon.com
Cc:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com
References: <1535537370-10729-1-git-send-email-javier@cnexlabs.com>
 <1535537370-10729-2-git-send-email-javier@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <8ee257b6-d275-356a-184a-749ef455d945@lightnvm.io>
Date:   Fri, 7 Sep 2018 12:38:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535537370-10729-2-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2018 12:09 PM, Javier González wrote:
> The lightnvm subsystem provides helpers to retrieve chunk metadata,
> where the target needs to provide a buffer to store the metadata. An
> implicit assumption is that this buffer is contiguous and can be used to
> retrieve the data from the device. If the device exposes too many
> chunks, then kmalloc might fail, thus failing instance creation.
> 
> This patch removes this assumption by implementing an internal buffer in
> the lightnvm subsystem to retrieve chunk metadata. Targets can then
> use virtual memory allocations. Since this is a target API change, adapt
> pblk accordingly.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-core.c |  4 ++--
>   drivers/lightnvm/pblk-init.c |  2 +-
>   drivers/nvme/host/lightnvm.c | 23 +++++++++++++++--------
>   3 files changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index fdcbeb920c9e..a311cc29afd8 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -120,7 +120,7 @@ static void pblk_end_io_erase(struct nvm_rq *rqd)
>   /*
>    * Get information for all chunks from the device.
>    *
> - * The caller is responsible for freeing the returned structure
> + * The caller is responsible for freeing (vmalloc) the returned structure
>    */
>   struct nvm_chk_meta *pblk_get_chunk_meta(struct pblk *pblk)
>   {
> @@ -134,7 +134,7 @@ struct nvm_chk_meta *pblk_get_chunk_meta(struct pblk *pblk)
>   	ppa.ppa = 0;
>   
>   	len = geo->all_chunks * sizeof(*meta);
> -	meta = kzalloc(len, GFP_KERNEL);
> +	meta = vzalloc(len);
>   	if (!meta)
>   		return ERR_PTR(-ENOMEM);
>   
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index e0db6de137d6..a99854439224 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -983,7 +983,7 @@ static int pblk_lines_init(struct pblk *pblk)
>   
>   	pblk_set_provision(pblk, nr_free_chks);
>   
> -	kfree(chunk_meta);
> +	vfree(chunk_meta);
>   	return 0;
>   
>   fail_free_lines:
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index 2c96e7fcdcac..5bfa354c5dd5 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -579,7 +579,7 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
>   	struct nvm_geo *geo = &ndev->geo;
>   	struct nvme_ns *ns = ndev->q->queuedata;
>   	struct nvme_ctrl *ctrl = ns->ctrl;
> -	struct nvme_nvm_chk_meta *dev_meta = (struct nvme_nvm_chk_meta *)meta;
> +	struct nvme_nvm_chk_meta *dev_meta, *dev_meta_off;
>   	struct ppa_addr ppa;
>   	size_t left = nchks * sizeof(struct nvme_nvm_chk_meta);
>   	size_t log_pos, offset, len;
> @@ -591,6 +591,10 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
>   	 */
>   	max_len = min_t(unsigned int, ctrl->max_hw_sectors << 9, 256 * 1024);
>   
> +	dev_meta = kmalloc(max_len, GFP_KERNEL);
> +	if (!dev_meta)
> +		return -ENOMEM;
> +
>   	/* Normalize lba address space to obtain log offset */
>   	ppa.ppa = slba;
>   	ppa = dev_to_generic_addr(ndev, ppa);
> @@ -604,6 +608,9 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
>   	while (left) {
>   		len = min_t(unsigned int, left, max_len);
>   
> +		memset(dev_meta, 0, max_len);
> +		dev_meta_off = dev_meta;
> +
>   		ret = nvme_get_log_ext(ctrl, ns, NVME_NVM_LOG_REPORT_CHUNK,
>   				dev_meta, len, offset);
>   		if (ret) {
> @@ -612,15 +619,15 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
>   		}
>   
>   		for (i = 0; i < len; i += sizeof(struct nvme_nvm_chk_meta)) {
> -			meta->state = dev_meta->state;
> -			meta->type = dev_meta->type;
> -			meta->wi = dev_meta->wi;
> -			meta->slba = le64_to_cpu(dev_meta->slba);
> -			meta->cnlb = le64_to_cpu(dev_meta->cnlb);
> -			meta->wp = le64_to_cpu(dev_meta->wp);
> +			meta->state = dev_meta_off->state;
> +			meta->type = dev_meta_off->type;
> +			meta->wi = dev_meta_off->wi;
> +			meta->slba = le64_to_cpu(dev_meta_off->slba);
> +			meta->cnlb = le64_to_cpu(dev_meta_off->cnlb);
> +			meta->wp = le64_to_cpu(dev_meta_off->wp);
>   
>   			meta++;
> -			dev_meta++;
> +			dev_meta_off++;
>   		}
>   
>   		offset += len;
> 

Thanks. Applied for 4.20.
