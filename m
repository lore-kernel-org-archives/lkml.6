Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4891C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F65204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XPue7BMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F65204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbeIBRYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:24:01 -0400
Received: from mail-sn1nam02on0134.outbound.protection.outlook.com ([104.47.36.134]:59648
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727480AbeIBRYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMHlz7015KLytnd06ZvV1sVyRzy0hQ3RfSzGvObMnVE=;
 b=XPue7BMozBy1s7ghekmxzrnMfHVeRmpq6rleuIVDL3usbZzkN3q566EKOFbqs90B02+kvHm5aMdOSDUMrtjHb4KKr7JNxgvSjcBxp7MkhmajQBQSgQGkXWqVvcTx6kWwmgmzMGngUCWlu6dFbLla3DZRuX3HBDvgtidmEDMeYKU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0503.namprd21.prod.outlook.com (10.172.122.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:48 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:48 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 60/89] MIPS: Octeon: add missing of_node_put()
Thread-Topic: [PATCH AUTOSEL 4.14 60/89] MIPS: Octeon: add missing
 of_node_put()
Thread-Index: AQHUQr3jBTeYmFMQIEm8h2/5t8TyIg==
Date:   Sun, 2 Sep 2018 13:07:23 +0000
Message-ID: <20180902064918.183387-60-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0503;6:+SLr0tx2+ovoXEKSJxus4Sc0GjiNHuaiVYwNLN0u8CGiuASnqbG8qeHQ06uDqprxVWFKMmlbw6esQPnkXAxUYgSTi+0X2pAj1awOzG/D+2t13iO0Kkq6h3cwI2tHb51DzhYAeRQpXboS0rcvTpPTxiVDpJbIAKDhyt/LOioD+zo2eDXeWp2DLtZVjdPr2diWMsHSx2zbGBq/sdi2BqujAfK8PtI/aWwGYUH1FWJwuCVxSnXeUDSAYY8Jn0UhMslehf0L7VtVtP9whD/g9PC6tqbXttCgZRqNuQpyGi+CTgY5D2s/M/0eRnVuAKyIzP+PXp9OFv19/O/WxxnyDOJbd9UWT6pVlgpcFVTE0FQg3IUktE8EBpbiwSKH5Q6rreqbNieV7HrwIpXCV/VnpaLMXIM5yNTxAoDENaoolpsSn1ae05PLVC9afUZ4BxKutUJmkCN2+FFLeIzzP3MZGE4awg==;5:+A5WwZKrunuZ24DtiNV2EZSXBhd2mWWUkcL15XCGZ5KoXDxT9afHcbvnAIpDoH3V6xq+cjo3AuEzQNmzCFDsHgVeSM6ShOhN9+RNLkRY6GYzsefYW8UDKQVHQBM7kHUo8F6b0CENECY9J/cz5QiyLj8gapvTljy3fp3BHn4dWvg=;7:LWcLYkUdwOf3c8Im2uUs26KKerr0VwDdpil+6wVCOCKgVlVu6kq3OFDCyEZonHH3EQlMyJGLWX1Bjb56E/VtcwPIDf0HqKccaxM8OaHgdgUoP4dRUVUWNYQWYyc+z3mxCENVC7b+5msWbryuQqh7FTG+9YG0U08C84R+SWQm6P0VoMOLHMKOOJPWR/lZWpa7/sTjNde6n9qd2sEpXwnfVOvm+NNpFAGq6dptjI/YOe3RCPw2iyHHocTfmyyOlxxY
x-ms-office365-filtering-correlation-id: c5a4bbc7-1aea-47bd-4a84-08d610d514f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0503;
x-ms-traffictypediagnostic: CY4PR21MB0503:
x-microsoft-antispam-prvs: <CY4PR21MB05033B99BA169533DBA6C292FB0D0@CY4PR21MB0503.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0503;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0503;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(105586002)(8936002)(102836004)(6346003)(68736007)(2900100001)(6116002)(217873002)(186003)(36756003)(81156014)(81166006)(1076002)(99286004)(26005)(5660300001)(66066001)(6666003)(8676002)(54906003)(256004)(316002)(305945005)(22452003)(3846002)(10090500001)(7736002)(110136005)(106356001)(2906002)(6506007)(10290500003)(2501003)(966005)(478600001)(2616005)(72206003)(6512007)(53936002)(575784001)(86362001)(86612001)(107886003)(6436002)(14454004)(76176011)(486006)(25786009)(476003)(97736004)(446003)(11346002)(6486002)(4326008)(6306002)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0503;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: eU/fEwEP5ArTsM4etQj16qCdrhFd88SGEihXf1QMy5pmXElFPlbsTziWduR/GhRZGBiIp8GiPuF5n9yGadi4jWfeiB+QlBv8acuF59HTaqWlGSkUhVQc0CxITh603yYmMiC3CNszeqU1TKObbq5oLiZMKuZo3Z6XSh9r8RxXnC0A8JmSsvUMhGH0qeoMw0lEUN7Q1Q/LWipbhB04f2cdvtcAFF1vj1p4RQlKp/Vg3RfVpTInN/Srb9o5g16M6weJSXDAH3nh1qxAxsK17F9n+CzJa9PGbNVEika0DHJyaJd5pr09djLVc54z51ZopHr+mUMMYOidXtU74BDHTUkLwuLEG4vGFq4sDPN71+UgIDU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a4bbc7-1aea-47bd-4a84-08d610d514f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:23.5907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit b1259519e618d479ede8a0db5474b3aff99f5056 ]

The call to of_find_node_by_name returns a node pointer with refcount
incremented thus it must be explicitly decremented here after the last
usage.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/19558/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/cavium-octeon/octeon-platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-o=
cteon/octeon-platform.c
index 8505db478904..1d92efb82c37 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -322,6 +322,7 @@ static int __init octeon_ehci_device_init(void)
 		return 0;
=20
 	pd =3D of_find_device_by_node(ehci_node);
+	of_node_put(ehci_node);
 	if (!pd)
 		return 0;
=20
@@ -384,6 +385,7 @@ static int __init octeon_ohci_device_init(void)
 		return 0;
=20
 	pd =3D of_find_device_by_node(ohci_node);
+	of_node_put(ohci_node);
 	if (!pd)
 		return 0;
=20
--=20
2.17.1
