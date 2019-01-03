Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A748AC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0C020815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OJs83z1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfACTRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:17:18 -0500
Received: from mail-eopbgr750059.outbound.protection.outlook.com ([40.107.75.59]:42816
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726500AbfACTRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1hegSlp2a91ZvLkdA0mnKOnIB6elLlURettibe/bdE=;
 b=OJs83z1Bv1W/Yy3JEGWb5lViVGmuE5wNEE44FsPgjbs5Rd/NazFDv/SkxWmoXZ2f+COLR6s97Bu2evt57kD0GLA9lMOiaRvlU2PUZZUdboADUbDwWLAe7FcdHdTQ6o2BXhKiokaPbLrqlA5z4H+PjSaWZrHMqZcaf/e65gBfABk=
Received: from DM5PR12MB1707.namprd12.prod.outlook.com (10.175.89.136) by
 DM5PR12MB2389.namprd12.prod.outlook.com (52.132.141.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 3 Jan 2019 19:17:14 +0000
Received: from DM5PR12MB1707.namprd12.prod.outlook.com
 ([fe80::7598:ef3f:4e71:7965]) by DM5PR12MB1707.namprd12.prod.outlook.com
 ([fe80::7598:ef3f:4e71:7965%4]) with mapi id 15.20.1471.019; Thu, 3 Jan 2019
 19:17:14 +0000
From:   "Kuehling, Felix" <Felix.Kuehling@amd.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amdgpu_vm: fix boolean expressions
Thread-Topic: [PATCH] drm/amdgpu_vm: fix boolean expressions
Thread-Index: AQHUo5MahWqrxqR/o0m37TooYk8e9KWd6rUA
Date:   Thu, 3 Jan 2019 19:17:14 +0000
Message-ID: <08f2d5c0-0e97-f44e-c07d-6a8cdfd277bb@amd.com>
References: <20190103173418.GA18739@embeddedor>
In-Reply-To: <20190103173418.GA18739@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-clientproxiedby: YTXPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::34) To DM5PR12MB1707.namprd12.prod.outlook.com
 (2603:10b6:3:10f::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2389;20:D+rPAH9/HziABNpGs3FUrRw7GrdeCxTEwUXGes07LQyxzsePpq1QnFbRAmkVt83i75FRyImGkijXUyV1gEl8jyhrElagwgmOmwsy2cvY0B3+TZvbcCR6/zEha+CC41llyhtoZbQX2DigYdQCTH8xlNq7XK34gwGRAbjz2c4H4ffrYkAu6olIHiBWy9OnUeAtgFkjTzkGyN70ImQCWo48StNSJ6lwr+QSUjdBgjFW4zxlkrB026SenSqFHKSaJzr1
x-ms-office365-filtering-correlation-id: 1abde946-d817-4630-316a-08d671b0118d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2389;
x-ms-traffictypediagnostic: DM5PR12MB2389:
x-microsoft-antispam-prvs: <DM5PR12MB2389117D51A8C239E362F838928D0@DM5PR12MB2389.namprd12.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB2389;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2389;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(346002)(136003)(52314003)(189003)(199004)(53936002)(575784001)(446003)(316002)(476003)(2616005)(229853002)(11346002)(53546011)(386003)(6506007)(2906002)(102836004)(6436002)(76176011)(66066001)(65956001)(68736007)(186003)(65806001)(52116002)(6486002)(26005)(6116002)(3846002)(6512007)(99286004)(4326008)(8936002)(72206003)(6916009)(97736004)(14454004)(256004)(86362001)(486006)(58126008)(54906003)(36756003)(6246003)(81166006)(8676002)(81156014)(31686004)(305945005)(65826007)(106356001)(105586002)(31696002)(25786009)(5660300001)(64126003)(7736002)(14444005)(71200400001)(478600001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2389;H:DM5PR12MB1707.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GQEMzT/nxqC1EEaUmfn7HjT/3xqTGJN+p7NU6M2unwIWCKaBgqA6jMancRMwOzyyS3EQFQh7h2uNoSKssTzqUuYCYbUFe7Ys+uGqYvnt+ZRBGZxxkuETzXbiY9t0vubZBE/q9DO0TaV51uHSdgVyIKeeSHJwHVxhL6Ms2v0f9OoiZXmqp3aQG5cddarpJmNQp9lYfFN1WXe5OVYTAhDFBbBfs8GktbGU3VpfhYbTi4vZo7aBLFAAYiqgCMWuqyfb8R/yqaOOuPmUiS8PIRlmUNm40k1OXLTlaekWJcupgqW+x9SePqBOJGkGdlfYDk5R
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1CECBEF8BFD3449B8F5E7750E26C983@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abde946-d817-4630-316a-08d671b0118d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 19:17:14.6527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2389
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMS0wMyAxMjozNCBwLm0uLCBHdXN0YXZvIEEuIFIuIFNpbHZhIHdyb3RlOg0KPiBG
aXggYm9vbGVhbiBleHByZXNzaW9ucyBieSB1c2luZyBsb2dpY2FsIEFORCBvcGVyYXRvciAnJiYn
DQo+IGluc3RlYWQgb2YgYml0d2lzZSBvcGVyYXRvciAnJicuDQo+DQo+IFRoaXMgaXNzdWUgd2Fz
IGRldGVjdGVkIHdpdGggdGhlIGhlbHAgb2YgQ29jY2luZWxsZS4NCj4NCj4gRml4ZXM6IGM4YzVl
NTY5YzViMCAoImRybS9hbWRncHU6IENvbnNvbGlkYXRlIHZpc2libGUgdnMuIHJlYWwgdnJhbSBj
aGVjayB2Mi4iKQ0KQWN0dWFsbHksIHRoaXMgYnVnIGdvZXMgYmFjayBmdXJ0aGVyLCB0byA5YTRi
N2Q0Yzc2OWUgKCJkcm0vYW1kZ3B1OiBBZGQNCnZtIGNvbnRleHQgbW9kdWxlIHBhcmFtIikuDQoN
CkFueXdheSwgdGhlIHBhdGNoIGlzIFJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXgu
S3VlaGxpbmdAYW1kLmNvbT4NCg0KUmVnYXJkcywNCsKgIEZlbGl4DQoNCg0KPiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBHdXN0YXZvIEEuIFIuIFNpbHZhIDxn
dXN0YXZvQGVtYmVkZGVkb3IuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYw0KPiBpbmRleCBlNzNkMTUyNjU5YTIuLjRjYzBkMTA3OTkzNSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gQEAgLTMwMDYsNyArMzAwNiw3IEBAIGlu
dCBhbWRncHVfdm1faW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdw
dV92bSAqdm0sDQo+ICAJfQ0KPiAgCURSTV9ERUJVR19EUklWRVIoIlZNIHVwZGF0ZSBtb2RlIGlz
ICVzXG4iLA0KPiAgCQkJIHZtLT51c2VfY3B1X2Zvcl91cGRhdGUgPyAiQ1BVIiA6ICJTRE1BIik7
DQo+IC0JV0FSTl9PTkNFKCh2bS0+dXNlX2NwdV9mb3JfdXBkYXRlICYgIWFtZGdwdV9nbWNfdnJh
bV9mdWxsX3Zpc2libGUoJmFkZXYtPmdtYykpLA0KPiArCVdBUk5fT05DRSgodm0tPnVzZV9jcHVf
Zm9yX3VwZGF0ZSAmJiAhYW1kZ3B1X2dtY192cmFtX2Z1bGxfdmlzaWJsZSgmYWRldi0+Z21jKSks
DQo+ICAJCSAgIkNQVSB1cGRhdGUgb2YgVk0gcmVjb21tZW5kZWQgb25seSBmb3IgbGFyZ2UgQkFS
IHN5c3RlbVxuIik7DQo+ICAJdm0tPmxhc3RfdXBkYXRlID0gTlVMTDsNCj4gIA0KPiBAQCAtMzEz
Niw3ICszMTM2LDcgQEAgaW50IGFtZGdwdV92bV9tYWtlX2NvbXB1dGUoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtLCB1bnMNCj4gIAl2bS0+cHRlX3N1cHBv
cnRfYXRzID0gcHRlX3N1cHBvcnRfYXRzOw0KPiAgCURSTV9ERUJVR19EUklWRVIoIlZNIHVwZGF0
ZSBtb2RlIGlzICVzXG4iLA0KPiAgCQkJIHZtLT51c2VfY3B1X2Zvcl91cGRhdGUgPyAiQ1BVIiA6
ICJTRE1BIik7DQo+IC0JV0FSTl9PTkNFKCh2bS0+dXNlX2NwdV9mb3JfdXBkYXRlICYgIWFtZGdw
dV9nbWNfdnJhbV9mdWxsX3Zpc2libGUoJmFkZXYtPmdtYykpLA0KPiArCVdBUk5fT05DRSgodm0t
PnVzZV9jcHVfZm9yX3VwZGF0ZSAmJiAhYW1kZ3B1X2dtY192cmFtX2Z1bGxfdmlzaWJsZSgmYWRl
di0+Z21jKSksDQo+ICAJCSAgIkNQVSB1cGRhdGUgb2YgVk0gcmVjb21tZW5kZWQgb25seSBmb3Ig
bGFyZ2UgQkFSIHN5c3RlbVxuIik7DQo+ICANCj4gIAlpZiAodm0tPnBhc2lkKSB7DQo=
