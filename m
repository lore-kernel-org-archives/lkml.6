Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-333748-1524839561-2-11988687924096615661
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524839560; b=Si4rynsVpYG3WoJCajwKTxwQxvf5JmHwgjy1yxBfzm+Unzu9eu
    mNS5xcAanVLWastz8UWuGjCqgG9WPuxPwo2u6h1QQOvaEyZ8MOhTiXgulxTp7zBc
    yfBLbuYT6IGRxN4H4s6FdiTEeOwovgMJn/RhdAaBFVaMmN/17xQRSq6qhqEcYH9T
    74Dyp5OdgxHus3EFH5jSNxtViHmy3Th5FcgF922myo/XwOQR+C7ox22MLD/w7iax
    gQu/cmLBsso1eGhT6keXPCHZq/0QP+ZHzvOz/zJkByIesH/alqdL8UFyPuH+6KL+
    Kkj6vUkz2V8oKoamDqzryjcxT5UP2E+PsA0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1524839560; bh=ZJm0EB4FBWAaU9FZ7JxeargmslOr8u8bU1leHQYdq38=; b=
    mSfENZa+3uEEeOSdDWZPogtx+GJzjCHDnRfhfKeIzhSxsLvxgXCNwVEz6XhwnyCa
    tElxlk8IcB21peeaj8ly0Pj3VWne3JozEkddlggX5vv30kB3bY4iVoXHoJVcrU9Y
    aND0WRiloYbdNzcypKhT9h0PZI3Eu5LceBAEBON9hvSP4NdbaW1sVeyzUclTwErL
    2D5gS5yFN18G9cTWCVVpixYhgGSfxDKjws/s0+w2y173dWe/Q4VSQ6QSCphNdDLz
    /M8bdjwGu6Kazw66GDnaTwkYP3vEDHk5mHYDBrYvxoAIEZ1IJBNG3ScitR8iazjy
    AMa8OtHM7pcNhNjnS+IL+g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBqnTH6c/4uQxwJPOkTL80FisMCTY4wo9u5et5w9QR8t9a/9bIZVkzsGzc2xg0LP4VGfDCUo1HvVqsb8P6cScbbG8MxSWscdmU3je1wgufWFTI/pRsom
    CiYbwwJcZ/41hOmCA37h1s+mIy67W1qMJ0Lpc9Ng8RaOnpfG6dqiWvfWMGUGL8hkZM67vaHNnkkPDW+LkljqA1bz3PDLFfP/IViL6x2Usir2fcNNEaqy+bc9
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=mGcY1-y8K0sA:10 a=JQGMX7YiA1EA:10
    a=A3aqUMXqizAA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=QDZ4HvhdkI4A:10 a=tA7aZXjiAAAA:8 a=ZZ6zTleMgBkSx-a9bgUA:9
    a=157zDSmWTi4CAmtv:21 a=Zf_Pm2K6-Z6SKR3_:21 a=QEXdDO2ut3YA:10
    a=kIIFJ0VLUOy1gFZzwZHL:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934863AbeD0OcX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:32:23 -0400
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:53235 "EHLO
        g4t3426.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934356AbeD0OcU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Apr 2018 10:32:20 -0400
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "joro@8bytes.org" <joro@8bytes.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "Hocko, Michal" <MHocko@suse.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
Thread-Topic: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
Thread-Index: AQHTu76cmkz1ie7mb0G/9GXlGHy7daQTW6wAgAAh0oCAABGZAIAABywAgAAmsYCAACedAIAAmRcAgABzlAA=
Date: Fri, 27 Apr 2018 14:31:51 +0000
Message-ID: <1524839460.2693.531.camel@hpe.com>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
         <20180314180155.19492-3-toshi.kani@hpe.com>
         <20180426141926.GN15462@8bytes.org> <1524759629.2693.465.camel@hpe.com>
         <20180426172327.GQ15462@8bytes.org> <1524764948.2693.478.camel@hpe.com>
         <20180426200737.GS15462@8bytes.org> <1524781764.2693.503.camel@hpe.com>
         <20180427073719.GT15462@8bytes.org>
