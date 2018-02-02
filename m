Return-Path: <konrad.wilk@oracle.com>
X-Google-Smtp-Source: AH8x224ryUd3c4lQcB9KZzZdKy6X0pWEmcFJcoDN71uDsc1dyk8nZQrlY1M06aANNvsDlVAo+rvx
ARC-Seal: i=1; a=rsa-sha256; t=1517595592; cv=none;
        d=google.com; s=arc-20160816;
        b=Wt50hLkQLfJB9HIJCA6Qc8r6JLVIzysxihw14pxpcT605Zt/5RlScduaT5YPMaGq/5
         YguWjisHzAzKpNqdmWy29vVyCg4kYaLu96OjJSWVwtJGUPUWgHlHJ1oVWjItMYWVwlvt
         DlnQlxO49zdSgIwqZH61CwBwVNtNUJ6CNxxv25Gc0RtGf4WIbz+RWfjVOASAvTgL4dOY
         E7v7qssKH53oeuO9DGmaxZrOhh9btqeObD0GtUqyCV1PO6tENrmXSIrSKb6SaCHvM7B0
         Zef1SWLlu17G32MgZEl87wJ1ynibpSVhR3LqUQ1cl4jPM46ELjbEE90lQCVdXYPmZJDH
         TYWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=8IazUTclngecnvMPuhbu4GHq+7GoJLuuSQr/djoJI6U=;
        b=fzbae7h68xm1j385pw1zKjsSvghAbaj4QW6aOekjXnkfGr5kvFlvKoBliP+uB1nhc8
         /u0O3cefz2inAFxa0Au9DDtCNZRik5SImmBnJrgq7Z7JI+kc8z1wlH9uPPQTzR1t1rwY
         D/mhT8W255S2djWWpmYnaWvOt9DTh2/O81JVHX6vnvXXiCDl8hOo8GbjNH3zJkH+E1as
         q9e91WfnHaS8cfj91pJZV+mUD+v5DydLgVG3cZTrXl21Ux4Jpt3ErDjqUT53lr7pFEOO
         wDjk3u+U22wru2H6zYzzMQkrh3aO4iN9YTlcsmLmpBvGAHjl7ZNMSMJxf5EBcUBTWi8r
         FUdA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=pG+nMA3w;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=pG+nMA3w;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Fri, 2 Feb 2018 13:19:21 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: KarimAllah Ahmed <karahmed@amazon.de>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v6 4/5] KVM: VMX: Allow direct access to
 MSR_IA32_SPEC_CTRL
Message-ID: <20180202181921.GV28192@char.us.oracle.com>
References: <1517522386-18410-1-git-send-email-karahmed@amazon.de>
 <1517522386-18410-5-git-send-email-karahmed@amazon.de>
 <20180202175352.GT28192@char.us.oracle.com>
 <1517594754.31953.65.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1517594754.31953.65.camel@infradead.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8793 signatures=668661
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020222
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591237580461918240?=
X-GMAIL-MSGID: =?utf-8?q?1591314316697709133?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 02, 2018 at 06:05:54PM +0000, David Woodhouse wrote:
> On Fri, 2018-02-02 at 12:53 -0500, Konrad Rzeszutek Wilk wrote:
> > .snip..
> > >=20
> > > @@ -1913,6 +1914,29 @@ static void update_exception_bitmap(struct
> > > kvm_vcpu *vcpu)
> > > =A0}
> > > =A0
> > > =A0/*
> > > + * Check if MSR is intercepted for currently loaded MSR bitmap.
> > > + */
> > > +static bool msr_write_intercepted(struct kvm_vcpu *vcpu, u32 msr)
> > > +{
> > > +	unsigned long *msr_bitmap;
> > > +	int f =3D sizeof(unsigned long);
> >
> > unsigned int
>=20
> $ grep -n 'f =3D sizeof' vmx.c
> 1934:	int f =3D sizeof(unsigned long);
> 5013:	int f =3D sizeof(unsigned long);
> 5048:	int f =3D sizeof(unsigned long);
> 5097:	int f =3D sizeof(unsigned long);
>=20
> It sucks enough that we're doing this stuff repeatedly, and it's a
> prime candidate for cleaning up, but I wasn't going to send Karim off
> to bikeshed that today. Let's at least keep it consistent.

Sure.
