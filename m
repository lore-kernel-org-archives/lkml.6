Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D9AC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E5F218E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="MSqVRvFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E5F218E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbeHNLt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 07:49:58 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:34306 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeHNLt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 07:49:58 -0400
Received: by mail-ed1-f41.google.com with SMTP id h1-v6so9720062eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 02:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=macxT4f4i7/rGR0kacmzWCsMuPlAQWB705JcFdVUGTM=;
        b=MSqVRvFg2uRYPF38DeGGvbPZXuseCNxPq0MB/2Lxs0ignJ3IKrm6GzgOOEFkmr8qdh
         TIEarlWAEAQeNx8SxQjXnG086OLaVx4DmmCvfM74lMiT+Z9uU7AE5YiRiEKtDKjiYjDd
         G50TSuap7M/CmsKWGoOmcfDb+MxmOeRf63VV4UO6/FL1nVvI7rOV9kn2KsKJf2J4s8Kx
         pOPUtJ++C+weo9E9ulYczz5BCxHzxBqljdzJ0Tehvzcqe6Zx05BZY75gqxlWIE0PcTf1
         PjADciUOcpXFZ1hYFak2pbZxfbLo+vR2pTjpRxN8aNxZ5z+7DSXdxvh6WqyjIc4iw5fk
         jWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=macxT4f4i7/rGR0kacmzWCsMuPlAQWB705JcFdVUGTM=;
        b=Zs5rynknMrjDchzb11vsyTEao1jhF8LLrPcwdt2BcDw8knRykHUExtqZWehi/cpH5E
         vAKsj3xlkZi+qi/QujTUZT4U/GmFnemVeszkZKpdgcoqHDJ4jOAXoJWQj+Oc68zagziJ
         adOSsVA8LSCXNxz3CjV6A/ajkz+VU7cxQrrKZ7st0tMI0nXFBAy0lFrioQqNjdt1Q3eO
         2AoJs8Kobpeb7Hw+7oWRGPet6JqU8pWGPd+Qbj930Xm1IlRKLJInbXfvbnuXI3IF366o
         XhXpodAwSiom2eMEN2eG+dihfQGl7ubMSALVXvB7kMoLT2vGcJOXhTb7++eS3RKRxkMO
         RP2Q==
X-Gm-Message-State: AOUpUlG3CS4zn1Tc667jNL3q5Qh3gmaxoDsMYQ1lUEbQUP8cRwzcejWY
        naUcK7FTnk6MDvX0v8gVI3s0VA==
X-Google-Smtp-Source: AA+uWPwj0jzVxSnNF/RqdqQJBj1YmDRVUiRXrfoQpd9QpqHyezbkSrRnYS/uDJ1f6EJyhKn6bkSQ2A==
X-Received: by 2002:a50:abc2:: with SMTP id u60-v6mr26218533edc.43.1534237421606;
        Tue, 14 Aug 2018 02:03:41 -0700 (PDT)
Received: from mac-halley13.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id i3-v6sm7617984edt.42.2018.08.14.02.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 02:03:41 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <7DC1C517-A47E-4DB3-9D17-9EFB94073887@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_B8D00315-E04C-4A11-B708-6F16DE93EAF3";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
 groups
Date:   Tue, 14 Aug 2018 11:03:37 +0200
In-Reply-To: <20180814073305.87255-3-hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Bart van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
References: <20180814073305.87255-1-hare@suse.de>
 <20180814073305.87255-3-hare@suse.de>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_B8D00315-E04C-4A11-B708-6F16DE93EAF3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

