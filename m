Return-Path: <prvs=56348445f=karahmed@amazon.de>
X-Google-Smtp-Source: AH8x227AUJ+reqddyGxgdxloUB+ZeciNjBMeWBY9OuAf63QXVvJJjwMzUNWYstONDQUspqeFvhtx
ARC-Seal: i=1; a=rsa-sha256; t=1517506776; cv=none;
        d=google.com; s=arc-20160816;
        b=UFnzwkGQGzvPDtN5pIqwK8Q4rT6Td+ltDuraC71JmN2+CAqtOEQZrOmT5ahVrpMo8s
         Kejt+J7mj4JdFEvuXIYOPXskcE78Ijxed+inY/sINYbQUvOHyeSnSSUMlRRLV05ewqOq
         riqoJtpAhYBSZSznXOXy+RMrxulpoA39Z2WcaYI6+fmNp5d+pctV8dVqg8brTR6YzgrQ
         IIwnEB5oxzt9NhLeeAARJau3nDszEVRwcXJ3cbkMpyNdVUgUzmgSpegD5kiQgXMsRp2z
         NGB0d5RmKgNiCEEUJexERxM04phE3I8uAFy8R422zf4/6U7pEolpI+EG8ShTinNJ49vI
         6cpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:precedence:content-language:in-reply-to
         :mime-version:user-agent:date:message-id:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=ZZQvFy7DiwrUlyIRqpJzeyBz2W6Nr1tW7eIAUBrve9Y=;
        b=MUX8ROFMptf98vXGN0xua8aPVg4y7VOl782ngccbYsh7ZYJxmpNjtbND04Dre0ZlKW
         nCHPhGZTePhqs+DEhN7qJlsNQpF6KFTCEFEpikCIbSboTBWJLv02sMKkPYabaCYyb8k8
         AI6i03v0FbUO6nfsbyXF94eL+BWlZY+nyW0VJ5icKoQ5VzYlX3IHDFDHxG1vmt0OlBti
         NNIx2LBusV6gQal+eOpK47g/pwyb6cFAWIxRPRmEgmft1OW9U1JRs3N5yDwkuXPpk12V
         re3oz8a8Z7zHseSZvC0O629pQN3mbT3j8msBdtI8edbQ2MAVB1Dq7fvgWzPDQEJl88ip
         kq4g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amazon.com header.s=amazon201209 header.b=G1pIHy18;
       spf=pass (google.com: domain of prvs=56348445f=karahmed@amazon.de designates 207.171.190.10 as permitted sender) smtp.mailfrom=prvs=56348445f=karahmed@amazon.de;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amazon.com header.s=amazon201209 header.b=G1pIHy18;
       spf=pass (google.com: domain of prvs=56348445f=karahmed@amazon.de designates 207.171.190.10 as permitted sender) smtp.mailfrom=prvs=56348445f=karahmed@amazon.de;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.com
X-IronPort-AV: E=Sophos;i="5.46,444,1511827200";
   d="scan'208";a="717790689"
Subject: Re: [PATCH v5 4/5] KVM: VMX: Allow direct access to
 MSR_IA32_SPEC_CTRL
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
From: KarimAllah Ahmed <karahmed@amazon.com>
Message-ID: <ed251937-be2a-a922-52e9-0982c15e7764@amazon.com>
Date: Thu, 1 Feb 2018 18:37:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1517491537.18619.307.camel@infradead.org>
Content-Language: en-US
X-Originating-IP: [10.43.161.67]
X-ClientProxiedBy: EX13D11UWB002.ant.amazon.com (10.43.161.20) To
 EX13D01EUB003.ant.amazon.com (10.43.166.248)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591113692084885209?=
