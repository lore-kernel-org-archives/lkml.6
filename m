Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCECC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AF12083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="QrOR8Yex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfBUT0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:26:32 -0500
Received: from mail-eopbgr720059.outbound.protection.outlook.com ([40.107.72.59]:12608
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbfBUT0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVGULZESIqUijGMj2PUmNHTvqiPLKcCI9ux0MchfP14=;
 b=QrOR8YexkmnHRCWmKXIgCynhHRtXIyRhZBQjVIBwmwSiCJ8vhGKjHDdd94+8SEs+F2dPdVUuSu4Uunx/9O5joJtHCbidieNSV+jJZMADqSZ0anjKOe/nsq3b8xUSU0qkOr8rBqVHew6wA4Jza8BHYIOOwEaJyrfGL7Y7YNNTAug=
Received: from BYAPR05MB5048.namprd05.prod.outlook.com (20.177.230.218) by
 BYAPR05MB6165.namprd05.prod.outlook.com (20.178.55.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Thu, 21 Feb 2019 19:26:29 +0000
Received: from BYAPR05MB5048.namprd05.prod.outlook.com
 ([fe80::b542:165c:d3da:244]) by BYAPR05MB5048.namprd05.prod.outlook.com
 ([fe80::b542:165c:d3da:244%5]) with mapi id 15.20.1643.008; Thu, 21 Feb 2019
 19:26:29 +0000
From:   Vishnu DASA <vdasa@vmware.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: Re: [PATCH] VMCI: Support upto 64-bit PPNs
Thread-Topic: [PATCH] VMCI: Support upto 64-bit PPNs
Thread-Index: AQHUxUwV6nWluENUEEaVtzCnZJ3KiqXi18+AgAdOKwA=
Date:   Thu, 21 Feb 2019 19:26:29 +0000
Message-ID: <8C694A7E-488C-42A9-83F8-AA4FB4E57A5A@vmware.com>
References: <20190215162738.21334-1-vdasa@vmware.com>
 <20190216195253.GB11061@kroah.com>
In-Reply-To: <20190216195253.GB11061@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b83c469-7475-45c6-3c9a-08d698327ad9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB6165;
x-ms-traffictypediagnostic: BYAPR05MB6165:
x-microsoft-exchange-diagnostics: 1;BYAPR05MB6165;20:etSec/JstQW2/Qdl6zWmuznAGb/pIFotBKPmLjpcv7XfCruaI/3D8g2gO6/1RU7tCzN8VVMdLGfSXCDhxwtn23uMrxGzJ2YFT0ynRUXIqu2DV4nqXmcqL+qHedDU/mW+FKl6m207HviAaIflQyalgTTsyf0K9LLlITbtUlvergc=
x-microsoft-antispam-prvs: <BYAPR05MB6165D33176837AE7B1FB9FC2CE7E0@BYAPR05MB6165.namprd05.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(366004)(376002)(136003)(189003)(199004)(6512007)(2906002)(68736007)(33656002)(2501003)(8676002)(82746002)(81166006)(99286004)(256004)(6916009)(6486002)(1730700003)(6436002)(5640700003)(229853002)(14454004)(478600001)(2351001)(106356001)(4744005)(6506007)(102836004)(105586002)(6246003)(107886003)(81156014)(8936002)(26005)(6116002)(3846002)(6346003)(54906003)(66066001)(186003)(25786009)(97736004)(36756003)(71200400001)(476003)(486006)(86362001)(316002)(4326008)(11346002)(305945005)(76176011)(53936002)(2616005)(446003)(7736002)(83716004)(5660300002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6165;H:BYAPR05MB5048.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vdasa@vmware.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9Oh4UuukQhfSKS3LF+/2wD/iT4AA/tBN3A05fiuVjhstUMgIVoDzT1jT0HZwxGaKpWIRf9HQAFTzO9bBUM8JhmWSPI41lHpJdAIt4ECW1Ae+O5iC51I1ZRA1so8fDiz2cESk3MnZxiAWoPzINRwijRPu2X8t9ZdVBv6RfZFssVfxSkN+CChsDmLx8xKmi/oEHTKI9dM/KCxw1TACFhF3/3XJO6lDeRl1NlCkyNEJJL5SiU8eQ6T9MFBiXYaRyk5hoJLJbbT5uLRwMoVTaAHb5cOhia+eBA4gTNngjsxx1yCXddrldQezIC8N5q+RVTXCXTAVDg7Tu9zcUhdVMbnL154W2R5gabaww1kBBiCrZsT9+2N5hNZvN2fOfkHzvZL0xF7IiGMv85S4/aTbCe7uiscKhpeMv3JjRj9uK0uzCTU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F6510A4F7428F488965BE7A9C4FE057@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b83c469-7475-45c6-3c9a-08d698327ad9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 19:26:29.4836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNClNvdW5kcyBsaWtlIGEgZ29vZCBpZGVhIHRvIHVzZSB0aGUgQklUKCkgbWFjcm8g
YnV0IGNhbiBJIGRvIHRoYXQgaW4gYSBzZXBhcmF0ZSBjaGFuZ2UgdG8gY292ZXIgdGhlIGVudGly
ZSBmaWxlIChhbmQgcGVyaGFwcyBvdGhlciB2bWNpIGZpbGVzIHRvbyk/DQoNClRoYW5rcywNClZp
c2hudQ0KDQrvu79PbiAyLzE2LzE5LCAxMTo1MyBBTSwgImdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnIiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KDQogICAgT24gRnJpLCBG
ZWIgMTUsIDIwMTkgYXQgMDQ6MzI6NDdQTSArMDAwMCwgVmlzaG51IERBU0Egd3JvdGU6DQogICAg
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92bXdfdm1jaV9kZWZzLmggYi9pbmNsdWRlL2xp
bnV4L3Ztd192bWNpX2RlZnMuaA0KICAgID4gaW5kZXggYjcyNGVmNzAwNWRlLi5lYWExZTc2MmJm
MDYgMTAwNjQ0DQogICAgPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3Ztd192bWNpX2RlZnMuaA0KICAg
ID4gKysrIGIvaW5jbHVkZS9saW51eC92bXdfdm1jaV9kZWZzLmgNCiAgICA+IEBAIC00NSw2ICs0
NSw3IEBADQogICAgPiAgI2RlZmluZSBWTUNJX0NBUFNfR1VFU1RDQUxMICAgICAweDINCiAgICA+
ICAjZGVmaW5lIFZNQ0lfQ0FQU19EQVRBR1JBTSAgICAgIDB4NA0KICAgID4gICNkZWZpbmUgVk1D
SV9DQVBTX05PVElGSUNBVElPTlMgMHg4DQogICAgPiArI2RlZmluZSBWTUNJX0NBUFNfUFBONjQg
ICAgICAgICAweDEwDQogICAgDQogICAgQklUKCk/DQogICAgDQogICAgDQoNCg==