>=20
> On 14 Aug 2018, at 09.33, Hannes Reinecke <hare@suse.de> wrote:
>=20
> We should be registering the ns_id attribute as default sysfs
> attribute groups, otherwise we have a race condition between
> the uevent and the attributes appearing in sysfs.
>=20
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
> drivers/nvme/host/core.c      | 21 +++++++++------------
> drivers/nvme/host/lightnvm.c  | 27 ++++-----------------------
> drivers/nvme/host/multipath.c | 15 ++++-----------
> drivers/nvme/host/nvme.h      | 11 +++--------
> 4 files changed, 20 insertions(+), 54 deletions(-)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0e824e8c8fd7..8e26d98e9a8f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2734,6 +2734,12 @@ const struct attribute_group =
nvme_ns_id_attr_group =3D {
> 	.is_visible	=3D nvme_ns_id_attrs_are_visible,
> };
>=20
> +const struct attribute_group *nvme_ns_id_attr_groups[] =3D {
> +	&nvme_ns_id_attr_group,
> +	NULL, /* Will be filled in by lightnvm if present */
> +	NULL,
> +};
> +
> #define nvme_show_str_function(field)						=
\
> static ssize_t  field##_show(struct device *dev,				=
\
> 			    struct device_attribute *attr, char *buf)		=
\
> @@ -3099,14 +3105,9 @@ static void nvme_alloc_ns(struct nvme_ctrl =
*ctrl, unsigned nsid)
>=20
> 	nvme_get_ctrl(ctrl);
>=20
> -	device_add_disk(ctrl->device, ns->disk, NULL);
> -	if (sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
> -					&nvme_ns_id_attr_group))
> -		pr_warn("%s: failed to create sysfs group for =
identification\n",
> -			ns->disk->disk_name);
> -	if (ns->ndev && nvme_nvm_register_sysfs(ns))
> -		pr_warn("%s: failed to register lightnvm sysfs group for =
identification\n",
> -			ns->disk->disk_name);
> +	if (ns->ndev)
> +		nvme_nvm_register_sysfs(ns);
> +	device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups);
>=20
> 	nvme_mpath_add_disk(ns, id);
> 	nvme_fault_inject_init(ns);
> @@ -3132,10 +3133,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>=20
> 	nvme_fault_inject_fini(ns);
> 	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
> -		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
> -					&nvme_ns_id_attr_group);
> -		if (ns->ndev)
> -			nvme_nvm_unregister_sysfs(ns);
> 		del_gendisk(ns->disk);
> 		blk_cleanup_queue(ns->queue);
> 		if (blk_get_integrity(ns->disk))
> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
> index 6fe5923c95d4..7bf2f9da6293 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -1270,39 +1270,20 @@ static const struct attribute_group =
nvm_dev_attr_group_20 =3D {
> 	.attrs		=3D nvm_dev_attrs_20,
> };
>=20
> -int nvme_nvm_register_sysfs(struct nvme_ns *ns)
> +void nvme_nvm_register_sysfs(struct nvme_ns *ns)
> {
> 	struct nvm_dev *ndev =3D ns->ndev;
> 	struct nvm_geo *geo =3D &ndev->geo;
>=20
> 	if (!ndev)
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
> -	struct nvm_dev *ndev =3D ns->ndev;
> -	struct nvm_geo *geo =3D &ndev->geo;
> +		return;
>=20
> 	switch (geo->major_ver_id) {
> 	case 1:
> -		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
> -					&nvm_dev_attr_group_12);
> +		nvme_ns_id_attr_groups[1] =3D &nvm_dev_attr_group_12;
> 		break;
> 	case 2:
> -		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
> -					&nvm_dev_attr_group_20);
> +		nvme_ns_id_attr_groups[1] =3D &nvm_dev_attr_group_20;
> 		break;
> 	}
> }
> diff --git a/drivers/nvme/host/multipath.c =
b/drivers/nvme/host/multipath.c
> index 477af51d01e8..8e846095c42d 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -282,13 +282,9 @@ static void nvme_mpath_set_live(struct nvme_ns =
*ns)
> 	if (!head->disk)
> 		return;
>=20
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
>=20
> 	kblockd_schedule_work(&ns->head->requeue_work);
> }
> @@ -494,11 +490,8 @@ void nvme_mpath_remove_disk(struct nvme_ns_head =
*head)
> {
> 	if (!head->disk)
> 		return;
> -	if (head->disk->flags & GENHD_FL_UP) {
> -		sysfs_remove_group(&disk_to_dev(head->disk)->kobj,
> -				   &nvme_ns_id_attr_group);
> +	if (head->disk->flags & GENHD_FL_UP)
> 		del_gendisk(head->disk);
> -	}
> 	blk_set_queue_dying(head->disk->queue);
> 	/* make sure all pending bios are cleaned up */
> 	kblockd_schedule_work(&head->requeue_work);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index bb4a2003c097..9ba6d67d8e0a 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -459,7 +459,7 @@ int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
> int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 =
lsp,
> 		void *log, size_t size, u64 offset);
>=20
> -extern const struct attribute_group nvme_ns_id_attr_group;
> +extern const struct attribute_group *nvme_ns_id_attr_groups[];
> extern const struct block_device_operations nvme_ns_head_ops;
>=20
> #ifdef CONFIG_NVME_MULTIPATH
> @@ -551,8 +551,7 @@ static inline void nvme_mpath_stop(struct =
nvme_ctrl *ctrl)
> void nvme_nvm_update_nvm_info(struct nvme_ns *ns);
> int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node);
> void nvme_nvm_unregister(struct nvme_ns *ns);
> -int nvme_nvm_register_sysfs(struct nvme_ns *ns);
> -void nvme_nvm_unregister_sysfs(struct nvme_ns *ns);
> +void nvme_nvm_register_sysfs(struct nvme_ns *ns);
> int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd, unsigned long =
arg);
> #else
> static inline void nvme_nvm_update_nvm_info(struct nvme_ns *ns) {};
> @@ -563,11 +562,7 @@ static inline int nvme_nvm_register(struct =
nvme_ns *ns, char *disk_name,
> }
>=20
> static inline void nvme_nvm_unregister(struct nvme_ns *ns) {};
> -static inline int nvme_nvm_register_sysfs(struct nvme_ns *ns)
> -{
> -	return 0;
> -}
> -static inline void nvme_nvm_unregister_sysfs(struct nvme_ns *ns) {};
> +static inline void nvme_nvm_register_sysfs(struct nvme_ns *ns) {};
> static inline int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd,
> 							unsigned long =
arg)
> {
> --
> 2.12.3
>=20
>=20

The lightnvm part you added to V2 looks good. Thanks!


Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_B8D00315-E04C-4A11-B708-6F16DE93EAF3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAltymukACgkQPEYBfS0l
eOCuTg/+Nuxs7egM/BBgWINqasHbnU1BuXabqZHgSjtsb2ip4VOgKK8rTxxknVEx
1dC565aMzA6o1muS6DBP6GFYxEGg5ksnGXWnv18Ik8ba6fmOficR0FPB9CGZiiV2
oXM4Vd5ljMckqPaMqTcowmhHDlVL15eM8O6FbtERiDwVSKweT7sdHdcGXX4UpsAW
TsUomg17u5nJvdmDbbw7SZkLH5ucqbDZD63277MhmFwnZ9Cb+uH0HKukvNS2g+rt
Tflz7NpAl1ZsXGRidxk55/ACHAMQx4fpU1j4XijCZYnhDpKxrLkk9coZ6Lu5sRpM
2im33ue3J3LTE0q1mggfcczEVX7wj20JhZAEOAVC5aT0rnkf8a6vAVYpByJYYkJo
8CGTX5wjK0Hd+UVjVe4FPcdKrASpuyjD0m/lRHHkkmzu8s4eHE/dkzdsOme6dAnq
HKL4XJe98WcnRBIBRzqN3y7tt6D28TvKzRy8sYT10Iwf4joj8/obyWLETuYJR0zI
/LGOmsQYNw36iN3osnOet/KuEgPr4+BhKQjXTW0sd02nFRhwx9oMh6SSeElQE1mL
8/I9MlHdypoNpOWnI4AimHxy5zCc2E++rA5NxaaKucczVQb0lTvkZ5x3MRGsXWdI
1CABafwehtqx9PqZLvjR6DctT5IiwvbGLsPdCuqngWfysOCoUwQ=
=HH1P
-----END PGP SIGNATURE-----

--Apple-Mail=_B8D00315-E04C-4A11-B708-6F16DE93EAF3--
