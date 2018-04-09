Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246794-2-8098848802360777476
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523246794; b=imcQtm297ST2f28OdBuxvRDEa1BEcMq3cZ4r+MrN1i5jHp33xf
    43oG8Kut5cMg83AE5G3zXRAos98c1XufKRPGnaxYNqfWWL+ZJQwVPYHe0V4+5aEr
    sWvXir+aAfLx66NosYndDRS9PyU4D0noBb/SlrhOlNSqreib2p78YNlJVl5swhyh
    Eij3hkGIHz1AeTjCisKS+BrVqz4drN9daTMEBfjmmX1sj7kUBlhh0IqqISHzXzLG
    jw0ftfkpyRXzqiSxYbyJ5paMqMXTG0CMor56lvh5ao1DILuAxWfZuf0T/Eunmtxx
    NHNIp1nJsIN7r89WMDIYamFUq9elNPpDALgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523246794; bh=w6ggzqsSifYUItn8DxFz1dke6KeIBE94EDrLTuIIpIc=; b=
    R6UmWkZSyWZglHpIvgEyvU3qrgAgjkVVhl6N2tQ3f44dC5Eff/IWnCcuE0OVWQNN
    F+z4H5FMroVfKD/zukTzNmXEDJm7EDG9PHBjMpMECvbbgh/XuA96f9o0irjfaTKT
    wng4gmjmxOoVQynx82XllbcdAtj8faP5UFqQVH1bfW7ODJSUgTEXRqvb3/ASSdtk
    G7FQeuXLcmhW5bdXWZi1TWdThSPqufuggrCI2RdKkYwMcwNWyFkGFpMYdZF3boPf
    HhqeIBMWweYXgG426op8eDO/DuBtRyMviWo+jI2Me7dJ+JVBO3uDyu26N8z//V/m
    KCz08VUWcyHWPhYoqzjOgw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LHKeu3tb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LHKeu3tb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAIGKn0wN8P0qCFfV2SvJbNtOlaNlZmxRmTruHXXzm1Od9PNmBjWUe8PL8+oihNnC/nLapZneHiYk1U5eSodAoIDwgz7yVJrsKJn5SGtQfovbX+yYN+N
    EPl1IMhk+DX/4dGvtgrxx2W4CJ+sNa3g1Qh+CRiRvaDoZv+P6LuxDsEXJ5IfTTAQGpZiYSs/5yOykmL1ns/+vFR76YihuUlS7b7ZDG8Q93k7X1mfu/Zk1UaQ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=tBb2bbeoAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8
    a=fGZEGPJtKAgip5Mm1HkA:9 a=QEXdDO2ut3YA:10 a=Oj-tNtZlA1e06AYgeCfH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeDIEGS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:06:18 -0400
