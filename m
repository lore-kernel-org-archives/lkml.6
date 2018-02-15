Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1146594-1518687766-2-6281613947544215424
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518687765; b=ihFJKrnMhDnJf4vCPN0ir8ckaCkVoXecRdJ4sBGqgmJJLtR
    SSA9xUJD/s2wgb3iwWdmN03qlgw6m3CfTQf6ogwnEqDqjmVplBxIRAeHBrMKcMoa
    nhgrAOUQfz7is1XKCmRAWxpI2LVJvbGtYFE9yPEQ0l3PMniRiJJm7GXBUXLNR3bx
    WdCMbuvf3PaLMfHO49cu5pvlit7g3IC5Kzpa68E2dBWyf6q41lkUI27ELw/TOsog
    RBdQRCAGFldwpvC4P0m1cVMGHvfyehQf+kc+lldJ9NJ1bZE3TqBIlj4maAuXeBE3
    zwIKByc2vb3060QUHaljfMKD1Y4rXPs7kk+ZJJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1518687765; bh=JS0RXX
    rK/yvj3E+wl0xe3EAtzQyJEK4uHO/XHojsOks=; b=ag6ajUR5PLzEPpV78qIvsz
    Ol9VPOC3QGcll4BEK7iyeXVFB2NzCkJv3YyLZC8o78/dEQV/cyOGkITn288wUII6
    pPh5W7gsxAu0/v7dFrGZ6fEwPIGSlMzcbEwWZes6s86SkolzaG/ZFihVLITeNTxF
    mLq1ZiSlzs3vB52H3h32dKsTc/fGYcEZOg5hOSUT92hVwDRNdZ+ntm79tgBEiOnc
    Tq1rPZVtJVAvi06uYJht/c+wjADXgyNuGzCBTXGKK9r+Bi2cLUk+nd+YXH8P7gWJ
    iqol7IrUsTy81b1Ga9Gnyb/hlmTuKh0B0NfxDm88f33PmI7Nd99JmWB+tcmovD3Q
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755165AbeBOJmj (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 04:42:39 -0500
Received: from mga11.intel.com ([192.55.52.93]:23465 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755192AbeBOJme (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 15 Feb 2018 04:42:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,516,1511856000";
   d="scan'208";a="204330228"
From: "Wu, Hao" <hao.wu@intel.com>
To: Alan Tull <atull@kernel.org>
CC: Moritz Fischer <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Subject: RE: [PATCH v4 03/24] fpga: mgr: add status for fpga-manager
Thread-Topic: [PATCH v4 03/24] fpga: mgr: add status for fpga-manager
Thread-Index: AQHTpK3+yVU4GYWAf0q2t/TpVHuTGqOjiO+AgAGv+EA=
Date: Thu, 15 Feb 2018 09:42:30 +0000
Message-ID: <BE8371DA886269458E0220A16DC1F8277E154E27@SHSMSX104.ccr.corp.intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
 <1518513893-4719-4-git-send-email-hao.wu@intel.com>
 <CANk1AXT4hSSa8j0A2Q=M91jjxDzkNayHZaftnOYSdZoppTMEAA@mail.gmail.com>
In-Reply-To: <CANk1AXT4hSSa8j0A2Q=M91jjxDzkNayHZaftnOYSdZoppTMEAA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTI4NDUyNmUtNDI1Mi00M2Y4LWFiZDUtZjE0ZmM5ZTI0YmFkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJpUHd4RGkrNUtQcVBoZW8rMUhJTlZcL2FpQTJCY2hBcjhjRHZCN1A2OHRQa1wvZm9rdXphSHh3SURlNnlzc1pQa1cifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PiBPbiBUdWUsIEZlYiAxMywgMjAxOCBhdCAzOjI0IEFNLCBXdSBIYW8gPGhhby53dUBpbnRlbC5j
b20+IHdyb3RlOg0KPiANCj4gSGkgSGFvLA0KPiANCj4gPiBUaGlzIHBhdGNoIGFkZHMgc3RhdHVz
IHRvIGZwZ2EtbWFuYWdlciBkYXRhIHN0cnVjdHVyZSwNCj4gDQo+IFBsZWFzZSB1cGRhdGUgdGhl
IGhlYWRlciB0byBiZXR0ZXIgZGVzY3JpYmUgdGhlIGN1cnJlbnQgY2hhbmdlcywgdGhpcw0KPiBw
YXRjaCBubyBsb25nZXIgYWRkcyBzdGF0dXMgdG8gdGhlIGZwZ2EgbWdyIGRhdGEgc3RydWN0Lg0K
DQpTb3JyeSwgd2lsbCBmaXggaXQuIFRoYW5rcyBhIGxvdCENCg0KSGFvDQoNCj4gDQo+ID4gdG8g
YWxsb3cNCj4gPiBkcml2ZXIgdG8gc3RvcmUgZnVsbC9wYXJ0aWFsIHJlY29uZmlndXJhdGlvbiBl
cnJvcnMgYW5kIG90aGVyDQo+ID4gc3RhdHVzIGluZm9ybWF0aW9uLCBhbmQgYWRkcyBvbmUgc3Rh
dHVzIGNhbGxiYWNrIHRvIGZwZ2FfbWFuYWdlcl9vcHMNCj4gPiB0byBhbGxvdyBmcGdhX21hbmFn
ZXIgdG8gY29sbGVjdCBsYXRlc3Qgc3RhdHVzIHdoZW4gZmFpbHVyZXMgYXJlDQo+ID4gZGV0ZWN0
ZWQuDQo+IA0KPiBPdGhlciB0aGFuIHRoYXQsIGxvb2tzIGdvb2QgdG8gbWUhICBUaGFua3MgZm9y
IHRha2luZyBteSBmZWVkYmFjay4NCj4gQWxhbg0KPiANCj4gPg0KPiA+IFRoZSBmb2xsb3dpbmcg
c3lzZnMgZmlsZSBpcyBjcmVhdGVkOg0KPiA+ICogL3N5cy9jbGFzcy9mcGdhX21hbmFnZXIvPGZw
Z2E+L3N0YXR1cw0KPiA+ICAgUmV0dXJuIHN0YXR1cyBvZiBmcGdhIG1hbmFnZXIsIGluY2x1ZGlu
ZyByZWNvbmZpZ3VyYXRpb24gZXJyb3JzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV3UgSGFv
IDxoYW8ud3VAaW50ZWwuY29tPg0KPiBBY2tlZC1ieTogQWxhbiBUdWxsIDxhdHVsbEBrZXJuZWwu
b3JnPg0K
