Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2278225-1527399184-2-2411487707403949738
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527399183; b=F223qPJ0TS7HCiO3A0m9CxgNFKLY0cxBlpsoG7DxLRQgklhzzn
    +eewwtiy4tIUc6jN4T4zhce6su8tKoiXXn8lBKqAPgMKPHCx5PhbpnjGQvCuXFaT
    zJj0SlVY+jJ36fjN1zMtClGIjfArUVMv5cQj0+cJrKWWNnpcMhnxDAzd4LGiaHY3
    NMtvi1f7IrPNdwZMB1YTKY6xgcYv5f4iid0yeFFtltVKlubcX8iowWT/Akb0p1OO
    ZHrVu/d++qN1k/Hc6w03YfEEGwz6W69i6dG8AKnC65qqE9gPGVFZpjDuakjDStXJ
    Cjci0lw/PCN+OxpSiXe80oEsm4GTDv35bMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1527399183; bh=yRtLOCMsov
    uN3VPkiRhom5Vy9j59/yvQnc270C5PZ6g=; b=GlxK2Ku9KK7qyEmLGxCepMai2u
    /7l4zWJt3mWYQnkCJQeYigK60LlvzZljJEJiNZ6l1EWFe2J+vj7BPBjyIEaIp9H9
    d1x7bpxloxlKtQ/BUjkpkQgmJaHrJ7wW17DC5YXIZlT9EN385FLM0D3vnf1yd4sB
    57vnMLE12c8WDHc12pP2XyXxtxeQUDNWhSZoHNCQVH+xJYIPAhE+LOhtbuR5gCcR
    5YS7p7lD/O2coy4l2LyPRIlcuegdeuJfrtSg93SnhAUkPC0cz5kJXhg4TcA536wE
    5x4ljWBblyx2SbWV0DGNH9JohvbLCVMAe0PCz46W3Jm2Q+y22k9xW0V4u7iw==
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
X-CM-Envelope: MS4wfNpG3fi52gwbMONvMrBPBWQ7JtQAa3GMZbT4fVdnh4APdtL2w6N6LimChC2z/ywk/M3kyeYX7302H6fDxJgQLlTIemyAE+zQ0CIa3m9to0pIMilhpdGI
    k/OsIdzaeMBLYF7pzKikLWx4OB+9TeN2c/vCqAK5FJ8vlqEHKeV6I62GfCsMSGrnXGunDpVWXP3w/ZV0vyvPDKN0T4j5KryO+OxMW97uapikCJB+Tm3qE+IZ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EbVHfS3oRaoA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=D6sbzV-a5RBVkQhPKukA:9 a=QEXdDO2ut3YA:10
    a=ic4oXV6auKO-Q6VfiSZ6:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755127AbeE0Fc7 (ORCPT <rfc822;linux@kroah.com>);
        Sun, 27 May 2018 01:32:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:52583 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755118AbeE0Fc6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 27 May 2018 01:32:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,446,1520924400";
   d="scan'208";a="42507905"
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
Thread-Index: AQHT9HR8sSnhkv5o2EW6xj6m94heQKRBeVoA//+OqnCAAPsYgIABCbbw
Date: Sun, 27 May 2018 05:32:52 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F3952F0CF@ORSMSX114.amr.corp.intel.com>
References: <1527285903-31799-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <CAKv+Gu_oNUmOwTgM9sAsfMn4WgY+grC2f12vRC4HH9CgxxkfXQ@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F39481456@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu_eShqmjkDSXnFs-_Hcay67+JTMdb6TatNZpV2v5_MoaQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu_eShqmjkDSXnFs-_Hcay67+JTMdb6TatNZpV2v5_MoaQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmZkNmRmNjUtMmNmYy00ZmU0LTk1ZTEtYTFmODVkY2NjZWM0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMnh3RlwvbVZ2TzI3SkxaYkVjeWxIcmtza0M1Z0w4WU1MdGoraHpidzB6TUhmd25yUU83QzVLNEhxVVpCYVB3dksifQ==
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

