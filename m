Return-Path: <fbarrat@linux.vnet.ibm.com>
X-Google-Smtp-Source: AH8x227wTIpQBRbKx640a3XhUAjY2y+XZqey9t0hauIs2CXMSUgDAB732ObNPllfKYheaAW0pE7C
ARC-Seal: i=1; a=rsa-sha256; t=1519212351; cv=none;
        d=google.com; s=arc-20160816;
        b=yoFWpAXSw3tPDuY/HtlDU/fmbKwsiiiyO/cvtbVy+3w2q7UNQDN9+B7SW4J2FAd6Ce
         bDlVynvvRH6ySQSlgsXUzgsY/FZUaNi4mv7ZqFNAUpp2eH3f+NM5AIyIdrhEoM4u0gM0
         rRtoYi5Q/6v2CEv4oQ/vayw6m7YmlqVN3hvxER25LURdKMCFfbRGh8XGxGu6NoDWBrIs
         HL2dZDShz5KNnHpfyFDnE/DSG6mfRYMNJtW9w6iP7uu+jZAeeoxaWzPYjXt3ud+Icz6O
         nwGjaai7vij5afvGhkQaRU+CsQQz+ibW0NmicAvlvYtKsMSepDxA3W7GE0UwKc4KBpAW
         JXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=TbcmrtlcCkyo8qx9GSKZmI1rJaxRs8hamEbsJhjvnk0=;
        b=MHOYCacKWEUOp0aNwk24hUXSbjf1/MoiJBPGY98mxpxEtIHJk5i2vTt0AE/nsIccss
         Ak7E7sx+9xTEx/DNwwpDP1ZmEC38BC2w/iIfBdeKWHh/ddeMUF3l9+4m5x3F8ib7V7mh
         y83529BkkhGpAUyepS37ctGaifUFQKBkb2YOdfJrEINj9FnFqpaT/qLE8AxnCqYI5Mfr
         RoufOWX4AA1WX+eUz2iZptCGBUMd/QhfSWIN5UL6w0y3zKchlzF5Ypfka/NsKrLXng3t
         5AQMhgwFHqZmQMpz7pwR78oMfPfBKBeS07RDSZzpgULp+jZvlO7ILpJWH4ZkF2jUaBRy
         TGnw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of fbarrat@linux.vnet.ibm.com) smtp.mailfrom=fbarrat@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of fbarrat@linux.vnet.ibm.com) smtp.mailfrom=fbarrat@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH] ocxl: Add get_metadata IOCTL to share OCXL information to
 userspace
To: Balbir Singh <bsingharora@gmail.com>,
        "Alastair D'Silva" <alastair@au1.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, frederic.barrat@fr.ibm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        "Alastair D'Silva" <alastair@d-silva.org>
References: <20180221045736.7614-1-alastair@au1.ibm.com>
 <CAKTCnz=cy5CkeRjJYpZ1NQpyQN-BVTvKXUxTxOMtTNosZFqJ7A@mail.gmail.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 21 Feb 2018 12:25:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKTCnz=cy5CkeRjJYpZ1NQpyQN-BVTvKXUxTxOMtTNosZFqJ7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18022111-0008-0000-0000-000004D2AD7E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022111-0009-0000-0000-00001E65B4F5
Message-Id: <c6017f9f-67f0-10eb-1eed-527c9c5298ba@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-21_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802210141
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592985250939595866?=
X-GMAIL-MSGID: =?utf-8?q?1593009610137441344?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



