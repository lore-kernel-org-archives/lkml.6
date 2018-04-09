Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AIpwx4+UKl6IDQ5sQPucO8HvS7bvect8BrIV9/dj/8jkv7mIFQUKFclkwmZCD6ULm+VUeDHgfqlG
ARC-Seal: i=1; a=rsa-sha256; t=1523234090; cv=none;
        d=google.com; s=arc-20160816;
        b=Yx7T1QE5eC1bKp8CIGKggf9nH6hdvwyvZHmcCLUfYri4i8fl4P68WYFse12xHt+U+x
         lcYAjFFvdh6boM3wpFVeYFtt8wr/mVsdgxwA83dq0D/UPvubQ0YRnfdN06P6EBLqP2Cd
         8XD5IFMPJsNppKL0Y+SlpCOTwbLruuCllp3h9ksYCsQ/+NfA9F68GrVn/dH2aT5KCk2r
         4DBzmq2mB0plVc9raQZ8vxNtLI4ybo/dEGX6Dqsj4EDWpQ8SmlIvyb8Dbg6iz/uscXYx
         HMNkNEBqQo9bD4ab9ODnHXBBL/CFuMEpw2bqEMskS3jCphqrfuh1a2sJDZHXurPrIV5z
         N2oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=r4MqWBszkIEpLx3my4YX6vqIKq3ETBVvtBUfe09/+oM=;
        b=riU3UvAMBuztjg+bPtlwykgzS0z+OOxp5DKPN+YGEtBqZzQQ7pS7Wr+5MvrT01GoiP
         Wt6tVsXl/u14y9n4QRhmn5NZDfOgpQOUoKxOYF8EXGdo8dmvHckGyd3EQQveqtLniWTF
         pVWQYy/j4rZajLicMxtoW/GHPVHskOlw97qWZJWSbI3ajVRdTuWpvbLzMKQg+xyJ60wZ
         lqWfvwaukwntZdRBbQ+VEmrSjQQil+YVBRG6ZMjSvHlgvi2Qx4TxrWi3qFZ9JlmJhqMe
         ONuZIpEBanP3FPV8zyOjqu7nsbOkLfp+s+bwEtD/XDDsDqNl1p2pU5NwSvZ0fUpVXLI+
         kJ1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=mMMDlhkQ;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.34.101 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=mMMDlhkQ;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.34.101 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Stephen Boyd <sboyd@codeaurora.org>, Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Marc Zyngier <marc.zyngier@arm.com>, Rajendra
 Nayak <rnayak@codeaurora.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 291/293] irqchip/gic-v3: Ignore disabled ITS
 nodes
Thread-Topic: [PATCH AUTOSEL for 4.9 291/293] irqchip/gic-v3: Ignore disabled
 ITS nodes
