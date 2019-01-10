Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D23CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B850720685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zaMRJz01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbfAJQ6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:58:34 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48378 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbfAJQ6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:58:34 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0AGrkDn180068;
        Thu, 10 Jan 2019 16:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=7Chk4M27S8U5tOjTqfzDgmGVgxpihuB7i7YZ2UXeIq0=;
 b=zaMRJz018TwD1ajhtrGnbC8AVUc6PpNkkb3KmqY+bx7gcP6EU+DJ2mZdd1z9F/1eZFbu
 rghSqj/2OF57eo12Pw0clasJsFOmEekjBDvTgA4xIJym6X6htuxHEIoy7eqfB+FPGPVE
 oWyxarnYI+qQQjWCAFZCbaOffRnMHxBaNyFHqT12OKEpZGyQh7wZrYwd5gfygiyXtRAp
 FY+Eyn9+xP4XOcpRFszJAlBtDMiHnW9OjejqF+20t9LiwqaHOZ05WQLC5STJKvRTcTQP
 CgPLxoEYwgKmMGSnMFIofdQYWEE4OQlJDeiZduv2WMWpZvu+1nuAQ5iamH0xj2ILXxGi +A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2ptn7r8902-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 16:58:18 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0AGwHgc015943
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 16:58:17 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0AGwGR7025863;
        Thu, 10 Jan 2019 16:58:17 GMT
Received: from [192.168.1.93] (/99.156.91.244)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Jan 2019 08:58:16 -0800
Subject: Re: [PATCH v1] fs/jfs: Switch to use new generic UUID API
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net
References: <20190110134153.83901-1-andriy.shevchenko@linux.intel.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Openpgp: preference=signencrypt
Message-ID: <026bd92b-4154-171a-a50d-d65200b2441b@oracle.com>
Date:   Thu, 10 Jan 2019 10:58:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190110134153.83901-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9131 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901100132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/19 7:41 AM, Andy Shevchenko wrote:
> There are new types and helpers that are supposed to be used in new code.
> 
> As a preparation to get rid of legacy types and API functions do
> the conversion here.

Looks good to me. I tweaked it slightly to keep checkpatch from
complaining about lines over 80 characters. I'll push it into -next for
v5.1.

