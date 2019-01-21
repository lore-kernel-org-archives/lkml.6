Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F6AC7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AD021019
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfAUMAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:00:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728258AbfAUMAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:00:33 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0LBv6Pc030110
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 07:00:32 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q5bdmdu6d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 07:00:30 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 21 Jan 2019 12:00:20 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 21 Jan 2019 12:00:16 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0LC0F8B47251512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 12:00:15 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F377FA405F;
        Mon, 21 Jan 2019 12:00:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EAE1A4065;
        Mon, 21 Jan 2019 12:00:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.90.201])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 21 Jan 2019 12:00:13 +0000 (GMT)
Subject: Re: [PATCH v2] ima: define ima_post_create_tmpfile() hook and add
 missing call
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Ignaz Forster <iforster@suse.de>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabian Vogt <fvogt@suse.de>, Al Viro <viro@ZenIV.linux.org.uk>
Date:   Mon, 21 Jan 2019 07:00:03 -0500
In-Reply-To: <20190117213421.ggasuc263dpqh46c@merlin>
References: <1545158873.4206.86.camel@linux.ibm.com>
         <20190117213421.ggasuc263dpqh46c@merlin>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19012112-0016-0000-0000-00000248470C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012112-0017-0000-0000-000032A277D6
Message-Id: <1548072003.3782.24.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-21_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901210095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-17 at 15:34 -0600, Goldwyn Rodrigues wrote:
> On 13:47 18/12, Mimi Zohar wrote:
> > If tmpfiles can be made persistent, then newly created tmpfiles need to
> > be treated like any other new files in policy.
> > 
> > This patch indicates which newly created tmpfiles are in policy, causing
> > the file hash to be calculated on __fput().
> 
> Discussed in overlayfs, this would be better if we use this on inode
> and called from vfs_tmpfile() instead of do_tmpfile(). This will cover
> the overlayfs case which uses tmpfiles while performing copy_up().
> The patch is attached.
> 
> Here is the updated patch which works for my cases.
> However, it is the the failure case after setting the IMA flags
> I am concerned about, though I don't think that should be as harmful.

Right.  The new IMA hook allocates memory for storing the flags, which
needs to be cleaned up on failure.  For this reason, the IMA call is
deferred until after the transition from locally freeing memory on
failure to relying on __fput().  In "do_last", the call to IMA is
after "opened"; and in the original version of this patch the call to
IMA is after finish_open().

Mimi

> 
> 
> If tmpfiles can be made persistent, then newly created tmpfiles need to
> be treated like any other new files in policy.
> 
> This patch indicates which newly created tmpfiles are in policy, causing
> the file hash to be calculated on __fput().
> 
> Reported-by: Ignaz Forster <ignaz.forster@gmx.de>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/namei.c                        |  1 +
>  include/linux/ima.h               |  6 ++++++
>  security/integrity/ima/ima_main.c | 35 +++++++++++++++++++++++++++++++++--
>  3 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 914178cdbe94..373a7ec4b09d 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3462,6 +3462,7 @@ struct dentry *vfs_tmpfile(struct dentry *dentry, umode_t mode, int open_flag)
>  		inode->i_state |= I_LINKABLE;
>  		spin_unlock(&inode->i_lock);
>  	}
> +	ima_post_create_tmpfile(inode);
>  	return child;
>  
>  out_err:
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index b5e16b8c50b7..32b0c5bdcd99 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -18,6 +18,7 @@ struct linux_binprm;
>  #ifdef CONFIG_IMA
>  extern int ima_bprm_check(struct linux_binprm *bprm);
>  extern int ima_file_check(struct file *file, int mask);
> +extern void ima_post_create_tmpfile(struct inode *inode);
>  extern void ima_file_free(struct file *file);
>  extern int ima_file_mmap(struct file *file, unsigned long prot);
>  extern int ima_load_data(enum kernel_load_data_id id);
> @@ -56,6 +57,11 @@ static inline int ima_file_check(struct file *file, int mask)
>  	return 0;
>  }
>  
> +static inline void ima_post_create_tmpfile(struct inode *inode)
> +{
> +	return;
> +}
> +
>  static inline void ima_file_free(struct file *file)
>  {
>  	return;
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 4ffac4f5c647..357edd140c09 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -396,6 +396,33 @@ int ima_file_check(struct file *file, int mask)
>  }
>  EXPORT_SYMBOL_GPL(ima_file_check);
>  
> +/**
> + * ima_post_create_tmpfile - mark newly created tmpfile as new
> + * @file : newly created tmpfile
> + *
> + * No measuring, appraising or auditing of newly created tmpfiles is needed.
> + * Skip calling process_measurement(), but indicate which newly, created
> + * tmpfiles are in policy.
> + */
> +void ima_post_create_tmpfile(struct inode *inode)
> +{
> +	struct integrity_iint_cache *iint;
> +	int must_appraise;
> +
> +	must_appraise = ima_must_appraise(inode, MAY_ACCESS, FILE_CHECK);
> +	if (!must_appraise)
> +		return;
> +
> +	/* Nothing to do if we can't allocate memory */
> +	iint = integrity_inode_get(inode);
> +	if (!iint)
> +		return;
> +
> +	/* needed for writing the security xattrs */
> +	set_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
> +	iint->ima_file_status = INTEGRITY_PASS;
> +}
> +
>  /**
>   * ima_post_path_mknod - mark as a new inode
>   * @dentry: newly created dentry
> @@ -413,9 +440,13 @@ void ima_post_path_mknod(struct dentry *dentry)
>  	if (!must_appraise)
>  		return;
>  
> +	/* Nothing to do if we can't allocate memory */
>  	iint = integrity_inode_get(inode);
> -	if (iint)
> -		iint->flags |= IMA_NEW_FILE;
> +	if (!iint)
> +		return;
> +
> +	/* needed for re-opening empty files */
> +	iint->flags |= IMA_NEW_FILE;
>  }
>  
>  /**

