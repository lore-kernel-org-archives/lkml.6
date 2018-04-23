Return-Path: <andrew.donnellan@au1.ibm.com>
X-Google-Smtp-Source: AIpwx4+FofoWkF7ZJeZCgCdV6qGWuObGFZ71W9jP8CwUBQcUR9TamKhs7h4jk/WM9HOOENuFoO+A
ARC-Seal: i=1; a=rsa-sha256; t=1524467780; cv=none;
        d=google.com; s=arc-20160816;
        b=uvyr1kN/UUzqj9ehT/9c8p6J0i4SdcZ17LZKDaE1WvPQKlhDXMhQdnI/MWRZqOvtX5
         XOf/CjNYKCklYyN20DSXu/m/SnOgp4Hk6Z5SW4ij389X+xSffwevBKnhiF34xxtUy4eN
         q6Wqf25A87Uyy5xInGXCCbiTX1SnIckU6vRAZTpwb8KuF7PR15b6gb5otqjee533bXxQ
         BRTMP0VJAlrhhGf0vMEbkw0CcbyvK8DwxF8E6lARr/7PWqVRT8vUHGw2BUuCymSZiTQR
         ip9ifzB1jL0uzygLB3oyZjEAl8V2AYYp0JdXeA/9W8lf5bqlohBmC3V8XodgH69mdUBy
         lFkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=BdxF4/ERf0p9H1yEl2SHzAc0hUhr0CCUmOm7oBfsKLI=;
        b=UpZqeCx5Na/uczOiffdmR7uk7kKNyUzV0DdnuOfmZZrn8BoupGwqhCIl/EbZdrhqUv
         uhnTv7He0hW4HZk/1m766auTb/7HhpooGVB9iRIGSk7h27U0C+QMRRY0Tpu9cTX3rOO0
         ZCBf5g87kgg6oCxswE3ljoefKV00RSX+lOR947adN2xGMOi8FrZjmmbApLvnviOnEv8S
         2w5B8omdrCMQNy37/C8wA9RqeRre113ty/FPqW+ap522PLRaSMOExpXCiNLjjovGQ1FR
         SOM92QJalIWkEsCpXu1ye7GXJRc9uT3omteBzcUmm8GItIlxHX4gqfwdxnbunmWBqop5
         7JKw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v2 5/7] ocxl: Expose the thread_id needed for wait on p9
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
        vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180418010810.30937-1-alastair@au1.ibm.com>
 <20180418010810.30937-6-alastair@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 23 Apr 2018 17:16:09 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418010810.30937-6-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18042307-0012-0000-0000-000005CDB5AD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042307-0013-0000-0000-0000194A1CDD
Message-Id: <fd17c03b-f131-67e0-a343-5456e75d6b59@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230080
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957549588354093?=
X-GMAIL-MSGID: =?utf-8?q?1598520327129801312?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 18/04/18 11:08, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> In order to successfully issue as_notify, an AFU needs to know the TID
> to notify, which in turn means that this information should be
> available in userspace so it can be communicated to the AFU.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

