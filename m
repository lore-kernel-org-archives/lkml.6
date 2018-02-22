Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AH8x2267LdgXk1gBHNA8SITSwuS/lNKv3TuGl7VD3AOhYT/I2H3N1RDow8mPXEIkBpMYu5ozLR5R
ARC-Seal: i=1; a=rsa-sha256; t=1519271314; cv=none;
        d=google.com; s=arc-20160816;
        b=NCudx6q+iav5hztxDzFvROgogc2OBnYd5wTjiSBX3GtjMJRBsdaqmJEkoiPLzE6GSL
         dxsUBmcQ8+EGdpxSLtdYCChmhKb6xc1unlyAQpzY6zS2mfLjG9K7y+wFEGmVsQ2rrbx1
         DaYNaQXOwGVxtgmfhPOip1PZtFX2ldp/GQCJ5caaiCC3MTcsYXVSY2uIOym1zAsYZcLA
         CbPAOayE461gq1JzJ4HkKlScPH5cu73njrSfEtK0s4HOkMLkk/Xf3C+u0BTayuyMAi9F
         p/imOoIm4ULE7117m1Ll1HFD88I/YpXV98kXfdvf0k7OCTai96CXH2IHXEV7uogUK4l2
         lE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:organization
         :references:in-reply-to:date:cc:to:from:subject
         :arc-authentication-results;
        bh=mXb4iicwZwb3Hzqei6N5r+4d1F13iT5lonKZL3Zam4w=;
        b=SQARiVm4vzOH+XhiCxPgyUrlu6gOoDugcgWnDuYeeyjqVzuilvVU0CS87OzRMAKxj3
         IpXeCbB3nyJ3JFu1FEXviV7RZe3P5PAjS8brAVecUtzzqXWbB7liHCmnsWyLEg75BoAo
         kyGJae+uElUKBKdUNJSr+tOW85eeshUtOsi9PjBK5ZZE8GA1J1fbwYaVS+m9VyYRXpA0
         MaqB3DowzyzNQrYodF8+3innjPc+C1Ddz42NU+oIb0R1MdosVJgB+xMi9HJrijyozQQ2
         KzA0Y3h9uigvMpN1nBcIsrCzDzBi+S6zRH9tZHX7fCnwVaynOKj+YWRiR6yZlKZq8g8a
         JcpA==
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
Date: Thu, 22 Feb 2018 14:48:27 +1100
In-Reply-To: <CAKTCnzmmUGPNk1ggpWYQjiDLcAR_c7cqdZyPU+6rKGC6AcNW7A@mail.gmail.com>
References: <20180221045736.7614-1-alastair@au1.ibm.com>
	 <CAKTCnz=cy5CkeRjJYpZ1NQpyQN-BVTvKXUxTxOMtTNosZFqJ7A@mail.gmail.com>
	 <1519255934.2867.3.camel@au1.ibm.com>
	 <CAKTCnzmmUGPNk1ggpWYQjiDLcAR_c7cqdZyPU+6rKGC6AcNW7A@mail.gmail.com>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18022203-0016-0000-0000-00000528507B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022203-0017-0000-0000-000028646742
Message-Id: <1519271307.2867.12.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802220048
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592985250939595866?=
X-GMAIL-MSGID: =?utf-8?q?1593071437996367817?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-02-22 at 14:41 +1100, Balbir Singh wrote:
> On Thu, Feb 22, 2018 at 10:32 AM, Alastair D'Silva <alastair@au1.ibm.
> com> wrote:
> > 
> > On Wed, 2018-02-21 at 17:43 +1100, Balbir Singh wrote:
> > > On Wed, Feb 21, 2018 at 3:57 PM, Alastair D'Silva <alastair@au1.i
> > > bm.c
> > > om> wrote:
> > > > From: Alastair D'Silva <alastair@d-silva.org>
> > > > 
> > > > Some required information is not exposed to userspace currently
> > > > (eg. the
> > > > PASID), pass this information back, along with other
> > > > information
> > > > which
> > > > is currently communicated via sysfs, which saves some parsing
> > > > effort in
> > > > userspace.
> > > > 
> > > > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > > > ---
> > > >  drivers/misc/ocxl/file.c | 27 +++++++++++++++++++++++++++
> > > >  include/uapi/misc/ocxl.h | 22 ++++++++++++++++++++++
> > > >  2 files changed, 49 insertions(+)
> > > > 
> > > > diff --git a/drivers/misc/ocxl/file.c
> > > > b/drivers/misc/ocxl/file.c
> > > > index d9aa407db06a..11514a8444e5 100644
> > > > --- a/drivers/misc/ocxl/file.c
> > > > +++ b/drivers/misc/ocxl/file.c
> > > > @@ -102,10 +102,32 @@ static long afu_ioctl_attach(struct
> > > > ocxl_context *ctx,
> > > >         return rc;
> > > >  }
> > > > 
> > > > +static long afu_ioctl_get_metadata(struct ocxl_context *ctx,
> > > > +               struct ocxl_ioctl_get_metadata __user *uarg)
> > > 
> > > Why do we call this metadata? Isn't this an afu_descriptor?
> > > 
> > 
> > It's metadata for the descriptor.
> 
> I meant metadata is too generic, could we have other types of
> metadata in OCXL?
> 

