Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D729DC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9C821763
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="QijpzTz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9C821763
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731841AbeHNMpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:45:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41302 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbeHNMpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:45:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id y17-v6so14886905ljy.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 02:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gh71CDQ+Yl8BZDJs7AwyEAGyXZDnjDIUbrLFhVzy5Ns=;
        b=QijpzTz/jMQZJM8J9zfjHAP+SA2wFLJnnMg82F810lI+GemKv+6nkLgiGKCp2Es9y8
         9ShCTk4qvdvvVFl21K+85oyihNrBkU/BiSptUPBuwgYnK74xyukKlySbMDt1gTTJXVG/
         2vr3budFU35603LB0IKO3Qs0Ej1Af8EjHnG+z1Kup8CU6poK29MeBWw+N7gmWjUm+KV9
         5IXymgzLTWbhKtTOGqoqNbhVMn4X7Seeh78OcYIpGlPXwu+oK02xsyiG5d+wIK48vzL0
         UjF8PiNHkgdgRCt9HBCHvVRIUSGOFL57DY/QGRSIeZRUcpuuw/KDNxxYbHQqUvp0t5Jl
         pOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gh71CDQ+Yl8BZDJs7AwyEAGyXZDnjDIUbrLFhVzy5Ns=;
        b=qf1KlT2Wkxf3sc0CCWKcBBssbUqEyL7TY0MC172YtHmObBgk1gT3mq+rFbZ7f16Cn2
         v4AHH+Q7C6QEWVcsbCZiu+t4QouN9ZdVbD9BCuZ3GgfPwbS5iOYCnO5oWUttCinMfPVr
         fqeTLSV365dhzq2FzNJ/ABa7FTfyL77ZgSsItlpf3kPj/1vtueF1mIW8OwWCypnwl6lA
         jXdMTcCglxBg6oqLuC6JjekFSmOEg3DYyIJghjxbKUVGuq3tlAZn+L+uA3nWOvMan0As
         CtyzEGnxT88WgQMHYGOXQjjGA3uX4VwKb9nCn4iS8FNorRXnrnIgqUtML4LJZpIrtu2d
         7yZw==
X-Gm-Message-State: AOUpUlFNRVy1vng3qJVbDXDBgNUA14fSNprjSMHeAM2MVuaB4GkT63mf
        +dJfYT/+asnX36/Asb3f0grqzw==
X-Google-Smtp-Source: AA+uWPwbHl3JF+LjahFUInO1ZtqlJo70HjHK/uc0Hus4EltHmhRvi8PF3L1QUpcHGPlr5jOhG8sc/g==
X-Received: by 2002:a2e:998e:: with SMTP id w14-v6mr14533217lji.7.1534240761602;
        Tue, 14 Aug 2018 02:59:21 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id w12-v6sm3485265lji.63.2018.08.14.02.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 02:59:20 -0700 (PDT)
Subject: Re: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
 groups
To:     hare@suse.de, axboe@kernel.dk
Cc:     hch@lst.de, sagi@grimberg.me, keith.busch@intel.com,
        bart.vanassche@wdc.com, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hare@suse.com
References: <20180814073305.87255-1-hare@suse.de>
 <20180814073305.87255-3-hare@suse.de>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <f04800f9-d6c4-d3e4-1151-8210ef28b24b@lightnvm.io>
