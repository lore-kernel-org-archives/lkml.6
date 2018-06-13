Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1D6C2C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B6E208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B6E208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935946AbeFMOol (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:44:41 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:36232 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935720AbeFMOoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:44:38 -0400
Received: by mail-ot0-f196.google.com with SMTP id c15-v6so3257058otl.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 07:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vRtm2IesPxLdmf8xChj4HvzpcNT7ko9W7kawvV2IqRY=;
        b=Lel9gbXT969r77B1DylmQrWOuDJ/BJlN1bfRPrIEKjaIqxyF3/E1zR7HBqRVhb4CZY
         OPNuSM77GSGBH7SstS8uRs0C4GcIq9/ojgD+kYgvSwUgNJXRMcswLzU9LmJmRD9iShlz
         L7uBbqnDpanzTwtQpexaoRjobS4SskNe4yzi4/818iLbYkzKygxTBdu91DA/8Y6iAYMh
         h9z48hOYoVeOBfU8pwsiclcGnH6Ii8fpJV6z1/rxMG14ErlhS1L/pFWgETaXkjGJAyqZ
         kx/cEMd/GYqR1mLOk34Ibtao8KjzaFCx7vAVMa56z+mBHeumkZ8Olbkqc9t/4tEJZxZR
         kb3w==
X-Gm-Message-State: APt69E0oRBc4YvgX4oOwzoc0y5kbcGyGziO1mkEqSOH7T3HfwLZDHpla
        fsD6jLrxLFyAjy3VXJKu6AHDnA==
X-Google-Smtp-Source: ADUXVKI8RqMflLG5d1weT4/YLWSrfJV7RdNM8meq+qscix1L902EVHWrWbixZY6BGQHak8UAf+nKLg==
X-Received: by 2002:a9d:4455:: with SMTP id f21-v6mr3524877otj.284.1528901078041;
        Wed, 13 Jun 2018 07:44:38 -0700 (PDT)
Received: from localhost ([130.164.62.61])
        by smtp.gmail.com with ESMTPSA id q23-v6sm1615185otd.25.2018.06.13.07.44.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 07:44:36 -0700 (PDT)
Date:   Wed, 13 Jun 2018 07:44:35 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luwei.kang@intel.com, yi.z.zhang@intel.com
Subject: Re: [PATCH v6 05/29] fpga: region: add compat_id support
Message-ID: <20180613144435.GE3866@archbook>
References: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
 <1528798243-2029-6-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528798243-2029-6-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 06:10:19PM +0800, Wu Hao wrote:
> This patch introduces a compat_id pointer member and sysfs interface
> for each fpga region, similar as compat_id for fpga manager, it allows
> applications to read the per region compat_id for compatibility
> checking before other actions on this fpga-region (e.g PR).
> 
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> v5: use pointer for compat_id as it's optional to implement.
> v6: add Acked-by from Alan.
> ---
>  Documentation/ABI/testing/sysfs-class-fpga-region |  9 +++++++++
>  drivers/fpga/fpga-region.c                        | 22 ++++++++++++++++++++++
>  include/linux/fpga/fpga-region.h                  |  2 ++
>  3 files changed, 33 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-region
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-fpga-region b/Documentation/ABI/testing/sysfs-class-fpga-region
> new file mode 100644
> index 0000000..ffdc853
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-fpga-region
> @@ -0,0 +1,9 @@
> +What:		/sys/class/fpga_region/<region>/compat_id
> +Date:		June 2018
> +KernelVersion:	4.18
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	FPGA region id for compatibility check, e.g compatibility
> +		of the FPGA reconfiguration hardware and image. This value
> +		is defined or calculated by the layer that is creating the
> +		FPGA region. This interface returns the compat_id value or
> +		just error code -ENOENT in case compat_id is not used.
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index 6d214d7..0d65220 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -158,6 +158,27 @@ int fpga_region_program_fpga(struct fpga_region *region)
>  }
>  EXPORT_SYMBOL_GPL(fpga_region_program_fpga);
>  
> +static ssize_t compat_id_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct fpga_region *region = to_fpga_region(dev);
> +
> +	if (!region->compat_id)
> +		return -ENOENT;
> +
> +	return sprintf(buf, "%016llx%016llx\n",
> +		       (unsigned long long)region->compat_id->id_h,
> +		       (unsigned long long)region->compat_id->id_l);
> +}
> +
> +static DEVICE_ATTR_RO(compat_id);
> +
> +static struct attribute *fpga_region_attrs[] = {
> +	&dev_attr_compat_id.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(fpga_region);
> +
>  /**
>   * fpga_region_create - alloc and init a struct fpga_region
>   * @dev: device parent
> @@ -258,6 +279,7 @@ static int __init fpga_region_init(void)
>  	if (IS_ERR(fpga_region_class))
>  		return PTR_ERR(fpga_region_class);
>  
> +	fpga_region_class->dev_groups = fpga_region_groups;
>  	fpga_region_class->dev_release = fpga_region_dev_release;
>  
>  	return 0;
> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
> index d7071cd..0521b7f 100644
> --- a/include/linux/fpga/fpga-region.h
> +++ b/include/linux/fpga/fpga-region.h
> @@ -14,6 +14,7 @@
>   * @bridge_list: list of FPGA bridges specified in region
>   * @mgr: FPGA manager
>   * @info: FPGA image info
> + * @compat_id: FPGA region id for compatibility check.
>   * @priv: private data
>   * @get_bridges: optional function to get bridges to a list
>   */
> @@ -23,6 +24,7 @@ struct fpga_region {
>  	struct list_head bridge_list;
>  	struct fpga_manager *mgr;
>  	struct fpga_image_info *info;
> +	struct fpga_compat_id *compat_id;
>  	void *priv;
>  	int (*get_bridges)(struct fpga_region *region);
>  };
> -- 
> 1.8.3.1
> 
Thanks,
Moritz
