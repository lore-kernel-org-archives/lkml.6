Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6421BC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 17:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188C52146E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 17:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188C52146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hotmail.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754323AbeGGRww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 13:52:52 -0400
Received: from mail-oln040092068090.outbound.protection.outlook.com ([40.92.68.90]:50425
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754148AbeGGRwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 13:52:51 -0400
Received: from AM5EUR02FT058.eop-EUR02.prod.protection.outlook.com
 (10.152.8.51) by AM5EUR02HT087.eop-EUR02.prod.protection.outlook.com
 (10.152.9.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.906.15; Sat, 7
 Jul 2018 17:52:47 +0000
Received: from AM5PR0701MB2657.eurprd07.prod.outlook.com (10.152.8.58) by
 AM5EUR02FT058.mail.protection.outlook.com (10.152.9.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.20.906.15 via Frontend Transport; Sat, 7 Jul 2018 17:52:47 +0000
Received: from AM5PR0701MB2657.eurprd07.prod.outlook.com
 ([fe80::b1fe:1b4f:88c3:5243]) by AM5PR0701MB2657.eurprd07.prod.outlook.com
 ([fe80::b1fe:1b4f:88c3:5243%7]) with mapi id 15.20.0952.008; Sat, 7 Jul 2018
 17:52:47 +0000
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCHv3] Fix range checks in kernfs_get_target_path
Thread-Topic: [PATCHv3] Fix range checks in kernfs_get_target_path
Thread-Index: AQHUFhtQ75qzmnRLgk6REyo6TeLGGQ==
Date:   Sat, 7 Jul 2018 17:52:47 +0000
Message-ID: <AM5PR0701MB2657711C49D0229DBED3A24EE4460@AM5PR0701MB2657.eurprd07.prod.outlook.com>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0162.eurprd05.prod.outlook.com
 (2603:10a6:7:28::49) To AM5PR0701MB2657.eurprd07.prod.outlook.com
 (2603:10a6:203:75::7)
x-incomingtopheadermarker: OriginalChecksum:8F8313CAB04DA7DE5F6424A804C8F06A3BBC2A6FD906BF30656C5E2AF69E6195;UpperCasedChecksum:2A097830ACF43D25C35B87BDA5D64CE4FA1C22F704655D3FEF0B2103E2E79CF0;SizeAsReceived:7423;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [OXWCjx/x0BACxALguRYb2jxwMCT+Gl6r]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5EUR02HT087;7:vCD9GopMMz38MQ8KQnJlnL/F/cuva2yAYaJ9mOXaZG1+dwXJoGlUtGGYSbGD5dlYCTLT89gk/fzU3eEpQd+cxonYFsIydzkYcrtF3AUflw3+fTFCQapyJGWKXOV1CzEPSKVqtFEGi4+9OPzBuUPyqhmVXqTlOBwQ6p/Y8hK6dNIb+dL/cbTgFccATwhPJa1C2i07M1YSbikBmwU1Wq62LDqzDKD0r77hpB0XU5bg3yrCyOhL/Uzk7mdqVFqwdHIZ
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1601125500)(1603101448)(1701031045);SRVR:AM5EUR02HT087;
x-ms-traffictypediagnostic: AM5EUR02HT087:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(82015058);SRVR:AM5EUR02HT087;BCL:0;PCL:0;RULEID:;SRVR:AM5EUR02HT087;
x-forefront-prvs: 0726B2D7A6
x-forefront-antispam-report: SFV:NSPM;SFS:(7070007)(189003)(199004)(81156014)(82202002)(1857600001)(5250100002)(8676002)(8936002)(2501003)(305945005)(26005)(74482002)(14454004)(386003)(99286004)(6506007)(55016002)(102836004)(74316002)(6346003)(7696005)(25786009)(486006)(110136005)(73972006)(5660300001)(104016004)(2900100001)(75402003)(97736004)(68736007)(9686003)(33656002)(105586002)(86362001)(106356001)(476003)(256004)(6436002)(14444005)(44832011);DIR:OUT;SFP:1901;SCL:1;SRVR:AM5EUR02HT087;H:AM5PR0701MB2657.eurprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:3;A:1;LANG:;
received-spf: None (protection.outlook.com: hotmail.de does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bernd.edlinger@hotmail.de; 
x-microsoft-antispam-message-info: HlPvefZOte2ScvmikH3+xGU01Bn9BbJGE04XsnqDQdkxxJlQW2jOHjLlD/bj6W/UuFhSAbhHcorcSuk9XM1z9AFDD+DOHwP+TRf4yq1QVg2EVJSXQgTpijAP+qYlV0hTTUakk8bSb25G85oPqLi9rF1a1rnte+Ukt6v7K7XT82Uy+gd8NWqOm0nRLOK6nicyqPjeZpjoWWdEvygfdaZh6sQ/pCNeHQyLPhs6lBeZKIU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C9970CE08B55746A95C1DD5971C3DC1@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b162dd-d9a6-46ea-325b-08d5e43272ad
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2018 17:52:47.5619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHRlcm1pbmF0aW5nIE5VTCBieXRlIGlzIG9ubHkgdGhlcmUgYmVjYXVzZSB0aGUgYnVmZmVy
IGlzDQphbGxvY2F0ZWQgd2l0aCBremFsbG9jKFBBR0VfU0laRSwgR0ZQX0tFUk5FTCksIGJ1dCBz
aW5jZSB0aGUNCnJhbmdlLWNoZWNrIGlzIG9mZi1ieS1vbmUsIGFuZCBQQUdFX1NJWkU9PVBBVEhf
TUFYLCB0aGUNCnJldHVybmVkIHN0cmluZyBtYXkgbm90IGJlIHplcm8tdGVybWluYXRlZCBpZiBp
dCBpcyBleGFjdGx5DQpQQVRIX01BWCBjaGFyYWN0ZXJzIGxvbmcuICBGdXJ0aGVybW9yZSBhbHNv
IHRoZSBpbml0aWFsIGxvb3ANCm1heSB0aGVvcmV0aWNhbGx5IGV4Y2VlZCBQQVRIX01BWCBhbmQg
Y2F1c2UgYSBmYXVsdC4NCg0KU2lnbmVkLW9mZi1ieTogQmVybmQgRWRsaW5nZXIgPGJlcm5kLmVk
bGluZ2VyQGhvdG1haWwuZGU+DQotLS0NCiAgZnMva2VybmZzL3N5bWxpbmsuYyB8IDUgKysrKy0N
CiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZm
IC0tZ2l0IGEvZnMva2VybmZzL3N5bWxpbmsuYyBiL2ZzL2tlcm5mcy9zeW1saW5rLmMNCmluZGV4
IDA4Y2NhYmQuLjc3NGJhZGEgMTAwNjQ0DQotLS0gYS9mcy9rZXJuZnMvc3ltbGluay5jDQorKysg
Yi9mcy9rZXJuZnMvc3ltbGluay5jDQpAQCAtNjMsNiArNjMsOSBAQCBzdGF0aWMgaW50IGtlcm5m
c19nZXRfdGFyZ2V0X3BhdGgoc3RydWN0IGtlcm5mc19ub2RlDQogIAkJaWYgKGJhc2UgPT0ga24p
DQogIAkJCWJyZWFrOw0KICANCisJCWlmICgocyAtIHBhdGgpICsgMyA+PSBQQVRIX01BWCkNCisJ
CQlyZXR1cm4gLUVOQU1FVE9PTE9ORzsNCisNCiAgCQlzdHJjcHkocywgIi4uLyIpOw0KICAJCXMg
Kz0gMzsNCiAgCQliYXNlID0gYmFzZS0+cGFyZW50Ow0KQEAgLTc5LDcgKzgyLDcgQEAgc3RhdGlj
IGludCBrZXJuZnNfZ2V0X3RhcmdldF9wYXRoKHN0cnVjdCBrZXJuZnNfbm9kZQ0KICAJaWYgKGxl
biA8IDIpDQogIAkJcmV0dXJuIC1FSU5WQUw7DQogIAlsZW4tLTsNCi0JaWYgKChzIC0gcGF0aCkg
KyBsZW4gPiBQQVRIX01BWCkNCisJaWYgKChzIC0gcGF0aCkgKyBsZW4gPj0gUEFUSF9NQVgpDQog
IAkJcmV0dXJuIC1FTkFNRVRPT0xPTkc7DQogIA0KICAJLyogcmV2ZXJzZSBmaWxsdXAgb2YgdGFy
Z2V0IHN0cmluZyBmcm9tIHRhcmdldCB0byBiYXNlICovDQotLSANCjEuOS4xDQo=
