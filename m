Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AIpwx49VHYFrXQYNvwlT3iZmvFeRkIUtOc+O5xke7ndc44ywD+D1/bR1RPARDLPlGxB7BS009VC/
ARC-Seal: i=1; a=rsa-sha256; t=1523233156; cv=none;
        d=google.com; s=arc-20160816;
        b=u2kXkwDDc7iTu/4Am331wLFUou5BktrTcznIEtx2SJZix8WcG3ohSFJ3DzpxgzLkBy
         QtyRcCPLR/taow0NrJ/1rjCapt0xtuXnmS3rlDkWeEoPY2OjTQqbMO8zGxMgW2kEasMh
         WUkhuc6F1Q9nKXEEvcZS8tPoLREIIariZT1ruPRjTPjW9BE5uwA8ySvCb4G91ww+LM75
         XeodjfPj8GfL7N7ZynMPh/ePVUDkBEHE8b+a4XWBFllxzVlkK6vk743h7RL36nLA83xl
         gV/mSBn2zBj6Tpep5kL87vCf8WX5WfFKeWNsy3tWMvboTJJl8Ed0Z6LATPeObqczkgN9
         DJ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=F3QJO11+aq2ukcZKFa6PUo3q8Eeqd1EXJbnxKQ/UgZo=;
        b=LiHITgZU3CYo9iLAOWiQonnVuZrqW5Wtuu3KwTS2lrPChBdOSftJpBnb5Zg4zX+Dhl
         1TEjsdS5PJXbclvp1JQDrofFywwNoig1TYmr52qXUxGnsrln7wL/gKgkQfQ8h00QrDAW
         Yi0ml6I2isx1kvAl8YSBiWrWQEK+sMfYAKWrvL72/WK4q53zvRpK7/wH02+vSvuRxrAG
         Zly5qTyBOMRyXl1QpolbgpY5qMiuxIdWgUz1/QDkkgPe6AM9DB4x/lT444j4vyafHtWD
         jbhSF3+vK+kV1KFYpoTaUcPySFhhrXmX3KLaiepbagPJHHscycZIG8s2Pf+XxxUg8ksi
         jDWA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=MXHbdE3Q;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.131 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=MXHbdE3Q;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.131 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Aaron Sierra <asierra@xes-inc.com>, Matt Schulte
	<matts@commtech-fastcom.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 092/189] tty: serial: exar: Relocate sleep
 wake-up handling
Thread-Topic: [PATCH AUTOSEL for 4.15 092/189] tty: serial: exar: Relocate
 sleep wake-up handling
Thread-Index: AQHTz5g2jqdRZLHGn0SNCnkbjWLFGg==
Date: Mon, 9 Apr 2018 00:17:58 +0000
Message-ID: <20180409001637.162453-92-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:sWkXENuQdNGllGZn6UulftBs9mxSI8+r7cXcMbM0dbQwc/wZUizgJ6+5ehA4slUyUlj24+L0eemDE+wMlNWifLkNQS69NIQn0Gk4ucqRJrdgzVZQcUlixnJlihlum13S5sY9DAqwvL2UoWqNop2qJ8U06XLDq4pBQ9lbDconeGtIVbmAGCWYPqEww4wQVrOFP66j38vjg7KhkWCjQHF8lUJG7yMNDl2TQ/5finShF78KrGRNxZ9mWmHkTEa5W0i/;20:HgRhTkYq9emDb1+Luy/yMulUZvvpxmGort3tIXTjF1iUZGcKoWbmmKcZJas1onZuafovh9TnAz/fC1sknlUW5FrNHUuV7kuhqYFjv8PwsvU8KJZLseTpCLq/LPyyvYEFuhxhg7MOrcRZ6AKe4Favl1jObOrRxdfIlgKVIbrnxcU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: dc98375f-b8c7-4495-9935-08d59daf86e7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB106304054B8EFDC1760D6BA4FBBF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(396003)(366004)(189003)(199004)(2900100001)(6436002)(7736002)(10090500001)(102836004)(3660700001)(6506007)(76176011)(305945005)(4326008)(5250100002)(97736004)(26005)(25786009)(6512007)(2906002)(81166006)(106356001)(107886003)(68736007)(14454004)(86612001)(66066001)(10290500003)(59450400001)(6666003)(5660300001)(81156014)(478600001)(476003)(486006)(6486002)(72206003)(3280700002)(99286004)(105586002)(36756003)(1076002)(2616005)(11346002)(53936002)(446003)(8676002)(186003)(3846002)(54906003)(6116002)(2501003)(8936002)(316002)(110136005)(575784001)(86362001)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Ra8DiKtVtrZ1oemHctytP9ZDgMq4yEJnkhnjaLQgvIJffxYp/Y8sKsQszLtOnGsIf30UQQgeFwQgs+V0wDJ7C4ifwIce06eejz2PSRDlq6Q21SsmFfwLnHsVJSvLmpwamkw+ZXxOaLAA0vTDVSYs2TV7TaAQzSkNFYCaZIKAEag05c7l3HlW8iTapaIc0314q4Li9G+S7+lRqnKIzI8U225oWsKwnjaUYpwJJc+T3f/SDUQ+O2D2Z4YkZfS6E+SB9ua7m3Sbc3VFH54WOaIDzxLx7eNNmR4fDfOBaEmej9fRW0gbobvXY8ATAZ37haUt7c1ubw7NdzZI45aR/x/zJJtEZ/EnJznvhQnVfvd0uSLbQdR9eoyNtuvGKSNXtcoZ0C5HNtJ9CuwMZgjK2mS9dfRK9vfTNAf+aIgZkf48T5k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc98375f-b8c7-4495-9935-08d59daf86e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:58.6320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597225730959541016?=
X-GMAIL-MSGID: =?utf-8?q?1597225730959541016?=
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
index a402878c9f30..38af306ca0e8 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -34,6 +34,7 @@
 #define PCI_DEVICE_ID_EXAR_XR17V4358		0x4358
 #define PCI_DEVICE_ID_EXAR_XR17V8358		0x8358
=20
+#define UART_EXAR_INT0		0x80
 #define UART_EXAR_8XMODE	0x88	/* 8X sampling rate select */
=20
 #define UART_EXAR_FCTR		0x08	/* Feature Control Register */
@@ -121,6 +122,7 @@ struct exar8250_board {
 struct exar8250 {
 	unsigned int		nr;
 	struct exar8250_board	*board;
+	void __iomem		*virt;
 	int			line[0];
 };
=20
@@ -131,12 +133,9 @@ static int default_setup(struct exar8250 *priv, struct=
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
@@ -420,6 +419,25 @@ static void pci_xr17v35x_exit(struct pci_dev *pcidev)
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
@@ -448,6 +466,9 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci=
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
@@ -461,6 +482,11 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pc=
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
index 11434551ac0a..1328c7e70108 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -441,7 +441,6 @@ static void io_serial_out(struct uart_port *p, int offs=
et, int value)
 }
=20
 static int serial8250_default_handle_irq(struct uart_port *port);
-static int exar_handle_irq(struct uart_port *port);
=20
 static void set_io_from_upio(struct uart_port *p)
 {
@@ -1883,26 +1882,6 @@ static int serial8250_default_handle_irq(struct uart=
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
@@ -3067,11 +3046,6 @@ static void serial8250_config_port(struct uart_port =
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
