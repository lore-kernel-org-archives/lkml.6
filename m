Return-Path: <prvs=56348445f=karahmed@amazon.de>
X-Google-Smtp-Source: AH8x225PjcgzsZKQKxKRgFgUDB7LAguL1v5wSuH1KiwgVjLh69msFLVCvx5IcoVrCcegYGk4+Yp5
ARC-Seal: i=1; a=rsa-sha256; t=1517495362; cv=none;
        d=google.com; s=arc-20160816;
        b=kLHTnWvRotOK7Rr7yKnfS0PEKcuyTXaUUy+AD134+XX/rVXexfOsyaUpaKANABdoUo
         tF419hZRk6QtHkITIgiWpTuI4UfMwx0w/GE7vFn/DgSXPyAW5f7cR9yCmpCcHYe7X1P0
         /K99L7zSG7kE56UdxHlAbTqwW95sV8PBq4C3lb+rHF6bQCKhgsbJHs18sZDH7ccZ1isK
         aBedEQdTulir73/17DSPFjMhPDCA0PN5qyEivurWZD40y+7QBbN4+3tdqqAzwnotNvs0
         1buTEdI0I6QyLZ29M8xCvgWG4NaHOSn7n+laM5bTUrV9JV10eUE9y90KXCsZcLvnuMDJ
         ui/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=ryv30bWqio1NqMwUhjIzw+Ew68M9iIdhYoxp3Wb3nYI=;
        b=yUw3tl7wMFoaayA873FDFKpcVphKP4YwaDOHZlLGHwt9J7uVGK8Iv4dursD7dH+luZ
         XAHeSQLi2PjSaNb9UCBIrwqnj/3bi8ErPYCUoOBp4WTkA9oWIDagTwkLV2fdIa2rTg63
         xVJwI8cPU0ttbksIuIie2zNHeIpp9SmcfiKIgU1aoDQ4ExQRNUga0wKaJZU8kOECfDhl
         RNGK6N+lR05KQcNP9xLv8i24/96r+Nyvf9gwfQhpndWXq0Ex3Jzezg+0TlnGbOQN4MQL
         DpI3TMow4nuPj3DBwKa7O1XwhgB6ZQTY53o3BkpAC/2HOPr3hBM7dDAmZziGpUK4eZv8
         /5og==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amazon.com header.s=amazon201209 header.b=iR+1Ha72;
       spf=pass (google.com: domain of prvs=56348445f=karahmed@amazon.de designates 207.171.184.29 as permitted sender) smtp.mailfrom=prvs=56348445f=karahmed@amazon.de;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amazon.com header.s=amazon201209 header.b=iR+1Ha72;
       spf=pass (google.com: domain of prvs=56348445f=karahmed@amazon.de designates 207.171.184.29 as permitted sender) smtp.mailfrom=prvs=56348445f=karahmed@amazon.de;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.com
X-IronPort-AV: E=Sophos;i="5.46,444,1511827200";
   d="scan'208";a="592063007"
Subject: Re: [PATCH v5 4/5] KVM: VMX: Allow direct access to
 MSR_IA32_SPEC_CTRL
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: Jim Mattson <jmattson@google.com>, KarimAllah Ahmed <karahmed@amazon.de>,
        kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "the
 arch/x86 maintainers" <x86@kernel.org>,
        Asit Mallick
	<asit.k.mallick@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, Andi Kleen <ak@linux.intel.com>,
        "Andrea
 Arcangeli" <aarcange@redhat.com>,
        Linus Torvalds
	<torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams
	<dan.j.williams@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        "Paolo
 Bonzini" <pbonzini@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg KH
	<gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>, Ashok Raj
	<ashok.raj@intel.com>
References: <1517427467-28567-1-git-send-email-karahmed@amazon.de>
 <1517427467-28567-5-git-send-email-karahmed@amazon.de>
 <CALMp9eRgc-qKS5CDTvqoUDdnAXu8xqy9ZB-rew=P9NgE5AfXWA@mail.gmail.com>
 <06cb88da-f355-41ed-380f-7daa8ddf6159@amazon.com>
 <CALMp9eS9LAJz+u3ujKZ5kLHihHMZ68LHajn3ri7sRPPEgFbHfA@mail.gmail.com>
 <a8f25ab3-0b1d-a248-9564-238e3dca3da4@amazon.com>
 <e28c13c4-4a04-8a41-2a5c-16509e1bad0e@amazon.com>
 <20180201042650.GD21751@char.us.oracle.com>
 <20180201141957.GC19621@char.us.oracle.com>
