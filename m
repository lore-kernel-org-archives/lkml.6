Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-444702-1521125475-2-6075720539383300188
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521125474; b=s6ARmmevXvqOVrY7MFAY/Qyx9xQU6HvvchRNITKeV3tOnb1
    /a704S2g7kc3Qp5VRTOd7HxSIXo+cCXZd/RBU83TbIp/JXBEdgP1DbcZpuINO77z
    kpQTx2J/jmr3HiFUt98c6Vmf4TfSF8lqL5Fm9M6HhtAoTomBmQNoTj76tE3+xts/
    MiEdWJhqx82uNEW1qBH8b8RBD096H5XuMnthSFDhf0sr7W9HsiUkNkO0pmBAzSNg
    7M90xtug+XgeEzC9J+v1XtUIw8f8vGSzzzWyxSjsLSRXdlC4aWj+5rcfKzG2jzbf
    593AOl8CiKqcqkSWipk9WVhHrEBvubFWGSF7CTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521125474; bh=6GLsWyeixh0EBVyzT6eV5bWUmTy7p4GI8YUmQL
    Gpntw=; b=P9W0a1umbaS6rQwv2JO+oN5aBcxZYGhLWUQ3WG9bVlf1BIS3Lv/Ldx
    CIeGDp5eiCHoyfIlHZXG1b99Xmq6M+zqzbzXQhP80JuFRWRX+qTtjlu4UYz8xiBd
    IwWj62S0qYF02qDb6M6RsTDNVsFn3svVroVl96hyF7RXWrrg6DiiVqEPD90e0sN1
    KmRa8m+TLoGALO8HlJVyUYYkWLTxPnoB+zXypcwnxRJn17BvZ41SfEyTHEpdvyE0
    8mkdg8//VWFnunWt4pXOj1VIqJ4u5asMhX0rc1obwlRNKAuiCwjEfQHjxXy6zw0P
    aiQtvz1fduJ0n5/jMtIH7yzcNF7xdIqA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752687AbeCOOvL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 10:51:11 -0400
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:41920 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752634AbeCOOvK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Mar 2018 10:51:10 -0400
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "bp@suse.de" <bp@suse.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
Thread-Topic: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
Thread-Index: AQHTu76cmkz1ie7mb0G/9GXlGHy7daPQ6ewAgAB4qQA=
Date: Thu, 15 Mar 2018 14:51:06 +0000
Message-ID: <1521125462.2693.154.camel@hpe.com>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
         <20180314180155.19492-3-toshi.kani@hpe.com>
         <14cb9fdf-25de-6519-2200-43f585b64cdd@codeaurora.org>
