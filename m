Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB671ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE52214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WEmGWeHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE52214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbeIQIaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:30:52 -0400
Received: from mail-eopbgr690116.outbound.protection.outlook.com ([40.107.69.116]:54124
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730561AbeIQIac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6a63vkXaG9UKmNlVfgX4Pu7pggwq6Wp96R91Vc7/1U=;
 b=WEmGWeHYaTLLidCMivOYy6OkAemxmbDQKkYsgcmmaZZlyArWuNczDjNX1tWdd2RfP2kxoJA3mf9h3fv8uBLDkYy/jziceENppqAUSMB1NYGurOceQ0JHV3967Q2YfkNHAu2Z2OERQ00TIxYqVIjjxEFsZL61JSq4Yy2gseOuJxg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0133.namprd21.prod.outlook.com (10.173.189.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:05:05 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 87/87] PCI: Whitelist Thunderbolt ports for
 runtime D3
Thread-Topic: [PATCH AUTOSEL 4.14 87/87] PCI: Whitelist Thunderbolt ports for
 runtime D3
Thread-Index: AQHUTjL8aFGgHYst30uDQLUO80aa4A==
Date:   Mon, 17 Sep 2018 03:03:19 +0000
Message-ID: <20180917030220.245686-87-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0133;6:ILCa6kVsePnHAgOTEVssLedUktrTpMXC19Er2M8qfnOJtkDZlXT87gQGTVEbq+eb9k0RM12Pl8uNoemmOBSPUdQ1iz2kLlxOCkk8T+ujJaJr8OHbrn86alkvfs26a+UVy2555EYnFvAyrhj3XXiHXI2UZs3h72UOAmcdF0anlZeyQubuQJgpDyYHULPt5UIuW8lRzZQqGvI16zDiRxeHUGT7hHt85rB3FEoOgeHjGzunJh2GtYxQJTrYWdrb0JueaGmF6ayftJ9zT3EGA/vlsb5UwhQW3UnqBeGt3Dh1SPTYbZOUYfi6exiaav/iPfOc0kD8lGwm4C6Vgry/f6isRUdpAxIqhPZynxOkI9v551AzR/Y3zLfe5gq8FouAcAfIcH4eQ1oQVuO/HmUsu5DdZ8mTLLPwzCko3yj52aqNBmUKpMjXdCdcxPP5ATCm6ayUeIgxO2NfozbQc9ClKJ7a+g==;5:Pp9GR9JBFwFOAOeNO1hQNKSwX5kLTOt9u1sZszn8XYxh83fuB+yKXLPYeluYxWLaWczqLb1bagDaVTcjvrtyOJ97ZUcb5rGoHiXwbugSh/49rQHMqx6FuRpkJKRuxcKwVohxmiYh42W4rzkwr5RW0VbKM1SpIVmhv/oRrONwlY4=;7:XmldX3apMTgVByrqVhGo5qZVaNoRtv+Q+QolMVuSLdhBjyc8YZ3X0mhLfXN4qE3pV7bIL2VTahIb/MHCBqFvgF3OB6rrKBakH7X4wVCU+U2qWpOrSAaf2l9kAfoe5jj4NIde9j//kntduTT89Ou+/mdPaM/cJ1obDX9QZhzUPg/z8Nc0uxbcQi4AOgVhxGWKhC9nlORpp79soh9cEVuz6s3aZQ2/9ftoZoubT13q0KMpatyh4urD60WOOfaFbTB5
x-ms-office365-filtering-correlation-id: b9fdffcd-a380-4b51-05d7-08d61c4a5e0f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0133;
x-ms-traffictypediagnostic: CY4PR21MB0133:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0133EC7E9D78557C5B005DBFFB1E0@CY4PR21MB0133.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(153496737603132)(228905959029699)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0133;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0133;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(102836004)(53936002)(8676002)(486006)(476003)(3846002)(6116002)(76176011)(10290500003)(97736004)(217873002)(256004)(5660300001)(107886003)(6506007)(478600001)(39060400002)(110136005)(2501003)(10090500001)(14444005)(305945005)(7736002)(446003)(11346002)(36756003)(2906002)(1076002)(22452003)(5250100002)(2616005)(26005)(316002)(106356001)(25786009)(68736007)(86362001)(575784001)(14454004)(72206003)(105586002)(99286004)(6486002)(6436002)(6512007)(86612001)(6666003)(81166006)(81156014)(186003)(2900100001)(54906003)(8936002)(4326008)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0133;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jCoQOYvEhbGF1e8bydHWcfTCFQ4NmIljUoCXYx/JYIZSufJG61j1tyHZzm0Frc9ACSV18BgZFKxunnGZu1HogIyWn+mWRpdg+3wsUWgC2NR8vhj+1ghld2LcwEPUFrDC+9eiCxdvdeQ3uwdbSMTL3k9LnXozrj4zsUnNBP41fmxLT0rfMX9DNlsEdR0Xq6EFncFd/k56npmyKwg+5OKV98dpptluJ9ouBWd1VOd+3Nq8xgqrYrAs5eGKFXJ377+P/2mP4J7CkijQjHcUow/oHjOVE6NQ7xm1tcVuo72nHGhya583kgBUKSo+ceDJJpOhhL1fbpHXY0wtcFGgDI2zr7R7OqVKAR6BG9ENxLs3VnY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fdffcd-a380-4b51-05d7-08d61c4a5e0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:20.0089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0133
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
index 22924629e64a..0c0d0ef82c88 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2267,7 +2267,7 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
  * @bridge: Bridge to check
  *
  * This function checks if it is possible to move the bridge to D3.
- * Currently we only allow D3 for recent enough PCIe ports.
+ * Currently we only allow D3 for recent enough PCIe ports and Thunderbolt=
.
  */
 bool pci_bridge_d3_possible(struct pci_dev *bridge)
 {
@@ -2296,6 +2296,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
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
