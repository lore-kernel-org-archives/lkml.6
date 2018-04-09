Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233445-2-14699494519219026686
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233444; b=RcMo7ANFDEivDWiukUDQ9h5uBBHveYttmCXQJhDqoB2xLD+DWy
    OMqsRueJ612ExQddrnp2f9cOvNxBNjUmyHdv1CbCIid3rWEjjJqLbEhYcrDzajcb
    0Bskd/4k6JCg3kDZwoS7D5d7saT5X5AN+3NW4F7Ky1a0x8couoR+9AvyzF6TpqwP
    +i8iyNbnK8ZU9a9c8h1+mznTZZ1of2r64nxHAzJbUH+3uQvAUyQs4m2G4Z99HLuW
    sVDZ+Gqm9n/Q/xy0GD9Ni13wIlNUwtO78Es4iTo7FjWo79z3CCSPD74o92kGwk4G
    9HCQwQ7+RgyeY/NXcJ8wyunhS2X2JldSR/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233444; bh=2aD7wUHULV
    7a08Pf56MqZe6WT/2KnqrszBHdFS+cE2I=; b=p/6LTdiLcIdpfH83YpTJ/VkNen
    7beR3dk/gTHvwuihpeLMRVOjYnCsc4YxYrkHDqTNNccx2FCAjMPU6Yo2Xo73oGJ4
    B31R1II562r1AWrk4dohKcKsh6bvNY6oJxcPhrAm+evbZ0RPg9XiNvZ6NEIKVaKV
    HtgVgqaCOzRzPuQs/o1E3/CSZ7PDsbyQj4kMNRBWLmna2vUQuGubMZ4Mr5QX8f+8
    xaTSMtnrqI/vtTflLmFKHDDSg0mNQu7A8ZnH8FizA508F/YcVAwkKeTQ40dK6YhF
    nqkkLdAVGFjsyWS3IED+7uOV3CGHWfC8+7RFdQuzs9fp2LWFORTB6Ga7etFw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i2CCP/8P x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i2CCP/8P x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHBq7U1ShYhXWBuosZriAJFinXKP26YqM/uYZgAYYjqp7MXk4Py3zmxCLqwfUNDc51bQX16UAlG52Th1Qe1ZcPnoQEG8V+5Ps+E0zPfwIAorNLAJjL+w
    H/ZDVI3iHkcc9LX5VpIRoeV931mhQsTvYx7r/4JxN8fJwjasY5Rytsym9fw7ogYMUyHZRSnRZD1htn9jkROVXB+ESEbfVo03waon/PTn2ZJq/DvjWM6aLSqj
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=3W9sBVhNAAAA:8 a=8AyvxOLsAAAA:8 a=ag1SF4gXAAAA:8
    a=yMhMjlubAAAA:8 a=uStphks18ANntG_bXj0A:9 a=Hb__TGJ0MNUUeBrz:21
    a=LRFeeLHUKPPXMfjM:21 a=wPNLvfGTeEIA:10 a=38sOm0jhF1M2KuwyeTFR:22
    a=2zfJb8d2Nkc_ZQPSw0Wi:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754999AbeDIAYA (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:24:00 -0400
Received: from mail-by2nam03on0115.outbound.protection.outlook.com ([104.47.42.115]:29467
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754974AbeDIAX4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Aaron Sierra <asierra@xes-inc.com>,
        Matt Schulte <matts@commtech-fastcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 076/161] tty: serial: exar: Relocate sleep
 wake-up handling
Thread-Topic: [PATCH AUTOSEL for 4.14 076/161] tty: serial: exar: Relocate
 sleep wake-up handling
Thread-Index: AQHTz5iceyNTfI2vjEG8mGhco3ZeKg==
Date: Mon, 9 Apr 2018 00:20:48 +0000
Message-ID: <20180409001936.162706-76-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;7:OnMIdna4DesfoI+F6KB02pZ96IG/JvuPC8Ix+KfF1YCe68EV4Vnj+cMEZrYLe8fzaNTc/ea4yiPzDBuy3OKM2WbZP06jUzhSCNwIdV797RjtgDhNo+kRHg8AVTjUljls04rOAXoCiEK1Th811oE8Deo3UImyR72LtbCGsdu65nuT3QM3+XJLPpGRQvnFxkkAik9OKh6doj+WOgrdMfKE/7F94tCEMJuB2GMKylULLZhvAdaQdDUOR3bcyy6cMnGQ;20:jTJa6HplACIlu8p75bRblPSLRkouEzPl3pesWTHr5KhYwsCs3g7UWrGJMwUOXA1UXZztXJDUDyz7KnYmfZIt4HN8NOC+drDyYio73sLHbaCVishQ+h+P6LqQzPSQe7t9Jue0EiemjPyRuzeTaDf/N82MpUFKWsxNH0jkTJ5A/XM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a14abb37-dfcb-4367-03c2-08d59db02c24
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1080C14A9958271B39EE5D8AFBBF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39380400002)(366004)(39860400002)(199004)(189003)(2501003)(5250100002)(8936002)(10090500001)(5660300001)(3660700001)(446003)(107886003)(14454004)(36756003)(6436002)(476003)(3280700002)(2616005)(11346002)(4326008)(6666003)(53936002)(6512007)(22452003)(305945005)(10290500003)(316002)(102836004)(2906002)(6116002)(66066001)(6506007)(3846002)(7736002)(486006)(54906003)(110136005)(186003)(72206003)(26005)(1076002)(105586002)(2900100001)(6486002)(97736004)(478600001)(81156014)(81166006)(86612001)(8676002)(106356001)(99286004)(86362001)(575784001)(76176011)(59450400001)(68736007)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 2IjCWBMBiuhFTq0y5ORt41VORx+TYTWlYQJaYuVzKXWAVGRtq6QYf0j80qUSY8TB3VLVSEbUrVZtL++POy9oqEAVLYJ5sqYk4ANtGB/gfhCNMSnPUqclE5PHPJVFDVeiWHH/cxT/LGR/DF4PvzvUudQ/Albtua46CbwVCH3eIL2l/mIeqRJaEZM4ehXOTSG0bNvcatbXpEpmWcGuyNpUJ50beUwfWDtnBgvWEILvuPXJ/lJlelzGVhged0eofJEKzrhLkPpNOR3hvGO8miLQ5+DTgEmWz95JfYy0kG+RYCI+TRWOlPJkshVtYm5MFgMAtVEwWyo3QNzs6RgEMQSgMUksNQhU3LHLbgzhR0npTHklvwbSUylmDpKgIJazLbtql3KkSxlzBPKnSHyykN9JE6hmP0ll4HM0uaULb+V4hjo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a14abb37-dfcb-4367-03c2-08d59db02c24
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:48.6753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Aaron Sierra <asierra@xes-inc.com>

