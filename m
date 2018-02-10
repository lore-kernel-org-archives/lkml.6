Return-Path: <David.Laight@aculab.com>
X-Google-Smtp-Source: AH8x225bEzi8dipOPGNAClOJF0I8gbsW7/Gh9uuLy+lnOsopzUDjmSyibcG9u9BGRp32wqVWdgKD
ARC-Seal: i=1; a=rsa-sha256; t=1518277246; cv=none;
        d=google.com; s=arc-20160816;
        b=zFDSdGkFmf7UqvnV/z186QnoB2OhcWBa/aoCblFBBh2/gTLTl6dqLyOScRmMCNmae/
         hkHbKZzRTesD54d5zRsCnrPKK4lsN+gHoyzS5SomQv5oR7944PWw5WV+wBE0qUXTpHvF
         iO3yAR9C88oCP85xdSThVPSvBKX+1r7XKMrqkat3hE3BZ1x9YnOfStBChz6DxziFMChy
         z4YZ7D0DZEVCSygeG8EkNjqAAV5TsjBcSPKmaCuTeaQi23JE6r5eZjavm1KcbSyCZRBD
         f8EHWv8DvGgsYZV9JUM5DLmOsMyDqGcC/WmgJR81ecFbcWcEzv+49c8dGtb4DcegoA31
         Qg2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=e09b1B+qXSR7Oa7jGfXTEWPPIXHwAyBXCWHu4wKqllE=;
        b=UMC+z9Mo91a5L/sDVB3In1I6GCp0AEKGSiAGelwyNk7USpN4Of5oxbMrjbug5jlfQf
         Lt6SKR8kqKXosL4MolWqHD0EvnopOh5EaZlOxcc+oTtmxY0vPxdNybOmMc5jl1TZVpX1
         k+nDF2WRMjTHE48k4sHnMrYzwP0xJapeb/qK9vRdPvdbIh5+FoHO62uFdEapSoGVvu15
         KPjE7kTOFb3vYvRGzM0gHyWwtfj53sxlPZTeE0uPDgHMG4LXNWB1l1GTPkLGyUwtX+aN
         y3aQCAlh1/H25CdW4OrtxlNs1NwBMS8yAg8EmEEidj/zu9aAjuJJJNeb4eL3IwtqRqKa
         EQfg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of david.laight@aculab.com designates 192.162.216.184 as permitted sender) smtp.mailfrom=David.Laight@aculab.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of david.laight@aculab.com designates 192.162.216.184 as permitted sender) smtp.mailfrom=David.Laight@aculab.com
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, Joerg Roedel
	<jroedel@suse.de>
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
	<keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>, Waiman Long
	<llong@redhat.com>, Pavel Machek <pavel@ucw.cz>
Subject: RE: [PATCH 09/31] x86/entry/32: Leave the kernel via trampoline stack
Thread-Topic: [PATCH 09/31] x86/entry/32: Leave the kernel via trampoline
 stack
Thread-Index: AQHTod8GduOBYzH6Y06ZOLi7EtO7oqOdxTWQ
Date: Sat, 10 Feb 2018 15:41:06 +0000
Message-ID: <aca58942b1424f83a0673318dc42c1f8@AcuMS.aculab.com>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <1518168340-9392-10-git-send-email-joro@8bytes.org>
 <CA+55aFzB9H=RT6YB3onZCephZMs9ccz4aJ_jcPcfEkKJD_YDCQ@mail.gmail.com>
 <20180209190226.lqh6twf7thfg52cq@suse.de>
 <CA+55aFzy6ZJDUpgHY0J2_z4kODaiYPgyHuOsMGiXmrhgR3kyPQ@mail.gmail.com>
 <20180209192515.qvvixkn5rz77oz6l@suse.de>
 <CA+55aFw643jQxVDrm05ZJ6YkVdqBBJ8WH-+=QCx3SDXrVN-TxA@mail.gmail.com>
In-Reply-To: <CA+55aFw643jQxVDrm05ZJ6YkVdqBBJ8WH-+=QCx3SDXrVN-TxA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
X-GMAIL-THRID: =?utf-8?q?1591914904027044040?=
X-GMAIL-MSGID: =?utf-8?q?1592029081864107067?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDkgRmVicnVhcnkgMjAxOCAxOTo0OQ0KLi4u
DQo+IEkgdGhpbmsgdGhlIGluc3RydWN0aW9uIHNjaGVkdWxpbmcgZW5kcyB1cCBiYXNpY2FsbHkg
YnJlYWtpbmcgYXJvdW5kDQo+IG1pY3JvY29kZWQgaW5zdHJ1Y3Rpb25zLCB3aGljaCBpcyB3aHkg
eW91J2xsIGdldCBzb21ldGhpbmcgbGlrZSAxMituDQo+IGN5Y2xlcyBmb3IgInJlcCBtb3ZzIiBv
biBzb21lIHVhcmNocywgYnV0IGF0IHRoYXQgcG9pbnQgaXQncyBwcm9iYWJseQ0KPiBtb3N0bHkg
aW4gdGhlIG5vaXNlIGNvbXBhcmVkIHRvIGFsbCB0aGUgb3RoZXIgbmFzdHkgUFRJIHRoaW5ncy4N
Cg0KT3IgNDgrbiBvbiBQNA0KDQo+IFlvdSB3b24ndCBzZWUgYW55IG9mIHRoZSBfcmVhbF8gYWR2
YW50YWdlcyAod2hpY2ggYXJlIGFib3V0IG1vdmluZw0KPiBjYWNoZWxpbmVzIGF0IGEgdGltZSks
IHNvIHdpdGggc21hbGxpc2ggY29waWVzIHlvdSByZWFsbHkgb25seSBzZWUgdGhlDQo+IGRvd25z
aWRlcyBvZiAicmVwIG1vdnMiLCB3aGljaCBpcyBtYWlubHkgdGhhdCBpbnN0cnVjdGlvbiBzY2hl
ZHVsaW5nDQo+IGhpY2t1cCB3aXRoIGFueSBtaW9jcm9jb2RlLg0KDQpJIHRob3VnaHQgdGhhdCB0
aGUgaGFyZHdhcmUgb3B0aW1pc2F0aW9uIGZvciAncmVwIG1vdnNiJyBvbiByZWNlbnQNCkludGVs
IGNwdXMgZ2VuZXJhdGVkIHdvcmQgc2l6ZWQgbWVtb3J5IGFjY2Vzc2VzIGV2ZW4gZm9yIG1pc2Fs
aWduZWQNCnNob3J0IHRyYW5zZmVycy4NCk15IHRob3VnaHRzIHdlcmUgdGhhdCB0aGV5J2QgaW1w
bGVtZW50ZWQgYSBjYWNoZSBsaW5lIHNpemVkIGJhcnJlbA0Kc2hpZnQgcmVnaXN0ZXIuDQpJZiB0
aGF0IGlzbid0IHRydWUgdGhlbiB1c2luZyBpdCBmb3IgYWxsIG1lbWNweSgpIGlzIHByb2JhYmx5
IHN0dXBpZA0KKGJ1dCBub3QgYXMgc3R1cGlkIGFzIGRvaW5nIGFsbCBtZW1jcHkgYmFja3dhcmRz
ISkNCg0KCURhdmlkDQoNCg0K
