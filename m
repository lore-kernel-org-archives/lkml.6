Return-Path: <fbarrat@linux.ibm.com>
X-Google-Smtp-Source: AB8JxZr4v8KHIAHNl3IQbsaOxKWMMxm468qoVc/RqDjaVgYcXDy1lP5ULh451IJ0gJpiRNrMHVDn
ARC-Seal: i=1; a=rsa-sha256; t=1525716883; cv=none;
        d=google.com; s=arc-20160816;
        b=jNej7PwRrkD4CjLXyDG/UG1oaO9l2+GsQ/Bk4wVDCjfwAtV1xe2VN+ZWV97MJVW5CU
         im30kZHG7J6SSxPe0nu96KoOMxTxbZXrQOV0MnHH3E4Y8IP/6AyztrvykRDfPcM2PkUm
         b8lqRyK4CLZErB3M4Ze/P5klMik9lliKQxT2L9NX0TcPbNI+46EabZBFkR1C2Y3bGFwl
         emqosuCNkG7KaBoxGps2Y6js/mmtc01W8nlmSVUituJyJn1WadZSNdKbAnKT4Q6Zt4+/
         amCtURnD9qrR8unK5z0EsGFJQCA5aVTHg2+l+BjxExtTrxg1krluZf19eHOXJcucdhuk
         8Mpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=WoePwBsgGKSRWVWVIs16sgtAbfOP/XFImGWW3L4wtls=;
        b=rys2Bmr2aISbaTP6pBZcE+mgdAWYFKAxThHtiqgNSWWkg5s8lxDHAzOUkkw/OwnkrC
         vnxLwP0H9d1L8DLmGCaPz+IfQTVsTQxqQ4lFB0/Mh6qKZCWk5ZhM35psJH2kvTusxp/9
         kGw9VXYKRDqIecC4EPDnqzMPIPOPxlG8Cif/rQ/mFh8D4KD9W6rlIzByxpZkYLq0J+BO
         fphADF8q0BmOd4eGb6AZxg889xAejacBn9nvBvtRmfrUyyE1vvEDWggmB8Y/NiMkt5nu
         Qpz3LkqAykIfPjmpn3ZVLeawDIq38o6EGEgn/jnAzPYssuPLb/uUogQKbdIdyRvhhpJF
         YDwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fbarrat@linux.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=fbarrat@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fbarrat@linux.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=fbarrat@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v2 6/7] ocxl: Add an IOCTL so userspace knows what CPU
 features are available
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
        vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180418010810.30937-1-alastair@au1.ibm.com>
 <20180418010810.30937-7-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Mon, 7 May 2018 20:14:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418010810.30937-7-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18050718-0040-0000-0000-0000043711D6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050718-0041-0000-0000-0000263B482A
Message-Id: <eec7dceb-0b25-8644-7f32-3700c3c4ed46@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805070182
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598044369272237673?=
X-GMAIL-MSGID: =?utf-8?q?1599830106647429059?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



Le 18/04/2018 à 03:08, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> In order for a userspace AFU driver to call the Power9 specific
> OCXL_IOCTL_ENABLE_P9_WAIT, it needs to verify that it can actually
> make that call.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>   Documentation/accelerators/ocxl.rst |  1 -
>   drivers/misc/ocxl/file.c            | 25 +++++++++++++++++++++++++
>   include/uapi/misc/ocxl.h            |  4 ++++
>   3 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/accelerators/ocxl.rst b/Documentation/accelerators/ocxl.rst
> index ddcc58d01cfb..7904adcc07fd 100644
> --- a/Documentation/accelerators/ocxl.rst
> +++ b/Documentation/accelerators/ocxl.rst
> @@ -157,7 +157,6 @@ OCXL_IOCTL_GET_METADATA:
>     Obtains configuration information from the card, such at the size of
>     MMIO areas, the AFU version, and the PASID for the current context.
> 
> -


Intended?

Other than that,
Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>



>   mmap
>   ----
> 
> diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
> index eb409a469f21..33ae46ce0a8a 100644
> --- a/drivers/misc/ocxl/file.c
> +++ b/drivers/misc/ocxl/file.c
> @@ -168,12 +168,32 @@ static long afu_ioctl_enable_p9_wait(struct ocxl_context *ctx,
>   }
>   #endif
> 
> +
> +static long afu_ioctl_get_features(struct ocxl_context *ctx,
> +		struct ocxl_ioctl_features __user *uarg)
> +{
> +	struct ocxl_ioctl_features arg;
> +
> +	memset(&arg, 0, sizeof(arg));
> +
> +#ifdef CONFIG_PPC64
> +	if (cpu_has_feature(CPU_FTR_P9_TIDR))
> +		arg.flags[0] |= OCXL_IOCTL_FEATURES_FLAGS0_P9_WAIT;
> +#endif
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
>   			x == OCXL_IOCTL_GET_METADATA ? "GET_METADATA" :	\
>   			x == OCXL_IOCTL_ENABLE_P9_WAIT ? "ENABLE_P9_WAIT" :	\
> +			x == OCXL_IOCTL_GET_FEATURES ? "GET_FEATURES" :	\
>   			"UNKNOWN")
> 
>   static long afu_ioctl(struct file *file, unsigned int cmd,
> @@ -239,6 +259,11 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
>   		break;
>   #endif
> 
> +	case OCXL_IOCTL_GET_FEATURES:
> +		rc = afu_ioctl_get_features(ctx,
> +				(struct ocxl_ioctl_features __user *) args);
> +		break;
> +
>   	default:
>   		rc = -EINVAL;
>   	}
> diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
> index 8d2748e69c84..bb80f294b429 100644
> --- a/include/uapi/misc/ocxl.h
> +++ b/include/uapi/misc/ocxl.h
> @@ -55,6 +55,9 @@ struct ocxl_ioctl_p9_wait {
>   	__u64 reserved3[3];
>   };
> 
> +#define OCXL_IOCTL_FEATURES_FLAGS0_P9_WAIT	0x01
> +struct ocxl_ioctl_features {
> +	__u64 flags[4];
>   };
> 
>   struct ocxl_ioctl_irq_fd {
> @@ -72,5 +75,6 @@ struct ocxl_ioctl_irq_fd {
>   #define OCXL_IOCTL_IRQ_SET_FD	_IOW(OCXL_MAGIC, 0x13, struct ocxl_ioctl_irq_fd)
>   #define OCXL_IOCTL_GET_METADATA _IOR(OCXL_MAGIC, 0x14, struct ocxl_ioctl_metadata)
>   #define OCXL_IOCTL_ENABLE_P9_WAIT	_IOR(OCXL_MAGIC, 0x15, struct ocxl_ioctl_p9_wait)
> +#define OCXL_IOCTL_GET_FEATURES _IOR(OCXL_MAGIC, 0x16, struct ocxl_ioctl_platform)
> 
>   #endif /* _UAPI_MISC_OCXL_H */
> 
