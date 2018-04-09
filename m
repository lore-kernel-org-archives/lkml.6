Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AIpwx4+YIco9WFQsK7PTebZ2QhS8lE++DS8PSF6UXO9FjnFVnQW4KlNdTgZHDxgS+meNsHkgMVsO
ARC-Seal: i=1; a=rsa-sha256; t=1523233314; cv=none;
        d=google.com; s=arc-20160816;
        b=ASjod++YSUnjpS5YtZ9pBGXWNnpA/hPtpff34U66W0oQ9qBqQqXhzb35/0hdCoStBg
         W/r8BgTiVv0lBDJXhtgtnmGWsaQWpZ98ICUC10BUpU1CQ6AyImIpDQ/pLL0oQzqtbYMR
         aDL9zldzi0OOCb2VH10gQ0ISEAn0q5J2YKeYaFzxpTBinMqErRvxKjllHuGgmCe7o55k
         oYLaWj7htcPfq3YP9qz1iWznnwkqcL8m/nYtqOYL9WpAZw6dWKsl4Ul6RhQMPNd9F0gI
         6/PCRGCa1BH9Vr6MS5yGrfSE5LztZabzyG9sQUzVLpHksYF+RwBdutUvuI+Ep+tE51Dm
         9fTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=BGD832bJ57I8HrVlBVAlZOK068IdWtEylaf0NbMlPA0=;
        b=QTWMjXggT3xzk8ByCazxspo8frCw8kayQ16uyJurWLuiRefmsFdSskoxaO2RfS55kF
         PX3NbmLNMWJ7Ni7CGQwS+ACt73qNuMAvx26eXJzWh3kN+EXoaYIGXlt7iAPBloE9tws1
         c284RpicOJrhc1HHM8rqx9H4lTJ6ytcn5Xj3BNejHwahYXqFEykfq9Jn7cCbw5gF+5Nw
         Hi1iB5n1jnNQ4P6CQ2VgKEQv0B5QxFzkIamgKVK8373iwtmLShsfIQnwCUAGIEqQFuQw
         TJAuJE0NUlujxblgjJRIe7Om7ZCSESekt1XwxWzMUO0L95rvLyk0NzT/9lJpUcC4EVxe
         PMhg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=Ha8221mJ;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.38.123 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=Ha8221mJ;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.38.123 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Stephen Boyd <sboyd@codeaurora.org>, Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Marc Zyngier <marc.zyngier@arm.com>, Rajendra
 Nayak <rnayak@codeaurora.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 187/189] irqchip/gic-v3: Ignore disabled ITS
 nodes
Thread-Topic: [PATCH AUTOSEL for 4.15 187/189] irqchip/gic-v3: Ignore disabled
 ITS nodes
Thread-Index: AQHTz5hlYqkrV78i/UiqQ65UqhiXJQ==
Date: Mon, 9 Apr 2018 00:19:16 +0000
Message-ID: <20180409001637.162453-187-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:H1eUcHZJVXXy7ME+ThuZogoiwwps0QJaS7gyHFu3012DRsuXokkdF9rlkxJ5wi6livZErU6iivplM4jM67cA6SRXwUJLe2Lmk22IlbAVBVZIPOLBsaa6JKZPh4GLds6l2+57A+Et4KZ4d3Tl9ih2xtxq1EVLPp4uql3FTn5TwGA8qmyVQimP3zIqxPV9LAPC9pitoACnBGx6YBMs1dh+3Jm9zsUmcgCawD5bUZ6tkdTzqV+3rQe16DROA3a61e87;20:/C7Frt2UkP16qxvPB5b0k3GvzbiNMixvgUZaERvVz5eEMopEaualk+9a3GgXHkIXA+6pu4h8Mflc7v8V01oGpYYmp4qv77zgBdl71FfeigKY5IFPSXXfsMMkxGHnYJAvWFN+MWDpf6fytWyanZ0G1FipNXYlq2E5MkZ8QoWoBGs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 31294eb6-a7e8-45b0-84e8-08d59dafe4cf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09367A0551BAF6937A2C3191FBBF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(185117386973197)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(396003)(376002)(366004)(199004)(189003)(3660700001)(36756003)(2501003)(76176011)(10290500003)(2616005)(5250100002)(3280700002)(478600001)(1076002)(72206003)(6436002)(53936002)(486006)(476003)(4326008)(6486002)(107886003)(5660300001)(54906003)(110136005)(102836004)(2906002)(6116002)(575784001)(3846002)(86612001)(81156014)(81166006)(6666003)(8936002)(305945005)(8676002)(2900100001)(6506007)(68736007)(14454004)(8656006)(106356001)(105586002)(25786009)(6512007)(86362001)(99286004)(446003)(59450400001)(10090500001)(11346002)(39060400002)(316002)(26005)(7736002)(66066001)(186003)(22452003)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: a108KfSOjgkeCIbF2uUT4+blefQGeXAyz73eXk2wZ+yCA7mbY0dHG0tWP3DATGYwRzP6nbGnt+E7g/pez1QPsifZdsEriBpu/F6w5rtn4EOOh5CPXiv+6sNxaSHqW4FHJz2BoYSaTF0efilxIMUbXvjpB3rORndmXbrH4ys7fQLelkwe8GJfJ8M5CVwdRjEOBi4W5BLfwhHXN/pOgyGjW1U/GbaQ6dVw1osiEZEG5ces20I1FwAPCJAIJnW0g2Ynf3cfW9c4Zsa4pwdwd/1B2fXcwVwIqlQUERrIVHBe8YqGe3j+vpkvwZWNcSkLUb61ANvqH07Z9Sq848wjWUromMcUXTkuVigpp29gO9GWC096Xqv7IGKZCvaK8m6rqLDeVsVTjBcqaP2XeW0G81A/F7MQJPpdolKqqoQeyqzrlwY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31294eb6-a7e8-45b0-84e8-08d59dafe4cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:16.7673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597225896404074716?=
X-GMAIL-MSGID: =?utf-8?q?1597225896404074716?=
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
index 12c325066deb..d49bd1120bd9 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3313,6 +3313,8 @@ static int __init its_of_probe(struct device_node *no=
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