Le 21/02/2018 à 07:43, Balbir Singh a écrit :
> On Wed, Feb 21, 2018 at 3:57 PM, Alastair D'Silva <alastair@au1.ibm.com> wrote:
>> From: Alastair D'Silva <alastair@d-silva.org>
>>
>> Some required information is not exposed to userspace currently (eg. the
>> PASID), pass this information back, along with other information which
>> is currently communicated via sysfs, which saves some parsing effort in
>> userspace.
>>
>> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
>> ---
>>   drivers/misc/ocxl/file.c | 27 +++++++++++++++++++++++++++
>>   include/uapi/misc/ocxl.h | 22 ++++++++++++++++++++++
>>   2 files changed, 49 insertions(+)
>>
>> diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
>> index d9aa407db06a..11514a8444e5 100644
>> --- a/drivers/misc/ocxl/file.c
>> +++ b/drivers/misc/ocxl/file.c
>> @@ -102,10 +102,32 @@ static long afu_ioctl_attach(struct ocxl_context *ctx,
>>          return rc;
>>   }
>>
>> +static long afu_ioctl_get_metadata(struct ocxl_context *ctx,
>> +               struct ocxl_ioctl_get_metadata __user *uarg)
> 
> Why do we call this metadata? Isn't this an afu_descriptor?
> 
>> +{
>> +       struct ocxl_ioctl_get_metadata arg;
>> +
>> +       memset(&arg, 0, sizeof(arg));
>> +
>> +       arg.version = 0;
> 
> Does it make sense to have version 0? Even if does, you can afford
> to skip initialization due to the memset above. I prefer that versions
> start with 1
> 
>> +
>> +       arg.afu_version_major = ctx->afu->config.version_major;
>> +       arg.afu_version_minor = ctx->afu->config.version_minor;
>> +       arg.pasid = ctx->pasid;
>> +       arg.pp_mmio_size = ctx->afu->config.pp_mmio_stride;
>> +       arg.global_mmio_size = ctx->afu->config.global_mmio_size;
>> +
>> +       if (copy_to_user(uarg, &arg, sizeof(arg)))
>> +               return -EFAULT;
>> +
>> +       return 0;
>> +}
>> +
>>   #define CMD_STR(x) (x == OCXL_IOCTL_ATTACH ? "ATTACH" :                        \
>>                          x == OCXL_IOCTL_IRQ_ALLOC ? "IRQ_ALLOC" :       \
>>                          x == OCXL_IOCTL_IRQ_FREE ? "IRQ_FREE" :         \
>>                          x == OCXL_IOCTL_IRQ_SET_FD ? "IRQ_SET_FD" :     \
>> +                       x == OCXL_IOCTL_GET_METADATA ? "GET_METADATA" : \
>>                          "UNKNOWN")
>>
>>   static long afu_ioctl(struct file *file, unsigned int cmd,
>> @@ -157,6 +179,11 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
>>                                          irq_fd.eventfd);
>>                  break;
>>
>> +       case OCXL_IOCTL_GET_METADATA:
>> +               rc = afu_ioctl_get_metadata(ctx,
>> +                               (struct ocxl_ioctl_get_metadata __user *) args);
>> +               break;
>> +
>>          default:
>>                  rc = -EINVAL;
>>          }
>> diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
>> index 4b0b0b756f3e..16e1f48ce280 100644
>> --- a/include/uapi/misc/ocxl.h
>> +++ b/include/uapi/misc/ocxl.h
>> @@ -32,6 +32,27 @@ struct ocxl_ioctl_attach {
>>          __u64 reserved3;
>>   };
>>
>> +/*
>> + * Version contains the version of the struct.
>> + * Versions will always be backwards compatible, that is, new versions will not
>> + * alter existing fields
>> + */
>> +struct ocxl_ioctl_get_metadata {
> 
> This sounds more like a function name, do we need it to be _get_metdata?
> 
>> +       __u16 version;
>> +
>> +       // Version 0 fields
>> +       __u8  afu_version_major;
>> +       __u8  afu_version_minor;
>> +       __u32 pasid;
>> +
>> +       __u64 pp_mmio_size;
>> +       __u64 global_mmio_size;
>> +
> 
> Should we document the fields? pp_ stands for per process, but is not
> very clear at first look. Why do we care to return only the size, what
> about lpc size?

My bad, I forgot to mention it before. There's a somewhat high-level 
description which needs updating in:
Documentation/accelerators/ocxl.rst

It doesn't go down to the level of the structure members, but at least 
all ioctl commands should have a brief description.

lpc_size could be added. It's currently useless to the library, but 
doesn't hurt. The one which was giving me troubles on a previous version 
of this patch was the lpc numa node ID, since that was experimental code 
and felt out of place considering what's been upstreamed in skiboot and 
linux so far.

   Fred


>> +       // End version 0 fields
>> +
>> +       __u64 reserved[13]; // Total of 16*u64
>> +};
> 
> 
> Balbir Singh.
> 
