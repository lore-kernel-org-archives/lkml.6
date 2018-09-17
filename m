Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F8BECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DFB208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WFEhNu7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97DFB208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbeIQIxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:53:37 -0400
Received: from mail-by2nam03on0122.outbound.protection.outlook.com ([104.47.42.122]:15894
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729604AbeIQI2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWttDL6FXWK+nA+B3JRLhuPs15Sit8bv1yb8XP9F/To=;
 b=WFEhNu7ncKn/UvsNKzlI7VsBf1gQ0XpNmaRw+CP4fYiVu6hd1XFlQg92nx24pQNGrfbGGTPtTX5LEn+rjs5DKd6b523xbQqdueZYtCqo5X1T5qDQHr+BLNxLaNAQXxI3fAKj1kuZx+9HE5SWtxzOgSpu3+lsir+Nf3oYBQ2iyX8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0168.namprd21.prod.outlook.com (10.173.192.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:02:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 115/136] ASoC: rt1305: Use ULL suffixes for
 64-bit constants
Thread-Topic: [PATCH AUTOSEL 4.18 115/136] ASoC: rt1305: Use ULL suffixes for
 64-bit constants
Thread-Index: AQHUTjK4u81zp7717UKKj1pOzbAgCQ==
Date:   Mon, 17 Sep 2018 03:01:24 +0000
Message-ID: <20180917030006.245495-115-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0168;6:f3GetMgjG6Dzh/wgFc1rKckJXYmLZ7+7+w66e6DvrlHo3UOQBKuX5ojBx3rb8i5OXL3Ke2YkIAAgEkauhm8n3GbyfDSoT4n6S1fpdQDAW3zjai6zWQdjuTkYDps041ulJ6Fcu68Bfp5fTMVl5U9OPvYHhrBapaj6tZmHokWPwSWw5ZN/6MzseWhhXiz/2sMdiadaZEQa1z9RYchefZ2q+QrfT7EEPTTqrEBMiEVPES05GJbS/DGDl3m6pIHqbnbRckFWfxVlBdvSOL/Ke9Lys/38WzPHr4G39h4VRH+0DmlccjReH2ozpXYXgkcW1QtcBOBIpOUx9O5LIIc1BC3iThqBmwCXeq6VwFCUhoCPU6mME7FQaYoy9KSB1fTb43H4RyafFrsakXKVOSx8tQJI5DrQFOLMlOpMDEiSjEbOhaARZvurI8Qh5CIwaRpUPDo8VTDr78baNRdRwN/B/UPmtA==;5:8rhNbZbRhKbY/WIgMpCTWQBU8YbVzUbOlYNfMCW9srLtRfdWNFedc+PRVpBuXTdAJppGgxQLlFT8k1MJIoCQ9rO4FoBSJWWdYZLywu18DJhRMoyUi9TxUPS/Vuf6NWdx5Cl8XCKz5vyTac7XYrpe92YkHHjZjyfasaQdQCmfh7M=;7:pD7wowtrRpnvnQFtvCpFxQbYCYguPzTkPAJ0pjm7JOEhTUkWRYyq0nfuEnc+uNxEP6GFq2mFmxVYG8V0rOmXEQ9V7Mw1rTV1bJmAOeev5Gg1iviZZBITUB6EshqMsqeu5R9ku9Hv02Sf4wGcYmu1hPVu7GEOjW0T4A4VBXPkqSPRgwrhxd7P2oEgRqjunA9QSAF6/AztlE+lSOuPQxTZTqzy0KDe75Z0Fi8iSpm+iA8tKQlJ8YW0b1RvZK0hOA2b
x-ms-office365-filtering-correlation-id: 00397b6d-bf78-4e81-9484-08d61c4a0ba5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0168;
x-ms-traffictypediagnostic: CY4PR21MB0168:
x-microsoft-antispam-prvs: <CY4PR21MB0168AE1DEEFE4E2822345714FB1E0@CY4PR21MB0168.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0168;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0168;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(136003)(199004)(189003)(11346002)(4326008)(105586002)(106356001)(486006)(446003)(6436002)(2616005)(22452003)(107886003)(10090500001)(25786009)(476003)(14454004)(110136005)(54906003)(316002)(2906002)(76176011)(99286004)(575784001)(36756003)(186003)(26005)(6346003)(5660300001)(7736002)(305945005)(10290500003)(8676002)(81156014)(81166006)(6486002)(68736007)(6666003)(102836004)(6116002)(3846002)(1076002)(53936002)(217873002)(72206003)(97736004)(6506007)(8936002)(86362001)(256004)(6512007)(2501003)(5250100002)(2900100001)(14444005)(478600001)(66066001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0168;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: +oj5zDwJMW58sOFJs9EiKwSbKnsdueWujuq96tHFNjkFlIvyaP7B6LQn6f8QhohbJHI0ki5D7mlIXsJu+R9I05rxKI6w/hS2sheCqPcVhsGOV9WIGIZpsv5SAip8AF2/Sq/jmgfBYjYdfvbRzbIlwEEcXiYWEiLx5qUWI6vYq+CaocT2G3pRuyXu+0fKni9yqMGxs+DXdIoLDsTVmYDvJbnYcD2zBRdm3PRmw1GksaKUaNUGbgCahO4spOC+OaQudp7Z39TE7Ss2nbuqqdt+ZzbC5U3oAEKAxgX4K0LP0AR03kPPkX9zyUi16wpO/9nqs/ghbJT6soSw9jXniivTwYijugHCH10gddkz5J75QWQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4184EF5284FD1E48971F230FA529260F@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00397b6d-bf78-4e81-9484-08d61c4a0ba5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:24.4165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCg0KWyBVcHN0
cmVhbSBjb21taXQgNGYyOWI2NjNjMDhkMzY5ZmUzMjBhMTQ4MTc5OTk2Yzk0Y2Y3ZDAxYiBdDQoN
CldpdGggZ2NjIDQuMS4yOg0KDQogICAgc291bmQvc29jL2NvZGVjcy9ydDEzMDUuYzogSW4gZnVu
Y3Rpb24g4oCYcnQxMzA1X2NhbGlicmF0ZeKAmToNCiAgICBzb3VuZC9zb2MvY29kZWNzL3J0MTMw
NS5jOjEwNjk6IHdhcm5pbmc6IGludGVnZXIgY29uc3RhbnQgaXMgdG9vIGxhcmdlIGZvciDigJhs
b25n4oCZIHR5cGUNCiAgICBzb3VuZC9zb2MvY29kZWNzL3J0MTMwNS5jOjEwODY6IHdhcm5pbmc6
IGludGVnZXIgY29uc3RhbnQgaXMgdG9vIGxhcmdlIGZvciDigJhsb25n4oCZIHR5cGUNCg0KQWRk
IHRoZSBtaXNzaW5nICJVTEwiIHN1ZmZpeGVzIHRvIGZpeCB0aGlzLg0KDQpGaXhlczogMjliYzY0
M2RkZDdlZmI3NCAoIkFTb0M6IHJ0MTMwNTogQWRkIFJUMTMwNS9SVDEzMDYgYW1wbGlmaWVyIGRy
aXZlciIpDQpTaWduZWQtb2ZmLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02
OGsub3JnPg0KU2lnbmVkLW9mZi1ieTogTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPg0K
U2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29t
Pg0KLS0tDQogc291bmQvc29jL2NvZGVjcy9ydDEzMDUuYyB8IDQgKystLQ0KIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9zb3Vu
ZC9zb2MvY29kZWNzL3J0MTMwNS5jIGIvc291bmQvc29jL2NvZGVjcy9ydDEzMDUuYw0KaW5kZXgg
ZjRjOGM0NWY0MDEwLi40MjFiOGZiMmZhMDQgMTAwNjQ0DQotLS0gYS9zb3VuZC9zb2MvY29kZWNz
L3J0MTMwNS5jDQorKysgYi9zb3VuZC9zb2MvY29kZWNzL3J0MTMwNS5jDQpAQCAtMTA2Niw3ICsx
MDY2LDcgQEAgc3RhdGljIHZvaWQgcnQxMzA1X2NhbGlicmF0ZShzdHJ1Y3QgcnQxMzA1X3ByaXYg
KnJ0MTMwNSkNCiAJcHJfZGVidWcoIkxlZnRfcmhsID0gMHgleCByaD0weCV4IHJsPTB4JXhcbiIs
IHJobCwgcmgsIHJsKTsNCiAJcHJfaW5mbygiTGVmdCBjaGFubmVsICVkLiVkb2htXG4iLCAocjBv
aG0vMTApLCAocjBvaG0lMTApKTsNCiANCi0JcjBsID0gNTYyOTQ5OTUzNDIxMzEyOw0KKwlyMGwg
PSA1NjI5NDk5NTM0MjEzMTJVTEw7DQogCWlmIChyaGwgIT0gMCkNCiAJCWRvX2RpdihyMGwsIHJo
bCk7DQogCXByX2RlYnVnKCJMZWZ0X3IwID0gMHglbGx4XG4iLCByMGwpOw0KQEAgLTEwODMsNyAr
MTA4Myw3IEBAIHN0YXRpYyB2b2lkIHJ0MTMwNV9jYWxpYnJhdGUoc3RydWN0IHJ0MTMwNV9wcml2
ICpydDEzMDUpDQogCXByX2RlYnVnKCJSaWdodF9yaGwgPSAweCV4IHJoPTB4JXggcmw9MHgleFxu
IiwgcmhsLCByaCwgcmwpOw0KIAlwcl9pbmZvKCJSaWdodCBjaGFubmVsICVkLiVkb2htXG4iLCAo
cjBvaG0vMTApLCAocjBvaG0lMTApKTsNCiANCi0JcjByID0gNTYyOTQ5OTUzNDIxMzEyOw0KKwly
MHIgPSA1NjI5NDk5NTM0MjEzMTJVTEw7DQogCWlmIChyaGwgIT0gMCkNCiAJCWRvX2RpdihyMHIs
IHJobCk7DQogCXByX2RlYnVnKCJSaWdodF9yMCA9IDB4JWxseFxuIiwgcjByKTsNCi0tIA0KMi4x
Ny4xDQo=