[ Upstream commit c7e1b4059075c9e8eed101d7cc5da43e95eb5e18 ]

Exar sleep wake-up handling has been done on a per-channel basis by
virtue of INT0 being accessible from each channel's address space. I
believe this was initially done out of necessity, but now that Exar
devices have their own driver, we can do things more efficiently by
registering a dedicated INT0 handler at the PCI device level.

I see this change providing the following benefits:

    1. If more than one port is active, eliminates the redundant bus
       cycles for reading INT0 on every interrupt.
    2. This note associated with hooking in the per-channel handler in
       8250_port.c is resolved:
        /* Fixme: probably not the best place for this */

Cc: Matt Schulte <matts@commtech-fastcom.com>
Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/serial/8250/8250_exar.c | 34 ++++++++++++++++++++++++++++++---=
-
 drivers/tty/serial/8250/8250_port.c | 26 --------------------------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/=
8250_exar.c
index c55624703fdf..e0aa5f03004c 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -37,6 +37,7 @@
 #define PCI_DEVICE_ID_EXAR_XR17V4358		0x4358
 #define PCI_DEVICE_ID_EXAR_XR17V8358		0x8358
=20
+#define UART_EXAR_INT0		0x80
 #define UART_EXAR_8XMODE	0x88	/* 8X sampling rate select */
=20
 #define UART_EXAR_FCTR		0x08	/* Feature Control Register */
