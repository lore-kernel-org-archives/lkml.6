Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233804-2-14153453451647384331
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233803; b=csoYIYOPTK3HVkIJTfnIeby4AGBc4JQ1IJX3cGyApltxM4r4Aj
    6YgVwrsjn+4AIFhqkgWfkc6Sm7wFPbYdTNUceANsQuu1t4MPFLP+GL6XYhcAk2NE
    hM6lWpspaFHssJpS7assc2f3aYACDyGkXIJCqtcwdpaz2dUJDhzjUWOp4QCUi607
    MMDe4T8DsToK4ua/hL4T6hvRGPtxbFUTIIXvaMUQu3y1i+3mrv6pHUVYRWmuPpW6
    U/1KtziP6TfGfdUd650hDa4/+V9vIiLMAHvxHfO41k66IeV9ufaC1QC1hXPe3vlW
    HRxS1tw84fkAG9cx7AOKf3Z3w5+4wOF0+qIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523233803; bh=bLZxxb9OrDITSScPDPe/npaGPGQwSKeSqi2Eb94SvpM=; b=
    A02CEeVA32XNJz/pOHwKeUzE/g2JqmGCU4v/bUhgVTKisRX1DH+NXdQ1lG9XkKxV
    VrARzxSgwvZ/wPQTQcEWuphq/cGUJTj1B79TF1M/8SLBfwVpSgTCvbBvMpwZHumO
    ZJICK/yoHBuTs1sSGHlZUx0kaz0usmnFI8FZuMzZRLSbiq+qYx6Hvprfj83Mmooo
    Yu3Hu/Lw/vAN3jPoSDQEIWmIxGoNaxhqxQfnknuC2vrRY2SFmgfv5ZBzUhrgouRg
    lJ1r6ib+AiCM6MVhtWeS72+5XmAV4hqjHgZmbl7fgkHUNmxV9bJ9KKudKNF1gTDH
    MhaXd2ftoEoMHUXW+zjxQA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=f75ec5Kk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=f75ec5Kk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIjmf9KdqdUGPhrw9LVkTD/CvkDjoN+bz86J/Ht+oGpEanGqncooe11M0OOuQvcsiUHOpoke02tpoUTfMNtpvbfVQXAToHCX9zJqRePhUHaG5TPgzkO0
    gWmxf7iUBYiny8WU00bIvy02Mi2NE6O0KevP+kLb92z4s3IjoNqmMT0O6KmZOqZXejo9AvJc/1clfGi3oGmN012DzSpPkwlakBlakXop2Q+k1ARw+XxM8/fW
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=DfNHnWVPAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8
    a=yMhMjlubAAAA:8 a=NNxdam4jXssEnxCv9nYA:9 a=MLcyE3zIsjVxBJJr:21
    a=Qn9xUNJF3qNZQCoP:21 a=QEXdDO2ut3YA:10 a=rjTVMONInIDnV1a_A2c_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbeDIA3j (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:29:39 -0400
Received: from mail-by2nam03on0107.outbound.protection.outlook.com ([104.47.42.107]:6816
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755997AbeDIA3g (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Kai Heng Feng <kai.heng.feng@canonical.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 106/293] platform/x86: dell-laptop: Fix bogus
 keyboard backlight sysfs interface
Thread-Topic: [PATCH AUTOSEL for 4.9 106/293] platform/x86: dell-laptop: Fix
 bogus keyboard backlight sysfs interface
Thread-Index: AQHTz5kX5IBk2wT7Q0qQPOqmts+89Q==
Date: Mon, 9 Apr 2018 00:24:16 +0000
Message-ID: <20180409002239.163177-106-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:7djEmrWv+9x/UW0zG3YpDKMYDm2xAVvyqh6pFlfIMVe9E/6GnJbe4wA1Nn9TtjMNJb/m9q0Dl66V7kRsB5lsn/7e7M+VMipyK1ArXBJOVZrJusW8v2v8kF08OyyRhpVLoW7T7EhuAJdvZ6vFiC2El23cvO7gVt/uPJ9yQTqVSzAU20BL+sdKq9msVIf/LWQ9km3HHtStGsVo2F/XEK52wNhbsis6FC8c/VgcPG2m9iVySrwtOvoG7yk5ErrSK0Pn;20:fvPylRhieKObbaJOoEffRUXVoVCArdTMzkaxy3xMoe4risHf3xoZ6V4nEDz8LpJxHgnXHH4DziiRRS/yM08YEVmrvy8gu4grULEEcJcgiR8Ifux6laN4BW1uyL1jT4DP7waxs3r2db6A1FjLJJ4ULiqlQsysJaUDDjJXYqaBf7g=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: dd469a9a-20da-4a8f-aa91-08d59db0f72b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB096768902396CCB636978A6CFBBF0@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(85827821059158)(198206253151910)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(39380400002)(346002)(199004)(189003)(6506007)(486006)(86362001)(14454004)(59450400001)(68736007)(102836004)(99286004)(26005)(3846002)(6116002)(186003)(476003)(2616005)(1076002)(3280700002)(86612001)(72206003)(4326008)(446003)(54906003)(76176011)(11346002)(2906002)(22452003)(3660700001)(110136005)(97736004)(316002)(6666003)(5660300001)(478600001)(8676002)(6512007)(8936002)(107886003)(6486002)(53936002)(81166006)(36756003)(81156014)(10290500003)(6436002)(10090500001)(25786009)(66066001)(106356001)(305945005)(7736002)(2501003)(5250100002)(105586002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: izd8nAn9nsCiP2YlH6uBXPoh+SOpeI3hPwEa8EPS1NOda+anFZIMZwxrOSBw7ryRzgn0/ThB5o5teihpbM3Z6uW1sKrvvRJnwZ3cPI67IoJCPmj7deG174tVc7nqQlhX5m5CZAGy6ZvjYjENJHztu7yyoEacvSOQHWYqaMTT/S59edMadYYrXbEtzWFzlSxiGQhMrhrlzhwreOSqIz6WDLvudpupmTYMPAPU2jkPHXjxmNEaXcaVWAl2l7PO2zJNlEll42LBQ0INHjZ1jWOtFoCkuJqEDKduBa1qbIpLKrRDDsqYrqF1hhc4eJ6ataChnZIh2ywg2eR7wNVLYey6mqym0pMLQrRU2kDmOrrzKye3LXI04yS58DOuW7xUppXYf37UNTFfcpLaVGr021u8gvIpJ18zHd9D9n9GboEgKqc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <403F5352981C774CA24B00C547D69715@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd469a9a-20da-4a8f-aa91-08d59db0f72b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:16.3781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogS2FpIEhlbmcgRmVuZyA8a2FpLmhlbmcuZmVuZ0BjYW5vbmljYWwuY29tPg0KDQpbIFVw
c3RyZWFtIGNvbW1pdCAxYjFmZmM1N2ExYjJlZGY1OGU4MDNlNDYzOTgwYjMyNjc2NWEyMzdmIF0N
Cg0KRGVsbCBMYXRpdHVkZSAzMTYwIGRvZXMgbm90IGhhdmUga2V5Ym9hcmQgYmFja2xpZ2h0LCBi
dXQgdGhlcmUgaXMgYQ0Kc3lzZnMgaW50ZXJmYWNlIGZvciBpdCwgd2hpY2ggZG9lcyBub3RoaW5n
IGF0IGFsbC4NCg0KS0JEX0xFRF9PTl9UT0tFTiBpcyB0aGUgb25seSB0b2tlbiBjYW4gYmUgZm91
bmQuIFNpbmNlIGl0IGRvZXNuJ3QgaGF2ZQ0KS0JEX0xFRF9PRkZfVE9LRU4gb3IgS0JEX0xFRF9B
VVRPXypfVE9LRU4sIGl0IHNob3VsZCBiZSBzYWZlIHRvIGFzc3VtZQ0KYXQgbGVhc3QgdHdvIHRv
a2VucyBzaG91bGQgYmUgcHJlc2VudCB0byBzdXBwb3J0IGtleWJvYXJkIGJhY2tsaWdodC4NCk5v
dCBhbGwgbW9kZWxzIGhhdmUgT04gdG9rZW4gLSB0aGV5IG1heSBoYXZlIG11bHRpcGxlIEFVVE8g
dG9rZW5zIGluc3RlYWQuDQoNCk1vZGVscyB3aGljaCBkbyBub3QgdXNlIFNNQklPUyB0b2tlbiB0
byBjb250cm9sIGtleWJvYXJkIGJhY2tsaWdodCwgYWxzbw0KaGF2ZSB0aGlzIGlzc3VlLiBCcmln
aHRuZXNzIGxldmVsIGlzIDAgb24gdGhlc2UgbW9kZWxzLiBWZXJpZmllZCBvbiBEZWxsDQpJbnNw
aXJvbiAzNTY1Lg0KDQpSZXBvcnRzIGtleWJvYXJkIGJhY2tsaWdodCBpcyBzdXBwb3J0ZWQgb25s
eSB3aGVuIGF0IGxlYXN0IHR3byBtb2RlcyBhcmUNCnByZXNlbnQuDQoNClNpZ25lZC1vZmYtYnk6
IEthaS1IZW5nIEZlbmcgPGthaS5oZW5nLmZlbmdAY2Fub25pY2FsLmNvbT4NClJldmlld2VkLWJ5
OiBQYWxpIFJvaMOhciA8cGFsaS5yb2hhckBnbWFpbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBBbmR5
IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NClNpZ25lZC1v
ZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWljcm9zb2Z0LmNvbT4NCi0tLQ0K
IGRyaXZlcnMvcGxhdGZvcm0veDg2L2RlbGwtbGFwdG9wLmMgfCA2ICsrKysrLQ0KIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGxhdGZvcm0veDg2L2RlbGwtbGFwdG9wLmMgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9k
ZWxsLWxhcHRvcC5jDQppbmRleCAxNjdkNTA0MmE2MjkuLjE3NTIzNWZhNzViYyAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2RlbGwtbGFwdG9wLmMNCisrKyBiL2RyaXZlcnMvcGxh
dGZvcm0veDg2L2RlbGwtbGFwdG9wLmMNCkBAIC0xNDg2LDcgKzE0ODYsMTEgQEAgc3RhdGljIHZv
aWQga2JkX2luaXQodm9pZCkNCiAJcmV0ID0ga2JkX2luaXRfaW5mbygpOw0KIAlrYmRfaW5pdF90
b2tlbnMoKTsNCiANCi0JaWYgKGtiZF90b2tlbl9iaXRzICE9IDAgfHwgcmV0ID09IDApDQorCS8q
DQorCSAqIE9ubHkgc3VwcG9ydHMga2V5Ym9hcmQgYmFja2xpZ2h0IHdoZW4gaXQgaGFzIGF0IGxl
YXN0IHR3byBtb2Rlcy4NCisJICovDQorCWlmICgocmV0ID09IDAgJiYgKGtiZF9pbmZvLmxldmVs
cyAhPSAwIHx8IGtiZF9tb2RlX2xldmVsc19jb3VudCA+PSAyKSkNCisJICAgIHx8IGtiZF9nZXRf
dmFsaWRfdG9rZW5fY291bnRzKCkgPj0gMikNCiAJCWtiZF9sZWRfcHJlc2VudCA9IHRydWU7DQog
fQ0KIA0KLS0gDQoyLjE1LjENCg==
