Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B7CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B6F2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LqZIrr9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B6F2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732775AbeIXVAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:00:25 -0400
Received: from mail-sn1nam01on0093.outbound.protection.outlook.com ([104.47.32.93]:29512
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731595AbeIXUwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+kQ13vM/6yZ2imKcEUrr7EdoKom7DjboFFRucOOAwY=;
 b=LqZIrr9eI6fPr9SULaSNH3t53dbbQtor5/onwH5GkFHQUt4DwGnlcmd5KJj2bzSgqXuTBAfmFy+LPdZxtuYjYUkrGyYMxC813DYGzgQeFFBlqQCYYYYNuCuTfbQ0sqYPD8d5zU9txNQjsxBiq/vIFxg5qWkGQVrS9mNn8jkzW5I=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:50:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tony Lindgren <tony@atomide.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 24/36] net: ethernet: cpsw-phy-sel: prefer
 phandle for phy sel
Thread-Topic: [PATCH AUTOSEL 4.14 24/36] net: ethernet: cpsw-phy-sel: prefer
 phandle for phy sel
Thread-Index: AQHUVBW+RrdRoVIOLUuW5UJsBjEg3w==
Date:   Mon, 24 Sep 2018 14:49:07 +0000
Message-ID: <20180924144851.164533-24-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:zsRiL7tG0CPmUMzrBldA1jA8HOPabiWPVG3NqxBGGx4NTsl3GgXcFIoeinRAwTx8lsZKuBUzdavNFlrxsc51NQq47DNUD5Br9wKC938s8v/snN6dOGH52s44i1cgIuZCuODoVNOSTAdG+s3T75oCOv8ApMQy6zAuu8xXqCv+AbnLYlAqaBmoYdZpscOz/cux06BH0rW+B2hVeFoNnNnd+3ZOnUMC8EabI4l2Ny1Beolq/ywhDfT/oCyQXsdqgiEo0qbSj/RJSUHzqeSYwd/MEeCJuZ3nIhanP0y15wX24HM8KyHogWoe35xQ9de+9rbH36RMd9F1VPh/ZlTE7rmz+Kz3Sk0/kHo0g4YbwsKhOzDnokbUW11RAwbIHD54FAmAIrP9JmBNRmDeWMe0t3tmYPat9HS0qP7EEf53iqtMk4CppnNf6SxNvIBIxXa/GQwSGluJA10cYsGq3s79pTCTIQ==;5:WqN6Bssgvxd7qOj9ldWfL18sLVJfK5k84ziDun3mJBTDM39wCTyIOASPhUqaKxz2C++n800f0AuDDaswExqnh1R5egxilYGAaIC8910qhjF/nGQzQnhQpXfAPdHGRE3UaYilCE+qd7dOdKEQNrcdJaSMPVwnObNKQED+li/a3Xo=;7:1PrDddlmtEAT209jiNopFq4pWFZyFJ8YJDqvtkPBGxaahLoeOawtn5qz/WSxIZuucOp2wr6/tOW8oT49JuvJANHFwHXIKCmAl+nE/Ku5lAF7XoMP4sqYZUz8NceTBqJDJgTPP1d3fcPKn4FuCpqX3VbWQEeS2yCqqagJU+1jgdzSoRXbPu2p0uwi/xF2FwaFTlCjS87/o0rUg2hGlkMdamxELkP6gY6lImvAVzlWYvkEgxLtoI6KXBHHjjYK7Tr5
x-ms-office365-filtering-correlation-id: 0958b963-bd65-43cb-a583-08d6222d0b7d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB047064C7464C007546B68D80FB170@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(31051911155226)(180628864354917)(28532068793085)(89211679590171)(12401385986421);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(2280196)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(26005)(97736004)(53936002)(14444005)(25786009)(1076002)(76176011)(99286004)(102836004)(186003)(6666003)(4326008)(3846002)(110136005)(107886003)(86362001)(5660300001)(6116002)(72206003)(54906003)(478600001)(8676002)(217873002)(86612001)(256004)(14454004)(10290500003)(316002)(6486002)(6436002)(106356001)(486006)(105586002)(446003)(6506007)(11346002)(476003)(10090500001)(2616005)(2501003)(5250100002)(71190400001)(68736007)(66066001)(81156014)(71200400001)(22452003)(7416002)(7736002)(305945005)(2900100001)(8936002)(6512007)(81166006)(36756003)(2906002)(60540400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: al95Rtpa6ASQ1rR8qAFTxz1bTJgw+1H/5/39BgOyoqq/DQpwdaG4ZwAQkNVQ1/txr8Uh2bio7zuo+p+n9omI70RSZe8rKmQWh3HqJSdtcEazx7lePZB6rgnT/YzLVHhUkKgPqGqn/PjzLbZXTYDwtTmAguWr98ClVaeyAamz7AQTte5PGuCzgdvQCB4ksoTA44I1T8FyQj7TcutYegU5BLM9SKkM09DVYkkeRn0yqDAbhTTCpQWxd2Je4J1FudRTd5FjE0fiEYfERz9AjCQrY/bZIcqcm8royNrMdSbFk71xciRpnJeGJdFBDol36S7a8B7aOAMIDzx2EhblMFZ8PBO/R21dL4USo9tUup/t8mromY9Sqk5bVS73TUQk8Ug/2z//cO9yHNTMPi116/z5FTiklgnyax+i0BCMVntMQbgWcZq6Yu1w7jQN8vyO++LukKp92LopIgtKIsylAF8zFzCaSNR81Pgam3ZNZSNgtNc9qQTh19kWnlu7b/STHmEoGj5l9iLTFYBlA3/j3x6wRAFltnKUms/YbmJ/nA7moMnKjsE3UT3kpuk4DUtCY2xa
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0958b963-bd65-43cb-a583-08d6222d0b7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:07.4498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 18eb8aea7fb2fb4490e578b1b8a1096c34b2fc48 ]

