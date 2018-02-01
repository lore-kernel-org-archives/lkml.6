Return-Path: <prvs=56348445f=karahmed@amazon.de>
X-Google-Smtp-Source: AH8x22736rMUxUTU2W7eohnTNSuGdoSi/L/+i4oCekzn2V4eeoZVV6bBeclBHBRvXQKwJ60YXRxK
ARC-Seal: i=1; a=rsa-sha256; t=1517507195; cv=none;
        d=google.com; s=arc-20160816;
        b=MH8tVpL0tPd88VQFOzX35/1KbrIO1elRnQz51t/HEXU+OozHESRWoSIlz2cx28mryT
         HEAQ7QrM8YCuKn7No5yCGMLEHOpyDIJJXbg0XKYxTdwOW9BMCGXDthGT0WdjAa4cebca
         rVNzQitGvAFmzQfvjeaPYE8GcLGW3Wit5bvQU0j/UlRCnP5gFZBal1rZGHkFXRL26629
         U8awn1XZzvRJXpaHMp5TqNGQcwpvyg9GE13D26ZaMP/7CVamy3aR4HRyS0IT5SD8UPDG
         odEiQODiDfG7x9Rvpkw5MLT2xEeUO0YFB7Dpiv9OFfV9GeHsPWd9BhmxWxXzpW1OiCqi
         Fqeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:precedence:content-language:in-reply-to
         :mime-version:user-agent:date:message-id:references:cc:to:from
         :subject:dkim-signature:arc-authentication-results;
        bh=ivWj4IL/FrirIcRVjya9Gds8oYTWPo8fUQKjKPKbeB4=;
        b=UuwV2acCU++ZSPtaFGcJs2wubTxEL8nFEgNwOJkeWt4LB8G28NwHOoiMqTihJ6OkkA
         OkOhausxouk06iUR30rLbJkhnjwGPz0gT+MSGS6m/22yx8Y7yPP93R9V6XK3lboV+5r8
         8R9EPl5zbF7Bq2KZvi4cdv7UHuRKxkOvgyA8EcC1BHAmyvtWbLwUtWMcQMeJfp0MZ/c6
         wmkB3oel0HfZe7L0ASF/dfnbSL1wI7XUT36UWyEUUl8RHtZkiMzlcY66is91v2uq87GF
         znPbRkr0hT+M0B7qgDFpgXaQG0+exCKFeRpbeZ5aCuN34FD9lqLx4pKdvuRwDNexL8tq
         RYAg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amazon.com header.s=amazon201209 header.b=AH5GEkdp;
       spf=pass (google.com: domain of prvs=56348445f=karahmed@amazon.de designates 207.171.184.29 as permitted sender) smtp.mailfrom=prvs=56348445f=karahmed@amazon.de;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amazon.com header.s=amazon201209 header.b=AH5GEkdp;
       spf=pass (google.com: domain of prvs=56348445f=karahmed@amazon.de designates 207.171.184.29 as permitted sender) smtp.mailfrom=prvs=56348445f=karahmed@amazon.de;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.com
X-IronPort-AV: E=Sophos;i="5.46,444,1511827200";
   d="scan'208";a="592135676"
Subject: Re: [PATCH v5 4/5] KVM: VMX: Allow direct access to
 MSR_IA32_SPEC_CTRL
From: KarimAllah Ahmed <karahmed@amazon.com>
To: David Woodhouse <dwmw2@infradead.org>,
        Konrad Rzeszutek Wilk
	<konrad.wilk@oracle.com>
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
        Greg KH <gregkh@linuxfoundation.org>,
        "Andy
 Lutomirski" <luto@kernel.org>, Ashok Raj <ashok.raj@intel.com>
References: <1517427467-28567-1-git-send-email-karahmed@amazon.de>
 <1517427467-28567-5-git-send-email-karahmed@amazon.de>
 <CALMp9eRgc-qKS5CDTvqoUDdnAXu8xqy9ZB-rew=P9NgE5AfXWA@mail.gmail.com>
 <06cb88da-f355-41ed-380f-7daa8ddf6159@amazon.com>
 <CALMp9eS9LAJz+u3ujKZ5kLHihHMZ68LHajn3ri7sRPPEgFbHfA@mail.gmail.com>
 <a8f25ab3-0b1d-a248-9564-238e3dca3da4@amazon.com>
 <e28c13c4-4a04-8a41-2a5c-16509e1bad0e@amazon.com>
 <20180201042650.GD21751@char.us.oracle.com>
 <1517491537.18619.307.camel@infradead.org>
 <ed251937-be2a-a922-52e9-0982c15e7764@amazon.com>
Message-ID: <d2db54d3-73ab-7e24-8368-3288e9d18f14@amazon.com>
Date: Thu, 1 Feb 2018 18:46:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <ed251937-be2a-a922-52e9-0982c15e7764@amazon.com>
Content-Language: en-US
X-Originating-IP: [10.43.161.129]
X-ClientProxiedBy: EX13D05UWB004.ant.amazon.com (10.43.161.208) To
 EX13D01EUB003.ant.amazon.com (10.43.166.248)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591113692084885209?=
