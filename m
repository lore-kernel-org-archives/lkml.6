Return-Path: <liuwenliang@huawei.com>
X-Google-Smtp-Source: AG47ELtnUwT5BIDcqryxBrm9wwvx5sVpYPGGHG7Xo5NjbF/WFsh969V0JS+IX2G/JRIo24adN/A9
ARC-Seal: i=1; a=rsa-sha256; t=1521894270; cv=none;
        d=google.com; s=arc-20160816;
        b=0BHwshqqXx54DDLwI8D24rCr+0IubywSY36mpoV/31D4AEzI8JPmdjEa+wb7a97uUg
         bX7y4K2g7cIiaTufkWNznota74xjrE+yRwiGXp9R2oQ3lPthAYrU24eYc8sNs+jj2SlY
         UIS05KDDLgFiyiH9xL19v9XiHXgHAdZywIrFlZXgSY553DSm//Fz+oG0r4VqFcFHDKjt
         pm4QFraQrp5D/xzPFCGw8z0/elruu0raI3uQYUPikPmQHXZ+snWtMx9Ib08TY3P1X3ue
         9yh3T/lWROuWajJ5LSKyIKdPjaA+rjQYsWwSTm7FIP1ByZUm+GmxyLjlqLGWugMKxvcx
         x7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:arc-authentication-results;
        bh=lBqr7uK4pzpvucUuXEU3EsSxWyZevaEXohfmbzdTFDU=;
        b=aLna4dzQvkDesQRtbhvBo0tj3zkjL6kVl75D+AENNca/jbraJiJ8AmKYfajSa8dYqi
         1rjpiKLIYT5r4TcetL52tPMQtC/4TjeOkwbt8JZc2wKGSB7z8KibN8uCCovXVmdcSE2B
         COzk5DdGxiHScqB0YW7meAWNZeaC76lHq3rJ/iWeEeKRUHjmc3PycXdQFOQfAfH7H4qD
         vZbflY8BuHK6wQHlgobaP63A1YS/xLHdZva3u8WylRQNdbMWUA4Nz2XwVFNop+NzsB2/
         K2CcwOH0X2h4MB7EZdSh/TFV2GNumneTfhGzKR6nRf/R1Sh7wYwwHWXH/+czdO4/bwW8
         qxiA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.187 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.187 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
From: "Liuwenliang (Abbott Liu)" <liuwenliang@huawei.com>
To: Dmitry Vyukov <dvyukov@google.com>
CC: Florian Fainelli <f.fainelli@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>, "kstewart@linuxfoundation.org"
	<kstewart@linuxfoundation.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "afzal.mohd.ma@gmail.com"
	<afzal.mohd.ma@gmail.com>, "alexander.levin@verizon.com"
	<alexander.levin@verizon.com>, "glider@google.com" <glider@google.com>,
	"christoffer.dall@linaro.org" <christoffer.dall@linaro.org>,
	"linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
	"mawilcox@microsoft.com" <mawilcox@microsoft.com>, "pombredanne@nexb.com"
	<pombredanne@nexb.com>, "ard.biesheuvel@linaro.org"
	<ard.biesheuvel@linaro.org>, "vladimir.murzin@arm.com"
	<vladimir.murzin@arm.com>, "nicolas.pitre@linaro.org"
	<nicolas.pitre@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"thgarnie@google.com" <thgarnie@google.com>, "dhowells@redhat.com"
	<dhowells@redhat.com>, "keescook@chromium.org" <keescook@chromium.org>,
	"arnd@arndb.de" <arnd@arndb.de>, "geert@linux-m68k.org"
	<geert@linux-m68k.org>, "tixy@linaro.org" <tixy@linaro.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "zhichao.huang@linaro.org" <zhichao.huang@linaro.org>,
	"jinb.park7@gmail.com" <jinb.park7@gmail.com>, "labbott@redhat.com"
	<labbott@redhat.com>, "philip@cog.systems" <philip@cog.systems>,
	"grygorii.strashko@linaro.org" <grygorii.strashko@linaro.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "opendmb@gmail.com"
	<opendmb@gmail.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>, "kvmarm@lists.cs.columbia.edu"
	<kvmarm@lists.cs.columbia.edu>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2 0/7] KASan for arm
