Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BF0C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 20:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3519E20672
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 20:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="k/86CLfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbeLPUKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 15:10:06 -0500
Received: from mail-eopbgr820104.outbound.protection.outlook.com ([40.107.82.104]:59904
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730746AbeLPUKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 15:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfqS2TdFslOzhmnGI67uSe8vhnl+JhEdbQB+MDgg01E=;
 b=k/86CLfLulUMGl8RVWvAzg8FFxkH7vz34pChgPNiFxi5AnOlZpLajZkOriCS9cwDO9rN+Q9RcqpkBkma2IJN2hjjXrLJUX/QMv5cfarAno3dConEKDnu+X/jTpwLrc+ZG5vPaUqlubpu6Lo82trpyngFVzrDo0wO1sHrvj2bGAs=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1408.namprd22.prod.outlook.com (10.172.63.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Sun, 16 Dec 2018 20:10:01 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%7]) with mapi id 15.20.1425.021; Sun, 16 Dec 2018
 20:10:01 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Daniel Jedrychowski <avistel@gmail.com>,
        Marek Vasut <marex@denx.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Subject: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode again"
Thread-Topic: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
Thread-Index: AQHUlXtT5YTLq052+E6wpTcC1lM1kg==
Date:   Sun, 16 Dec 2018 20:10:01 +0000
Message-ID: <20181216200833.27928-1-paul.burton@mips.com>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
In-Reply-To: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:a03:60::29) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:647:4100:4687:84d1:277a:c6e5:ae34]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1408;6:5YZPEk5lubHhqfDnNgedD2GXVY1YGSWr6TrHtbMSN3yw+wHScnkquRt8eVMvEwMTaIWPiPtiT1Gd1S6qzsTBmyzOVDsCflcmk40pZSVZaI4XrfwZLwj5Zk4zlYQQVf5m2CeZ240Nv9CgNXiBmBaQqWtQ40q71tOD8HQNQtZAYWutTiDA6O6Ts5USKdtXqT62nnHOHntcGvMbES1ozV9FIFFWRWHfeGrhU54hKtGqEZcoYZ5Pxi5p9Beb7Pjz1/GiC2pjovgiMXSa6C2VVVtUFpITKHr88gd/wH9Gx5dxb/HuXLOT+VhQeXopO7FqbP4h64HqAIlQAm7ksG0lw7rapUyBYCyKFw4fhnsqpz+P4W6P2gOdyFL/Ta1fI7S6rpcfjVI/atjJvbdqX7VM7G+8H3/EtqLbd7nC8ck6aDEXRcgNNE0G+WXZrKbjQBHDKhY0fzc+j7O8NyEB1k0gK372jw==;5:IdvDeKCbhvwbGvUxy+UnAlg+m5+qRVHqhBdkzP9dpWyhomudWyEdGpUVtaX87Qju5nob2wvfoIo4Dn28GLUgOXpRVEJwLcPY0MHzwNiiO9ud8FNXBS48mERe5yF/G+S0kstvRTGIalMzWSB/ukskBBJOdTaGcDHi8ox0euKNAr4=;7:0hMoCSgRx5f66S09bvi+zRDJa2DDbRoOi4zUNRufIIQ0/Ri9u9bCxGUPIulix8nP0XTJYyi4V4OA5A/ssK/RY0YU6MHEwket8Lz34wwAw+h3/ksHL+Aj/dhSj7ScszwCDkbMNpi3meDcLY4dagQw6w==
x-ms-office365-filtering-correlation-id: 094763a3-df16-44da-873e-08d6639275b0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1408;
x-ms-traffictypediagnostic: MWHPR2201MB1408:
x-microsoft-antispam-prvs: <MWHPR2201MB14084666C2FB7304CC4CC297C1A30@MWHPR2201MB1408.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(3002001)(93006095)(10201501046)(3231475)(944501520)(52105112)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1408;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1408;
x-forefront-prvs: 0888B1D284
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(39830400003)(136003)(376002)(346002)(366004)(199004)(189003)(1076002)(575784001)(36756003)(6116002)(446003)(2616005)(25786009)(106356001)(5660300001)(39060400002)(7736002)(305945005)(52116002)(105586002)(76176011)(11346002)(476003)(4326008)(386003)(110136005)(316002)(102836004)(6506007)(8676002)(54906003)(81166006)(81156014)(2501003)(46003)(2906002)(44832011)(99286004)(42882007)(68736007)(486006)(6306002)(71200400001)(6486002)(8936002)(14454004)(71190400001)(6436002)(97736004)(508600001)(53936002)(14444005)(256004)(186003)(966005)(6512007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1408;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /guYwgRtrmv6VOLDW65smL2G3s1OB/vLFnYfHSi0qR3yVFVkKIzM24M02r1CGD5sJGZWWVEDOul3JmubqatyqczOqFMcIwDNSuDk1WpPrPBZA+5+sq4JH+MVX4KOyuRl/fhxn2b6nqXMDcX36voJ/zaG7WiU8PoPqNJXkZ69NWD57AMFmLcaW6MLscD/CNGHr2xJG64xur9QogwanhHwwanhuHnQ0uEmdEabowz2nW5G7fQQZ59Hixy2YjuHW8j1nlbgLUMUGJkIxM+gqqThRlUmiPrHwC1pWrf04UxfqQSDPiTUhBPDe22eFdO4Pd/z
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 094763a3-df16-44da-873e-08d6639275b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2018 20:10:01.4444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1408
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f6aa5beb45be ("serial: 8250: Fix clearing FIFOs in RS485 mode
again") makes a change to FIFO clearing code which its commit message
suggests was intended to be specific to use with RS485 mode, however:

 1) The change made does not just affect __do_stop_tx_rs485(), it also
    affects other uses of serial8250_clear_fifos() including paths for
    starting up, shutting down or auto-configuring a port regardless of
    whether it's an RS485 port or not.

 2) It makes the assumption that resetting the FIFOs is a no-op when
    FIFOs are disabled, and as such it checks for this case & explicitly
    avoids setting the FIFO reset bits when the FIFO enable bit is
    clear. A reading of the PC16550D manual would suggest that this is
    OK since the FIFO should automatically be reset if it is later
    enabled, but we support many 16550-compatible devices and have never
    required this auto-reset behaviour for at least the whole git era.
    Starting to rely on it now seems risky, offers no benefit, and
    indeed breaks at least the Ingenic JZ4780's UARTs which reads
    garbage when the RX FIFO is enabled if we don't explicitly reset it.

 3) By only resetting the FIFOs if they're enabled, the behaviour of
    serial8250_do_startup() during boot now depends on what the value of
    FCR is before the 8250 driver is probed. This in itself seems
    questionable and leaves us with FCR=3D0 & no FIFO reset if the UART
    was used by 8250_early, otherwise it depends upon what the
    bootloader left behind.

 4) Although the naming of serial8250_clear_fifos() may be unclear, it
    is clear that callers of it expect that it will disable FIFOs. Both
    serial8250_do_startup() & serial8250_do_shutdown() contain comments
    to that effect, and other callers explicitly re-enable the FIFOs
    after calling serial8250_clear_fifos(). The premise of that patch
    that disabling the FIFOs is incorrect therefore seems wrong.

