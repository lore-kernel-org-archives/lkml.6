Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A923AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F1E20824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F1E20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeJ3BtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:49:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:31022 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbeJ3BtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:49:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 09:59:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,441,1534834800"; 
   d="scan'208";a="92137900"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Oct 2018 09:59:45 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 29 Oct 2018 09:59:45 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.166]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.124]) with mapi id 14.03.0415.000;
 Mon, 29 Oct 2018 09:59:45 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Daniel Aberger - Profihost AG <d.aberger@profihost.ag>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "s.priebe@profihost.ag" <s.priebe@profihost.ag>,
        "n.fahldieck@profihost.ag" <n.fahldieck@profihost.ag>,
        "p.kramme@profihost.ag" <p.kramme@profihost.ag>
Subject: RE: MCE reports errors that can't be verified
Thread-Topic: MCE reports errors that can't be verified
Thread-Index: AQHUb3R6Du2H3PccI06uWh4ZOKELaqU226KA//+UKCA=
Date:   Mon, 29 Oct 2018 16:59:44 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7D43AA76@ORSMSX110.amr.corp.intel.com>
References: <6ccf5413-ce2a-bbb9-0203-b0cc9fe2e641@profihost.ag>
 <20181029161525.GI32150@zn.tnic>
In-Reply-To: <20181029161525.GI32150@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTJmZTZlZjctMDU4Zi00YjM0LTg1YzItYjQ0MDRhMTc4OWRkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTWdIenJVWnUrZEdyNmhNSEdBNERnZ1kwK3lnZmpIKzJGXC9mZE4raTI2TklDQnUzV1ltdnpaU0xrMnNQbDZcL3FrIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGUgZmFjdCB0aGF0IHlvdSBzZWUgdGhpcywgbWVhbnMsIHRoZSBlcnJvciBoYXMgcmVhY2hl
ZCB0aGUgbGFzdA0KPiBub3RpZmllci4gU28gdGhlIEVEQUMgbm90aWZpZXIgbXVzdCd2ZSBydW4g
dG9vIGFuZCBoYW5kZWQgdGhlIGVycm9yIHRvDQo+IHRoZSBFREFDIGRyaXZlci4NCj4NCj4gQ2Fu
IHlvdSBzZW5kIGEgZnVsbCBkbWVzZyBmcm9tIHRoYXQgbWFjaGluZSwgcHJpdmF0ZWx5IHRvIFRv
bnkgYW5kIG1lIGlzDQo+IGZpbmUgdG9vLg0KDQpTb21lIHN5c3RlbSBjb25maWd1cmF0aW9uIGlu
Zm9ybWF0aW9uIHdvdWxkIGJlIGhlbHBmdWwuIEkgY2FuIHNlZSBmcm9tIHRoZSBsb2dzDQp0aGF0
IHRoaXMgb24gYSBIYXN3ZWxsIFhlb24sIGJ1dCBub3Qgd2hpY2ggbW9kZWwuICBUaGUgYWRkcmVz
c2VzIG9mIHRoZSBlcnJvcnMNCmFyZSBhcm91bmQgNDQ4R0IsIGhvdyBtdWNoIG1lbW9yeSBkb2Vz
IHRoZSBzeXN0ZW0gaGF2ZT8gT3V0cHV0IG9mDQoiZG1pZGVjb2RlIC10IDE3IiB3b3VsZCBoZWxw
Lg0KDQpUaGVyZSBhcmUgc29tZSBzdHJhbmdlIHZhbHVlcyBpbiB0aGUgc25pcCB5b3Ugc2VudC4g
Rmlyc3QgbG9nZ2VkIGVycm9yIHNob3dzIGENCmNvcnJlY3RlZCBlcnJvciBjb3VudCBvZiAyNTQ0
LiBOZXh0IHNob3dzIGp1c3QgY291bnQ9MSAod2l0aCBvdmVyZmxvdyBiaXQgc2V0IHRvIDApLg0K
VGhpcmQgaGFzIGEgY291bnQgb2YgMiwgd2l0aCBvdmVyZmxvdyBzZXQuDQoNClNvIEknbSBndWVz
c2luZyB0aGF0IHlvdSBtYXkgaGF2ZSBzb21lIHN0b3JtcyBvZiBjb3JyZWN0ZWQgZXJyb3JzIGFu
ZCBMaW51eA0KaGFzIHN3aXRjaGVkIHRvIHBvbGxpbmcgbW9kZS4NCg0KVGhlIHRocmVlIGVycm9y
cyBpbiB0aGUgc2FtcGxlIGFyZSBhbGwgb24gdGhlIHNhbWUgY2hhbm5lbCAoMSkgb2YgdGhlIHNh
bWUgbWVtb3J5DQpjb250cm9sbGVyICgwKS4gQnV0IHRoZSBhZGRyZXNzZXMgYXJlIGRpZmZlcmVu
dC4gSW5kaWNhdGVzIHRoYXQgc29tZXRoaW5nIHNlcmlvdXMgaGFzDQpoYXBwZW5lZCB0byBhIERJ
TU0gb24gdGhhdCBjaGFubmVsLg0KDQpUaGUgRURBQyBkcml2ZXIgcHJpbnRlZCBvdXQgdGhvc2Ug
bWVzc2FnZXMsIGJ1dCB0aGVuIHNpbGVudGx5IGZhaWxlZCB0byBnaXZlIGFueQ0KZXh0cmEgZGV0
YWlsLiAgTm90IHJlYWxseSBzdXJlIGhvdyB0aGF0IGhhcHBlbmVkLiBQZXJoYXBzIEknbSBtaXNz
aW5nIHNvbWUgZXJyb3INCnBhdGggd2hlcmUgaXQganVzdCBnaXZlcyB1cC4gQ2FuIHlvdSBydW4g
KGFzIHJvb3QpICJsc3BjaSAteHh4eCIgYW5kIHNlbmQgdGhlIG91dHB1dA0KZnJvbSB0aGF0LiAo
Q29tcHJlc3MgYW5kIHNlbmQgb2ZmIGxpc3QpLg0KDQotVG9ueQ0K