Thread-Topic: [PATCH v2 0/7] KASan for arm
Thread-Index: AdPDatr3PI5JlbY/Sv2byYaXb9ks/g==
Date: Sat, 24 Mar 2018 12:24:22 +0000
Message-ID: <B8AC3E80E903784988AB3003E3E97330C00774B7@dggemm510-mbs.china.huawei.com>
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
X-GMAIL-MSGID: =?utf-8?q?1595821806143535597?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gTW9uLCBNYXIgMTksIDIwMTggYXQgMTY6NDQgLCBEbWl0cnkgVnl1a292IHdyb3RlOg0KPkhp
IEFiYm90dCwNCj4NCj5JJ3ZlIHNraW1tZWQgdGhyb3VnaCB0aGUgY2hhbmdlcyBhbmQgdGhleSBn
ZW5lcmFsbHkgbG9vayBnb29kIHRvIG1lLiBJDQo+YW0gbm90IGFuIGV4cGVjdCBpbiBhcm0sIHNv
IEkgZGlkIG5vdCBsb29rIHRvbyBjbG9zZWx5IG9uIHRoZXNlIHBhcnRzDQo+KHdoaWNoIGlzIGFj
dHVhbGx5IG1vc3Qgb2YgdGhlIGNoYW5nZXMpLg0KPg0KPkZXSVcNCj5BY2tlZC1ieTogRG1pdHJ5
IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUuY29tPg0KPg0KPlBsZWFzZSBhbHNvIHVwZGF0ZSBzZXQg
b2Ygc3VwcG9ydGVkIGFyY2hzIGF0IHRoZSB0b3Agb2YNCj5Eb2N1bWVudGF0aW9uL2Rldi10b29s
cy9rYXNhbi5yc3QNCj4NCj5UaGFua3MgZm9yIHdvcmtpbmcgb24gdXBzdHJlYW1pbmcgdGhpcyEN
Cg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCkkgd2lsbCB1cGRhdGUgc2V0IG9mIHN1cHBvcnRl
ZCBhcmNocyBqdXN0IGxpa2UgdGhpczoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldi10
b29scy9rYXNhbi5yc3QgYi9Eb2N1bWVudGF0aW9uL2Rldi10b29scy9rYXNhbi5yc3QNCmluZGV4
IGY3YTE4ZjIuLmQ5MjEyMGQgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2Rldi10b29scy9r
YXNhbi5yc3QNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2thc2FuLnJzdA0KQEAgLTEy
LDcgKzEyLDcgQEAgS0FTQU4gdXNlcyBjb21waWxlLXRpbWUgaW5zdHJ1bWVudGF0aW9uIGZvciBj
aGVja2luZyBldmVyeSBtZW1vcnkgYWNjZXNzLA0KIHRoZXJlZm9yZSB5b3Ugd2lsbCBuZWVkIGEg
R0NDIHZlcnNpb24gNC45LjIgb3IgbGF0ZXIuIEdDQyA1LjAgb3IgbGF0ZXIgaXMNCiByZXF1aXJl
ZCBmb3IgZGV0ZWN0aW9uIG9mIG91dC1vZi1ib3VuZHMgYWNjZXNzZXMgdG8gc3RhY2sgb3IgZ2xv
YmFsIHZhcmlhYmxlcy4NCg0KLUN1cnJlbnRseSBLQVNBTiBpcyBzdXBwb3J0ZWQgb25seSBmb3Ig
dGhlIHg4Nl82NCBhbmQgYXJtNjQgYXJjaGl0ZWN0dXJlcy4NCitDdXJyZW50bHkgS0FTQU4gaXMg
c3VwcG9ydGVkIG9ubHkgZm9yIHRoZSB4ODZfNjQsIGFybTY0IGFuZCBhcm0gYXJjaGl0ZWN0dXJl
cy4NCg0K
