Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A062AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280A020866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Y2cCG+gM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280A020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbeIKCEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:04:39 -0400
Received: from mail-eopbgr700127.outbound.protection.outlook.com ([40.107.70.127]:11871
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726150AbeIKCEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nb+O9QSotuQdYw/1Wb+8SprAHC9jgxiXfDt+gcAYmTk=;
 b=Y2cCG+gMuDcEMIkRNQ/Sz53lhLvbvy2EIUQlnC6le8/Qw7dxYtWsd5HpkiLivV5NbyJLl8H5qhG94VFA9GQKkAyNXN5BlxxDwgzW7ZaqdxpqRGOflKB6prW6TaWj6hUZPDE1npe0CtW1iX2N9suxdMIJaiinihMSkBQnV0xpdw0=
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com (52.132.149.30) by
 MW2PR2101MB0908.namprd21.prod.outlook.com (52.132.152.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Mon, 10 Sep 2018 21:08:39 +0000
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::8dea:f5e5:67f7:c879]) by MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::8dea:f5e5:67f7:c879%5]) with mapi id 15.20.1164.006; Mon, 10 Sep 2018
 21:08:39 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
CC:     "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Bernhard Landauer <oberon@manjaro.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Subject: RE: [PATCH] Drivers: hv: vmbus: include header for get_irq_regs()
Thread-Topic: [PATCH] Drivers: hv: vmbus: include header for get_irq_regs()
Thread-Index: AQHUQDbGwxz6ALD2+Uq6EERgr8fIEqTpnqUAgAB1qeA=
Date:   Mon, 10 Sep 2018 21:08:38 +0000
Message-ID: <MW2PR2101MB11133F952B2EFE7D501FF055A0050@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <20180830075503.vh3qcdcnxcjobj55@linutronix.de>
 <20180910140658.4umofqptuxhevtit@linutronix.de>
