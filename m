Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80271ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1078920881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1078920881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeIOBs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 21:48:28 -0400
Received: from mail-bl2nam02on0053.outbound.protection.outlook.com ([104.47.38.53]:10669
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726969AbeIOBs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 21:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEvVErA+MHkfjz+mizYa4ezOgLzdAytGyPppL1cLNAA=;
 b=aWyo3Q3cMtFopHrcm/osC0b+ikBuFlQALYXgeBP5NmQaKnOSBnt88cS1WeHaiLGtWmdyj7Y28TusrBEcFeKwyY66OVqC4NuTtzxa6sO7vFuke4xrklhr0M6950DObY13NNsnv+JFk0pAt25dGRdzeoyNStPztR9gz+LPuDMxffo=
Received: from DM5PR06MB3161.namprd06.prod.outlook.com (10.174.240.148) by
 DM5PR06MB3257.namprd06.prod.outlook.com (10.174.241.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Fri, 14 Sep 2018 20:32:22 +0000
Received: from DM5PR06MB3161.namprd06.prod.outlook.com
 ([fe80::114e:bdcc:c27c:c585]) by DM5PR06MB3161.namprd06.prod.outlook.com
 ([fe80::114e:bdcc:c27c:c585%2]) with mapi id 15.20.1122.020; Fri, 14 Sep 2018
 20:32:22 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.linux.org" <linux-nfs@vger.linux.org>
Subject: [GIT PULL] Please pull NFS client bugfixes for 4.19
Thread-Topic: [GIT PULL] Please pull NFS client bugfixes for 4.19
Thread-Index: AQHUTGoKDuGh83S5P0a7kBwpWzh2aA==
Date:   Fri, 14 Sep 2018 20:32:22 +0000
Message-ID: <9cf28df18cd2deba1b693df949e58efbcd299019.camel@netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [68.40.188.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR06MB3257;6:ceXMNCaPtQWkUd3pYo0eMiXFYVhajAq6txAYj8Ju/OWDiluBOa5hmjG3CRmvcXh8FMI3hf0wCaJgUpeyhas/hNNb0V8+NsZ/zqwaFOVy8sBwFQIHHkWkdBTsuX6mBqNFplnfkKHqNSYpWMTuIFeuV2mL/50C2KhIk8h6ohF65mjMzQA222y0pvyExBEQweODyJoC07hn2QBZzSqBiRACfoy5AE+0qSu/YXnHkkIwXZdrGHxMX8gicPsSdp2SzSiAsaapwXOosmeNCJ1+j3qKC/8HxMZWZGAEEsBNGKDigRaw4z/dHi13CYzQ68jK3EvtzWRGAVntMPL0pwl21s5SfO57SglywzNpoWYHxzReIyQzyqvMzlIMk7w3wjgT9H0O4IzILPPqq0Yw9Xfl9jCLL+il/mi4ncASnWGOnJ2sYlx7oB6E9DGzeu1UHdAK65zfqLg+FfHQfMmx/nNGNFTLjg==;5:cvg7R9SKeCpJaCuJQBAvXhdFEyKJ3gyPeitFODRTBRUy3LsYZQQS3I3Xoa74KpwIfZZIcyoTLDR8UEO65x1qGlh7JbpL3a27W8voi7EcwRrH2KofLyKFYmy+bor1D6KhvmfEW9Gmqpu+W4EjeMnNUiqTzXhEV9Myxw0Bf58AWBI=;7:DGAyYjPr59WVR/lMiicyJJK+gxVQ94Qxk1fmu03RoSzvgVm9B6lgoyIv919BmnVyFG4N10XDn8RfHJTWsXOlkeChTGbW4EQUKKWgHpAfU7lr+WgMdX1GI5ZWVvoGKyVpHtKtAsw5XKA+7mYIyjU+EcaXS6IE7EptyneHTLSSNlG01dD7z/ShFM4nBDtVt3KNa1ef2W0IqCmoVT9sSRF1h89O3ZpRllGlZipu37M1zTr+0l+s+3FGxhRHOWfS3LId
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 01532194-8708-495a-1845-08d61a812cbf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7193020);SRVR:DM5PR06MB3257;
x-ms-traffictypediagnostic: DM5PR06MB3257:
x-microsoft-antispam-prvs: <DM5PR06MB3257E8372CF1B6E3449FD581F8190@DM5PR06MB3257.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(5213294742642);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:DM5PR06MB3257;BCL:0;PCL:0;RULEID:;SRVR:DM5PR06MB3257;
x-forefront-prvs: 07954CC105
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(136003)(346002)(39860400002)(189003)(199004)(99286004)(5640700003)(81156014)(50226002)(6916009)(53936002)(6486002)(6512007)(316002)(8936002)(5660300001)(6436002)(118296001)(305945005)(2906002)(2900100001)(1730700003)(68736007)(25786009)(7736002)(81166006)(2501003)(4326008)(72206003)(478600001)(54906003)(66066001)(8676002)(14454004)(3846002)(97736004)(6116002)(105586002)(2351001)(106356001)(5250100002)(486006)(102836004)(2616005)(6506007)(26005)(186003)(476003)(256004)(86362001)(575784001)(36756003)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR06MB3257;H:DM5PR06MB3161.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XKcqQPbWQawLIS3nn1wOBmOPzgV0CHJmw+wxhCLDJshbZX4HLpBR+maTq9vxXHl9jid9xuBrFaSW1w3xDm3nlS7ZjLp1wENyXdWZMUeiqZtBePKUxN6qqKr2FOcSOkTimvR3v7931/Gk23vOOl8eRcemiKI+4XF4uIsBYThwQ5w5erIJ6PkpxMINbXSt8uqnaHnQTOhLa2fjntCh3vcZoqg3l/TauYRfcmmuXl1NoJ+46o66pNIZNvSl6l7lvyNscK7lRdVVFcswVw5b70o6N+xMGKIwIfuAn5GVww7c33r2mQrdQ2v2+dd6mWAE23BC+mPoZJAmrY/Bv31LgRdKFalCGK4kSaVPoa68iIWXd7g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD9BD424906C45468CBDA5609972EBA4@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01532194-8708-495a-1845-08d61a812cbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2018 20:32:22.2217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR06MB3257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgMGFmNGM4YmU5
N2ExNGQxZGY4YTc4YjQ5OTNhMDllOGRmZjU0NWExODoNCg0KICBwTkZTOiBSZW1vdmUgdW53YW50
ZWQgb3B0aW1pc2F0aW9uIG9mIGxheW91dGdldCAoMjAxOC0wOC0yMSAxMzozOTowOCAtMDQwMCkN
Cg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgZ2l0Oi8vZ2l0
LmxpbnV4LW5mcy5vcmcvcHJvamVjdHMvYW5uYS9saW51eC1uZnMuZ2l0IHRhZ3MvbmZzLWZvci00
LjE5LTINCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDlmMGM1MTI0ZjRhODI1MDNl
ZTVkNTVjNjBiMGI5YzZhZmMzYWY2OGI6DQoNCiAgTkZTOiBEb24ndCBvcGVuIGNvZGUgY2xlYXJp
bmcgb2YgZGVsZWdhdGlvbiBzdGF0ZSAoMjAxOC0wOS0xNCAxNjoyNDoyNyAtMDQwMCkNCg0KLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KDQpUaGVzZSBhcmUgYSBoYW5kZnVsIG9mIGZpeGVzIGZvciBwcm9ibGVtcyB0aGF0IFRy
b25kIGZvdW5kLiAgU29ycnkgdGhhdA0KcGF0Y2ggIzEgYW5kICMzIGhhdmUgdGhlIHNhbWUgbmFt
ZSwgYSBzZWNvbmQgaXNzdWUgd2FzIGZvdW5kIGFmdGVyIGFwcGx5aW5nDQp0aGUgZmlyc3QgcGF0
Y2guDQoNClRoYW5rcywNCkFubmENCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpUcm9uZCBNeWtsZWJ1c3QgKDUpOg0K
ICAgICAgTkZTdjQ6IEZpeCBhIHRyYWNlcG9pbnQgT29wcyBpbiBpbml0aWF0ZV9maWxlX2RyYWlu
aW5nKCkNCiAgICAgIHBORlM6IEVuc3VyZSB3ZSByZXR1cm4gdGhlIGVycm9yIGlmIHNvbWVvbmUg
a2lsbHMgYSB3YWl0aW5nIGxheW91dGdldA0KICAgICAgTkZTdjQ6IEZpeCBhIHRyYWNlcG9pbnQg
T29wcyBpbiBpbml0aWF0ZV9maWxlX2RyYWluaW5nKCkNCiAgICAgIE5GU3Y0LjEgZml4IGluZmlu
aXRlIGxvb3Agb24gSS9PLg0KICAgICAgTkZTOiBEb24ndCBvcGVuIGNvZGUgY2xlYXJpbmcgb2Yg
ZGVsZWdhdGlvbiBzdGF0ZQ0KDQogZnMvbmZzL25mczRwcm9jLmMgIHwgMzEgKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLQ0KIGZzL25mcy9uZnM0c3RhdGUuYyB8ICAyICsrDQogZnMvbmZz
L25mczR0cmFjZS5oIHwgIDQgKystLQ0KIGZzL25mcy9wbmZzLmMgICAgICB8IDI2ICsrKysrKysr
KysrKysrKystLS0tLS0tLS0tDQogNCBmaWxlcyBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspLCAy
NCBkZWxldGlvbnMoLSkNCg==