The cpsw-phy-sel device is not a child of the cpsw interconnect target
module. It lives in the system control module.

Let's fix this issue by trying to use cpsw-phy-sel phandle first if it
exists and if not fall back to current usage of trying to find the
cpsw-phy-sel child. That way the phy sel driver can be a child of the
system control module where it belongs in the device tree.

Without this fix, we cannot have a proper interconnect target module
hierarchy in device tree for things like genpd.

Note that deferred probe is mostly not supported by cpsw and this patch
does not attempt to fix that. In case deferred probe support is needed,
this could be added to cpsw_slave_open() and phy_connect() so they start
handling and returning errors.

For documenting it, looks like the cpsw-phy-sel is used for all cpsw device
tree nodes. It's missing the related binding documentation, so let's also
update the binding documentation accordingly.

Cc: devicetree@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/ti/cpsw-phy-sel.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw-phy-sel.c b/drivers/net/ethernet/=
ti/cpsw-phy-sel.c
index 0c1adad7415d..396e1cd10667 100644
--- a/drivers/net/ethernet/ti/cpsw-phy-sel.c
+++ b/drivers/net/ethernet/ti/cpsw-phy-sel.c
@@ -170,10 +170,13 @@ void cpsw_phy_sel(struct device *dev, phy_interface_t=
 phy_mode, int slave)
 	struct device_node *node;
 	struct cpsw_phy_sel_priv *priv;
=20
-	node =3D of_get_child_by_name(dev->of_node, "cpsw-phy-sel");
+	node =3D of_parse_phandle(dev->of_node, "cpsw-phy-sel", 0);
 	if (!node) {
-		dev_err(dev, "Phy mode driver DT not found\n");
-		return;
+		node =3D of_get_child_by_name(dev->of_node, "cpsw-phy-sel");
+		if (!node) {
+			dev_err(dev, "Phy mode driver DT not found\n");
+			return;
+		}
 	}
=20
 	dev =3D bus_find_device(&platform_bus_type, NULL, node, match);
--=20
2.17.1
