Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A377C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E805424F17
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uYiUryvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E805424F17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753311AbeGBSbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:31:16 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40259 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753124AbeGBSbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:31:14 -0400
Received: by mail-pl0-f66.google.com with SMTP id t6-v6so8334562plo.7;
        Mon, 02 Jul 2018 11:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Pq3FZasq0p3z0Fpwvax4TtTtGsrOxHy3SXjnYp/4zNs=;
        b=uYiUryvIG5gzZnaOJmg3ZStBsqNJ3unUkpwcEWPKCyXagX5VybuOyWHEbL4jqkBNHD
         FLz44y9zjhELG5v/V1wAmYllpZ5oWMMviYkqJjSOALgUGKdpRk5udKunxEKp6fqaeBcj
         /PbjorKcfYxKFJDjDE5TKySU3bbn/ikp13yb2QNgcEdh2h6u0gH+DFtUoqz+YD39DOIj
         pz+uZHPY8sR8Ck5Tu/GRiOzy+7tfCGhVy5mQg9eutDmQnrreTdH0DrdtpvoEfA21Vv9U
         o85MBrcFRoyryaENM+FXowbujsvD56H0/nQxTcR6KQs7LhM7Ic539TfFZ+fPJnAbh8Pu
         hQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Pq3FZasq0p3z0Fpwvax4TtTtGsrOxHy3SXjnYp/4zNs=;
        b=mS4v3X1Ggs8WHUT+v3rSlgl1xNTyzGjpQfXvgIUhgjPpVEPFtWJgHClJYhDu+gs6jz
         spRhxyK3rBV6eEEyxGemokhsnf6LfXrtpregdMfouOGGE3BBRQAKKGs39CAb7DqAGj7l
         Q4fm8HChJj/UpHnXaceDEBAh4cB4qclXBUumb0NXJT7Y/IRPKxgI1N5s5/SCcjEr88P6
         0sfswV2wzfFIlUTGnKlre2+Wrqebj+5a3AGxCf2vH4FkROvdtG4c71SVet2zp6XwNuPx
         2b9BSXr5vd62jrt2FUb3se8BgbuNeL/XPVVjG1cnZXo+W8kVrc7Yjqmu1entwnS6kkie
         KcKQ==
X-Gm-Message-State: APt69E3TWCaQV3eZ6/x5cFi/CLylxY51uNzTEAntM5nQXtB3JdtB3P2L
        TA44+9sItre89JrPtfSs87s=
X-Google-Smtp-Source: ADUXVKJ9q3CKhc15Lu6puGKwwWgtECyeJoeMcaua1ckm8aJxYaGNF5AK0F9M6IW1AHz3bvMG4Zd4Sw==
X-Received: by 2002:a17:902:206:: with SMTP id 6-v6mr26998709plc.294.1530556273093;
        Mon, 02 Jul 2018 11:31:13 -0700 (PDT)
Received: from JF-EN-C02V905BHTDF.tld ([216.23.175.59])
        by smtp.gmail.com with ESMTPSA id b123-v6sm16140535pfb.156.2018.07.02.11.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 11:31:11 -0700 (PDT)
Subject: Re: [PATCH v5 3/8] ima: based on policy require signed kexec kernel
 images
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1530542283-26145-4-git-send-email-zohar@linux.vnet.ibm.com>
From:   J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <840dae63-5a90-1327-437e-1ed92e165754@gmail.com>
Date:   Mon, 2 Jul 2018 11:31:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530542283-26145-4-git-send-email-zohar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/2/18 7:37 AM, Mimi Zohar wrote:
> The original kexec_load syscall can not verify file signatures, nor can
> the kexec image be measured.  Based on policy, deny the kexec_load
> syscall.


Curiosity question: I thought kexec_load() syscall was used to load a 
crashdump?  If this is true, how would this work if kexec_load() is 
being denied?  I don't think I'd want to be hindered in cases where I'm 
trying to diagnose a crash.

Thanks,
Jay


> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: David Howells <dhowells@redhat.com>
>
> ---
> Changelog v3:
> - use switch/case
>
>   include/linux/ima.h                 |  7 +++++++
>   security/integrity/ima/ima.h        |  1 +
>   security/integrity/ima/ima_main.c   | 27 +++++++++++++++++++++++++++
>   security/integrity/ima/ima_policy.c |  2 ++
>   security/security.c                 |  7 ++++++-
>   5 files changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 0e4647e0eb60..84806b54b50a 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -11,6 +11,7 @@
>   #define _LINUX_IMA_H
>   
>   #include <linux/fs.h>
> +#include <linux/security.h>
>   #include <linux/kexec.h>
>   struct linux_binprm;
>   
> @@ -19,6 +20,7 @@ extern int ima_bprm_check(struct linux_binprm *bprm);
>   extern int ima_file_check(struct file *file, int mask, int opened);
>   extern void ima_file_free(struct file *file);
>   extern int ima_file_mmap(struct file *file, unsigned long prot);
> +extern int ima_load_data(enum kernel_load_data_id id);
>   extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
>   extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
>   			      enum kernel_read_file_id id);
> @@ -49,6 +51,11 @@ static inline int ima_file_mmap(struct file *file, unsigned long prot)
>   	return 0;
>   }
>   
> +static inline int ima_load_data(enum kernel_load_data_id id)
> +{
> +	return 0;
> +}
> +
>   static inline int ima_read_file(struct file *file, enum kernel_read_file_id id)
>   {
>   	return 0;
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 2ab1affffa36..588e4813370c 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -232,6 +232,7 @@ int ima_policy_show(struct seq_file *m, void *v);
>   #define IMA_APPRAISE_MODULES	0x08
>   #define IMA_APPRAISE_FIRMWARE	0x10
>   #define IMA_APPRAISE_POLICY	0x20
> +#define IMA_APPRAISE_KEXEC	0x40
>   
>   #ifdef CONFIG_IMA_APPRAISE
>   int ima_appraise_measurement(enum ima_hooks func,
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index dca44cf7838e..71fecfef0939 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -496,6 +496,33 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>   				   MAY_READ, func, 0);
>   }
>   
> +/**
> + * ima_load_data - appraise decision based on policy
> + * @id: kernel load data caller identifier
> + *
> + * Callers of this LSM hook can not measure, appraise, or audit the
> + * data provided by userspace.  Enforce policy rules requring a file
> + * signature (eg. kexec'ed kernel image).
> + *
> + * For permission return 0, otherwise return -EACCES.
> + */
> +int ima_load_data(enum kernel_load_data_id id)
> +{
> +	if ((ima_appraise & IMA_APPRAISE_ENFORCE) != IMA_APPRAISE_ENFORCE)
> +		return 0;
> +
> +	switch (id) {
> +	case LOADING_KEXEC_IMAGE:
> +		if (ima_appraise & IMA_APPRAISE_KEXEC) {
> +			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
> +			return -EACCES;	/* INTEGRITY_UNKNOWN */
> +		}
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
>   static int __init init_ima(void)
>   {
>   	int error;
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 7f4a4de7e831..ebfb389b79df 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -448,6 +448,8 @@ static int ima_appraise_flag(enum ima_hooks func)
>   		return IMA_APPRAISE_FIRMWARE;
>   	else if (func == POLICY_CHECK)
>   		return IMA_APPRAISE_POLICY;
> +	else if (func == KEXEC_KERNEL_CHECK)
> +		return IMA_APPRAISE_KEXEC;
>   	return 0;
>   }
>   
> diff --git a/security/security.c b/security/security.c
> index 05fe5b1932d7..7b870df0a335 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1063,7 +1063,12 @@ EXPORT_SYMBOL_GPL(security_kernel_post_read_file);
>   
>   int security_kernel_load_data(enum kernel_load_data_id id)
>   {
> -	return call_int_hook(kernel_load_data, 0, id);
> +	int ret;
> +
> +	ret = call_int_hook(kernel_load_data, 0, id);
> +	if (ret)
> +		return ret;
> +	return ima_load_data(id);
>   }
>   
>   int security_task_fix_setuid(struct cred *new, const struct cred *old,

