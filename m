Return-Path: <liuwenliang@huawei.com>
X-Google-Smtp-Source: AG47ELsKsSAjsxtTjCZX4FigOgfGZuBH6tCFsYj0CGMvGVmJ9AzqsLY/GSAjZJxPEMLDa5qH9AGA
ARC-Seal: i=1; a=rsa-sha256; t=1521896766; cv=none;
        d=google.com; s=arc-20160816;
        b=DmfAYx1kgumV/38c2BTw5z7NxulNhJSZMtQoO1kZBF0YdmNw97ZRRn/IYI3AYQv8XB
         ufcpkx1AcBDobbK3WGr0s8HiGuiTOzzTzo6pFNNXasqrn3M4efaciWRnOMexlwSQ5GVL
         2vfhHAT1iOtGwaUhPse2ojfdEvQ1GfyChuabIMOq8bbr6jAjcd4ypaSjwVM7WsSRhJW4
         xVB8Br7oiUJ3fpv7iri33vZpVwmJ+lWd/cBQfnqtJcpFgg1Kvk8aB8CwnRU80nr0ge76
         jsID14Nh7HhJaz7Joqx0nHO6A8O1aQ6vMAVFiwaA8ncdgQd4kAYmj+cTR1DC6epVnNaD
         QbkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:arc-authentication-results;
        bh=1VFBim7YGZ9dkErK8UECKCQBN3CAg5JaG14FehZ35z0=;
        b=KJC2KNA8EV5uHNyZD61lOd7Z811UPzsklEORert8hEwzi2l2pUAXfxkIk4u7oZNaqB
         TE0j3zs7AF0zL2WojlpfGQr/CPyTMsii9JGwPyYB2/5SlkTC5abZng8vuMcFxUeRQ8SO
         Zb1tuS/YF+9OtguC9aEb1KltC1aFkCJEq3cc1bZ3H+WRJz90nCHFAJ1HowoxB5K8FTaP
         6CFyp2tOuDV0Ca1SyWdqX1ntLwXfPSquglJEbxNkvCp2uJ22T896GqfHb6+7nuvcPlKF
         j4VbXWwvAbcIVJM9fV4bfdTHz63iATkWwkQ60tFOM68oksDvsaXxk/pqlWLLLXepOBzv
         ZB2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.255 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.255 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
From: "Liuwenliang (Abbott Liu)" <liuwenliang@huawei.com>
To: Florian Fainelli <f.fainelli@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>, "kstewart@linuxfoundation.org"
	<kstewart@linuxfoundation.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "afzal.mohd.ma@gmail.com"
	<afzal.mohd.ma@gmail.com>, "alexander.levin@verizon.com"
	<alexander.levin@verizon.com>
CC: "glider@google.com" <glider@google.com>, "dvyukov@google.com"
	<dvyukov@google.com>, "christoffer.dall@linaro.org"
	<christoffer.dall@linaro.org>, "linux@rasmusvillemoes.dk"
	<linux@rasmusvillemoes.dk>, "mawilcox@microsoft.com"
	<mawilcox@microsoft.com>, "pombredanne@nexb.com" <pombredanne@nexb.com>,
	"ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
	"vladimir.murzin@arm.com" <vladimir.murzin@arm.com>,
	"nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "thgarnie@google.com" <thgarnie@google.com>,
	"dhowells@redhat.com" <dhowells@redhat.com>, "keescook@chromium.org"
	<keescook@chromium.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"geert@linux-m68k.org" <geert@linux-m68k.org>, "tixy@linaro.org"
	<tixy@linaro.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"james.morse@arm.com" <james.morse@arm.com>, "zhichao.huang@linaro.org"
	<zhichao.huang@linaro.org>, "jinb.park7@gmail.com" <jinb.park7@gmail.com>,
	"labbott@redhat.com" <labbott@redhat.com>, "philip@cog.systems"
	<philip@cog.systems>, "grygorii.strashko@linaro.org"
	<grygorii.strashko@linaro.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "opendmb@gmail.com" <opendmb@gmail.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>, "kvmarm@lists.cs.columbia.edu"
	<kvmarm@lists.cs.columbia.edu>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2 0/7] KASan for arm