Shaggy

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> - not tested on real FS
> 
>  fs/jfs/jfs_incore.h     |  6 ++++--
>  fs/jfs/jfs_logmgr.c     | 17 ++++++++---------
>  fs/jfs/jfs_logmgr.h     | 10 +++++-----
>  fs/jfs/jfs_mount.c      |  4 ++--
>  fs/jfs/jfs_superblock.h |  7 ++++---
>  fs/jfs/super.c          |  5 +++--
>  6 files changed, 26 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
> index 912a3af2393e..340eb8e4f716 100644
> --- a/fs/jfs/jfs_incore.h
> +++ b/fs/jfs/jfs_incore.h
> @@ -23,6 +23,8 @@
>  #include <linux/rwsem.h>
>  #include <linux/slab.h>
>  #include <linux/bitops.h>
> +#include <linux/uuid.h>
> +
>  #include "jfs_types.h"
>  #include "jfs_xtree.h"
>  #include "jfs_dtree.h"
> @@ -178,8 +180,8 @@ struct jfs_sb_info {
>  	pxd_t		logpxd;		/* pxd describing log	*/
>  	pxd_t		fsckpxd;	/* pxd describing fsck wkspc */
>  	pxd_t		ait2;		/* pxd describing AIT copy	*/
> -	char		uuid[16];	/* 128-bit uuid for volume	*/
> -	char		loguuid[16];	/* 128-bit uuid for log	*/
> +	uuid_t		uuid;		/* 128-bit uuid for volume	*/
> +	uuid_t		loguuid;	/* 128-bit uuid for log	*/
>  	/*
>  	 * commit_state is used for synchronization of the jfs_commit
>  	 * threads.  It is protected by LAZY_LOCK().
> diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
> index 6b68df395892..6361fa4d85db 100644
> --- a/fs/jfs/jfs_logmgr.c
> +++ b/fs/jfs/jfs_logmgr.c
> @@ -1092,8 +1092,7 @@ int lmLogOpen(struct super_block *sb)
>  	mutex_lock(&jfs_log_mutex);
>  	list_for_each_entry(log, &jfs_external_logs, journal_list) {
>  		if (log->bdev->bd_dev == sbi->logdev) {
> -			if (memcmp(log->uuid, sbi->loguuid,
> -				   sizeof(log->uuid))) {
> +			if (!uuid_equal(&log->uuid, &sbi->loguuid)) {
>  				jfs_warn("wrong uuid on JFS journal");
>  				mutex_unlock(&jfs_log_mutex);
>  				return -EINVAL;
> @@ -1130,7 +1129,7 @@ int lmLogOpen(struct super_block *sb)
>  	}
>  
>  	log->bdev = bdev;
> -	memcpy(log->uuid, sbi->loguuid, sizeof(log->uuid));
> +	uuid_copy(&log->uuid, &sbi->loguuid);
>  
>  	/*
>  	 * initialize log:
> @@ -1336,7 +1335,7 @@ int lmLogInit(struct jfs_log * log)
>  			jfs_info("lmLogInit: inline log:0x%p base:0x%Lx size:0x%x",
>  				 log, (unsigned long long)log->base, log->size);
>  		} else {
> -			if (memcmp(logsuper->uuid, log->uuid, 16)) {
> +			if (!uuid_equal(&logsuper->uuid, &log->uuid)) {
>  				jfs_warn("wrong uuid on JFS log device");
>  				goto errout20;
>  			}
> @@ -1732,7 +1731,7 @@ static int lmLogFileSystem(struct jfs_log * log, struct jfs_sb_info *sbi,
>  	int i;
>  	struct logsuper *logsuper;
>  	struct lbuf *bpsuper;
> -	char *uuid = sbi->uuid;
> +	uuid_t *uuid = &sbi->uuid;
>  
>  	/*
>  	 * insert/remove file system device to log active file system list.
> @@ -1743,8 +1742,8 @@ static int lmLogFileSystem(struct jfs_log * log, struct jfs_sb_info *sbi,
>  	logsuper = (struct logsuper *) bpsuper->l_ldata;
>  	if (activate) {
>  		for (i = 0; i < MAX_ACTIVE; i++)
> -			if (!memcmp(logsuper->active[i].uuid, NULL_UUID, 16)) {
> -				memcpy(logsuper->active[i].uuid, uuid, 16);
> +			if (uuid_is_null(&logsuper->active[i].uuid)) {
> +				uuid_copy(&logsuper->active[i].uuid, uuid);
>  				sbi->aggregate = i;
>  				break;
>  			}
> @@ -1755,8 +1754,8 @@ static int lmLogFileSystem(struct jfs_log * log, struct jfs_sb_info *sbi,
>  		}
>  	} else {
>  		for (i = 0; i < MAX_ACTIVE; i++)
> -			if (!memcmp(logsuper->active[i].uuid, uuid, 16)) {
> -				memcpy(logsuper->active[i].uuid, NULL_UUID, 16);
> +			if (uuid_equal(&logsuper->active[i].uuid, uuid)) {
> +				uuid_copy(&logsuper->active[i].uuid, &uuid_null);
>  				break;
>  			}
>  		if (i == MAX_ACTIVE) {
> diff --git a/fs/jfs/jfs_logmgr.h b/fs/jfs/jfs_logmgr.h
> index e38c21598850..870fc22360e7 100644
> --- a/fs/jfs/jfs_logmgr.h
> +++ b/fs/jfs/jfs_logmgr.h
> @@ -19,6 +19,8 @@
>  #ifndef	_H_JFS_LOGMGR
>  #define _H_JFS_LOGMGR
>  
> +#include <linux/uuid.h>
> +
>  #include "jfs_filsys.h"
>  #include "jfs_lock.h"
>  
> @@ -73,15 +75,13 @@ struct logsuper {
>  	__le32 state;		/* 4: state - see below */
>  
>  	__le32 end;		/* 4: addr of last log record set by logredo */
> -	char uuid[16];		/* 16: 128-bit journal uuid */
> +	uuid_t uuid;		/* 16: 128-bit journal uuid */
>  	char label[16];		/* 16: journal label */
>  	struct {
> -		char uuid[16];
> +		uuid_t uuid;
>  	} active[MAX_ACTIVE];	/* 2048: active file systems list */
>  };
>  
> -#define NULL_UUID "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
> -
>  /* log flag: commit option (see jfs_filsys.h) */
>  
>  /* log state */
> @@ -410,7 +410,7 @@ struct jfs_log {
>  	spinlock_t synclock;	/* 4: synclist lock */
>  	struct lbuf *wqueue;	/* 4: log pageout queue */
>  	int count;		/* 4: count */
> -	char uuid[16];		/* 16: 128-bit uuid of log device */
> +	uuid_t uuid;		/* 16: 128-bit uuid of log device */
>  
>  	int no_integrity;	/* 3: flag to disable journaling to disk */
>  };
> diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
> index d8658607bf46..c9c1f16b93df 100644
> --- a/fs/jfs/jfs_mount.c
> +++ b/fs/jfs/jfs_mount.c
> @@ -389,8 +389,8 @@ static int chkSuper(struct super_block *sb)
>  		sbi->logpxd = j_sb->s_logpxd;
>  	else {
>  		sbi->logdev = new_decode_dev(le32_to_cpu(j_sb->s_logdev));
> -		memcpy(sbi->uuid, j_sb->s_uuid, sizeof(sbi->uuid));
> -		memcpy(sbi->loguuid, j_sb->s_loguuid, sizeof(sbi->uuid));
> +		uuid_copy(&sbi->uuid, &j_sb->s_uuid);
> +		uuid_copy(&sbi->loguuid, &j_sb->s_loguuid);
>  	}
>  	sbi->fsckpxd = j_sb->s_fsckpxd;
>  	sbi->ait2 = j_sb->s_ait2;
> diff --git a/fs/jfs/jfs_superblock.h b/fs/jfs/jfs_superblock.h
> index 04847b8d3070..0a401f083d1a 100644
> --- a/fs/jfs/jfs_superblock.h
> +++ b/fs/jfs/jfs_superblock.h
> @@ -18,6 +18,8 @@
>  #ifndef	_H_JFS_SUPERBLOCK
>  #define _H_JFS_SUPERBLOCK
>  
> +#include <linux/uuid.h>
> +
>  /*
>   * make the magic number something a human could read
>   */
> @@ -100,10 +102,9 @@ struct jfs_superblock {
>  	pxd_t s_xlogpxd;	/* 8: extendfs logpxd */
>  	/* - 128 byte boundary - */
>  
> -	char s_uuid[16];	/* 16: 128-bit uuid for volume */
> +	uuid_t s_uuid;		/* 16: 128-bit uuid for volume */
>  	char s_label[16];	/* 16: volume label */
> -	char s_loguuid[16];	/* 16: 128-bit uuid for log device */
> -
> +	uuid_t s_loguuid;	/* 16: 128-bit uuid for log device */
>  };
>  
>  extern int readSuper(struct super_block *, struct buffer_head **);
> diff --git a/fs/jfs/super.c b/fs/jfs/super.c
> index 65d8fc87ab11..99a43e7f6ee0 100644
> --- a/fs/jfs/super.c
> +++ b/fs/jfs/super.c
> @@ -174,8 +174,9 @@ static int jfs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	buf->f_files = maxinodes;
>  	buf->f_ffree = maxinodes - (atomic_read(&imap->im_numinos) -
>  				    atomic_read(&imap->im_numfree));
> -	buf->f_fsid.val[0] = (u32)crc32_le(0, sbi->uuid, sizeof(sbi->uuid)/2);
> -	buf->f_fsid.val[1] = (u32)crc32_le(0, sbi->uuid + sizeof(sbi->uuid)/2,
> +	buf->f_fsid.val[0] = (u32)crc32_le(0, (char *)&sbi->uuid,
> +					sizeof(sbi->uuid)/2);
> +	buf->f_fsid.val[1] = (u32)crc32_le(0, (char *)&sbi->uuid + sizeof(sbi->uuid)/2,
>  					sizeof(sbi->uuid)/2);
>  
>  	buf->f_namelen = JFS_NAME_MAX;
> 