From: KarimAllah Ahmed <karahmed@amazon.com>
Message-ID: <e3bb9f32-46fa-c20d-023a-79a1199403e8@amazon.com>
Date: Thu, 1 Feb 2018 15:28:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180201141957.GC19621@char.us.oracle.com>
Content-Language: en-US
X-Originating-IP: [10.43.162.191]
X-ClientProxiedBy: EX13D11UWC004.ant.amazon.com (10.43.162.101) To
 EX13D01EUB003.ant.amazon.com (10.43.166.248)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591113692084885209?=
X-GMAIL-MSGID: =?utf-8?q?1591209216773827602?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gMDIvMDEvMjAxOCAwMzoxOSBQTSwgS29ucmFkIFJ6ZXN6dXRlayBXaWxrIHdyb3RlOgo+IC5z
bmlwLi4KPj4+ICsvKiBJcyBTUEVDX0NUUkwgaW50ZXJjZXB0ZWQgZm9yIHRoZSBjdXJyZW50bHkg
cnVubmluZyB2Q1BVPyAqLwo+Pj4gK3N0YXRpYyBib29sIHNwZWNfY3RybF9pbnRlcmNlcHRlZChz
dHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCj4+PiArewo+Pj4gKwl1bnNpZ25lZCBsb25nICptc3JfYml0
bWFwOwo+Pj4gKwlpbnQgZiA9IHNpemVvZih1bnNpZ25lZCBsb25nKTsKPj4+ICsKPj4+ICsJaWYg
KCFjcHVfaGFzX3ZteF9tc3JfYml0bWFwKCkpCj4+PiArCQlyZXR1cm4gdHJ1ZTsKPj4+ICsKPj4+
ICsJbXNyX2JpdG1hcCA9IGlzX2d1ZXN0X21vZGUodmNwdSkgPwo+Pj4gKwkJCXRvX3ZteCh2Y3B1
KS0+bmVzdGVkLnZtY3MwMi5tc3JfYml0bWFwIDoKPj4+ICsJCQl0b192bXgodmNwdSktPnZtY3Mw
MS5tc3JfYml0bWFwOwo+Pj4gKwo+Pj4gKwlyZXR1cm4gISF0ZXN0X2JpdChNU1JfSUEzMl9TUEVD
X0NUUkwsIG1zcl9iaXRtYXAgKyAweDgwMCAvIGYpOwo+Pj4gK30KPj4+ICsKPiAuLnNuaXAuLgo+
Pj4gQEAgLTMzNTksNiArMzM5MywzNCBAQCBzdGF0aWMgaW50IHZteF9zZXRfbXNyKHN0cnVjdCBr
dm1fdmNwdSAqdmNwdSwgc3RydWN0IG1zcl9kYXRhICptc3JfaW5mbykKPj4+ICAgCWNhc2UgTVNS
X0lBMzJfVFNDOgo+Pj4gICAJCWt2bV93cml0ZV90c2ModmNwdSwgbXNyX2luZm8pOwo+Pj4gICAJ
CWJyZWFrOwo+Pj4gKwljYXNlIE1TUl9JQTMyX1NQRUNfQ1RSTDoKPj4+ICsJCWlmICghbXNyX2lu
Zm8tPmhvc3RfaW5pdGlhdGVkICYmCj4+PiArCQkgICAgIWd1ZXN0X2NwdWlkX2hhcyh2Y3B1LCBY
ODZfRkVBVFVSRV9JQlJTKSAmJgo+Pj4gKwkJICAgICFndWVzdF9jcHVpZF9oYXModmNwdSwgWDg2
X0ZFQVRVUkVfU1BFQ19DVFJMKSkKPj4+ICsJCQlyZXR1cm4gMTsKPj4+ICsKPj4+ICsJCXZteC0+
c3BlY19jdHJsX3VzZWQgPSB0cnVlOwo+Pj4gKwo+Pj4gKwkJLyogVGhlIFNUSUJQIGJpdCBkb2Vz
bid0IGZhdWx0IGV2ZW4gaWYgaXQncyBub3QgYWR2ZXJ0aXNlZCAqLwo+Pj4gKwkJaWYgKGRhdGEg
JiB+KFNQRUNfQ1RSTF9JQlJTIHwgU1BFQ19DVFJMX1NUSUJQKSkKPj4+ICsJCQlyZXR1cm4gMTsK
Pj4+ICsKPj4+ICsJCXZteC0+c3BlY19jdHJsID0gZGF0YTsKPj4+ICsKPj4+ICsJCS8qCj4+PiAr
CQkgKiBXaGVuIGl0J3Mgd3JpdHRlbiAodG8gbm9uLXplcm8pIGZvciB0aGUgZmlyc3QgdGltZSwg
cGFzcwo+Pj4gKwkJICogaXQgdGhyb3VnaC4gVGhpcyBtZWFucyB3ZSBkb24ndCBoYXZlIHRvIHRh
a2UgdGhlIHBlcmYKPj4KPj4gLi4gQnV0IG9ubHkgaWYgaXQgaXMgYSBuZXN0ZWQgZ3Vlc3QgKGFz
IHlvdSBoYXZlICYmIGlzX2d1ZXN0X21vZGUpLgo+Pgo+PiBEbyB5b3Ugd2FudCB0byB1cGRhdGUg
dGhlIGNvbW1lbnQgYSBiaXQ/Cj4+Cj4+PiArCQkgKiBoaXQgb2Ygc2F2aW5nIGl0IG9uIHZtZXhp
dCBmb3IgdGhlIGNvbW1vbiBjYXNlIG9mIGd1ZXN0cwo+Pj4gKwkJICogdGhhdCBkb24ndCB1c2Ug
aXQuCj4+PiArCQkgKi8KPj4+ICsJCWlmIChjcHVfaGFzX3ZteF9tc3JfYml0bWFwKCkgJiYgZGF0
YSAmJgo+Pj4gKwkJICAgIHNwZWNfY3RybF9pbnRlcmNlcHRlZCh2Y3B1KSAmJgo+Pj4gKwkJICAg
IGlzX2d1ZXN0X21vZGUodmNwdSkpCj4+ICAgICAgICAgICAgICAgICAgICAgIF5eXl5eXl5eXl5e
Xl5eXl5eXiA8PT09IGhlcmUKPiAKPiBXb3VsZCBpdCBiZSBwZXJoYXBzIGFsc28gZ29vZCB0byBt
ZW50aW9uIHRoZSBjb21wbGV4aXR5IG9mIGhvdwo+IHdlIG91Z2h0IHRvIGJlIGhhbmRsaW5nIEwx
IGFuZCBMMiBndWVzdHMgaW4gdGhlIGNvbW1pdD8KPiAKPiBXZSBhcmUgYWxsIHN0cmVzc2VkIGFu
ZCBJIGFtIHN1cmUgc29tZSBvZiB1cyBoYXZlbid0IGdvdHRlbiBtdWNoCj4gc2xlZXAgLSBidXQg
aXQgY2FuIGhlbHAgaW4gc2F5IHRocmVlIG1vbnRocyB3aGVuIHNvbWUgdW5sdWNrbHkgbmV3Cj4g
c291bCBpcyB0cnlpbmcgdG8gdW5kZXJzdGFuZCB0aGlzIGFuZCBnZXRzIHV0dGVybHkgY29uZnVz
ZWQuCgpZdXAsIEkgd2lsbCBnbyB0aHJvdWdoIHRoZSBwYXRjaGVzIGFuZCBhZGQgYXMgbXVjaCBk
ZXRhaWxzIGFzIHBvc3NpYmxlLgoKQW5kIHllcywgdGhlIGlzX2d1ZXN0X21vZGUodmNwdSkgaGVy
ZSBpcyBpbnZlcnRlZCA6RCBJIGJsYW1lIHRoZSBsYXRlCm5pZ2h0IDopCgo+IAo+Pj4gKwkJCXZt
eF9kaXNhYmxlX2ludGVyY2VwdF9mb3JfbXNyKAo+Pj4gKwkJCQkJdm14LT52bWNzMDEubXNyX2Jp
dG1hcCwKPj4+ICsJCQkJCU1TUl9JQTMyX1NQRUNfQ1RSTCwKPj4+ICsJCQkJCU1TUl9UWVBFX1JX
KTsKPj4+ICsJCWJyZWFrOwo+Pj4gICAJY2FzZSBNU1JfSUEzMl9QUkVEX0NNRDoKPj4+ICAgCQlp
ZiAoIW1zcl9pbmZvLT5ob3N0X2luaXRpYXRlZCAmJgo+Pj4gICAJCSAgICAhZ3Vlc3RfY3B1aWRf
aGFzKHZjcHUsIFg4Nl9GRUFUVVJFX0lCUEIpICYmCj4gCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50
ZXIgR2VybWFueSBHbWJICkJlcmxpbiAtIERyZXNkZW4gLSBBYWNoZW4KbWFpbiBvZmZpY2U6IEty
YXVzZW5zdHIuIDM4LCAxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhyZXI6IERyLiBSYWxmIEhl
cmJyaWNoLCBDaHJpc3RpYW4gU2NobGFlZ2VyClVzdC1JRDogREUyODkyMzc4NzkKRWluZ2V0cmFn
ZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgSFJCIDE0OTE3MyBCCg==
