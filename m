Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233484-2-8163270010135090480
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233482; b=lfvtAOFtlicVbOGaC0Xk4SiuMgGQZKS9aOZMyMKcS+YfYJpcq3
    1wr03kmsGaB2s1+fWjs2gPaHk1RvlwArSg8ytK6vo9JRrFt0LqW73p6HSV8j4i2t
    CJZ2SYMf7gBRnN9penhSwC38Dqo+tOX/Wh5kjLUUHftgy0J6TQOxdzMv/dL1n3fP
    0QWzQWSHzmY6crTnhClQrtvsXLWn91gnpGIuKxx6ix1h3hw/HotBuKreiDxLeln/
    wWl+KExJ9RDgZRtrC/eBDhJAOaMe0THks4u3D38+4VG/VHU1FHK98DHadfkN2zBw
    7lhoK/GCphOjV7FlmJUgrNkYoCMAukDJjBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-id:mime-version:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:content-type:content-transfer-encoding
    :sender; s=fm2; t=1523233482; bh=eIG9mjpQj9xIo1eDd4DXGVUp/x9TgOF
    nyTUg8Gp7dxE=; b=nAPiWJmgkuqJxi//6akiRhq6ACPR0mq51qZHrCvBOd0i2Vd
    hAw+vRB7rEAVeaxHt8XLnliEpqv5gL3GiP60C7ToGw4QBsSUcXp0aaaVNdmlrx36
    sQOMfT0lSk6RjcqKUSNPOaWOVwGusOM3NT0L/IuSrffuUlWc3rhrroWoXn9/b+Bd
    kUwSlbTpc4bihqRZND05taTVhj5tuRv1O1FxwOJtdHEMRd4iFNmTsMm/pbrwiVqm
    NzLzpJNPA+UOjTd3f4vwKkWwvAfdLJWx4HZgoVMjeqMnuH8ZJnjlcK1U69CMjzmM
    CQ31Q+3bEHxjU1se3u3LZs8K/0lhZHyvBxoI21g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GRBTZKAo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GRBTZKAo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOq7tm7dej0EV4sASMis8aHeInclgv6mQS9ykkGqAJUEbhJoUh8r5RV7rcBVBu6JCKWMr2Lal5ROp58F4VtgpeYKFJ2pDVGF3R7XX82VfbSIkxU+u3KH
    3/NWUxoeuKqfK5rpUZ+Hs1Tx4P36HWrBsaXBSv17Y/sf4Cs3NNGcLt/WOnOjRfdZfT6qzDOQF4SFMHkuaTLCmxt8u8j9wM0Abqx8hWdtP1B9lV1hZAvDW87w
    WOx5OZBqLx/XYZj0pIWgKQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
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
Subject: [PATCH AUTOSEL for 4.14 090/161] x86/hyperv: Check for required
 priviliges in hyperv_init()
Thread-Topic: [PATCH AUTOSEL for 4.14 090/161] x86/hyperv: Check for required
 priviliges in hyperv_init()
Thread-Index: AQHTz5ijYn6ZV2yYGEm/YlW7CcMt2Q==
Date: Mon, 9 Apr 2018 00:21:01 +0000
Message-ID: <20180409001936.162706-90-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB0984;
 7:lNRjY+57NOcgWcNFAcS2iGdmsUPl3gc1J5/rT0FkdS8xqjkXg32B2UYuDciO2H9qt7oWHPND930co+ZZemm9g6a9K+mDHlRCs0Govt2D7ZYK/n0QHdG5tEcqE6922bPyAVglK8pBz3SP5u1F9rbn5nGWSDIM7b2YSid0RlEcJ0N4cymihdD3/42ptg8aF/WSQmNs9FhyFZZWdmZuZdxdy/RGJBy1JonvSyWhBVX1nSuLD7reHveTai+uOpMKDkPs;
 20:NAw+NnkPvmCeoatMVrbKYUSPeEwA0wRI0F91kMJ/vvBulmDWSjOoOd6mYGGyxD6Tb15Ghg5bgjD31uDdabqPy4mn8Tg5TTv6WAIawYmkHEl3DcUJJaEaY5J/gXOQcPMF65ORuOaorv6rswHvR3d59K3xnCpvWw9dqLrP8k/djsk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: ebca4cdc-be8f-45c3-df9f-08d59db0438d
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0984941DBA062F466961258CFBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(42068640409301); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);
 SRVR:DM5PR2101MB0984; BCL:0; PCL:0; RULEID:; SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(39380400002)(346002)(376002)(366004)(39860400002)(396003)(189003)(199004)(5250100002)(2501003)(110136005)(54906003)(6116002)(6436002)(11346002)(1076002)(486006)(25786009)(105586002)(2900100001)(102836004)(966005)(86612001)(3846002)(68736007)(107886003)(316002)(7416002)(10290500003)(5660300001)(86362001)(2616005)(305945005)(4326008)(446003)(6486002)(22452003)(7736002)(575784001)(6306002)(476003)(8676002)(81156014)(81166006)(8936002)(6512007)(10090500001)(186003)(3280700002)(106356001)(76176011)(2906002)(99286004)(26005)(97736004)(59450400001)(14454004)(6666003)(478600001)(53936002)(6506007)(36756003)(72206003)(66066001)(3660700001)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB0984;
 H:DM5PR2101MB1032.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
x-microsoft-antispam-message-info: d6i1V1tIq2IO3pyKK+edlrLcRgzYdGtccy0/u1n2e4f/Oug8SKOVKteat6yewKJ5XhFWPtinxd2b4y1igNNzUvuckOyEfYVn7awknmsPLKbJrk3iDpUwyxQpLI3s8PRIb/MiWjGDMIKhxezi71/QGmwo7oh3JkpjAMfrTU9WLTOSfCFA/9uM4zhG8jMuBdkwdQtlzHVz9MCRvwSjtIXftXXf+akRz7tH5amOnzNjBoWcR8gyEb8drRJqB+1c/R6PTd9To2+EhIenIDAN9jKQkJAt/Lh/tnlXFK16y1ccFulGjDIs7I9YM2h+5UKQvGrIqUJMQjcwJwJxkiT5DcA14E2vm3YiSb2xKLaUMTGA6VkvHUjNnTsiBNKu6Ctj1krxk9mbWbKjWP0POs9NwZbdQc4dsz06cbnjK+i+lyVBJjI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <1E616B9C16DA934297B9E56EAA36C6AB@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebca4cdc-be8f-45c3-df9f-08d59db0438d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:01.0658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
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
X2luaXQuYyBiL2FyY2gveDg2L2h5cGVydi9odl9pbml0LmMNCmluZGV4IGEwYjg2Y2Y0ODZlMC4u
MmU5ZDU4Y2MzNzFlIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYvaHlwZXJ2L2h2X2luaXQuYw0KKysr
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
