Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id yLp0NJxTGVszHwAAmS7hNA
	; Thu, 07 Jun 2018 15:48:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 450056089E; Thu,  7 Jun 2018 15:48:46 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="I8dE+aB2"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 589F860590;
	Thu,  7 Jun 2018 15:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 589F860590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934672AbeFGPsm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:48:42 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:15701 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934435AbeFGPsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1528386517; x=1559922517;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=CRI6DSEE/FZ1u7uWp8cs/x1oKSjX4lX9Vrc7vuEelIk=;
  b=I8dE+aB2PrV93t2vretdDx0Ne7lf8mREJQC2gqaJfzvfHZMatpzy0k9z
   pn8qyJTOwKVmQkrH4sR0RKL5HB+i/vcYBUGuD7CAEiqwRUIeGkx3HYlLv
   HecTfNJnOGwz8pT1fZW0rkFdjhHrdfvZBmxPUXIl9xjhBEjBiir7hiP7l
   4=;
X-IronPort-AV: E=Sophos;i="5.49,486,1520899200";
   d="scan'208";a="682097804"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Jun 2018 15:48:36 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w57FmV4w105089
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 7 Jun 2018 15:48:33 GMT
Received: from EX13D02EUB001.ant.amazon.com (10.43.166.150) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 7 Jun 2018 15:48:32 +0000
Received: from uc1a35a69ae4659.ant.amazon.com (10.43.160.8) by
 EX13D02EUB001.ant.amazon.com (10.43.166.150) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 7 Jun 2018 15:48:28 +0000
Subject: Re: [less-CONFIG_NET 7/7] kvm: drop CONFIG_NET
From: Norbert Manthey <nmanthey@amazon.de>
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
 <ef0fe0ef-3620-3628-2a7e-c8b73e466a21@amazon.de>
Openpgp: preference=signencrypt
Autocrypt: addr=nmanthey@amazon.de; prefer-encrypt=mutual; keydata=
 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
 pEddsOqYwOs=
