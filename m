Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54212ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C138C208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="V2c7TjiZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C138C208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbeIQI7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:59:36 -0400
Received: from mail-eopbgr710095.outbound.protection.outlook.com ([40.107.71.95]:52685
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728996AbeIQI0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOwbSpjpujF7HuGjruRdpVcAVl0Q5TZh9dC7IxI8P04=;
 b=V2c7TjiZ3Gx5IKDmP0MaMWL1AO+1re2njaVqb/5TMjd5yaURlOCaPcCWDO6jSM8jPlC/avWV7zePYdqr0reofSIYIi0EoXFyCI3aNmT4mQOjTEqfEr3S6cW9rhrI6JtBEkIaadDpjWSigYM2LZ/ISfy2+TJF6qRsfePwn1iLcd4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:01:14 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:14 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alagu Sankar <alagusankar@silex-india.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 054/136] ath10k: sdio: set skb len for all rx
 packets
Thread-Topic: [PATCH AUTOSEL 4.18 054/136] ath10k: sdio: set skb len for all
 rx packets
Thread-Index: AQHUTjKhdnr2BbODH0eKl/GOpZdnjg==
Date:   Mon, 17 Sep 2018 03:00:46 +0000
Message-ID: <20180917030006.245495-54-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:gSqGNTY35JnfL3+X4NI3Eo9d+OYCyeu5KshbrbYxLhqV5xNV8/UjGTYKOnaQgg4TizWXA+XyMmKo8ppMGaiwiMcmbf1li8+kVRMUrZZ8fkuOlRO2aCLtNtnNKgm7ktVZR3HD5JW3OmVKV9UyL2QsUSuXu/iyP+8F1ic50l6/lBXfPyISf+JwM5uNJbT7tcjQLJNYugQDsik6+xahQLFDQZVvraiSXZao9qzO8wu6wS+ZE9ClkwcQxj5uUgWKWmrqQe/jndKPse8dx3LAkG4K/he45nbiIa3Xy6q5wUIM9rLKqOrkfXv2a6334xe86Yo58TrJ5LyfLlQk+Ln9Bk99xiQGz0dsEN1xvv1/qzrez9s5TfO5uoSdlzCK7bfSQDyqocat5fpkKrD+Djp3l13WUWNhnHJHnHeGZqiUw0lCrAO4uUzN0LbuZH3/0KBB5tFK6b3cCWxFOOOqgytiFGOYfg==;5:J1qSIlzncSEx3OhY9S0tXLPPios5eCrMGJdYtJ+IQTDKe8Mb+oS3YshdQErOVLp1Qepw9x2sO29AUMErfil5J6iFgBm9u+d/h8Lf5rlHyWqdaBK5sz+9vvLTV5taNvukdYrimfIobjDW4/Ma0kiJ8Y5SSCdHzhJ02dDw0n+FVqs=;7:a4U1qiJ5MW++9f+2xVQ0YrNLbXADnotmqRqX9sWhfwQJWKWYM9nzm6UQApxvIW4WnidbwtW3IaYzSyqZWBCJsblbNUGmMkHsdB+mfvVuWShQ6x7hdS2P8a3djuEq+ikPX1DhzjKhZUWTCUAPUrTh/jHBw7lq2snaH4mcbs0LSxRkAbcbTFVS09kRbh330crFz4u1nohAzBLSZyuD8/27UiYYKJSyn9edoS2F9VbpAqufAlq2+ADHs1AiSfebbDUR
x-ms-office365-filtering-correlation-id: 8f9eff3b-492a-48c1-5b77-08d61c49d4c1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB01677BBB13A948230A3F54A9FB1E0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39860400002)(199004)(189003)(6116002)(1076002)(86612001)(4326008)(97736004)(53936002)(2900100001)(7736002)(107886003)(106356001)(10290500003)(81166006)(105586002)(68736007)(3846002)(99286004)(305945005)(36756003)(8936002)(2906002)(217873002)(54906003)(86362001)(110136005)(25786009)(316002)(5660300001)(102836004)(66066001)(76176011)(478600001)(446003)(11346002)(2616005)(8676002)(486006)(476003)(6346003)(186003)(26005)(6666003)(6506007)(6512007)(5250100002)(6436002)(10090500001)(6486002)(72206003)(14454004)(256004)(2501003)(22452003)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: DVWwO6RF5sIRl+YDRD+i+HAgba8kp0x0QbrxYSvtt7bzu3WO0d/lCVTtKl/4F9HztINzk59WhUN/Z2kZix9k+X6/kDUvBawrsv76HlDCxDmMQI/4hyPbRRaFvIoW/B8xH8wS4J6+qVS274OJK6WzjOnJ21puL/Fc48kR1z6CBSwaMsGtWtkskXF8qfcZiD2WbxsSSPBruN8Z4JPn399knu/poOjjmmgCLwcRGPIB2umtLOT/+DW5QDk2ktL8ZK3lj/UziLeZGwjCe2OBL1Q/FLFnSfCqk2rZyNw45y3jPEgFDha4GJP6ySHNq0NMWf3cZIZLVaHB1KX0YvrV4vAp0dpAtCaosBm2yEVqFSNm5nQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9eff3b-492a-48c1-5b77-08d61c49d4c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:46.1045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alagu Sankar <alagusankar@silex-india.com>

[ Upstream commit 8530b4e7b22bc3bd8240579f3844c73947cd5f71 ]

Without this, packets larger than 1500 will silently be dropped.
Easily reproduced by sending a ping packet with a size larger
than 1500.

Co-Developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Alagu Sankar <alagusankar@silex-india.com>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath10k/sdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/=
ath/ath10k/sdio.c
index d46523b0472c..aebdf99068e7 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -396,6 +396,7 @@ static int ath10k_sdio_mbox_rx_process_packet(struct at=
h10k *ar,
 	int ret;
=20
 	payload_len =3D le16_to_cpu(htc_hdr->len);
+	skb->len =3D payload_len + sizeof(struct ath10k_htc_hdr);
=20
 	if (trailer_present) {
 		trailer =3D skb->data + sizeof(*htc_hdr) +
--=20
2.17.1
