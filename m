Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5463C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9684620857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="naD2oQOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9684620857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbeIGFSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:18:10 -0400
Received: from mail-eopbgr680106.outbound.protection.outlook.com ([40.107.68.106]:39946
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730321AbeIGFSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muYUKlIgaU7HWbzxJCwJ1gtDd+pUkWWyp0a8whLQN9U=;
 b=naD2oQObrDvyV5MNdZSv7rtjQ4Gh6kjlXXJkHB5b9HS62d2wNbfXRVmcyDQtBYalyVXuQHnY0RoCcY16Mbp8qno+tAWK9L1K1zrMme1dEsP3xPINYmoPBoXckDg9rciRqde8BOsAQJiuno7juwLXMrMjNpnkip+LqXKBar5YuDk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0695.namprd21.prod.outlook.com (10.175.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:39:08 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:39:08 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 58/67] s390/qeth: reset layer2 attribute on layer
 switch
Thread-Topic: [PATCH AUTOSEL 4.14 58/67] s390/qeth: reset layer2 attribute on
 layer switch
Thread-Index: AQHURkMJAMpNlG5+S0aB9j1HwBPUtw==
Date:   Fri, 7 Sep 2018 00:38:03 +0000
Message-ID: <20180907003716.57737-58-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0695;6:7L//yNJp691O2h/ZJLTKx+M0fXXzex14T3UpPqkxI2o3iWogQWvPhnHSHBpVHU36ChahCX0zDvurlvQ3zKknRPIlsm4qfZojlX9/R/vyAd//ilQVmGFX08sZVUD+POL60HitcbrAtVXFxqnUbu2SE88ASaZFP4URuAeIKQVs01yVkU0Il83XgvGS5RQnQbVQEgDuRPUEsWZlceE6LoeBaC370anNCfaHazUPj5ZCCfIpRrWYbBc5ymEOd5wQyQQw086Tc0mpUnRE/YvP/PEOE3H9nm4Po3xsX7IYNwRuk+kLAswVn768hqOOszpVQST7d+//8PAh0+bPYDKXjhbk6nqjz+5QbT9AXNuZgBa/dKPLRsx9JhpV9+JUSPLMXnB+IMxvcXuKEUBp2UM61ymNNi7IQZ1f+7/k4ht7wWykQilf17rjEYcdWfnFAZNoTWiPfcWUMDTNFDJs/8HgxIvz5Q==;5:3Qpu/cBHHpxjnnRkhnX7L0DlAExsyqpnbTYjThf2Y2zgSxCmXb0in63Fv31iGzpuze+IDrD6qiWLE95yd6f4tFMTx/KXm+fgUD/lVlnfHmvtHKb1z4suheCNBuqiexbdGhCfbsAi9yL7JTBkMTli0R/9uTImzAqlpOeZFS3affA=;7:vAAe8lcM2Tx7WJI/gLmdgbYUSwkqFgBp65wwKJA+3M+mhfa5kD+u26WSUU23JC0yJuLf4GqXkcK58VgmaXQ5vCpmZK5SXWLZuyw/zkCEScmbQlKGTygk6Tnz7RwUgCQUATEg+zvrraH+ZLOlDHwf9yqL4jaDP6EWM4j67Wym/f0e7ewcwqaoTuUVF6mmPAec/9A403Fk1TsOMsdiwQBAvyZuf+MLplVNFJKgdwI2iog8mj0HtYToGNIWf7hHng5Y
x-ms-office365-filtering-correlation-id: 319b5bd2-bd31-4065-61c3-08d6145a52bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0695;
x-ms-traffictypediagnostic: CY4PR21MB0695:
x-microsoft-antispam-prvs: <CY4PR21MB0695036ABD426247103D4442FB000@CY4PR21MB0695.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0695;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0695;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(136003)(199004)(189003)(99286004)(6486002)(5250100002)(256004)(6436002)(8676002)(81156014)(81166006)(2906002)(10090500001)(97736004)(2900100001)(76176011)(305945005)(7736002)(25786009)(36756003)(86612001)(105586002)(22452003)(106356001)(575784001)(4326008)(66066001)(476003)(2616005)(5660300001)(486006)(6666003)(446003)(11346002)(86362001)(316002)(8936002)(6506007)(6116002)(72206003)(3846002)(14454004)(217873002)(2501003)(6512007)(478600001)(1076002)(10290500003)(53936002)(68736007)(102836004)(110136005)(6346003)(54906003)(26005)(186003)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0695;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ehMujXPI945kRXKv8iwAMaX3zScQd96iGP4iWlnyu8CMLMxXr2AVxd5rUgsTE/oG5HMX9UEpn4Qlp07nZ1ztB+H3C+EGWMa8MyIHtyz8+wlFdc/jzf57vvMaDA9QyhKQSys3BZ+tIIFPZU5okGs3yBbJPFaCS7NlR7Rydfl1+ngLp8cNasOjLkS8hLJF6nEjrLmwuLSWiEdG1eG/yJlDkHIChS3u/THtiPA8pXTY6D+SBR+crYoLX2foKlq6z1e0NVyl5DQXa61dJTF3PO24QL2JaxLzEEFftxIRicNbl1f3cNPmoNasx3ULzdqBR/RH4uPKUConutTl111GepFZ6hj1ysWOu8djOga43IhJ/UE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319b5bd2-bd31-4065-61c3-08d6145a52bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:03.2599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0695
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit 70551dc46ffa3555a0b5f3545b0cd87ab67fd002 ]

After the subdriver's remove() routine has completed, the card's layer
mode is undetermined again. Reflect this in the layer2 field.

If qeth_dev_layer2_store() hits an error after remove() was called, the
card _always_ requires a setup(), even if the previous layer mode is
requested again.
But qeth_dev_layer2_store() bails out early if the requested layer mode
still matches the current one. So unless we reset the layer2 field,
re-probing the card back to its previous mode is currently not possible.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/s390/net/qeth_core_sys.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_=
sys.c
index d1ee9e30c68b..21e91fbb2860 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -423,6 +423,7 @@ static ssize_t qeth_dev_layer2_store(struct device *dev=
,
 	if (card->discipline) {
 		card->discipline->remove(card->gdev);
 		qeth_core_free_discipline(card);
+		card->options.layer2 =3D -1;
 	}
=20
 	rc =3D qeth_core_load_discipline(card, newdis);
--=20
2.17.1