Received: from mail-bl2nam02on0131.outbound.protection.outlook.com ([104.47.38.131]:5451
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753236AbeDIARw (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 040/189] ubifs: Fix uninitialized variable in
 search_dh_cookie()
Thread-Topic: [PATCH AUTOSEL for 4.15 040/189] ubifs: Fix uninitialized
 variable in search_dh_cookie()
Thread-Index: AQHTz5geF7X6zLnfMkqhLrLXSlV8mA==
Date: Mon, 9 Apr 2018 00:17:17 +0000
Message-ID: <20180409001637.162453-40-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:55TBRcu3czZEZsvRgZCL9mg+ptX+OLlbf8KTRunDN/mCqMqdMT4oMtVRnNRhNNyJ4Xat83nUExMlw5bdpudUqKT2sTihybyIkKQmuu1AFDy9FEBxFJMZbwYGurXOv7OMqQjR00DLHYsVZ7YZVVXOk1VmjJCYYTsnsWRLONUUABJnjlc5Voo2ivmFrpZWsYG5KK/XG3qQZ9KjceLQsL2D79wq4FJ/fzbmraSWKPkGEg1YyWasR+65LWuYtQo/7RRe;20:v6nQTdbUi8eGTpnXZCkmOmR3JF241vKoqo/lRR2zbHLHy1OwhONXgndWGP9Ee15sZGQ8rINnz4Z0BQRe2MMuTfTiQWzXsgOS4Z+jxpH35ioY9ByvPv4OtdTvRKRKA366vbX7HTXoxRq66ooVsk7CoDW7Vau6O2OxDHd/qiYTN48=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 98c41901-766d-46ea-8a06-08d59daf51cb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10488F4126D7F869D9DDFCCDFBBF0@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(346002)(396003)(189003)(199004)(86362001)(1076002)(575784001)(99286004)(6116002)(110136005)(3846002)(54906003)(22452003)(3280700002)(105586002)(2906002)(76176011)(4326008)(6512007)(6436002)(6486002)(3660700001)(6666003)(7736002)(59450400001)(86612001)(25786009)(2900100001)(14454004)(97736004)(53936002)(107886003)(68736007)(102836004)(36756003)(6506007)(26005)(186003)(106356001)(305945005)(5250100002)(72206003)(478600001)(2501003)(10290500003)(81166006)(5660300001)(8676002)(66066001)(316002)(81156014)(2616005)(10090500001)(11346002)(446003)(476003)(8936002)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: krf73yoVTR08OFeCmzI/81eStLMjldUt7nQ/NugcgapSlXMMpS+O53wFXlg7ew+wLr9x8TCIbr70FOSuKZOTMtkx29qF/Sqbqnp9+XRPhiV1ve3gVk/cSWwz3idwkOWwlm4p/Y88QsyjerGIAENrXde67Xsx/GUJj7ADOWWa82669SGbDdZM6rs3rhdsbl7feYndMg/CLGXT5/eCH9WjolPrGmtYzRuRcupTEp4gDz6mTpG2jHaLX2qlwrvuhnp3wHfJzBCHgwUhXne3qmPz4XIimi06lMvQI4NO0kopkUAPnioHjnq5agx/HCu3IY5Fm64oi6f9tUiw7EwM4v16myfSCmTSxe2P+KTo6v6rlK/g9a8Lx0Tt46eA4ae6FF+mvgcjKudfIK1r7df4uzMTPhr0FGV7q12ghOJcGWS0RV0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <88DB8D7BF075884EB65C2D8AB5D1D93A@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c41901-766d-46ea-8a06-08d59daf51cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:17.8857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCg0KWyBVcHN0
cmVhbSBjb21taXQgYzg3NzE1NGQzMDdmNGE5MWUwYjViODViNzU1MzU3MTNkYWI5NDVhZSBdDQoN
CmZzL3ViaWZzL3RuYy5jOiBJbiBmdW5jdGlvbiDigJhzZWFyY2hfZGhfY29va2ll4oCZOg0KZnMv
dWJpZnMvdG5jLmM6MTg5Mzogd2FybmluZzog4oCYZXJy4oCZIGlzIHVzZWQgdW5pbml0aWFsaXpl
ZCBpbiB0aGlzIGZ1bmN0aW9uDQoNCkluZGVlZCwgZXJyIGlzIGFsd2F5cyB1c2VkIHVuaW5pdGlh
bGl6ZWQuDQoNCkFjY29yZGluZyB0byBhbiBvcmlnaW5hbCByZXZpZXcgY29tbWVudCBmcm9tIEh5
dW5jaHVsLCBhY2tub3dsZWRnZWQgYnkNClJpY2hhcmQsIGVyciBzaG91bGQgYmUgaW5pdGlhbGl6
ZWQgdG8gLUVOT0VOVCB0byBhdm9pZCB0aGUgZmlyc3QgY2FsbCB0bw0KdG5jX25leHQoKS4gIEJ1
dCB3ZSBjYW4gYWNoaWV2ZSB0aGUgc2FtZSBieSByZW9yZGVyaW5nIHRoZSBjb2RlLg0KDQpGaXhl
czogNzgxZjY3NWUyZDdlICgidWJpZnM6IEZpeCB1bmxpbmsgY29kZSB3cnQuIGRvdWJsZSBoYXNo
IGxvb2t1cHMiKQ0KUmVwb3J0ZWQtYnk6IEh5dW5jaHVsIExlZSA8aHljLmxlZUBnbWFpbC5jb20+
DQpTaWduZWQtb2ZmLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3Jn
Pg0KU2lnbmVkLW9mZi1ieTogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD4NClNp
Z25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWljcm9zb2Z0LmNvbT4N
Ci0tLQ0KIGZzL3ViaWZzL3RuYy5jIHwgMjEgKysrKysrKy0tLS0tLS0tLS0tLS0tDQogMSBmaWxl
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9mcy91Ymlmcy90bmMuYyBiL2ZzL3ViaWZzL3RuYy5jDQppbmRleCAwYTIxM2RjYmEyYTEuLmJh
M2QwZTBmODYxNSAxMDA2NDQNCi0tLSBhL2ZzL3ViaWZzL3RuYy5jDQorKysgYi9mcy91Ymlmcy90
bmMuYw0KQEAgLTE4OTAsMzUgKzE4OTAsMjggQEAgc3RhdGljIGludCBzZWFyY2hfZGhfY29va2ll
KHN0cnVjdCB1Ymlmc19pbmZvICpjLCBjb25zdCB1bmlvbiB1Ymlmc19rZXkgKmtleSwNCiAJdW5p
b24gdWJpZnNfa2V5ICpka2V5Ow0KIA0KIAlmb3IgKDs7KSB7DQotCQlpZiAoIWVycikgew0KLQkJ
CWVyciA9IHRuY19uZXh0KGMsICZ6bm9kZSwgbik7DQotCQkJaWYgKGVycikNCi0JCQkJZ290byBv
dXQ7DQotCQl9DQotDQogCQl6YnIgPSAmem5vZGUtPnpicmFuY2hbKm5dOw0KIAkJZGtleSA9ICZ6
YnItPmtleTsNCiANCiAJCWlmIChrZXlfaW51bShjLCBka2V5KSAhPSBrZXlfaW51bShjLCBrZXkp
IHx8DQogCQkgICAga2V5X3R5cGUoYywgZGtleSkgIT0ga2V5X3R5cGUoYywga2V5KSkgew0KLQkJ
CWVyciA9IC1FTk9FTlQ7DQotCQkJZ290byBvdXQ7DQorCQkJcmV0dXJuIC1FTk9FTlQ7DQogCQl9
DQogDQogCQllcnIgPSB0bmNfcmVhZF9oYXNoZWRfbm9kZShjLCB6YnIsIGRlbnQpOw0KIAkJaWYg
KGVycikNCi0JCQlnb3RvIG91dDsNCisJCQlyZXR1cm4gZXJyOw0KIA0KIAkJaWYgKGtleV9oYXNo
KGMsIGtleSkgPT0ga2V5X2hhc2goYywgZGtleSkgJiYNCiAJCSAgICBsZTMyX3RvX2NwdShkZW50
LT5jb29raWUpID09IGNvb2tpZSkgew0KIAkJCSp6biA9IHpub2RlOw0KLQkJCWdvdG8gb3V0Ow0K
KwkJCXJldHVybiAwOw0KIAkJfQ0KLQl9DQotDQotb3V0Og0KIA0KLQlyZXR1cm4gZXJyOw0KKwkJ
ZXJyID0gdG5jX25leHQoYywgJnpub2RlLCBuKTsNCisJCWlmIChlcnIpDQorCQkJcmV0dXJuIGVy
cjsNCisJfQ0KIH0NCiANCiBzdGF0aWMgaW50IGRvX2xvb2t1cF9kaChzdHJ1Y3QgdWJpZnNfaW5m
byAqYywgY29uc3QgdW5pb24gdWJpZnNfa2V5ICprZXksDQotLSANCjIuMTUuMQ0K
