Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D401ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E0F2064D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="N67F7RVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E0F2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbeIXVLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:11:23 -0400
Received: from mail-bn3nam01on0094.outbound.protection.outlook.com ([104.47.33.94]:39765
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730107AbeIXUve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+kQ13vM/6yZ2imKcEUrr7EdoKom7DjboFFRucOOAwY=;
 b=N67F7RVYa1779Ivb8siWvPq9khHKONR96xqWOM3CKr9PGAySwNEe2kQnY1ng+SHeBP4Zx7v6jk+v2OR+hkFUWCQqYuW6aoZ1acUQ1jB1B+GJ2++NY1xjJR5liqfd91or6TumURwy1KjkY482IaEQB1mgkYC04IFtJsy5FOHKmrU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:48:59 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:59 +0000
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
Subject: [PATCH AUTOSEL 4.18 52/76] net: ethernet: cpsw-phy-sel: prefer
 phandle for phy sel
Thread-Topic: [PATCH AUTOSEL 4.18 52/76] net: ethernet: cpsw-phy-sel: prefer
 phandle for phy sel
Thread-Index: AQHUVBWqtjXDvPUTH0eQWdmSSNX6vQ==
Date:   Mon, 24 Sep 2018 14:48:33 +0000
Message-ID: <20180924144751.164410-51-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:nMI9ghDXZE40yzfwpqNXedQiuiN2zGv/W0mzlODIPDllTx0D3M61Fu3WLPB1dRARtrRBBlOJ2MNZNioRQbjCDbPgOz9ae8sphDYj3z6+/4MXTZEAmcoVeD5VmP1bDtwKBUE3UcUyJytqXUYCTXoRFMMCQpLQJk5d7xG+Ux9GO+tcjNsRdsUVd4raqc6AT4ZTEAm3ijFVxuaTVgOrITOn3J1nIUA0hR0lNohOvAUQvUlPuFPVFOiaCXCbceUdJnxf3PpZHHMp4e2J4dv8rkkyvfcn/i9Wn+EKdtFEsNqX+EZf/tKIdOxQ2U7mHa3s4epaIAZoNFmOpCc9Xoh/Yk/iXa96wujOuOKGe95w9Osv7cyVsCKf19Qxd0wbyT9cQLo7nzu8igOWwge3k/KXdholmUA7Y17hp5ONDWuZK/amtAB/BvRUFD6a1nV39QT5IF1WwONd3zMVU0qi3TTGPscccA==;5:BlzfeqNEnUrD8i5jrSAs21hu6XBl/jp97Y46TPBdGyFOyu+/uiXjmFZwlqctmbHZPgJG1R7RlloOQXqsEt1/EPPT1og2zDqa7UNNnMHCS25CAIJYW+MQrWAnaXhTS3Pu2cRLkNlnrUnGXk0t1RzjLvwx3Uk4vMziZ4V7xxDp18I=;7:f64KuCiFWcVULjKZF/dWkxwvweIewYwzjxneWk/enRt9Q6EMDkY45dFoJItDKVWfIs5kec6SfWhj+UqDFVlal5Dsh2HZ6gb1WpfpajeKnSikrDgzdX/MUaBIJsJ/2PCTMZWqVkIANZZ8cCgyTSr/W2rzeGF76ZXv8TgbEA+COCFFThnOtipivk5BxVaWCYCWncSLhCmgS/HNbg4vzWkjB1/hfO54UdTpBXjETNBHCtms3+Gma35i9NFQUCdKw3HP
x-ms-office365-filtering-correlation-id: 01486b2c-ce58-470f-00ba-08d6222cdc76
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0744C1BA9A65A80AF1912E5EFB170@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(31051911155226)(180628864354917)(28532068793085)(89211679590171)(12401385986421);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(2280196)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(39860400002)(376002)(366004)(189003)(199004)(11346002)(446003)(476003)(86362001)(186003)(81166006)(6506007)(8676002)(81156014)(6666003)(5660300001)(486006)(99286004)(53936002)(305945005)(6512007)(6436002)(2616005)(71200400001)(71190400001)(68736007)(6486002)(102836004)(10090500001)(7736002)(36756003)(97736004)(86612001)(7416002)(316002)(3846002)(6116002)(1076002)(217873002)(14444005)(256004)(54906003)(110136005)(107886003)(10290500003)(4326008)(478600001)(22452003)(5250100002)(26005)(8936002)(2906002)(2501003)(2900100001)(66066001)(72206003)(105586002)(14454004)(76176011)(25786009)(106356001)(60540400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RnJN8wO2e9hc1leecGZCBsSnRuv99xio+Ne9y3/GO6zaxKpHs6PmaatDilXBHMR/3OxxJjMTPydZGPGPacXXbj8DA3DvxdouvbmmwzvM1H2w0AYdfbc4ES59QkFUUFZWlMK5HFxiZEHLbFBoEl9s3z+x3SN31MRzxQrY5FoFHQSQuLHbt2fRMETEaUQ52XxfT8iD8VpOC0lNdiCHTzcnWi7ue5xnWcMv5y7aTa9DwBR6wLwAXj/GLSIwCFBfy3wuVH19X05z+Ju9jrHIMyP1lBrRPhjdPQdBkV3Y1UuxuTBMYr9CqC5g+odu5A9mSPHxCNsBTREt7PmhDzUc3PWVAEpWr1sZTR2gc85FEn5EgQjMcXhK5kA5kmU3iSRxNVKnZxbo+Ppze8nOQOfIAsxJh7ifMprqH5qfy0zwoDELwS8jmGvMVRD25kSUCcmpNz2xiwe0XSAvmu/Al8miW5bqs04lmfGo++aNhTFeI3Avwby0oeE/a+hfMriuE3Zk091nY59wMx37xW5eURROWwYu47BPYpWGGFaN1Oe78ViMeSafso1lOuGhYvFTY8oXfr0h
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01486b2c-ce58-470f-00ba-08d6222cdc76
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:33.5398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
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
