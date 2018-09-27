Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D18C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFB6216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Qimntw7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CFB6216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeI1CRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:17:19 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3572 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbeI1CRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:17:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bad36240000>; Thu, 27 Sep 2018 12:57:24 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 27 Sep 2018 12:57:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 27 Sep 2018 12:57:22 -0700
Received: from [10.24.70.87] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 27 Sep
 2018 19:57:19 +0000
Subject: Re: [PATCH v3 2/2] vfio: add edid support to mbochs sample driver
To:     Gerd Hoffmann <kraxel@redhat.com>,
        <intel-gvt-dev@lists.freedesktop.org>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     <kvm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20180921083013.15028-1-kraxel@redhat.com>
 <20180921083013.15028-3-kraxel@redhat.com>
X-Nvconfidentiality: public
From:   Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <4b9847dd-c37d-1d5d-3343-7030e62894fb@nvidia.com>
Date:   Fri, 28 Sep 2018 01:27:16 +0530
MIME-Version: 1.0
In-Reply-To: <20180921083013.15028-3-kraxel@redhat.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1538078244; bh=famG4nz4l3rxXGbRzqYjuLqLAjshCjlGyZ6AjUbeKvw=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Qimntw7E9zzt2UYDdEsbab0rv1SSY6guiMW6rD3iY2c5EYfwCn81W+YXRzEFVw3bD
         JMS+fEzy8jV2XHdILpT5b77LqG6TW5mcVSfm/+U0omsEZVtq6FxwOVHTadLMXBvk0c
         35IOCZaTpBcMwAA+qJvlFYYpPw553ka7+WxspbDjsSd3Lo1CCFRGLGtXjcCHx5IJLy
         YM/opQ5a5GBBFQKpJfADUgLNCRT45uSU4ClQWhudwfnBL4f0WNkX+2XQwJ0lUqVGNf
         MXigjWfMXxliYsWW57IAhaa2b3kHuRlQhWYpmnP1BzvqzZb+88FRcwtmGbxfna2LCW
         URBf6JtkAIYDQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/2018 2:00 PM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  samples/vfio-mdev/mbochs.c | 136 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 117 insertions(+), 19 deletions(-)
