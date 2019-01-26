Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB3DC282C0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F5A218F0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="suwu1d+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfAZDGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 22:06:18 -0500
Received: from sonic305-21.consmr.mail.gq1.yahoo.com ([98.137.64.84]:45828
        "EHLO sonic305-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725916AbfAZDGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 22:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1548471976; bh=YMjHO9DGrnYFQ0iG/jRnXEOb2J0X21r4Mq3lbz0C3GA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=suwu1d+9NN/LxoXkV2lxMeAET5G+KEcn+TMXbUdnGyXaQ80oJ+NWorvZTobXPOMy4uBGNccQ+W8lw3ReVpNRrlE+JxP3WWMMwi90LJIGxt9MLIIzOHyB5Ai7AdlEZkuQ08TfSZ+pScocn/mQoMgn8rzzVv8OpFr2D23HUvEU2Bq+ETmv/X+LOgNghzKtk95S6AGr3+2EbMw98I4+ZS8P1XGGV50+VCkxhtGA/rtPTCn2uJvPEkba9oSthKX4LLusywN9oK7dj0HTdTGwhokaPy2S4T/W86zZmGUmaskGP4NvcHX4lNr+gCQLKJRfzQODsUuF3zDbFs0PEb5LLwH5AQ==
X-YMail-OSG: ypjfWfwVM1nNieBaI4hSNIo5QkLhC89Ycv1ioSj2EriumnBXVEDvYXZORgQdwgo
 9h577qyg_dtyzkPS.u2yGsTPE.JQ_k9ksbAf1R1fEvhIUV2d64SD2KgrrldsuMvOUzkxmnyPIQds
 m99hpb3Bi89texL8sbTXjH1Dwew_PQXZPU3k06jrvWN_E.7y.oVERtWFokAe8NwH5Unyov3F.k.C
 z89cir9JZiT2YTDB.3Byi9cQ236HMwb1jbul_SrRSQtx.SrhSskjge3AocswLwv_1nH8A003JuQd
 LqL9OPDelZ_IkU7qUYHmZIWGl4qcDYXWyGr8DwpWMt43V4.llglFMNmm7ClKB_pzlfgvwJOdgw0y
 Fc_xZfxj.KUVB5S1AbD2wL15290B5Ek2jhY0cNfux2xW4xabLGKJ6LoEDKEXCWx6x4WAyB.KpAuW
 vR_Le6f_4Te2hRsFIxljaGJnGsMrcahvevhOJwxbZzP1BiEH.XGwG3QS145_i2B6tqQDGzULGQB.
 RaVQsmNsP5MEFEEhxOf.nC6HGcy6pgVORJbRul5NH5FBqkHlwL19YqfSBS5J4Nvgn.FzQJLq36b.
 ddhAcgU2O8vTaQsnrLHClWqV8z17HPoJTjRA4.GjN_k_oYfYjuNUsuwvyAcf4O0j.dSwvDvznIUT
 B6.dRTUIFFzplWzSQSk44.5cejISwPtfgFm3tjjeQGzE4W_fXqJM8UGRFF1NGu6d4Y06UgX.3vyN
 4XkWqpjrLUxlPts9isQ_0OL7GjgEhKITqLXxAKFQhmpQ1S.o.B1NP.JNSNgbleL_trq5neDk4qcm
 0LajY2EVzHPqRBRPMqJlnUEkUKDR85eJ_6AXVeelc2A33gPhb6Id18empGWxWD2blGFIe2jSughs
 AoZsQNtgQ8_NoKOjkIsMCj0b7upyKpLkdyz5qCxUZ.arzEAqUYtJt8FdH2D9tUJDPoVkAW03JPG5
 iWGUPruqSkX6BKZyI2FDb1YzGMuR4SGLaI2OMglUaQCDag8UsU4.BLZK6BXmr54euaXvd59.76mL
 FOEUORSCwQp9FpFilV8J2MCI60XEjaJYE9Ap93SjiAymrrhD9k.2ApA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.gq1.yahoo.com with HTTP; Sat, 26 Jan 2019 03:06:16 +0000
Received: from 125.120.85.115 (EHLO [10.1.1.220]) ([125.120.85.115])
          by smtp419.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d3b63daab4a55472c65c54c0414565b1;
          Sat, 26 Jan 2019 03:06:12 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] staging: erofs: complete POSIX ACL support
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>
References: <20190125161007.4447-1-gaoxiang25@huawei.com>
 <20190125161007.4447-2-gaoxiang25@huawei.com>
 <94daa491-40c8-4a09-a0b5-55a7e92dc3fc@huawei.com>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <531700c1-31b4-1a9d-d3f8-4ca4e85bfdff@aol.com>
