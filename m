Return-Path: <konrad.wilk@oracle.com>
X-Google-Smtp-Source: AH8x227UTwG5m188KF1IxPvaSzkryRI7rVJrx89NX0q0B+IZvDHMEZT+qNgOeOZPbnrjNESkTcxu
ARC-Seal: i=1; a=rsa-sha256; t=1517603428; cv=none;
        d=google.com; s=arc-20160816;
        b=oMXaguET99fU0bSl0DaKN39ZCAcLPcLMOHeqs8rLHbOzGm7LtPc8iICGbuvpLvQ7N0
         1Rv1B5FAyjmgyHFSGAUoQZstEdayNXA8xn8Dg28jffPs/yTpnf0WnCBOclFa0k2eIPjC
         LDbPiMUuEwAa0bvXOWiCGEkp4hC9OflnKwXCB88BhllDl9INarxmEHRcCKC3QKK7umcJ
         x0aEMkBH0eegsxQOgdr6or/WqOCPPx62sNDdnUKNXfyC8bgnpiGCkRKh2pGewe4O0lg0
         UYatczvhRUZF7bSmBWKWwWTKh7oQgIa+L26u1ZqOxA1hdgEJ12t/vhasAJjh9wDRiZsS
         g8vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=6zuCK6GTuungBvTZDOI6FgEYKui63UmKhgQlU+QNjaA=;
        b=i0j5JfKihCP2rm65gZwaqDHRjF6BT3RQrtZ0AwZPST/2pyrtafvmAhmJz4+FtAfiTf
         h1K4fIVIkRr90k2uV+OihJrDrM/q1S18qqv5PzGUZyBPyoUh12PGyaP6eaOQzA7jG+G2
         nypNLXjfauv9dXcAlwlrXPWBWZyNCYHiFpUW4m/H9AGjWGldGDvc9SuWtXFhdnxJ0BL/
         /xTE7VLyiczaEfvWI/o9/TrcSuxFyb0SxYKc03jwpazdtjyfbDn0hGWzzbYoWdnIRmen
         bCZSCMmRNU1nicHdX1sxS2RRXx6lycKw/cUZ1xsIZE3xyQtdwIEDz5BmbBSWNQAGbiRR
         ngHg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=OrqXwhQh;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=OrqXwhQh;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Fri, 2 Feb 2018 15:28:57 -0500
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
Message-ID: <20180202202857.GI28192@char.us.oracle.com>
References: <1517522386-18410-1-git-send-email-karahmed@amazon.de>
 <1517522386-18410-3-git-send-email-karahmed@amazon.de>
 <20180202174932.GR28192@char.us.oracle.com>
 <1517594544.31953.62.camel@infradead.org>
 <20180202195601.GD28192@char.us.oracle.com>
 <1517602575.31953.74.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1517602575.31953.74.camel@infradead.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8793 signatures=668661
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020245
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591237582659331850?=
X-GMAIL-MSGID: =?utf-8?q?1591322532471822332?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 02, 2018 at 08:16:15PM +0000, David Woodhouse wrote:
>=20
>=20
> On Fri, 2018-02-02 at 14:56 -0500, Konrad Rzeszutek Wilk wrote:
> > On Fri, Feb 02, 2018 at 06:02:24PM +0000, David Woodhouse wrote:
> > >=20
> > > On Fri, 2018-02-02 at 12:49 -0500, Konrad Rzeszutek Wilk wrote:
> > > >=20
> > > > >=20
> > > > > @@ -625,7 +629,12 @@ static inline int __do_cpuid_ent(struct
> > > > > kvm_cpuid_entry2 *entry, u32 function,
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!g_phys_=
as)
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0g_phys_as =3D phys_as;
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0entry->eax =3D=
 g_phys_as | (virt_as << 8);
> > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0entry->ebx =3D en=
try->edx =3D 0;
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0entry->edx =3D 0;
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* IBPB isn't nec=
essarily present in hardware cpuid>=A0=A0*/
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (boot_cpu_has(=
X86_FEATURE_IBPB))
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0entry->ebx |=3D F(IBPB);
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0entry->ebx &=3D k=
vm_cpuid_8000_0008_ebx_x86_features;
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0cpuid_mask(&entry=
->ebx, CPUID_8000_0008_EBX);
> > > > It is with x86/pti nowadays. I think you can remove that comment.
> > > In this code we use the actual CPUID instruction, then filter stuff=
 out
> > > of it (with &=3D kvm_cpuid_XXX_x86_features and then cpuid_mask() t=
o turn
> > > off any bits which were otherwise present in the hardware and *woul=
d*
> > > have been supported by KVM, but which the kernel has decided to pre=
tend
> > > are not present.
> > >=20
> > > Nothing would *set* the IBPB bit though, since that's a "virtual" b=
it
> > > on Intel hardware. The comment explains why we have that |=3D F(IBP=
B),
> > > and if the comment wasn't true, we wouldn't need that code either.
> >
> > But this seems wrong. That is on Intel CPUs we will advertise on
> > AMD leaf that the IBPB feature is available.
> >=20
> > Shouldn't we just check to see if the machine is AMD before advertisi=
ng
> > this bit?
>=20
> No. The AMD feature bits give us more fine-grained support for exposing
> IBPB or IBRS alone, so we expose those bits on Intel too.

But but.. that runs smack against the idea of exposing a platform that
is as close to emulating the real hardware as possible.

As in I would never expect an Intel CPU to expose the IBPB on the 0x8000_=
0008
leaf. Hence KVM (nor any hypervisor) should not do it either.

Unless Intel is doing it? Did I miss a new spec update?
