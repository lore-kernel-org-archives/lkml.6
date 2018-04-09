Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523244399-2-15548447103496935817
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523244398; b=a5tSsanPSB8QsKppp1XxEiwjgj26qNdP+U1JJUT0dZQTzJNrNg
    GdwpkAXy524pR9meIBuT7ZwN1nVUuTfxfedtyRHyOJPdC2eqyaJBvTLYDNImBeXy
    hJGxYsRGsCQFrmAAOqKUPDAY7Pa2HIBRGHIeEIvBUL33hK+35ezs/PN5qdE1qZWk
    8B93WV85db95Uo3e4r8s370vMyaETMnxZ5zZn7T5dMcgjVpxi790hcfWznz/iuNo
    4NRBp2VJJl7ZLQeGygAFcE47MNDRsPKJEvizw51hw1DrpdpB6krm750nCnoualBA
    v6rsDP2eP56XYGmZYKulQOymt9u+MpTgPrvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523244398; bh=gA1NwsxNHO8M8hdwumij37By7D5iV0CG5C4S6wq3n1k=; b=
    ejtsdeZa4Bxi0Zs6iUELaNIB4EZSe0Frz8p/pWso8l93fB7yUYTSM+MiFZDzMTot
    ra+2UlMCtK1gHQMhQQYgWbmdd5Z2OPWCdHUjRCytzFKSMl+isITw+2cx2sUoqQor
    BkGqHs65gOFpGjkEcPkSIF9aJ181KOd7chgs7BfK5A1SZ+J4KyD4aiPBk6sYDgA9
    zd9tcK3st8CiXtcZoOxqBkZ5smdnfmz0MR1L2UrYWxIda6PKst05BJwjDuj8KUKq
    SZA9NTOd7bA9Sbg9QfPnLGLK2GGDzUAEApzQnf2Fc/poZS+BOH5jHrOHVPq5Ydm+
    f15k91REY0zPEQ8DxiejDQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SXl2npBP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SXl2npBP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBO1I9k3uOK63YR3yY9iU7vZrBx2WjgHZDpmJ+xa8Anho1wFlTCwfTosJHfwvxMYVmMNKNQNsZUIn5GTkHwMJ+4YVPW/akW0+71aHuNLMRNw9XET4Mv/
    KWRxhpEE+PyzZlmGqcoUGgCjRgkN1GHSI0AEMp0MjaQkAe2y0SGrLUExl0tkVWm4hRfKsCemEDLFXlqb4FLujQsFZSUHWtIM+3zgFI7mBaUCQgWLrBeN84wq
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8
    a=yMhMjlubAAAA:8 a=iYBqROrJM-20mFt28jwA:9 a=GdNakm-1_ZxDm1rf:21
    a=54aOE-0-7H9qIBq9:21 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754337AbeDID0L (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:26:11 -0400
Received: from mail-sn1nam02on0111.outbound.protection.outlook.com ([104.47.36.111]:52845
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754627AbeDIAWJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 013/161] platform/x86: dell-laptop: Filter
 out spurious keyboard backlight change events
Thread-Topic: [PATCH AUTOSEL for 4.14 013/161] platform/x86: dell-laptop:
 Filter out spurious keyboard backlight change events
Thread-Index: AQHTz5h5a3eLbKAGiE+pEShnJAYPxA==
Date: Mon, 9 Apr 2018 00:19:51 +0000
Message-ID: <20180409001936.162706-13-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:bKlk41P4tbaByaCXgamT6cT6S5gtFIsGt6HBFajY9Xe41vhXS1ClUgX+uvpwRfYa3Sp/pOL3GoWm7ANM3pp1oUwozEG3n0J/oHJ9NHJRppjEGOds8IGdI7I3BmW3nPTCbXTn7IdVzquVRUrJWXknFt9AVaR4i5j+JLcFii/C/ey+cT9SG5SzjrO8B7sVjJZAXIH2mma/BRHVaYRgyTeBRaj4dI5QBQwGZOECOZWuhxERESZPQkZTvp6ifQs4UaiB;20:NoRdcTGTwcCz/lOVnEtDRSVcCFYjA5Rnv4cNXFS1vM/2KIBkaRUjUBJk4adT3mz7I7ypf5KaQvKIJhXFqTsnRa7nC2gmdoEpHMezkldj6rOymFJzKmTslfu9BZRd5VSIWxjRx2Gnuhx8SFQoP+pLrmyI/qCHhJ5bzDj3loRfYyg=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f95b1f3-9f52-44ff-dae6-08d59dafeabb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0936C928D73EA42024B15C2EFBBF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(83566789882024)(211171220733660)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(396003)(376002)(366004)(199004)(189003)(3660700001)(36756003)(2501003)(76176011)(10290500003)(2616005)(5250100002)(3280700002)(478600001)(1076002)(72206003)(6436002)(53936002)(486006)(6306002)(476003)(4326008)(6486002)(107886003)(5660300001)(54906003)(110136005)(102836004)(2906002)(6116002)(3846002)(86612001)(81156014)(81166006)(6666003)(8936002)(305945005)(8676002)(2900100001)(6506007)(68736007)(14454004)(106356001)(105586002)(25786009)(966005)(6512007)(86362001)(99286004)(446003)(59450400001)(10090500001)(11346002)(316002)(26005)(7736002)(66066001)(186003)(22452003)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: MeoAKLUmcERRJbAhqbY9QZfKkAkSRC7Q54vlzdOY/aTX++tFiICwLOGfL66R/Zr5OVcGs0TgD0JyOGWWrJj7+nnS6xmq5sWz++uPXaP7VDknhI4eskekI0oYI5Iku2eZSQWUiO5IctsKzfYJayxTPvBgahvqyAIJ19aZb08omosqwqtFyk2/1NYt3fp5hW/IDhqi/33H7t2SaSZlMtkesfDSEjERAtT0pgqhkSX+ocXeNo6oabWArV27n4hzGkzWR6WqHeRF9qyCFNkvwcHZBoyRDQDoeY2JSIm6qP/m0em3HKsuLEDjWMkXvVnQzcsVRWzXuKRbhOobr+SXK5YAK94L0ge2fEfU2vDMWJckI0tVv7FGcZM+gRp3jKZvU6pHqx4/pNB1iGncZLPb8ZJ4L4YU0HAWWSo4aQyVw+pi6dI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB0552F4649A794095A18809079B94F2@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f95b1f3-9f52-44ff-dae6-08d59dafeabb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:51.3638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4NCg0KWyBVcHN0cmVhbSBj
b21taXQgNGQ2YmRlNTEyYTg2YzMyZGYzYTFmMjg5ZDJiNGNkMDRiMTc3NThkMSBdDQoNCk9uIHNv
bWUgRGVsbCBYUFMgbW9kZWxzIFdNSSBldmVudHMgb2YgdHlwZSAweDAwMDAgcmVwb3J0aW5nIGEg
a2V5Y29kZSBvZg0KMHhlMDBjIGdldCByZXBvcnRlZCB3aGVuIHRoZSBicmlnaHRuZXNzIG9mIHRo
ZSBMQ0QgcGFuZWwgY2hhbmdlcy4NCg0KVGhpcyBsZWFkcyB0byB1cyByZXBvcnRpbmcgZmFsc2Ut
cG9zaXRpdmUga2JkX2xlZCBjaGFuZ2UgZXZlbnRzIHRvDQp1c2Vyc3BhY2Ugd2hpY2ggaW4gdHVy
biBsZWFkcyB0byB0aGUga2JkIGJhY2tsaWdodCBPU0Qgc2hvd2luZyB3aGVuIGl0DQpzaG91bGQg
bm90Lg0KDQpXZSBhbHJlYWR5IHJlYWQgdGhlIGN1cnJlbnQga2V5Ym9hcmQgYmFja2xpZ2h0IGJy
aWdodG5lc3MgdmFsdWUgd2hlbg0KcmVwb3J0aW5nIGV2ZW50cyBiZWNhdXNlIHRoZSBsZWRfY2xh
c3NkZXZfbm90aWZ5X2JyaWdodG5lc3NfaHdfY2hhbmdlZA0KQVBJIHJlcXVpcmVzIHRoaXMuIENv
bXBhcmUgdGhpcyB2YWx1ZSB0byB0aGUgbGFzdCBrbm93biB2YWx1ZSBhbmQgZmlsdGVyDQpvdXQg
ZHVwbGljYXRlIGV2ZW50cywgZml4aW5nIHRoaXMuDQoNCk5vdGUgdGhlIGZpeGVkIGlzc3VlIGlz
IGVzcC4gYSBwcm9ibGVtIG9uIFhQUyBtb2RlbHMgd2l0aCBhbiBhbWJpZW50IGxpZ2h0DQpzZW5z
b3IgYW5kIGF1dG9tYXRpYyBicmlnaHRuZXNzIGFkanVzdG1lbnRzIHR1cm5lZCBvbiwgdGhpcyBj
YXVzZXMgdGhlIGtiZA0KYmFja2xpZ2h0IE9TRCB0byBzaG93IGFsbCB0aGUgdGltZSB0aGVyZS4N
Cg0KQnVnTGluazogaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNnaT9pZD0x
NTE0OTY5DQpGaXhlczogOWM2NTZiMDc5OSAoInBsYXRmb3JtL3g4NjogZGVsbC0qOiBDYWxsIG5l
dyBsZWQgaHdfY2hhbmdlZCBBUEkgLi4uIikNCkFja2VkLWJ5OiBQYWxpIFJvaMOhciA8cGFsaS5y
b2hhckBnbWFpbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUBy
ZWRoYXQuY29tPg0KU2lnbmVkLW9mZi1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNo
ZW5rb0BsaW51eC5pbnRlbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFu
ZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQotLS0NCiBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9kZWxs
LWxhcHRvcC5jIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKy0tDQogMSBmaWxlIGNoYW5nZWQs
IDIyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3BsYXRmb3JtL3g4Ni9kZWxsLWxhcHRvcC5jIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvZGVsbC1s
YXB0b3AuYw0KaW5kZXggNzQyNGU1MzE1N2IwLi5kZDUwNDNhNmExMTQgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL3BsYXRmb3JtL3g4Ni9kZWxsLWxhcHRvcC5jDQorKysgYi9kcml2ZXJzL3BsYXRmb3Jt
L3g4Ni9kZWxsLWxhcHRvcC5jDQpAQCAtMTE3Nyw2ICsxMTc3LDcgQEAgc3RhdGljIHU4IGtiZF9w
cmV2aW91c19tb2RlX2JpdDsNCiANCiBzdGF0aWMgYm9vbCBrYmRfbGVkX3ByZXNlbnQ7DQogc3Rh
dGljIERFRklORV9NVVRFWChrYmRfbGVkX211dGV4KTsNCitzdGF0aWMgZW51bSBsZWRfYnJpZ2h0
bmVzcyBrYmRfbGVkX2xldmVsOw0KIA0KIC8qDQogICogTk9URTogdGhlcmUgYXJlIHRocmVlIHdh
eXMgdG8gc2V0IHRoZSBrZXlib2FyZCBiYWNrbGlnaHQgbGV2ZWwuDQpAQCAtMjAyMCw2ICsyMDIx
LDcgQEAgc3RhdGljIGVudW0gbGVkX2JyaWdodG5lc3Mga2JkX2xlZF9sZXZlbF9nZXQoc3RydWN0
IGxlZF9jbGFzc2RldiAqbGVkX2NkZXYpDQogc3RhdGljIGludCBrYmRfbGVkX2xldmVsX3NldChz
dHJ1Y3QgbGVkX2NsYXNzZGV2ICpsZWRfY2RldiwNCiAJCQkgICAgIGVudW0gbGVkX2JyaWdodG5l
c3MgdmFsdWUpDQogew0KKwllbnVtIGxlZF9icmlnaHRuZXNzIG5ld192YWx1ZSA9IHZhbHVlOw0K
IAlzdHJ1Y3Qga2JkX3N0YXRlIHN0YXRlOw0KIAlzdHJ1Y3Qga2JkX3N0YXRlIG5ld19zdGF0ZTsN
CiAJdTE2IG51bTsNCkBAIC0yMDQ5LDYgKzIwNTEsOSBAQCBzdGF0aWMgaW50IGtiZF9sZWRfbGV2
ZWxfc2V0KHN0cnVjdCBsZWRfY2xhc3NkZXYgKmxlZF9jZGV2LA0KIAl9DQogDQogb3V0Og0KKwlp
ZiAocmV0ID09IDApDQorCQlrYmRfbGVkX2xldmVsID0gbmV3X3ZhbHVlOw0KKw0KIAltdXRleF91
bmxvY2soJmtiZF9sZWRfbXV0ZXgpOw0KIAlyZXR1cm4gcmV0Ow0KIH0NCkBAIC0yMDc2LDYgKzIw
ODEsOSBAQCBzdGF0aWMgaW50IF9faW5pdCBrYmRfbGVkX2luaXQoc3RydWN0IGRldmljZSAqZGV2
KQ0KIAkJaWYgKGtiZF9sZWQubWF4X2JyaWdodG5lc3MpDQogCQkJa2JkX2xlZC5tYXhfYnJpZ2h0
bmVzcy0tOw0KIAl9DQorDQorCWtiZF9sZWRfbGV2ZWwgPSBrYmRfbGVkX2xldmVsX2dldChOVUxM
KTsNCisNCiAJcmV0ID0gbGVkX2NsYXNzZGV2X3JlZ2lzdGVyKGRldiwgJmtiZF9sZWQpOw0KIAlp
ZiAocmV0KQ0KIAkJa2JkX2xlZF9wcmVzZW50ID0gZmFsc2U7DQpAQCAtMjEwMCwxMyArMjEwOCwy
NSBAQCBzdGF0aWMgdm9pZCBrYmRfbGVkX2V4aXQodm9pZCkNCiBzdGF0aWMgaW50IGRlbGxfbGFw
dG9wX25vdGlmaWVyX2NhbGwoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYiwNCiAJCQkJICAgICB1
bnNpZ25lZCBsb25nIGFjdGlvbiwgdm9pZCAqZGF0YSkNCiB7DQorCWJvb2wgY2hhbmdlZCA9IGZh
bHNlOw0KKwllbnVtIGxlZF9icmlnaHRuZXNzIG5ld19rYmRfbGVkX2xldmVsOw0KKw0KIAlzd2l0
Y2ggKGFjdGlvbikgew0KIAljYXNlIERFTExfTEFQVE9QX0tCRF9CQUNLTElHSFRfQlJJR0hUTkVT
U19DSEFOR0VEOg0KIAkJaWYgKCFrYmRfbGVkX3ByZXNlbnQpDQogCQkJYnJlYWs7DQogDQotCQls
ZWRfY2xhc3NkZXZfbm90aWZ5X2JyaWdodG5lc3NfaHdfY2hhbmdlZCgma2JkX2xlZCwNCi0JCQkJ
CQlrYmRfbGVkX2xldmVsX2dldCgma2JkX2xlZCkpOw0KKwkJbXV0ZXhfbG9jaygma2JkX2xlZF9t
dXRleCk7DQorCQluZXdfa2JkX2xlZF9sZXZlbCA9IGtiZF9sZWRfbGV2ZWxfZ2V0KCZrYmRfbGVk
KTsNCisJCWlmIChrYmRfbGVkX2xldmVsICE9IG5ld19rYmRfbGVkX2xldmVsKSB7DQorCQkJa2Jk
X2xlZF9sZXZlbCA9IG5ld19rYmRfbGVkX2xldmVsOw0KKwkJCWNoYW5nZWQgPSB0cnVlOw0KKwkJ
fQ0KKwkJbXV0ZXhfdW5sb2NrKCZrYmRfbGVkX211dGV4KTsNCisNCisJCWlmIChjaGFuZ2VkKQ0K
KwkJCWxlZF9jbGFzc2Rldl9ub3RpZnlfYnJpZ2h0bmVzc19od19jaGFuZ2VkKCZrYmRfbGVkLA0K
KwkJCQkJCQkJa2JkX2xlZF9sZXZlbCk7DQogCQlicmVhazsNCiAJfQ0KIA0KLS0gDQoyLjE1LjEN
Cg==