X-GMAIL-MSGID: =?utf-8?q?1591221625157420687?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

CgpPbiAwMi8wMS8yMDE4IDA2OjM3IFBNLCBLYXJpbUFsbGFoIEFobWVkIHdyb3RlOgo+IE9uIDAy
LzAxLzIwMTggMDI6MjUgUE0sIERhdmlkIFdvb2Rob3VzZSB3cm90ZToKPj4KPj4KPj4gT24gV2Vk
LCAyMDE4LTAxLTMxIGF0IDIzOjI2IC0wNTAwLCBLb25yYWQgUnplc3p1dGVrIFdpbGsgd3JvdGU6
Cj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vdm14LmMgYi9hcmNoL3g4Ni9rdm0v
dm14LmMKPj4+PiBpbmRleCA2YTlmNGVjLi5iZmM4MGZmIDEwMDY0NAo+Pj4+IC0tLSBhL2FyY2gv
eDg2L2t2bS92bXguYwo+Pj4+ICsrKyBiL2FyY2gveDg2L2t2bS92bXguYwo+Pj4+IEBAIC01OTQs
NiArNTk0LDE0IEBAIHN0cnVjdCB2Y3B1X3ZteCB7Cj4+Pj4gwqDCoCAjZW5kaWYKPj4+PiDCoMKg
wqDCoMKgwqDCoMKgdTY0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFyY2hf
Y2FwYWJpbGl0aWVzOwo+Pj4+ICvCoMKgwqDCoMKgdTY0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHNwZWNfY3RybDsKPj4+PiArCj4+Pj4gK8KgwqDCoMKgwqAvKgo+Pj4+ICvC
oMKgwqDCoMKgICogVGhpcyBpbmRpY2F0ZXMgdGhhdDoKPj4+PiArwqDCoMKgwqDCoCAqIDEpIGd1
ZXN0X2NwdWlkX2hhcyhYODZfRkVBVFVSRV9JQlJTKSA9PSB0cnVlICYmCj4+Pj4gK8KgwqDCoMKg
wqAgKiAyKSBUaGUgZ3Vlc3QgaGFzIGFjdHVhbGx5IGluaXRpYXRlZCBhIHdyaXRlIGFnYWluc3Qg
dGhlIE1TUi4KPj4+PiArwqDCoMKgwqDCoCAqLwo+Pj4+ICvCoMKgwqDCoMKgYm9vbCBzcGVjX2N0
cmxfdXNlZDsKPj4+PiDCoMKgwqDCoMKgwqDCoMKgLyoKPj4+PiDCoMKgwqDCoMKgwqDCoMKgICog
VGhpcyBpbmRpY2F0ZXMgdGhhdDoKPj4KPj4gVGhhbmtzIGZvciBwZXJzaXN0aW5nIHdpdGggdGhl
IGRldGFpbHMgaGVyZSwgS2FyaW0uIEluIGFkZGl0aW9uIHRvCj4+IEtvbnJhZCdzIGhlY2tsaW5n
IGF0IHRoZSBjb21tZW50cywgSSdsbCBhZGQgbXkgb3duIHJlcXVlc3QgdG8gaGlzLi4uCj4+Cj4+
IEknZCBsaWtlIHRoZSBjb21tZW50IGZvciBzcGVjX2N0cmxfdXNlZCB0byBleHBsYWluIHdoeSBp
dCBpc24ndAo+PiBlbnRpcmVseSByZWR1bmRhbnQgd2l0aCB0aGUgc3BlY19jdHJsX2ludGVyY2Vw
dGVkKCkgZnVuY3Rpb24uCj4+Cj4+IFdpdGhvdXQgbmVzdGluZywgSSBiZWxpZXZlIGl0ICp3b3Vs
ZCogYmUgcmVkdW5kYW50LCBidXQgdGhlIGRpZmZlcmVuY2UKPj4gY29tZXMgd2hlbiBhbiBMMiBp
cyBydW5uaW5nIGZvciB3aGljaCBMMSBoYXMgbm90IHBlcm1pdHRlZCB0aGUgTVNSIHRvCj4+IGJl
IHBhc3NlZCB0aHJvdWdoLiBUaGF0J3Mgd2hlbiB3ZSBoYXZlIHNwZWNfY3RybF91c2VkID0gdHJ1
ZSBidXQgdGhlCj4+IE1TUiAqaXNuJ3QqIGFjdHVhbGx5IHBhc3NlZCB0aHJvdWdoIGluIHRoZSBh
Y3RpdmUgbXNyX2JpdG1hcC4KPj4KPj4gUXVlc3Rpb246IGlmIHNwZWNfY3RybF91c2VkIGlzIGFs
d2F5cyBlcXVpdmFsZW50IHRvIHRoZSBpbnRlcmNlcHQgYml0Cj4+IGluIHRoZSB2bWNzMDEubXNy
X2JpdG1hcCwganVzdCBub3QgdGhlIGd1ZXN0IGJpdG1hcC4uLiBzaG91bGQgd2UgZGl0Y2gKPj4g
aXQgYW5kIGFsd2F5cyB1c2UgdGhlIGJpdCBmcm9tIHRoZSB2bWNzMDEubXNyX2JpdG1hcD8KPiAK
PiBJZiBJIHVzZWQgdGhlIHZtY3MwMS5tc3JfYml0bWFwLCBzcGVjX2N0cmxfdXNlZCB3aWxsIGFs
d2F5cyBiZSB0cnVlIGlmCj4gTDAgcGFzc2VkIGl0IHRvIEwxLiBFdmVuIGlmIEwxIGRpZCBub3Qg
YWN0dWFsbHkgcGFzcyBpdCB0byBMMiBhbmQgZXZlbgo+IGlmIEwyIGhhcyBub3Qgd3JpdHRlbiB0
byBpdCB5ZXQgKCF1c2VkKS4KPiAKPiBUaGlzIHByZXR0eSBtdWNoIHJlbmRlcnMgdGhlIHNob3J0
LWNpcmN1aXQgYXQKPiBuZXN0ZWRfdm14X21lcmdlX21zcl9iaXRtYXAgdXNlbGVzczoKPiAKPiAg
wqDCoMKgwqDCoMKgwqAgaWYgKCFuZXN0ZWRfY3B1X2hhc192aXJ0X3gyYXBpY19tb2RlKHZtY3Mx
MikgJiYKPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAhdG9fdm14KHZjcHUpLT5wcmVkX2NtZF91
c2VkICYmCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIXRvX3ZteCh2Y3B1KS0+c3BlY19jdHJs
X3VzZWQpCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7Cj4g
Cj4gLi4uIGFuZCB0aGUgZGVmYXVsdCBwYXRoIHdpbGwgYmUga3ZtX3ZjcHVfZ3BhX3RvX3BhZ2Ug
KyBrbWFwLgo+IAo+IFRoYXQgYmVpbmcgc2FpZCwgSSBoYXZlIHRvIGFkbWl0IHRoZSBsb2dpYyBm
b3Igc3BlY19jdHJsX3VzZWQgaXMgbm90Cj4gcGVyZmVjdCBlaXRoZXIuCj4gCj4gSWYgTDEgb3Ig
YW55IG9mIHRoZSBMMnMgdG91Y2hlZCB0aGUgTVNSLCBzcGVjX2N0cmxfdXNlZCB3aWxsIGJlIHNl
dCB0bwo+IHRydWUuIFNvIGlmIG9uZSBMMiB1c2VkIHRoZSBNU1IsIGFsbCBvdGhlciBMMnMgd2ls
bCBhbHNvIHNraXAgdGhlIHNob3J0LQo+IGNpcmN1aXQgbWVudGlvbmVkIGFib3ZlIGFuZCBlbmQg
dXAgKmFsd2F5cyogZ29pbmcgdGhyb3VnaAo+IGt2bV92Y3B1X2dwYV90b19wYWdlICsga21hcC4K
PiAKPiBNYXliZSBhbGwgb2YgdGhpcyBpcyBvdmVyLXRoaW5raW5nIGFuZCBpbiByZWFsaXR5IHRo
ZSBzaG9ydC1jaXJjdWl0Cj4gYWJvdmUgaXMgcmVhbGx5IHVzZWxlc3MgYW5kIGFsbCBMMiBndWVz
dHMgYXJlIGhhcHBpbHkgdXNpbmcgeDJhcGljIDopCj4gCgpoZWhlIC4uCgogPj4gaWYgc3BlY19j
dHJsX3VzZWQgaXMgYWx3YXlzIGVxdWl2YWxlbnQgdG8gdGhlIGludGVyY2VwdCBiaXQgaW4gdGhl
CnZtY3MwMS5tc3JfYml0bWFwCgphY3R1YWxseSB5ZXMsIHdlIGNhbi4KCkkganVzdCBmb3Jnb3Qg
dGhhdCB3ZSB1cGRhdGUgdGhlIG1zciBiaXRtYXAgbGF6aWx5ISA6KQoKPj4KPj4gU29ycnkgOikK
Pj4KQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKQmVybGluIC0gRHJlc2Rl
biAtIEFhY2hlbgptYWluIG9mZmljZTogS3JhdXNlbnN0ci4gMzgsIDEwMTE3IEJlcmxpbgpHZXNj
aGFlZnRzZnVlaHJlcjogRHIuIFJhbGYgSGVyYnJpY2gsIENocmlzdGlhbiBTY2hsYWVnZXIKVXN0
LUlEOiBERTI4OTIzNzg3OQpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVy
ZyBIUkIgMTQ5MTczIEIK
