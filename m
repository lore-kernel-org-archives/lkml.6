Return-Path: <kernel-hardening-return-12503-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsAVaCSK4uqaiZz4d9SPGO5eXok+XzEgOWqLu9xQ00Fih/lJHlOjuAxYrqz0wlPUwtFzGD8
ARC-Seal: i=1; a=rsa-sha256; t=1520944300; cv=none;
        d=google.com; s=arc-20160816;
        b=C6ZDrlKGJwXNZ12Lz7mLDXOADk5FHpAdAclAPk0vRxZ5LiK6BG1FVW8Qg18jwABPCD
         SZaRBrDtut+f0pum9e5BKYieOZpP/iwPzDdw69FAX/EbnozpXq/WZVZsGMEmjUL3stC9
         vYQQYeQ5DEB1LrTtqMSf5lEBr0OBY0I9Gpl3J346qA+zpGQfQCOnvjzV4RiTlIPSjL3/
         ueFNWahRBQI7fdOBwr1CeW6bLN95QFa2s6dkvqDwfYiAivUsq6zNjsSYCW+ItL0OtiE3
         VmA2utF0nOpv8Ecz1jKSV0HnSjbYQ22R982HMEpdjXZHbu/G2R6rj+P2QQJUE6uZTuwz
         F6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=zEYOeRnplyJid69FxE8VlqPSFfUhl1Dz3EE7hk6N9Nc=;
        b=JK5/tG3IZPRLNY+Euv6zWZasjIXvsVW+ly+Iod0uR9RlkcLiD1gYW+BtP310JeR5kV
         pH/v/mBAOnvj36hJCmLxk2ZgS2B9ISY4Su/qe+twkCWJqQjBxn8TWRYl+p4Yqwss8V88
         hXEIvCsEMtla4vuDayIMShe4Mdfgm9W4LrjT4GM/ic66F9YczLBexsrF/P0zph1i5GGl
         02EE0thUhGnCgpZdC0g003yEUUTSytfwET20D3n09tLePPJbBzlJZnGDhQy0uat6bab6
         rh4d+++CgKIlpQ40FpVINozt0j4aiLQifBjltFRn3osVbuzjk5ZNSEsew8d4p5PAUb4a
         q8pg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12503-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12503-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12503-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12503-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Daniel Micay' <danielmicay@gmail.com>, Arend van Spriel
	<arend.vanspriel@broadcom.com>
CC: Andreas Christoforou <andreaschristofo@gmail.com>, Kees Cook
	<keescook@chromium.org>, Kernel Hardening
	<kernel-hardening@lists.openwall.com>, QCA ath9k Development
	<ath9k-devel@qca.qualcomm.com>, Kalle Valo <kvalo@codeaurora.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Netdev
	<netdev@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers: net: wireless: ath: ath9: dfs: remove VLA usage
Thread-Topic: [PATCH] drivers: net: wireless: ath: ath9: dfs: remove VLA usage
Thread-Index: AQHTuMnnjNH4TjF/HkGf/htWtZeOkKPOG2eQ
Date: Tue, 13 Mar 2018 12:32:17 +0000
Message-ID: <423b529d48c54eba9f7ed51922814d46@AcuMS.aculab.com>
References: <1520598613-3641-1-git-send-email-andreaschristofo@gmail.com>
 <5AA464DE.90100@broadcom.com>
 <CA+DvKQ+hbMoWJdOuQB5n+eVF4ePf=kVuRiMbdtTUZ8ars4Pz4A@mail.gmail.com>
In-Reply-To: <CA+DvKQ+hbMoWJdOuQB5n+eVF4ePf=kVuRiMbdtTUZ8ars4Pz4A@mail.gmail.com>
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
X-GMAIL-THRID: =?utf-8?q?1594463764603415966?=
X-GMAIL-MSGID: =?utf-8?q?1594825690558705035?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogRGFuaWVsIE1pY2F5DQo+IFNlbnQ6IDEwIE1hcmNoIDIwMTggMjM6NDUNCj4gDQo+ID4g
SnVzdCB3b25kZXJpbmcuIElzIHRoaXMgYWN0dWFsbHkgYSBWTEEuIEZGVF9OVU1fU0FNUExFUyB3
YXMgc3RhdGljIGNvbnN0IHNvDQo+ID4gbm90IHJlYWxseSBnb2luZyB0byBzaG93IGEgbG90IG9m
IHZhcmlhdGlvbi4gVGhpcyBhcnJheSB3aWxsIGFsd2F5cyBoYXZlIHRoZQ0KPiA+IHNhbWUgc2l6
ZSBvbiB0aGUgc3RhY2suDQo+IA0KPiBUaGUgaXNzdWUgaXMgdGhhdCB1bmxpa2UgaW4gQysrLCBh
IGBzdGF0aWMgY29uc3RgIGNhbid0IGJlIHVzZWQgaW4gYQ0KPiBjb25zdGFudCBleHByZXNzaW9u
IGluIEMuIEl0J3MgdW5jbGVhciB3aHkgQyBpcyBkZWZpbmVkIHRoYXQgd2F5IGJ1dA0KPiBpdCdz
IGhvdyBpdCBpcyBhbmQgdGhlcmUgaXNuJ3QgY3VycmVudGx5IGEgR0NDIGV4dGVuc2lvbiBtYWtp
bmcgbW9yZQ0KPiB0aGluZ3MgaW50byBjb25zdGFudCBleHByZXNzaW9ucyBsaWtlIEMrKy4NCg0K
J3N0YXRpYycgYW5kICdjb25zdCcgYXJlIGJvdGgganVzdCBxdWFsaWZpZXJzIHRvIGEgJ3Zhcmlh
YmxlJw0KWW91IGNhbiBzdGlsbCB0YWtlIGl0J3MgYWRkcmVzcy4NClRoZSBsYW5ndWFnZSBhbGxv
d3MgeW91IHRvIGNhc3QgYXdheSB0aGUgJ2NvbnN0JyBhbmQgd3JpdGUgdG8NCnRoZSB2YXJpYWJs
ZSAtIHRoZSBlZmZlY3QgaXMgcHJvYmFibHkgJ2ltcGxlbWVudGF0aW9uIGRlZmluZWQnLg0KDQpJ
dCBpcyBwcm9iYWJseSByZXF1aXJlZCB0byBiZSB2YWxpZCBmb3IgJ3N0YXRpYyBjb25zdCcgaXRl
bXMNCnRvIGJlIHBhdGNoYWJsZS4NCg0KCURhdmlkDQoNCg==
