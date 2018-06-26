Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F907C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AAA26A5F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43AAA26A5F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935145AbeFZMPs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:15:48 -0400
Received: from upbd19pa07.eemsg.mail.mil ([214.24.27.82]:37479 "EHLO
        upbd19pa07.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934072AbeFZMPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:15:46 -0400
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa07.eemsg.mail.mil with ESMTP/TLS/AES256-SHA; 26 Jun 2018 12:15:40 +0000
X-IronPort-AV: E=Sophos;i="5.51,274,1526342400"; 
   d="scan'208";a="15027041"
IronPort-PHdr: =?us-ascii?q?9a23=3Aaa6rqhGRlEhKo/XzSfkBnZ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76ps64bnLW6fgltlLVR4KTs6sC17KL9fi4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCa9bL9oMBm6sRjau9ULj4dlNqs/0A?=
 =?us-ascii?q?bCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG?=
 =?us-ascii?q?81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUj?=
 =?us-ascii?q?m58axlVAHnhzsGNz4h8WHYlMpwjL5AoBm8oxBz2pPYbJ2JOPZ7eK7Sc8kaRW?=
 =?us-ascii?q?5cVchPUSJPDJ63Y48WA+YfIepUqo/wrEYMoxSjHwmhHP7hxCFGhnH23qM03e?=
 =?us-ascii?q?ouHg7E0wM8ENwDq2jUodfvOasOTey4wqvFwDPeZP1Wwzf9743Ifwg8r/GQQ7?=
 =?us-ascii?q?1wacrRxlcpFwjYk1uQrJbqPzeR1usTs2mQ8u1tVfmyhG48sAxxvjiuydssio?=
 =?us-ascii?q?nOnI4VzEvE+j9jzIY6It24Vld2bNi5G5VTryGXL5Z6T8wtTm1yuCs216cKtY?=
 =?us-ascii?q?C0cSQU0pgr2hjSYOGdfYeS+BLsTuORLC99hHJiZb2wmQ6/8VOlyu3gTsm010?=
 =?us-ascii?q?tKrjZdntnMqH8N0xvT59CbSvRn5Eeh2CuP1xvJ5uFFJ0A0m63bK4U/zbEsjJ?=
 =?us-ascii?q?YTrUTCETP2mEXxlqOWcFkr+vO05Oj9Z7Xmp5ucO5d1igH4LKsuhtSyDfk3Pw?=
 =?us-ascii?q?UBRWSW+fmw2Kf98UD2XrlGlOA6nrHcsJ/AJMQboqC5AxVS0oYm8xu/FCqp0M?=
 =?us-ascii?q?8DkHkbLFNKZBKHj4/zN1HIO/D3F+2zg1urkDd13/zGJKHuAo3RLnjfl7fsZb?=
 =?us-ascii?q?R95FRayAo1zdBS/J1UCrYGIPL8Xk/+qsbUAQM+Mwyx2+znEsly1psCWWKTBa?=
 =?us-ascii?q?+UKLvSvkWV5uIrOOSMfJUauCv5K/Q84v7uing5mUUDcqWzwZQXb3W4FOx8I0?=
 =?us-ascii?q?qFeXrsnssBEWASswUgVOzlkkeCUT9IZ3upR6Iz/Cs7CIO9DYfbQoCimqCO0z?=
 =?us-ascii?q?mhEp1RfGBGBUiGEW30eIWcR/cMdCWSL9d6kjMaSbehVpUh1RCytA760LdnLf?=
 =?us-ascii?q?Tb+jcetZ390Nh5/erTlQs99TZsFcSSz3mNT31onmMPXzI22KF/oUpgylaMyK?=
 =?us-ascii?q?R4gOJXFcZV5/xXVgc3LoDcz+NkBNDoQA7BfcmGSEygQtq4BTE9VNUxw8UBYx?=
 =?us-ascii?q?U1J9L3rBnF2WKKBKUT3+iJDZoy8orT2H/+I8s7wHHDgu1pt1A7RoNqMmq8i+?=
 =?us-ascii?q?Yr7wHOA6bRmlid0qOtcr4RmiXK8THHhUeUvUoQaAdqUL6NCX0Hb1HXtvzh71?=
 =?us-ascii?q?nDVKeqAL8qdAxbxpjGYrBHbtzvkEVuWOboONOYZXm43Wi3G0Wm3LSJObH2dn?=
 =?us-ascii?q?0d0SOVM00NlwQe7D7SLgQlLjuwqGLZSjp1HBTgZF26oro2k2+yUkJhl1LCVE?=
 =?us-ascii?q?Zmzbfgv0dP3fE=3D?=
X-IPAS-Result: =?us-ascii?q?A2AyAQAaLTJb/wHyM5BUCBkBAQEBAQEBAQEBAQEHAQEBA?=
 =?us-ascii?q?QGDHwsBAQECAYFvEiiDeYhkjDEGgRAilRSBJANThHcCgzQ2FgECAQEBAQEBA?=
 =?us-ascii?q?gFsKII1JAGCTwEFIwRSEAsYAgImAgJXBgEMBgIBAYJfQoFzDaxYgWkzhFuDb?=
 =?us-ascii?q?IEagQuIb4EHgQ8nDIJchDQhgyaCVQKHXIRrO4wvCY8NBo1KkzgGKzOBHysIA?=
 =?us-ascii?q?hgIIQ+DJJBtIzCNTII5AQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 26 Jun 2018 12:15:39 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5QCFafF009059;
        Tue, 26 Jun 2018 08:15:36 -0400
Subject: Re: [PATCH] selinux: move user accesses in selinuxfs out of locked
 regions
To:     Jann Horn <jannh@google.com>, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov
Cc:     security@kernel.org, linux-kernel@vger.kernel.org
References: <20180625163425.216965-1-jannh@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9d5d0cb7-5875-0814-835b-097db650b6a1@tycho.nsa.gov>
Date:   Tue, 26 Jun 2018 08:16:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625163425.216965-1-jannh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/2018 12:34 PM, Jann Horn wrote:
> If a user is accessing a file in selinuxfs with a pointer to a userspace
> buffer that is backed by e.g. a userfaultfd, the userspace access can
> stall indefinitely, which can block fsi->mutex if it is held.
> 
> For sel_read_policy(), remove the locking, since this method doesn't seem
> to access anything that requires locking.
> 
> For sel_read_bool(), move the user access below the locked region.
> 
> For sel_write_bool() and sel_commit_bools_write(), move the user access
> up above the locked region.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Jann Horn <jannh@google.com>

Only question I have is wrt the Fixes line, i.e. was this an issue until userfaultfd was introduced, and if not,
do we need it to be back-ported any further than the commit which introduced it.

Otherwise, you can add my
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>  security/selinux/selinuxfs.c | 77 ++++++++++++++++--------------------
>  1 file changed, 33 insertions(+), 44 deletions(-)
> 
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index f3d374d2ca04..065f8cea84e3 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -445,18 +445,13 @@ static ssize_t sel_read_policy(struct file *filp, char __user *buf,
>  	struct policy_load_memory *plm = filp->private_data;
>  	int ret;
>  
> -	mutex_lock(&fsi->mutex);
> -
>  	ret = avc_has_perm(&selinux_state,
>  			   current_sid(), SECINITSID_SECURITY,
>  			  SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL);
>  	if (ret)
> -		goto out;
> +		return ret;
>  
> -	ret = simple_read_from_buffer(buf, count, ppos, plm->data, plm->len);
> -out:
> -	mutex_unlock(&fsi->mutex);
> -	return ret;
> +	return simple_read_from_buffer(buf, count, ppos, plm->data, plm->len);
>  }
>  
>  static vm_fault_t sel_mmap_policy_fault(struct vm_fault *vmf)
> @@ -1188,25 +1183,29 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
>  	ret = -EINVAL;
>  	if (index >= fsi->bool_num || strcmp(name,
>  					     fsi->bool_pending_names[index]))
> -		goto out;
> +		goto out_unlock;
>  
>  	ret = -ENOMEM;
>  	page = (char *)get_zeroed_page(GFP_KERNEL);
>  	if (!page)
> -		goto out;
> +		goto out_unlock;
>  
>  	cur_enforcing = security_get_bool_value(fsi->state, index);
>  	if (cur_enforcing < 0) {
>  		ret = cur_enforcing;
> -		goto out;
> +		goto out_unlock;
>  	}
>  	length = scnprintf(page, PAGE_SIZE, "%d %d", cur_enforcing,
>  			  fsi->bool_pending_values[index]);
> -	ret = simple_read_from_buffer(buf, count, ppos, page, length);
> -out:
>  	mutex_unlock(&fsi->mutex);
> +	ret = simple_read_from_buffer(buf, count, ppos, page, length);
> +out_free:
>  	free_page((unsigned long)page);
>  	return ret;
> +
> +out_unlock:
> +	mutex_unlock(&fsi->mutex);
> +	goto out_free;
>  }
>  
>  static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
> @@ -1219,6 +1218,17 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
>  	unsigned index = file_inode(filep)->i_ino & SEL_INO_MASK;
>  	const char *name = filep->f_path.dentry->d_name.name;
>  
> +	if (count >= PAGE_SIZE)
> +		return -ENOMEM;
> +
> +	/* No partial writes. */
> +	if (*ppos != 0)
> +		return -EINVAL;
> +
> +	page = memdup_user_nul(buf, count);
> +	if (IS_ERR(page))
> +		return PTR_ERR(page);
> +
>  	mutex_lock(&fsi->mutex);
>  
>  	length = avc_has_perm(&selinux_state,
> @@ -1233,22 +1243,6 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
>  					     fsi->bool_pending_names[index]))
>  		goto out;
>  
> -	length = -ENOMEM;
> -	if (count >= PAGE_SIZE)
> -		goto out;
> -
> -	/* No partial writes. */
> -	length = -EINVAL;
> -	if (*ppos != 0)
> -		goto out;
> -
> -	page = memdup_user_nul(buf, count);
> -	if (IS_ERR(page)) {
> -		length = PTR_ERR(page);
> -		page = NULL;
> -		goto out;
> -	}
> -
>  	length = -EINVAL;
>  	if (sscanf(page, "%d", &new_value) != 1)
>  		goto out;
> @@ -1280,6 +1274,17 @@ static ssize_t sel_commit_bools_write(struct file *filep,
>  	ssize_t length;
>  	int new_value;
>  
> +	if (count >= PAGE_SIZE)
> +		return -ENOMEM;
> +
> +	/* No partial writes. */
> +	if (*ppos != 0)
> +		return -EINVAL;
> +
> +	page = memdup_user_nul(buf, count);
> +	if (IS_ERR(page))
> +		return PTR_ERR(page);
> +
>  	mutex_lock(&fsi->mutex);
>  
>  	length = avc_has_perm(&selinux_state,
> @@ -1289,22 +1294,6 @@ static ssize_t sel_commit_bools_write(struct file *filep,
>  	if (length)
>  		goto out;
>  
> -	length = -ENOMEM;
> -	if (count >= PAGE_SIZE)
> -		goto out;
> -
> -	/* No partial writes. */
> -	length = -EINVAL;
> -	if (*ppos != 0)
> -		goto out;
> -
> -	page = memdup_user_nul(buf, count);
> -	if (IS_ERR(page)) {
> -		length = PTR_ERR(page);
> -		page = NULL;
> -		goto out;
> -	}
> -
>  	length = -EINVAL;
>  	if (sscanf(page, "%d", &new_value) != 1)
>  		goto out;
> 

