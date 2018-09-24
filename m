Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87F5C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694952087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ozfBv/Kv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694952087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389294AbeIXUyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:54:32 -0400
Received: from mail-eopbgr680134.outbound.protection.outlook.com ([40.107.68.134]:2178
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731967AbeIXUyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFdIVdvKIHPkPD35mrk5JjrrotO57nfYjjNhWaHyBeY=;
 b=ozfBv/KvS41sosVyOy9u8Sq2LGwNaK/mLnECD5UfmwWBhJxs2b8meMU65pNFcp6nnrSQLsJdlBrJbcG6bYVNIDKOVMRjPRt0JK+MN2+sqY1T1sFHWN2AQ6Ng6GjoyrVwkGSI3D93QRwQNsy94MSR1SMLXVbvOmYpWDbcjUhehXc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0631.namprd21.prod.outlook.com (10.175.115.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:51:49 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:49 +0000
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
Subject: [PATCH AUTOSEL 3.18 06/13] net: ethernet: cpsw-phy-sel: prefer
 phandle for phy sel
Thread-Topic: [PATCH AUTOSEL 3.18 06/13] net: ethernet: cpsw-phy-sel: prefer
 phandle for phy sel
Thread-Index: AQHUVBXkRMXvNEFnmUe5PB9W5854Bw==
Date:   Mon, 24 Sep 2018 14:50:10 +0000
Message-ID: <20180924144959.164754-6-alexander.levin@microsoft.com>
References: <20180924144959.164754-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144959.164754-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0631;6:Yz3N8FNfNVBDfm9SclLVu5J8jb8BISOVdvIbVJ92oo6hUIB+TsZOwfTsP6cSoc+DGUGERB2XpBhXJJMT//+6p3QCH2LCt0wvb2U0VWDubeDlm114ozZ3d6wd7ivJ5Aztm78hmitWx0AW9JdPMtr2Evy2VQftU5aV0BDLtgYsT/9b8XqmBpuRL4QzPEis6h2nbr7wdQZ8vdm4m275rZdN8vjlORnw8FxUTo7M+UcAaEXox7GgRbNNkEBWTHWr85iwD/I1g5sRCMuSxZRJPNk1ZdQ1qNcF6KPhO7CtQdEWqRTdyPyMhmafiOgBpqvTWKql1AH1XUIE9AkFTATVEUUc4wd/5f202PeXatCH5IZl0odJCj5d4d9DAIY9VceUjYM81i4uatyxcSNnl+TYs3hiNTwiwPMB0NOi8jC/4/sXc8WEbhtvnx4TPqRAO+rBEJOPCrecbUmMf5p3F1IZUdfwRg==;5:NJLxRnYXopI8MG6doBRH1Ai4Zg7AaOKmvY5w2sg1fk0PqNxN0aIwJfYP4cuZX+tkkwdDi+J8r5DC6V/INo1kBRn+TPDd/flNjoWR8jPEGyDp3BCg6OTfUITMG3GLxbjtuJlKy9d7ulIjAlly0M3Lju9mGSIPY4EEWlH8OFqq6Qc=;7:0zHmhAnV4Ta3wqb5yp+QnCKcS6ivL8tS1qhsonDuLXuzgQIlEO0JRKn6pZojjN/cJlKjfBUq3qUpDL2BxzwMsesXddPDxHPejLCdce0Mggxr5S6f6Xgh1KexKiZgHR3YI18MqQijcXYOwwg79Gca1yGm4Sza+aF44dlcVCfi1j8SGzUoMdbSML8b2azF5TAlfwh0LoH+2OeSTJmtZHueHH4fqsaIAq5vQvTltl2BXsbDMCLZG+T7tjlh+BkZXpGE
x-ms-office365-filtering-correlation-id: 1a33da7e-b6fd-491b-c536-08d6222d41cd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0631;
x-ms-traffictypediagnostic: CY4PR21MB0631:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB063195F9A98E916E8F05DBAEFB170@CY4PR21MB0631.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(31051911155226)(180628864354917)(28532068793085)(89211679590171)(12401385986421);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(2280196)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0631;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0631;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(189003)(10290500003)(316002)(8936002)(66066001)(4326008)(107886003)(7416002)(6666003)(22452003)(6512007)(25786009)(110136005)(54906003)(305945005)(68736007)(53936002)(7736002)(99286004)(5660300001)(2900100001)(6486002)(186003)(97736004)(26005)(6436002)(217873002)(71190400001)(10090500001)(1076002)(71200400001)(2616005)(11346002)(446003)(476003)(5250100002)(3846002)(486006)(2501003)(14444005)(256004)(86612001)(105586002)(14454004)(86362001)(81156014)(81166006)(106356001)(76176011)(72206003)(2906002)(478600001)(36756003)(102836004)(8676002)(6506007)(6116002)(60540400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0631;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NYtKpmV2jCAPEHoHWQxYufIJK6KN9cXXM0z0Bf5qpe2miQyBFkK92jkR8W9vLsbtIlDhXGxTbwpC8PJIgdwE7uC11ke7CLzhX+IyRMs3cRP5MvAaR6IWKUkFBGBg5fTzYvo4tc/lvp9Yq39idLMFp5WWdwRqWW9Vfs6Txdy6cxEY2+NggVna/v18spi2IP7CU/FVOVuV5ls1ky5eGEBRH9DWwA1gSF11w8+WfSsph90snn1KoVoiEV06ZptmAUW3ocyhfvkpXl8gB41tGn4wFJ97DMV8coPnQ2eMp0B+hzsF+JfhPQxEE8zIyMl8/+ogz8IEKfDI8+6LuxSSeE9qcmpjCA3hHO09o2xhuIBjdW9werB6MmA7PfI0WHfPLtT0irC2MmlIOZCuC+ykXCkfd7RQZqx5w2dzBoP4V4/V11VPTBNcHY+pg6+UcheWGFTdyAozKqmaPtE00q3p0ynsE47/nH5SzbkZuGYE2aNiGLtdHOsLHFfOVIbGsthL3VlFp4fjP80RLnqEsP7PrPPezflvY2H/8MBs5OFCHhfU2ZmuzBws09hdTSA0mbIz1ql2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a33da7e-b6fd-491b-c536-08d6222d41cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:50:10.7829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0631
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
index 0ea78326cc21..21453ca7deff 100644
--- a/drivers/net/ethernet/ti/cpsw-phy-sel.c
+++ b/drivers/net/ethernet/ti/cpsw-phy-sel.c
@@ -145,10 +145,13 @@ void cpsw_phy_sel(struct device *dev, phy_interface_t=
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
