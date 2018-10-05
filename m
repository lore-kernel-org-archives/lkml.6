Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A79C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA90E2064D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ONnUCSn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA90E2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbeJEPMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:12:14 -0400
Received: from mail-eopbgr730079.outbound.protection.outlook.com ([40.107.73.79]:59624
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727750AbeJEPMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fJzK84Couo27X8y3RRlpE6hdUPohCzdMaKCLz3k+Ls=;
 b=ONnUCSn9l2i5Hs6b6W7rHFpaD4XnxTxevuH0vPiBhc8sWzUy98FG3jFO0mZxvLZ4h2iA/AnY+8Jp6KLjyaHVPXXtP8dLJpGmy7ccbEwCsMhnjE+owei/H5jqw/Z30jtWet0jsfU8hQSvnrnmaj0fvr6UmZtbHZQmt+Ouj4yjoaw=
Received: from BN6PR12MB1714.namprd12.prod.outlook.com (10.175.101.11) by
 BN6PR12MB1779.namprd12.prod.outlook.com (10.175.101.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.23; Fri, 5 Oct 2018 08:14:35 +0000
Received: from BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::5826:a5b3:996b:ce05]) by BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::5826:a5b3:996b:ce05%12]) with mapi id 15.20.1207.021; Fri, 5 Oct 2018
 08:14:35 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Guenter Roeck <linux@roeck-us.net>, Peng Hao <peng.hao2@zte.com.cn>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] amdgpu/gmc : fix compile warning
Thread-Topic: [PATCH] amdgpu/gmc : fix compile warning
Thread-Index: AQHUXINz8METxdpO60GfNTlgx6+1Ag==
Date:   Fri, 5 Oct 2018 08:14:34 +0000
Message-ID: <022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com>
References: <1536919552-116245-1-git-send-email-peng.hao2@zte.com.cn>
 <20181004185237.GA20667@roeck-us.net>
In-Reply-To: <20181004185237.GA20667@roeck-us.net>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-originating-ip: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
x-clientproxiedby: VI1PR0202CA0031.eurprd02.prod.outlook.com
 (2603:10a6:803:14::44) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1779;20:zh0wfiIdhKQ1KsoyQQnRKFRAqU3lC4BLkwXcEU7ijaG5fFgS3KJRuFr1tA2AZnTx3MBumxYYqmfW5Q9h/FJs29+unNPo1FwyPYJqQ5RmQnbCDzG7HVQzuk7oo9EwmzErXcn5M7hc/pGULlM0BvO7AmhYKiurVRdEF57VfLjCKefdTj+KFJd9qU0qUF/opYgWDoQw5HXAqGaGxL8xecwrCZ9ODz8TlyLCMIomqjbdUbS9auiZcSiEfFVmVUvpi/En
