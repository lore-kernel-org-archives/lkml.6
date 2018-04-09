Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233176-2-7740838449598427534
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233175; b=uF+N/lV6RrvaycGMKZWmhHrhqXWDwsKVh0FxLcAV7QARbRBBX6
    y7TZLwzZelZ6E7xncXtAsvorgLNj+6a8le8Xp1ne003RZggJnQ6S8PMzaHtoOYc1
    Np7fVZC/9HDTMPzuGQnmSlq87W8ubjYidZBiHLKq0bQBXY3vh3NCD/vmiIDOY3nQ
    e0gwW9VPODAhHtLMQpJXt28vCyWeKxtbnRj5WhmSqENkSgzZlyW4+jQojv6SVWVw
    PqBvsa5mplSlZoy3fqZA5box+tiePfCqdVNsbPg3ko+uPWWVIZivAdyVhOKRsiLZ
    8ssTSOhIMujCYqJJncFVrdBqv1d9jA0TwwSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-id:mime-version:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:content-type:content-transfer-encoding
    :sender; s=fm2; t=1523233175; bh=RxKkYTngSmVmexZp88sRN4vFz1KmEww
    qXHRu5qB8cXk=; b=W3SPxBShyLL/NMnhDeX3iCDUaX91iIJP7psWGc5qwKfwLFc
    I0BbX0iFAjOxTAy9+A3avyiaL1w6dwySfiT/PUevs4FlyXO1RW4DsAWpyuP5iAKH
    W2PQvUiEERz/BdfUJA3o6hcQACp46XgktdFdHkVCKEXK1iZY9Z+7YN1LwURwHu0O
    z60aOu3aI1mEeBOmB+MEh8lhmmBca7GZtxTnuytVFr+2Ha9QIWnJN+L8ewO2kutC
    /3tphwMakqVoy8lmLlHL+XTbxh9od7ISoCN72eAJXpEyO6p26RqXZg1HAHSeJsy7
    bqBMZmDguk62K8/2t7r046yPJbIfWhD5kbN4u7g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TxPE9xCO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TxPE9xCO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBAspx3F3UEdc3thtAO3U/1KXt8h4UIRIVohZS9nxUFc1bx5QZh4ZItmXOqwjq84ceKvr1lc0UhERPAoRjT0s0xugC2bPuwzfLTwj5T211LkSV0xIkKs
    pXzrVUZ1DTgWw/YI8+6r3KY9QCRMOMMSteVXhNpG9SfoLZsTjizXLdjVvR+whZzEOwKX6KfZYKk6R+mCB4iz4ztYgMlLWLd4LOwpZcDcx7x5ZZK2a+EjmsTi
    c2+Vn0HJ2+VweDJbFADScA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=20KFwNOVAAAA:8
    a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=TYBLyS7eAAAA:8 a=DDOyTI_5AAAA:8
    a=YtnSInc0arG0W8qGliQA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=zvYvwCWiE4KgVXXeO06c:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH AUTOSEL for 4.15 109/189] x86/hyperv: Check for required
 priviliges in hyperv_init()
Thread-Topic: [PATCH AUTOSEL for 4.15 109/189] x86/hyperv: Check for required
 priviliges in hyperv_init()
