Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CECEC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155F82070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="CYUitKig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbfACO7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 09:59:42 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:40950 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfACO7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 09:59:42 -0500
X-IronPort-AV: E=Sophos;i="5.56,435,1539673200"; 
   d="scan'208";a="22935897"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Jan 2019 07:59:38 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 3 Jan 2019 08:00:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93VWRM0TPpiT6bWJ8EtlRSAWMsFv/AYtou/eioSy40Q=;
 b=CYUitKig+CqgLQdE5yiNuUTqaJ95i6PcukHyQvoRgboARdLz1lJmpCZsZqvod5pvnqJyINunRmrynWV7TjuOyBoO8TsIRCrLniosBDQ87toDMuMC3lJrDM5Z34AnDIGgYilqQDVptOTrnL73H9ooy9aFRLojvbKSRUFXZ3EYb4w=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1760.namprd11.prod.outlook.com (10.175.53.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 3 Jan 2019 14:59:35 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627%6]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 14:59:35 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>, <Tristram.Ha@microchip.com>
Subject: [PATCH] net: macb: remove unnecessary code
Thread-Topic: [PATCH] net: macb: remove unnecessary code
Thread-Index: AQHUo3Tw84uggXM/Ski0WW4h2DNkOQ==
Date:   Thu, 3 Jan 2019 14:59:35 +0000
Message-ID: <1546527547-10262-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0602CA0017.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::27) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1760;6:ykNxx3oxEwYSn7KUrQsiTy1TbgHHg2KixTRLTbIhQC3lXYl6g4cu7DrwuGHKGzZPc9oNKw3UBaC5A2xAphdUga/mWPFEGGvcSOPkqOEv34wDTTxFN1ReN593mTMRXJEZi9KvPkoHm4pFIBTfeYsJYzHnuxGi8HhooHqao/TLlzLS3JiAW/Bc37nS9R39XHvGkzv65dG/As8OaumiW867BSpmoIRqVE5KGRL7ROlFSzJgWUABTLo2nfNMUWAslsodTTjESZPwqvxByf8TOxa4SEvzsAk73xtoMOtsyoXBwl0kzaLF9PK/576/OqIjmM0yEkhE5xTN/mL9KzVWF+rtbK5Oujnn/yYGqfd+SDsf5YzMy9kPTuOmA/i/Aw7/xVIyUt/vg3hd9RlqatRjWaQOEI4C6NF/dOizuTkRPKb9n0DT7CRWe+JKGL3tv0Gj3Mxc6RKiO/rCfii24yeNnZ2hzA==;5:roy/EAgncufVp3tXXk02NANyMKP2kR3D/oHjmJNArFxz50Unu6LywpsFd7VuyT+X92kN0Lteifoj3ZJ6gU+DEk+mfRF+3yekwT763zM2osgWAXTm5lW55A5GcQa8zAwOvzM6WdxpOJtYfUKwxm8vb3nsKTWnJwaYHJP5tS7f4Dk0o3VWAAHPw1HVstb98wjadIeiJCyGUNfjJy9LMmIykg==;7:H21seN5kHxQdO2W50iE1HjOZD0xSGM54WAZuk88N51+GRFHsCFnRa4yfUnmgJpN/gDB6CegZfBRz4q2JEHTdMDACeKFivk3VY2LQGdeRqpYRS5xgRJEn1fWNSne2JXYp5f0M9C8v5LqZvAWVK3JVYg==
x-ms-office365-filtering-correlation-id: 19cc6323-6e77-4048-5a84-08d6718c12f9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1760;
x-ms-traffictypediagnostic: MWHPR11MB1760:
x-microsoft-antispam-prvs: <MWHPR11MB1760E09E7F523EFD06BACD55878D0@MWHPR11MB1760.namprd11.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(10201501046)(93006095)(93001095)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:MWHPR11MB1760;BCL:0;PCL:0;RULEID:;SRVR:MWHPR11MB1760;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(199004)(189003)(66066001)(25786009)(486006)(2906002)(8676002)(68736007)(386003)(6506007)(99286004)(2501003)(6486002)(5660300001)(105586002)(106356001)(4326008)(6436002)(36756003)(7736002)(14454004)(71190400001)(107886003)(305945005)(476003)(54906003)(2616005)(110136005)(102836004)(86362001)(8936002)(53936002)(256004)(71200400001)(478600001)(6512007)(6116002)(72206003)(97736004)(52116002)(81166006)(81156014)(3846002)(316002)(186003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1760;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qXz7aWwVoDZP6z7PqDgkze++LaFQTTw8wkpfcT2dyYPWWJBrtVnh//E/d3F5Kmd5epZHrLdzpGVH7QOZlsaiCMutYRxneLRrIbdykmMJifzZrXbbxQzfZP1feMMw+rYYG8JDqsC3M6gGRDls1Fx/ASyn8nWHZuDV93FyMBZo/zdw8LNt23FCvDvwP95Q2nQuHzOxthb7D6ihM+7sL3utEDChGUqof6qS3bcSiaya/6gtUufVvA/y3xfGwKPEewZpDxILYiH4ObEssT0TUXFr6IJeNU64xrDxzto1Aoq+AnXRR5Hzw5jpdzoff9vxL7x5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 19cc6323-6e77-4048-5a84-08d6718c12f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 14:59:35.3390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1760
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Commit 653e92a9175e ("net: macb: add support for padding and fcs
computation") introduced a bug fixed by commit 899ecaedd155 ("net:
ethernet: cadence: fix socket buffer corruption problem"). Code removed
in this patch is not reachable at all so remove it.

Fixes: 653e92a9175e ("net: macb: add support for padding and fcs computatio=
n")
Cc: Tristram Ha <Tristram.Ha@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/etherne=
t/cadence/macb_main.c
index b126926ef7f5..66cc7927061a 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1738,12 +1738,8 @@ static int macb_pad_and_fcs(struct sk_buff **skb, st=
ruct net_device *ndev)
 		*skb =3D nskb;
 	}
=20
-	if (padlen) {
-		if (padlen >=3D ETH_FCS_LEN)
-			skb_put_zero(*skb, padlen - ETH_FCS_LEN);
-		else
-			skb_trim(*skb, ETH_FCS_LEN - padlen);
-	}
+	if (padlen > ETH_FCS_LEN)
+		skb_put_zero(*skb, padlen - ETH_FCS_LEN);
=20
 add_fcs:
 	/* set FCS to packet */
--=20
2.7.4