Message-ID: <3f98f2be-47e1-ecf1-ff3c-0b35ae93437a@amazon.de>
Date: Thu, 7 Jun 2018 17:48:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ef0fe0ef-3620-3628-2a7e-c8b73e466a21@amazon.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
X-Originating-IP: [10.43.160.8]
X-ClientProxiedBy: EX13D10UWA001.ant.amazon.com (10.43.160.216) To
 EX13D02EUB001.ant.amazon.com (10.43.166.150)
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBQYW9sbywKCmFmdGVyIHlvdSBhc2tlZCwgSSBydW4gYSBmZXcgbW9yZSAibWFrZSByYW5k
Y29uZmlnOyBtYWtlIiByb3VuZHMsIGFuZApmb3VuZCBhIHByb2JsZW0gd2l0aCBvbmUgb2YgdGhl
IGNvbW1pdHMgKHdoZW4gdXNpbmcgQlBGX1NZU0NBTEwsIE5FVCBhbmQKU0VDQ09NUF9GSUxURVIp
LiBJJ2xsIGZpeCB0aGUgaXNzdWVzIGFuZCBhbGwgb3RoZXIgdGhhdCBtaWdodCBwb3AgdXAsCmFu
ZCByZXJ1biB0aGUgcmFuZGNvbmZpZyBsb29wIG1hbnkgbW9yZSB0aW1lcyB0byBnZXQgYSBiZXR0
ZXIgY292ZXJhZ2UKYW5kIGhpZ2hlciBjb25maWRlbmNlLiBJJ2xsIHVwZGF0ZSB0aGUgc2VyaWVz
IGFmdGVyd2FyZHMuCgpCZXN0LApOb3JiZXJ0CgoKT24gMDYvMDcvMjAxOCAwMTo0NiBQTSwgTm9y
YmVydCBNYW50aGV5IHdyb3RlOgo+IE9uIDA2LzA3LzIwMTggMDE6MjAgUE0sIFBhb2xvIEJvbnpp
bmkgd3JvdGU6Cj4+IE9uIDA2LzA2LzIwMTggMTU6NTMsIE5vcmJlcnQgTWFudGhleSB3cm90ZToK
Pj4+IEluIHNvbWUgc2NlbmFyaW9zLCB3ZSBkbyBub3Qgd2FudCB0byB1c2UgQ09ORklHX05FVCBl
dmVuIHRob3VnaCB3ZSB3YW50Cj4+PiB0byB1c2UgQ09ORklHX0tWTS4gVG8gZ2V0IHRoaXMgd29y
a2luZywgYW5kIHRvIG5vdCBwdWxsIGluIG1vcmUKPj4+IGRlcGVuZGVuY2llcywgd2UgbmVlZCB0
byBkaXNhYmxlIENPTkZJR19UQVNLU1RBVFMgYXMgd2VsbC4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5
OiBOb3JiZXJ0IE1hbnRoZXkgPG5tYW50aGV5QGFtYXpvbi5kZT4KPj4+IC0tLQo+Pj4gIGFyY2gv
eDg2L2t2bS9LY29uZmlnIHwgNSArKy0tLQo+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9L
Y29uZmlnIGIvYXJjaC94ODYva3ZtL0tjb25maWcKPj4+IGluZGV4IDkyZmQ0MzMuLmYyMDk4MTcg
MTAwNjQ0Cj4+PiAtLS0gYS9hcmNoL3g4Ni9rdm0vS2NvbmZpZwo+Pj4gKysrIGIvYXJjaC94ODYv
a3ZtL0tjb25maWcKPj4+IEBAIC0yMiw4ICsyMiw4IEBAIGNvbmZpZyBLVk0KPj4+ICAJdHJpc3Rh
dGUgIktlcm5lbC1iYXNlZCBWaXJ0dWFsIE1hY2hpbmUgKEtWTSkgc3VwcG9ydCIKPj4+ICAJZGVw
ZW5kcyBvbiBIQVZFX0tWTQo+Pj4gIAlkZXBlbmRzIG9uIEhJR0hfUkVTX1RJTUVSUwo+Pj4gLQkj
IGZvciBUQVNLU1RBVFMvVEFTS19ERUxBWV9BQ0NUOgo+Pj4gLQlkZXBlbmRzIG9uIE5FVCAmJiBN
VUxUSVVTRVIKPj4+ICsJIyBUQVNLX0RFTEFZX0FDQ1Q6Cj4+PiArCWRlcGVuZHMgb24gTVVMVElV
U0VSCj4+PiAgCWRlcGVuZHMgb24gWDg2X0xPQ0FMX0FQSUMKPj4+ICAJc2VsZWN0IFBSRUVNUFRf
Tk9USUZJRVJTCj4+PiAgCXNlbGVjdCBNTVVfTk9USUZJRVIKPj4+IEBAIC0zNyw3ICszNyw2IEBA
IGNvbmZpZyBLVk0KPj4+ICAJc2VsZWN0IEtWTV9BU1lOQ19QRgo+Pj4gIAlzZWxlY3QgVVNFUl9S
RVRVUk5fTk9USUZJRVIKPj4+ICAJc2VsZWN0IEtWTV9NTUlPCj4+PiAtCXNlbGVjdCBUQVNLU1RB
VFMKPj4+ICAJc2VsZWN0IFRBU0tfREVMQVlfQUNDVAo+Pj4gIAlzZWxlY3QgUEVSRl9FVkVOVFMK
Pj4+ICAJc2VsZWN0IEhBVkVfS1ZNX01TSQo+Pj4KPj4gQXNzdW1pbmcgaXQgY29tcGlsZXMsIGl0
IGxvb2tzIGdvb2QuIDopCj4+Cj4+IFBhb2xvCj4+Cj4gSXQgY29tcGlsZXMsIHdpdGggdGhlIGRl
ZmF1bHQgY29uZmlndXJhdGlvbiwgYXMgd2VsbCBhcyB3aXRoIHRoZSBzdWJzZXQKPiB0aGF0IEkg
Y3VycmVudGx5IHVzZS4gU2luY2UgSSBoYXZlIGFuIGFjdHVhbGx5IHNtYWxsIHNlbGVjdGlvbiBv
ZiBjb25maWcKPiBvcHRpb25zLCBJIHdvbmRlciB3aGV0aGVyIHRoZXJlIGlzIHNvbWUgYmVzdCBw
cmFjdGljZXMgdG8gbWFrZSBzdXJlIHRoaXMKPiBjaGFuZ2UgZG9lcyBub3QgY29ycnVwdCBvdGhl
ciBjb25maWd1cmF0aW9ucyB0aGF0IHJlbHkgb24gS1ZNIHNlbGVjdGluZwo+IFRBU0tTVEFUUy4K
Pgo+IE5vcmJlcnQKCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICkJlcmxp
biAtIERyZXNkZW4gLSBBYWNoZW4KbWFpbiBvZmZpY2U6IEtyYXVzZW5zdHIuIDM4LCAxMDExNyBC
ZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhyZXI6IERyLiBSYWxmIEhlcmJyaWNoLCBDaHJpc3RpYW4gU2No
bGFlZ2VyClVzdC1JRDogREUyODkyMzc4NzkKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hh
cmxvdHRlbmJ1cmcgSFJCIDE0OTE3MyBCCg==
