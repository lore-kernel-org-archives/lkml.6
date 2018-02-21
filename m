Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AH8x225bh30p9cljmUVQX7Id1wAJY84ct3RnOLlKThXT4iLjVJih9zuOEqldmm1dAsoZ9uIND5QW
ARC-Seal: i=1; a=rsa-sha256; t=1519255943; cv=none;
        d=google.com; s=arc-20160816;
        b=W13G+ew/RnPIFh8lyOUINn6FR0hHKwpZJCC71T6FOQIYEHS2g0vpDt6Uad02/ei6pY
         Myj/2DySiUI7Ni8oCAbepSzlQEmr3ihKjHq1eyEDhWo14mSSH0vEK77tlV2mwr5Y6Z22
         extf8XHnehZ9cKXmtCn6FX1NlG6vfd4gBr0tUC3FbwdLXw7jfVD2TKju+KFpzG8RtFY8
         eidwATVrZkx4PiUSo6kAo7tbwktB5HZps3wYiA/e5TpW00phz0WJzzXZhM5a+Qx9073m
         YQo20I6C3+ZWNuWekdedfAGa7WzuySow7f9HBafwtFKw6cprFIGge6DOQGpaGpLH5dvj
         LMwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:organization
         :references:in-reply-to:date:cc:to:from:subject
         :arc-authentication-results;
        bh=TQJIARAYyuAPN5zamdEjPSSH+iU1z05eed3db8dCAGw=;
        b=nTXoR5UsOdvFOnaCfZzMLTw7WUC/uP+Y0056t4SWycdIeCUnxII/lwVF9VD1Xjq5FC
         KU02mVmjKG80FaOw/A9bMsQWJwgo7bzefxNi7o8w00+h0OOrZGwIiV9aB0O2tXRBAT4I
         RDxSU2+hVOI+hm5Nje38Mp8WzRV52n8S1XrLpnKNjzip+FB8LHQe9sk74MlS94mOuHpV
         gE3YPM8AcYzozIWORbiK8E9HgOKTz+YvyrCg9FTj5i6ASHOpIgLaYLv5NY7c+SUA4uXU
         ULWpR5+aZ6Ir24q5pyyOyIGA/OJ00Da8DHFORqCzBu8/jUD60Exlhyz6yAI2beYd8TSE
         vj+A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH] ocxl: Add get_metadata IOCTL to share OCXL information
 to userspace
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
        "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, frederic.barrat@fr.ibm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew
	Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 22 Feb 2018 10:32:14 +1100
In-Reply-To: <CAKTCnz=cy5CkeRjJYpZ1NQpyQN-BVTvKXUxTxOMtTNosZFqJ7A@mail.gmail.com>
References: <20180221045736.7614-1-alastair@au1.ibm.com>
	 <CAKTCnz=cy5CkeRjJYpZ1NQpyQN-BVTvKXUxTxOMtTNosZFqJ7A@mail.gmail.com>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18022123-0040-0000-0000-000004153A27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022123-0041-0000-0000-000026184D43
Message-Id: <1519255934.2867.3.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-21_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802210279
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592985250939595866?=
X-GMAIL-MSGID: =?utf-8?q?1593055320223728791?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On Wed, 2018-02-21 at 17:43 +1100, Balbir Singh wrote:
> On Wed, Feb 21, 2018 at 3:57 PM, Alastair D'Silva <alastair@au1.ibm.c
> om> wrote:
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > Some required information is not exposed to userspace currently
> > (eg. the
> > PASID), pass this information back, along with other information
> > which
> > is currently communicated via sysfs, which saves some parsing
> > effort in
> > userspace.
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> >  drivers/misc/ocxl/file.c | 27 +++++++++++++++++++++++++++
> >  include/uapi/misc/ocxl.h | 22 ++++++++++++++++++++++
> >  2 files changed, 49 insertions(+)
> > 
> > diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
> > index d9aa407db06a..11514a8444e5 100644
> > --- a/drivers/misc/ocxl/file.c
> > +++ b/drivers/misc/ocxl/file.c
> > @@ -102,10 +102,32 @@ static long afu_ioctl_attach(struct
> > ocxl_context *ctx,
> >         return rc;
> >  }
> > 
> > +static long afu_ioctl_get_metadata(struct ocxl_context *ctx,
> > +               struct ocxl_ioctl_get_metadata __user *uarg)
> 
> Why do we call this metadata? Isn't this an afu_descriptor?
> 