For these reasons, this reverts commit f6aa5beb45be ("serial: 8250: Fix
clearing FIFOs in RS485 mode again").

Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: f6aa5beb45be ("serial: 8250: Fix clearing FIFOs in RS485 mode again"=
).
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Jedrychowski <avistel@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Cc: linux-mips@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: stable <stable@vger.kernel.org> # 4.10+
---
I did suggest an alternative approach which would rename
serial8250_clear_fifos() and split it into 2 variants - one that
disables FIFOs & one that does not, then use the latter in
__do_stop_tx_rs485():

https://lore.kernel.org/lkml/20181213014805.77u5dzydo23cm6fq@pburton-laptop=
/

However I have no access to the OMAP3 hardware that Marek's patch was
attempting to fix & have heard nothing back with regards to him testing
that approach, so here's a simple revert that fixes the Ingenic JZ4780.

I've marked for stable back to v4.10 presuming that this is how far the
broken patch may be backported, given that this is where commit
2bed8a8e7072 ("Clearing FIFOs in RS485 emulation mode causes subsequent
transmits to break") that it tried to fix was introduced.
---
 drivers/tty/serial/8250/8250_port.c | 29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/=
8250_port.c
index f776b3eafb96..3f779d25ec0c 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -552,30 +552,11 @@ static unsigned int serial_icr_read(struct uart_8250_=
port *up, int offset)
  */
 static void serial8250_clear_fifos(struct uart_8250_port *p)
 {
-	unsigned char fcr;
-	unsigned char clr_mask =3D UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT;
-
 	if (p->capabilities & UART_CAP_FIFO) {
-		/*
-		 * Make sure to avoid changing FCR[7:3] and ENABLE_FIFO bits.
-		 * In case ENABLE_FIFO is not set, there is nothing to flush
-		 * so just return. Furthermore, on certain implementations of
-		 * the 8250 core, the FCR[7:3] bits may only be changed under
-		 * specific conditions and changing them if those conditions
-		 * are not met can have nasty side effects. One such core is
-		 * the 8250-omap present in TI AM335x.
-		 */
-		fcr =3D serial_in(p, UART_FCR);
-
-		/* FIFO is not enabled, there's nothing to clear. */
-		if (!(fcr & UART_FCR_ENABLE_FIFO))
-			return;
-
-		fcr |=3D clr_mask;
-		serial_out(p, UART_FCR, fcr);
-
-		fcr &=3D ~clr_mask;
-		serial_out(p, UART_FCR, fcr);
+		serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO);
+		serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO |
+			       UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
+		serial_out(p, UART_FCR, 0);
 	}
 }
=20
@@ -1467,7 +1448,7 @@ static void __do_stop_tx_rs485(struct uart_8250_port =
*p)
 	 * Enable previously disabled RX interrupts.
 	 */
 	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
-		serial8250_clear_fifos(p);
+		serial8250_clear_and_reinit_fifos(p);
=20
 		p->ier |=3D UART_IER_RLSI | UART_IER_RDI;
 		serial_port_out(&p->port, UART_IER, p->ier);
--=20
2.20.0

