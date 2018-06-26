Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F51AC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49FE26625
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4zCqwrs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49FE26625
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932068AbeFZHj7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:39:59 -0400
Received: from mail-eopbgr700056.outbound.protection.outlook.com ([40.107.70.56]:22432
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752007AbeFZHj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/Hy3yfC+39TWJhG4PVs0SIg32nx4sbgHY1FQInRKZY=;
 b=4zCqwrs4RWJqPdG2PmJeCO09D/HkaWSKOc5KluWvRKmN7dyun3KuUUHGAfZz+wgst/OAYug/iRuVzzRwmc2L6emUNiOrt4bu21KZH1jNlzQ1LQ2clE9JvN/bQQUxjqfVIVaYLGMeLvZTzqHAYnSqSbfSd9FUIBlXxK5LZ7YICs8=
Received: from DM3PR12MB0873.namprd12.prod.outlook.com (10.164.7.143) by
 DM3PR12MB0780.namprd12.prod.outlook.com (10.164.7.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.21; Tue, 26 Jun 2018 07:39:56 +0000
Received: from DM3PR12MB0873.namprd12.prod.outlook.com
 ([fe80::19cc:1e82:3f38:4050]) by DM3PR12MB0873.namprd12.prod.outlook.com
 ([fe80::19cc:1e82:3f38:4050%6]) with mapi id 15.20.0884.024; Tue, 26 Jun 2018
 07:39:51 +0000
From:   "Qu, Jim" <Jim.Qu@amd.com>
To:     Lyude Paul <lyude@redhat.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC:     "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDIvNF0gZHJtL2FtZGdwdTogcy9kaXNwX2RldGV0aW9u?=
 =?gb2312?B?X3BvcnRzL2Rpc3BfZGV0ZWN0aW9uX3BvcnRzLw==?=
Thread-Topic: [PATCH 2/4] drm/amdgpu:
 s/disp_detetion_ports/disp_detection_ports/
Thread-Index: AQHUDOpYrpiwQvhxh0ewhMawvkTgAqRyJ8cx
Date:   Tue, 26 Jun 2018 07:39:51 +0000
Message-ID: <DM3PR12MB087380F6607E66D6A2CF4D9B99490@DM3PR12MB0873.namprd12.prod.outlook.com>
References: <20180626010916.20300-1-lyude@redhat.com>,<20180626010916.20300-3-lyude@redhat.com>
In-Reply-To: <20180626010916.20300-3-lyude@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=Jim.Qu@amd.com; 
x-originating-ip: [116.228.147.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM3PR12MB0780;7:mPXHW6v1PzxMqxdD34fHEAAUFV6j02kGbPx3anuU+0+CATmQVjmjHioZ9ctsHPEZ/Hlnel+sdRXcljLras19ZVFBKNTXe+U6VP+q7wtvUI9hCGYct3doKU+2pZhCgXXGSO6hwjFAb3FZdPpru4S9cb0IMQRbbsAkRhAJA61RgLexiQRanf+qC37sw4QMcgZNnWM5SkXbnaNKKh0v5IkulyJmA9vn4l2UIuMqAUlmXd2PUb7Uq/uFKn315SVmmzuh;20:KP1fy5XYKs3j/cpcTNU6EPrup4EZx0ou5SSztMnq5W6U/p7poS4U/hVNuHZ3+lIG4OYsaMaGdfiPX+OJYq5DwwIE2uSyWFrDYnZwt0iwDtgEQUb0j8+FzSziIdFoSYGUQMM7qm7eoziFa9v0ewP+La/tBEFuQ8sMkLKHYoKTdV0iHlyDCL27ibqsDOtfRYfABSUukGIdNyWWvoLEgF9IQZllx0a2+RMfW8sesOH0a22xhc4bj2DtqIw38q5APWt1
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(366004)(346002)(39860400002)(189003)(199004)(54906003)(5250100002)(81156014)(316002)(966005)(7696005)(86362001)(76176011)(53936002)(2906002)(14454004)(305945005)(81166006)(97736004)(74316002)(72206003)(33656002)(68736007)(7736002)(256004)(14444005)(478600001)(476003)(5660300001)(2501003)(66066001)(110136005)(6116002)(486006)(9686003)(102836004)(3846002)(25786009)(99286004)(6306002)(2900100001)(55016002)(6436002)(106356001)(8936002)(105586002)(6506007)(446003)(224303003)(11346002)(186003)(4326008)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR12MB0780;H:DM3PR12MB0873.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: b4168ccb-c3dc-4e38-a058-08d5db380047
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM3PR12MB0780;
x-ms-traffictypediagnostic: DM3PR12MB0780:
x-microsoft-antispam-prvs: <DM3PR12MB07809F761B91D54508FE19D099490@DM3PR12MB0780.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(217544274631240);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM3PR12MB0780;BCL:0;PCL:0;RULEID:;SRVR:DM3PR12MB0780;
x-forefront-prvs: 071518EF63
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vP/tnmMAZi0XsiSN97hiKlngaLHvFrHPtKYH40mEOeoQyVPuzCYorGphjO7pZCkBwbQkai81MHYBYusa+yJrlBAQxZteu96S2OsZajXeqeLKDdX1U9deJz6+0a6Ww/5/ATIpE/ayyWKC2FaywY4lo/jf+MSkAYn9VrTghNY/77Ze98ZitBF9mnfVoB+Qmz0yw2zZ4l6kZFyyc8P4IGdqSB865Cm6t9eM8o5TFw960gWBe8YkDPbQ3dwDg3D2qIv8eKrz9syL+ibuXD4gXTk5SZJFgqinLUDfpGUoajA1vv6lArBQPPU1UGk4FCGcrdSYsk9GqexvjzJQRu+IVyggP2argEWGNE/Q1kj0MMmNrvA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4168ccb-c3dc-4e38-a058-08d5db380047
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2018 07:39:51.0627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB0780
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZWQtYnk6IEppbSBRdSA8SmltLlF1QGFtZC5jb20+DQoNClRoYW5rcw0KSmltUXUNCg0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0Kt6K8/sjLOiBhbWQtZ2Z4
IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiC0+rHtIEx5dWRlIFBhdWwg
PGx5dWRlQHJlZGhhdC5jb20+DQq3osvNyrG85DogMjAxOMTqNtTCMjbI1SA5OjA5OjA1DQrK1bz+
yMs6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQqzrcvNOiBaaG91LCBEYXZpZChDaHVu
TWluZyk7IERhdmlkIEFpcmxpZTsgSHVhbmcsIFJheTsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgS2FpLUhlbmcgRmVuZzsgRGV1
Y2hlciwgQWxleGFuZGVyOyBLb2VuaWcsIENocmlzdGlhbg0K1vfM4jogW1BBVENIIDIvNF0gZHJt
L2FtZGdwdTogcy9kaXNwX2RldGV0aW9uX3BvcnRzL2Rpc3BfZGV0ZWN0aW9uX3BvcnRzLw0KDQpT
aWduZWQtb2ZmLWJ5OiBMeXVkZSBQYXVsIDxseXVkZUByZWRoYXQuY29tPg0KLS0tDQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2F0cHhfaGFuZGxlci5jIHwgNCArKy0tDQogMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hdHB4X2hhbmRsZXIuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hdHB4X2hhbmRsZXIuYw0KaW5kZXggMWFl
NWFlOGM0NWE0Li43MTdjYzVhOTAzMTMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfYXRweF9oYW5kbGVyLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9hdHB4X2hhbmRsZXIuYw0KQEAgLTMyLDcgKzMyLDcgQEAgc3RydWN0IGFt
ZGdwdV9hdHB4X2Z1bmN0aW9ucyB7DQogICAgICAgIGJvb2wgc3dpdGNoX3N0YXJ0Ow0KICAgICAg
ICBib29sIHN3aXRjaF9lbmQ7DQogICAgICAgIGJvb2wgZGlzcF9jb25uZWN0b3JzX21hcHBpbmc7
DQotICAgICAgIGJvb2wgZGlzcF9kZXRldGlvbl9wb3J0czsNCisgICAgICAgYm9vbCBkaXNwX2Rl
dGVjdGlvbl9wb3J0czsNCiB9Ow0KDQogc3RydWN0IGFtZGdwdV9hdHB4IHsNCkBAIC0xNTYsNyAr
MTU2LDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2F0cHhfcGFyc2VfZnVuY3Rpb25zKHN0cnVjdCBh
bWRncHVfYXRweF9mdW5jdGlvbnMgKmYsIHUzMiBtYXMNCiAgICAgICAgZi0+c3dpdGNoX3N0YXJ0
ID0gbWFzayAmIEFUUFhfR1JBUEhJQ1NfREVWSUNFX1NXSVRDSF9TVEFSVF9OT1RJRklDQVRJT05f
U1VQUE9SVEVEOw0KICAgICAgICBmLT5zd2l0Y2hfZW5kID0gbWFzayAmIEFUUFhfR1JBUEhJQ1Nf
REVWSUNFX1NXSVRDSF9FTkRfTk9USUZJQ0FUSU9OX1NVUFBPUlRFRDsNCiAgICAgICAgZi0+ZGlz
cF9jb25uZWN0b3JzX21hcHBpbmcgPSBtYXNrICYgQVRQWF9HRVRfRElTUExBWV9DT05ORUNUT1JT
X01BUFBJTkdfU1VQUE9SVEVEOw0KLSAgICAgICBmLT5kaXNwX2RldGV0aW9uX3BvcnRzID0gbWFz
ayAmIEFUUFhfR0VUX0RJU1BMQVlfREVURUNUSU9OX1BPUlRTX1NVUFBPUlRFRDsNCisgICAgICAg
Zi0+ZGlzcF9kZXRlY3Rpb25fcG9ydHMgPSBtYXNrICYgQVRQWF9HRVRfRElTUExBWV9ERVRFQ1RJ
T05fUE9SVFNfU1VQUE9SVEVEOw0KIH0NCg0KIC8qKg0KLS0NCjIuMTcuMQ0KDQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KYW1kLWdmeCBtYWlsaW5nIGxp
c3QNCmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngNCg==
