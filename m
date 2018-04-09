Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AIpwx4/rf+3QwLZVW9jD8au815YGOsfQtdMJ5oKldx6Kt3FnVaRbrUxJ5KNJUniv4Zhf4pvXWD89
ARC-Seal: i=1; a=rsa-sha256; t=1523233589; cv=none;
        d=google.com; s=arc-20160816;
        b=bxt6FiWO1DRaz3GpQ6RmQibcm+OUnUAXD7OShpyy78BdzKFetDEJPwQcKieDXXXj0I
         NE05Y6kJ/35DCQjQDRxszYw8pQ3oumnnuVYAzbmUj3HBN0yP8nopdPqzPm+ISqr9BeZb
         L3nOoveoMT/mswsgMZx0k9AwEn3sPCbuNe4aO00ZFe2oYs0Ah+1ZbBz1mK1dydxTOWs0
         iAqauXE8gB3Qkv7NR0jkq3nwvH2EYlZmDqGbJ8WJXIXDgmiwOs+yuPooLWbcrKBqjFlD
         7rzdhDT1Q38FlDFZdzlo5RVFKKeQOf6mexCLuxf46GNoQoMi3iG36/SynaaCGRdxEk1M
         QalQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=a2PnUgaLe1Y7VEfl3uUiA95JLAZHviKRzXz9rXnXO74=;
        b=Hr6vMSsEyzDBDsJv6zLO1xVG7UgZbbfHM7DsD8P5YCbpj9q79tO7/SJ9A2/jLsgSeZ
         dJsLO106dfSbcYdkeyQUplq4Jd4rBT1Lm9t8Fwh5J+UMx5v80ewR0rje/tj2JTeJcTEz
         vkP5l6+wjlZF0XHmcry8fU5L60NroaXIofMWpDcdfrmeZ8S+h0ZDhmGnVA2TVGLWrSFM
         yXg477ss25nArEcpwIC3CNl4wUbacc2kZ1rDkONeLYEOOp3rVqPocgHD8E7BBoX1MPNB
         UkdQbV8cEzeTyuvR9dSlbyaWCnPxUt/bDH5q+rpuOKeJwDFfCNn9UBN/vxdPPI6qgfIf
         kKfw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=VtD0kEy8;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.37.123 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=VtD0kEy8;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.37.123 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Stephen Boyd <sboyd@codeaurora.org>, Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Marc Zyngier <marc.zyngier@arm.com>, Rajendra
 Nayak <rnayak@codeaurora.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 159/161] irqchip/gic-v3: Ignore disabled ITS
 nodes
Thread-Topic: [PATCH AUTOSEL for 4.14 159/161] irqchip/gic-v3: Ignore disabled
 ITS nodes
Thread-Index: AQHTz5jJGZckf5bYa0ejOjRDuWx53Q==
Date: Mon, 9 Apr 2018 00:22:05 +0000
Message-ID: <20180409001936.162706-159-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:/ZrnYL9p5Ig4dhc/3STfNuAL68tfPXQoJSUvF6S5KZiBDDpJDUME69H6PHoevZqdtpS5/kW1sZTf1ZRJ3CjAOCm16EEm1zAlQSPslMUfDqIHKLGWC1+Uz3j1JoazIH5WBX6rFkgTvqRp810C4AJA8fLAp6cu5dfFugFmXKZdEJUJdpySZX5h2xt2mOdpbAw6cpUKjZfsoN8Ax0cggZyuRUt6OR3JvNEGeAwk38Hdzf3ArwDbBpcLfGr2DfUXTczw;20:QYd5OgLAUsaQyy5hCRdiRCAaNAlzcJuaBxXH9f0ZQBf4bAU204BGojlFxxUQdyCOHzRVSzvkQ1+felf57PocGHlCJxQpFSRCNemGDQRoQV/iWGOgQ7PG2jZQLn7akUYeTIlxtScm4Zid6laLbFWXEQ2FAja6BSyWmjXN/iJjSZ0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 741cd9ed-cc73-47a4-0ab9-08d59db0886d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101502F8C70BEB378ACB40AFFBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(185117386973197)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(575784001)(476003)(6666003)(59450400001)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(8656006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(39060400002)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: nzInLIMOSi/Wemv/+kcOlN0LDWMQIHNDhTxjV+lsKQr9RoZ9G/5/dQQdC62d4BHCo9yf80/ALedP7zsrgf/Rg/p1tQ2oQrWhRupzXGBOQbo1w2l+l7gCYsyeMDlUBUtxTLOUt2UyuINgl/zIDn35g1tjSQqFx2RSjs1Lxvo2tWB/7jufV+1xQP3SppnNVoOKxBp5iWRdc3AP+Lzi5Wh1YSfRrkySRaNPCO9qzYUs5PFugnGw9HOvNTlTx15TKCJ6Hovfg8jlPzJ258dJF0KIU+K8NcDJC9icwlkR6kR+plAd29ZZO0vz3YDsElPyhV1VkNP+coZaYj9ELP5YBKmA3qn4CAs/V4Qt+iHU7WMyUrX3yXq+GU543N+x61dknDkavvqNA45V+DN9PYxM3l3o8b8RTPg6gDSV+3tUmkM4ObY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741cd9ed-cc73-47a4-0ab9-08d59db0886d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:22:05.5654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597225896404074716?=
X-GMAIL-MSGID: =?utf-8?q?1597226184562663420?=
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
index 14a8c0a7e095..25a98de5cfb2 100644
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
index 833a90fe33ae..8881a053c173 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -154,6 +154,8 @@ static void __init its_pmsi_of_init(void)
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
index af57f8473a88..13f195c9743e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3083,6 +3083,8 @@ static int __init its_of_probe(struct device_node *no=
de)
=20
 	for (np =3D of_find_matching_node(node, its_device_id); np;
 	     np =3D of_find_matching_node(np, its_device_id)) {
+		if (!of_device_is_available(np))
+			continue;
 		if (!of_property_read_bool(np, "msi-controller")) {
 			pr_warn("%pOF: no msi-controller property, ITS ignored\n",
 				np);
diff --git a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c b/drive=
rs/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
index 123e4af58408..50260cb5056d 100644
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