I don't believe so, we would instead expand the scope of this IOCTL
using version & space available from the reserved fields.

> > 
> > > > +{
> > > > +       struct ocxl_ioctl_get_metadata arg;
> > > > +
> > > > +       memset(&arg, 0, sizeof(arg));
> > > > +
> > > > +       arg.version = 0;
> > > 
> > > Does it make sense to have version 0? Even if does, you can
> > > afford
> > > to skip initialization due to the memset above. I prefer that
> > > versions
> > > start with 1
> > > 
> > 
> > Setting it to 0 is for the reader, not the compiler. I'm not clear
> > on
> > the benefit of starting the version at 1, could you clarify?
> 
> How do I distinguish between version number never set and 0?
> 

The version number is always set. If the IOCTL doesn't exist, the ioctl
call will error instead.

> > 
> > > > +
> > > > +       arg.afu_version_major = ctx->afu->config.version_major;
> > > > +       arg.afu_version_minor = ctx->afu->config.version_minor;
> > > > +       arg.pasid = ctx->pasid;
> > > > +       arg.pp_mmio_size = ctx->afu->config.pp_mmio_stride;
> > > > +       arg.global_mmio_size = ctx->afu-
> > > > >config.global_mmio_size;
> > > > +
> > > > +       if (copy_to_user(uarg, &arg, sizeof(arg)))
> > > > +               return -EFAULT;
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > >  #define CMD_STR(x) (x == OCXL_IOCTL_ATTACH ? "ATTACH"
> > > > :                        \
> > > >                         x == OCXL_IOCTL_IRQ_ALLOC ? "IRQ_ALLOC"
> > > > :       \
> > > >                         x == OCXL_IOCTL_IRQ_FREE ? "IRQ_FREE"
> > > > :         \
> > > >                         x == OCXL_IOCTL_IRQ_SET_FD ?
> > > > "IRQ_SET_FD"
> > > > :     \
> > > > +                       x == OCXL_IOCTL_GET_METADATA ?
> > > > "GET_METADATA" : \
> > > >                         "UNKNOWN")
> > > > 
> > > >  static long afu_ioctl(struct file *file, unsigned int cmd,
> > > > @@ -157,6 +179,11 @@ static long afu_ioctl(struct file *file,
> > > > unsigned int cmd,
> > > >                                         irq_fd.eventfd);
> > > >                 break;
> > > > 
> > > > +       case OCXL_IOCTL_GET_METADATA:
> > > > +               rc = afu_ioctl_get_metadata(ctx,
> > > > +                               (struct ocxl_ioctl_get_metadata
> > > > __user *) args);
> > > > +               break;
> > > > +
> > > >         default:
> > > >                 rc = -EINVAL;
> > > >         }
> > > > diff --git a/include/uapi/misc/ocxl.h
> > > > b/include/uapi/misc/ocxl.h
> > > > index 4b0b0b756f3e..16e1f48ce280 100644
> > > > --- a/include/uapi/misc/ocxl.h
> > > > +++ b/include/uapi/misc/ocxl.h
> > > > @@ -32,6 +32,27 @@ struct ocxl_ioctl_attach {
> > > >         __u64 reserved3;
> > > >  };
> > > > 
> > > > +/*
> > > > + * Version contains the version of the struct.
> > > > + * Versions will always be backwards compatible, that is, new
> > > > versions will not
> > > > + * alter existing fields
> > > > + */
> > > > +struct ocxl_ioctl_get_metadata {
> > > 
> > > This sounds more like a function name, do we need it to be
> > > _get_metdata?
> > > 
> > 
> > It pretty much is a function, it returns to userspace metadata
> > about
> > the descriptor being operated on.
> > 
> 
> It has a verb indicating action

I misunderstood, I had named the struct to match the IOCTL, but that
isn't necessary. I'll update it in the next patch.

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