@@ -124,6 +125,7 @@ struct exar8250_board {
 struct exar8250 {
 	unsigned int		nr;
 	struct exar8250_board	*board;
+	void __iomem		*virt;
 	int			line[0];
 };
=20
@@ -134,12 +136,9 @@ static int default_setup(struct exar8250 *priv, struct=
 pci_dev *pcidev,
 	const struct exar8250_board *board =3D priv->board;
 	unsigned int bar =3D 0;
=20
-	if (!pcim_iomap_table(pcidev)[bar] && !pcim_iomap(pcidev, bar, 0))
-		return -ENOMEM;
-
 	port->port.iotype =3D UPIO_MEM;
 	port->port.mapbase =3D pci_resource_start(pcidev, bar) + offset;
-	port->port.membase =3D pcim_iomap_table(pcidev)[bar] + offset;
+	port->port.membase =3D priv->virt + offset;
 	port->port.regshift =3D board->reg_shift;
=20
 	return 0;
@@ -423,6 +422,25 @@ static void pci_xr17v35x_exit(struct pci_dev *pcidev)
 	port->port.private_data =3D NULL;
 }
=20
+/*
+ * These Exar UARTs have an extra interrupt indicator that could fire for =
a
+ * few interrupts that are not presented/cleared through IIR.  One of whic=
h is
+ * a wakeup interrupt when coming out of sleep.  These interrupts are only
+ * cleared by reading global INT0 or INT1 registers as interrupts are
+ * associated with channel 0. The INT[3:0] registers _are_ accessible from=
 each
+ * channel's address space, but for the sake of bus efficiency we register=
 a
+ * dedicated handler at the PCI device level to handle them.
+ */
+static irqreturn_t exar_misc_handler(int irq, void *data)
+{
+	struct exar8250 *priv =3D data;
+
+	/* Clear all PCI interrupts by reading INT0. No effect on IIR */
+	ioread8(priv->virt + UART_EXAR_INT0);
+
+	return IRQ_HANDLED;
+}
+
 static int
 exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 {
@@ -451,6 +469,9 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci=
_device_id *ent)
 		return -ENOMEM;
=20
 	priv->board =3D board;
+	priv->virt =3D pcim_iomap(pcidev, bar, 0);
+	if (!priv->virt)
+		return -ENOMEM;
=20
 	pci_set_master(pcidev);
=20
@@ -464,6 +485,11 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pc=
i_device_id *ent)
 	uart.port.irq =3D pci_irq_vector(pcidev, 0);
 	uart.port.dev =3D &pcidev->dev;
=20
+	rc =3D devm_request_irq(&pcidev->dev, uart.port.irq, exar_misc_handler,
+			 IRQF_SHARED, "exar_uart", priv);
+	if (rc)
+		return rc;
+
 	for (i =3D 0; i < nr_ports && i < maxnr; i++) {
 		rc =3D board->setup(priv, pcidev, &uart, i);
 		if (rc) {
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/=
8250_port.c
index 8dcfd4978a03..e9d4420869dd 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -445,7 +445,6 @@ static void io_serial_out(struct uart_port *p, int offs=
et, int value)
 }
=20
 static int serial8250_default_handle_irq(struct uart_port *port);
-static int exar_handle_irq(struct uart_port *port);
=20
 static void set_io_from_upio(struct uart_port *p)
 {
@@ -1890,26 +1889,6 @@ static int serial8250_default_handle_irq(struct uart=
_port *port)
 	return ret;
 }
=20
-/*
- * These Exar UARTs have an extra interrupt indicator that could
- * fire for a few unimplemented interrupts.  One of which is a
- * wakeup event when coming out of sleep.  Put this here just
- * to be on the safe side that these interrupts don't go unhandled.
- */
-static int exar_handle_irq(struct uart_port *port)
-{
-	unsigned int iir =3D serial_port_in(port, UART_IIR);
-	int ret =3D 0;
-
-	if (((port->type =3D=3D PORT_XR17V35X) || (port->type =3D=3D PORT_XR17D15=
X)) &&
-	    serial_port_in(port, UART_EXAR_INT0) !=3D 0)
-		ret =3D 1;
-
-	ret |=3D serial8250_handle_irq(port, iir);
-
-	return ret;
-}
-
 /*
  * Newer 16550 compatible parts such as the SC16C650 & Altera 16550 Soft I=
P
  * have a programmable TX threshold that triggers the THRE interrupt in
@@ -3074,11 +3053,6 @@ static void serial8250_config_port(struct uart_port =
*port, int flags)
 	if (port->type =3D=3D PORT_UNKNOWN)
 		serial8250_release_std_resource(up);
=20
-	/* Fixme: probably not the best place for this */
-	if ((port->type =3D=3D PORT_XR17V35X) ||
-	   (port->type =3D=3D PORT_XR17D15X))
-		port->handle_irq =3D exar_handle_irq;
-
 	register_dev_spec_attr_grp(up);
 	up->fcr =3D uart_config[up->port.type].fcr;
 }
--=20
2.15.1
