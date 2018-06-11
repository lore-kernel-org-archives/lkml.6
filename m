Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 443C1C07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0279E20660
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0279E20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934162AbeFKSMt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:12:49 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:44634 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933281AbeFKSMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:12:48 -0400
Received: by mail-ot0-f195.google.com with SMTP id w13-v6so24877071ote.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 11:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A9yxv76u0LGKoyvnFpdKMfgXudYUm4W+AiZ3rXhIiQc=;
        b=IkfpRcbADEZCtjrYIl54RaxYYmj9m7wKVOKU2+yl3IJbA/9pJCCNtOzn2MDcSFkG8E
         zuxRdsMBatChSdslPDE727GFiQKIvlsLmyHSewbEdvtQSaqL5ur9hU8NQsi27XqunrQ0
         QesoeyC+5kvaLwoOc+6Z42aRKJqK8mCGrjB8aX1EfMSAkEk5e1ZjkOGfjyYJZWLOR4M6
         F6IIvEY7ty78ghWsTdxkI/6RV/+BZhyAYqnDp6oBlh0QvApqsbhcjagY0xZQnHSpXEcJ
         8MQsHmCIa5/IbU0QbVcK6R/zj5Q5o23ddnRy1Lag+eaHgnXPJxQezC52Z9tDDGhriL3+
         wY6Q==
X-Gm-Message-State: APt69E0KLC8tQChIR0h7fS0a6CucLI8F0PQffS2JyljE3tyFNZ1UP2Tn
        cqjQeQcZOeDJaldePvHqxOWGobEhPBQ=
X-Google-Smtp-Source: ADUXVKKG0SMa24cPvPQRpJK4QFFj4ZhG5MBlFmWaIIgAE/dAPglZyNl9JJ2G9aj1vcVbPdYA/KyHsQ==
X-Received: by 2002:a9d:3684:: with SMTP id h4-v6mr188978otc.186.1528740768386;
        Mon, 11 Jun 2018 11:12:48 -0700 (PDT)
Received: from ?IPv6:2601:602:9802:a8dc::d2dd? ([2601:602:9802:a8dc::d2dd])
        by smtp.gmail.com with ESMTPSA id t4-v6sm19558631otd.40.2018.06.11.11.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 11:12:47 -0700 (PDT)
Subject: Re: [PATCH] Revert "debugfs: inode: debugfs_create_dir uses mode
 permission from parent"
To:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     efault@gmx.de
References: <20180611092810.21886-1-tmricht@linux.ibm.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <7afa9f6a-f37d-384b-d719-bb5e50a00442@redhat.com>
Date:   Mon, 11 Jun 2018 11:12:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180611092810.21886-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2018 02:28 AM, Thomas Richter wrote:
> This reverts commit 95cde3c59966f6371b6bcd9e4e2da2ba64ee9775.
> It breaks the ioctl(KVM_CREATE_VM) interface.
> 

Can you elaborate a little more on how this breaks? Fedora has
gotten at least one report of a failure in this ioctl and
I'd like know if it's the same issue.

Thanks,
Laura

> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>   fs/debugfs/inode.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index a913b12fc7f8..13b01351dd1c 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -512,9 +512,7 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
>   	if (unlikely(!inode))
>   		return failed_creating(dentry);
>   
> -	if (!parent)
> -		parent = debugfs_mount->mnt_root;
> -	inode->i_mode = S_IFDIR | ((d_inode(parent)->i_mode & 0770));
> +	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
>   	inode->i_op = &simple_dir_inode_operations;
>   	inode->i_fop = &simple_dir_operations;
>   
> 