nitpicks below

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   drivers/misc/ocxl/context.c       |  5 +++-
>   drivers/misc/ocxl/file.c          | 53 +++++++++++++++++++++++++++++++++++++++
>   drivers/misc/ocxl/link.c          | 36 ++++++++++++++++++++++++++
>   drivers/misc/ocxl/ocxl_internal.h |  1 +
>   include/misc/ocxl.h               |  9 +++++++
>   include/uapi/misc/ocxl.h          | 10 ++++++++
>   6 files changed, 113 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
> index 909e8807824a..95f74623113e 100644
> --- a/drivers/misc/ocxl/context.c
> +++ b/drivers/misc/ocxl/context.c
> @@ -34,6 +34,8 @@ int ocxl_context_init(struct ocxl_context *ctx, struct ocxl_afu *afu,
>   	mutex_init(&ctx->xsl_error_lock);
>   	mutex_init(&ctx->irq_lock);
>   	idr_init(&ctx->irq_idr);
> +	ctx->tidr = 0;
> +
>   	/*
>   	 * Keep a reference on the AFU to make sure it's valid for the
>   	 * duration of the life of the context
> @@ -65,6 +67,7 @@ int ocxl_context_attach(struct ocxl_context *ctx, u64 amr)
>   {
>   	int rc;
>   
> +	// Locks both status & tidr
>   	mutex_lock(&ctx->status_mutex);
>   	if (ctx->status != OPENED) {
>   		rc = -EIO;
> @@ -72,7 +75,7 @@ int ocxl_context_attach(struct ocxl_context *ctx, u64 amr)
>   	}
>   
>   	rc = ocxl_link_add_pe(ctx->afu->fn->link, ctx->pasid,
> -			current->mm->context.id, 0, amr, current->mm,
> +			current->mm->context.id, ctx->tidr, amr, current->mm,
>   			xsl_fault_error, ctx);
>   	if (rc)
>   		goto out;
> diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
> index 038509e5d031..eb409a469f21 100644
> --- a/drivers/misc/ocxl/file.c
> +++ b/drivers/misc/ocxl/file.c
> @@ -5,6 +5,8 @@
>   #include <linux/sched/signal.h>
>   #include <linux/uaccess.h>
>   #include <uapi/misc/ocxl.h>
> +#include <asm/reg.h>
> +#include <asm/switch_to.h>
>   #include "ocxl_internal.h"
>   
>   
> @@ -123,11 +125,55 @@ static long afu_ioctl_get_metadata(struct ocxl_context *ctx,
>   	return 0;
>   }
>   
> +#ifdef CONFIG_PPC64
> +static long afu_ioctl_enable_p9_wait(struct ocxl_context *ctx,
> +		struct ocxl_ioctl_p9_wait __user *uarg)
> +{
> +	struct ocxl_ioctl_p9_wait arg;
> +
> +	memset(&arg, 0, sizeof(arg));
> +
> +	if (cpu_has_feature(CPU_FTR_P9_TIDR)) {
> +		enum ocxl_context_status status;
> +
> +		// Locks both status & tidr
> +		mutex_lock(&ctx->status_mutex);
> +		if (!ctx->tidr) {
> +			if (set_thread_tidr(current))
> +				return -ENOENT;
> +
> +			ctx->tidr = current->thread.tidr;
> +		}
> +
> +		status = ctx->status;
> +		mutex_unlock(&ctx->status_mutex);
> +
> +		if (status == ATTACHED) {
> +			int rc;
> +			struct link *link = ctx->afu->fn->link;

Declarations at the top

> +
> +			rc = ocxl_link_update_pe(link, ctx->pasid, ctx->tidr);
> +			if (rc)
> +				return rc;
> +		}
> +
> +		arg.thread_id = ctx->tidr;
> +	} else
> +		return -ENOENT;
> +
> +	if (copy_to_user(uarg, &arg, sizeof(arg)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +#endif
> +
>   #define CMD_STR(x) (x == OCXL_IOCTL_ATTACH ? "ATTACH" :			\
>   			x == OCXL_IOCTL_IRQ_ALLOC ? "IRQ_ALLOC" :	\
>   			x == OCXL_IOCTL_IRQ_FREE ? "IRQ_FREE" :		\
>   			x == OCXL_IOCTL_IRQ_SET_FD ? "IRQ_SET_FD" :	\
>   			x == OCXL_IOCTL_GET_METADATA ? "GET_METADATA" :	\
> +			x == OCXL_IOCTL_ENABLE_P9_WAIT ? "ENABLE_P9_WAIT" :	\
>   			"UNKNOWN")
>   
>   static long afu_ioctl(struct file *file, unsigned int cmd,
> @@ -186,6 +232,13 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
>   				(struct ocxl_ioctl_metadata __user *) args);
>   		break;
>   
> +#ifdef CONFIG_PPC64
> +	case OCXL_IOCTL_ENABLE_P9_WAIT:
> +		rc = afu_ioctl_enable_p9_wait(ctx,
> +				(struct ocxl_ioctl_p9_wait __user *) args);
> +		break;
> +#endif
> +
>   	default:
>   		rc = -EINVAL;
>   	}
> diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
> index 656e8610eec2..88876ae8f330 100644
> --- a/drivers/misc/ocxl/link.c
> +++ b/drivers/misc/ocxl/link.c
> @@ -544,6 +544,42 @@ int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
>   }
>   EXPORT_SYMBOL_GPL(ocxl_link_add_pe);
>   
> +int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid)
> +{
> +	struct link *link = (struct link *) link_handle;
> +	struct spa *spa = link->spa;
> +	struct ocxl_process_element *pe;
> +	int pe_handle, rc;
> +
> +	if (pasid > SPA_PASID_MAX)
> +		return -EINVAL;
> +
> +	pe_handle = pasid & SPA_PE_MASK;
> +	pe = spa->spa_mem + pe_handle;
> +
> +	mutex_lock(&spa->spa_lock);
> +
> +	pe->tid = tid;
> +
> +	/*
> +	 * The barrier makes sure the PE is updated
> +	 * before we clear the NPU context cache below, so that the
> +	 * old PE cannot be reloaded erroneously.
> +	 */
> +	mb();
> +
> +	/*
> +	 * hook to platform code
> +	 * On powerpc, the entry needs to be cleared from the context
> +	 * cache of the NPU.
> +	 */
> +	rc = pnv_ocxl_spa_remove_pe_from_cache(link->platform_data, pe_handle);
> +	WARN_ON(rc);
> +
> +	mutex_unlock(&spa->spa_lock);
> +	return rc;
> +}
> +
>   int ocxl_link_remove_pe(void *link_handle, int pasid)
>   {
>   	struct link *link = (struct link *) link_handle;
> diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
> index 5d421824afd9..6c6d4e61888e 100644
> --- a/drivers/misc/ocxl/ocxl_internal.h
> +++ b/drivers/misc/ocxl/ocxl_internal.h
> @@ -77,6 +77,7 @@ struct ocxl_context {
>   	struct ocxl_xsl_error xsl_error;
>   	struct mutex irq_lock;
>   	struct idr irq_idr;
> +	__u16 tidr; // Thread ID used for P9 wait implementation

What's the difference between u16 and __u16...

>   };
>   
>   struct ocxl_process_element {
> diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
> index 51ccf76db293..9ff6ddc28e22 100644
> --- a/include/misc/ocxl.h
> +++ b/include/misc/ocxl.h
> @@ -188,6 +188,15 @@ extern int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
>   		void (*xsl_err_cb)(void *data, u64 addr, u64 dsisr),
>   		void *xsl_err_data);
>   
> +/**
> + * Update values within a Process Element
> + *
> + * link_handle: the link handle associated with the process element
> + * pasid: the PASID for the AFU context
> + * tid: the new thread id for the process element
> + */
> +extern int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid);
> +
>   /*
>    * Remove a Process Element from the Shared Process Area for a link
>    */
> diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
> index 0af83d80fb3e..8d2748e69c84 100644
> --- a/include/uapi/misc/ocxl.h
> +++ b/include/uapi/misc/ocxl.h
> @@ -48,6 +48,15 @@ struct ocxl_ioctl_metadata {
>   	__u64 reserved[13]; // Total of 16*u64
>   };
>   
> +struct ocxl_ioctl_p9_wait {
> +	__u16 thread_id; // The thread ID required to wake this thread
> +	__u16 reserved1;
> +	__u32 reserved2;
> +	__u64 reserved3[3];
> +};
> +
> +};
> +
>   struct ocxl_ioctl_irq_fd {
>   	__u64 irq_offset;
>   	__s32 eventfd;
> @@ -62,5 +71,6 @@ struct ocxl_ioctl_irq_fd {
>   #define OCXL_IOCTL_IRQ_FREE	_IOW(OCXL_MAGIC, 0x12, __u64)
>   #define OCXL_IOCTL_IRQ_SET_FD	_IOW(OCXL_MAGIC, 0x13, struct ocxl_ioctl_irq_fd)
>   #define OCXL_IOCTL_GET_METADATA _IOR(OCXL_MAGIC, 0x14, struct ocxl_ioctl_metadata)
> +#define OCXL_IOCTL_ENABLE_P9_WAIT	_IOR(OCXL_MAGIC, 0x15, struct ocxl_ioctl_p9_wait)
>   
>   #endif /* _UAPI_MISC_OCXL_H */
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
