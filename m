Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2435C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D6B20844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oBZMarnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfBHQRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:17:02 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41893 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfBHQRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:17:02 -0500
Received: by mail-ed1-f65.google.com with SMTP id p15so3215553edy.8;
        Fri, 08 Feb 2019 08:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=icQ8rEb29SSkaNaT00Mt1OQFSmwVzg3WEAip8NpRYqg=;
        b=oBZMarnp/QK3DCKh+Irjm2c2ztfP9vuCWVU5k15ZggMdN+mMmm29uDLCkQX+N+A50+
         uHA38JchGfSsuDuBOlgdUp58MOYdQuPNCkwmkATV0WU711gC6tABXt7X/X/fXo1nRsSo
         Ql9piG78aKrXzuT6ye/Sr+X9Ij9YU7zEqKN1+owzu23Jh/fQCIzOCQ2f7X/DkRnm0Mve
         FB4AtZ8urMPoo01g4yhBa+EZT7CZOCzAAkjk6HmzkWjVkaeVxnIuGrv1JxmP7FED+34z
         2/L5uVLovAXUbqlTM8eZfKHLPujmNE1lfyyBKNgiC+SW674qfM9OciIkvBqJaWUGMbeg
         SiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=icQ8rEb29SSkaNaT00Mt1OQFSmwVzg3WEAip8NpRYqg=;
        b=P3XIsT+eRgPiIHBFzMb9vA/POL3L/LPYAa6ru30tnNsYEwnGepXfycRTtaxLzbUEKc
         plIJNF2x6+tTsduK0y6AtlWRKfxeFxjfN8KQulDAFBhnJNhsUW+DFiwjz5NJnmT1gVfd
         vD8A0l5/f7RsQNMVHOjaNjCYMWX7w9ZhPjVgflnsC02JwqxRmkfSspHUKv6nwUgWAFnQ
         iBvpLoX0wnCNPHRsTVddYwQIBnpxgHZsT4b9va5Ryuy7Rs3JaL8e2sdBGjYFLw5Nwuqj
         Df3TkBluR9bFsaKoNrw7pZwTXPhSLqjw2wkpdocLMDeqXuA2+wANgSUrcsWUvxJDMFkX
         7dgA==
X-Gm-Message-State: AHQUAuYqgt1TEi4EhquOtP1lK9bU8awlQn2gLS3czYUjQkKXb/bM/OC1
        r4e0SUZE1ilhmA8aesYxR38=
X-Google-Smtp-Source: AHgI3IZPHpxKfW6lfaVCZS3SsRaJoSAHkgFzkX24g4nwdZ5i9wHD4qmsrIeQxHcrDW1uF3TkB2hQ9A==
X-Received: by 2002:a50:b8e5:: with SMTP id l92mr17158623ede.294.1549642619282;
        Fri, 08 Feb 2019 08:16:59 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id s19sm563282eja.52.2019.02.08.08.16.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 08 Feb 2019 08:16:58 -0800 (PST)
Date:   Fri, 8 Feb 2019 09:16:56 -0700
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
Message-ID: <20190208161656.GA32343@archlinux-ryzen>
References: <20190206162452.7749-1-roberto.sassu@huawei.com>
 <20190206162452.7749-5-roberto.sassu@huawei.com>
 <20190208042411.GA4822@archlinux-ryzen>
 <cded9b3a-e321-ed05-4d41-51b8dab45c8d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cded9b3a-e321-ed05-4d41-51b8dab45c8d@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 09:41:14AM +0100, Roberto Sassu wrote:
> On 2/8/2019 5:24 AM, Nathan Chancellor wrote:
> > > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > > index afd022fc9d3d..816e686a73ac 100644
> > > --- a/include/linux/tpm.h
> > > +++ b/include/linux/tpm.h
> > > @@ -22,6 +22,10 @@
> > >   #ifndef __LINUX_TPM_H__
> > >   #define __LINUX_TPM_H__
> > > +#include <linux/hw_random.h>
> > > +#include <linux/acpi.h>
> 
> Hi Nathan
> 
> I think the error comes from the line above.
> security/integrity/ima/ima.h includes <linux/tpm.h>, which now includes
> <linux/acpi.h>, which includes <asm/acpi.h>, which includes
> <linux/efi.h> (for the arm64 architecture only). Both ima.h and efi.h
> define 'NONE'.
> 

Thank you for providing that analysis, I appreciate it!

> The solution would be to rename one of them. I'm not familiar with the
> EFI part. Renaming 'NONE' in IMA should be easy as it is not used
> anywhere.
> 

This seems reasonable, no?

Thanks,
Nathan

========================================================================

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d213e835c498..f203a86f1f23 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -173,7 +173,7 @@ static inline unsigned long ima_hash_key(u8 *digest)
 }
 
 #define __ima_hooks(hook)              \
-       hook(NONE)                      \
+       hook(NO_CHECK)                  \
        hook(FILE_CHECK)                \
        hook(MMAP_CHECK)                \
        hook(BPRM_CHECK)                \