Thread-Index: AQHTz5g/A1ksiFAmjkmhZDxsAa8C3A==
Date: Mon, 9 Apr 2018 00:18:12 +0000
Message-ID: <20180409001637.162453-109-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB1063;
 7:DTd4ceXNDQEjEmI5PfcfieB4oQl71h3feM68soPnKo/7YMzCLKcOtU0yHxcd9A/8UH8GkSPXjWOMGzl3JrScuOXmhbUBYkYzSJpCRuIm25ApvNMSZLaSw+1zY/FuojmznnG3bATD/BFQfI/Q4E8aUu+0wWjvhmPmIF0eEHClQ6ivyT9+rf5vHEo3h/Fr+FuveLDwOyMAz1ogQ6CQv56DeI2k6hfKN09s2UkL+6u+S0cyUDYWt3blHYw9jCUqb0am;
 20:ss8Bfz7MQOmx35zQcZW/5w2Ud3+QDv7qbu58IRxb/ZamoBNaTHrq3cbBerUCY070e2oRfnLKrg8rwTEFuwe1D0qqP2QPYDEJYtxWozb9p9oBUXOTcbAph9LWdb6Y4ga20uffS+lgfosyMhrln7G+Aj/8a0IXZkSzW/T+I4533Hc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: b01776e0-dbf6-445c-5d12-08d59daf8c8c
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1063A1328D9562F2E1A79695FBBF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(42068640409301); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);
 SRVR:DM5PR2101MB1063; BCL:0; PCL:0; RULEID:; SRVR:DM5PR2101MB1063;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(396003)(366004)(189003)(199004)(2900100001)(6436002)(7736002)(10090500001)(102836004)(3660700001)(6506007)(76176011)(305945005)(4326008)(5250100002)(97736004)(26005)(25786009)(6512007)(2906002)(81166006)(106356001)(107886003)(68736007)(14454004)(86612001)(66066001)(10290500003)(6306002)(59450400001)(6666003)(5660300001)(966005)(81156014)(478600001)(476003)(486006)(6486002)(72206003)(3280700002)(99286004)(105586002)(36756003)(1076002)(2616005)(11346002)(53936002)(446003)(8676002)(186003)(3846002)(54906003)(6116002)(2501003)(8936002)(316002)(110136005)(86362001)(7416002)(22452003)(22906009)(217873001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB1063;
 H:DM5PR2101MB1032.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
x-microsoft-antispam-message-info: 6aQt7t2yOLn4qDGlqayv1W4xU3/bnDqs6LUVdQhrvrxYKQVTYL+igkzoj9A5P8dprx+zXODjDHCxVXWFk88RgVfhrXr1xv0rPhNSizPbjwUUsNmMCV5Yz+MoPX4EZZAjh/tDGSeW3WFGqbZnohCUkec4+qkWY3hyrVuECQItSDXumZPNH89KFioz/WZjAixGJzWm+bei/Xz54eg2GY6koef6IyYYtINXa0G8vqQ18L/uSsztGAjHT7NacH9rzVAJcQEKIgsWLtOwqq5XO29AEKSt4nZmGJ036GEVcJ2fuO/gW9JT8nf5x69B07bsdycq0g9yEOxCP2FKJKSsGyicB6nCJ5bFqJBq1IN8kgzNXlIEnRAZ5atriNcuhQNk1VYk9qX8Dwr66t5V4Id9gzg1ZygM+GmbyoHpzaKSq2P/NZM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <9033351F3076D2418DEBF336FF801317@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01776e0-dbf6-445c-5d12-08d59daf8c8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:12.3967 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "Michael Kelley
 \(EOSG\)" <Michael.H.Kelley@microsoft.com>, Roman Kagan <rkagan@virtuozzo.com>,
 Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Mohammed Gamal <mmorsy@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogVml0YWx5IEt1em5ldHNvdiA8dmt1em5ldHNAcmVkaGF0LmNvbT4NCg0KWyBVcHN0cmVh
bSBjb21taXQgODlhOGY2ZDQ5MDRjOGNmM2ZmOGZlZTlmZGFmZjM5MmE2YmJiOGJmNiBdDQoNCklu
IGh5cGVydl9pbml0KCkgaXRzIHByZXN1bWVkIHRoYXQgaXQgYWx3YXlzIGhhcyBhY2Nlc3MgdG8g
VlAgaW5kZXggYW5kDQpoeXBlcmNhbGwgTVNScyB3aGlsZSBhY2NvcmRpbmcgdG8gdGhlIHNwZWNp
ZmljYXRpb24gaXQgc2hvdWxkIGJlIGNoZWNrZWQgaWYNCml0J3MgYWxsb3dlZCB0byBhY2Nlc3Mg
dGhlIGNvcnJlc3BvbmRpbmcgTVNScyBiZWZvcmUgYWNjZXNzaW5nIHRoZW0uDQoNClNpZ25lZC1v
ZmYtYnk6IFZpdGFseSBLdXpuZXRzb3YgPHZrdXpuZXRzQHJlZGhhdC5jb20+DQpTaWduZWQtb2Zm
LWJ5OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NClJldmlld2VkLWJ5OiBU
aG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCkNjOiBTdGVwaGVuIEhlbW1pbmdl
ciA8c3RoZW1taW5AbWljcm9zb2Z0LmNvbT4NCkNjOiBrdm1Admdlci5rZXJuZWwub3JnDQpDYzog
UmFkaW0gS3LEjW3DocWZIDxya3JjbWFyQHJlZGhhdC5jb20+DQpDYzogSGFpeWFuZyBaaGFuZyA8
aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT4NCkNjOiAiTWljaGFlbCBLZWxsZXkgKEVPU0cpIiA8TWlj
aGFlbC5ILktlbGxleUBtaWNyb3NvZnQuY29tPg0KQ2M6IFJvbWFuIEthZ2FuIDxya2FnYW5Admly
dHVvenpvLmNvbT4NCkNjOiBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4NCkNjOiBk
ZXZlbEBsaW51eGRyaXZlcnByb2plY3Qub3JnDQpDYzogUGFvbG8gQm9uemluaSA8cGJvbnppbmlA
cmVkaGF0LmNvbT4NCkNjOiAiSy4gWS4gU3Jpbml2YXNhbiIgPGt5c0BtaWNyb3NvZnQuY29tPg0K
Q2M6IENhdGh5IEF2ZXJ5IDxjYXZlcnlAcmVkaGF0LmNvbT4NCkNjOiBNb2hhbW1lZCBHYW1hbCA8
bW1vcnN5QHJlZGhhdC5jb20+DQpMaW5rOiBodHRwczovL2xrbWwua2VybmVsLm9yZy9yLzIwMTgw
MTI0MTMyMzM3LjMwMTM4LTItdmt1em5ldHNAcmVkaGF0LmNvbQ0KU2lnbmVkLW9mZi1ieTogU2Fz
aGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogYXJjaC94ODYv
aHlwZXJ2L2h2X2luaXQuYyB8IDkgKysrKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaHlwZXJ2L2h2
X2luaXQuYyBiL2FyY2gveDg2L2h5cGVydi9odl9pbml0LmMNCmluZGV4IDE4OWEzOTgyOTBkYi4u
MjFmOWQ1M2Q5ZjAwIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYvaHlwZXJ2L2h2X2luaXQuYw0KKysr
IGIvYXJjaC94ODYvaHlwZXJ2L2h2X2luaXQuYw0KQEAgLTExMCwxMiArMTEwLDE5IEBAIHN0YXRp
YyBpbnQgaHZfY3B1X2luaXQodW5zaWduZWQgaW50IGNwdSkNCiAgKi8NCiB2b2lkIGh5cGVydl9p
bml0KHZvaWQpDQogew0KLQl1NjQgZ3Vlc3RfaWQ7DQorCXU2NCBndWVzdF9pZCwgcmVxdWlyZWRf
bXNyczsNCiAJdW5pb24gaHZfeDY0X21zcl9oeXBlcmNhbGxfY29udGVudHMgaHlwZXJjYWxsX21z
cjsNCiANCiAJaWYgKHg4Nl9oeXBlcl90eXBlICE9IFg4Nl9IWVBFUl9NU19IWVBFUlYpDQogCQly
ZXR1cm47DQogDQorCS8qIEFic29sdXRlbHkgcmVxdWlyZWQgTVNScyAqLw0KKwlyZXF1aXJlZF9t
c3JzID0gSFZfWDY0X01TUl9IWVBFUkNBTExfQVZBSUxBQkxFIHwNCisJCUhWX1g2NF9NU1JfVlBf
SU5ERVhfQVZBSUxBQkxFOw0KKw0KKwlpZiAoKG1zX2h5cGVydi5mZWF0dXJlcyAmIHJlcXVpcmVk
X21zcnMpICE9IHJlcXVpcmVkX21zcnMpDQorCQlyZXR1cm47DQorDQogCS8qIEFsbG9jYXRlIHBl
cmNwdSBWUCBpbmRleCAqLw0KIAlodl92cF9pbmRleCA9IGttYWxsb2NfYXJyYXkobnVtX3Bvc3Np
YmxlX2NwdXMoKSwgc2l6ZW9mKCpodl92cF9pbmRleCksDQogCQkJCSAgICBHRlBfS0VSTkVMKTsN
Ci0tIA0KMi4xNS4xDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpkZXZlbCBtYWlsaW5nIGxpc3QKZGV2ZWxAbGludXhkcml2ZXJwcm9qZWN0Lm9yZwpodHRw
Oi8vZHJpdmVyZGV2LmxpbnV4ZHJpdmVycHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcml2
ZXJkZXYtZGV2ZWwK