In-Reply-To: <14cb9fdf-25de-6519-2200-43f585b64cdd@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.219.147.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DF4PR8401MB1145;6:8+UUQsUcy3ACopo/RyL0QN+A+7WrHLqriv+xsS198RoYhbefFlMNVCadh2kbD0hLe6La3RRvDnYOFQ6UuCpGgxgHMoKAE9tNo8HN6PfTdGHqMuTqXO30aGFL11VqYvtgGgBOy98IfEGDV06Yp/OPsFuVTpOkdQIisJguRo7spaSx+6IyXYft+DGQtb6I3pWJdml8F8N9D8174El0+wzIPz8Y/HPL2CcT4gapFGpaFIi0qGHjYlOCc97KBe89xcntVftc3l51cuHP730lKRUov0uRxZmZGWjsBtmkPEg+AUf6HS+EAcKnxYvc9r+RgkLuG1BIYtEssoVjYhT844pVsFaTMZfnNuvB1ueKs21fNCkiIILrDsHp3E3AJDGaINNR;5:eaB7ZX71251CuWWkN0WwqsfoknQYAIPmTPcLr/ur+zEw2/dBfh1NKtchx8Mcb30YRoYYkXv57Ixb4RINq3n/QNQLDAqdQIgWD+XTGkyo8w63I2DrTKCZBSxUjFL1Cf++DG1l6MQvCFCH72Kv03yYY4KBT/JLFqLcG01xl58Wl/A=;24:xlDb+yC0Rc+0SKH91gLrN/qsnw0a2KQLcR8xUrGkwp6PiCMTUW3m0PwI8gGPtbhA3MsJVMJ/vAOlfo+JjAJBD6ISTdoSqj+khfX9u/eubZE=;7:rzRbGVu1qjVfQbqIWYwbx7y/MR2OLaFLHOezIuI+4PhcpL3r7uczTgdLh85l/7orVdE8s2sk8idPltuxHKzjiaXnPV972cf6iKe8NPbLkoM/7P1sm8Y7r+o20kDSf9InfMTXx5/lY5M3n2XQGHSDGu15oIVgCbO9AJLFbjs+NI7nCt9Xf8RlgedOGSZchfJdKKpHzLT48syhu6RVgXWYzQS9VFG3LAj/Oudr92AaVemGoBL+ZotY+08Jsyskkc2u
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 17e0faba-78be-4b40-9633-08d58a842e8d
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:DF4PR8401MB1145;
x-ms-traffictypediagnostic: DF4PR8401MB1145:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <DF4PR8401MB11458E1B130EE5AB2093AA5F82D00@DF4PR8401MB1145.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(9452136761055)(222181515654134);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DF4PR8401MB1145;BCL:0;PCL:0;RULEID:;SRVR:DF4PR8401MB1145;
x-forefront-prvs: 0612E553B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(39380400002)(366004)(199004)(189003)(377424004)(3280700002)(105586002)(6506007)(26005)(2906002)(5660300001)(478600001)(14454004)(2501003)(53546011)(3660700001)(2201001)(102836004)(68736007)(3846002)(53936002)(86362001)(186003)(5250100002)(6246003)(76176011)(6116002)(7736002)(36756003)(106356001)(54906003)(6436002)(6486002)(25786009)(2950100002)(66066001)(4326008)(8936002)(81156014)(103116003)(110136005)(8676002)(6512007)(7416002)(305945005)(2900100001)(99286004)(97736004)(81166006)(229853002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:DF4PR8401MB1145;H:DF4PR8401MB0396.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 66t+iUKJWkILYyMD3h/vGsA293nvAgHuSI8Fezf+gNr8opaW/YJ1F+2JrOEkIfKun+nHghzasHyqE9JWoUalg2ov+DaLnIws+WFcGpNFzXHpZWhH8BQC3BcreTWTFtPW1T/zR6EVP0d2xTvBBCbJNXwDHEC6ssnwKY2/etUq5jcYYmyC8i5TWrgNCgUV5BS2cVF6Db8lNecXNbVwKAHO0PmWXYKNNnTzxZNSu6V6l8c4THzmLlhGaQtjQ1j6p2onmKg9pNa+kSa4o1hEh4NwCtmAv/vKqAThKEG+i5MjDUUjA1Zw+y5DbFXCD6BU/4b2SfLlkpvwH27MzTMzLhz2aw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B31960CADFB9D478D453187E9F7B27F@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e0faba-78be-4b40-9633-08d58a842e8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2018 14:51:06.3202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB1145
X-OriginatorOrg: hpe.com
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVGh1LCAyMDE4LTAzLTE1IGF0IDEzOjA5ICswNTMwLCBDaGludGFuIFBhbmR5YSB3cm90ZToN
Cj4gDQo+IE9uIDMvMTQvMjAxOCAxMTozMSBQTSwgVG9zaGkgS2FuaSB3cm90ZToNCj4gPiBJbXBs
ZW1lbnQgcHVkX2ZyZWVfcG1kX3BhZ2UoKSBhbmQgcG1kX2ZyZWVfcHRlX3BhZ2UoKSBvbiB4ODYs
IHdoaWNoDQo+ID4gY2xlYXIgYSBnaXZlbiBwdWQvcG1kIGVudHJ5IGFuZCBmcmVlIHVwIGxvd2Vy
IGxldmVsIHBhZ2UgdGFibGUocykuDQo+ID4gQWRkcmVzcyByYW5nZSBhc3NvY2lhdGVkIHdpdGgg
dGhlIHB1ZC9wbWQgZW50cnkgbXVzdCBoYXZlIGJlZW4gcHVyZ2VkDQo+ID4gYnkgSU5WTFBHLg0K
PiA+IA0KPiA+IGZpeGVzOiBlNjFjZTZhZGU0MDRlICgibW06IGNoYW5nZSBpb3JlbWFwIHRvIHNl
dCB1cCBodWdlIEkvTyBtYXBwaW5ncyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogVG9zaGkgS2FuaSA8
dG9zaGkua2FuaUBocGUuY29tPg0KPiA+IENjOiBNaWNoYWwgSG9ja28gPG1ob2Nrb0BzdXNlLmNv
bT4NCj4gPiBDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCj4g
PiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+ID4gQ2M6IEluZ28g
TW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPg0KPiA+IENjOiAiSC4gUGV0ZXIgQW52aW4iIDxocGFA
enl0b3IuY29tPg0KPiA+IENjOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQHN1c2UuZGU+DQo+ID4gQ2M6
IE1hdHRoZXcgV2lsY294IDx3aWxseUBpbmZyYWRlYWQub3JnPg0KPiA+IENjOiA8c3RhYmxlQHZn
ZXIua2VybmVsLm9yZz4NCj4gPiAtLS0NCj4gPiAgIGFyY2gveDg2L21tL3BndGFibGUuYyB8ICAg
MjggKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDI2
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L21tL3BndGFibGUuYyBiL2FyY2gveDg2L21tL3BndGFibGUuYw0KPiA+IGluZGV4IDFl
ZWQ3ZWQ1MThlNi4uMzRjZGE3ZTA1NTFiIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L21tL3Bn
dGFibGUuYw0KPiA+ICsrKyBiL2FyY2gveDg2L21tL3BndGFibGUuYw0KPiA+IEBAIC03MTIsNyAr
NzEyLDIyIEBAIGludCBwbWRfY2xlYXJfaHVnZShwbWRfdCAqcG1kKQ0KPiA+ICAgICovDQo+ID4g
ICBpbnQgcHVkX2ZyZWVfcG1kX3BhZ2UocHVkX3QgKnB1ZCkNCj4gPiAgIHsNCj4gPiAtCXJldHVy
biBwdWRfbm9uZSgqcHVkKTsNCj4gPiArCXBtZF90ICpwbWQ7DQo+ID4gKwlpbnQgaTsNCj4gPiAr
DQo+ID4gKwlpZiAocHVkX25vbmUoKnB1ZCkpDQo+ID4gKwkJcmV0dXJuIDE7DQo+ID4gKw0KPiA+
ICsJcG1kID0gKHBtZF90ICopcHVkX3BhZ2VfdmFkZHIoKnB1ZCk7DQo+ID4gKw0KPiA+ICsJZm9y
IChpID0gMDsgaSA8IFBUUlNfUEVSX1BNRDsgaSsrKQ0KPiA+ICsJCWlmICghcG1kX2ZyZWVfcHRl
X3BhZ2UoJnBtZFtpXSkpDQo+IA0KPiBUaGlzIGlzIGZvcmNlZCBhY3Rpb24gYW5kIG5vIG9wdGlv
bmFsLiBBbHNvLCBwbWRfZnJlZV9wdGVfcGFnZSgpDQo+IGRvZXNuJ3QgcmV0dXJuIDAgaW4gYW55
IGNhc2UuIFNvLCB5b3UgbWF5IHJlbW92ZSBfaWZfID8NCg0KVGhlIGNvZGUgbmVlZHMgdG8gYmUg
d3JpdHRlbiBwZXIgdGhlIGludGVyZmFjZSBkZWZpbml0aW9uLCBub3QgcGVyIHRoZQ0KY3VycmVu
dCBpbXBsZW1lbnRhdGlvbi4NCg0KPiA+ICsJCQlyZXR1cm4gMDsNCj4gPiArDQo+ID4gKwlwdWRf
Y2xlYXIocHVkKTsNCj4gPiArCWZyZWVfcGFnZSgodW5zaWduZWQgbG9uZylwbWQpOw0KPiA+ICsN
Cj4gPiArCXJldHVybiAxOw0KPiA+ICAgfQ0KPiA+ICAgDQo+ID4gICAvKioNCj4gPiBAQCAtNzI0
LDYgKzczOSwxNSBAQCBpbnQgcHVkX2ZyZWVfcG1kX3BhZ2UocHVkX3QgKnB1ZCkNCj4gPiAgICAq
Lw0KPiA+ICAgaW50IHBtZF9mcmVlX3B0ZV9wYWdlKHBtZF90ICpwbWQpDQo+ID4gICB7DQo+ID4g
LQlyZXR1cm4gcG1kX25vbmUoKnBtZCk7DQo+ID4gKwlwdGVfdCAqcHRlOw0KPiA+ICsNCj4gPiAr
CWlmIChwbWRfbm9uZSgqcG1kKSkNCj4gDQo+IFRoaXMgc2hvdWxkIGFsc28gY2hlY2sgaWYgcG1k
IGlzIGFscmVhZHkgaHVnZS4gU2FtZSBmb3IgcHVkID8NCg0KTm90IG5lY2Vzc2FyeS4gQXMgZGVz
Y3JpYmVkIGluIHRoZSBmdW5jdGlvbiBoZWFkZXIsIG9uZSBvZiB0aGUgZW50cnkNCmNvbmRpdGlv
bnMgaXMgdGhhdCBhIGdpdmVuIHBtZCByYW5nZSBpcyB1bm1hcHBlZC4gIFNlZQ0KdnVubWFwX3Bt
ZF9yYW5nZSgpLg0KDQpUaGFua3MsDQotVG9zaGkNCg==