Thread-Index: AQHTz5lw17auk3dqCES/JDxsj9zu9g==
Date: Mon, 9 Apr 2018 00:26:44 +0000
Message-ID: <20180409002239.163177-291-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:q3LBrwKaIE4/83uHBcJSb7oLqYzyoG4YkNnE2eF9pB8YkXd8WFn9jRrWHvAJPx/+MYUlyeAtYB6EPbEZUpbmXCqcGfQAcl+MMjhWyrVMTfYGMKPlyh1IFdTieGqcKgQOUoiHBn1bQi53QbfaJmHyPPRTgHbu07/sireXpU35EIRdoi9NTC5QvsQQq94/PTjOiyi8PL7LWK3AELFGL4/ILIJ1xbCrUsrUxCGJ9PjpLnqJ/bUJuZZw+ZlnDwa/zLSh;20:j7a0bgArmlskx9t2YT6u2K3lGWL/78Bk2W+M9D6lxEuX4zH68H06xLfVuQyxpmRfgE+XodeXPq+SzuqGDXNB5Vk8H86XnYSgSV6sUjZx1j6FtIy79g00GnZs4zOx1wuaMt2qMZJiUdsSQsO35N+KlGqJX+ck8B9H4m9nbwbwnBM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 035c6c3e-f910-4637-a642-08d59db1b2ee
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08062695925C2CE957CDDC67FBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(185117386973197)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(59450400001)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(1076002)(186003)(26005)(7736002)(8656006)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(39060400002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(86362001)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: y38htmsNI+gcV+3CRT7ymm47E4yoEJPL5Mi/Nn3fTG5HEWBta+VGNzQqYmOyyyOcx9gIv2XJZNrM1A5RXJB49/7NB0LWccUK4LAVyz49lCZksiC3jxn55cSH9wKLVnbOJBO+f4EWnz30fRX40qNZRTvrFlAqAZz4HdUl/ZfBNI/2U6jNHVrGmYgduDmch1WyEIwcIe0Zz7zD8+3LaXIdjFQ36QNmDjF/0SUVq4cd9grAK8G0xU4S3XYbN291CUTSRzEYAGcvTzyR8fMvshj9Lx6biLVFtsRWH1UDb2/xmg8WF+fvvdEhA5J/SHq1rRBAhnhjBWKLAHZtaS6W5Iiym0YhUAayUTAeX5aoaza2kRo/bdLuZAuK3PsYvsBuJ8zGHnO1/qs6uNBAx7Y7x0qNdJ8xgARDWlanal1XdS+d2oE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035c6c3e-f910-4637-a642-08d59db1b2ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:44.1291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597225896404074716?=
X-GMAIL-MSGID: =?utf-8?q?1597226710021124574?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Stephen Boyd <sboyd@codeaurora.org>

[ Upstream commit 95a2562590c2f64a0398183f978d5cf3db6d0284 ]

On some platforms there's an ITS available but it's not enabled
because reading or writing the registers is denied by the
firmware. In fact, reading or writing them will cause the system
to reset. We could remove the node from DT in such a case, but
it's better to skip nodes that are marked as "disabled" in DT so
that we can describe the hardware that exists and use the status
property to indicate how the firmware has configured things.

Cc: Stuart Yoder <stuyoder@gmail.com>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c               | 2 ++
 drivers/irqchip/irq-gic-v3-its-platform-msi.c          | 2 ++
 drivers/irqchip/irq-gic-v3-its.c                       | 2 ++
 drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq=
-gic-v3-its-pci-msi.c
index 77931214d954..6b5f50e1fc72 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -132,6 +132,8 @@ static int __init its_pci_of_msi_init(void)
=20
 	for (np =3D of_find_matching_node(NULL, its_device_id); np;
 	     np =3D of_find_matching_node(np, its_device_id)) {
+		if (!of_device_is_available(np))
+			continue;
 		if (!of_property_read_bool(np, "msi-controller"))
 			continue;
=20
diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchi=
p/irq-gic-v3-its-platform-msi.c
index 470b4aa7d62c..e4768fcdc672 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -80,6 +80,8 @@ static int __init its_pmsi_init(void)
=20
 	for (np =3D of_find_matching_node(NULL, its_device_id); np;
 	     np =3D of_find_matching_node(np, its_device_id)) {
+		if (!of_device_is_available(np))
+			continue;
 		if (!of_property_read_bool(np, "msi-controller"))
 			continue;
=20
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-=
its.c
index ac15e5d5d9b2..558c7589c329 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1807,6 +1807,8 @@ static int __init its_of_probe(struct device_node *no=
de)
=20
 	for (np =3D of_find_matching_node(node, its_device_id); np;
 	     np =3D of_find_matching_node(np, its_device_id)) {
+		if (!of_device_is_available(np))
+			continue;
 		if (!of_property_read_bool(np, "msi-controller")) {
 			pr_warn("%s: no msi-controller property, ITS ignored\n",
 				np->full_name);
diff --git a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c b/drive=
rs/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
index eaeb3c51e14b..cb95c3e940f1 100644
--- a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
@@ -75,6 +75,8 @@ int __init its_fsl_mc_msi_init(void)
=20
 	for (np =3D of_find_matching_node(NULL, its_device_id); np;
 	     np =3D of_find_matching_node(np, its_device_id)) {
+		if (!of_device_is_available(np))
+			continue;
 		if (!of_property_read_bool(np, "msi-controller"))
 			continue;
=20
--=20
2.15.1
