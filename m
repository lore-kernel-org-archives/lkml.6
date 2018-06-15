Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7538CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FBE208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33FBE208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936342AbeFOPY7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 11:24:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:56095 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935695AbeFOPY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 11:24:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8AD84ACC4;
        Fri, 15 Jun 2018 15:24:57 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH] xen: add new hypercall buffer mapping device
To:     Jan Beulich <JBeulich@suse.com>
Cc:     xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        lkml <linux-kernel@vger.kernel.org>
References: <20180615131740.5037-1-jgross@suse.com>
 <5B23CE9502000078001CBA36@suse.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cc607075-2d0b-3171-65e1-e24318777114@suse.com>
Date:   Fri, 15 Jun 2018 17:24:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5B23CE9502000078001CBA36@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/18 16:35, Jan Beulich wrote:
>>>> On 15.06.18 at 15:17, <jgross@suse.com> wrote:
>> --- /dev/null
>> +++ b/drivers/xen/privcmd-buf.c
>> @@ -0,0 +1,216 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>> +
>> +/******************************************************************************
>> + * privcmd-buf.c
>> + *
>> + * Mmap of hypercall buffers.
>> + *
>> + * Copyright (c) 2018 Juergen Gross
>> + */
>> +
>> +#define pr_fmt(fmt) "xen:" KBUILD_MODNAME ": " fmt
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/list.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/mm.h>
>> +#include <linux/slab.h>
>> +
>> +#include "privcmd.h"
>> +
>> +MODULE_LICENSE("GPL");
>> +
>> +static int limit = 64;
>> +module_param(limit, int, 0644);
> 
> Can this go negative? If not - "unsigned int" and "uint" prehaps?

Perhaps. ;-)

> 
>> +static int privcmd_buf_mmap(struct file *file, struct vm_area_struct *vma)
>> +{
>> +	struct privcmd_buf_private *file_priv = file->private_data;
>> +	struct privcmd_buf_vma_private *vma_priv;
>> +	unsigned int count = vma_pages(vma);
>> +	unsigned int i;
>> +	int ret = 0;
>> +
>> +	if (!(vma->vm_flags & VM_SHARED)) {
>> +		pr_err("Mapping must be shared\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (file_priv->allocated + count > limit) {
>> +		pr_err("Mapping limit reached!\n");
> 
> For both error messages - if you really want them, I think they should be
> made more helpful such that it is possible to identify the offender. Log at
> least process name and pid, or drop the messages?

I think dropping them should be fine.

> 
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
> 
> Don't you also need to undo the partially successful insertion?

No, this is done by generic mmap() handling when I'm returning an error.

> 
>> +struct miscdevice xen_privcmdbuf_dev = {
>> +	.minor = MISC_DYNAMIC_MINOR,
> 
> While dynamic minors are of course much better than fixed ones (as
> we used to use many years ago), but aren't they still a relatively
> limited resource? By setting a "mode" on a handle to the original
> privcmd interface, no new minor would be needed.

Hmm, I'm not very fond of this idea. That would make all privcmd
file ops rather clumsy. OTOH I can see the benfits.

Anyone wanting to comment on this idea?

> 
>> --- a/drivers/xen/privcmd.c
>> +++ b/drivers/xen/privcmd.c
>> @@ -1007,12 +1007,21 @@ static int __init privcmd_init(void)
>>  		pr_err("Could not register Xen privcmd device\n");
>>  		return err;
>>  	}
>> +
>> +	err = misc_register(&xen_privcmdbuf_dev);
>> +	if (err != 0) {
>> +		pr_err("Could not register Xen hypercall-buf device\n");
>> +		misc_deregister(&privcmd_dev);
>> +		return err;
> 
> Wouldn't this better be a warning only, without failing driver init?

No, I don't think so. We rather want the hypercall buffer handling to
be clean from now on.


Juergen