> Thanks
> 
> Roberto
> 
> 
> > > +#include <linux/cdev.h>
> > > +#include <linux/fs.h>
> > >   #include <crypto/hash_info.h>
> > >   #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
> > > @@ -75,6 +79,93 @@ struct tpm_class_ops {
> > >   	void (*clk_enable)(struct tpm_chip *chip, bool value);
> > >   };
> > > +#define TPM_NUM_EVENT_LOG_FILES		3
> > > +
> > > +/* Indexes the duration array */
> > > +enum tpm_duration {
> > > +	TPM_SHORT = 0,
> > > +	TPM_MEDIUM = 1,
> > > +	TPM_LONG = 2,
> > > +	TPM_LONG_LONG = 3,
> > > +	TPM_UNDEFINED,
> > > +	TPM_NUM_DURATIONS = TPM_UNDEFINED,
> > > +};
> > > +
> > > +#define TPM_PPI_VERSION_LEN		3
> > > +
> > > +struct tpm_space {
> > > +	u32 context_tbl[3];
> > > +	u8 *context_buf;
> > > +	u32 session_tbl[3];
> > > +	u8 *session_buf;
> > > +};
> > > +
> > > +struct tpm_bios_log {
> > > +	void *bios_event_log;
> > > +	void *bios_event_log_end;
> > > +};
> > > +
> > > +struct tpm_chip_seqops {
> > > +	struct tpm_chip *chip;
> > > +	const struct seq_operations *seqops;
> > > +};
> > > +
> > > +struct tpm_chip {
> > > +	struct device dev;
> > > +	struct device devs;
> > > +	struct cdev cdev;
> > > +	struct cdev cdevs;
> > > +
> > > +	/* A driver callback under ops cannot be run unless ops_sem is held
> > > +	 * (sometimes implicitly, eg for the sysfs code). ops becomes null
> > > +	 * when the driver is unregistered, see tpm_try_get_ops.
> > > +	 */
> > > +	struct rw_semaphore ops_sem;
> > > +	const struct tpm_class_ops *ops;
> > > +
> > > +	struct tpm_bios_log log;
> > > +	struct tpm_chip_seqops bin_log_seqops;
> > > +	struct tpm_chip_seqops ascii_log_seqops;
> > > +
> > > +	unsigned int flags;
> > > +
> > > +	int dev_num;		/* /dev/tpm# */
> > > +	unsigned long is_open;	/* only one allowed */
> > > +
> > > +	char hwrng_name[64];
> > > +	struct hwrng hwrng;
> > > +
> > > +	struct mutex tpm_mutex;	/* tpm is processing */
> > > +
> > > +	unsigned long timeout_a; /* jiffies */
> > > +	unsigned long timeout_b; /* jiffies */
> > > +	unsigned long timeout_c; /* jiffies */
> > > +	unsigned long timeout_d; /* jiffies */
> > > +	bool timeout_adjusted;
> > > +	unsigned long duration[TPM_NUM_DURATIONS]; /* jiffies */
> > > +	bool duration_adjusted;
> > > +
> > > +	struct dentry *bios_dir[TPM_NUM_EVENT_LOG_FILES];
> > > +
> > > +	const struct attribute_group *groups[3];
> > > +	unsigned int groups_cnt;
> > > +
> > > +	u32 nr_allocated_banks;
> > > +	struct tpm_bank_info *allocated_banks;
> > > +#ifdef CONFIG_ACPI
> > > +	acpi_handle acpi_dev_handle;
> > > +	char ppi_version[TPM_PPI_VERSION_LEN + 1];
> > > +#endif /* CONFIG_ACPI */
> > > +
> > > +	struct tpm_space work_space;
> > > +	u32 last_cc;
> > > +	u32 nr_commands;
> > > +	u32 *cc_attrs_tbl;
> > > +
> > > +	/* active locality */
> > > +	int locality;
> > > +};
> > > +
> > >   #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
> > >   extern int tpm_is_tpm2(struct tpm_chip *chip);
> > > -- 
> > > 2.17.1
> > > 
> > 
> > Hi Robert,
> > 
> > This patch causes a build error with Clang (bisected on next-20190207):
> > 
> > security/integrity/ima/ima.h:191:2: error: redefinition of enumerator 'NONE'
> >          __ima_hooks(__ima_hook_enumify)
> >          ^
> > security/integrity/ima/ima.h:176:7: note: expanded from macro '__ima_hooks'
> >          hook(NONE)                      \
> >               ^
> > include/linux/efi.h:1709:2: note: previous definition is here
> >          NONE,
> >          ^
> > 1 error generated.
> > 
> > I am not sure how to reconcile this otherwise I would have sent a patch.
> > 
> > Thanks,
> > Nathan
> > 
> 
> -- 
> HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
> Managing Director: Bo PENG, Jian LI, Yanli SHI
