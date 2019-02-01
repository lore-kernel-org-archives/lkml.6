Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D7DC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F4F21726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hqTSvTpn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbfBAQrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:47:15 -0500
Received: from mail-eopbgr780074.outbound.protection.outlook.com ([40.107.78.74]:62851
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727057AbfBAQrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxTO8VBVbiNOJR8VRWYsI6CT4iLbuBawqPZDTCQI0Ig=;
 b=hqTSvTpnJTIqohyVnFRr33rY5QAeNOxtfJCCnwVFwM3OcMrGsyk9VAhrKlW3NCwDhoKopW/giLfzp/ILvUrkUQ/j7RgLFm693wz6ITxL1fqHax9YWoOTZFeArKbEoRwCDKqfGvOwwC/YPiiCTd3CYZbizW0PE55eSjP+D7P5WhM=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB3291.namprd12.prod.outlook.com (20.179.106.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Fri, 1 Feb 2019 16:47:13 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::10bf:617c:4515:4ad2]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::10bf:617c:4515:4ad2%2]) with mapi id 15.20.1558.026; Fri, 1 Feb 2019
 16:47:13 +0000
From:   "Singh, Brijesh" <brijesh.singh@amd.com>
To:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: [PATCH 0/2] KVM: SVM: move the SEV command handling into a separate
 file
Thread-Topic: [PATCH 0/2] KVM: SVM: move the SEV command handling into a
 separate file
Thread-Index: AQHUuk3H4gJB1J4DqUi+VYhv1rGmfw==
Date:   Fri, 1 Feb 2019 16:47:12 +0000
Message-ID: <20190201164654.3888-1-brijesh.singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR15CA0025.namprd15.prod.outlook.com
 (2603:10b6:805:16::38) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3291;20:CFUnUcmFclpneil/jqDPRuNXc/QgYUPUtIf4WNK7orJoyjG+JFbEk2qa74N45LgEhEnYeixsCnzMUSzbzABAwySe8j9eUPDvz/46d/ScEO/kXUer+iW9wubBMquwWdHDX2KmOsdlJNNitn78u/aZNvsTrgg7GmUcXTbGX3hPQzVzqTp0hSDL46KPIY0b9mvejU4HwTfxvlZ0cqKmqDddTO4UXIvlj9OmNF3mNhJa0ReBmydeG0a5NdKeliuU+js/
x-ms-office365-filtering-correlation-id: 30af3636-5aca-4a94-6543-08d68864ea04
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3291;
x-ms-traffictypediagnostic: DM6PR12MB3291:
x-microsoft-antispam-prvs: <DM6PR12MB32912D04C2338A495790F6B8E5920@DM6PR12MB3291.namprd12.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(366004)(136003)(199004)(189003)(99286004)(4744005)(6436002)(25786009)(4326008)(36756003)(110136005)(54906003)(966005)(71190400001)(6486002)(2501003)(71200400001)(50226002)(81156014)(6306002)(316002)(8936002)(81166006)(6512007)(8676002)(52116002)(1076003)(7736002)(478600001)(305945005)(6506007)(386003)(66066001)(14454004)(6116002)(68736007)(3846002)(26005)(86362001)(256004)(186003)(102836004)(2906002)(2616005)(476003)(53936002)(97736004)(105586002)(106356001)(486006)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3291;H:DM6PR12MB2682.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZRJX/sW8FW2ueGBBGsd7iZkY1f/PSc3SodKDg8a6+tsxPPXfC1HsxbsJF6z9fA6CIXQ0qI0PJ117omzpszizjhjP+x1Yg4bwzb9aeqrAjDwZn4rHaJ5Co7TaEFEo326hg0+rlve3GxybxaO4FCRv8KWUEFw/Ks5dSRxBzes6c42yXBrZEc4lHbfMUNkquDR2U50ZJP0rITR7GP9OWoQ3ig7U5o0JjZo/8brOsm127YOzTbE+9uxYgl9UOROJiJh4QyOInAwHP1wDQUvv4MFVHw4KQgkzrtFtxRlfXA59msj1Le6+9vY6vOE6Go91OtFF/2bKCFc2zXpRZaNHLR+tp0OgDdsvY0QF+vfK+xZXd6mHmc4yAufaCIcujaUwHswS/CINC5NCqH4mEeO8kF6FR2IDpySZsTz9K1wb28+Bfc8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52643AF0BB51BF4BA3FA7AC8809C57EF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30af3636-5aca-4a94-6543-08d68864ea04
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 16:47:11.4110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3291
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

c3ZtLmMgaXMgcHJldHR5IGh1Z2UsIGJlZm9yZSB3ZSBhZGQgbW9yZSBTRVYgc3BlY2lmaWMgY29t
bWFuZHMgKGUuZyBTRVYtRVMsDQpTRVYtTWlncmF0aW9uIGV0YykgbGV0cyBtb3ZlIHRoZSBTRVYg
Y29tbWFuZCBoYW5kbGluZyBpbnRvIGEgc2VwYXJhdGUgZmlsZS4NClRoZXJlIGlzIG5vIGxvZ2lj
YWwgY2hhbmdlcyBpbiB0aGlzIHNlcmllcy4NCg0KVGhlIHBhdGNoIGlzIGJhc2VkIG9uIG1vdGl2
YXRpb24gZnJvbSB0aGlzIHRocmVhZDoNCmh0dHBzOi8vbWFyYy5pbmZvLz9sPWxpbnV4LWtlcm5l
bCZtPTE1MzkxMDI0MDUwNzM5OSZ3PTINCg0KQ2M6IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44
LmRlPg0KQ2M6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+DQpDYzogIlJhZGlt
IEtyxI1tw6HFmSIgPHJrcmNtYXJAcmVkaGF0LmNvbT4NCkNjOiBKb2VyZyBSb2VkZWwgPGpvcm9A
OGJ5dGVzLm9yZz4NCkNjOiBUb20gTGVuZGFja3kgPFRob21hcy5MZW5kYWNreUBhbWQuY29tPg0K
DQpCcmlqZXNoIFNpbmdoICgyKToNCiAgS1ZNOiBTVk06IG1vdmUgY29tbW9uIHN0cnVjdCBkZWZp
bml0aW9ucyB0byBoZWFkZXIgZmlsZQ0KICBLVk06IFNWTTogbW92ZSB0aGUgU0VWIHNwZWNpZmlj
IGZ1bmN0aW9uIGluIGEgc2VwYXJhdGUgZmlsZQ0KDQogYXJjaC94ODYvaW5jbHVkZS9hc20vc3Zt
LmggfCAgMTU1ICsrKysrDQogYXJjaC94ODYva3ZtL01ha2VmaWxlICAgICAgfCAgICAyICsNCiBh
cmNoL3g4Ni9rdm0vc2V2LmMgICAgICAgICB8IDEwNzYgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KIGFyY2gveDg2L2t2bS9zZXYuaCAgICAgICAgIHwgICA0MCArKw0KIGFyY2gveDg2
L2t2bS9zdm0uYyAgICAgICAgIHwgMTIzNCArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCiA1IGZpbGVzIGNoYW5nZWQsIDEyOTYgaW5zZXJ0aW9ucygrKSwgMTIxMSBkZWxldGlv
bnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC94ODYva3ZtL3Nldi5jDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGFyY2gveDg2L2t2bS9zZXYuaA0KDQotLSANCjIuMTcuMQ0KDQo=
