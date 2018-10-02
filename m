Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC37C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE962089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P1ghiHMl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE962089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeJBS7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:59:23 -0400
Received: from mail-he1eur01on0047.outbound.protection.outlook.com ([104.47.0.47]:49983
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727610AbeJBS7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9A67WAkTuLmWG8BV0N11CTw9aA59LypGUOINHIVf3Tc=;
 b=P1ghiHMlpAX0OmDwoO4j/QTyCVjQ47XKkDqEdzw7xNsSAvs/Nf2FnxOmQnAqrXz6lGt/jj5/ltWyf3T4bVVzy1biGV7RRUmdf10v55mePaINrDTEH3WYYy6T/8XQniy8aBcXyRgQUK39RVOriW5xcfshz+5OkellvCWdrQrIUB0=
Received: from HE1PR0401MB2363.eurprd04.prod.outlook.com (10.168.33.8) by
 HE1PR0401MB2459.eurprd04.prod.outlook.com (10.168.147.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.23; Tue, 2 Oct 2018 12:16:17 +0000
Received: from HE1PR0401MB2363.eurprd04.prod.outlook.com
 ([fe80::10fa:841f:d25c:a565]) by HE1PR0401MB2363.eurprd04.prod.outlook.com
 ([fe80::10fa:841f:d25c:a565%10]) with mapi id 15.20.1185.024; Tue, 2 Oct 2018
 12:16:17 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Leo Li <leoyang.li@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
CC:     "stuyoder@gmail.com" <stuyoder@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH] bus: fsl-mc: explicitly define the fsl_mc_command endianness
Thread-Topic: [PATCH] bus: fsl-mc: explicitly define the fsl_mc_command
 endianness
Thread-Index: AQHUWkm47JDUmoDApkiQYO7wBwTqZA==
Date:   Tue, 2 Oct 2018 12:16:17 +0000
Message-ID: <1538482550-7698-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0189.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::13) To HE1PR0401MB2363.eurprd04.prod.outlook.com
 (2603:10a6:3:25::8)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2459;6:iinTUm1bPGDxoJinGDn+QpYDtUltdZQeWDDPmOlZApxz6Xe271Qe0qFeTyCEx1GXOgiaU4VLfuYX/PDTHOnEYFMZIH8pS6sbV7UZ+QKZEqUAtf7llVp+pGSTRUBMFJptak8FPp/lztGpiSKGbX2PlCBxKS+PUv+HJKUxXtrWnFp+02QwaxNPJ9Q7QLUt4F2oMCLjpbLgGnMsfxUI/1ENYYI1FIDWB1ndsbhqfMmzQpNFxQlO7WhoCh/NouJiuirelQbzo5yGjnPFGzorzOzsr/kuKPtWB/XTgT8dVor3SjL0xOnm46dxRmmXdrDdHN5mvgoe1xSxMHsYTof/pP9YpMoWUfezr0EofJUUmlENG7UMgDuhf8lZbeVwavttO8xeXHCUAQdmhmrLWpG6qokTmtX1oXQbpsOlZVYMYotcAKSyvFDuTDFBCdvoGf4RZZ3/TjXLYu9pQM1p46Zye51kKg==;5:+89yeFpaJ4YE+QWONMN4FeB11PMRDemSS+MGz0NE+PYi28nHB5AdjhyYbx7qG22kRjzHr2FuWnm6j1zYg6AmDbkIG/SXBznIRhI+WAjXsc3uvCcWx8HMmpBXX/CyA+WaMcLwhS/q7ZVJiZNkrN6RrJ5ZiXzJ4LKEtFfVp57oiGM=;7:tGOsTJKsQVLJ/WMU4am7SNOXjjaAvc0hZKtgQZaMu0J+ErHkKC301nvODLykQU5JX9AVkGjIEyOl4lhoN5XErE4Zcn6aZlKkVSwzQNk7GdXAoDn0P8Cok1CXy/bKEgyqPiWVkdl9AsAOPdM+vdciSkSyQNhP1JOARnMJ/IGDkmaVu6wjq0lZp+hJAamzwz3NECZ7amtupICwSwLdN2x7SlX6FEtAtVizxpL9a8wj+Dt15vqcFmc1TjNw4iRzuZhX
x-ms-office365-filtering-correlation-id: d69dd34a-4c8c-453c-8f50-08d62860da6d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2459;
x-ms-traffictypediagnostic: HE1PR0401MB2459:
x-microsoft-antispam-prvs: <HE1PR0401MB24598E2755479D6ABC52C3E2E0E80@HE1PR0401MB2459.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:HE1PR0401MB2459;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2459;
x-forefront-prvs: 0813C68E65
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(136003)(396003)(189003)(199004)(99286004)(6506007)(36756003)(386003)(6436002)(52116002)(6346003)(68736007)(305945005)(86362001)(478600001)(575784001)(39060400002)(4326008)(25786009)(6486002)(6512007)(26005)(102836004)(71200400001)(97736004)(186003)(5250100002)(256004)(8676002)(2501003)(71190400001)(105586002)(106356001)(81156014)(2906002)(8936002)(316002)(53936002)(486006)(476003)(2616005)(54906003)(110136005)(1857600001)(6636002)(14454004)(5660300001)(6116002)(66066001)(7736002)(81166006)(2900100001)(44832011)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2459;H:HE1PR0401MB2363.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-microsoft-antispam-message-info: lqaDMDF5BN+W6fiIUBqB+kuvpGB41csoYiWHboZMEmBuVnRis3Gc6ulCUZYjIAVNw7QzYAap6B/9vmJvnOVtWCGWZ2F0v4afyYC2w/SP/pOhJDcEhptccYogUNhCvbPV7iFLwiLm+GROXIHynCvrMsFJdEC5alYpoNw+cJySYgySandY8/AhiyuKuIjr1n4fYbL3Xw5qhGilBLCJUi8j4QaLIeTDt2hiPe4VPpzb0B3a7xNY4Xck+TG5QgL1kP2pYQsFYQ/1eglqOyf5odeomNEEQIvSlUxdmqOLsCQ+nNlPNAk5JAtlu3epEQN8PwFTbTXpDScQtcxqr01ykAt93Cx0t60OAMOHoRsMpItMsGY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69dd34a-4c8c-453c-8f50-08d62860da6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 12:16:17.4682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2459
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the header and the command parameters of the fsl_mc_command are
64-bit little-endian words. Use the appropriate type to explicitly
specify their endianness.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 include/linux/fsl/mc.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index f27cb14..96c54bb 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -210,8 +210,8 @@ struct mc_cmd_header {
 };
=20
 struct fsl_mc_command {
-	u64 header;
-	u64 params[MC_CMD_NUM_OF_PARAMS];
+	__le64 header;
+	__le64 params[MC_CMD_NUM_OF_PARAMS];
 };
=20
 enum mc_cmd_status {
@@ -238,11 +238,11 @@ enum mc_cmd_status {
 /* Command completion flag */
 #define MC_CMD_FLAG_INTR_DIS	0x01
=20
-static inline u64 mc_encode_cmd_header(u16 cmd_id,
-				       u32 cmd_flags,
-				       u16 token)
+static inline __le64 mc_encode_cmd_header(u16 cmd_id,
+					  u32 cmd_flags,
+					  u16 token)
 {
-	u64 header =3D 0;
+	__le64 header =3D 0;
 	struct mc_cmd_header *hdr =3D (struct mc_cmd_header *)&header;
=20
 	hdr->cmd_id =3D cpu_to_le16(cmd_id);
--=20
1.9.1

