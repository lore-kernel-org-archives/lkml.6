Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03060ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC6B214FF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Dfhe2ih0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC6B214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbeIQI3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:04 -0400
Received: from mail-cys01nam02on0116.outbound.protection.outlook.com ([104.47.37.116]:31712
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729986AbeIQI3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2subuoNVYCHQOgOSaBvPFE+iM+0GA7mDGQf9ZZaE2TY=;
 b=Dfhe2ih07OATnCMWVTE+X6wuTM6ZU9XAj/CHaVrRTi8D1/AJRbQFzsN3np6zNFXe1bwh1GHDqNzIIcO5avhMZe6I+cKOUhx70L/C2wbKjUq4kHoVRVYFU6gQCmYZWp3H5GjGT4Qfg7tKZDt1ZnQLZf5vAmi5q70n291JRDtl5Ec=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 134/136] PCI: Whitelist Thunderbolt ports for
 runtime D3
Thread-Topic: [PATCH AUTOSEL 4.18 134/136] PCI: Whitelist Thunderbolt ports
 for runtime D3
Thread-Index: AQHUTjK+PRvVO+eKJkyoeqjAXGgsow==
Date:   Mon, 17 Sep 2018 03:01:36 +0000
Message-ID: <20180917030006.245495-134-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:rRJxGm5YXGQulA1Dt897dYi3wQnrVO2Z//bzR34IHzhv4XYVAlqZiCbGnqarqdmS89ujllOwrztcqS0PYILTtokXA0XD/9r5YnJL3ZfkjGKXfvASKmKjHwN4n+2QMbV3NOxk/gmlXVNAXmvF36GEEVQ90mOhXyRoxyk2TXDYOHX+62lIHzJBS62ZRNVzVK2H+HWudXpKufBCBHrH2XzyFI09Ky1AxrjRsPAAIS+S72xzC+Qq5pH79tcYvbJqAH3N2Lr9Bh1sqr0QGlNQZry5cw1ZxiXqhgpKylj2VJJTJrg/z/XhX/dGOoZd7Gzi36KzkiQLmEN+5QSjN3RrBwtGhdjKHrT7UKPngtbEeu5wFK1SQx2rTldHoHJ6x6kvKSXVkl8EgdczUzlHCLUwe9vEzu3RQ3CSu9U69+x4cEH3APjo5R0SBSpuO+RApruF8tDl/tSFyS6OaTyfsnTD1DGXiQ==;5:Gnv2bx8HtUDSfPyb0O7unhr4+Ke8FhTOxq8meoE/Pvs5KF7jgcQ/Cv5QkaxvB8A2fhgk96OtRWJ0HSorgH/WTyb6mly0/X7pjNcFrnXzVowSBn8itPp3Ml83bn9NAn78hk66SJC0agTWCAeENcwd4aCvgsOX2UxOaJCb5Kd9jY0=;7:ecfNy8REgU51GbbRZIuf3x0j/VpjNQEN3dhpvA9mLFf3pKhFLW/Dr173IvwcGPtLor0XShWEzFYoLQZaYjxlZbzhn2A6oTtorfap1ot9zBOIzXAPVJlw/JNFyzwJuvm32QOR+otWozFV/PaLI/YXxFLyMavNLhurUMj/7bCUziqy0OBjir+slCTACwtCE07rMxPAM6Cd6OKaoAYq8SK6zhB2buIx701/zAbkgw1wcn0TRuW3gkMMhzAnSeRjvkot
x-ms-office365-filtering-correlation-id: 76b73250-f62e-4ecd-0a74-08d61c4a2320
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
x-microsoft-antispam-prvs: <CY4PR21MB011806A22109C70F89DA23CBFB1E0@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(153496737603132)(228905959029699)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(2616005)(186003)(8936002)(10290500003)(66066001)(97736004)(102836004)(36756003)(5250100002)(256004)(3846002)(6116002)(2900100001)(476003)(2501003)(14454004)(54906003)(446003)(217873002)(110136005)(486006)(11346002)(6346003)(8676002)(86362001)(26005)(72206003)(81166006)(81156014)(86612001)(14444005)(478600001)(25786009)(105586002)(2906002)(99286004)(68736007)(6666003)(39060400002)(6486002)(305945005)(7736002)(76176011)(6506007)(6512007)(53936002)(22452003)(1076002)(4326008)(6436002)(316002)(107886003)(10090500001)(106356001)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: FXMhVtu3LzW3QicudetijEXrkAZDXDiZFdgTOmG0eZTsB0flBjeEJA64SJEl1ibzLD3ARpLbp58XOBQILN1QcGBKUBhQ0qIC5QISJR5wVnZbsSU98HD1WKFtDqqvUZTllpjeXRhA5ea5Dcb8hjBGizG5zJGbtAqJFNeyHeWrIZQOuGesGLwj1W3asuLHLSqCHCIB9090cav6YqufyCTocvinlOiW4aRCEe79PQrMM6Nf0xi8qIfaT1cpdvT1KP6t3fBsUINo7j8b3ngn4w1eDdIgcmdSTRc0SYrhhgFnH8MpDzeNz69QINaq5P36iV3FN/oHfu/R6RCRZKt/iufWy+CNXgmPnhMyy946YgQKKJw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b73250-f62e-4ecd-0a74-08d61c4a2320
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:36.0258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit 47a8e237ed443c174f8f73402755c458c56eb611 ]

Thunderbolt controllers can be runtime suspended to D3cold to save ~1.5W.
This requires that runtime D3 is allowed on its PCIe ports, so whitelist
them.

The 2015 BIOS cutoff that we've instituted for runtime D3 on PCIe ports
is unnecessary on Thunderbolt because we know that even the oldest
controller, Light Ridge (2010), is able to suspend its ports to D3 just
fine -- specifically including its hotplug ports.  And the power saving
should be afforded to machines even if their BIOS predates 2015.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Andreas Noever <andreas.noever@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pci/pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0abe2865a3a5..550f8e9464b7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2318,7 +2318,7 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
  * @bridge: Bridge to check
  *
  * This function checks if it is possible to move the bridge to D3.
- * Currently we only allow D3 for recent enough PCIe ports.
+ * Currently we only allow D3 for recent enough PCIe ports and Thunderbolt=
.
  */
 bool pci_bridge_d3_possible(struct pci_dev *bridge)
 {
@@ -2345,6 +2345,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		if (pci_bridge_d3_force)
 			return true;
=20
+		/* Even the oldest 2010 Thunderbolt controller supports D3. */
+		if (bridge->is_thunderbolt)
+			return true;
+
 		/*
 		 * It should be safe to put PCIe ports from 2015 or newer
 		 * to D3.
--=20
2.17.1
