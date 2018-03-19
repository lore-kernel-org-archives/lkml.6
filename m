Return-Path: <kernel-hardening-return-12700-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtkPAaRJP02pUdTXnc10ULZjHItFurs3SzAz3d7nSF6Gh8fo3DfNIk+e7IEDHiGOxpTvrLI
ARC-Seal: i=1; a=rsa-sha256; t=1521452561; cv=none;
        d=google.com; s=arc-20160816;
        b=nfaexcVL/ruGDK0+5SSjogSpmPyl7BSGHDgHZ/W7jDxCUSdTZG9sA0/qU9LEfUbTOL
         aNdouC/og8EnWbJsVhmHxJ/rmcVyiM6lTgojuL2V7wIhZEWet2nfFhYzprZ0VWBo2od/
         YuRBTSCBdnkDVR5L8dlP6rr+13sjqj+XjEhF8YB4dA8nc+m2ys22GAd1u7pb2Gj0hhBs
         4ll08NHjZvbzFq0qBOLtehYXvGORp6dJw/uy6bD3B/RomHs64qrh1BHlGGLI8hyQ3eLZ
         LOw+L6utcHjR88JNyDLgrp62r+AhI0GsWMJDM+RAcdN4RBZUo+1ItaXhSyhREVAQkTeh
         9Gmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=+6dyHJNX8duF8L29LpH89GOIL3RkC7UsM8C+s+0bHXQ=;
        b=DillI3p4LxYFrqC857KDer6Boc/DzA7/rX4BWgd2bcyUc5upVrhb7Cfn+q7NEry8Gu
         DM7hUduxcd7FQGqsDt297qJ/+Xajmi0S3QfR1059DYnRVqujKlOn7U0y2EpO56+vcHMM
         nhtHtHsFawc4s9q7IgFzclSed5a43WK+SnisECwIYvRVnuT3KbTLj7/nQ0Om9WuUYyZ1
         heW9YXSJswBqGps2s7z9FxlEzHPglz/qnu0KjaYsWhr22r3wlWssOEwa4mTimMLCdIF/
         W3m/b81E8PVL2QuR6NG6g16k0UzRdJUNzGCaTHGVd4aE6fKAD0A8SkMJw+m8g19lnEru
         UhGA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12700-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12700-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12700-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12700-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>
CC: Kees Cook <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Florian Weimer <fweimer@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, "Randy
 Dunlap" <rdunlap@infradead.org>, Miguel Ojeda
	<miguel.ojeda.sandonis@gmail.com>, Ingo Molnar <mingo@kernel.org>, Ian Abbott
	<abbotti@mev.co.uk>, linux-input <linux-input@vger.kernel.org>, linux-btrfs
	<linux-btrfs@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kernel Hardening
	<kernel-hardening@lists.openwall.com>
Subject: RE: [PATCH v5 0/2] Remove false-positive VLAs when using max()
Thread-Topic: [PATCH v5 0/2] Remove false-positive VLAs when using max()
Thread-Index: AQHTvxHmcPC61AQThUukKjo0dmw4m6PXTV6g
Date: Mon, 19 Mar 2018 09:43:13 +0000
Message-ID: <0e94e9582bec4373b5e21c612be179ac@AcuMS.aculab.com>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
 <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com>
 <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
 <20180316175502.GE30522@ZenIV.linux.org.uk>
 <CA+55aFzsrVF7W+YQye=EeF4Wk3yDOTbb_vSiM8s1zkKbE4JV4Q@mail.gmail.com>
 <CAGXu5jJmAAgaq3VCsUN2yjpHLSc7P-kNrM_4c4cqP=ysFcETXA@mail.gmail.com>
 <CA+55aFwv0VC67cx2W9yrf7qSFKf6ncVRrsVyLGqdmfSBn4yTYw@mail.gmail.com>
 <42b4342b-aefc-a16a-0d43-9f9c0d63ba7a@rasmusvillemoes.dk>
 <CA+55aFwFoTapX2niPiaET5kg7K85qxhav1_PoDDxY0o_VRA5Ag@mail.gmail.com>
 <38b6da49-1138-017e-7307-f39ff067d6d2@rasmusvillemoes.dk>
 <CA+55aFw0WC+S3TTE6x_vkLbRV6YLeR4-1S9LsBXhE+E2KZqBuA@mail.gmail.com>
In-Reply-To: <CA+55aFw0WC+S3TTE6x_vkLbRV6YLeR4-1S9LsBXhE+E2KZqBuA@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1595358640609165102?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogbGludXM5NzFAZ21haWwuY29tIFttYWlsdG86bGludXM5NzFAZ21haWwuY29tXSBPbiBC
ZWhhbGYgT2YgTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTggTWFyY2ggMjAxOCAyMzozNg0KLi4u
DQo+IA0KPiBZZWFoLCBhbmQgc2luY2Ugd2UncmUgaW4gdGhlIHNpdHVhdGlvbiB0aGF0ICpuZXcq
IGdjYyB2ZXJzaW9ucyB3b3JrDQo+IGZvciB1cyBhbnl3YXksIGFuZCB3ZSBvbmx5IGhhdmUgaXNz
dWVzIHdpdGggb2xkZXIgZ2NjJ3MgKHRoYXQgc2FkbHkNCj4gcGVvcGxlIHN0aWxsIHVzZSksIGV2
ZW4gaWYgdGhlcmUgd2FzIGEgbmV3IGNvb2wgZmVhdHVyZSB3ZSBjb3VsZG4ndA0KPiB1c2UgaXQu
DQoNCklzIGl0IG5lY2Vzc2FyeSB0byBoYXZlIHRoZSBmdWxsIGNoZWNrcyBmb3Igb2xkIHZlcnNp
b25zIG9mIGdjYz8NCg0KRXZlbiAtV3ZsYSBjb3VsZCBiZSBwcmVkaWNhdGVkIG9uIHZlcnkgcmVj
ZW50IGdjYyAtIHNpbmNlIHdlIGFyZW4ndA0Kd29ycmllZCBhYm91dCB3aGV0aGVyIGdjYyBkZWNp
ZGVzIHRvIGdlbmVyYXRlIGEgdmxhLCBidXQgd2hldGhlcg0KdGhlIHNvdXJjZSByZXF1ZXN0cyBv
bmUuDQoNCglEYXZpZA0KDQo=