X-GMAIL-MSGID: =?utf-8?q?1591221185252136415?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gMDIvMDEvMjAxOCAwMjoyNSBQTSwgRGF2aWQgV29vZGhvdXNlIHdyb3RlOgo+IAo+IAo+IE9u
IFdlZCwgMjAxOC0wMS0zMSBhdCAyMzoyNiAtMDUwMCwgS29ucmFkIFJ6ZXN6dXRlayBXaWxrIHdy
b3RlOgo+Pgo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92bXguYyBiL2FyY2gveDg2L2t2
bS92bXguYwo+Pj4gaW5kZXggNmE5ZjRlYy4uYmZjODBmZiAxMDA2NDQKPj4+IC0tLSBhL2FyY2gv
eDg2L2t2bS92bXguYwo+Pj4gKysrIGIvYXJjaC94ODYva3ZtL3ZteC5jCj4+PiBAQCAtNTk0LDYg
KzU5NCwxNCBAQCBzdHJ1Y3QgdmNwdV92bXggewo+Pj4gIMKgICNlbmRpZgo+Pj4gICAgCj4+PiAg
wqDCoMKgwqDCoMKgwqB1NjTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXJj
aF9jYXBhYmlsaXRpZXM7Cj4+PiArwqDCoMKgwqDCoHU2NMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzcGVjX2N0cmw7Cj4+PiArCj4+PiArwqDCoMKgwqDCoC8qCj4+PiArwqDC
oMKgwqDCoCAqIFRoaXMgaW5kaWNhdGVzIHRoYXQ6Cj4+PiArwqDCoMKgwqDCoCAqIDEpIGd1ZXN0
X2NwdWlkX2hhcyhYODZfRkVBVFVSRV9JQlJTKSA9PSB0cnVlICYmCj4+PiArwqDCoMKgwqDCoCAq
IDIpIFRoZSBndWVzdCBoYXMgYWN0dWFsbHkgaW5pdGlhdGVkIGEgd3JpdGUgYWdhaW5zdCB0aGUg
TVNSLgo+Pj4gK8KgwqDCoMKgwqAgKi8KPj4+ICvCoMKgwqDCoMKgYm9vbCBzcGVjX2N0cmxfdXNl
ZDsKPj4+ICAgIAo+Pj4gIMKgwqDCoMKgwqDCoMKgLyoKPj4+ICDCoMKgwqDCoMKgwqDCoCAqIFRo
aXMgaW5kaWNhdGVzIHRoYXQ6Cj4gCj4gVGhhbmtzIGZvciBwZXJzaXN0aW5nIHdpdGggdGhlIGRl
dGFpbHMgaGVyZSwgS2FyaW0uIEluIGFkZGl0aW9uIHRvCj4gS29ucmFkJ3MgaGVja2xpbmcgYXQg
dGhlIGNvbW1lbnRzLCBJJ2xsIGFkZCBteSBvd24gcmVxdWVzdCB0byBoaXMuLi4KPiAKPiBJJ2Qg
bGlrZSB0aGUgY29tbWVudCBmb3Igc3BlY19jdHJsX3VzZWQgdG8gZXhwbGFpbiB3aHkgaXQgaXNu
J3QKPiBlbnRpcmVseSByZWR1bmRhbnQgd2l0aCB0aGUgc3BlY19jdHJsX2ludGVyY2VwdGVkKCkg
ZnVuY3Rpb24uCj4gCj4gV2l0aG91dCBuZXN0aW5nLCBJIGJlbGlldmUgaXQgKndvdWxkKiBiZSBy
ZWR1bmRhbnQsIGJ1dCB0aGUgZGlmZmVyZW5jZQo+IGNvbWVzIHdoZW4gYW4gTDIgaXMgcnVubmlu
ZyBmb3Igd2hpY2ggTDEgaGFzIG5vdCBwZXJtaXR0ZWQgdGhlIE1TUiB0bwo+IGJlIHBhc3NlZCB0
aHJvdWdoLiBUaGF0J3Mgd2hlbiB3ZSBoYXZlIHNwZWNfY3RybF91c2VkID0gdHJ1ZSBidXQgdGhl
Cj4gTVNSICppc24ndCogYWN0dWFsbHkgcGFzc2VkIHRocm91Z2ggaW4gdGhlIGFjdGl2ZSBtc3Jf
Yml0bWFwLgo+IAo+IFF1ZXN0aW9uOiBpZiBzcGVjX2N0cmxfdXNlZCBpcyBhbHdheXMgZXF1aXZh
bGVudCB0byB0aGUgaW50ZXJjZXB0IGJpdAo+IGluIHRoZSB2bWNzMDEubXNyX2JpdG1hcCwganVz
dCBub3QgdGhlIGd1ZXN0IGJpdG1hcC4uLiBzaG91bGQgd2UgZGl0Y2gKPiBpdCBhbmQgYWx3YXlz
IHVzZSB0aGUgYml0IGZyb20gdGhlIHZtY3MwMS5tc3JfYml0bWFwPwoKSWYgSSB1c2VkIHRoZSB2
bWNzMDEubXNyX2JpdG1hcCwgc3BlY19jdHJsX3VzZWQgd2lsbCBhbHdheXMgYmUgdHJ1ZSBpZgpM
MCBwYXNzZWQgaXQgdG8gTDEuIEV2ZW4gaWYgTDEgZGlkIG5vdCBhY3R1YWxseSBwYXNzIGl0IHRv
IEwyIGFuZCBldmVuCmlmIEwyIGhhcyBub3Qgd3JpdHRlbiB0byBpdCB5ZXQgKCF1c2VkKS4KClRo
aXMgcHJldHR5IG11Y2ggcmVuZGVycyB0aGUgc2hvcnQtY2lyY3VpdCBhdApuZXN0ZWRfdm14X21l
cmdlX21zcl9iaXRtYXAgdXNlbGVzczoKCiAgICAgICAgIGlmICghbmVzdGVkX2NwdV9oYXNfdmly
dF94MmFwaWNfbW9kZSh2bWNzMTIpICYmCiAgICAgICAgICAgICAhdG9fdm14KHZjcHUpLT5wcmVk
X2NtZF91c2VkICYmCiAgICAgICAgICAgICAhdG9fdm14KHZjcHUpLT5zcGVjX2N0cmxfdXNlZCkK
ICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7CgouLi4gYW5kIHRoZSBkZWZhdWx0IHBhdGgg
d2lsbCBiZSBrdm1fdmNwdV9ncGFfdG9fcGFnZSArIGttYXAuCgpUaGF0IGJlaW5nIHNhaWQsIEkg
aGF2ZSB0byBhZG1pdCB0aGUgbG9naWMgZm9yIHNwZWNfY3RybF91c2VkIGlzIG5vdApwZXJmZWN0
IGVpdGhlci4KCklmIEwxIG9yIGFueSBvZiB0aGUgTDJzIHRvdWNoZWQgdGhlIE1TUiwgc3BlY19j
dHJsX3VzZWQgd2lsbCBiZSBzZXQgdG8KdHJ1ZS4gU28gaWYgb25lIEwyIHVzZWQgdGhlIE1TUiwg
YWxsIG90aGVyIEwycyB3aWxsIGFsc28gc2tpcCB0aGUgc2hvcnQtCmNpcmN1aXQgbWVudGlvbmVk
IGFib3ZlIGFuZCBlbmQgdXAgKmFsd2F5cyogZ29pbmcgdGhyb3VnaAprdm1fdmNwdV9ncGFfdG9f
cGFnZSArIGttYXAuCgpNYXliZSBhbGwgb2YgdGhpcyBpcyBvdmVyLXRoaW5raW5nIGFuZCBpbiBy
ZWFsaXR5IHRoZSBzaG9ydC1jaXJjdWl0CmFib3ZlIGlzIHJlYWxseSB1c2VsZXNzIGFuZCBhbGwg
TDIgZ3Vlc3RzIGFyZSBoYXBwaWx5IHVzaW5nIHgyYXBpYyA6KQoKPiAKPiBTb3JyeSA6KQo+IApB
bWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApCZXJsaW4gLSBEcmVzZGVuIC0g
QWFjaGVuCm1haW4gb2ZmaWNlOiBLcmF1c2Vuc3RyLiAzOCwgMTAxMTcgQmVybGluCkdlc2NoYWVm
dHNmdWVocmVyOiBEci4gUmFsZiBIZXJicmljaCwgQ2hyaXN0aWFuIFNjaGxhZWdlcgpVc3QtSUQ6
IERFMjg5MjM3ODc5CkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIEhS
QiAxNDkxNzMgQgo=
