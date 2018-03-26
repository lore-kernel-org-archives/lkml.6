Return-Path: <liuwenliang@huawei.com>
X-Google-Smtp-Source: AG47ELuYjTVujM9oLO0IcBNYlqH07xaV8RFIlyqjNXQgyNEyWiDix2jouz8jd5s4lGdBqPUbiY7G
ARC-Seal: i=1; a=rsa-sha256; t=1522026829; cv=none;
        d=google.com; s=arc-20160816;
        b=i7wsrV5RES29fUB17lKKFJVQIY7lYCazj3rcNioETxqR+wJQcpPxmOPvM4h6adzpXm
         UY3BlFm+2a4rT2xQWb4bJK4hJnFrnZGxVoZhQfRo+aeUmRnvNeJ5vXSx0E4nciU2826U
         QAbPRFGlKoKnoFWzgm3JxkTFSU3FBVQ1xp5PgzsEr6SVDVFajgJjxE7I+/cxcbZyvYiV
         xzjEzHPEmkABXQa3dSTPjMVR0UyuhxkT0UznixVODBZFI0rHYOfu4TfwqlQOprRrXoNg
         vF+aVL26bXv+tURUwD5t/gNZ/MTz9zD01/MuNqeZr/WjjvRbZwW37H1DcuyrPURRdRee
         9+CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:arc-authentication-results;
        bh=kDYOL1RjNLKlo2GXYaqJUagWfsCrbaw/J6bxnR4+WPs=;
        b=arzQDltMMyl0xdSV/gJQs+eJFwbdJQxE8u4gfp0KnlwPhKmREsVVbtM+sL/Hizov4v
         TuukJ7KJLXdaWghHM0moa5+RPV2yDyfsDDUeMYjJTzo305IycFOydB4wi/73FfdZdmOo
         2xdtR1TL1bV6i/0HCFxXHhAnZQHhPSkjbQjYJeWFMAKVchJDd2MqBtv0w57eGMOn0H1n
         3KZtxBXREUdjv6uEm1ugleHXtzEXimeNdX/jt297ycB/RMVDj3cSY/aP055+nWC8fcaa
         WB9YBc9qGq3WX3f1indKb22/t6mbkJyilAKBXbzpRyn2UnvvRUWlNplUFzzCgr4+bCgn
         Gijg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.188 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.188 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
From: "Liuwenliang (Abbott Liu)" <liuwenliang@huawei.com>
To: Joel Stanley <joel@jms.id.au>
CC: Russell King <linux@armlinux.org.uk>, "aryabinin@virtuozzo.com"
	<aryabinin@virtuozzo.com>, Marc Zyngier <marc.zyngier@arm.com>,
	"kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>, Greg KH
	<gregkh@linuxfoundation.org>, Florian Fainelli <f.fainelli@gmail.com>,
	"Andrew Morton" <akpm@linux-foundation.org>, Afzal Mohammed
	<afzal.mohd.ma@gmail.com>, "alexander.levin@verizon.com"
	<alexander.levin@verizon.com>, "glider@google.com" <glider@google.com>,
	"dvyukov@google.com" <dvyukov@google.com>, Christoffer Dall
	<christoffer.dall@linaro.org>, "linux@rasmusvillemoes.dk"
	<linux@rasmusvillemoes.dk>, "mawilcox@microsoft.com"
	<mawilcox@microsoft.com>, Philippe Ombredanne <pombredanne@nexb.com>,
	"ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
	"vladimir.murzin@arm.com" <vladimir.murzin@arm.com>,
	"nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>, Thomas Gleixner
	<tglx@linutronix.de>, "thgarnie@google.com" <thgarnie@google.com>,
	"dhowells@redhat.com" <dhowells@redhat.com>, Kees Cook
	<keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven
	<geert@linux-m68k.org>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Mark Rutland
	<mark.rutland@arm.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"zhichao.huang@linaro.org" <zhichao.huang@linaro.org>, "jinb.park7@gmail.com"
	<jinb.park7@gmail.com>, "labbott@redhat.com" <labbott@redhat.com>,
	"philip@cog.systems" <philip@cog.systems>, "grygorii.strashko@linaro.org"
	<grygorii.strashko@linaro.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "opendmb@gmail.com" <opendmb@gmail.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "Linux
 ARM" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>, "kvmarm@lists.cs.columbia.edu"
	<kvmarm@lists.cs.columbia.edu>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2 0/7] KASan for arm
Thread-Topic: [PATCH v2 0/7] KASan for arm
Thread-Index: AdPEnToyoHGlFktmRSmbiJuYhed7Pw==
Date: Mon, 26 Mar 2018 01:13:45 +0000
Message-ID: <B8AC3E80E903784988AB3003E3E97330C0077579@dggemm510-mbs.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.57.90.243]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595281327886471398?=
X-GMAIL-MSGID: =?utf-8?q?1595960804702268405?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gMjYgTWFyY2ggMjAxOCBhdCA3OjU5LCBKb2VsIFN0YW5sZXkgIDxqb2VsLnN0YW5AZ21haWwu
Y29tPiB3cm90ZToNCj5PbiAxOCBNYXJjaCAyMDE4IGF0IDIzOjIzLCBBYmJvdHQgTGl1IDxsaXV3
ZW5saWFuZ0BodWF3ZWkuY29tPiB3cm90ZToNCj4NCj4+ICAgIFRoZXNlIHBhdGNoZXMgYWRkIGFy
Y2ggc3BlY2lmaWMgY29kZSBmb3Iga2VybmVsIGFkZHJlc3Mgc2FuaXRpemVyIA0KPj4gKHNlZSBE
b2N1bWVudGF0aW9uL2thc2FuLnR4dCkuDQo+DQo+VGhhbmtzIGZvciBpbXBsZW1lbnRpbmcgdGhp
cy4gSSBnYXZlIHRoZSBzZXJpZXMgYSBzcGluIG9uIGFuIEFTUEVFRA0KPmFzdDI1MDAgKEFSTXY1
KSBzeXN0ZW0gd2l0aCBhc3BlZWRfZzVfZGVmY29uZmlnLg0KPg0KPkl0IGZvdW5kIGEgYnVnIGlu
IHRoZSBOQ1NJIGNvZGUgKGh0dHBzOi8vZ2l0aHViLmNvbS9vcGVuYm1jL2xpbnV4L2lzc3Vlcy8x
NDYpLg0KPg0KPlRlc3RlZC1ieTogSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT4NCj4NCj5D
aGVlcnMsDQo+DQo+Sm9lbA0KDQpUaGFua3MgZm9yIHlvdXIgdGVzdC4NCg==
