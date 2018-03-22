Return-Path: <kernel-hardening-return-12719-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvqZnSZ77jjc/s8J98XdMXZXkeziLU4G1NyOvU908xI1Y6ZPVd/R2JiVqPyfQR/vZGAN43+
ARC-Seal: i=1; a=rsa-sha256; t=1521731561; cv=none;
        d=google.com; s=arc-20160816;
        b=vv9TfbzLtvhrJByzSFCkbTPSbIm/MIkr0crVLElt/YXPxbgFL2v1SzN4o+f0082kzC
         qJPDYX4bY53YX3foU5HTC64gjmo2D9qWrlAcrBN0Qst5S3zfps+XOYcjQFw4L6KvcTQb
         C4J/Hv5pOquoueAOn0d3uf43gZ3Ptf6vXeavWPITh/sClMGmKGbLxW1ZJOweAdvMgZUM
         K2L4wwkBdPTq88h2UeZRrwZSAVHEdWopNa8Ifw8fX8caC3F9GhuqYKcnowEXmzFO6f4Q
         FANr1CeZVQtbddIrY8c3vuZHHq+ypxSbfzuaXBlWgbRYxSuKLsNzF5TyKyw0Z4qLPUwC
         Mfwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=8Y4RTkoJdTHjN3/VPPN9fT+cCA5F9CJ0IF6WB8NHEqk=;
        b=sg6gYFYHvOByq1kb3ESCE++2S4PNSeb5gJFLBdsIXLYRHHoE85TyBrSbv2U950TBJQ
         /f24WcMmU19IimCAAAqwL9J2iR52KbGRZfl1lj8srqh5dr0lIiQGleFctquZSGNxhN06
         RwsGFCeCR55KACCZdMCu57ZdizGZXY/oiovf8Bdoc2ro1MtTZ65OmMpzg+Am+aKG8XlD
         9WsqQkMN/Znzv/odDUx+ZfWNwJyFdSdRrla5bXOwzPh3NpJhEpSmmGDIQmXzn7dH3ceG
         ic+sxdmUOgw4dvL5E7TOlLayfQLtYZObrmEUMw0AXnAG29qbyHnEqfPfOOsfEXszOFzT
         zArw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12719-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12719-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12719-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12719-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Kees Cook' <keescook@chromium.org>, Linus Torvalds
	<torvalds@linux-foundation.org>
CC: Al Viro <viro@zeniv.linux.org.uk>, Florian Weimer <fweimer@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf
	<jpoimboe@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Randy
 Dunlap" <rdunlap@infradead.org>, Miguel Ojeda
	<miguel.ojeda.sandonis@gmail.com>, Ingo Molnar <mingo@kernel.org>, Ian Abbott
	<abbotti@mev.co.uk>, linux-input <linux-input@vger.kernel.org>, linux-btrfs
	<linux-btrfs@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kernel Hardening
	<kernel-hardening@lists.openwall.com>
Subject: RE: [PATCH v5 0/2] Remove false-positive VLAs when using max()
Thread-Topic: [PATCH v5 0/2] Remove false-positive VLAs when using max()
Thread-Index: AQHTwe7PnYpqRiT7c0Sbu9fUunNPkKPcXEUA
Date: Thu, 22 Mar 2018 15:13:10 +0000
Message-ID: <6057c50c19d94174814e90503caa0aa5@AcuMS.aculab.com>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
 <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com>
 <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
 <20180316175502.GE30522@ZenIV.linux.org.uk>
 <CA+55aFzsrVF7W+YQye=EeF4Wk3yDOTbb_vSiM8s1zkKbE4JV4Q@mail.gmail.com>
 <CAGXu5jJmAAgaq3VCsUN2yjpHLSc7P-kNrM_4c4cqP=ysFcETXA@mail.gmail.com>
 <CA+55aFwv0VC67cx2W9yrf7qSFKf6ncVRrsVyLGqdmfSBn4yTYw@mail.gmail.com>
 <CAGXu5jJ=ZYpf=30H6hsWn-R-CEVYAgVMHxjmoLUC00QYq0r17g@mail.gmail.com>
 <CA+55aFwxk=tUECYQkd4cog08qW4ZT=r2K7FQXzGnc-zuMc7JQA@mail.gmail.com>
 <CAGXu5j+5i+56R0KDLMDA=+_DRW5w9aUGCEo0dq6PZvHPBWkM1g@mail.gmail.com>
In-Reply-To: <CAGXu5j+5i+56R0KDLMDA=+_DRW5w9aUGCEo0dq6PZvHPBWkM1g@mail.gmail.com>
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
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595651194296883529?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogS2VlcyBDb29rDQo+IFNlbnQ6IDIyIE1hcmNoIDIwMTggMTU6MDENCi4uLg0KPiA+ICAg
LyogR2xvcnkgdG8gTWFydGluIFVlY2tlciA8TWFydGluLlVlY2tlckBtZWQudW5pLWdvZXR0aW5n
ZW4uZGU+ICovDQo+ID4gICAjZGVmaW5lIF9faXNfY29uc3RhbnQoYSkgXA0KPiA+ICAgICAgICAg
KHNpemVvZihpbnQpID09IHNpemVvZigqKDEgPyAoKHZvaWQqKSgoYSkgKiAwbCkpIDogKGludCop
MSkpKQ0KLi4uDQo+IFNvLCB0aGlzIHRpbWUgaXQncyBub3QgYSBjYXRhc3Ryb3BoaWMgZmFpbHVy
ZSB3aXRoIGdjYyA0LjQuIEluc3RlYWQgaXQNCj4gZmFpbHMgaW4gMTEgZGlzdGluY3QgcGxhY2Vz
Og0KLi4uDQo+IFNlZW1zIGxpa2UgaXQgZG9lc24ndCBsaWtlIHZvaWQgKiBhcmd1bWVudHM6DQo+
IA0KPiBtbS9wZXJjcHUuYzoNCj4gICAgICAgICAgICAgICAgIHZvaWQgKnB0cjsNCj4gLi4uDQo+
ICAgICAgICAgICAgICAgICBiYXNlID0gbWluKHB0ciwgYmFzZSk7DQoNClRyeSBhZGRpbmcgKHVu
c2lnbmVkIGxvbmcpIGJlZm9yZSB0aGUgKGEpLg0KDQoJRGF2aWQNCg0K
