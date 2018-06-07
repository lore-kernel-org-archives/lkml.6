Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id qAMuItGOGVsFGQAAmS7hNA
	; Thu, 07 Jun 2018 20:00:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9CEB56074D; Thu,  7 Jun 2018 20:00:23 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gOKBHrG7"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DB113601B4;
	Thu,  7 Jun 2018 20:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB113601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932344AbeFGUAV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:00:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43836 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeFGUAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:00:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w57Jp61N164383;
        Thu, 7 Jun 2018 20:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=kiNGnobxTXP1eaURQZEjyhjUkjiE3mJtn+mHLjbqbzQ=;
 b=gOKBHrG7Cwl0HeRHtYRDUlbHu7XxlPXZBPjryJVZph8oKjX21UpslDbo1GboM99x62uq
 Gt7IDZOBOKOuGgUDLWa8LRyntgUAEoFPIviwlxqliSGzl5oelR/q5HKnf4W1j+qHwnEO
 Jc9v56NJxzl1Wll0ogREDYXShbrZAptadvScbnd0SHSbnw67Kpncgci2qtl/kqeyWZA9
 ql7wzXFqJtoeuuhC9+v6blUhEPHk72M/etjyoP1P/4SbAjUFRVluYM2hEds1tli6JeKV
 PLSCgCGSspIT48k0joSQI7+GCGuQHBGXWUb4QWwihV9lCa856VYLOIF53wBl1wrnOFfi qg==
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2jbvypteuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jun 2018 20:00:00 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w57JxxNu018694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jun 2018 19:59:59 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w57Jxxb9006227;
        Thu, 7 Jun 2018 19:59:59 GMT
Received: from [192.168.0.120] (/202.156.141.250)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Jun 2018 12:59:58 -0700
Subject: Re: [PATCH 3.16 315/410] btrfs: use proper endianness accessors for
 super_copy
To: Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc: akpm@linux-foundation.org, Liu Bo <bo.li.liu@oracle.com>,
        David Sterba <dsterba@suse.com>
References: <lsq.1528380321.739649291@decadent.org.uk>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <452bdbb9-5785-3f1f-59aa-c59024716d80@oracle.com>
Date: Fri, 8 Jun 2018 04:02:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <lsq.1528380321.739649291@decadent.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8917 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806070211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ben,

  This patch was reverted from the mainline and 4.14 stable as it only
  added half of the endianness conversion and caused regression. This
  patch should not be included.

Thanks, Anand


On 06/07/2018 10:05 PM, Ben Hutchings wrote:
> 3.16.57-rc1 review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Anand Jain <anand.jain@oracle.com>
> 
> commit 3c181c12c431fe33b669410d663beb9cceefcd1b upstream.
> 
> The fs_info::super_copy is a byte copy of the on-disk structure and all
> members must use the accessor macros/functions to obtain the right
> value.  This was missing in update_super_roots and in sysfs readers.
> 
> Moving between opposite endianness hosts will report bogus numbers in
> sysfs, and mount may fail as the root will not be restored correctly. If
> the filesystem is always used on a same endian host, this will not be a
> problem.
> 
> Fix this by using the btrfs_set_super...() functions to set
> fs_info::super_copy values, and for the sysfs, use the cached
> fs_info::nodesize/sectorsize values.
> 
> Fixes: df93589a17378 ("btrfs: export more from FS_INFO to sysfs")
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reviewed-by: Liu Bo <bo.li.liu@oracle.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> [ update changelog ]
> Signed-off-by: David Sterba <dsterba@suse.com>
> [bwh: Backported to 3.16:
>   - btrfs_fs_info doesn't have cached nodesize or sectorsize fields, so use
>     the accessor functions
>   - Adjust context]
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -406,7 +406,7 @@ static ssize_t btrfs_nodesize_show(struc
>   {
>   	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
>   
> -	return snprintf(buf, PAGE_SIZE, "%u\n", fs_info->super_copy->nodesize);
> +	return snprintf(buf, PAGE_SIZE, "%u\n", btrfs_super_nodesize(fs_info->super_copy));
>   }
>   
>   BTRFS_ATTR_RW(nodesize, 0444, btrfs_nodesize_show, btrfs_no_store);
> @@ -416,7 +416,7 @@ static ssize_t btrfs_sectorsize_show(str
>   {
>   	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
>   
> -	return snprintf(buf, PAGE_SIZE, "%u\n", fs_info->super_copy->sectorsize);
> +	return snprintf(buf, PAGE_SIZE, "%u\n", btrfs_super_sectorsize(fs_info->super_copy));
>   }
>   
>   BTRFS_ATTR_RW(sectorsize, 0444, btrfs_sectorsize_show, btrfs_no_store);
> @@ -426,7 +426,7 @@ static ssize_t btrfs_clone_alignment_sho
>   {
>   	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
>   
> -	return snprintf(buf, PAGE_SIZE, "%u\n", fs_info->super_copy->sectorsize);
> +	return snprintf(buf, PAGE_SIZE, "%u\n", btrfs_super_sectorsize(fs_info->super_copy));
>   }
>   
>   BTRFS_ATTR_RW(clone_alignment, 0444, btrfs_clone_alignment_show, btrfs_no_store);
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1428,19 +1428,23 @@ static void update_super_roots(struct bt
>   
>   	super = root->fs_info->super_copy;
>   
> +	/* update latest btrfs_super_block::chunk_root refs */
>   	root_item = &root->fs_info->chunk_root->root_item;
> -	super->chunk_root = root_item->bytenr;
> -	super->chunk_root_generation = root_item->generation;
> -	super->chunk_root_level = root_item->level;
> +	btrfs_set_super_chunk_root(super, root_item->bytenr);
> +	btrfs_set_super_chunk_root_generation(super, root_item->generation);
> +	btrfs_set_super_chunk_root_level(super, root_item->level);
>   
> +	/* update latest btrfs_super_block::root refs */
>   	root_item = &root->fs_info->tree_root->root_item;
> -	super->root = root_item->bytenr;
> -	super->generation = root_item->generation;
> -	super->root_level = root_item->level;
> +	btrfs_set_super_root(super, root_item->bytenr);
> +	btrfs_set_super_generation(super, root_item->generation);
> +	btrfs_set_super_root_level(super, root_item->level);
> +
>   	if (btrfs_test_opt(root, SPACE_CACHE))
> -		super->cache_generation = root_item->generation;
> +		btrfs_set_super_cache_generation(super, root_item->generation);
>   	if (root->fs_info->update_uuid_tree_gen)
> -		super->uuid_tree_generation = root_item->generation;
> +		btrfs_set_super_uuid_tree_generation(super,
> +						     root_item->generation);
>   }
>   
>   int btrfs_transaction_in_commit(struct btrfs_fs_info *info)
> 