> 
> diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
> index 2535c3677c..ca7960adf5 100644
> --- a/samples/vfio-mdev/mbochs.c
> +++ b/samples/vfio-mdev/mbochs.c
> @@ -71,11 +71,19 @@
>  #define MBOCHS_NAME		  "mbochs"
>  #define MBOCHS_CLASS_NAME	  "mbochs"
>  
> +#define MBOCHS_EDID_REGION_INDEX  VFIO_PCI_NUM_REGIONS
> +#define MBOCHS_NUM_REGIONS        (MBOCHS_EDID_REGION_INDEX+1)
> +
>  #define MBOCHS_CONFIG_SPACE_SIZE  0xff
>  #define MBOCHS_MMIO_BAR_OFFSET	  PAGE_SIZE
>  #define MBOCHS_MMIO_BAR_SIZE	  PAGE_SIZE
> -#define MBOCHS_MEMORY_BAR_OFFSET  (MBOCHS_MMIO_BAR_OFFSET + \
> +#define MBOCHS_EDID_OFFSET	  (MBOCHS_MMIO_BAR_OFFSET +	\
>  				   MBOCHS_MMIO_BAR_SIZE)
> +#define MBOCHS_EDID_SIZE	  PAGE_SIZE
> +#define MBOCHS_MEMORY_BAR_OFFSET  (MBOCHS_EDID_OFFSET + \
> +				   MBOCHS_EDID_SIZE)
> +
> +#define MBOCHS_EDID_BLOB_OFFSET   (MBOCHS_EDID_SIZE/2)
>  
>  #define STORE_LE16(addr, val)	(*(u16 *)addr = val)
>  #define STORE_LE32(addr, val)	(*(u32 *)addr = val)
> @@ -95,16 +103,24 @@ MODULE_PARM_DESC(mem, "megabytes available to " MBOCHS_NAME " devices");
>  static const struct mbochs_type {
>  	const char *name;
>  	u32 mbytes;
> +	u32 max_x;
> +	u32 max_y;
>  } mbochs_types[] = {
>  	{
>  		.name	= MBOCHS_CLASS_NAME "-" MBOCHS_TYPE_1,
>  		.mbytes = 4,
> +		.max_x  = 800,
> +		.max_y  = 600,
>  	}, {
>  		.name	= MBOCHS_CLASS_NAME "-" MBOCHS_TYPE_2,
>  		.mbytes = 16,
> +		.max_x  = 1920,
> +		.max_y  = 1440,
>  	}, {
>  		.name	= MBOCHS_CLASS_NAME "-" MBOCHS_TYPE_3,
>  		.mbytes = 64,
> +		.max_x  = 0,
> +		.max_y  = 0,
>  	},
>  };
>  
> @@ -115,6 +131,11 @@ static struct cdev	mbochs_cdev;
>  static struct device	mbochs_dev;
>  static int		mbochs_used_mbytes;
>  
> +struct vfio_region_info_ext {
> +	struct vfio_region_info          base;
> +	struct vfio_region_info_cap_type type;
> +};
> +
>  struct mbochs_mode {
>  	u32 drm_format;
>  	u32 bytepp;
> @@ -144,13 +165,14 @@ struct mdev_state {
>  	u32 memory_bar_mask;
>  	struct mutex ops_lock;
>  	struct mdev_device *mdev;
> -	struct vfio_device_info dev_info;
>  
>  	const struct mbochs_type *type;
>  	u16 vbe[VBE_DISPI_INDEX_COUNT];
>  	u64 memsize;
>  	struct page **pages;
>  	pgoff_t pagecount;
> +	struct vfio_region_gfx_edid edid_regs;
> +	u8 edid_blob[0x400];
>  
>  	struct list_head dmabufs;
>  	u32 active_id;
> @@ -342,10 +364,20 @@ static void handle_mmio_read(struct mdev_state *mdev_state, u16 offset,
>  			     char *buf, u32 count)
>  {
>  	struct device *dev = mdev_dev(mdev_state->mdev);
> +	struct vfio_region_gfx_edid *edid;
>  	u16 reg16 = 0;
>  	int index;
>  
>  	switch (offset) {
> +	case 0x000 ... 0x3ff: /* edid block */
> +		edid = &mdev_state->edid_regs;
> +		if (edid->link_state != VFIO_DEVICE_GFX_LINK_STATE_UP ||
> +		    offset >= edid->edid_size) {
> +			memset(buf, 0, count);
> +			break;
> +		}
> +		memcpy(buf, mdev_state->edid_blob + offset, count);
> +		break;
>  	case 0x500 ... 0x515: /* bochs dispi interface */
>  		if (count != 2)
>  			goto unhandled;
> @@ -365,6 +397,44 @@ static void handle_mmio_read(struct mdev_state *mdev_state, u16 offset,
>  	}
>  }
>  
> +static void handle_edid_regs(struct mdev_state *mdev_state, u16 offset,
> +			     char *buf, u32 count, bool is_write)
> +{
> +	char *regs = (void *)&mdev_state->edid_regs;
> +
> +	if (offset + count > sizeof(mdev_state->edid_regs))
> +		return;
> +	if (count != 4)
> +		return;
> +	if (offset % 4)
> +		return;
> +
> +	if (is_write) {
> +		switch (offset) {
> +		case offsetof(struct vfio_region_gfx_edid, link_state):
> +		case offsetof(struct vfio_region_gfx_edid, edid_size):
> +			memcpy(regs + offset, buf, count);
> +			break;
> +		default:
> +			/* read-only regs */
> +			break;
> +		}
> +	} else {
> +		memcpy(buf, regs + offset, count);
> +	}
> +}
> +
> +static void handle_edid_blob(struct mdev_state *mdev_state, u16 offset,
> +			     char *buf, u32 count, bool is_write)
> +{
> +	if (offset + count > mdev_state->edid_regs.edid_max_size)
> +		return;
> +	if (is_write)
> +		memcpy(mdev_state->edid_blob + offset, buf, count);
> +	else
> +		memcpy(buf, mdev_state->edid_blob + offset, count);
> +}
> +
>  static ssize_t mdev_access(struct mdev_device *mdev, char *buf, size_t count,
>  			   loff_t pos, bool is_write)
>  {
> @@ -384,13 +454,25 @@ static ssize_t mdev_access(struct mdev_device *mdev, char *buf, size_t count,
>  			memcpy(buf, (mdev_state->vconfig + pos), count);
>  
>  	} else if (pos >= MBOCHS_MMIO_BAR_OFFSET &&
> -		   pos + count <= MBOCHS_MEMORY_BAR_OFFSET) {
> +		   pos + count <= (MBOCHS_MMIO_BAR_OFFSET +
> +				   MBOCHS_MMIO_BAR_SIZE)) {
>  		pos -= MBOCHS_MMIO_BAR_OFFSET;
>  		if (is_write)
>  			handle_mmio_write(mdev_state, pos, buf, count);
>  		else
>  			handle_mmio_read(mdev_state, pos, buf, count);
>  
> +	} else if (pos >= MBOCHS_EDID_OFFSET &&
> +		   pos + count <= (MBOCHS_EDID_OFFSET +
> +				   MBOCHS_EDID_SIZE)) {
> +		pos -= MBOCHS_EDID_OFFSET;
> +		if (pos < MBOCHS_EDID_BLOB_OFFSET) {
> +			handle_edid_regs(mdev_state, pos, buf, count, is_write);
> +		} else {
> +			pos -= MBOCHS_EDID_BLOB_OFFSET;
> +			handle_edid_blob(mdev_state, pos, buf, count, is_write);
> +		}
> +
>  	} else if (pos >= MBOCHS_MEMORY_BAR_OFFSET &&
>  		   pos + count <=
>  		   MBOCHS_MEMORY_BAR_OFFSET + mdev_state->memsize) {
> @@ -471,6 +553,10 @@ static int mbochs_create(struct kobject *kobj, struct mdev_device *mdev)
>  	mdev_state->next_id = 1;
>  
>  	mdev_state->type = type;
> +	mdev_state->edid_regs.max_xres = type->max_x;
> +	mdev_state->edid_regs.max_yres = type->max_y;
> +	mdev_state->edid_regs.edid_offset = MBOCHS_EDID_BLOB_OFFSET;
> +	mdev_state->edid_regs.edid_max_size = sizeof(mdev_state->edid_blob);
>  	mbochs_create_config_space(mdev_state);
>  	mbochs_reset(mdev);
>  
> @@ -932,16 +1018,16 @@ static int mbochs_dmabuf_export(struct mbochs_dmabuf *dmabuf)
>  }
>  
>  static int mbochs_get_region_info(struct mdev_device *mdev,
> -				  struct vfio_region_info *region_info,
> -				  u16 *cap_type_id, void **cap_type)
> +				  struct vfio_region_info_ext *ext)
>  {
> +	struct vfio_region_info *region_info = &ext->base;
>  	struct mdev_state *mdev_state;
>  
>  	mdev_state = mdev_get_drvdata(mdev);
>  	if (!mdev_state)
>  		return -EINVAL;
>  
> -	if (region_info->index >= VFIO_PCI_NUM_REGIONS)
> +	if (region_info->index >= MBOCHS_NUM_REGIONS)
>  		return -EINVAL;
>  
>  	switch (region_info->index) {
> @@ -964,6 +1050,20 @@ static int mbochs_get_region_info(struct mdev_device *mdev,
>  		region_info->flags  = (VFIO_REGION_INFO_FLAG_READ  |
>  				       VFIO_REGION_INFO_FLAG_WRITE);
>  		break;
> +	case MBOCHS_EDID_REGION_INDEX:
> +		ext->base.argsz = sizeof(*ext);
> +		ext->base.offset = MBOCHS_EDID_OFFSET;
> +		ext->base.size = MBOCHS_EDID_SIZE;
> +		ext->base.flags = (VFIO_REGION_INFO_FLAG_READ  |
> +				   VFIO_REGION_INFO_FLAG_WRITE |
> +				   VFIO_REGION_INFO_FLAG_CAPS);

Any reason to not to use _MMAP flag?
How would QEMU side code read this region? will it be always trapped?
If vendor driver sets _MMAP flag, will QEMU side handle that case as well?
I think since its blob, edid could be read by QEMU using one memcpy
rather than adding multiple memcpy of 4 or 8 bytes.

Thanks,
Kirti

> +		ext->base.cap_offset = offsetof(typeof(*ext), type);
> +		ext->type.header.id = VFIO_REGION_INFO_CAP_TYPE;
> +		ext->type.header.version = 1;
> +		ext->type.header.next = 0;
> +		ext->type.type = VFIO_REGION_TYPE_GFX;
> +		ext->type.subtype = VFIO_REGION_SUBTYPE_GFX_EDID;
> +		break;
>  	default:
>  		region_info->size   = 0;
>  		region_info->offset = 0;
> @@ -984,7 +1084,7 @@ static int mbochs_get_device_info(struct mdev_device *mdev,
>  				  struct vfio_device_info *dev_info)
>  {
>  	dev_info->flags = VFIO_DEVICE_FLAGS_PCI;
> -	dev_info->num_regions = VFIO_PCI_NUM_REGIONS;
> +	dev_info->num_regions = MBOCHS_NUM_REGIONS;
>  	dev_info->num_irqs = VFIO_PCI_NUM_IRQS;
>  	return 0;
>  }
> @@ -1084,7 +1184,7 @@ static long mbochs_ioctl(struct mdev_device *mdev, unsigned int cmd,
>  			unsigned long arg)
>  {
>  	int ret = 0;
> -	unsigned long minsz;
> +	unsigned long minsz, outsz;
>  	struct mdev_state *mdev_state;
>  
>  	mdev_state = mdev_get_drvdata(mdev);
> @@ -1106,8 +1206,6 @@ static long mbochs_ioctl(struct mdev_device *mdev, unsigned int cmd,
>  		if (ret)
>  			return ret;
>  
> -		memcpy(&mdev_state->dev_info, &info, sizeof(info));
> -
>  		if (copy_to_user((void __user *)arg, &info, minsz))
>  			return -EFAULT;
>  
> @@ -1115,24 +1213,24 @@ static long mbochs_ioctl(struct mdev_device *mdev, unsigned int cmd,
>  	}
>  	case VFIO_DEVICE_GET_REGION_INFO:
>  	{
> -		struct vfio_region_info info;
> -		u16 cap_type_id = 0;
> -		void *cap_type = NULL;
> +		struct vfio_region_info_ext info;
>  
> -		minsz = offsetofend(struct vfio_region_info, offset);
> +		minsz = offsetofend(typeof(info), base.offset);
>  
>  		if (copy_from_user(&info, (void __user *)arg, minsz))
>  			return -EFAULT;
>  
> -		if (info.argsz < minsz)
> +		outsz = info.base.argsz;
> +		if (outsz < minsz)
> +			return -EINVAL;
> +		if (outsz > sizeof(info))
>  			return -EINVAL;
>  
> -		ret = mbochs_get_region_info(mdev, &info, &cap_type_id,
> -					   &cap_type);
> +		ret = mbochs_get_region_info(mdev, &info);
>  		if (ret)
>  			return ret;
>  
> -		if (copy_to_user((void __user *)arg, &info, minsz))
> +		if (copy_to_user((void __user *)arg, &info, outsz))
>  			return -EFAULT;
>  
>  		return 0;
> @@ -1148,7 +1246,7 @@ static long mbochs_ioctl(struct mdev_device *mdev, unsigned int cmd,
>  			return -EFAULT;
>  
>  		if ((info.argsz < minsz) ||
> -		    (info.index >= mdev_state->dev_info.num_irqs))
> +		    (info.index >= VFIO_PCI_NUM_IRQS))
>  			return -EINVAL;
>  
>  		ret = mbochs_get_irq_info(mdev, &info);
> 
