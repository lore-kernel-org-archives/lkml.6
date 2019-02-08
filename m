Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11C3C282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B476E2147C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+DGLPvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfBHEYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 23:24:18 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36369 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfBHEYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 23:24:17 -0500
Received: by mail-ed1-f67.google.com with SMTP id k20so227951edx.3;
        Thu, 07 Feb 2019 20:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=54KNOSb1H1kc+I/wOX5cMu3wwjrgdbc2LbHcMcOO8W0=;
        b=l+DGLPvDzIqEYYQQwFxXT65eCWNNfQKBPB36E6+QPi27utSWgdpXCezKoy3SxZgulq
         JLJJ4FtZXDllRzUHzZzl8FeLE1i24Sz0SXlRhIXRi0+W87/h1hA6YXjqBBdHVSl6Rq9a
         oKWa4HMXQwRUZcLa9soaeoqzsRBBTapwE7jyOaxfTs+k2tXNw93gOiypQt4iLhZ4zhsG
         ZEKgpYvaBrB4FAkFbjBWGTuB1b5InMAkd/A87USF5+k9E0d0gt7JE/uLLb4Bd50fVm/+
         8geBepQJv2D9uQgOW2ffNiJ5jq9PR2ijb9rCb2XV3/1sMjzkIA1MJsRG4QNpOHMPiWZn
         Sufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=54KNOSb1H1kc+I/wOX5cMu3wwjrgdbc2LbHcMcOO8W0=;
        b=W7DZPgOpVxAo+r97z4wKVkTWSM3E9MZ6qjh31Vi1v6xmUijP9OmYeUa3tFS8EJUgOk
         uc1M+HNMeuoWrWJZtvtbtt7qyoVI+MGPAkcPK7eMKW9MACsq7NdSHHdYKnOAoiwl/VXH
         A6NPWu9VdNg9VKlXfFw13K3NX7O6GuX41l2ggicxg1iMyGTHylTsKsxxc8zecpApE/59
         NFuLkuQg2OW9eZEwe+jJH53Eud58Yd5k7v6h9RAqfAYXfrb8j0sX63xOzHr/of+mrOt/
         QGhc0jT4ZuwAdrx5GxAqhnozo8T/WN0QsM9ZCzDR9Gqcvc52WKYa1dU5+JSRKe1hYp3P
         Mbrw==
X-Gm-Message-State: AHQUAuZd3hM1MKEwHpNXm43EdBuxwsgVzg4kzT93XO8Ds7bHLijFzofq
        nrUqt4WCj52zNwiA7xlnJGY=
X-Google-Smtp-Source: AHgI3IZ9cFvEWeTUuWfeD3MkFFMiSCdgcjt+tzeFxbhN+VOrRGZ0mZNyKgHrlzM4nwEa6ntkdZ20LQ==
X-Received: by 2002:a17:906:b7c3:: with SMTP id fy3mr14420348ejb.5.1549599854814;
        Thu, 07 Feb 2019 20:24:14 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id w27sm234833eje.76.2019.02.07.20.24.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 07 Feb 2019 20:24:13 -0800 (PST)
Date:   Thu, 7 Feb 2019 21:24:11 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        david.safford@ge.com, monty.wiseman@ge.com,
        matthewgarrett@google.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com,
        ndesaulniers@google.com
Subject: Re: [PATCH v10, RESEND 4/6] tpm: move tpm_chip definition to
 include/linux/tpm.h
Message-ID: <20190208042411.GA4822@archlinux-ryzen>
References: <20190206162452.7749-1-roberto.sassu@huawei.com>
 <20190206162452.7749-5-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206162452.7749-5-roberto.sassu@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 05:24:50PM +0100, Roberto Sassu wrote:
> The tpm_chip structure contains the list of PCR banks currently allocated
> in the TPM. When support for crypto agility will be added to the TPM
> driver, users of the driver have to provide a digest for each allocated
> bank to tpm_pcr_extend(). With this patch, they can obtain the PCR bank
> algorithms directly from chip->allocated_banks.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  drivers/char/tpm/tpm.h | 101 ++---------------------------------------
>  include/linux/tpm.h    |  91 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 95 insertions(+), 97 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 4efa304e9ece..4f85ce909122 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -25,30 +25,22 @@
>  
>  #include <linux/module.h>
>  #include <linux/delay.h>
> -#include <linux/fs.h>
> -#include <linux/hw_random.h>
>  #include <linux/mutex.h>
>  #include <linux/sched.h>
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/tpm.h>
> -#include <linux/acpi.h>
> -#include <linux/cdev.h>
>  #include <linux/highmem.h>
>  #include <linux/tpm_eventlog.h>
> -#include <crypto/hash_info.h>
>  
>  #ifdef CONFIG_X86
>  #include <asm/intel-family.h>
>  #endif
>  
> -enum tpm_const {
> -	TPM_MINOR = 224,	/* officially assigned */
> -	TPM_BUFSIZE = 4096,
> -	TPM_NUM_DEVICES = 65536,
> -	TPM_RETRY = 50,		/* 5 seconds */
> -	TPM_NUM_EVENT_LOG_FILES = 3,
> -};
> +#define TPM_MINOR		224	/* officially assigned */
> +#define TPM_BUFSIZE		4096
> +#define TPM_NUM_DEVICES		65536
> +#define TPM_RETRY		50
>  
>  enum tpm_timeout {
>  	TPM_TIMEOUT = 5,	/* msecs */
> @@ -65,16 +57,6 @@ enum tpm_addr {
>  	TPM_ADDR = 0x4E,
>  };
>  
> -/* Indexes the duration array */
> -enum tpm_duration {
> -	TPM_SHORT = 0,
> -	TPM_MEDIUM = 1,
> -	TPM_LONG = 2,
> -	TPM_LONG_LONG = 3,
> -	TPM_UNDEFINED,
> -	TPM_NUM_DURATIONS = TPM_UNDEFINED,
> -};
> -
>  #define TPM_WARN_RETRY          0x800
>  #define TPM_WARN_DOING_SELFTEST 0x802
>  #define TPM_ERR_DEACTIVATED     0x6
> @@ -179,15 +161,6 @@ enum tpm2_cc_attrs {
>  #define TPM_VID_WINBOND  0x1050
>  #define TPM_VID_STM      0x104A
>  
> -#define TPM_PPI_VERSION_LEN		3
> -
> -struct tpm_space {
> -	u32 context_tbl[3];
> -	u8 *context_buf;
> -	u32 session_tbl[3];
> -	u8 *session_buf;
> -};
> -
>  enum tpm_chip_flags {
>  	TPM_CHIP_FLAG_TPM2		= BIT(1),
>  	TPM_CHIP_FLAG_IRQ		= BIT(2),
> @@ -196,72 +169,6 @@ enum tpm_chip_flags {
>  	TPM_CHIP_FLAG_ALWAYS_POWERED	= BIT(5),
>  };
>  
> -struct tpm_bios_log {
> -	void *bios_event_log;
> -	void *bios_event_log_end;
> -};
> -
> -struct tpm_chip_seqops {
> -	struct tpm_chip *chip;
> -	const struct seq_operations *seqops;
> -};
> -
> -struct tpm_chip {
> -	struct device dev;
> -	struct device devs;
> -	struct cdev cdev;
> -	struct cdev cdevs;
> -
> -	/* A driver callback under ops cannot be run unless ops_sem is held
> -	 * (sometimes implicitly, eg for the sysfs code). ops becomes null
> -	 * when the driver is unregistered, see tpm_try_get_ops.
> -	 */
> -	struct rw_semaphore ops_sem;
> -	const struct tpm_class_ops *ops;
> -
> -	struct tpm_bios_log log;
> -	struct tpm_chip_seqops bin_log_seqops;
> -	struct tpm_chip_seqops ascii_log_seqops;
> -
> -	unsigned int flags;
> -
> -	int dev_num;		/* /dev/tpm# */
> -	unsigned long is_open;	/* only one allowed */
> -
> -	char hwrng_name[64];
> -	struct hwrng hwrng;
> -
> -	struct mutex tpm_mutex;	/* tpm is processing */
> -
> -	unsigned long timeout_a; /* jiffies */
> -	unsigned long timeout_b; /* jiffies */
> -	unsigned long timeout_c; /* jiffies */
> -	unsigned long timeout_d; /* jiffies */
> -	bool timeout_adjusted;
> -	unsigned long duration[TPM_NUM_DURATIONS]; /* jiffies */
> -	bool duration_adjusted;
> -
> -	struct dentry *bios_dir[TPM_NUM_EVENT_LOG_FILES];
> -
> -	const struct attribute_group *groups[3];
> -	unsigned int groups_cnt;
> -
> -	u32 nr_allocated_banks;
> -	struct tpm_bank_info *allocated_banks;
> -#ifdef CONFIG_ACPI
> -	acpi_handle acpi_dev_handle;
> -	char ppi_version[TPM_PPI_VERSION_LEN + 1];
> -#endif /* CONFIG_ACPI */
> -
> -	struct tpm_space work_space;
> -	u32 last_cc;
> -	u32 nr_commands;
> -	u32 *cc_attrs_tbl;
> -
> -	/* active locality */
> -	int locality;
> -};
> -
>  #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
>  
>  struct tpm_header {
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index afd022fc9d3d..816e686a73ac 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -22,6 +22,10 @@
>  #ifndef __LINUX_TPM_H__
>  #define __LINUX_TPM_H__
>  
> +#include <linux/hw_random.h>
> +#include <linux/acpi.h>
> +#include <linux/cdev.h>
> +#include <linux/fs.h>
>  #include <crypto/hash_info.h>
>  
>  #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
> @@ -75,6 +79,93 @@ struct tpm_class_ops {
>  	void (*clk_enable)(struct tpm_chip *chip, bool value);
>  };
>  
> +#define TPM_NUM_EVENT_LOG_FILES		3
> +
> +/* Indexes the duration array */
> +enum tpm_duration {
> +	TPM_SHORT = 0,
> +	TPM_MEDIUM = 1,
> +	TPM_LONG = 2,
> +	TPM_LONG_LONG = 3,
> +	TPM_UNDEFINED,
> +	TPM_NUM_DURATIONS = TPM_UNDEFINED,
> +};
> +
> +#define TPM_PPI_VERSION_LEN		3
> +
> +struct tpm_space {
> +	u32 context_tbl[3];
> +	u8 *context_buf;
> +	u32 session_tbl[3];
> +	u8 *session_buf;
> +};
> +
> +struct tpm_bios_log {
> +	void *bios_event_log;
> +	void *bios_event_log_end;
> +};
> +
> +struct tpm_chip_seqops {
> +	struct tpm_chip *chip;
> +	const struct seq_operations *seqops;
> +};
> +
> +struct tpm_chip {
> +	struct device dev;
> +	struct device devs;
> +	struct cdev cdev;
> +	struct cdev cdevs;
> +
> +	/* A driver callback under ops cannot be run unless ops_sem is held
> +	 * (sometimes implicitly, eg for the sysfs code). ops becomes null
> +	 * when the driver is unregistered, see tpm_try_get_ops.
> +	 */
> +	struct rw_semaphore ops_sem;
> +	const struct tpm_class_ops *ops;
> +
> +	struct tpm_bios_log log;
> +	struct tpm_chip_seqops bin_log_seqops;
> +	struct tpm_chip_seqops ascii_log_seqops;
> +
> +	unsigned int flags;
> +
> +	int dev_num;		/* /dev/tpm# */
> +	unsigned long is_open;	/* only one allowed */
> +
> +	char hwrng_name[64];
> +	struct hwrng hwrng;
> +
> +	struct mutex tpm_mutex;	/* tpm is processing */
> +
> +	unsigned long timeout_a; /* jiffies */
> +	unsigned long timeout_b; /* jiffies */
> +	unsigned long timeout_c; /* jiffies */
> +	unsigned long timeout_d; /* jiffies */
> +	bool timeout_adjusted;
> +	unsigned long duration[TPM_NUM_DURATIONS]; /* jiffies */
> +	bool duration_adjusted;
> +
> +	struct dentry *bios_dir[TPM_NUM_EVENT_LOG_FILES];
> +
> +	const struct attribute_group *groups[3];
> +	unsigned int groups_cnt;
> +
> +	u32 nr_allocated_banks;
> +	struct tpm_bank_info *allocated_banks;
> +#ifdef CONFIG_ACPI
> +	acpi_handle acpi_dev_handle;
> +	char ppi_version[TPM_PPI_VERSION_LEN + 1];
> +#endif /* CONFIG_ACPI */
> +
> +	struct tpm_space work_space;
> +	u32 last_cc;
> +	u32 nr_commands;
> +	u32 *cc_attrs_tbl;
> +
> +	/* active locality */
> +	int locality;
> +};
> +
>  #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
>  
>  extern int tpm_is_tpm2(struct tpm_chip *chip);
> -- 
> 2.17.1
> 

Hi Robert,

This patch causes a build error with Clang (bisected on next-20190207):

security/integrity/ima/ima.h:191:2: error: redefinition of enumerator 'NONE'
        __ima_hooks(__ima_hook_enumify)
        ^
security/integrity/ima/ima.h:176:7: note: expanded from macro '__ima_hooks'
        hook(NONE)                      \
             ^
include/linux/efi.h:1709:2: note: previous definition is here
        NONE,
        ^
1 error generated.

I am not sure how to reconcile this otherwise I would have sent a patch.

Thanks,
Nathan
