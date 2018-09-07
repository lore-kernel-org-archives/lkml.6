Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19A0C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E8220844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Zu3CkOeC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E8220844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbeIGFfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:35:08 -0400
Received: from mail-sn1nam02on0091.outbound.protection.outlook.com ([104.47.36.91]:3440
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727799AbeIGFPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhCfqe4lR8iytpMUnjEtRRSuOEDm/N2pNqr7ZNAdgqo=;
 b=Zu3CkOeCWcOS4asS/r3Hosw7rannpj5laPISwTSOQjcYm+0a06GG4mDJB486bt9JSMdM0gaIDyOQc2Lad9y852pvhCk44m47jKRsij+EcQuEycfawpXWoigHZ30F53o4cd5o321eskVB69EBBmbBoShTwVjmPjNb1NWHAar/lcY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:37:35 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:35 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 74/88] s390/qeth: reset layer2 attribute on layer
 switch
Thread-Topic: [PATCH AUTOSEL 4.18 74/88] s390/qeth: reset layer2 attribute on
 layer switch
Thread-Index: AQHURkLaBzI9anXohkGVh0MUazcHpw==
Date:   Fri, 7 Sep 2018 00:36:44 +0000
Message-ID: <20180907003547.57567-74-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:Ar0eXzCvvvLD0uSM90BA0GcTai8HwLe0NsWYUzfgHo36yJaXV9YcH0GZQIWKPG8cPQf2F9PAdFRt0sfN0kxJoEsEEDpFxrlqxTEMa5TXOLDTfyTdaZy2jX/jWcnAmpHlfMyDQ4/Sd/yFHhVFK/o+OQkMHU/grYCFnIrNQTMX1t3n1+3UqKhfIvv2AsBwUCELBpV7Z31xLgktIh0M6YhWH85hmJaSHwtdn/2NnKNtRVnjQ44RAXNvaP7xtsRcIrV+uK+ZrNgM1yQLar0HyTmq+kDaBej6hKmds5YTDCkpkVIrZEossDeg+2lWb6Z5U7+6RPl6gPG6XYUdLphsXsn7Of6yLG3HVP1CJTrx0YosydBfq+JU0z1jJn+GnJ9371oPkpu1AbnlcTauOtRamt3//Je/x8IuY4vsCNscaszp7mg08w2cb75dZuH8y+s3Ba/DYJ8flopPGRJAs/2umTg/Yw==;5:lpHKqnTC1jkVhxMsjtrlgb04Pvuk7txCUsgvJL7ongNBmW/lTj3d6m2NBKvYIbG4NlzcDiYIAhjybeHMSvGyr9xIRvNj5bkDbIDQmp/42Yes/ygqMyt3GN3UsJeV8Xe/j3ZiF9DW18xkc2LC4256/RxspNoFMi5wB5ckBgLowGU=;7:sjr9QhFCX+BimalEDzUh2aDRFOZLbUQNpXUsPFQ3JINJ54tWJNokvJBgzJEc+oXj/mYto4o1hvjui1HovURb+CcOydSrDsSHU0ceh3cTCQLVJjBAXpXix/ty/ho806Jv7iJQ+CnN47HHxeGOFmou60znGVHGj71WavxtqsiiQIb3nk9rt9JfyHTnLPHoSwrYmGYflf4IzGf2F3A1HiWKxN54LoMFCr5TzL8qslXEjBIgDu5+/bQxaWU9yfk8mpqn
x-ms-office365-filtering-correlation-id: da6000f9-9970-4507-27eb-08d6145a1b4c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01188567EF0E202828361720FB000@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(136003)(366004)(189003)(199004)(97736004)(2900100001)(53936002)(316002)(86612001)(25786009)(86362001)(575784001)(2906002)(6512007)(68736007)(110136005)(54906003)(107886003)(4326008)(10290500003)(14454004)(81156014)(81166006)(66066001)(8936002)(8676002)(478600001)(6116002)(3846002)(72206003)(305945005)(7736002)(1076002)(106356001)(105586002)(36756003)(99286004)(186003)(26005)(5250100002)(446003)(6666003)(256004)(217873002)(10090500001)(76176011)(5660300001)(6436002)(11346002)(6486002)(6506007)(102836004)(2501003)(22452003)(476003)(486006)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: H7iWIEvHWw6jF+LTfDyHGlb4Tk/hq7K4U6qXvoqA3+kFr7UMG1hqGvOCUxtdlTGf3zSuccUTVBvLkyY0E7cKUOp2vInQHle1kJumwSe22HQLym1VDtbcGU3YqbuT2EHf46pqpfbjXzkA3p7jnoEQdafvZNJ2mxMFGas0FEJUn6SnwB/TUZQ62njBjlvswnUF0ulFBMyj6kJ6EUfNAAXuQtnyqhiagy9PnnyPs48VooXL2R+FGzg/x0ZhcAkwMu0Hz67ItdU+WGgVg4yxcHyCFs3eJijVItBlcrl6Sp+imvfHtBNLGaXi7L8xuTPMV9p7utaDgD+ilmhiLormgaRZsgUGIB4Vj1rwVIGIQHrFKjI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da6000f9-9970-4507-27eb-08d6145a1b4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:44.3919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
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
index c3f18afb368b..cfb659747693 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -426,6 +426,7 @@ static ssize_t qeth_dev_layer2_store(struct device *dev=
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
