Return-Path: <fbarrat@linux.vnet.ibm.com>
X-Google-Smtp-Source: AH8x224ySVjgHk+Dn05GMYsDtBuS9r9JC1LJp0E8OXZMaHQua655VDn528lbgaAKkjgm8/fOLxbs
ARC-Seal: i=1; a=rsa-sha256; t=1519301774; cv=none;
        d=google.com; s=arc-20160816;
        b=uwuHV5rA+9sBakNEBbQIvnVkeknjV8ZLxcHadLIlKwaADoTqeT5dJEleYY2pKgx4XO
         XOEZPuRJfggDprfhPKDnysKJDaH5W/NDRWpBoWq+FAdsl66TcKdOxlYdolGM1Q45Brh0
         7v0OrubjQjRX5HEUqBxxP3HKa6q5G40JaSRyCDElXWceudgH4x/jAa0LsjzKSLoqyz2V
         A3qinb26gJAIa6n2E49OHkIziSszXvW7UyJEEglvTvrN02vYxU9Bxl3FvXHCjuRE75re
         VutGFoJgKRiL+EARsfRg7uGDBtZS+mF+Hhz1nkQDa/KXX+ziMIFfprRMO0ILLVk1rD56
         Yhjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=vMmxQVJnpNWTra+onpuWC7HfBdnC1pBdjqQMdj7JogM=;
        b=DemNoo6FtfDESafEJoBjkBJy4IOL1OJ1gDJaINnrOuNWFZtgIWwKJsnMqrUgLHHX7C
         ybrfOPcQmlr67ttpnjh8PmKyI04Vs9O0vpunchoI1a9soC1R5SNorznpgiZvX+RUl5Y3
         t1zhlTkNkVv3s/xByBB7DoLetdTHSA5UMcae97xtt1BqqxJyZ4Msa28qOFbwfkhFbCon
         TXz04CBatiNcT+CAS5LybpjVvUZQu6S7WjrmLR0Xp8hR/8AaMHNUndxptkbMLkF1gndF
         RipJ8o4/3udM3wSmU5bulEvlmy00wJYUklGmDqV5inlni+ue4m5AlX6sZH93WQhEkWgs
         zxjg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of fbarrat@linux.vnet.ibm.com) smtp.mailfrom=fbarrat@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of fbarrat@linux.vnet.ibm.com) smtp.mailfrom=fbarrat@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v3 1/2] ocxl: Add get_metadata IOCTL to share OCXL
 information to userspace
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, frederic.barrat@fr.ibm.com, gregkh@linuxfoundation.org,
        andrew.donnellan@au1.ibm.com,
        "Alastair D'Silva" <alastair@d-silva.org>
References: <20180222030334.14060-1-alastair@au1.ibm.com>
 <20180222041739.27899-1-alastair@au1.ibm.com>
 <20180222041739.27899-2-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Thu, 22 Feb 2018 13:16:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222041739.27899-2-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18022212-0040-0000-0000-000004157763
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022212-0041-0000-0000-000026188CAC
Message-Id: <b9e7dc51-33b2-f72f-6687-3ee8f6bccc21@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802220156
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592985250939595866?=
X-GMAIL-MSGID: =?utf-8?q?1593103377536738102?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



Le 22/02/2018 à 05:17, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Some required information is not exposed to userspace currently (eg. the
> PASID), pass this information back, along with other information which
> is currently communicated via sysfs, which saves some parsing effort in
> userspace.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---

Thanks!
Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>


>   drivers/misc/ocxl/file.c | 27 +++++++++++++++++++++++++++
>   include/uapi/misc/ocxl.h | 17 +++++++++++++++++
>   2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
> index d9aa407db06a..90df1be5ef3f 100644
> --- a/drivers/misc/ocxl/file.c
> +++ b/drivers/misc/ocxl/file.c
> @@ -102,10 +102,32 @@ static long afu_ioctl_attach(struct ocxl_context *ctx,
>   	return rc;
>   }
> 
> +static long afu_ioctl_get_metadata(struct ocxl_context *ctx,
> +		struct ocxl_ioctl_metadata __user *uarg)
> +{
> +	struct ocxl_ioctl_metadata arg;
> +
> +	memset(&arg, 0, sizeof(arg));
> +
> +	arg.version = 0;
> +
> +	arg.afu_version_major = ctx->afu->config.version_major;
> +	arg.afu_version_minor = ctx->afu->config.version_minor;
> +	arg.pasid = ctx->pasid;
> +	arg.pp_mmio_size = ctx->afu->config.pp_mmio_stride;
> +	arg.global_mmio_size = ctx->afu->config.global_mmio_size;
> +
> +	if (copy_to_user(uarg, &arg, sizeof(arg)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>   #define CMD_STR(x) (x == OCXL_IOCTL_ATTACH ? "ATTACH" :			\
>   			x == OCXL_IOCTL_IRQ_ALLOC ? "IRQ_ALLOC" :	\
>   			x == OCXL_IOCTL_IRQ_FREE ? "IRQ_FREE" :		\
>   			x == OCXL_IOCTL_IRQ_SET_FD ? "IRQ_SET_FD" :	\
> +			x == OCXL_IOCTL_GET_METADATA ? "GET_METADATA" :	\
>   			"UNKNOWN")
> 
>   static long afu_ioctl(struct file *file, unsigned int cmd,
> @@ -157,6 +179,11 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
>   					irq_fd.eventfd);
>   		break;
> 
> +	case OCXL_IOCTL_GET_METADATA:
> +		rc = afu_ioctl_get_metadata(ctx,
> +				(struct ocxl_ioctl_metadata __user *) args);
> +		break;
> +
>   	default:
>   		rc = -EINVAL;
>   	}
> diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
> index 4b0b0b756f3e..0af83d80fb3e 100644
> --- a/include/uapi/misc/ocxl.h
> +++ b/include/uapi/misc/ocxl.h
> @@ -32,6 +32,22 @@ struct ocxl_ioctl_attach {
>   	__u64 reserved3;
>   };
> 
> +struct ocxl_ioctl_metadata {
> +	__u16 version; // struct version, always backwards compatible
> +
> +	// Version 0 fields
> +	__u8  afu_version_major;
> +	__u8  afu_version_minor;
> +	__u32 pasid;		// PASID assigned to the current context
> +
> +	__u64 pp_mmio_size;	// Per PASID MMIO size
> +	__u64 global_mmio_size;
> +
> +	// End version 0 fields
> +
> +	__u64 reserved[13]; // Total of 16*u64
> +};
> +
>   struct ocxl_ioctl_irq_fd {
>   	__u64 irq_offset;
>   	__s32 eventfd;
> @@ -45,5 +61,6 @@ struct ocxl_ioctl_irq_fd {
>   #define OCXL_IOCTL_IRQ_ALLOC	_IOR(OCXL_MAGIC, 0x11, __u64)
>   #define OCXL_IOCTL_IRQ_FREE	_IOW(OCXL_MAGIC, 0x12, __u64)
>   #define OCXL_IOCTL_IRQ_SET_FD	_IOW(OCXL_MAGIC, 0x13, struct ocxl_ioctl_irq_fd)
> +#define OCXL_IOCTL_GET_METADATA _IOR(OCXL_MAGIC, 0x14, struct ocxl_ioctl_metadata)
> 
>   #endif /* _UAPI_MISC_OCXL_H */
> 
