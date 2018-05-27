Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2517909-1527410277-2-9980841723147060106
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527410277; b=ghg196nbmFd9GIWLJjp3O8oZCzh3vRq9MvuohoCEJ6kfYJHyTZ
    E1Zf3eRvYzAQ69uGFt/092xtMG7pdbIT5EipjTpMr8VZRW7f07TR/zhZZ9V2WEur
    nZP+XINF0MfvbqDOI7C29oGKaZ4bkzEbaoWd0avbSA1gZqiPHirYwKq54zEQMCIA
    zUOteunjp90LlNTuhMdIkVNEvfNUi2PPpt3ugubIejCTiG+iwnGJVlrtVwl6fj3a
    m9OWnlSXRk7RT7PIE6V1xSd+yIuxc09V5dZRUsJ4MK7Ba/amKo4AV2CUvOBbpNO8
    uJjPyiuYU3fS6cE03p6ttrG2ZtygV/Y0RYGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1527410277; bh=Gqa+tDUAT1
    8AethzfLQiOoCrEz7h1HQlblNuQJOHBlU=; b=mJ+KZzXaDJK5VjbTyimYoBPquF
    YYoSYz24FGjmnA80cqwDupSDqP5vOFfDxiRSIoycMog50sPAmZ8Zmf4CZmFW7qYi
    sJuBxhAJExhL03R2antrX0vGJY7RreamS68SeUFHRCHNl2omTjJeQtoBBhW2C/HC
    NXav1InhCI1WBmxprZ1sKNsfl8cPnMEc4LekUGlIc7p3CtD3pdmz76iYue47wpGh
    +/0m5a+jAmdhGdOGgniTOVyebNJm8/ZDbXOCqvH40FxRlvBoarfJgQoqUAiRcEJt
    UBhmzYRnKGSsJhK9FZy3XOIBybd75l2dsBo1P0xcpQDXLr1iNC8xj1+ilJ+A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfHIGU3slFEe+4mMqSPschWekInuYS437kcf9jAMNpIkmWlId6sBw+ZNvj87by70Ghk6zq7NzFx2+sLwYANP66aYenZNIw+V+JiqbdBg/5Xb5SHaIVmEL
    HX+G5fyxBk8FYV57DmCLylQSmi8mduMSgjANFOCN14MIHLA7f2dQ2Hso7dADSnGFpULnMHvesyVm45PPTsMZ4UnapOMHGrjny0jdLnv9qS/eOqJrjfOYWNju
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=MJJdeXxr-TQA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=g5JnaeU5hhOiKYEzWDMA:9 a=QEXdDO2ut3YA:10
    a=ic4oXV6auKO-Q6VfiSZ6:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934407AbeE0Ihy (ORCPT <rfc822;linux@kroah.com>);
        Sun, 27 May 2018 04:37:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:30534 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934160AbeE0Ihx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 27 May 2018 04:37:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,446,1520924400";
   d="scan'208";a="43152685"
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
Thread-Index: AQHT9HR8sSnhkv5o2EW6xj6m94heQKRBeVoA//+OqnCAAPsYgIABCbbwgACmjwD//4w5QA==
Date: Sun, 27 May 2018 08:37:43 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F39539372@ORSMSX114.amr.corp.intel.com>
References: <1527285903-31799-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <CAKv+Gu_oNUmOwTgM9sAsfMn4WgY+grC2f12vRC4HH9CgxxkfXQ@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F39481456@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu_eShqmjkDSXnFs-_Hcay67+JTMdb6TatNZpV2v5_MoaQ@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F3952F0CF@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu96gURHioy7hRLW2reyUwYMQDSLHhGE=m_TOz9CYF_Tjw@mail.gmail.com>
In-Reply-To: <CAKv+Gu96gURHioy7hRLW2reyUwYMQDSLHhGE=m_TOz9CYF_Tjw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjg4MmUzZmUtZjBhMi00Zjg2LTg3YzAtZWU4OWJmZjkwNjQ4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZVBlOFFhRnNjRlZXcWQ4RWk3MFVBNHNhYXlzTXh6bnlVbkg5OUZJQklhTmpKb053QkMwckVhVlwvY2FyUWMwWWYifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PiA+IE9uZSBtb3JlIHF1ZXN0aW9uIGFnYWluLCBpZiB3ZSBhcmUgc3VyZSB0aGF0IG5vbi1ibG9j
a2luZyB2YXJpYW50cw0KPiA+IHdpbGwgX2Fsd2F5c18gYmUgY2FsbGVkIGluIGF0b21pYyBjb250
ZXh0LCB0aGVuLCB3ZSBnb3QgaXQgY292ZXJlZC4NCj4gPiBCZWNhdXNlLCBpbg0KPiA+IHNldF92
YXJpYWJsZSgpIGFuZCBxdWVyeV92YXJpYWJsZV9pbmZvKCkgKGJvdGggYmxvY2tpbmcgYW5kDQo+
ID4gbm9uLWJsb2NraW5nKSB3ZSBjaGVjayBmb3IgaW5fYXRvbWljKCkgYW5kIGlmIHNvLCB3ZSBk
b24ndCB1c2UgZWZpX3J0c193cQ0KPiAocGxlYXNlIHJlZmVyIHRvIHBhdGNoIDMpLg0KPiA+DQo+
ID4gSWYgeW91IHRoaW5rLCB0aGVyZSBtaWdodCBiZSBhIHByb2JhYmlsaXR5IG9mIGNhbGxpbmcg
bm9uLWJsb2NraW5nDQo+ID4gZWZpX3J0cyBvdXQgb2YgYXRvbWljIGNvbnRleHQsIHRoZW4sIHN1
cmUhIExldCdzIG1ha2UgdGhlbSBuZXZlciB1c2UNCj4gZWZpX3J0c193cS4NCj4gPg0KPiANCj4g
VGhpcyBpcyBub3QgYWJvdXQgd2hhdCBoYXBwZW5zIHRvIGJlIHRoZSBjdXJyZW50IHNpdHVhdGlv
bi4gSXQgaXMgYWJvdXQgdGhlIEFQSS4NCj4gDQo+IFRoZSBub24tYmxvY2tpbmcgZnVuY3Rpb25z
IHNob3VsZCBuZXZlciBibG9jaywgcGVyaW9kLiBUaGV5IGVpdGhlciBmYWlsIGdyYWNlZnVsbHkN
Cj4gb3IgcGVyZm9ybSB0aGVpciBkdXRpZXMgd2l0aG91dCBzbGVlcGluZy4NCg0KWWVzLCB0aGF0
IG1ha2VzIHNlbnNlLg0KDQo+IA0KPiBJbiB0aGlzIHBhcnRpY3VsYXIgY2FzZSwgSSB0aGluayBp
dCBpcyB1c2VmdWwgdG8gaGF2ZSBhIGd1YXJhbnRlZWQgbm9uLWJsb2NraW5nDQo+IHZlcnNpb24s
IG5vdCBvbmx5IHRvIGRlbGV0ZSB0aGUgZHVtbXkgRUZJIHZhcmlhYmxlLCBidXQgcG90ZW50aWFs
bHkgaW4gb3RoZXINCj4gZnV0dXJlIGNhc2VzIGFzIHdlbGwsIGdpdmVuIHRoYXQgdGhleSBjYW4g
YmUgY2FsbGVkIG11Y2ggZWFybGllciBpbiB0aGUgYm9vdCAod2hlbg0KPiB0aGUgcGVyZi8lY3Iz
IGlzc3VlIGlzIG5vdCBhIGNvbmNlcm4gdG8gYmVnaW4gd2l0aCkNCg0KVGhhbmtzIGZvciBtYWtp
bmcgaXQgbW9yZSBjbGVhciA6KQ0KSSB3aWxsIGNoYW5nZSB0aGUgbm9uLWJsb2NraW5nIHZhcmlh
bnRzIF9ub3RfIHRvIHVzZSBlZmlfcnRzX3dxIGFuZCBhcyB5b3Ugc3VnZ2VzdGVkIA0KbWFrZSBl
ZmlfZGVsZXRlX2R1bW15X3ZhcmlhYmxlKCkgdXNlIG5vbi1ibG9ja2luZyB2YXJpYW50cyAodGhh
dCBzaG91bGQgYWxzbyBtYWtlIGl0IA0KbG9jYWwgdG8gYXJjaC94ODYpLg0KDQpBbm90aGVyIGZv
bGxvdyBvbiBxdWVzdGlvbiBpcywgZG9lcyBldmVyeSBmaXJtd2FyZSBzdXBwb3J0IGJvdGggYmxv
Y2tpbmcgYW5kIA0Kbm9uLWJsb2NraW5nIHZhcmlhbnRzIChzcGVjaWFsbHkgbGVnYWN5IEVGSSBm
aXJtd2FyZSk/IEkgYW0gd29ycmllZCBhYm91dCANCnRoaXMgYmVjYXVzZSwgcHJlc2VudGx5IGVm
aV9kZWxldGVfZHVtbXlfdmFyaWFibGUoKSB1c2VzIHNldF92YXJpYWJsZSgpIGFuZCANCnF1ZXJ5
X3ZhcmlhYmxlX2luZm8oKSBidXQgaWYgSSBjaGFuZ2UgZWZpX2RlbGV0ZV9kdW1teV92YXJpYWJs
ZSgpIHRvIHVzZSBub24tYmxvY2tpbmcgDQp2YXJpYW50cyBhbmQgaWYgdGhleSBhcmVu4oCZdCBz
dXBwb3J0ZWQsIHRoZW4sIEkgZ3Vlc3MsIGVmaV9kZWxldGVfZHVtbXlfdmFyaWFibGUoKSBtaWdo
dCANCmZhaWwgOigNCg0KU28sIGNvdWxkIHlvdSBwbGVhc2UgY2xhcmlmeSBvbiB0aGF0Pw0KDQpS
ZWdhcmRzLA0KU2FpDQo=
