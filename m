Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421ECC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D992087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="f58ksgJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D992087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388786AbeIXUxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:53:34 -0400
Received: from mail-by2nam03on0094.outbound.protection.outlook.com ([104.47.42.94]:22973
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388734AbeIXUxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+kQ13vM/6yZ2imKcEUrr7EdoKom7DjboFFRucOOAwY=;
 b=f58ksgJSpCzwWlmTGiLZYgdhQ0+0IXDZKuGwqItUv1rSHrvWtI1tHvkiu6RRXrh0yWZUZg+VGRNk/4FCXvBD0LWYDUSb01keu/lQQ8xqVhr7eWgtpsJYsHUwDSM86y8VU0QkrQpYgTNwJeXC6QSkxnCZsjiTh+3yNGTb3FlKYhs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:50:58 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:58 +0000
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
Subject: [PATCH AUTOSEL 4.9 12/23] net: ethernet: cpsw-phy-sel: prefer phandle
 for phy sel
Thread-Topic: [PATCH AUTOSEL 4.9 12/23] net: ethernet: cpsw-phy-sel: prefer
 phandle for phy sel
Thread-Index: AQHUVBXMwGQ1mUsaYEmrkEdC0L9bRQ==
Date:   Mon, 24 Sep 2018 14:49:30 +0000
Message-ID: <20180924144919.164617-12-alexander.levin@microsoft.com>
References: <20180924144919.164617-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144919.164617-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:fqlPDFADgdoDYa7TMf9XgQAxtb+MQVRByuSjSCp9f3Q1gmGSn86swYxNCGKwo8eO4Nn4wLFJI3I/IT1Hj82+1ycBWc5z7cPYBFLkTACa/rNIKDpb7HW26rjw+6c1F67VpeaounMWydKKjKOCi+OqEVyp2QfvJ+0bvMEnklu65o6TORAGi/obviM3ffiWW2S2cQCRRffFWPWC+hT0x74t9aQgTS7ioulmC2aaGGqncvGCniiPvnfAofMg+nVuZ8PFJPZcvCurO3JBFtGHQnBXskzDcdHnlsEJTDQPnbW1BHoBB2DK4rjUKvJH86BcFJ0FLXbMt+5eiStFGMWAkwFQVNvQlpv5XNNddSUmvaW8MkvYCtiBNKDCjP4TgTNSbbPviVQiOxCGaZCjl/1ptYHSE5FcFbRfLEp8ZtdJMsWUqr8kzZDmotkBoe2ky9o0QPS9LxFuavf0ZbEkyjRiBQ69cw==;5:V9nBUoO7uBsGn1RqHiaQgB2AWUCCLKHKtOF6ekZe8yIwYOGNjN/sXdN8iJvNI/aeEC0WZxgvoSiB/GF1fZlHGFsly0E+SR9SmGutOCr7DoJaZVQcAYvh9tU+fqh2hfuwzeKoCmvh8In82CMfIoDE7bLToPfyxuZhxuECC5IivOM=;7:G6HMNTjvm84LGH90Oo43MYCsnqaD3GzHt50fokBE/yF21+mVpEFAp9X+Zq4wyGDHA4ncHRYhIHdAqHpCPfXVouJJgFUKnQ/JdCfNkADlFceMtlHnY3NrtbvKz/a/jUJiZHvcn9i1JzlWrWq+55mSUusF2ciePeOKO9HL0QtKbIH2GvKvc24ACU53H0kQjZAc5QifFb7yCuHVoKtXHoyKYdRWCrJPduGRDRz2sF2UioHG6mILuJpMnaa+a86Pw4Iz
x-ms-office365-filtering-correlation-id: 0ecc22dd-20ac-4389-f024-08d6222d2367
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0181846369DD92AEB842AF54FB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(31051911155226)(180628864354917)(28532068793085)(89211679590171)(12401385986421);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(2280196)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(14444005)(7416002)(5250100002)(217873002)(6666003)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(11346002)(446003)(76176011)(60540400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ajt1Ctd/tS7j018TWckdWBAeW5aWwTYiwWRiIh19QsppKJ2JIxnNlAuKGfMqk6ZEOJvJiW4bwDgibIkgW1O6sxK30QBusxSX8yrLT8cVklQrWoNSWMV7kFPIN3l+HeqV7D59Jd+gTJQDbo+ZEbWO/rWmvHeIpVp8GFZ6gNEyidmTD5EobW3FZPK4ZuatBhhO2XuFhYfPp2vGv8l3EwRWXvPwTXIFSi+LHtvNSgCgTsUcNtemJGfzWqesxAsWIgt30y+YCU8CRtRZoUsUzBxxf7iAAW6wJ/NVHzsoLBy1hOs2n5XcghHmWxp0sXenyRVBX6YkJOtTGyAYTQ0Ypk1EShTIMuKBfZ9qeDut1VIJCtTlq7MRSHn2l6L9+PT89vKSVRiiD/cnszbfTNFIP14KdkfAhlHnPYgOFs7dHveCqffHOR9GEIzdYgpPe6M3nPblv9PBH9opfw4ielsA5yZTHFjp4plP9Yt8V514/U7JwvtnuviH5bDn+uZkeBQTwQgF8DFYaHGgH7XY1SQWYb5FyQQZV8UWeXhBQxf+MRnwZg+wvTw8laGgKR5O0NlUmYGt
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecc22dd-20ac-4389-f024-08d6222d2367
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:30.6068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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