x-ms-office365-filtering-correlation-id: 3f4e7432-e53b-4b5d-f6db-08d62a9a95a7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1779;
x-ms-traffictypediagnostic: BN6PR12MB1779:
x-microsoft-antispam-prvs: <BN6PR12MB177948BBAAF11E4F1D16F25683EB0@BN6PR12MB1779.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:BN6PR12MB1779;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1779;
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(366004)(39860400002)(376002)(199004)(189003)(65956001)(65806001)(6116002)(102836004)(106356001)(36756003)(4326008)(186003)(14444005)(305945005)(5250100002)(256004)(25786009)(71200400001)(71190400001)(7736002)(46003)(68736007)(105586002)(478600001)(81156014)(81166006)(14454004)(64126003)(8936002)(97736004)(76176011)(58126008)(8676002)(65826007)(2900100001)(99286004)(486006)(72206003)(52116002)(110136005)(229853002)(54906003)(53936002)(5660300001)(6512007)(316002)(6436002)(2616005)(6486002)(86362001)(11346002)(6246003)(31686004)(6506007)(386003)(476003)(31696002)(2906002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1779;H:BN6PR12MB1714.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: z7BqgDd1H6jyNf5iD8v/mbl/ygN2XuAAodOI1OhIwhvBGuLOIoQDYVV7mmaNuYJqpLJqRtIYVFrmNPSI+DM1td1OaNA2SwPRwvm8vEkz/5J92+2NXyoezTzbKC7R3hwsurq/ce6NEBqkvt8ub4QP47E2CILEll0wUivDbjsmoeHm1h6iOxUVL/xFpnQESd84HE86LQJPpYPw4JkhmaQUk3RemQunnk7+ggMAdJ5VFdr9A7Q/7+eRpoen1XgXHCa13eU9ph+k0h0MnWoqp4JyA3QG6kpJ4xrX5ZODnpYn2bsPQqrJXM1bEitBytG0AmFOl6Bq+IIeDpgbRLZNYlg7XAI0rnRqpCGBZHlVboMZlN8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <957C012718770745945997ADADB984DB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4e7432-e53b-4b5d-f6db-08d62a9a95a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 08:14:34.8511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1779
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMDQuMTAuMjAxOCB1bSAyMDo1MiBzY2hyaWViIEd1ZW50ZXIgUm9lY2s6DQo+IEhpLA0KPg0K
PiBPbiBGcmksIFNlcCAxNCwgMjAxOCBhdCAwNjowNTo1MlBNICswODAwLCBQZW5nIEhhbyB3cm90
ZToNCj4+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OF8wLmM6DQo+PiAgICAgIElu
IGZ1bmN0aW9uIOKAmGdtY192OF8wX3Byb2Nlc3NfaW50ZXJydXB04oCZOg0KPj4gZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y4XzAuYzoxNDQ3OjEwOg0KPj4gICAgICB3YXJuaW5nOiBt
aXNzaW5nIGJyYWNlcyBhcm91bmQgaW5pdGlhbGl6ZXIgWy1XbWlzc2luZy1icmFjZXNdDQo+Pg0K
Pj4gU2lnbmVkLW9mZi1ieTogUGVuZyBIYW8gPHBlbmcuaGFvMkB6dGUuY29tLmNuPg0KPiBXYXMg
dGhlcmUgYW55IGZlZWRiYWNrIG9uIHRoaXMgcGF0Y2ggPyBUaGUgcHJvYmxlbSBkb2VzIGFmZmVj
dCB1cywNCj4gYW5kIHdlJ2xsIG5lZWQgYSBmaXguDQoNCldlbGwgYXMgZGlzY3Vzc2VkIHVzaW5n
ICJ7IHsgMCB9IH0iIGlzIGFzIHdyb25nIGFzIHVzaW5nICJ7IDAgfSIuDQoNCldlIHNob3VsZCBl
aXRoZXIgdXNlIG9ubHkgInsgfSIgb3IgZXZlbiBiZXR0ZXIgbWFrZSBuYWlscyB3aXRoIGhlYWRz
IGFuZCANCnVzZSBtZW1zZXQoKS4NCg0KQ2hyaXN0aWFuLg0KDQo+DQo+PiAtLS0NCj4+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y4XzAuYyB8IDIgKy0NCj4+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyB8IDIgKy0NCj4+ICAgMiBmaWxlcyBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nbWNfdjhfMC5jDQo+PiBpbmRleCA5MzMzMTA5Li41NWY0NzU1IDEwMDY0NA0KPj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y4XzAuYw0KPj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y4XzAuYw0KPj4gQEAgLTE0NDQsNyArMTQ0NCw3
IEBAIHN0YXRpYyBpbnQgZ21jX3Y4XzBfcHJvY2Vzc19pbnRlcnJ1cHQoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsDQo+PiAgIAkJZ21jX3Y4XzBfc2V0X2ZhdWx0X2VuYWJsZV9kZWZhdWx0KGFk
ZXYsIGZhbHNlKTsNCj4+ICAgDQo+PiAgIAlpZiAocHJpbnRrX3JhdGVsaW1pdCgpKSB7DQo+PiAt
CQlzdHJ1Y3QgYW1kZ3B1X3Rhc2tfaW5mbyB0YXNrX2luZm8gPSB7IDAgfTsNCj4+ICsJCXN0cnVj
dCBhbWRncHVfdGFza19pbmZvIHRhc2tfaW5mbyA9IHsgezB9IH07DQo+PiAgIA0KPiBJIHdvbmRl
cmVkIGlmDQo+IAkJc3RydWN0IGFtZGdwdV90YXNrX2luZm8gdGFza19pbmZvID0geyB9Ow0KPiB3
b3VsZCBiZSBiZXR0ZXIuDQo+DQo+IFRoYW5rcywNCj4gR3VlbnRlcg0KPg0KPj4gICAJCWFtZGdw
dV92bV9nZXRfdGFza19pbmZvKGFkZXYsIGVudHJ5LT5wYXNpZCwgJnRhc2tfaW5mbyk7DQo+PiAg
IA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jDQo+PiBpbmRleCA3MmY4MDE4
Li5lOGI3OGM1IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21j
X3Y5XzAuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYw0K
Pj4gQEAgLTI1OSw3ICsyNTksNyBAQCBzdGF0aWMgaW50IGdtY192OV8wX3Byb2Nlc3NfaW50ZXJy
dXB0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPj4gICAJfQ0KPj4gICANCj4+ICAgCWlm
IChwcmludGtfcmF0ZWxpbWl0KCkpIHsNCj4+IC0JCXN0cnVjdCBhbWRncHVfdGFza19pbmZvIHRh
c2tfaW5mbyA9IHsgMCB9Ow0KPj4gKwkJc3RydWN0IGFtZGdwdV90YXNrX2luZm8gdGFza19pbmZv
ID0geyB7MH0gfTsNCj4+ICAgDQo+PiAgIAkJYW1kZ3B1X3ZtX2dldF90YXNrX2luZm8oYWRldiwg
ZW50cnktPnBhc2lkLCAmdGFza19pbmZvKTsNCj4+ICAgDQoNCg==
