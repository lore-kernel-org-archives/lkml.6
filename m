Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B4FC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2947120880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2947120880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeILUT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:19:29 -0400
Received: from mout.gmx.net ([212.227.15.18]:53877 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbeILUT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:19:29 -0400
Received: from [10.0.0.14] ([113.87.91.49]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MJk04-1g1D9k3LiW-0016ro; Wed, 12
 Sep 2018 17:04:45 +0200
Subject: Re: [PATCH v2 2/5] ext4: cache NULL when both default_acl and acl are
 NULL
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     jack@suse.com, jaegeuk@kernel.org, yuchao0@huawei.com,
        shaggy@kernel.org, hubcap@omnibond.com, martin@omnibond.com,
        devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        jfs-discussion@lists.sourceforge.net
References: <20180831143352.22970-1-cgxu519@gmx.com>
 <20180831143352.22970-2-cgxu519@gmx.com>
From:   cgxu519 <cgxu519@gmx.com>
Message-ID: <f1dd02a3-78ea-0240-72cc-135ee26f6524@gmx.com>
Date:   Wed, 12 Sep 2018 23:04:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180831143352.22970-2-cgxu519@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Provags-ID: V03:K1:mIatdzC03k0f10jGPkm1FBUZoB6babITqGa3dMCCpVS/P4O96AJ
 ndhsfDuFZdM6wnBDFMxLe1B6bkIec1ji57z/cmA1c6GOm+H08Dbfj4ZCsg+ViqaXaB28wo+
 gsTxqMU7hohTURxdWHXErU7MAygEw5GGicZT5pexYfAC3fF5qIl1tFuP+ra77Yk+FGgiuMZ
 9ExHvGYXzFxtV25w0zgJQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KNBu9F54qmM=:oSsTzVkwhjT/RMfzWAzZ0E
 nabCZV9XPsrha63umRlLqdFL9vqUyrENJ3/xcPvNPCf7Z/d4rMJbj3qfOZZAwsLaiP/s3BnSj
 iJd1f0wU4OIJaXMZgA3vARcJaFv6dJiSIcipXu3wWRCE/ParNv1zVTAPThni19FEznYKSMwMz
 emdIhSIjqWfXnZNNOCa7n6gnpq6mz2Ph0aDimVHQPShYOWICLrJh1ZxXiOnMoJB+0tyDSF9Do
 eHNmzy228XCPGm0i6DhKU7lew2bZq1u2mJfr5p1SirrQsWt7MYuqBV040R4F9haK+QhK8PcR0
 8/8gzXCtM9NTxjFjtRe8lfgLzVDNR46N+ORKA2uiRM2qKUq6sPLVTt6vF2ZEmrXXhVa19EMnY
 I40XalPiFhFIEsGfY4Q+dBMcTUrM2kMd5Fac92QBUg0RtYqFHcD2j5lMfNjfLihdg8VFQxQ2f
 hl+6nsCzh61FhdXNV72Ae5NHURzFrR+TKCfLKL541zxpbXH3+pTN8DFAn06peq1u60KRfgt/A
 SfEZpL0o0Ua5O/YmsseJzjjgflP57yqGCldOyoKqNwiSjBAF2V0gACdId+d0pcRW4zUunJKfm
 u/oE5fqHlxmm/UzxoF5vu3O8wgPyPrtLUVwI4dOzjpe1Xx34+5/6PbMu9ZA6XF25z6xicw52a
 CgR50ZFfe1Xpzu1mUUUcpNLbdQaQbwhvKW7kWVWrtbXmlbRGmg1doLm021P9NJtpFIRYeLktp
 Q6fYRll8ppgIc+jPsh5s7av2E6dETvSy6yV/fJ1TNvSi7iOH6tzb1qFol8utOtWeCXHVxcKXg
 tyBbZX5hI/ZsffUWPj3891Nc9yUERF2wXpqbehVPgNG6CnfEeQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/2018 10:33 PM, Chengguang Xu wrote:
> default_acl and acl of newly created inode will be initiated
> as ACL_NOT_CACHED in vfs function inode_init_always() and later
> will be updated by calling xxx_init_acl() in specific filesystems.
> Howerver, when default_acl and acl are NULL then they keep the value
> of ACL_NOT_CACHED, this patch tries to cache NULL for acl/default_acl
> in this case.
>
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> ---
> v1->v2:
> - Coding style change.
>
>   fs/ext4/acl.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
> index fb50f9aa6ead..c1d570ee1d9f 100644
> --- a/fs/ext4/acl.c
> +++ b/fs/ext4/acl.c
> @@ -284,12 +284,16 @@ ext4_init_acl(handle_t *handle, struct inode *inode, struct inode *dir)
>   		error = __ext4_set_acl(handle, inode, ACL_TYPE_DEFAULT,
>   				       default_acl, XATTR_CREATE);
>   		posix_acl_release(default_acl);
> +	} else {
> +		inode->i_default_acl = NULL;
>   	}
>   	if (acl) {
>   		if (!error)
>   			error = __ext4_set_acl(handle, inode, ACL_TYPE_ACCESS,
>   					       acl, XATTR_CREATE);
>   		posix_acl_release(acl);
> +	} else {
> +		inode->i_acl = NULL;
>   	}
>   	return error;
>   }

Hi Ted,  Andreas

Have you got chance to look at this patch?

Thanks,
Chengguang