Date:   Sat, 26 Jan 2019 11:06:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <94daa491-40c8-4a09-a0b5-55a7e92dc3fc@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On 2019/1/26 10:48, Chao Yu wrote:
> On 2019/1/26 0:10, Gao Xiang wrote:
>> Let's add .get_acl() to read the file's acl from its xattrs
>> to make POSIX ACL usable.
>>
>> Here is the on-disk detail,
>> fullname: system.posix_acl_access
>> struct erofs_xattr_entry:
>>         .e_name_len = 0
>>         .e_name_index = EROFS_XATTR_INDEX_POSIX_ACL_ACCESS (2)
>>
>> fullname: system.posix_acl_default
>> struct erofs_xattr_entry:
>> 	.e_name_len = 0
>> 	.e_name_index = EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT (3)
>>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> ---
>> change log v2:
>>  - add the missing SB_POSIXACL flag;
>>  - fix the on-disk detail, use .e_name_len == 0 and proper prefix value;
>>  - tested ok with xattr enabled erofs_mkfs;
>>
>>  .../erofs/Documentation/filesystems/erofs.txt      |  2 ++
>>  drivers/staging/erofs/inode.c                      |  3 ++
>>  drivers/staging/erofs/namei.c                      |  1 +
>>  drivers/staging/erofs/super.c                      |  8 +++++
>>  drivers/staging/erofs/xattr.c                      | 37 ++++++++++++++++++++++
>>  drivers/staging/erofs/xattr.h                      |  6 ++++
>>  6 files changed, 57 insertions(+)
>>
>> diff --git a/drivers/staging/erofs/Documentation/filesystems/erofs.txt b/drivers/staging/erofs/Documentation/filesystems/erofs.txt
>> index 803988d74c21..961ec4da7705 100644
>> --- a/drivers/staging/erofs/Documentation/filesystems/erofs.txt
>> +++ b/drivers/staging/erofs/Documentation/filesystems/erofs.txt
>> @@ -36,6 +36,8 @@ Here is the main features of EROFS:
>>  
>>   - Support xattr inline and tail-end data inline for all files;
>>  
>> + - Support POSIX.1e ACLs by using xattrs;
>> +
>>   - Support transparent file compression as an option:
>>     LZ4 algorithm with 4 KB fixed-output compression for high performance;
>>  
>> diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
>> index 4f04f7c38cf2..924b8dfc7a8f 100644
>> --- a/drivers/staging/erofs/inode.c
>> +++ b/drivers/staging/erofs/inode.c
>> @@ -287,6 +287,7 @@ const struct inode_operations erofs_generic_iops = {
>>  #ifdef CONFIG_EROFS_FS_XATTR
>>  	.listxattr = erofs_listxattr,
>>  #endif
>> +	.get_acl = erofs_get_acl,
>>  };
>>  
>>  const struct inode_operations erofs_symlink_iops = {
>> @@ -294,6 +295,7 @@ const struct inode_operations erofs_symlink_iops = {
>>  #ifdef CONFIG_EROFS_FS_XATTR
>>  	.listxattr = erofs_listxattr,
>>  #endif
>> +	.get_acl = erofs_get_acl,
>>  };
>>  
>>  const struct inode_operations erofs_fast_symlink_iops = {
>> @@ -301,5 +303,6 @@ const struct inode_operations erofs_fast_symlink_iops = {
>>  #ifdef CONFIG_EROFS_FS_XATTR
>>  	.listxattr = erofs_listxattr,
>>  #endif
>> +	.get_acl = erofs_get_acl,
>>  };
>>  
>> diff --git a/drivers/staging/erofs/namei.c b/drivers/staging/erofs/namei.c
>> index 7fed1f996ab0..b1752adc5934 100644
>> --- a/drivers/staging/erofs/namei.c
>> +++ b/drivers/staging/erofs/namei.c
>> @@ -238,5 +238,6 @@ const struct inode_operations erofs_dir_iops = {
>>  #ifdef CONFIG_EROFS_FS_XATTR
>>  	.listxattr = erofs_listxattr,
>>  #endif
>> +	.get_acl = erofs_get_acl,
>>  };
>>  
>> diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
>> index 176fca2af379..54cd7dac0a1f 100644
>> --- a/drivers/staging/erofs/super.c
>> +++ b/drivers/staging/erofs/super.c
>> @@ -398,6 +398,14 @@ static int erofs_read_super(struct super_block *sb,
>>  	if (!silent)
>>  		infoln("root inode @ nid %llu", ROOT_NID(sbi));
>>  
>> +#ifdef CONFIG_EROFS_FS_POSIX_ACL
>> +	/* Update the POSIXACL Flag */
>> +	if (test_opt(sbi, POSIX_ACL))
>> +		sb->s_flags |= SB_POSIXACL;
>> +	else
>> +		sb->s_flags &= ~SB_POSIXACL;
>> +#endif
>> +
>>  #ifdef CONFIG_EROFS_FS_ZIP
>>  	INIT_RADIX_TREE(&sbi->workstn_tree, GFP_ATOMIC);
>>  #endif
>> diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xattr.c
>> index 7de46690d972..6759485ae862 100644
>> --- a/drivers/staging/erofs/xattr.c
>> +++ b/drivers/staging/erofs/xattr.c
>> @@ -643,3 +643,40 @@ ssize_t erofs_listxattr(struct dentry *dentry,
>>  	return shared_listxattr(&it);
>>  }
>>  
>> +#ifdef CONFIG_EROFS_FS_POSIX_ACL
>> +struct posix_acl *erofs_get_acl(struct inode *inode, int type)
>> +{
>> +	struct posix_acl *acl;
>> +	int ea_prefix, rc;
>> +	char *value = NULL;
>> +
>> +	switch(type) {
>> +	case ACL_TYPE_ACCESS:
>> +		ea_prefix = EROFS_XATTR_INDEX_POSIX_ACL_ACCESS;
>> +		break;
>> +	case ACL_TYPE_DEFAULT:
>> +		ea_prefix = EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT;
>> +		break;
>> +	default:
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	rc = erofs_getxattr(inode, ea_prefix, "", NULL, 0);
>> +	if (rc > 0) {
>> +		value = kvmalloc(rc, GFP_KERNEL);
> 
> erofs_kmalloc() is enough?

I think kmalloc is enough for this case, but I think kvmalloc is not
bad as well.

Actually I want to introduce erofs_kvmalloc() in the later patch and
use it in general except for the context which is unsuitable for vmalloc..

Let me send v3 if it is unnecessary...

Thanks,
Gao Xiang

> 
> Thanks,
> 
>> +		if (!value)
>> +			return ERR_PTR(-ENOMEM);
>> +		rc = erofs_getxattr(inode, ea_prefix, "", value, rc);
>> +	}
>> +
>> +	if (rc == -ENOATTR)
>> +		acl = NULL;
>> +	else if (rc < 0)
>> +		acl = ERR_PTR(rc);
>> +	else
>> +		acl = posix_acl_from_xattr(&init_user_ns, value, rc);
>> +	kvfree(value);
>> +	return acl;
>> +}
>> +#endif
>> +
>> diff --git a/drivers/staging/erofs/xattr.h b/drivers/staging/erofs/xattr.h
>> index 634dae9aaa0b..35ba5ac2139a 100644
>> --- a/drivers/staging/erofs/xattr.h
>> +++ b/drivers/staging/erofs/xattr.h
>> @@ -87,5 +87,11 @@ static ssize_t __maybe_unused erofs_listxattr(struct dentry *dentry,
>>  }
>>  #endif
>>  
>> +#ifdef CONFIG_EROFS_FS_POSIX_ACL
>> +struct posix_acl *erofs_get_acl(struct inode *inode, int type);
>> +#else
>> +#define erofs_get_acl	(NULL)
>> +#endif
>> +
>>  #endif
>>  
>>
> 