In-Reply-To: <20180910140658.4umofqptuxhevtit@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:3:6a3d:63ce:5e50:3adf]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0908;6:eK7GLiaq1YEKF+/KMW1neNHH4r/IsqHvU3I+X7VzCqxEgwYcatQ7l7OoxWS3qZPdtZPGJnDeOHoUXf8/TNAo2SyYSgmbpPCXbUBlCClNcYwm3aK0DHJLwPtzpHHkRHMtq00867pKPCW2qG4UD02MhWoTo0Ut0aOUE9xQdb5YJP/M+WAstP2rc2NcT6RbLqPJK2viAOkBmT1cXlNXWuAdOzp46j4Jeut30CZy6zvEBcxKquZuPPz/UGHKVAvDn8sdtRaLScHGyI+DY77A8oeNc61YqBQlKKwglttCxpd3IrecJq8gSWd8DgIcoRZXHwgY8SC2cVDy7lGkASLgAKK18MLDDo37rd0dkrJVEW5+sVR1YIf4E3K3DHxutqAZU4Q4mxrzSDO7q3u2xUUWgb3dKXiOPiVzqvkNpE+kZ4nE7naGxzNvQZxhpRN6bs61zRTHW+mhIwrDAO9fUOWLtltLHQ==;5:io7FQWwkXmEI/A9LkQ2mx7DtliXfKAsGS+KZ9rGr720uMtM1UsAeB0w4SLRmgeQbspiQcnImV+1P+C/ezdmfoSQYlvC/3H7ZH5sZ+ebz/ylTbkNUgwdAk9Sve+3L68UBr/Yagz/XzG9/p7uhzL5EKyl1MTDkcvtu3krT4GCPh/U=;7:YRepDVUuqCoiWbGWqvLMCNqZtuTnD6jxuhIsC1ZBwboFVOXHz4JSi0ck6QGI/a8HwU4AyygSM+DJLJ8Zzyt7MgoQ9YGW0o5v4orFS06bCLYro/XcURuE9q3Ed8KYo6at8ZPGGw5EB4qoVYtXKVNAN2rViVnzZa5qoWFwzGGDEfBYamU2bSKRLx145naNhMfGm2D8b8rthoJIcneM5w38qlQmYbTHYsgQeL2QIMGo2d6OBq35Ja1wmmQbpK16lyPu
x-ms-office365-filtering-correlation-id: 403f3108-3895-42a5-566b-08d617619487
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB0908;
x-ms-traffictypediagnostic: MW2PR2101MB0908:
x-microsoft-antispam-prvs: <MW2PR2101MB090802B323F1A0CFD0E4CFC3A0050@MW2PR2101MB0908.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050)(76991033);SRVR:MW2PR2101MB0908;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0908;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(366004)(376002)(346002)(13464003)(189003)(199004)(446003)(7696005)(6506007)(476003)(11346002)(10090500001)(99286004)(53936002)(86612001)(53546011)(86362001)(110136005)(54906003)(186003)(6116002)(6436002)(22452003)(33656002)(8990500004)(229853002)(316002)(2906002)(102836004)(46003)(9686003)(8676002)(106356001)(105586002)(6346003)(55016002)(4326008)(25786009)(97736004)(6636002)(74316002)(2900100001)(1511001)(5250100002)(6246003)(68736007)(8936002)(305945005)(5660300001)(7736002)(76176011)(486006)(478600001)(14454004)(256004)(10290500003)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0908;H:MW2PR2101MB1113.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-microsoft-antispam-message-info: Ja9e2dGPMOO1IS9fGr//ZTOBQr2eLzITf6Qkbg+xpM2GgzAaldvGWkp0CC7gG6nac90R2TJXMmP+0K+Y4ztjA6R4OXnjleJHX1h9xz+PQCMdRFuu3bDjrFltcwyZIuhFe38TEb/+JlgAfhbnBTyNyvfUg+uEmkWd2dnHxahxZRnya712iJYJfCicdTwJRxAsqzyZ3+gB1AFbVNhhEkTrciizCk/7Gq77i53gqAt9jWfO1h1uFW8qn8jcTBl4KaSMmCikNsFwFbGrvV7Y1t+1yL2Xqid7nqqb0/OfYweeYRmO7bfM7GN4U9cDTpkPUEEgy7os4+FEsOi3uu69o7V4xb+TRvhwDPdSuGPPFShc5wg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 403f3108-3895-42a5-566b-08d617619487
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 21:08:38.8846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0908
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ViYXN0aWFuIEFuZHJ6
ZWogU2lld2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPg0KPiBTZW50OiBNb25kYXksIFNlcHRl
bWJlciAxMCwgMjAxOCA3OjA3IEFNDQo+IFRvOiBLWSBTcmluaXZhc2FuIDxreXNAbWljcm9zb2Z0
LmNvbT47IEhhaXlhbmcgWmhhbmcNCj4gPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+OyBTdGVwaGVu
IEhlbW1pbmdlcg0KPiA8c3RoZW1taW5AbWljcm9zb2Z0LmNvbT4NCj4gQ2M6IGRldmVsQGxpbnV4
ZHJpdmVycHJvamVjdC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFN0ZXZlbg0K
PiBSb3N0ZWR0IDxyb3N0ZWR0QGdvb2RtaXMub3JnPjsgQmVybmhhcmQgTGFuZGF1ZXINCj4gPG9i
ZXJvbkBtYW5qYXJvLm9yZz47IFJhbGYgUmFtc2F1ZXIgPHJhbGYucmFtc2F1ZXJAb3RoLQ0KPiBy
ZWdlbnNidXJnLmRlPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBEcml2ZXJzOiBodjogdm1idXM6
IGluY2x1ZGUgaGVhZGVyIGZvciBnZXRfaXJxX3JlZ3MoKQ0KPiANCj4gT24gMjAxOC0wOC0zMCAw
OTo1NTowMyBbKzAyMDBdLCBUbyBLLiBZLiBTcmluaXZhc2FuIHdyb3RlOg0KPiA+IE9uICFSVCB0
aGUgaGVhZGVyIGZpbGUgZ2V0X2lycV9yZWdzKCkgZ2V0cyBwdWxsZWQgaW4gdmlhIG90aGVyIGhl
YWRlciBmaWxlcy4NCj4gT24NCj4gPiBSVCBpdCBkb2VzIG5vdCBhbmQgdGhlIGJ1aWxkIGZhaWxz
Og0KPiA+DQo+ID4gICAgIGRyaXZlcnMvaHYvdm1idXNfZHJ2LmM6OTc1IGltcGxpY2l0IGRlY2xh
cmF0aW9uIG9mIGZ1bmN0aW9uDQo+IOKAmGdldF9pcnFfcmVnc+KAmSBbLVdlcnJvcj1pbXBsaWNp
dC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCj4gPiAgICAgZHJpdmVycy9odi9odi5jOjExNSBpbXBs
aWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhnZXRfaXJxX3JlZ3PigJkgWy0NCj4gV2Vy
cm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQ0KPiA+DQo+ID4gQWRkIHRoZSBoZWFk
ZXIgZmlsZSBmb3IgZ2V0X2lycV9yZWdzKCkgaW4gYSBjb21tb24gaGVhZGVyIHNvIGl0IHVzZWQg
YnkNCj4gPiB2bWJ1c19kcnYuYyBieSBodi5jIGZvciB0aGVpciBnZXRfaXJxX3JlZ3MoKSB1c2Fn
ZS4NCj4gPg0KPiA+IFJlcG9ydGVkLWJ5OiBCZXJuaGFyZCBMYW5kYXVlciA8b2Jlcm9uQG1hbmph
cm8ub3JnPg0KPiA+IFJlcG9ydGVkLWJ5OiBSYWxmIFJhbXNhdWVyIDxyYWxmLnJhbXNhdWVyQG90
aC1yZWdlbnNidXJnLmRlPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNlYmFzdGlhbiBBbmRyemVqIFNp
ZXdpb3IgPGJpZ2Vhc3lAbGludXRyb25peC5kZT4NCj4gDQo+IHBpbmcNCg0KSXQgaXMgaW4gbXkg
cXVldWU7IHdpbGwgc3VibWl0IGl0IHNvb24uDQoNCksuIFkNCj4gDQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvaHYvaHlwZXJ2X3ZtYnVzLmggfCAxICsNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9odi9oeXBlcnZfdm1idXMu
aCBiL2RyaXZlcnMvaHYvaHlwZXJ2X3ZtYnVzLmgNCj4gPiBpbmRleCA3MmVhYmEzZDUwZmMyLi43
OTdmMDc5MTgxOTdjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaHYvaHlwZXJ2X3ZtYnVzLmgN
Cj4gPiArKysgYi9kcml2ZXJzL2h2L2h5cGVydl92bWJ1cy5oDQo+ID4gQEAgLTMxLDYgKzMxLDcg
QEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2F0b21pYy5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgv
aHlwZXJ2Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4NCj4gPiArI2luY2x1
ZGUgPGxpbnV4L2lycS5oPg0KPiA+DQo+ID4gICNpbmNsdWRlICJodl90cmFjZS5oIg0KPiA+DQo+
ID4gLS0NCj4gPiAyLjE4LjANCj4gPg0K
