Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 50C30C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D9D208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D9D208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756208AbeFOOQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 10:16:04 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:51234 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755645AbeFOOQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 10:16:02 -0400
X-IronPort-AV: E=Sophos;i="5.51,227,1526342400"; 
   d="scan'208";a="74724178"
Subject: Re: [Xen-devel] [PATCH] xen: add new hypercall buffer mapping device
To:     Juergen Gross <jgross@suse.com>, <linux-kernel@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>
CC:     <boris.ostrovsky@oracle.com>
References: <20180615131740.5037-1-jgross@suse.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Openpgp: preference=signencrypt
Autocrypt: addr=andrew.cooper3@citrix.com; prefer-encrypt=mutual; keydata=
 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
 6+ahAA==
Message-ID: <530a680a-4df2-e021-14ca-c8e2d5a551eb@citrix.com>
Date:   Fri, 15 Jun 2018 15:15:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615131740.5037-1-jgross@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/18 14:17, Juergen Gross wrote:
> +MODULE_LICENSE("GPL");
> +
> +static int limit = 64;
> +module_param(limit, int, 0644);
> +MODULE_PARM_DESC(limit, "Maximum number of pages that may be allocated by "
> +			"the privcmd-buf device per open file");

I have a feeling that, once we try and remove some of the bounce
buffering, 64 pages will be somewhat restricting.  In particular,
migration performance will benefit by keeping the logdirty bitmap buffer
persistently mapped, rather than allocated/bounced/deallocated on each
iteration.

However, perhaps 64 is fine for now.

> +static int privcmd_buf_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct privcmd_buf_private *file_priv = file->private_data;
> +	struct privcmd_buf_vma_private *vma_priv;
> +	unsigned int count = vma_pages(vma);

This will truncate to 0 if anyone tried mmap()ing 8T (if I've done my
calculations correctly) of virtual address space.

> +	unsigned int i;
> +	int ret = 0;
> +
> +	if (!(vma->vm_flags & VM_SHARED)) {
> +		pr_err("Mapping must be shared\n");
> +		return -EINVAL;
> +	}
> +
> +	if (file_priv->allocated + count > limit) {

cout > limit || (allocated + count) > limit to avoid overflows.

> +		pr_err("Mapping limit reached!\n");
> +		return -ENOSPC;
> +	}
> +
> +	vma_priv = kzalloc(sizeof(*vma_priv) + count * sizeof(void *),
> +			   GFP_KERNEL);
> +	if (!vma_priv)
> +		return -ENOMEM;
> +
> +	vma_priv->n_pages = count;
> +	count = 0;
> +	for (i = 0; i < vma_priv->n_pages; i++) {
> +		vma_priv->pages[i] = alloc_page(GFP_KERNEL | __GFP_ZERO);
> +		if (!vma_priv->pages[i])
> +			break;
> +		count++;
> +	}
> +
> +	mutex_lock(&file_priv->lock);
> +
> +	file_priv->allocated += count;
> +
> +	vma_priv->file_priv = file_priv;
> +	vma_priv->users = 1;
> +
> +	vma->vm_flags |= VM_IO | VM_DONTEXPAND | VM_DONTDUMP;

Why DONTDUMP? Its just data, and stands a reasonable chance of being
related to the cause of a crash.

> +	vma->vm_ops = &privcmd_buf_vm_ops;
> +	vma->vm_private_data = vma_priv;
> +
> +	list_add(&vma_priv->list, &file_priv->list);
> +
> +	if (vma_priv->n_pages != count)
> +		ret = -ENOMEM;
> +	else
> +		for (i = 0; i < vma_priv->n_pages; i++) {
> +			ret = vm_insert_page(vma, vma->vm_start + i * PAGE_SIZE,
> +					     vma_priv->pages[i]);
> +			if (ret)
> +				break;
> +		}
> +
> +	if (ret)
> +		privcmd_buf_vmapriv_free(vma_priv);
> +
> +	mutex_unlock(&file_priv->lock);
> +
> +	return ret;
> +}
> +
> +const struct file_operations xen_privcmdbuf_fops = {
> +	.owner = THIS_MODULE,
> +	.open = privcmd_buf_open,
> +	.release = privcmd_buf_release,
> +	.mmap = privcmd_buf_mmap,
> +};
> +EXPORT_SYMBOL_GPL(xen_privcmdbuf_fops);
> +
> +struct miscdevice xen_privcmdbuf_dev = {
> +	.minor = MISC_DYNAMIC_MINOR,
> +	.name = "xen/privcmd-buf",

Sorry to nitpick, but how about naming this just "xen/hypercall" ?

privcmd is currently a rather large security hole because it allows
userspace to have access to all the hypercalls, including the ones which
should be restricted to just the kernel.  In the past, a plan has been
floated to slowly replace the use of the raw ioctl() with proper ioctls
for the hypercalls which userspace might reasonably use.
> diff --git a/drivers/xen/xenfs/super.c b/drivers/xen/xenfs/super.c
> index 71ddfb4cf61c..d752d0dd3d1d 100644
> --- a/drivers/xen/xenfs/super.c
> +++ b/drivers/xen/xenfs/super.c
> @@ -48,6 +48,7 @@ static int xenfs_fill_super(struct super_block *sb, void *data, int silent)
>  		[2] = { "xenbus", &xen_xenbus_fops, S_IRUSR|S_IWUSR },
>  		{ "capabilities", &capabilities_file_ops, S_IRUGO },
>  		{ "privcmd", &xen_privcmd_fops, S_IRUSR|S_IWUSR },
> +		{ "privcmd-buf", &xen_privcmdbuf_fops, S_IRUSR|S_IWUSR },

Do we really need to provide the fallback here?  /dev/xen has been
around for ages, and it would really be a good thing if we can
eventually retire xenfs.

~Andrew