In-Reply-To: <20180427073719.GT15462@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.219.163.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB1284;7:M11Xsnd1XEa36TrIkMJjzDiDIzHJXdUY0LdEQX3vJlvLwpiWR9g+SSAr9OOu7Da/t2Im25OUfdAN3nj787++UK8+9zukbNPbJk/LRrf2SQOKZUQVeGJVDGLAL1/efClRuwZJlZqdWXufCHW5adpf6Fi0VFPHSyltvJUXOpkRsAmavnAZInizC/wNLLN3VF80ry8g7ynea5f8ak6KxYj/FpdeSwpAqFuvMMGpAJ664m2gkNQbaSm9FJCxN1YOSBWp
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(5600026)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB1284;
x-ms-traffictypediagnostic: AT5PR8401MB1284:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB1284F3FFD916420C6B473011828D0@AT5PR8401MB1284.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AT5PR8401MB1284;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB1284;
x-forefront-prvs: 0655F9F006
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(346002)(39380400002)(366004)(51914003)(189003)(199004)(377424004)(6916009)(105586002)(476003)(486006)(7416002)(5660300001)(446003)(229853002)(2351001)(103116003)(2616005)(99286004)(11346002)(6486002)(6436002)(7736002)(186003)(14454004)(8936002)(6246003)(36756003)(1730700003)(8676002)(81156014)(81166006)(3280700002)(3660700001)(68736007)(316002)(59450400001)(2906002)(5640700003)(305945005)(97736004)(3846002)(53936002)(2900100001)(66066001)(4326008)(478600001)(5250100002)(2501003)(25786009)(106356001)(93886005)(6116002)(26005)(102836004)(6506007)(54906003)(76176011)(6512007)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1284;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 4mvJCAaT/Vbzs82zHQXlQ6vXOqSDVwDqm++nkDzHqvcu/EQMVPcIGCiJsWnQ9ik7xDvKaAf3a+GT6+j/w/fhFRFU43cSKlGol6bVthgAY0DG7bLfJcH3ZtzNCvQ6jNeUMOKo91ze1lEHJAGnDKswKtn7ED9D/bDu4zXfDz4LXVwudt9AHdfnAI+CSSItR7Qz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <76CF738D819A5A4C9117DC257825724D@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 51f38f5d-f24f-4883-0e8b-08d5ac4b9dc8
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f38f5d-f24f-4883-0e8b-08d5ac4b9dc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2018 14:31:51.0970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1284
X-OriginatorOrg: hpe.com
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gRnJpLCAyMDE4LTA0LTI3IGF0IDA5OjM3ICswMjAwLCBqb3JvQDhieXRlcy5vcmcgd3JvdGU6
DQo+IE9uIFRodSwgQXByIDI2LCAyMDE4IGF0IDEwOjMwOjE0UE0gKzAwMDAsIEthbmksIFRvc2hp
IHdyb3RlOg0KPiA+IFRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24uIEFmdGVyIHJlYWRpbmcg
dGhyb3VnaCBTRE0gb25lIG1vcmUgdGltZSwgSQ0KPiA+IGFncmVlIHRoYXQgd2UgbmVlZCBhIFRM
QiBwdXJnZSBoZXJlLiBIZXJlIGlzIG15IGN1cnJlbnQgdW5kZXJzdGFuZGluZy4gDQo+ID4gDQo+
ID4gIC0gSU5WTFBHIHB1cmdlcyBib3RoIFRMQiBhbmQgcGFnaW5nLXN0cnVjdHVyZSBjYWNoZXMu
IFNvLCBQTUQgY2FjaGUgd2FzDQo+ID4gcHVyZ2VkIG9uY2UuDQo+ID4gIC0gSG93ZXZlciwgcHJv
Y2Vzc29yIG1heSBjYWNoZSB0aGlzIFBNRCBlbnRyeSBsYXRlciBpbiBzcGVjdWxhdGlvbg0KPiA+
IHNpbmNlIGl0IGhhcyBwLWJpdCBzZXQuIChUaGlzIGlzIHdoZXJlIG15IG1pc3VuZGVyc3RhbmRp
bmcgd2FzLg0KPiA+IFNwZWN1bGF0aW9uIGlzIG5vdCBhbGxvd2VkIHRvIGFjY2VzcyBhIHRhcmdl
dCBhZGRyZXNzLCBidXQgaXQgbWF5IHN0aWxsDQo+ID4gY2FjaGUgdGhpcyBQTUQgZW50cnkuKQ0K
PiA+ICAtIEEgc2luZ2xlIElOVkxQRyBvbiBlYWNoIHByb2Nlc3NvciBwdXJnZXMgdGhpcyBQTUQg
Y2FjaGUuIEl0IGRvZXMgbm90DQo+ID4gbmVlZCBhIHJhbmdlIHB1cmdlICh3aGljaCB3YXMgYWxy
ZWFkeSBkb25lKS4NCj4gPiANCj4gPiBEb2VzIGl0IHNvdW5kIHJpZ2h0IHRvIHlvdT8NCj4gDQo+
IFRoZSByaWdodCBmaXggaXMgdG8gZmlyc3Qgc3luY2hyb25pemUgdGhlIGNoYW5nZXMgd2hlbiB0
aGUgUE1EL1BVRCBpcw0KPiBjbGVhcmVkIGFuZCB0aGVuIGZsdXNoIHRoZSBUTEIgc3lzdGVtLXdp
ZGUuIEFmdGVyIHRoYXQgaXMgZG9uZSB5b3UgY2FuDQo+IGZyZWUgdGhlIHBhZ2UuDQoNCkFncmVl
ZC4gVGhpcyBjYW4gYmUgZG9uZSBvbiB0b3Agb2YgdGhpcyBwYXRjaC4NCg0KPiBCdXQgZG9pbmcg
YWxsIHRoYXQgaW4gdGhlIHB1ZC9wbWRfZnJlZV9wbWQvcHRlX3BhZ2UoKSBmdW5jdGlvbnMgaXMg
dG9vDQo+IGV4cGVuc2l2ZSwgYXMgdGhlIFRMQiBmbHVzaCByZXF1aXJlcyB0byBzZW5kIElQSXMg
dG8gYWxsIGNvcmVzIGluIHRoZQ0KPiBzeXN0ZW0sIGFuZCB0aGF0IGV2ZXJ5IHRpbWUgdGhlIGZ1
bmN0aW9uIGlzIGNhbGxlZC4NCj4NCj4gU28gd2hhdCBuZWVkcyB0byBiZSBkb25lIGlzIHRvIGZp
eCB0aGlzIGZyb20gaGlnaC1sZXZlbCBpb3JlbWFwIGNvZGUgdG8NCj4gZmlyc3QgdW5tYXAgYWxs
IHJlcXVpcmVkIFBURS9QTUQgcGFnZXMgYW5kIGNvbGxlY3QgdGhlbSBpbiBhIGxpc3QuIFdoZW4N
Cj4gdGhhdCBpcyBkb25lIHlvdSBjYW4gc3luY2hyb25pemUgdGhlIGNoYW5nZXMgd2l0aCB0aGUg
b3RoZXIgcGFnZS10YWJsZXMNCj4gaW4gdGhlIHN5c3RlbSBhbmQgZG8gb25lIHN5c3RlbS13aWRl
IFRMQiBmbHVzaC4gV2hlbiB0aGF0IGlzIGNvbXBsZXRlDQo+IHlvdSBjYW4gZnJlZSB0aGUgcGFn
ZXMgb24gdGhlIGxpc3QgdGhhdCB3ZXJlIGNvbGxlY3RlZCB3aGlsZSB1bm1hcHBpbmcuDQo+DQo+
IFRoZW4gdGhlIG5ldyBtYXBwaW5ncyBjYW4gYmUgZXN0YWJsaXNoZWQgYW5kIGFnYWluIHN5bmNo
cm9uaXplZCB3aXRoIHRoZQ0KPiBvdGhlciBwYWdlLXRhYmxlcyBpbiB0aGUgc3lzdGVtLg0KDQpZ
ZXMsIGFuZCB0aGlzIHBhdGNoIHdhcyBkZXNpZ25lZCB0byB3b3JrIGluIHN1Y2ggd2F5LiAgUGxl
YXNlIG5vdGUgdGhhdA0KdGhpcyBwYXRjaCBhZGRlZCBwdWRfZnJlZV9wbWRfcGFnZSgpIGFuZCBw
bWRfZnJlZV9wdGVfcGFnZSgpIHRvIHRoZQ0KaW9yZW1hcCgpIHBhdGggd2hlbiBhbmQgb25seSB3
aGVuIGl0IGNyZWF0ZXMgYSBwdWQgb3IgcG1kIG1hcC4gIFRoaXMNCmFzc3VyZXMgdGhlIGZvbGxv
d2luZyBwcmVjb25kaXRpb25zIGFyZSBtZXQgd2l0aG91dCBvdmVyaGVhZC4NCiAtIEFsbCBwdGUg
ZW50cmllcyBmb3IgYSB0YXJnZXQgcHVkL3BtZCBhZGRyZXNzIHJhbmdlIGhhdmUgYmVlbiBjbGVh
cmVkLg0KIC0gU3lzdGVtLXdpZGUgVExCIHB1cmdlcyBoYXZlIGJlZW4gZG9uZSBmb3IgYSB0YXJn
ZXQgcHVkL3BtZCBhZGRyZXNzDQpyYW5nZS4NCg0KU28sIHdlIGNhbiBhZGQgdGhlIHN0ZXAgMiBv
biB0b3Agb2YgdGhpcyBwYXRjaC4NCiAxLiBDbGVhciBwdWQvcG1kIGVudHJ5Lg0KIDIuIFN5c3Rl
bSB3aWRlIFRMQiBmbHVzaCA8LS0gVE8gQkUgQURERUQgQlkgTkVXIFBBVENIDQogMy4gRnJlZSBp
dHMgdW5kZXJsaW5pbmcgcG1kL3B0ZSBwYWdlLg0KDQo+ID4gQXMgZm9yIHRoZSBCVUdfT04gaXNz
dWUsIGFyZSB5b3UgYWJsZSB0byByZXByb2R1Y2UgdGhpcyBpc3N1ZT8gIElmIHNvLA0KPiA+IHdv
dWxkIHlvdSBiZSBhYmxlIHRvIHRlc3QgdGhlIGZpeD8NCj4gDQo+IFllcywgSSBjYW4gcmVwcm9k
dWNlIHRoZSBCVUdfT04gd2l0aCBteSBQVEkgcGF0Y2hlcyBhbmQgYSBmZWRvcmEtaTM4Ng0KPiBW
TS4NCg0KR3JlYXQhDQoNCj4gSSBhbHJlYWR5IHJhbiBpbnRvIHRoZSBpc3N1ZSBiZWZvcmUgeW91
ciBwYXRjaGVzIHdlcmUgbWVyZ2VkIHVwc3RyZWFtLA0KPiBidXQgbXkgImZpeCIgaXMgZGlmZmVy
ZW50IGJlY2F1c2UgaXQganVzdCBwcmV2ZW50cyBodWdlLW1hcHBpbmdzIHdoZW4NCj4gdGhlcmUg
d2VyZSBzbWFsbGVyIG1hcHBpbmdzIGJlZm9yZS4gU2VlDQo+IA0KPiAJZTNlMjg4MTIxNDA4IHg4
Ni9wZ3RhYmxlOiBEb24ndCBzZXQgaHVnZSBQVUQvUE1EIG9uIG5vbi1sZWFmIGVudHJpZXMNCj4g
DQo+IGZvciBkZXRhaWxzLiBUaGlzIHBhdGNoIGRvZXMgbm90IGZpeCB0aGUgYmFzZS1wcm9ibGVt
LCBidXQgaGlkZXMgaXQNCj4gYWdhaW4sIGFzIHRoZSByZWFsIGZpeCBuZWVkcyBzb21lIG1vcmUg
d29yayBhY3Jvc3MgYXJjaGl0ZWN0dXJlcy4NCg0KUmlnaHQuICBQYXRjaCAxLzIgb2YgdGhpcyBz
ZXJpZXMgbWFkZSB0aGUgc2FtZSBmaXggYXMgd2VsbC4gIFNlZToNCg0KYjZiZGI3NTE3YzNkICBt
bS92bWFsbG9jOiBhZGQgaW50ZXJmYWNlcyB0byBmcmVlIHVubWFwcGVkIHBhZ2UgdGFibGUNCg0K
PiBZb3VyIHBhdGNoIGFjdHVhbGx5IG1ha2VzIHRoZSBwcm9ibGVtIHdvcnNlLCB3aXRob3V0IGl0
IHRoZSBQVEUvUE1EIHBhZ2VzDQo+IHdlcmUganVzdCBsZWFrZWQsIHNvIHRoYXQgdGhleSBjb3Vs
ZCBub3QgYmUgcmV1c2VkLiBCdXQgd2l0aCB5b3VyIHBhdGNoDQo+IHRoZSBwYWdlcyBjYW4gYmUg
dXNlZCBhZ2FpbiBhbmQgdGhlIHBhZ2Utd2Fsa2VyIG1pZ2h0IGVzdGFibGlzaCBUTEINCj4gZW50
cmllcyBiYXNlZCBvbiByYW5kb20gY29udGVudCB0aGUgbmV3IG93bmVyIHdyaXRlcyB0byBpdC4g
VGhpcyBjYW4NCj4gbGVhZCB0byBhbGwga2luZHMgb2YgcmFuZG9tIGFuZCB2ZXJ5IGhhcmQgdG8g
ZGVidWcgZGF0YSBjb3JydXB0aW9uDQo+IGlzc3Vlcy4NCj4gDQo+IFNvIHVudGlsIHdlIG1ha2Ug
dGhlIGdlbmVyaWMgaW9yZW1hcCBjb2RlIGluIGxpYi9pb3JlbWFwLmMgc21hcnRlciBhYm91dA0K
PiB1bm1hcHBpbmcvcmVtYXBwaW5nIHJhbmdlcyB0aGUgYmVzdCBzb2x1dGlvbiBpcyBtYWtpbmcg
bXkgZml4IHdvcmsgYWdhaW4NCj4gYnkgcmV2ZXJ0aW5nIHlvdXIgcGF0Y2guDQoNCldlIGRvIG5v
dCBuZWVkIHRvIHJldmVydCB0aGlzIHBhdGNoLiAgV2UgY2FuIG1ha2UgdGhlIGFib3ZlIGNoYW5n
ZSBJDQptZW50aW9uZWQuDQoNClRoYW5rcywNCi1Ub3NoaQ0K
