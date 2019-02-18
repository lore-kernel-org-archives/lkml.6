Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E0AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 01:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8015220859
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 01:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jqXaCUra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfBRBdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 20:33:52 -0500
Received: from mail-eopbgr780048.outbound.protection.outlook.com ([40.107.78.48]:51336
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726281AbfBRBdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 20:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FFwXAvbT7lP7q0l7eHovbBS16ZOsLnEI0AFUOsyfmA=;
 b=jqXaCUra6fra19c+JaMWQzh0shpQBPypB0MNLJUipxGiX/ZPE0VR9hNUeSsZ6OjG8Xa3W9tG66b3JwbEQVcQUw6gW+SHtb6ZKG/3qCBktTbVsAIpmIIgR7mFpFYt+rkDAVSQH7AJiiUFokiR+tg/oBeRm+C/el3ABlmdWfdAxyQ=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2847.namprd12.prod.outlook.com (52.135.104.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Mon, 18 Feb 2019 01:33:49 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::35e5:6f95:dfe:efe]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::35e5:6f95:dfe:efe%2]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 01:33:49 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>
Subject: [PATCH] ACPI / processor: Set P_LVL{2,3} idle state descriptions
Thread-Topic: [PATCH] ACPI / processor: Set P_LVL{2,3} idle state descriptions
Thread-Index: AQHUxyn/zss0L+lwcUmS0k6J0SW8vg==
Date:   Mon, 18 Feb 2019 01:33:49 +0000
Message-ID: <20190218013335.233265-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR1501CA0021.namprd15.prod.outlook.com
 (2603:10b6:805::34) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51339a96-b208-4810-93ea-08d6954121d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2847;
x-ms-traffictypediagnostic: SN6PR12MB2847:
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2847;20:QsXgcRUmkK04NR1iF+Qy4AmXbJjy7L8G+HcIlRWYTIH+sWiQixV8zEto+YIoC+oVPCBF4EgV8CzVRLe05H+o5Xh3U03OAaqSE/kQAIZQkdnku6lDrL425foaQZVroRIbQpP8Ex7AHlQ6slwnsVfLquovzm0126cSqZJ8Sl1eoW5IjuRKjCRaHzWiJJCJwniu9AOaPEaZZjlhYPXsK5onkRK/WwpLZWa2i/D/DYnBmYZ9YnzCUT0Okp5wYOvqqCVF
x-microsoft-antispam-prvs: <SN6PR12MB284759C4088C3949ADDE2931F8630@SN6PR12MB2847.namprd12.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(346002)(136003)(376002)(189003)(199004)(5660300002)(102836004)(256004)(1076003)(71190400001)(14444005)(71200400001)(14454004)(3846002)(6116002)(106356001)(6506007)(2351001)(54906003)(6512007)(53936002)(86362001)(316002)(36756003)(386003)(66066001)(68736007)(105586002)(99286004)(5640700003)(6486002)(6436002)(8936002)(81166006)(81156014)(7736002)(50226002)(305945005)(6916009)(52116002)(97736004)(486006)(476003)(2616005)(26005)(4326008)(8676002)(2906002)(186003)(478600001)(2501003)(72206003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2847;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Rh/UetXiXnxaRZd+8KG+aKHK0VJWdjMOEiV+x9Z+SAl3ePd23DJhFc3vV+BFviLeP3ifFTau6hMuxQJXKm8jdBg4l2o2ui6qbSHFhxfMCwyYTvWPYBQIJ0I6IfkAFQUv8EDlev7TC8hPDonL+OpfsBIAqpD8SH8KzGi4+KEcv4RbHz0eJ8UakWq3VpLFUh+4WPaEXfJnVI8V1+CR1PJeAuytUsIWQuRpusS7vUnlgUZoA+t2fvgEgNQVrit2fCJU6j92mycBPHfGXVG4bpYeGqfZfiLamDWgE26J3mN9ySNkjY2qzImw6SU5yrGl+EKi9nu8u6KI935Md3VYo3wT3kgDJBGkxl/pNExHGz+EijykSOCJoOpa0zFrQ4sBX6bqeaAlHXBL29ZCgqCeuxTnChOhKfkjmY8OufKIhIMZyAo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51339a96-b208-4810-93ea-08d6954121d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 01:33:49.0222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2847
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The ACPI idle driver will fallback to using the legacy P_LVL* SystemIO
method of entering C-states if the _CST method is disabled and P_BLK is
defined. However, in this case the C2 and C3 states won't have a
description set, so the user will see "<null>" when reading the
description from sysfs.

Give each of these states a description.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/acpi/processor_idle.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index b2131c4ea124..98d4ec5bf450 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -282,6 +282,13 @@ static int acpi_processor_get_power_info_fadt(struct a=
cpi_processor *pr)
 			  pr->power.states[ACPI_STATE_C2].address,
 			  pr->power.states[ACPI_STATE_C3].address));
=20
+	snprintf(pr->power.states[ACPI_STATE_C2].desc,
+			 ACPI_CX_DESC_LEN, "ACPI P_LVL2 IOPORT 0x%x",
+			 pr->power.states[ACPI_STATE_C2].address);
+	snprintf(pr->power.states[ACPI_STATE_C3].desc,
+			 ACPI_CX_DESC_LEN, "ACPI P_LVL3 IOPORT 0x%x",
+			 pr->power.states[ACPI_STATE_C3].address);
+
 	return 0;
 }
=20
--=20
2.17.1