Date:   Tue, 14 Aug 2018 11:59:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180814073305.87255-3-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 09:33 AM, Hannes Reinecke wrote:
> We should be registering the ns_id attribute as default sysfs
> attribute groups, otherwise we have a race condition between
> the uevent and the attributes appearing in sysfs.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c      | 21 +++++++++------------
>   drivers/nvme/host/lightnvm.c  | 27 ++++-----------------------
>   drivers/nvme/host/multipath.c | 15 ++++-----------
>   drivers/nvme/host/nvme.h      | 11 +++--------
>   4 files changed, 20 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0e824e8c8fd7..8e26d98e9a8f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2734,6 +2734,12 @@ const struct attribute_group nvme_ns_id_attr_group = {
>   	.is_visible	= nvme_ns_id_attrs_are_visible,
>   };
>   
> +const struct attribute_group *nvme_ns_id_attr_groups[] = {
> +	&nvme_ns_id_attr_group,
> +	NULL, /* Will be filled in by lightnvm if present */
> +	NULL,
> +};
> +
>   #define nvme_show_str_function(field)						\
>   static ssize_t  field##_show(struct device *dev,				\
>   			    struct device_attribute *attr, char *buf)		\
> @@ -3099,14 +3105,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   
>   	nvme_get_ctrl(ctrl);
>   
> -	device_add_disk(ctrl->device, ns->disk, NULL);
> -	if (sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
> -					&nvme_ns_id_attr_group))
> -		pr_warn("%s: failed to create sysfs group for identification\n",
> -			ns->disk->disk_name);
> -	if (ns->ndev && nvme_nvm_register_sysfs(ns))
> -		pr_warn("%s: failed to register lightnvm sysfs group for identification\n",
> -			ns->disk->disk_name);
> +	if (ns->ndev)
> +		nvme_nvm_register_sysfs(ns);
> +	device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups);
>   
>   	nvme_mpath_add_disk(ns, id);
>   	nvme_fault_inject_init(ns);
> @@ -3132,10 +3133,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>   
>   	nvme_fault_inject_fini(ns);
>   	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
> -		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
> -					&nvme_ns_id_attr_group);
> -		if (ns->ndev)
> -			nvme_nvm_unregister_sysfs(ns);
>   		del_gendisk(ns->disk);
>   		blk_cleanup_queue(ns->queue);
>   		if (blk_get_integrity(ns->disk))
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index 6fe5923c95d4..7bf2f9da6293 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -1270,39 +1270,20 @@ static const struct attribute_group nvm_dev_attr_group_20 = {
>   	.attrs		= nvm_dev_attrs_20,
>   };
>   
> -int nvme_nvm_register_sysfs(struct nvme_ns *ns)
> +void nvme_nvm_register_sysfs(struct nvme_ns *ns)
>   {
>   	struct nvm_dev *ndev = ns->ndev;
>   	struct nvm_geo *geo = &ndev->geo;
>   
>   	if (!ndev)
> -		return -EINVAL;
> -
> -	switch (geo->major_ver_id) {
> -	case 1:
> -		return sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
> -					&nvm_dev_attr_group_12);
> -	case 2:
> -		return sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
> -					&nvm_dev_attr_group_20);
> -	}
> -
> -	return -EINVAL;
> -}
> -
> -void nvme_nvm_unregister_sysfs(struct nvme_ns *ns)
> -{
> -	struct nvm_dev *ndev = ns->ndev;
> -	struct nvm_geo *geo = &ndev->geo;
> +		return;
>   
>   	switch (geo->major_ver_id) {
>   	case 1:
> -		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
> -					&nvm_dev_attr_group_12);
> +		nvme_ns_id_attr_groups[1] = &nvm_dev_attr_group_12;
>   		break;
>   	case 2:
> -		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
> -					&nvm_dev_attr_group_20);
> +		nvme_ns_id_attr_groups[1] = &nvm_dev_attr_group_20;
>   		break;
>   	}
>   }
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 477af51d01e8..8e846095c42d 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -282,13 +282,9 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
>   	if (!head->disk)
>   		return;
>   
> -	if (!(head->disk->flags & GENHD_FL_UP)) {
> -		device_add_disk(&head->subsys->dev, head->disk, NULL);
> -		if (sysfs_create_group(&disk_to_dev(head->disk)->kobj,
> -				&nvme_ns_id_attr_group))
> -			dev_warn(&head->subsys->dev,
> -				 "failed to create id group.\n");
> -	}
> +	if (!(head->disk->flags & GENHD_FL_UP))
> +		device_add_disk(&head->subsys->dev, head->disk,
> +				nvme_ns_id_attr_groups);
>   
>   	kblockd_schedule_work(&ns->head->requeue_work);
>   }
> @@ -494,11 +490,8 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
>   {
>   	if (!head->disk)
>   		return;
> -	if (head->disk->flags & GENHD_FL_UP) {
> -		sysfs_remove_group(&disk_to_dev(head->disk)->kobj,
> -				   &nvme_ns_id_attr_group);
> +	if (head->disk->flags & GENHD_FL_UP)
>   		del_gendisk(head->disk);
> -	}
>   	blk_set_queue_dying(head->disk->queue);
>   	/* make sure all pending bios are cleaned up */
>   	kblockd_schedule_work(&head->requeue_work);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index bb4a2003c097..9ba6d67d8e0a 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -459,7 +459,7 @@ int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
>   int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp,
>   		void *log, size_t size, u64 offset);
>   
> -extern const struct attribute_group nvme_ns_id_attr_group;
> +extern const struct attribute_group *nvme_ns_id_attr_groups[];
>   extern const struct block_device_operations nvme_ns_head_ops;
>   
>   #ifdef CONFIG_NVME_MULTIPATH
> @@ -551,8 +551,7 @@ static inline void nvme_mpath_stop(struct nvme_ctrl *ctrl)
>   void nvme_nvm_update_nvm_info(struct nvme_ns *ns);
>   int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node);
>   void nvme_nvm_unregister(struct nvme_ns *ns);
> -int nvme_nvm_register_sysfs(struct nvme_ns *ns);
> -void nvme_nvm_unregister_sysfs(struct nvme_ns *ns);
> +void nvme_nvm_register_sysfs(struct nvme_ns *ns);
>   int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd, unsigned long arg);
>   #else
>   static inline void nvme_nvm_update_nvm_info(struct nvme_ns *ns) {};
> @@ -563,11 +562,7 @@ static inline int nvme_nvm_register(struct nvme_ns *ns, char *disk_name,
>   }
>   
>   static inline void nvme_nvm_unregister(struct nvme_ns *ns) {};
> -static inline int nvme_nvm_register_sysfs(struct nvme_ns *ns)
> -{
> -	return 0;
> -}
> -static inline void nvme_nvm_unregister_sysfs(struct nvme_ns *ns) {};
> +static inline void nvme_nvm_register_sysfs(struct nvme_ns *ns) {};
>   static inline int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd,
>   							unsigned long arg)
>   {
> 

Thanks Hannes.

Acked-by: Matias Bjørling <mb@lightnvm.io>
