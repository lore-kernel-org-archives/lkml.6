Return-Path: <konrad.wilk@oracle.com>
X-Google-Smtp-Source: AH8x2248ft75N73Eja4rH5pW9sTEZy3CFlCsy2LJ4pVR4Cfg+NmViCuXwRI7tStSYdQ05ozHc3Nn
ARC-Seal: i=1; a=rsa-sha256; t=1517604835; cv=none;
        d=google.com; s=arc-20160816;
        b=ZgCZ32bi3DALAslRUXv6ChstZCecMPgf7qrNIOTerwTbEQcth4tmJWy+WwLsViDPxu
         jdeVqVEMq0itgEMVANsrsmYOHaTdxwmliYbU4TQQGmUWrgklHrleDilLlNVK5Z8PVJon
         t7LbOuVaqMkDSg661xeX0vZ0lLXUYDdGs4HGU4W9ziuHmOWLXvjKGWxhTMbgvhgCtEjn
         v9wygTjhDSTWl3bKWOYnA/d0kgM3y0Ks0X01T8VdvId175ea8Dfg86QQ6vVWJJ/yUoRF
         dnaFCZIhJr/L3WYnaCGUcrbJ8YWWRZ+7+F3SMOsefD2TVGljZjPKOkNmSK2dkkLPMjyF
         usWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=98bDHMqy7sYQo5wgzCY+pd70UFknv/XEsVW90siC5vQ=;
        b=YcUkZBj+DRZ7Eegs7gWDzy6NPfSGJrZ0bfBpBK6MhXTZNRtj1Sig0b5r215VMumSx9
         lxHqsnQ6lxI3kj4dILIfNgqABzGQHu/+eawSYvj1u3QKFl649hM4BAEOhUoUdqQSFY16
         GXmHgteCWIomeChiXNpYO0kQm4u79P7r+GRUMVx6bcG/4VTsNTdkBIQgkJpNp8GFGrWS
         Hfv01+CvoXNPSqhg9SrA2ouub/Fv4CpZQXvgBV+vWViqfBYGNgDUfuu1CpsIEoku+Re/
         vytltebfJ6oDWVmcNKd8yKP8SLVaOGsii8mIIeO5FlxY3IlPgnIaGPkR84G2dnvp9WxP
         PDuw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=TJrcQWXX;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=TJrcQWXX;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Fri, 2 Feb 2018 15:52:20 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: KarimAllah Ahmed <karahmed@amazon.de>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 2/5] KVM: x86: Add IBPB support
Message-ID: <20180202205220.GA2516@char.us.oracle.com>
References: <1517522386-18410-1-git-send-email-karahmed@amazon.de>
 <1517522386-18410-3-git-send-email-karahmed@amazon.de>
 <20180202174932.GR28192@char.us.oracle.com>
 <1517594544.31953.62.camel@infradead.org>
 <20180202195601.GD28192@char.us.oracle.com>
 <1517602575.31953.74.camel@infradead.org>
 <20180202202857.GI28192@char.us.oracle.com>
 <1517603487.31953.76.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1517603487.31953.76.camel@infradead.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8793 signatures=668661
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=631
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020251
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591237582659331850?=
X-GMAIL-MSGID: =?utf-8?q?1591324007588609814?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 02, 2018 at 08:31:27PM +0000, David Woodhouse wrote:
> On Fri, 2018-02-02 at 15:28 -0500, Konrad Rzeszutek Wilk wrote:
> >=20
> > >=A0
> > > No. The AMD feature bits give us more fine-grained support for expo=
sing
> > > IBPB or IBRS alone, so we expose those bits on Intel too.
> >=20
> > But but.. that runs smack against the idea of exposing a platform tha=
t
> > is as close to emulating the real hardware as possible.
> >=20
> > As in I would never expect an Intel CPU to expose the IBPB on the 0x8=
000_0008
> > leaf. Hence KVM (nor any hypervisor) should not do it either.
> >=20
> > Unless Intel is doing it? Did I miss a new spec update?
>=20
> Are you telling me there's no way you can infer from CPUID that you're
> running in a hypervisor?

That is not what I am saying. The CPUIDs 0x40000000 ... 0x400000ff
are reserved for hypervisor usage. The SDM is pretty clear about it.

The Intel SDM and the AMD equivalant are pretty clear about what the
other leafs should have on its platform.

[5 minutes later]

And I am eating my words here.=20

CPUID.80000008 shows how MAXPHYSADDR is used (on the Intel SDM).

Never mind the noise.
