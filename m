Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B3BC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D7420841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="oKN4GG1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D7420841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbeIBRUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:54 -0400
Received: from mail-eopbgr680109.outbound.protection.outlook.com ([40.107.68.109]:63944
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728340AbeIBRUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMHlz7015KLytnd06ZvV1sVyRzy0hQ3RfSzGvObMnVE=;
 b=oKN4GG1vciVHI2CFFXn3WF4fEN6WN/A9MT1/Mw8xwmbCNH835VDHbodsbTkXt6ZR7bf5TiF9XR5qqLj35Xt/wrtUkTBaq6e90S5mHcn5aqvmGDrNGpF5hGI9DvLNU46+oD5fBqiy/y6b3cgeDrzNT/omEiBE+VyJ1P7m3VK7aWo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:59 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:59 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 087/131] MIPS: Octeon: add missing of_node_put()
Thread-Topic: [PATCH AUTOSEL 4.18 087/131] MIPS: Octeon: add missing
 of_node_put()
Thread-Index: AQHUQr2K17UrrI9CQEq2NnuM0wRctA==
Date:   Sun, 2 Sep 2018 13:04:54 +0000
Message-ID: <20180902064601.183036-87-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:GFdbtwYkCw3TGoqbZGxJbTCp+XZU6ep626Ics710DW8EY0598P5O6ky72daKwbTI31j8E97u68hNzT8NSZiwXxqgiEJoeS1HkLytekiDVJOEvDATY83mOaTDRQQVZWlTsmLtU6LfAqymbhClK8DueVax6EOdnUljBp7zDaRi7lhWM2O1HSRM5kXYqAB4MZ9bP9gEBrxRgkT+AUzVdP7/mqAlnIXmHifmDsQXEkKawn+WGc8seANOmjzskitmZYiAWkByhTai1Fg9oqRms2xA5+wNG78gQe5OQlqZD+9deRw3InVsrzVNHzouIG6IqK6P5Ebw8w8+B0kQnluAAXWyDwTkfvsP7584SIX9qbmK+PdD9pQbogZFZVhgCQd5kjm3wcUicJGOa1xUzQD8h6+T0w6ahki4dSJadBgzYKbCA6CGJVRrbB86K9ZlP+e/d3JzlFyd2gxQRaPdt8KpGvZM9A==;5:dVqFXxgYG+Fpj61wipuhNWuGUxh51PKQAhSYaQt22oI16V+roWsJB6bubjvje11VJ0xctpGBUFQGyUF8Qhkdp6+D6k28YE9Fe7lENBpFuxl53mP4xeKkePCC1V07g8Uvf8PMY3K+ljsTnGj/F1bjZ19lJnar7s6+fzvECVV0opk=;7:hK5l0Ywijft1WH9gEpeO2CDBeeVkZd0BcCPEIBXtISJ0iv73GSMR5ykeWXW9Myk4O4OnH0wYsM7clt6m46kRlAV0jLZjLLtArS7Jg6MNJ/oz81zGxIMhXhDyODLrUZ1ipEq5oJxIsHnlup/9Sa9eHnN4ejRcxNqT2RyXIcfDkel+Vg3wfaGQ6cTIQMibqANHnNvazI/JRYb2eyD+JbiYZfmGp7f0o5tVWYZXwjj5uI/wUBrs8xrbaDPtloLkTSls
x-ms-office365-filtering-correlation-id: 46f31186-58c5-4ea9-c092-08d610d4b01a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB074144601761236E7051FDAFFB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(6666003)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(575784001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(6306002)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(966005)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: waIU8byLF+6x0gXM/GDlSdGHFDMVHydC2zu0m7BEwtoHnXEHO85l4/CAcrnY36DYqsDvUoCpwzRYsbuS63wA6WwsOx711d+KECmwoDYLj7vK4I/9l3/e9MC9UW8W73eWhAe+sS+K8JF5ldojmuLU4pWKXqsuI+St9ZJm0AG7xUlgz6MmmNvTfW7Z1pse0czM6ECOGrA+x73g68TRZU4OOvRMXFTw64WBVurbGYknkBhIFcydJ7DbKwadYXwbCA/KZ+yBvXIdp+pG+Jm7nt7gwietvh9U+anhWHVxJ401Up59NfPQAQjggukkdZTRSF3NbAjzp4lJnjPMztPjKFR85do0nkjw/sgHvN3/dgSr5DY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f31186-58c5-4ea9-c092-08d610d4b01a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:54.6259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit b1259519e618d479ede8a0db5474b3aff99f5056 ]

The call to of_find_node_by_name returns a node pointer with refcount
incremented thus it must be explicitly decremented here after the last
usage.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/19558/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/cavium-octeon/octeon-platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-o=
cteon/octeon-platform.c
index 8505db478904..1d92efb82c37 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -322,6 +322,7 @@ static int __init octeon_ehci_device_init(void)
 		return 0;
=20
 	pd =3D of_find_device_by_node(ehci_node);
+	of_node_put(ehci_node);
 	if (!pd)
 		return 0;
=20
@@ -384,6 +385,7 @@ static int __init octeon_ohci_device_init(void)
 		return 0;
=20
 	pd =3D of_find_device_by_node(ohci_node);
+	of_node_put(ohci_node);
 	if (!pd)
 		return 0;
=20
--=20
2.17.1
