Return-Path: <kernel-hardening-return-12582-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvsPLe897jxJOzw0nTdNaMp6Ai5DzALkFjaZ4iAAECeX5Lk6mohKHGYDeL0jgpK64Tp6Myz
ARC-Seal: i=1; a=rsa-sha256; t=1521026641; cv=none;
        d=google.com; s=arc-20160816;
        b=KLyBEo1htuRuFvNmlF6rSAXofwrcM+oLJp6EdyJPpI5+WUTgvkNkXUeV3Uhhgyq4gH
         ZwTS3+nH848lwr2lCNQfmObFEB/MKfTi1mSw8ame0Jx61IbLcB1SPY1dKOGZNJqb2Zrb
         HceI2vl+B27Mud2TG3X1qCNvYRsQGEcHhJhxSyCTh2Xx8DxJwncbfzrZyTtH2Ebfi9ap
         yM+FuifKS0LO4TkoxU+gt4hY+YT6+m89qp89CMN1YWF4CZCTqn5qQ73+dFCpJjndxgVA
         ZpMOgKEGK1PxjwLsiVOPgfXoR5kWD33fhSnBGOKNnqA/MaBQcGqIXME/ywodq7c+8MKn
         WiRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=PJWU5YhdLq1ZH08mrf2T/GmgCgBIpqSiHNII/4hAPaI=;
        b=YjiJ4BNMxtt8fwfYyUPP3vGnVlvRUP0k8MOIiBEsHBcP1ldE9BRZdcQjamzALdpCk0
         7ZGemfc+a9DEg9s1OQ19KaJzD9h3cw1aqkewht3IJijPaSXIXQwwqM6fBYE1K6zOnlyj
         GGC3KL4W/Nl6c12/GfYpM+W/rptAx3ecxT7SYYKwXdZ+h7hwO7S52DvAbUazMaDsfmaB
         4IjDvuZw87ml83Cn6ASBrj/+kOytpF2xmhlNn+m/KxH6R/5MtKlVqUMHjEjGFNiPX2aV
         tI2euLgcCMNv5q/+gn7hiPN2DmQahq7LAS80uveUZQoGirb2Fqh8yEtuoKTsqQ4ZoTPn
         KcKg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12582-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12582-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12582-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12582-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Salvatore Mesoraca' <s.mesoraca16@gmail.com>, Vivien Didelot
	<vivien.didelot@savoirfairelinux.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kernel
 Hardening" <kernel-hardening@lists.openwall.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Andrew
 Lunn" <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Kees Cook
	<keescook@chromium.org>
Subject: RE: [PATCH] net: dsa: drop some VLAs in switch.c
Thread-Topic: [PATCH] net: dsa: drop some VLAs in switch.c
Thread-Index: AQHTuxcE2Gjef9GklEifgyXjxnMvUqPPl40g
Date: Wed, 14 Mar 2018 11:24:30 +0000
Message-ID: <9843d23677af411aa75a5fb24df3c97b@AcuMS.aculab.com>
References: <1520970647-19587-1-git-send-email-s.mesoraca16@gmail.com>
 <87fu5321du.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
 <CAJHCu1JCCkkoL92tL+Zpx6te1A=-B1dNbAFu4sFEHiHa4vB6BQ@mail.gmail.com>
In-Reply-To: <CAJHCu1JCCkkoL92tL+Zpx6te1A=-B1dNbAFu4sFEHiHa4vB6BQ@mail.gmail.com>
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
X-GMAIL-THRID: =?utf-8?q?1594853343808183482?=
X-GMAIL-MSGID: =?utf-8?q?1594912031508464989?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogU2FsdmF0b3JlIE1lc29yYWNhDQo+IFNlbnQ6IDEzIE1hcmNoIDIwMTggMjI6MDENCj4g
MjAxOC0wMy0xMyAyMDo1OCBHTVQrMDE6MDAgVml2aWVuIERpZGVsb3QgPHZpdmllbi5kaWRlbG90
QHNhdm9pcmZhaXJlbGludXguY29tPjoNCj4gPiBIaSBTYWx2YXRvcmUsDQo+IA0KPiBIaSBWaXZp
ZW4sDQo+IA0KPiA+IFNhbHZhdG9yZSBNZXNvcmFjYSA8cy5tZXNvcmFjYTE2QGdtYWlsLmNvbT4g
d3JpdGVzOg0KPiA+DQo+ID4+IGRzYV9zd2l0Y2gncyBudW1fcG9ydHMgaXMgY3VycmVudGx5IGZp
eGVkIHRvIERTQV9NQVhfUE9SVFMuIFNvIHdlIGF2b2lkDQo+ID4+IDIgVkxBc1sxXSBieSB1c2lu
ZyBEU0FfTUFYX1BPUlRTIGluc3RlYWQgb2YgZHMtPm51bV9wb3J0cy4NCj4gPj4NCj4gPj4gWzFd
IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE4LzMvNy82MjENCj4gPj4NCj4gPj4gU2lnbmVkLW9m
Zi1ieTogU2FsdmF0b3JlIE1lc29yYWNhIDxzLm1lc29yYWNhMTZAZ21haWwuY29tPg0KPiA+DQo+
ID4gTkFLLg0KPiA+DQo+ID4gV2UgYXJlIGluIHRoZSBwcm9jZXNzIHRvIHJlbW92ZSBoYXJkY29k
ZWQgbGltaXRzIHN1Y2ggYXMgRFNBX01BWF9QT1JUUw0KPiA+IGFuZCBEU0FfTUFYX1NXSVRDSEVT
LCBzbyB3ZSBoYXZlIHRvIHN0aWNrIHdpdGggZHMtPm51bV9wb3J0cy4NCj4gDQo+IEkgY2FuIHJl
d3JpdGUgdGhlIHBhdGNoIHVzaW5nIGttYWxsb2MuDQo+IEFsdGhvdWdoLCBpZiBkcy0+bnVtX3Bv
cnRzIHdpbGwgYWx3YXlzIGJlIGxlc3MgdGhhbiBvciBlcXVhbCB0byAxMiwgaXQNCj4gc2hvdWxk
IGJlIGJldHRlciB0bw0KPiBqdXN0IHVzZSBEU0FfTUFYX1BPUlRTLg0KDQpJc24ndCB1c2luZyBE
RUNMQVJFX0JJVE1BUCgpIGNvbXBsZXRlbHkgT1RUIHdoZW4gdGhlIG1heGltdW0gc2l6ZSBpcyBs
ZXNzDQp0aGFuIHRoZSBudW1iZXIgb2YgYml0cyBpbiBhIHdvcmQ/DQoNCglEYXZpZA0KDQo=
