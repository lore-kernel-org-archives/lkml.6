Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C080CC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659492083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IU4IGBJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659492083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbeIGFTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:19:35 -0400
Received: from mail-cys01nam02on0134.outbound.protection.outlook.com ([104.47.37.134]:20941
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730880AbeIGFTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsxP1fooKhjspaYe/wyTwvpnCssxAqJWr5sa01XLEn4=;
 b=IU4IGBJQ4cBFDqe3N6KY1kqTQhntfhg3jLpZu6KUcYijw31Cw4mZCl3yz4Aoe0RhwgsGTwXIdvr1G40dy+9Ue8pfvPQzpQCR89qrwP0+k8dH4Qn17c0B/OwW11jo3otN8EiLjrdkP8474RmSuGFlvpNl7VZT773wpm7edr2KCgk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0694.namprd21.prod.outlook.com (10.175.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 38/43] s390/qeth: reset layer2 attribute on layer
 switch
Thread-Topic: [PATCH AUTOSEL 4.9 38/43] s390/qeth: reset layer2 attribute on
 layer switch
Thread-Index: AQHURkMixI1P4BGmu06UVXRc09bY+Q==
Date:   Fri, 7 Sep 2018 00:38:45 +0000
Message-ID: <20180907003816.57852-38-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0694;6:iLG8IfT4uOewly+GaaPal16W/Jx/K+gq6TMsP9TZrw9DCoFvISBeogOgd54Ud7DuVjuIiwhOtA7vhZFOCAVQ7DII/8SZduL1YtF0Pr7sTDu8Xq8IpONO5ZAz4bNf0360564PklqAHspRSfChxvT5Qh3gnTFyee0VPWjOgcH12vuLng71ecLeUJiCcrLwmMlueS+ydXukBC7SL61fwUaRZwB4v0RO1Lq04ms+SqhGH2nQU1Uv5ZthadkilKsWrNbZNr12coTj5LDVpQMEfDmIOeorr/t1COmNF2+Vy0A1NcLDhZHNoczTdgXz8ZZRrSGmmKI/flVGH3MFsaRJE25rfchb7Mlf7PMtcDwipnFP5A0IfgE8E+q2lnTmUuT2ROJbDxMjmnbe6dEHH7AawiTVmuaWZTn3rfB05ASOU1ok3O68lKbYPTJDUN+s5yfStffUZxN+xEiN1m1sknd6OMKNAQ==;5:46En9LWyjTUfKpKje/F4WcZJGksNxVZ7BRd2bZ7iQDmMpSnJUwWonOBKf84PbTVo/HIGSCn+u+IOxrfbVx2eWqWROLZJ6flySm1X9l0atPZjr9yakl0ZDZcI8CWP9FsZWNG6/uUOrRMF8GdQfLwizzNlVLfVu4c9lXUZphjqPv4=;7:ATFNyyin0Vxo3A6e3EhaPSpefJMcQ1qTvgcoJRrNlIZvYlWvtO1Q7Wi8x0Hl5N3J/AK0ecg++RuZHC8SVj/s0IGlV1CQQcKvRnM1PQAaF1+0uH6A/o05USNzps30dQ5rTWoXcWFNAxgb4uPP+/X0ww9mpxziOKqG4K2at9HcVCtY+YnMpu5iXOSi5gXs8gosANVteBSrvcKA4MZuay3bBC1WXve94sXG/enNySEH2F7gtr2I+RNt/9o1dSZQ1NRP
x-ms-office365-filtering-correlation-id: 8bf78076-63bb-41cc-9014-08d6145aa24c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0694;
x-ms-traffictypediagnostic: CY4PR21MB0694:
x-microsoft-antispam-prvs: <CY4PR21MB0694CDFF2D891308EA43F14CFB000@CY4PR21MB0694.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0694;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0694;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(2906002)(575784001)(186003)(86362001)(6666003)(110136005)(107886003)(54906003)(36756003)(25786009)(4326008)(256004)(2616005)(6506007)(6486002)(6346003)(6436002)(6512007)(446003)(476003)(11346002)(486006)(86612001)(2900100001)(5660300001)(102836004)(26005)(66066001)(53936002)(68736007)(7736002)(81166006)(81156014)(8676002)(10090500001)(8936002)(6116002)(3846002)(99286004)(105586002)(76176011)(106356001)(5250100002)(22452003)(14454004)(316002)(1076002)(2501003)(305945005)(217873002)(97736004)(10290500003)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0694;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Q1U/EDHXjewnB020i80+bleLldm3DPd2uuD1/KUQVNCT/mjfKE5vRnwbVrXz5h/o1Yvs7rC6kJ81/1+4M5R4bBgZHLrNknxwR0ULp+VV97GUNVnE5XTPAmYCCW1cL3LjmV0XJ4BUxNTB/y2iw7uGG1Co1/Zg3rdMVUXua3if6ZXJRKMdZkd1ZRrMOhKIwHEQ+JZcjU5pSPUUNV4AdxxeHCluFgrurA34/rM582RI0vU+i8EATBi2EOnQrzzxqvGUvr2K3oqOFlGMriNbxgeg/arqXNnd8RP2UR28DPQ87urxNtQqPLw+qdKPSztp3CQrQRg+x4nMI4pYHiahgKahSJIa1gQ3eyfgdiEyQiQEZEI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf78076-63bb-41cc-9014-08d6145aa24c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:45.1633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0694
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
index db6a285d41e0..0a7a6da36dfd 100644
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
