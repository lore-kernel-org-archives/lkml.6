Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELvw8yBJe5k9dktemQjQWkzdUYk9Reb5VTlj+7BFQ/m/nxGfmRzECKqmYHtthHbZK+QuK30z
ARC-Seal: i=1; a=rsa-sha256; t=1520485095; cv=none;
        d=google.com; s=arc-20160816;
        b=ispIpEwrBvbm3mrB3aSSlOgJNlQSg7irQojaRHewdP4qz0dZaRjR0dG7KDnXHDFttO
         fCMknFrxcNLOP44ODMMdPoD1E1cQkRMXNWbn+ccIC8K/oAE6NbEc+0QC45naxPRTRv+D
         6fuBPzSR2qjWma9XUvqtuUi+ai3RioC4nyAhrefFV3/Bulh38qKTwFeTDEZBa4y6Zb9B
         dVZLlB9Z/3SWbF6hxRAEq4GPrSdWmA1dIvhOzIrOTGROFugEI04wrPwcnQ/DP42U3c58
         W3AuwkbtLy6c5of+mWCk0ADl0+a9KcbrUGpdOgOZEW+EkpgQNlko0+68w+WYVuqAM8Q3
         2lvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=K5VHiNKQJ7+Wn0oEJXFrh/V6HQcKz/dLWsf3nwJanX0=;
        b=F+9aw8hQxZMbobu9ZOeZ8aDA+PX+49ujT1p6wEpAMWRv/zebPEmxuG96KPphRcdLAQ
         aErqpplpxO499+JDp9KxPyMc2Mur8DP0oTmntqDg5JEFLsUfCZf0HYrPki/dcXHE25uW
         EE52dQVACc/lE6AeIm8cnIwQxN+lnEM0FDIqKOEBqFCw6pgvvBkUNm7P0qxjv0PF/Ega
         dcoS48Bhweyda9CFOtUJ4RSN3e3qeGWh6tfoztqbXpY9K1hoFf/3Fekjx4Y5DSQVopiz
         KWwjlOEytq2byG7ArohFFyPpEbulnBS37xNtESLtHPF32FSLLnHh1tbVE3UUn7Wrq2xp
         /DMw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=UV1DZkmP;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.41.128 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=UV1DZkmP;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.41.128 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 20/67] tty: goldfish: Enable 'earlycon' only
 if built-in
Thread-Topic: [PATCH AUTOSEL for 4.14 20/67] tty: goldfish: Enable 'earlycon'
 only if built-in
Thread-Index: AQHTtpn87EH5/F61rUGBq3+zobOEpg==
Date: Thu, 8 Mar 2018 04:57:40 +0000
Message-ID: <20180308045641.7814-20-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0808;20:YuDndRRbRqI0Nnv6Bn5rdVM+H9S6Z4k0FbO5LfyAuEi+KEbifXa8XeOAKIOgHaI3aulnXJbrYarhMCVlWtAOxcFqOuBIa364hvNfvmAMpeQapiCXo2qtyqgVIQwUtWnxZc13DLT3ieho1EjGaMxuM4dF8PD0c9hUTDLlqhvlidE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aa6cdb31-d0ae-4d70-6e03-08d584b1328f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0808;
x-ms-traffictypediagnostic: DM5PR2101MB0808:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08084E6C68D3F387FD803C4FFBDF0@DM5PR2101MB0808.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0808;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0808;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(366004)(376002)(346002)(199004)(189003)(22452003)(99286004)(76176011)(2906002)(105586002)(3846002)(86612001)(478600001)(72206003)(14454004)(2900100001)(8676002)(102836004)(68736007)(5660300001)(316002)(6116002)(54906003)(26005)(6506007)(575784001)(59450400001)(1076002)(86362001)(36756003)(186003)(10090500001)(110136005)(106356001)(4326008)(6512007)(6486002)(7736002)(5250100002)(3280700002)(3660700001)(2501003)(6666003)(81166006)(2950100002)(305945005)(53936002)(107886003)(8936002)(6436002)(81156014)(66066001)(25786009)(10290500003)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0808;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 1X4Cxnq9Qpeok8H+CpnG8HrvfZgr/dvGokkjZRy30mDTViYSoOgO4s9lPhcw8qSkSejX+I1mbt/iqX1NM7eJAC+NGAhh+60b+U1JgAzvjpmdCywGuj7iRwYQgmm2HKls5+iacnvG6wUeWXntXIQd4J/gf0pM7MlTUoix9pmQfIJb2jBiUnc3kcN0WEHAHO86XPcS3jrzBh4VznYCzDwxTucmbDH1T0c1tZbnEHLpUBH8D5w3wzS91xYMLJhd8xiasYlJLYz7AdJexncdAhykRQSlgE1Nkafr/+Zr/SLyIUFJ/sLX0hS+VTTj2huFyOQf+2mrwfjD+dZA0yIOfuWb6g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6cdb31-d0ae-4d70-6e03-08d584b1328f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:40.2469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0808
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594344069127920075?=
X-GMAIL-MSGID: =?utf-8?q?1594344179129220684?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 6a28fd2bbc94bfca105632e5ef8a9dbe63ba0b39 ]

