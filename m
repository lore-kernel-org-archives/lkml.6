Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD8BECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1DC2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KzHOO8HL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A1DC2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbeIQIbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:14 -0400
Received: from mail-eopbgr710091.outbound.protection.outlook.com ([40.107.71.91]:43296
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730787AbeIQIbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tb4IJoQOPfRhx2q4SYG6PBWc6FcUBye7uVSe21CIWk8=;
 b=KzHOO8HLEte3qwHuljI5IbVQ6naisS//2OgRMcqknvIxyN0SXKK5yBrOmtgr1IXqkwhhuARtce9kLs/Jm8+gWnB8g5OpO+MLwLKV7FkIlyvBIPw9RDcbMyhGS6Vx9yasXU9QnAEOoGl0KleggbhgfameYmGsBWVVTL+Mj4WnkGI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.6; Mon, 17 Sep 2018 03:05:47 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:47 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 31/57] ALSA: snd-aoa: add of_node_put() in error
 path
Thread-Topic: [PATCH AUTOSEL 4.9 31/57] ALSA: snd-aoa: add of_node_put() in
 error path
Thread-Index: AQHUTjMW9sFKhE3gk0aCQiGju7qHtg==
Date:   Mon, 17 Sep 2018 03:04:02 +0000
Message-ID: <20180917030340.378-31-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:0x9Dhrvczek+TPzzPJAJ7r3XuDGCAPb0Ypmibqz7tFy9tyxb3FFHJzvyGmv7X8SrkBHSo/GIZrWpmr7bIgtVIp8biOeY9cfRWGrCsVgWyopcaawE8K0VBdoIXjtcl6TGkIiV5NMx4nGaYIJpndjBHU7C60tVMfPGykE95TtG/bKhWgexdmKuLKqTpTT9W+qNiL2VzqCGD2cB9q7YiknCo9HUG3XQ+8VrQ5Rsd5sOzDdblRFbYmTn8k7naE4/pdq7+R6yfNdbBe6fjyJwizV6wivWrzBK+5lCWIvaXMShbzJv8BtpxLq3oCJ8i5J6zsVghAwV/q7jJwIMiRnT5aenADTekmMr/uTjyfk3lPo78gndAJhWLDdZffgmFGajlDvmdOCj2M4G1y9r2+wZc2zjDCYp9WKFd2PpY2GPPJTSYK4OUTjDZJyMsDlMwkG+qN/gfMakpGhsqQzVL4iBzSl14A==;5:7Wv4oeHx6jfdLTwo6raCGPOl3wikt7RSJEUIKBw6v0eJyq974WQ2yhSXMCjW9j+e0YLwSicu5UsUM789iO2sE8IMc0y9L+GgWC2vFn/x9ClVq6McI9jMqDZIK7mAz9XdaYVxgd8Z7vq4b73IBb+3iFvHkmpCwbtMD6lAJhlO9Qw=;7:G5K6G98+Y6LSj37PwDKJBlEGdnjS5hnHZPoj4/EcMPctGBIzHFmDegtWt1RzliRFbz2dVmBTIiSNod8zGJs90Xw/hJ1sspdy+DTMQeZL7scqSllfSq0eEYXQ+ycNR2p+ym8xXOjajesgUw/i9kmaQmL2Vk4okwWCSVY3AOYzdlkDmnJESo8rjzJkHWfohmZADuilV1OoEuE9c2FW96OvCjSc8rH2xdbOnveUWBDLzun//FZbzko2R+68UzDIxUTK
x-ms-office365-filtering-correlation-id: e40873b6-a932-47fa-1695-08d61c4a774d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB0757CB703FBC55B78F358C16FB1E0@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(8936002)(68736007)(476003)(575784001)(10290500003)(446003)(53936002)(11346002)(6512007)(486006)(86612001)(6436002)(1076002)(256004)(6486002)(2616005)(14444005)(81156014)(81166006)(7736002)(8676002)(217873002)(478600001)(305945005)(3846002)(6116002)(86362001)(4326008)(106356001)(66066001)(186003)(36756003)(99286004)(76176011)(102836004)(107886003)(26005)(2906002)(5660300001)(110136005)(54906003)(10090500001)(22452003)(72206003)(2900100001)(316002)(14454004)(97736004)(105586002)(6506007)(25786009)(6346003)(6666003)(5250100002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: rEdmQPd/BVPDMEBly7HsU8wCgwQ8SPtkQ/3Xmvpu6Q/J95WuCy/B2DYUH4Xo61KRYWzQ2vqY2MJOCgHgWX95yM68yiJDPDIrnafDX6woyk0odrB/vyJ7ahKTjtL0w75xxknrMC1p+ettpLuA8Iv1+gA2woZ4cYMc1CwbXu4bqn7n1BE2myh854MZIJuupjXyYy+XiZO1DE6kEi6K+hhbb0I0ZzuZ1gmnsWL/GKV+7fcnCCgng0KQNuEYWqgSD92dv+sP7hrCse8LOJCeEJCy/jB5edm0c7Pb5wAARcJsw9MeX5Zk4/qvAZJ5yV9DE0INmHCqFAQs/3iP57CRrOREflRhX+B7qHjCFmPlvBkEyEY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40873b6-a932-47fa-1695-08d61c4a774d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:02.3209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit 222bce5eb88d1af656419db04bcd84b2419fb900 ]

 Both calls to of_find_node_by_name() and of_get_next_child() return a
node pointer with refcount incremented thus it must be explicidly
decremented here after the last usage. As we are assured to have a
refcounted  np  either from the initial
of_find_node_by_name(NULL, name); or from the of_get_next_child(gpio, np)
in the while loop if we reached the error code path below, an
x of_node_put(np) is needed.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit f3d9478b2ce4 ("[ALSA] snd-aoa: add snd-aoa")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/aoa/core/gpio-feature.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/aoa/core/gpio-feature.c b/sound/aoa/core/gpio-feature.c
index 71960089e207..65557421fe0b 100644
--- a/sound/aoa/core/gpio-feature.c
+++ b/sound/aoa/core/gpio-feature.c
@@ -88,8 +88,10 @@ static struct device_node *get_gpio(char *name,
 	}
=20
 	reg =3D of_get_property(np, "reg", NULL);
-	if (!reg)
+	if (!reg) {
+		of_node_put(np);
 		return NULL;
+	}
=20
 	*gpioptr =3D *reg;
=20
--=20
2.17.1
