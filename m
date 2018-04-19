Return-Path: <David.Laight@aculab.com>
X-Google-Smtp-Source: AIpwx48aRYrrH+zORGHJ/RhD0VTbSrCb5WT6kHeWGe3wDPJRxbaV29VRG1NmEA95XsAzc63A8yWJ
ARC-Seal: i=1; a=rsa-sha256; t=1524128452; cv=none;
        d=google.com; s=arc-20160816;
        b=Natsfd1S+ndBSewCLPSJFUORcM/6eWQVnP8ErIOn97E4jhZeGGdKe+B8uId3bfogxv
         V4j35VpqDCqlWDwIzemPvc8NVnzWlIA1mWAP4Z0OJozlUKzhlH1W184Ukhv0XIIhpuLy
         ZIU4wlNjbucvXhKM7wVc62s+r56ffhaSqZI8ArlhUa/It7LmEO7G0t+xV1ZocRDFjvcd
         RZ4Jd3o47srnlYCk3Oh3X7HBebthLsSIallHczIJs6zLxDHKLDvXsCxtJLf4rf4t9cje
         s5P75VZ3zg46t9tQtHyZWzdR8IWsoLXoiAl0FDQzKFAxNQgLMf0QcJBjGFtxeGi2GYoD
         ZxDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=ZWwtkNhdtYhWo3F+zJmnFdY0lJkWmdh6EkpssWMTPmE=;
        b=U9ulNB5ZAmNtCuoOq18iSK6TEUdH7LgxQN/jOHmIr7HjPFezL8SM+YlbBK4he+Q4Rc
         izvIAk0zX0OGur8t5xviJlOvzGXQVegfd5awG0SsslU8gBc8AQMnFpau13KQVWsEA0LF
         nUz1AJHyiouy3UyDC0F0DsQc5BERDeU64mx8mZD1BUCqswFG0nBKNa1px/pnwTJHJ49e
         oSmvwGcDeQ/wif4wXNm3irAnqSsHfcGvGCj4JtRY8Cmog/Wk0nygSQ0t0qGxTho0AUSq
         uR/0K9faB318LNg3WTVA+b9abHDtxV4u+zE9C9KJk4MzEfJOFNXBi3DzNoN/eK/eSMi1
         qTHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of david.laight@aculab.com designates 192.162.217.194 as permitted sender) smtp.mailfrom=David.Laight@aculab.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of david.laight@aculab.com designates 192.162.217.194 as permitted sender) smtp.mailfrom=David.Laight@aculab.com
From: David Laight <David.Laight@ACULAB.COM>
To: 'Andi Kleen' <ak@linux.intel.com>, Linus Torvalds
	<torvalds@linux-foundation.org>
CC: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>,
	"Ingo Molnar" <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, "the
 arch/x86 maintainers" <x86@kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "Andy
 Lutomirski" <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>, "Josh
 Poimboeuf" <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Jiri Kosina
	<jkosina@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brian Gerst
	<brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, Eduardo Valentin
	<eduval@amazon.com>, Greg KH <gregkh@linuxfoundation.org>, Will Deacon
	<will.deacon@arm.com>, "Liguori, Anthony" <aliguori@amazon.com>, Daniel Gruss
	<daniel.gruss@iaik.tugraz.at>, Hugh Dickins <hughd@google.com>, Kees Cook
	<keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>,
	"Waim@linux.intel.com" <Waim@linux.intel.com>
Subject: RE: [PATCH 03/35] x86/entry/32: Load task stack from x86_tss.sp1 in
 SYSENTER handler
Thread-Topic: [PATCH 03/35] x86/entry/32: Load task stack from x86_tss.sp1 in
 SYSENTER handler
Thread-Index: AQHT13bnKx+NN3fDIEG3+xsazjALzqQHym9Q
Date: Thu, 19 Apr 2018 09:01:12 +0000
Message-ID: <15c09c5a13d244ba8ad3f69ee0a24657@AcuMS.aculab.com>
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
 <1523892323-14741-4-git-send-email-joro@8bytes.org>
 <87k1t4t7tw.fsf@linux.intel.com>
 <CA+55aFxKzsPQW4S4esvJY=wb7D3LKBdDDcXoMKJSqcOgnD3FuA@mail.gmail.com>
 <20180419003833.GO6694@tassilo.jf.intel.com>
In-Reply-To: <20180419003833.GO6694@tassilo.jf.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916934570630846?=
X-GMAIL-MSGID: =?utf-8?q?1598164515882745590?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andi Kleen
> Sent: 19 April 2018 01:39
>=20
> On Wed, Apr 18, 2018 at 05:02:02PM -0700, Linus Torvalds wrote:
> > On Wed, Apr 18, 2018 at 4:26 PM, Andi Kleen <ak@linux.intel.com> wrote:
> > >
> > > Seems like a hack. Why can't that be stored in a per cpu variable?
> >
> > It *is* a percpu variable - the whole x86_tss structure is percpu.
> >
> > I guess it could be a different (separate) percpu variable, but might
> > as well use the space we already have allocated.
>=20
> Would be better/cleaner to use a separate variable instead of reusing
> x86 structures like this. Who knows what subtle side effects that
> may have eventually.
>=20
> It will be also easier to understand in the code.

You could (probably) use an unnamed union in the x86_tss structure
so that it is more obvious that the two variables share a location.

	David
