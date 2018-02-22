Return-Path: <bsingharora@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519271214; cv=none;
        d=google.com; s=arc-20160816;
        b=hcllLr80SKLEQ7PQiHVy+zRZSrfC8smexpDuewifyNKC8e8blf4xaAsdabvHwDAVbX
         Q+cE3rMJPqoSUcweCBqXGDr/RUStUkNq2YOY51oQlptAzxYytyXZ3etEw7yeLCSKvhbQ
         fAt+IP6K4eJJVeZVsEglYA3oOnynSraaMt1kKgI3oB2RCLrrbgbygXGMzP637jbwwFp7
         +n26eRi2HREbbdwyYs9B4CE8meuuOHnP1GFti/Q4mNXi8eVnnIewcHeizJRyGxRFMHql
         HcmS7474kfLzuJZDkcw7FznZeJ8+Tn74Bqe2t09Xo4DhQZ7bBAyxlWAMc54hkOYeKkW5
         xr0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=PslOoHvM6prYE4CN44Ohhxq2sa1u0UjEHxFbMFFO3Os=;
        b=UkceHE8ZvcsOGI9JbBkkN9Gpm3RdU+xBL+nlIH00oV6dzK80ZQIokfjqzdx7mLvGcS
         Vfjg71yKdSfPqXhm1d+rfHE0pSibGuNZmNa2QWTIwi4N+0CJjxrYvHb5UaXelRqoYK92
         oX5ocKJ36Lo128kRWfH3xmELZNUoWqsC7xT9lIn6UYEQc9cnIHWUcsrfobPPHulBfJER
         Ei4UVencfm7rAxjqqmH8yU88rYO4Yv+tn34sZbRmel3hJNHYlLSNLAiru5+BSQGJKwSV
         pbncgD00ts5cml3akclX+o6hU+OOPmUnhMli3yr1LGse+URn5dDb6qlSfIgPzq1NGC3W
         4ggA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=r65sU34G;
       spf=pass (google.com: domain of bsingharora@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=bsingharora@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=r65sU34G;
       spf=pass (google.com: domain of bsingharora@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=bsingharora@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227ivUUOrX6b9vwz3MrVz29BZ6DTmuYf9Z+A/woEAgPlCm5Fl6w6raRLRbznmH6DvsXsDJrcnHeG4tSdRJ2utPk=
MIME-Version: 1.0
In-Reply-To: <c6017f9f-67f0-10eb-1eed-527c9c5298ba@linux.vnet.ibm.com>
References: <20180221045736.7614-1-alastair@au1.ibm.com> <CAKTCnz=cy5CkeRjJYpZ1NQpyQN-BVTvKXUxTxOMtTNosZFqJ7A@mail.gmail.com>
 <c6017f9f-67f0-10eb-1eed-527c9c5298ba@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 22 Feb 2018 14:46:53 +1100
Message-ID: <CAKTCnzkwwmbU4vzrmzW=eNnr2QW+rj=OUcAdOVxz+qKGC=9Q9A@mail.gmail.com>
Subject: Re: [PATCH] ocxl: Add get_metadata IOCTL to share OCXL information to userspace
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: "Alastair D'Silva" <alastair@au1.ibm.com>, Arnd Bergmann <arnd@arndb.de>, frederic.barrat@fr.ibm.com,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Andrew Donnellan <andrew.donnellan@au1.ibm.com>, "Alastair D'Silva" <alastair@d-silva.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592985250939595866?=
X-GMAIL-MSGID: =?utf-8?q?1593071333516549382?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 10:25 PM, Frederic Barrat
<fbarrat@linux.vnet.ibm.com> wrote:
>
>
> Le 21/02/2018 =C3=A0 07:43, Balbir Singh a =C3=A9crit :
>>
>> On Wed, Feb 21, 2018 at 3:57 PM, Alastair D'Silva <alastair@au1.ibm.com>
>> wrote:
>>>
>>> From: Alastair D'Silva <alastair@d-silva.org>
>>>
>>> Some required information is not exposed to userspace currently (eg. th=
e
>>> PASID), pass this information back, along with other information which
>>> is currently communicated via sysfs, which saves some parsing effort in
>>> userspace.
>>>
>>> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
>>> ---
>>>   drivers/misc/ocxl/file.c | 27 +++++++++++++++++++++++++++
>>>   include/uapi/misc/ocxl.h | 22 ++++++++++++++++++++++
>>>   2 files changed, 49 insertions(+)
>>>
>>> diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
>>> index d9aa407db06a..11514a8444e5 100644
>>> --- a/drivers/misc/ocxl/file.c
>>> +++ b/drivers/misc/ocxl/file.c
>>> @@ -102,10 +102,32 @@ static long afu_ioctl_attach(struct ocxl_context
>>> *ctx,
>>>          return rc;
>>>   }
>>>
>>> +static long afu_ioctl_get_metadata(struct ocxl_context *ctx,
>>> +               struct ocxl_ioctl_get_metadata __user *uarg)
>>
>>
>> Why do we call this metadata? Isn't this an afu_descriptor?
>>
>>> +{
>>> +       struct ocxl_ioctl_get_metadata arg;
>>> +
>>> +       memset(&arg, 0, sizeof(arg));
>>> +
>>> +       arg.version =3D 0;
>>
>>
>> Does it make sense to have version 0? Even if does, you can afford
>> to skip initialization due to the memset above. I prefer that versions
>> start with 1
>>
>>> +
>>> +       arg.afu_version_major =3D ctx->afu->config.version_major;
>>> +       arg.afu_version_minor =3D ctx->afu->config.version_minor;
>>> +       arg.pasid =3D ctx->pasid;
>>> +       arg.pp_mmio_size =3D ctx->afu->config.pp_mmio_stride;
>>> +       arg.global_mmio_size =3D ctx->afu->config.global_mmio_size;
>>> +
>>> +       if (copy_to_user(uarg, &arg, sizeof(arg)))
>>> +               return -EFAULT;
>>> +
>>> +       return 0;
>>> +}
>>> +
>>>   #define CMD_STR(x) (x =3D=3D OCXL_IOCTL_ATTACH ? "ATTACH" :
>>> \
>>>                          x =3D=3D OCXL_IOCTL_IRQ_ALLOC ? "IRQ_ALLOC" :
>>> \
>>>                          x =3D=3D OCXL_IOCTL_IRQ_FREE ? "IRQ_FREE" :
>>> \
>>>                          x =3D=3D OCXL_IOCTL_IRQ_SET_FD ? "IRQ_SET_FD" =
:
>>> \
>>> +                       x =3D=3D OCXL_IOCTL_GET_METADATA ? "GET_METADAT=
A" : \
>>>                          "UNKNOWN")
>>>
>>>   static long afu_ioctl(struct file *file, unsigned int cmd,
>>> @@ -157,6 +179,11 @@ static long afu_ioctl(struct file *file, unsigned
>>> int cmd,
>>>                                          irq_fd.eventfd);
>>>                  break;
>>>
>>> +       case OCXL_IOCTL_GET_METADATA:
>>> +               rc =3D afu_ioctl_get_metadata(ctx,
>>> +                               (struct ocxl_ioctl_get_metadata __user =
*)
>>> args);
>>> +               break;
>>> +
>>>          default:
>>>                  rc =3D -EINVAL;
>>>          }
>>> diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
>>> index 4b0b0b756f3e..16e1f48ce280 100644
>>> --- a/include/uapi/misc/ocxl.h
>>> +++ b/include/uapi/misc/ocxl.h
>>> @@ -32,6 +32,27 @@ struct ocxl_ioctl_attach {
>>>          __u64 reserved3;
>>>   };
>>>
>>> +/*
>>> + * Version contains the version of the struct.
>>> + * Versions will always be backwards compatible, that is, new versions
>>> will not
>>> + * alter existing fields
>>> + */
>>> +struct ocxl_ioctl_get_metadata {
>>
>>
>> This sounds more like a function name, do we need it to be _get_metdata?
>>
>>> +       __u16 version;
>>> +
>>> +       // Version 0 fields
>>> +       __u8  afu_version_major;
>>> +       __u8  afu_version_minor;
>>> +       __u32 pasid;
>>> +
>>> +       __u64 pp_mmio_size;
>>> +       __u64 global_mmio_size;
>>> +
>>
>>
>> Should we document the fields? pp_ stands for per process, but is not
>> very clear at first look. Why do we care to return only the size, what
>> about lpc size?
>
>
> My bad, I forgot to mention it before. There's a somewhat high-level
> description which needs updating in:
> Documentation/accelerators/ocxl.rst

Thanks, that's helpful

>
> It doesn't go down to the level of the structure members, but at least al=
l
> ioctl commands should have a brief description.
>
> lpc_size could be added. It's currently useless to the library, but doesn=
't
> hurt. The one which was giving me troubles on a previous version of this
> patch was the lpc numa node ID, since that was experimental code and felt
> out of place considering what's been upstreamed in skiboot and linux so f=
ar.
>

Yeah, I think metadata will evolve for a while till it settle's down.
Since ocxl_ioctl_get_metadata is exposed via uapi, a newer program
calling an older kernel will never work, since the size of that struct
will always be larger than what the OS supports and our copy_to_user()
will fail. The other option is for the user program to try all
possible versions till one succeeds, that is bad as well. I think
there are a few ways around it, if we care about this combination.

Balbir Singh.
