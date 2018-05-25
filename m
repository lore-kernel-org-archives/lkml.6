Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-350046-1527289740-2-3760804408017712609
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527289740; b=TbpnSChwQcMmSsr0IMYN1el0lwbAMqbvwDZUWsSCPgXFBvX1eP
    cYDccopH1i1th7oZQi3j780mUHc9qnOGtgPFV6PQAkKT7apffuBDm3PMGgLlRkKZ
    lfPeA+MyuXLOEtIbe9Nz8MbUfbJKOD+lZVDAmEYaGSUJso73sDDs456OmeuU4Hba
    BPdlfPIc7Dju742SCzXEkbfCPamCTORMwzcxEkfu41wYYr/o5vXUqiseQ1Wb4b23
    wD+wBsosFWl4DCdMgOu4huPFLPlU81XPhZFhIsOKRBwzT3Pp/4QcvKWzb2Ewtp+G
    Ly2dsRrzdx8TP8YYCKndqWujQIMTTxmt1fNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1527289740; bh=eqXvaUGODr
    6Md5bJVUUfLRl6vxiiSSXXibMzd2fBrWo=; b=UHKuu4/SrVq1Hwi0p5kEitSGlr
    O5buZvck5cCGfUzDRooBsJni1o44vmetxgDmsN5tNOrW/PW2q54/feP9W1k15SKu
    I0W60YwRB1+1KxCWgkM3Nwf8JTviXO/xzBYSVfBLzf0SZAEkeAISyBsBDoY1LDdA
    EgW0f1sC8vmDN+bZdtIGoZ4jfOJrPSh19X65hX2FQa0s+6VDQSXl5bJ+My6v0Xk/
    By76/50AzgOINaMRtaj24gnRl+o+fqsxGe3IV2dxG6GlC7SUzJZZ+K0ApxRXS8AG
    f0H63PpiSi99vNhiHGUPZMUws0TEuGb00AHSAMsRRc0TacLGmnq/wlXxXqbw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBX8VgnCq7Y85HK4F6KaSOzExg9aYRJG2XqGkKSf5Ho0XF7il8iZM2GowTr+M2Fy5TXMgNAI88MlnjNTI7MjBlFnfkd2l61t1U1QsxUvHoCpxCK3vIgI
    ERHc+TqO4smtQm92iweZdmN8/B6ku8PvVrX2Mdw5bjFh1gImXtK3RjgoAGdlqemmylKBZ+aX7ONFm1m2npZ7Q5uf7sC/aStkrOVrvSWaCTAtnW7s6VMLP2yu
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EbVHfS3oRaoA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=bNqBfS2W_FjvpjgHkNEA:9 a=QEXdDO2ut3YA:10
    a=ic4oXV6auKO-Q6VfiSZ6:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030654AbeEYXI5 (ORCPT <rfc822;linux@kroah.com>);
        Fri, 25 May 2018 19:08:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:8452 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030538AbeEYXI5 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 25 May 2018 19:08:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,441,1520924400";
   d="scan'208";a="58599433"
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Will Deacon" <will.deacon@arm.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        "Naresh Bhat" <naresh.bhat@linaro.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: RE: [PATCH V4 0/3] Use efi_rts_wq to invoke EFI Runtime Services
Thread-Topic: [PATCH V4 0/3] Use efi_rts_wq to invoke EFI Runtime Services
Thread-Index: AQHT9HR8sSnhkv5o2EW6xj6m94heQKRBeVoA//+OqnA=
Date: Fri, 25 May 2018 23:08:55 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F39481456@ORSMSX114.amr.corp.intel.com>
References: <1527285903-31799-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <CAKv+Gu_oNUmOwTgM9sAsfMn4WgY+grC2f12vRC4HH9CgxxkfXQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu_oNUmOwTgM9sAsfMn4WgY+grC2f12vRC4HH9CgxxkfXQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjJlZjQ3MDEtNTA1My00MGVhLThjN2UtZGNlNDgzYjZhZjJlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidllCNlhTR3prZm4rMENOM3ZGaUVOTVNvc0lYTmdraHFVa1Nvd1pPNks1c1NTRDIyTzdDcVZiY2JRdDVXTFExUiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PiA+IENoYW5nZXMgZnJvbSBWMyB0byBWNDoNCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
ID4gMS4gQXMgc3VnZ2VzdGVkIGJ5IFBldGVyLCB1c2UgY29tcGxldGlvbnMgaW5zdGVhZCBvZiBm
bHVzaF93b3JrKCkgYXMgdGhlDQo+ID4gICBmb3JtZXIgaXMgY2hlYXBlcg0KPiA+IDIuIENhbGwg
ZWZpX2RlbGV0ZV9kdW1teV92YXJpYWJsZSgpIGZyb20gZWZpc3Vic3lzX2luaXQoKS4gU29ycnkh
IEFyZCwNCj4gPiAgIHdhc24ndCBhYmxlIHRvIGZpbmQgYSBiZXR0ZXIgYWx0ZXJuYXRpdmUgdG8g
a2VlcCB0aGlzIGNoYW5nZSBsb2NhbCB0bw0KPiA+ICAgYXJjaC94ODYuDQo+ID4NCj4gDQo+IFR3
byBxdWVzdGlvbnM6DQo+IC0gU2hvdWxkIHRoZSBub24tYmxvY2tpbmcgdmFyaWFudHMgb2YgdGhl
IHF1ZXJ5IGFuZCBzZXRfdmFyaWFibGVfc3RvcmUgdXNlIHRoZQ0KPiB3b3JrIHF1ZXVlPyBEb2Vz
bid0IHRoYXQgbWFrZSB0aGVtIGJsb2NraW5nPw0KDQpUaGF0J3MgYSBnb29kIHF1ZXN0aW9uIC4g
SSB0aGluayB5b3UgYXJlIHJpZ2h0LCBjYWxsaW5nIG5vbi1ibG9ja2luZyB2YXJpYW50cyBvZiBl
ZmlfcnRzIA0KdXNpbmcgd29yayBxdWV1ZXMgbWFrZXMgdGhlbSBibG9ja2luZy4gQnV0LCBJIGhh
dmUgYSBmb2xsb3cgb24gcXVlc3Rpb24uDQoNCkFzc3VtZSBzb21lIHVzZXIgcmVxdWVzdGVkIHRv
IGV4ZWN1dGUgc29tZSBub24tYmxvY2tpbmcgdmFyaWFudCBvZiBlZmlfcnRzIGFuZCANCnRoZSBr
ZXJuZWwgaGFzbid0IGNhbGxlZCBlZmlfY2FsbF92aXJ0KCkgeWV0LCBidXQgd2FzIHNjaGVkdWxl
ZCBvdXQuIElPVywgZXZlbiB0aG91Z2ggDQp1c2VyIHJlcXVlc3RzIGZvciBub24tYmxvY2tpbmcg
ZWZpIGNhbGwsIHdlIG1pZ2h0IHN0aWxsIGJsb2NrLiBBbSBJIHJpZ2h0Pw0KDQpXaXRoIGVmaV9y
dHNfd3EsIEkgdGhpbmssIEkgaGF2ZSBpbmNyZWFzZWQgdGhlIHdpbmRvdyBvZiBnZXR0aW5nIGJs
b2NrZWQuIFdpdGggZWZpX3J0c193cSwgDQprZXJuZWwgc2hvdWxkIGV4cGxpY2l0bHkgY2FsbCBz
Y2hlZHVsZSgpIHRvIHJ1biBmaXJtd2FyZSBhbmQgdGhlIGNoYW5jZXMgb2YgZ2V0dGluZyBibG9j
a2VkIA0KYXJlIG11Y2ggbW9yZS4NCg0KRXhwZWN0IHRoaXMgaW5jcmVhc2VkIHdpbmRvdywgSSB0
aGluayBmaXJtd2FyZSBzaG91bGQgYmUgZXhlY3V0ZWQgYXMgYmVmb3JlLg0KDQpTbywgY2FuIHlv
dSBwbGVhc2UgZXhwbGFpbiBtZSB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIGJsb2NraW5nIGFuZCBu
b24tYmxvY2tpbmcgdmFyaWFudHMNCmZyb20ga2VybmVsIHBlcnNwZWN0aXZlPw0KKHRoZSB3YXkg
d2UgZ2V0IGxvY2tzIGFyZSBkaWZmZXJlbnQgZG93bl9pbnRlcnJ1cHRpYmxlKCkgdnMgZG93bl90
cnlsb2NrKCkpDQoNCj4gLSBJZiB0aGUgbm9uLWJsb2NraW5nIHNldF92YXJpYWJsZSgpIGRvZXMg
bm90IHVzZSB0aGUgd29yayBxdWV1ZSwgY2FuIHdlIGp1c3QgY2FsbA0KPiBpdCBmcm9tIGVmaV9k
ZWxldGVfZHVtbXlfdmFyaWFibGUoKSwgYW5kIGtlZXAgdGhlIGNhbGxzIHdoZXJlIHRoZXkgYXJl
Pw0KDQpZZXMsIEkgdGhpbmsgd2UgY2FuIGRvIHRoYXQgKGlmIHdlIGRvbid0IHVzZSBlZmlfcnRz
X3dxIGZvciBub24tYmxvY2tpbmcgdmFyaWFudHMpLg0KDQpSZWdhcmRzLA0KU2FpDQo=
