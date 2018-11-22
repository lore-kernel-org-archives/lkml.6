Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EA4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B77820820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B77820820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392121AbeKVPpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 10:45:14 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:60136 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbeKVPpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 10:45:13 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2B5B274;
        Thu, 22 Nov 2018 05:07:32 +0000 (UTC)
Date:   Wed, 21 Nov 2018 21:07:30 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     danielijrobson@gmail.com
Cc:     dbueso@suse.de, manfred@colorfullife.com, ebiederm@xmission.com,
        mike.kravetz@oracle.com, linux@dominikbrodowski.net,
        viro@zeniv.linux.org.uk, ebiggers@google.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipc/shm.c: removed 'int err' from shm_get_policy()
Message-Id: <20181121210730.f820f51d03d1171d4319dc30@linux-foundation.org>
In-Reply-To: <20181118234911.17697-1-danielijrobson@gmail.com>
References: <20181118234911.17697-1-danielijrobson@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2018 23:49:11 +0000 danielijrobson@gmail.com wrote:

> removed unneeded variable in shm_get_policy()
> 
> ...
>
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -461,11 +461,10 @@ static int shm_set_policy(struct vm_area_struct *vma, struct mempolicy *new)
>  {
>  	struct file *file = vma->vm_file;
>  	struct shm_file_data *sfd = shm_file_data(file);
> -	int err = 0;
>  
>  	if (sfd->vm_ops->set_policy)
> -		err = sfd->vm_ops->set_policy(vma, new);
> -	return err;
> +		return sfd->vm_ops->set_policy(vma, new);
> +	return 0;
>  }

Sorry, I don't think this is enough of an improvement to justify adding
the patch.