PiA+IEFzc3VtZSBzb21lIHVzZXIgcmVxdWVzdGVkIHRvIGV4ZWN1dGUgc29tZSBub24tYmxvY2tp
bmcgdmFyaWFudCBvZg0KPiA+IGVmaV9ydHMgYW5kIHRoZSBrZXJuZWwgaGFzbid0IGNhbGxlZCBl
ZmlfY2FsbF92aXJ0KCkgeWV0LCBidXQgd2FzDQo+ID4gc2NoZWR1bGVkIG91dC4gSU9XLCBldmVu
IHRob3VnaCB1c2VyIHJlcXVlc3RzIGZvciBub24tYmxvY2tpbmcgZWZpIGNhbGwsIHdlDQo+IG1p
Z2h0IHN0aWxsIGJsb2NrLiBBbSBJIHJpZ2h0Pw0KPiA+DQo+IA0KPiBObywgdGhhdCBpcyB0aGUg
d2hvbGUgcG9pbnQuIFRoZXNlIGZ1bmN0aW9ucyBtYXkgYmUgY2FsbGVkIGZyb20gYXRvbWljIGNv
bnRleHQsDQo+IHdoaWNoIGlzIHdoeSB0aGV5IHRyeWxvY2soKSBhbmQgZ2l2ZSB1cCByYXRoZXIg
dGhhbiBibG9jayBvbiB0aGUgc2VtYXBob3JlIGlmIGEgcnQNCj4gc2VydmljZXMgY2FsbCBpcyBh
bHJlYWR5IGluIHByb2dyZXNzLiBFLmcuLA0KPiANCj4gLyoNCj4gICogZWZpdmFyX2VudHJ5X3Nl
dF9ub25ibG9ja2luZyAtIGNhbGwgc2V0X3ZhcmlhYmxlX25vbmJsb2NraW5nKCkNCj4gICoNCj4g
ICogVGhpcyBmdW5jdGlvbiBpcyBndWFyYW50ZWVkIHRvIG5vdCBibG9jayBhbmQgaXMgc3VpdGFi
bGUgZm9yIGNhbGxpbmcNCj4gICogZnJvbSBjcmFzaC9wYW5pYyBoYW5kbGVycy4NCj4gICoNCj4g
ICogQ3J1Y2lhbGx5LCB0aGlzIGZ1bmN0aW9uIHdpbGwgbm90IGJsb2NrIGlmIGl0IGNhbm5vdCBh
Y3F1aXJlDQo+ICAqIGVmaXZhcnNfbG9jay4gSW5zdGVhZCwgaXQgcmV0dXJucyAtRUJVU1kuDQo+
ICAqLw0KPg0KDQpPbmUgbW9yZSBxdWVzdGlvbiBhZ2FpbiwgaWYgd2UgYXJlIHN1cmUgdGhhdCBu
b24tYmxvY2tpbmcgdmFyaWFudHMgd2lsbA0KX2Fsd2F5c18gYmUgY2FsbGVkIGluIGF0b21pYyBj
b250ZXh0LCB0aGVuLCB3ZSBnb3QgaXQgY292ZXJlZC4gQmVjYXVzZSwgaW4NCnNldF92YXJpYWJs
ZSgpIGFuZCBxdWVyeV92YXJpYWJsZV9pbmZvKCkgKGJvdGggYmxvY2tpbmcgYW5kIG5vbi1ibG9j
a2luZykgd2UgY2hlY2sNCmZvciBpbl9hdG9taWMoKSBhbmQgaWYgc28sIHdlIGRvbid0IHVzZSBl
ZmlfcnRzX3dxIChwbGVhc2UgcmVmZXIgdG8gcGF0Y2ggMykuDQoNCklmIHlvdSB0aGluaywgdGhl
cmUgbWlnaHQgYmUgYSBwcm9iYWJpbGl0eSBvZiBjYWxsaW5nIG5vbi1ibG9ja2luZyBlZmlfcnRz
IG91dCBvZiBhdG9taWMNCmNvbnRleHQsIHRoZW4sIHN1cmUhIExldCdzIG1ha2UgdGhlbSBuZXZl
ciB1c2UgZWZpX3J0c193cS4NCg0KUmVnYXJkcywNClNhaQ0K
