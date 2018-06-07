Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Mxb2J84aGVtvZgAAmS7hNA
	; Thu, 07 Jun 2018 11:46:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E8CD3608BA; Thu,  7 Jun 2018 11:46:28 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Hw/YWCs0"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 38D9760115;
	Thu,  7 Jun 2018 11:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 38D9760115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932668AbeFGLqZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 07:46:25 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:33420 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932334AbeFGLqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 07:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1528371983; x=1559907983;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Y5BDPJdeyOB8FqS1OGdrZ0rSWkEM3aBT5EZcgf2xUko=;
  b=Hw/YWCs0UnJaUtAizaIcGKzzMpTRLNMFPIeula7oOnYhbTmxuW7YFaXq
   PiH5We4G7ouHdYx0pPpVSJQJdh62tYcJCQvuOPyP59Q/3VDQ/sXNqHOIf
   6v/+xCKF3cSzoUAZmmfBvrxjHJ+0HjrwzsdEcvpAJg0kD9EFEUO14M8W5
   M=;
X-IronPort-AV: E=Sophos;i="5.49,486,1520899200";
   d="scan'208";a="723191421"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Jun 2018 11:46:21 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w57BkIHQ106247
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 7 Jun 2018 11:46:20 GMT
Received: from EX13D02EUB001.ant.amazon.com (10.43.166.150) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 7 Jun 2018 11:46:19 +0000
Received: from uc1a35a69ae4659.ant.amazon.com (10.43.161.93) by
 EX13D02EUB001.ant.amazon.com (10.43.166.150) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 7 Jun 2018 11:46:15 +0000
Subject: Re: [less-CONFIG_NET 7/7] kvm: drop CONFIG_NET
To: Paolo Bonzini <pbonzini@redhat.com>
CC: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1528293127-23825-1-git-send-email-nmanthey@amazon.de>
 <1528293206-24298-1-git-send-email-nmanthey@amazon.de>
 <1528293206-24298-7-git-send-email-nmanthey@amazon.de>
 <a7344c4f-a1d9-597d-b18d-059a2752becf@redhat.com>
From: Norbert Manthey <nmanthey@amazon.de>
Openpgp: preference=signencrypt
Autocrypt: addr=nmanthey@amazon.de; prefer-encrypt=mutual; keydata=
 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
 pEddsOqYwOs=