Commit 3840ed9548f7 ("tty: goldfish: Implement support for kernel
'earlycon' parameter") breaks an allmodconfig config on x86:
|  LD      vmlinux.o
|  MODPOST vmlinux.o
|drivers/tty/serial/earlycon.o: In function `parse_options':
|drivers/tty/serial/earlycon.c:97: undefined reference to `uart_parse_early=
con'
|Makefile:1005: recipe for target 'vmlinux' failed

earlycon.c::parse_options() invokes uart_parse_earlycon() from serial_core.=
c
which is compiled=3Dm because GOLDFISH_TTY itself (and most others) are =3D=
m.
To avoid that, I'm adding the _CONSOLE config option which is selected if t=
he
GOLDFISH module itself is =3Dy since it doesn't need the early bits for the=
 =3Dm
case (other drivers do the same dance).
The alternative would be to move uart_parse_earlycon() from
serial_core.c to earlycon.c (we don't have that many users of that
function).

Fixes: 3840ed9548f7 ("tty: goldfish: Implement support for kernel
       'earlycon' parameter")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Miodrag Dinic <miodrag.dinic@mips.com>
Acked-by: Miodrag Dinic <miodrag.dinic@mips.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/Kconfig    | 6 +++++-
 drivers/tty/goldfish.c | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index cc2b4d9433ed..b811442c5ce6 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -394,10 +394,14 @@ config GOLDFISH_TTY
 	depends on GOLDFISH
 	select SERIAL_CORE
 	select SERIAL_CORE_CONSOLE
-	select SERIAL_EARLYCON
 	help
 	  Console and system TTY driver for the Goldfish virtual platform.
=20
+config GOLDFISH_TTY_EARLY_CONSOLE
+	bool
+	default y if GOLDFISH_TTY=3Dy
+	select SERIAL_EARLYCON
+
 config DA_TTY
 	bool "DA TTY"
 	depends on METAG_DA
diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index 381e981dee06..85a500ddbcaa 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -442,6 +442,7 @@ static int goldfish_tty_remove(struct platform_device *=
pdev)
 	return 0;
 }
=20
+#ifdef CONFIG_GOLDFISH_TTY_EARLY_CONSOLE
 static void gf_early_console_putchar(struct uart_port *port, int ch)
 {
 	__raw_writel(ch, port->membase);
@@ -465,6 +466,7 @@ static int __init gf_earlycon_setup(struct earlycon_dev=
ice *device,
 }
=20
 OF_EARLYCON_DECLARE(early_gf_tty, "google,goldfish-tty", gf_earlycon_setup=
);
+#endif
=20
 static const struct of_device_id goldfish_tty_of_match[] =3D {
 	{ .compatible =3D "google,goldfish-tty", },
--=20
2.14.1
