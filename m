Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39121C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFE8243FC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFzf3pGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDFE8243FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753367AbeGBSpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:45:50 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41552 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753099AbeGBSpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:45:47 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so8358474ply.8;
        Mon, 02 Jul 2018 11:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=R5gITDyKjHIcVf9ODycq5GIar2+xX43sCJn6NRzBzuo=;
        b=dFzf3pGYv00NPCSKZpk/T2ReruSrNQq4EH16t1RUgn/KY224Na4JCUUGsmqTGiRvNT
         A7rhvgTfEzNjDr9an44UXZM6HQsG9J3gpTn1kN+WNNIIolp5/6KIr5K7aMb8UbQhLlBO
         tAk8bj1wQzuQcO0mHubMOs0dyHX6f+Eq5twdnWmMwHt7QfmcHVZsoiEVClxzkWPkml42
         X9Hnx5gJC1gWiegMg9V+9PbsmYjDoT/UUtAZXlXvnmRlI1tYmgUVUEwpi9694pr7dN5i
         JCWq1GN4fTDMASL97CGm4JMAJH/3mVDEzQJTN3NRcZppm30mDWATka000bLlZrkHkAXR
         FOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=R5gITDyKjHIcVf9ODycq5GIar2+xX43sCJn6NRzBzuo=;
        b=RxgbYiUWwE4MJzjDjwID1+UiVWN3l3dl/BTfJMa3kYMU9w38+x8uyH+CCnPjUF2lCX
         q4pRzz0BPv/fFzOG28hhyZD4t/wGT8D0Xu5t0Or7PNC06/t9dXF2Fy6e1I/OOZ9wXs2W
         uOHLsVsOMN7RAddelD0Q67/IhKRl56Tjg4O0gnjB0z2Qa1aRLUX1H/+Fu0kNZNfyzNjf
         v1PEq/rCLWJ80u96UxjPG5S0nor4BaMzv6Bg9pMhF9P4agM/LXd5U1LueZwnI89ShB4i
         lnKTIJf/zq67xR4n7OyFJkvZotGDxZy2zmiP82irkjAV/qIoaen1zG+nuVKj9D1cYzR6
         U8FQ==
X-Gm-Message-State: APt69E00Oul7AoET0GrBnPXkZ9e5mq1qQmWM2+HnrLWoUzRSbQjivdb0
        UC5BnwwjhQnt4SBzkvnc5bM=
X-Google-Smtp-Source: ADUXVKJtrIhsfgjS9wdOAsIzIE0QJsODbDppOWuoW2FCOzO0r6eRWSUQOvlFvWQThFKHIfxsNb56dg==
X-Received: by 2002:a17:902:b40f:: with SMTP id x15-v6mr27220990plr.270.1530557147365;
        Mon, 02 Jul 2018 11:45:47 -0700 (PDT)
Received: from JF-EN-C02V905BHTDF.tld ([216.23.175.59])
        by smtp.gmail.com with ESMTPSA id f10-v6sm21961197pgr.30.2018.07.02.11.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 11:45:46 -0700 (PDT)
Subject: Re: [PATCH v5 1/8] security: define new LSM hook named
 security_kernel_load_data
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1530542283-26145-2-git-send-email-zohar@linux.vnet.ibm.com>
From:   J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <64f467a5-e907-ee3e-495b-b2c731715037@gmail.com>
Date:   Mon, 2 Jul 2018 11:45:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530542283-26145-2-git-send-email-zohar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/2/18 7:37 AM, Mimi Zohar wrote:
> Differentiate between the kernel reading a file from the kernel loading
> data provided by userspace.  This patch defines a new LSM hook named
> security_kernel_load_data.

If this patch series is re-done, can we tweak the description here 
please?  From what I understood of the code in this patch, I'd tweak it as:

"Differentiate between the kernel reading a file specified by userspace 
and the kernel loading a block of data provided by userspace.  This 
patch defines a new LSM hook named security_kernel_load_data()."

 From the description, I got a tad confused if the the kernel reading a file was also provided by userspace (I know it may be 2nd-nature to people on this list, I'm still learning this kernel module).

Thanks,
Jay

> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
>
> ---
> Changelog v5:
> - Share the kernel_load_data_id and kernel_read_file_id values,
> simplifying Loadpin's and other LSMs calling one LSM hook from the
> other.
>
> Changelog v4:
> - Define new LSM hook named security_kernel_load_data.
>
> Changelog v3:
> - Rename security_kernel_read_file to security_kernel_read_data().
>
> Changelog v2:
> - Define a generic wrapper named security_kernel_read_blob() for
> security_kernel_read_file().
>
> Changelog v1:
> - Define and call security_kexec_load(), a wrapper for
> security_kernel_read_file().
>
>   include/linux/lsm_hooks.h |  6 ++++++
>   include/linux/security.h  | 27 +++++++++++++++++++++++++++
>   security/security.c       |  5 +++++
>   3 files changed, 38 insertions(+)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 8f1131c8dd54..a08bc2587b96 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -576,6 +576,10 @@
>    *	userspace to load a kernel module with the given name.
>    *	@kmod_name name of the module requested by the kernel
>    *	Return 0 if successful.
> + * @kernel_load_data:
> + *	Load data provided by userspace.
> + *	@id kernel load data identifier
> + *	Return 0 if permission is granted.
>    * @kernel_read_file:
>    *	Read a file specified by userspace.
>    *	@file contains the file structure pointing to the file being read
> @@ -1582,6 +1586,7 @@ union security_list_options {
>   	int (*kernel_act_as)(struct cred *new, u32 secid);
>   	int (*kernel_create_files_as)(struct cred *new, struct inode *inode);
>   	int (*kernel_module_request)(char *kmod_name);
> +	int (*kernel_load_data)(enum kernel_load_data_id id);
>   	int (*kernel_read_file)(struct file *file, enum kernel_read_file_id id);
>   	int (*kernel_post_read_file)(struct file *file, char *buf, loff_t size,
>   				     enum kernel_read_file_id id);
> @@ -1872,6 +1877,7 @@ struct security_hook_heads {
>   	struct hlist_head cred_getsecid;
>   	struct hlist_head kernel_act_as;
>   	struct hlist_head kernel_create_files_as;
> +	struct hlist_head kernel_load_data;
>   	struct hlist_head kernel_read_file;
>   	struct hlist_head kernel_post_read_file;
>   	struct hlist_head kernel_module_request;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 63030c85ee19..3410acfe139c 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -159,6 +159,27 @@ extern int mmap_min_addr_handler(struct ctl_table *table, int write,
>   typedef int (*initxattrs) (struct inode *inode,
>   			   const struct xattr *xattr_array, void *fs_data);
>   
> +
> +/* Keep the kernel_load_data_id enum in sync with kernel_read_file_id */
> +#define __data_id_enumify(ENUM, dummy) LOADING_ ## ENUM,
> +#define __data_id_stringify(dummy, str) #str,
> +
> +enum kernel_load_data_id {
> +	__kernel_read_file_id(__data_id_enumify)
> +};
> +
> +static const char * const kernel_load_data_str[] = {
> +	__kernel_read_file_id(__data_id_stringify)
> +};
> +
> +static inline const char *kernel_load_data_id_str(enum kernel_load_data_id id)
> +{
> +	if ((unsigned)id >= LOADING_MAX_ID)
> +		return kernel_load_data_str[LOADING_UNKNOWN];
> +
> +	return kernel_load_data_str[id];
> +}
> +
>   #ifdef CONFIG_SECURITY
>   
>   struct security_mnt_opts {
> @@ -320,6 +341,7 @@ void security_cred_getsecid(const struct cred *c, u32 *secid);
>   int security_kernel_act_as(struct cred *new, u32 secid);
>   int security_kernel_create_files_as(struct cred *new, struct inode *inode);
>   int security_kernel_module_request(char *kmod_name);
> +int security_kernel_load_data(enum kernel_load_data_id id);
>   int security_kernel_read_file(struct file *file, enum kernel_read_file_id id);
>   int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
>   				   enum kernel_read_file_id id);
> @@ -909,6 +931,11 @@ static inline int security_kernel_module_request(char *kmod_name)
>   	return 0;
>   }
>   
> +static inline int security_kernel_load_data(enum kernel_load_data_id id)
> +{
> +	return 0;
> +}
> +
>   static inline int security_kernel_read_file(struct file *file,
>   					    enum kernel_read_file_id id)
>   {
> diff --git a/security/security.c b/security/security.c
> index e7d76a8000a5..05fe5b1932d7 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1061,6 +1061,11 @@ int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
>   }
>   EXPORT_SYMBOL_GPL(security_kernel_post_read_file);
>   
> +int security_kernel_load_data(enum kernel_load_data_id id)
> +{
> +	return call_int_hook(kernel_load_data, 0, id);
> +}
> +
>   int security_task_fix_setuid(struct cred *new, const struct cred *old,
>   			     int flags)
>   {