Message-ID: <ef0fe0ef-3620-3628-2a7e-c8b73e466a21@amazon.de>
Date: Thu, 7 Jun 2018 13:46:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a7344c4f-a1d9-597d-b18d-059a2752becf@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
X-Originating-IP: [10.43.161.93]
X-ClientProxiedBy: EX13D05UWC004.ant.amazon.com (10.43.162.223) To
 EX13D02EUB001.ant.amazon.com (10.43.166.150)
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYvMDcvMjAxOCAwMToyMCBQTSwgUGFvbG8gQm9uemluaSB3cm90ZToKPiBPbiAwNi8wNi8y
MDE4IDE1OjUzLCBOb3JiZXJ0IE1hbnRoZXkgd3JvdGU6Cj4+IEluIHNvbWUgc2NlbmFyaW9zLCB3
ZSBkbyBub3Qgd2FudCB0byB1c2UgQ09ORklHX05FVCBldmVuIHRob3VnaCB3ZSB3YW50Cj4+IHRv
IHVzZSBDT05GSUdfS1ZNLiBUbyBnZXQgdGhpcyB3b3JraW5nLCBhbmQgdG8gbm90IHB1bGwgaW4g
bW9yZQo+PiBkZXBlbmRlbmNpZXMsIHdlIG5lZWQgdG8gZGlzYWJsZSBDT05GSUdfVEFTS1NUQVRT
IGFzIHdlbGwuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IE5vcmJlcnQgTWFudGhleSA8bm1hbnRoZXlA
YW1hem9uLmRlPgo+PiAtLS0KPj4gIGFyY2gveDg2L2t2bS9LY29uZmlnIHwgNSArKy0tLQo+PiAg
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPj4KPj4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9LY29uZmlnIGIvYXJjaC94ODYva3ZtL0tjb25maWcKPj4g
aW5kZXggOTJmZDQzMy4uZjIwOTgxNyAxMDA2NDQKPj4gLS0tIGEvYXJjaC94ODYva3ZtL0tjb25m
aWcKPj4gKysrIGIvYXJjaC94ODYva3ZtL0tjb25maWcKPj4gQEAgLTIyLDggKzIyLDggQEAgY29u
ZmlnIEtWTQo+PiAgCXRyaXN0YXRlICJLZXJuZWwtYmFzZWQgVmlydHVhbCBNYWNoaW5lIChLVk0p
IHN1cHBvcnQiCj4+ICAJZGVwZW5kcyBvbiBIQVZFX0tWTQo+PiAgCWRlcGVuZHMgb24gSElHSF9S
RVNfVElNRVJTCj4+IC0JIyBmb3IgVEFTS1NUQVRTL1RBU0tfREVMQVlfQUNDVDoKPj4gLQlkZXBl
bmRzIG9uIE5FVCAmJiBNVUxUSVVTRVIKPj4gKwkjIFRBU0tfREVMQVlfQUNDVDoKPj4gKwlkZXBl
bmRzIG9uIE1VTFRJVVNFUgo+PiAgCWRlcGVuZHMgb24gWDg2X0xPQ0FMX0FQSUMKPj4gIAlzZWxl
Y3QgUFJFRU1QVF9OT1RJRklFUlMKPj4gIAlzZWxlY3QgTU1VX05PVElGSUVSCj4+IEBAIC0zNyw3
ICszNyw2IEBAIGNvbmZpZyBLVk0KPj4gIAlzZWxlY3QgS1ZNX0FTWU5DX1BGCj4+ICAJc2VsZWN0
IFVTRVJfUkVUVVJOX05PVElGSUVSCj4+ICAJc2VsZWN0IEtWTV9NTUlPCj4+IC0Jc2VsZWN0IFRB
U0tTVEFUUwo+PiAgCXNlbGVjdCBUQVNLX0RFTEFZX0FDQ1QKPj4gIAlzZWxlY3QgUEVSRl9FVkVO
VFMKPj4gIAlzZWxlY3QgSEFWRV9LVk1fTVNJCj4+Cj4gQXNzdW1pbmcgaXQgY29tcGlsZXMsIGl0
IGxvb2tzIGdvb2QuIDopCj4KPiBQYW9sbwo+Ckl0IGNvbXBpbGVzLCB3aXRoIHRoZSBkZWZhdWx0
IGNvbmZpZ3VyYXRpb24sIGFzIHdlbGwgYXMgd2l0aCB0aGUgc3Vic2V0CnRoYXQgSSBjdXJyZW50
bHkgdXNlLiBTaW5jZSBJIGhhdmUgYW4gYWN0dWFsbHkgc21hbGwgc2VsZWN0aW9uIG9mIGNvbmZp
ZwpvcHRpb25zLCBJIHdvbmRlciB3aGV0aGVyIHRoZXJlIGlzIHNvbWUgYmVzdCBwcmFjdGljZXMg
dG8gbWFrZSBzdXJlIHRoaXMKY2hhbmdlIGRvZXMgbm90IGNvcnJ1cHQgb3RoZXIgY29uZmlndXJh
dGlvbnMgdGhhdCByZWx5IG9uIEtWTSBzZWxlY3RpbmcKVEFTS1NUQVRTLgoKTm9yYmVydApBbWF6
b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApCZXJsaW4gLSBEcmVzZGVuIC0gQWFj
aGVuCm1haW4gb2ZmaWNlOiBLcmF1c2Vuc3RyLiAzOCwgMTAxMTcgQmVybGluCkdlc2NoYWVmdHNm
dWVocmVyOiBEci4gUmFsZiBIZXJicmljaCwgQ2hyaXN0aWFuIFNjaGxhZWdlcgpVc3QtSUQ6IERF
Mjg5MjM3ODc5CkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIEhSQiAx
NDkxNzMgQgo=
