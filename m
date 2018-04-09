Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233487-2-8242966012393797053
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233486; b=eAmTjFaOuPatc24YN/oQDNArxFkukTAanxK1JOWaCzQBFhasDw
    L/zHyeQXqLTGiU6SNhSblgIydTkcI9ZSYMltoaGj9dItNUPt23gxVK2oOgIKp41V
    GMbKJoJjJrCFmHJqsnlbgA1HAW9RUea89eguX5k6Oz2ThqgEMqHAKPUZWyZaEn9v
    V2HawHsS/um50ZFtQp3sit9LbtwIuOc3lLZ+BPTvSRs5UNHzWCK2gjnPwF9G1qb5
    0KBFP0Ta7G3FvOrBFqiief3WfYb4AogUaltJoQRpIQIC3VcpG6pbPwR+lV9Qnw8d
    omDb+gyoOai6x8U2RDkNjXJacIA0SVcMQuhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523233486; bh=L8BtSRv3Ukn9qqhmC93Xxh2nTxOrg5YLXgFvEXq6nPE=; b=
    MiV+ITpb+3RCKrIUlAk1cqCVAbjL9575HF2zm+I47e7INSOxMxSGHgcsgaBkX+g5
    DHIQmVspXlm7P6Za24hsAUBIAZaH5DRK/itQJ6nHOOMtO1IF7+iiXmuUoytJMg8Q
    iddcVMqUchqkzbBHo0P0gbW1y51ja/IfbB/o0vO/AaDZsc5HH4PUi/qdtXquoJq2
    feDu7OpKxvOvkBhqnKH53s8Ejpml7albw/vvz4s7eKGOaVIhCMv05/X2WI/Ywt2J
    CSRKos9+GbjqwfzA7ikgYz7kYuD+8N47tJTYEIWzhkgasXirOLlqnIMX/jpKCgbC
    jmQuAWcqZ4UXNd0DoFtvXA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=amma84v7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=amma84v7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLnwADynLdlGpLNYkNSyEpTB2Rs4C2EJrc/KMrwyXzreax/D5QIhMgBLnhkHu46M+iaYs4nwgj4GhOFKIXHCf9XwcOBUrQ0QVjJUhObFiHWMPeL/na9C
    Ctnz1X30YkB0m9gjwh9eVr1FaXS/P0rq/3Xc4jWZ43cyvdP5rVud056hifXtEBo5doCnaEBqtDreHOQvL9m5sGZ875m6OnZ5y2uOUnC0mkW9wIQ4824KL93J
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=Z4Rwk6OoAAAA:8
    a=yMhMjlubAAAA:8 a=pgxZd55qGeuizeMcAicA:9 a=aOW6cD_BeTEB7AVL:21
    a=kTIEWnIPErBOTe5A:21 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932104AbeDIAYn (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:24:43 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:63840
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932094AbeDIAYj (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:24:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: =?utf-8?B?SmFuIEguIFNjaMO2bmhlcnI=?= <jschoenh@amazon.de>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 095/161] fs/dax.c: release PMD lock even when
 there is no PMD support in DAX
Thread-Topic: [PATCH AUTOSEL for 4.14 095/161] fs/dax.c: release PMD lock even
 when there is no PMD support in DAX
Thread-Index: AQHTz5imPpFcGlN8XEiMvhi2zGNSmQ==
Date: Mon, 9 Apr 2018 00:21:06 +0000
Message-ID: <20180409001936.162706-95-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:aC7CmfTWs1Q3v8clmho/7FXDATzvrWYSl7KRbb4XsyvzxZnbEgF4alacCPngDZ79OFpHhDs4eMIZMVx4JboxXGODFGc4YSSU+IbX0u8WdQdge8/9TeGJ69nab4HIjGclSKqLeyp/8zMAE+5jdnDFr0b/3PaQ6b4fbaHkJp+tiFZFrqJ0J3s6I71653SfAlASKzaHIzSdWs3GerEaegf12/CpYMD8TlBTULBeL22ThDJqHshcNk+yRkU9zQ6yjgLM;20:uP037byyM1PyokaZ3t/+j2SBK6DQp0SfurfYp6Jx4+EaiEmFyZ8JlAJp8FHSuD2da7x+MRAxiMU+qP7a61ouccm771ChiJ2VGumxcYhnJKfQqL7+xNfjLWdx6McUgkuTDFrZ8qF8MgeRfvhZIo5uqu2YWGptEzghl4aoE/4UIZo=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5ed933d7-a3f9-4fb7-e921-08d59db0461f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09841ACA199C18BEDBD095E3FBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(366004)(39860400002)(396003)(189003)(199004)(5250100002)(2501003)(110136005)(54906003)(6116002)(6436002)(11346002)(1076002)(486006)(25786009)(105586002)(2900100001)(102836004)(966005)(86612001)(3846002)(68736007)(107886003)(316002)(10290500003)(5660300001)(86362001)(2616005)(305945005)(4326008)(446003)(6486002)(22452003)(7736002)(575784001)(6306002)(476003)(8676002)(81156014)(81166006)(8936002)(6512007)(10090500001)(186003)(3280700002)(106356001)(76176011)(2906002)(99286004)(26005)(97736004)(59450400001)(14454004)(6666003)(478600001)(53936002)(6506007)(36756003)(72206003)(66066001)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: a1+UR0VZiio3dzRA/5i3JqhMTk4S0tPvqK4YL7Y+y0Ey8oLwQg5rZL/TiL9V43hT1tX+bBPT6hlC3EcbvHOC77lN3w+/Bm23DQ1mn3Snz6Lam+XH8g2k85Sv/JND25L9GLVSpTnSJHkKWyMKuiqhbhmFCqcjKEWD9sp87+B8XKfHCf/s3xy+zhMWMJrPWXcdyT/4DUsODxRDWAanNdVMkAW6C7xM8IKExzJ/jjGIChTJ6QMecXeWb2RCWMjryI3BHPd2BsUE0pVnkW3ICYTt5q/0nNj0zPsg4KfRo81NboxO9qRhAFzHsvrus5DF8i+fiRw2Pf4cB9W/seEaSY1yzYneQZGBILM5BvF4bd8gYJcW301DhSi2QyMDL5jh3E64URHjjDUQ/jvkrbk8Qh6uQuBXC/OWE+bWPobRrjulOR8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A65B98951E7F74458594615BDC10239D@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed933d7-a3f9-4fb7-e921-08d59db0461f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:06.2532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogSmFuIEguIFNjaMO2bmhlcnIgPGpzY2hvZW5oQGFtYXpvbi5kZT4NCg0KWyBVcHN0cmVh
bSBjb21taXQgZWUxOTBjYTY1MTZiYzgyNTdlM2QzNjE4N2NhNmYwZjcxYTllYzQ3NyBdDQoNCmZv
bGxvd19wdGVfcG1kKCkgY2FuIHRoZW9yZXRpY2FsbHkgcmV0dXJuIGFmdGVyIGhhdmluZyBhY3F1
aXJlZCBhIFBNRA0KbG9jaywgZXZlbiB3aGVuIERBWCB3YXMgbm90IGNvbXBpbGVkIHdpdGggQ09O
RklHX0ZTX0RBWF9QTUQuDQoNClJlbGVhc2UgdGhlIFBNRCBsb2NrIHVuY29uZGl0aW9uYWxseS4N
Cg0KTGluazogaHR0cDovL2xrbWwua2VybmVsLm9yZy9yLzIwMTgwMTE4MTMzODM5LjIwNTg3LTEt
anNjaG9lbmhAYW1hem9uLmRlDQpGaXhlczogZjcyOWM4YzliMjRmICgiZGF4OiB3cnByb3RlY3Qg
cG1kX3QgaW4gZGF4X21hcHBpbmdfZW50cnlfbWtjbGVhbiIpDQpTaWduZWQtb2ZmLWJ5OiBKYW4g
SC4gU2Now7ZuaGVyciA8anNjaG9lbmhAYW1hem9uLmRlPg0KUmV2aWV3ZWQtYnk6IFJvc3MgWndp
c2xlciA8cm9zcy56d2lzbGVyQGxpbnV4LmludGVsLmNvbT4NClJldmlld2VkLWJ5OiBBbmRyZXcg
TW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KQ2M6IE1hdHRoZXcgV2lsY294IDxt
YXdpbGNveEBtaWNyb3NvZnQuY29tPg0KU2lnbmVkLW9mZi1ieTogQW5kcmV3IE1vcnRvbiA8YWtw
bUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NClNpZ25lZC1vZmYtYnk6IExpbnVzIFRvcnZhbGRzIDx0
b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4NClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmlu
IDxhbGV4YW5kZXIubGV2aW5AbWljcm9zb2Z0LmNvbT4NCi0tLQ0KIGZzL2RheC5jIHwgMiArLQ0K
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0t
Z2l0IGEvZnMvZGF4LmMgYi9mcy9kYXguYw0KaW5kZXggMTkxMzA2Y2Q4YjZiLi5kZGI0OTgxYWUz
MmUgMTAwNjQ0DQotLS0gYS9mcy9kYXguYw0KKysrIGIvZnMvZGF4LmMNCkBAIC02MzAsOCArNjMw
LDggQEAgc3RhdGljIHZvaWQgZGF4X21hcHBpbmdfZW50cnlfbWtjbGVhbihzdHJ1Y3QgYWRkcmVz
c19zcGFjZSAqbWFwcGluZywNCiAJCQlzZXRfcG1kX2F0KHZtYS0+dm1fbW0sIGFkZHJlc3MsIHBt
ZHAsIHBtZCk7DQogCQkJbW11X25vdGlmaWVyX2ludmFsaWRhdGVfcmFuZ2Uodm1hLT52bV9tbSwg
c3RhcnQsIGVuZCk7DQogdW5sb2NrX3BtZDoNCi0JCQlzcGluX3VubG9jayhwdGwpOw0KICNlbmRp
Zg0KKwkJCXNwaW5fdW5sb2NrKHB0bCk7DQogCQl9IGVsc2Ugew0KIAkJCWlmIChwZm4gIT0gcHRl
X3BmbigqcHRlcCkpDQogCQkJCWdvdG8gdW5sb2NrX3B0ZTsNCi0tIA0KMi4xNS4xDQo=