Thread-Topic: [PATCH v2 0/7] KASan for arm
Thread-Index: AdPDcM8mvdpkefYWSzmzWmfFrEdiOw==
Date: Sat, 24 Mar 2018 13:06:00 +0000
Message-ID: <B8AC3E80E903784988AB3003E3E97330C00774D7@dggemm510-mbs.china.huawei.com>
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
X-GMAIL-MSGID: =?utf-8?q?1595824423713754785?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gMDMvMjAvMjAxOCAyOjMwIEFNLCBBYmJvdHQgTGl1IHdyb3RlOg0KPkJUVywgaXQgbG9va3Mg
bGlrZSB5b3UgaGF2ZSBzb21lIHNlY3Rpb24gbWlzbWF0Y2hlczoNCj4NCj5XQVJOSU5HOiB2bWxp
bnV4Lm8oLm1lbWluaXQudGV4dCsweDQwKTogU2VjdGlvbiBtaXNtYXRjaCBpbiByZWZlcmVuY2UN
Cj5mcm9tIHRoZSBmdW5jdGlvbiBrYXNhbl9wdGVfcG9wdWxhdGUoKSB0byB0aGUgZnVuY3Rpb24N
Cj4uaW5pdC50ZXh0Omthc2FuX2FsbG9jX2Jsb2NrLmNvbnN0cHJvcC41KCkNCj5UaGUgZnVuY3Rp
b24gX19tZW1pbml0IGthc2FuX3B0ZV9wb3B1bGF0ZSgpIHJlZmVyZW5jZXMNCj5hIGZ1bmN0aW9u
IF9faW5pdCBrYXNhbl9hbGxvY19ibG9jay5jb25zdHByb3AuNSgpLg0KPklmIGthc2FuX2FsbG9j
X2Jsb2NrLmNvbnN0cHJvcC41IGlzIG9ubHkgdXNlZCBieSBrYXNhbl9wdGVfcG9wdWxhdGUgdGhl
bg0KPmFubm90YXRlIGthc2FuX2FsbG9jX2Jsb2NrLmNvbnN0cHJvcC41IHdpdGggYSBtYXRjaGlu
ZyBhbm5vdGF0aW9uLg0KPg0KPldBUk5JTkc6IHZtbGludXgubygubWVtaW5pdC50ZXh0KzB4MTQ0
KTogU2VjdGlvbiBtaXNtYXRjaCBpbiByZWZlcmVuY2UNCj5mcm9tIHRoZSBmdW5jdGlvbiBrYXNh
bl9wbWRfcG9wdWxhdGUoKSB0byB0aGUgZnVuY3Rpb24NCj4uaW5pdC50ZXh0Omthc2FuX2FsbG9j
X2Jsb2NrLmNvbnN0cHJvcC41KCkNCj5UaGUgZnVuY3Rpb24gX19tZW1pbml0IGthc2FuX3BtZF9w
b3B1bGF0ZSgpIHJlZmVyZW5jZXMNCj5hIGZ1bmN0aW9uIF9faW5pdCBrYXNhbl9hbGxvY19ibG9j
ay5jb25zdHByb3AuNSgpLg0KPklmIGthc2FuX2FsbG9jX2Jsb2NrLmNvbnN0cHJvcC41IGlzIG9u
bHkgdXNlZCBieSBrYXNhbl9wbWRfcG9wdWxhdGUgdGhlbg0KPmFubm90YXRlIGthc2FuX2FsbG9j
X2Jsb2NrLmNvbnN0cHJvcC41IHdpdGggYSBtYXRjaGluZyBhbm5vdGF0aW9uLg0KPg0KPldBUk5J
Tkc6IHZtbGludXgubygubWVtaW5pdC50ZXh0KzB4MWE0KTogU2VjdGlvbiBtaXNtYXRjaCBpbiBy
ZWZlcmVuY2UNCj5mcm9tIHRoZSBmdW5jdGlvbiBrYXNhbl9wdWRfcG9wdWxhdGUoKSB0byB0aGUg
ZnVuY3Rpb24NCj4uaW5pdC50ZXh0Omthc2FuX2FsbG9jX2Jsb2NrLmNvbnN0cHJvcC41KCkNCj5U
aGUgZnVuY3Rpb24gX19tZW1pbml0IGthc2FuX3B1ZF9wb3B1bGF0ZSgpIHJlZmVyZW5jZXMNCj5h
IGZ1bmN0aW9uIF9faW5pdCBrYXNhbl9hbGxvY19ibG9jay5jb25zdHByb3AuNSgpLg0KPklmIGth
c2FuX2FsbG9jX2Jsb2NrLmNvbnN0cHJvcC41IGlzIG9ubHkgdXNlZCBieSBrYXNhbl9wdWRfcG9w
dWxhdGUgdGhlbg0KPmFubm90YXRlIGthc2FuX2FsbG9jX2Jsb2NrLmNvbnN0cHJvcC41IHdpdGgg
YSBtYXRjaGluZyBhbm5vdGF0aW9uLg0KDQpUaGFua3MgZm9yIHlvdXIgdGVzdGluZy4NCkkgZG9u
J3Qga25vdyB3aHkgdGhlIGNvbXBpbGVyIG9uIG15IG1hY2hpbmUgZG9lc24ndCByZXBvcnQgdGhp
cyB3YXJpbmcuDQpDb3VsZCB5b3UgdGVzdCBhZ2FpbiB3aXRoIGFkZGluZyB0aGUgZm9sbG93aW5n
IGNvZGU6DQpsaXV3ZW5saWFuZ0BsaW51eDovaG9tZS9zb2Z0X2Rpc2sveW9jdG8vbGludXgtZ2l0
L2xpbnV4PiBnaXQgZGlmZg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21tL2thc2FuX2luaXQuYyBi
L2FyY2gvYXJtL21tL2thc2FuX2luaXQuYw0KaW5kZXggZDMxNmYzNy4uYWUxNGQxOSAxMDA2NDQN
Ci0tLSBhL2FyY2gvYXJtL21tL2thc2FuX2luaXQuYw0KKysrIGIvYXJjaC9hcm0vbW0va2FzYW5f
aW5pdC5jDQpAQCAtMTE1LDcgKzExNSw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBjbGVhcl9wZ2Rz
KHVuc2lnbmVkIGxvbmcgc3RhcnQsDQogICAgICAgICAgICAgICAgcG1kX2NsZWFyKHBtZF9vZmZf
ayhzdGFydCkpOw0KIH0NCg0KLXB0ZV90ICogX19tZW1pbml0IGthc2FuX3B0ZV9wb3B1bGF0ZShw
bWRfdCAqcG1kLCB1bnNpZ25lZCBsb25nIGFkZHIsIGludCBub2RlKQ0KK3B0ZV90ICogX19pbml0
IGthc2FuX3B0ZV9wb3B1bGF0ZShwbWRfdCAqcG1kLCB1bnNpZ25lZCBsb25nIGFkZHIsIGludCBu
b2RlKQ0KIHsNCiAgICAgICAgcHRlX3QgKnB0ZSA9IHB0ZV9vZmZzZXRfa2VybmVsKHBtZCwgYWRk
cik7DQoNCkBAIC0xMzIsNyArMTMyLDcgQEAgcHRlX3QgKiBfX21lbWluaXQga2FzYW5fcHRlX3Bv
cHVsYXRlKHBtZF90ICpwbWQsIHVuc2lnbmVkIGxvbmcgYWRkciwgaW50IG5vZGUpDQogICAgICAg
IHJldHVybiBwdGU7DQogfQ0KDQotcG1kX3QgKiBfX21lbWluaXQga2FzYW5fcG1kX3BvcHVsYXRl
KHB1ZF90ICpwdWQsIHVuc2lnbmVkIGxvbmcgYWRkciwgaW50IG5vZGUpDQorcG1kX3QgKiBfX2lu
aXQga2FzYW5fcG1kX3BvcHVsYXRlKHB1ZF90ICpwdWQsIHVuc2lnbmVkIGxvbmcgYWRkciwgaW50
IG5vZGUpDQogew0KICAgICAgICBwbWRfdCAqcG1kID0gcG1kX29mZnNldChwdWQsIGFkZHIpOw0K
DQpAQCAtMTQ2LDcgKzE0Niw3IEBAIHBtZF90ICogX19tZW1pbml0IGthc2FuX3BtZF9wb3B1bGF0
ZShwdWRfdCAqcHVkLCB1bnNpZ25lZCBsb25nIGFkZHIsIGludCBub2RlKQ0KICAgICAgICByZXR1
cm4gcG1kOw0KIH0NCg0KLXB1ZF90ICogX19tZW1pbml0IGthc2FuX3B1ZF9wb3B1bGF0ZShwZ2Rf
dCAqcGdkLCB1bnNpZ25lZCBsb25nIGFkZHIsIGludCBub2RlKQ0KK3B1ZF90ICogX19pbml0IGth
c2FuX3B1ZF9wb3B1bGF0ZShwZ2RfdCAqcGdkLCB1bnNpZ25lZCBsb25nIGFkZHIsIGludCBub2Rl
KQ0KIHsNCiAgICAgICAgcHVkX3QgKnB1ZCA9IHB1ZF9vZmZzZXQocGdkLCBhZGRyKTsNCg0KQEAg
LTE2MSw3ICsxNjEsNyBAQCBwdWRfdCAqIF9fbWVtaW5pdCBrYXNhbl9wdWRfcG9wdWxhdGUocGdk
X3QgKnBnZCwgdW5zaWduZWQgbG9uZyBhZGRyLCBpbnQgbm9kZSkNCiAgICAgICAgcmV0dXJuIHB1
ZDsNCiB9DQoNCi1wZ2RfdCAqIF9fbWVtaW5pdCBrYXNhbl9wZ2RfcG9wdWxhdGUodW5zaWduZWQg
bG9uZyBhZGRyLCBpbnQgbm9kZSkNCitwZ2RfdCAqIF9faW5pdCBrYXNhbl9wZ2RfcG9wdWxhdGUo
dW5zaWduZWQgbG9uZyBhZGRyLCBpbnQgbm9kZSkNCiB7DQogICAgICAgIHBnZF90ICpwZ2QgPSBw
Z2Rfb2Zmc2V0X2soYWRkcik7DQoNCg==