It's metadata for the descriptor.

> > +{
> > +       struct ocxl_ioctl_get_metadata arg;
> > +
> > +       memset(&arg, 0, sizeof(arg));
> > +
> > +       arg.version = 0;
> 
> Does it make sense to have version 0? Even if does, you can afford
> to skip initialization due to the memset above. I prefer that
> versions
> start with 1
> 

Setting it to 0 is for the reader, not the compiler. I'm not clear on
the benefit of starting the version at 1, could you clarify?

> > +
> > +       arg.afu_version_major = ctx->afu->config.version_major;
> > +       arg.afu_version_minor = ctx->afu->config.version_minor;
> > +       arg.pasid = ctx->pasid;
> > +       arg.pp_mmio_size = ctx->afu->config.pp_mmio_stride;
> > +       arg.global_mmio_size = ctx->afu->config.global_mmio_size;
> > +
> > +       if (copy_to_user(uarg, &arg, sizeof(arg)))
> > +               return -EFAULT;
> > +
> > +       return 0;
> > +}
> > +
> >  #define CMD_STR(x) (x == OCXL_IOCTL_ATTACH ? "ATTACH"
> > :                        \
> >                         x == OCXL_IOCTL_IRQ_ALLOC ? "IRQ_ALLOC"
> > :       \
> >                         x == OCXL_IOCTL_IRQ_FREE ? "IRQ_FREE"
> > :         \
> >                         x == OCXL_IOCTL_IRQ_SET_FD ? "IRQ_SET_FD"
> > :     \
> > +                       x == OCXL_IOCTL_GET_METADATA ?
> > "GET_METADATA" : \
> >                         "UNKNOWN")
> > 
> >  static long afu_ioctl(struct file *file, unsigned int cmd,
> > @@ -157,6 +179,11 @@ static long afu_ioctl(struct file *file,
> > unsigned int cmd,
> >                                         irq_fd.eventfd);
> >                 break;
> > 
> > +       case OCXL_IOCTL_GET_METADATA:
> > +               rc = afu_ioctl_get_metadata(ctx,
> > +                               (struct ocxl_ioctl_get_metadata
> > __user *) args);
> > +               break;
> > +
> >         default:
> >                 rc = -EINVAL;
> >         }
> > diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
> > index 4b0b0b756f3e..16e1f48ce280 100644
> > --- a/include/uapi/misc/ocxl.h
> > +++ b/include/uapi/misc/ocxl.h
> > @@ -32,6 +32,27 @@ struct ocxl_ioctl_attach {
> >         __u64 reserved3;
> >  };
> > 
> > +/*
> > + * Version contains the version of the struct.
> > + * Versions will always be backwards compatible, that is, new
> > versions will not
> > + * alter existing fields
> > + */
> > +struct ocxl_ioctl_get_metadata {
> 
> This sounds more like a function name, do we need it to be
> _get_metdata?
> 

It pretty much is a function, it returns to userspace metadata about
the descriptor being operated on.

> > +       __u16 version;
> > +
> > +       // Version 0 fields
> > +       __u8  afu_version_major;
> > +       __u8  afu_version_minor;
> > +       __u32 pasid;
> > +
> > +       __u64 pp_mmio_size;
> > +       __u64 global_mmio_size;
> > +
> 
> Should we document the fields? pp_ stands for per process, but is not
> very clear at first look. Why do we care to return only the size,
> what
> about lpc size?
> 

Yes, I would rather call it per_pasid_mmio_size, but consistency with
the rest of the driver (& exposed sysfs entries) is also important.

> > +       // End version 0 fields
> > +
> > +       __u64 reserved[13]; // Total of 16*u64
> > +};
> 
> 
> Balbir Singh.
> 

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australiamob: 0423 762 819
