Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A9403C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7B120896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7B120896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756286AbeFOOj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 10:39:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:49611 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756243AbeFOOj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 10:39:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 093F9AD29;
        Fri, 15 Jun 2018 14:39:25 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH] xen: add new hypercall buffer mapping device
To:     Andrew Cooper <andrew.cooper3@citrix.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     boris.ostrovsky@oracle.com
References: <20180615131740.5037-1-jgross@suse.com>
 <530a680a-4df2-e021-14ca-c8e2d5a551eb@citrix.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <df025cce-1d31-f978-9655-63171473ceb9@suse.com>
Date:   Fri, 15 Jun 2018 16:39:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <530a680a-4df2-e021-14ca-c8e2d5a551eb@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/18 16:15, Andrew Cooper wrote:
> On 15/06/18 14:17, Juergen Gross wrote:
>> +MODULE_LICENSE("GPL");
>> +
>> +static int limit = 64;
>> +module_param(limit, int, 0644);
>> +MODULE_PARM_DESC(limit, "Maximum number of pages that may be allocated by "
>> +			"the privcmd-buf device per open file");
> 
> I have a feeling that, once we try and remove some of the bounce
> buffering, 64 pages will be somewhat restricting.  In particular,
> migration performance will benefit by keeping the logdirty bitmap buffer
> persistently mapped, rather than allocated/bounced/deallocated on each
> iteration.
> 
> However, perhaps 64 is fine for now.
> 
>> +static int privcmd_buf_mmap(struct file *file, struct vm_area_struct *vma)
>> +{
>> +	struct privcmd_buf_private *file_priv = file->private_data;
>> +	struct privcmd_buf_vma_private *vma_priv;
>> +	unsigned int count = vma_pages(vma);
> 
> This will truncate to 0 if anyone tried mmap()ing 8T (if I've done my
> calculations correctly) of virtual address space.

Okay, I'll change the type to unsigned long.

> 
>> +	unsigned int i;
>> +	int ret = 0;
>> +
>> +	if (!(vma->vm_flags & VM_SHARED)) {
>> +		pr_err("Mapping must be shared\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (file_priv->allocated + count > limit) {
> 
> cout > limit || (allocated + count) > limit to avoid overflows.

unsigned long again.

> 
>> +		pr_err("Mapping limit reached!\n");
>> +		return -ENOSPC;
>> +	}
>> +
>> +	vma_priv = kzalloc(sizeof(*vma_priv) + count * sizeof(void *),
>> +			   GFP_KERNEL);
>> +	if (!vma_priv)
>> +		return -ENOMEM;
>> +
>> +	vma_priv->n_pages = count;
>> +	count = 0;
>> +	for (i = 0; i < vma_priv->n_pages; i++) {
>> +		vma_priv->pages[i] = alloc_page(GFP_KERNEL | __GFP_ZERO);
>> +		if (!vma_priv->pages[i])
>> +			break;
>> +		count++;
>> +	}
>> +
>> +	mutex_lock(&file_priv->lock);
>> +
>> +	file_priv->allocated += count;
>> +
>> +	vma_priv->file_priv = file_priv;
>> +	vma_priv->users = 1;
>> +
>> +	vma->vm_flags |= VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
> 
> Why DONTDUMP? Its just data, and stands a reasonable chance of being
> related to the cause of a crash.

Hmm, yes. I'll drop it.

> 
>> +	vma->vm_ops = &privcmd_buf_vm_ops;
>> +	vma->vm_private_data = vma_priv;
>> +
>> +	list_add(&vma_priv->list, &file_priv->list);
>> +
>> +	if (vma_priv->n_pages != count)
>> +		ret = -ENOMEM;
>> +	else
>> +		for (i = 0; i < vma_priv->n_pages; i++) {
>> +			ret = vm_insert_page(vma, vma->vm_start + i * PAGE_SIZE,
>> +					     vma_priv->pages[i]);
>> +			if (ret)
>> +				break;
>> +		}
>> +
>> +	if (ret)
>> +		privcmd_buf_vmapriv_free(vma_priv);
>> +
>> +	mutex_unlock(&file_priv->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +const struct file_operations xen_privcmdbuf_fops = {
>> +	.owner = THIS_MODULE,
>> +	.open = privcmd_buf_open,
>> +	.release = privcmd_buf_release,
>> +	.mmap = privcmd_buf_mmap,
>> +};
>> +EXPORT_SYMBOL_GPL(xen_privcmdbuf_fops);
>> +
>> +struct miscdevice xen_privcmdbuf_dev = {
>> +	.minor = MISC_DYNAMIC_MINOR,
>> +	.name = "xen/privcmd-buf",
> 
> Sorry to nitpick, but how about naming this just "xen/hypercall" ?

I really have no special preferences here.

> privcmd is currently a rather large security hole because it allows
> userspace to have access to all the hypercalls, including the ones which
> should be restricted to just the kernel.  In the past, a plan has been
> floated to slowly replace the use of the raw ioctl() with proper ioctls
> for the hypercalls which userspace might reasonably use.

I'd rather let the privcmd driver either ask the hypervisor which
hypercalls are fine to call from user mode, or let it encapsulate
the hypercall in a new "user hypercall" which the hypervisor can
verify then.

>> diff --git a/drivers/xen/xenfs/super.c b/drivers/xen/xenfs/super.c
>> index 71ddfb4cf61c..d752d0dd3d1d 100644
>> --- a/drivers/xen/xenfs/super.c
>> +++ b/drivers/xen/xenfs/super.c
>> @@ -48,6 +48,7 @@ static int xenfs_fill_super(struct super_block *sb, void *data, int silent)
>>  		[2] = { "xenbus", &xen_xenbus_fops, S_IRUSR|S_IWUSR },
>>  		{ "capabilities", &capabilities_file_ops, S_IRUGO },
>>  		{ "privcmd", &xen_privcmd_fops, S_IRUSR|S_IWUSR },
>> +		{ "privcmd-buf", &xen_privcmdbuf_fops, S_IRUSR|S_IWUSR },
> 
> Do we really need to provide the fallback here?  /dev/xen has been
> around for ages, and it would really be a good thing if we can
> eventually retire xenfs.

I'd be fine dropping it.

Just did some archaeology: /dev/xen is supported since Xen 4.5. Do we
really want to drop support of older Xen versions in the Linux kernel?


Juergen
