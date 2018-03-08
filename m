Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELvPt1FMBgUu22IaA+klPTWvcVjgQ1LgrKms/b70XkCVXodOrad5nDciPobefq3y4ac/nINC
ARC-Seal: i=1; a=rsa-sha256; t=1520484990; cv=none;
        d=google.com; s=arc-20160816;
        b=Q4GsSjI325JYVR25AQlMdgqYBOSi2M3K6Lk1n0GbTSBnjBIg/EMbf18aY5kWvwwC/6
         ItUWDKlt5JoDzHcbAb7/DI07n91Qlnr4yRIDkPXbJFhocvjsm4uBvnjl+TtBQPSoUlOg
         UPKtuW8sAX57lFmvqKUQwhC4AWKgkI5K3qnCo3VWherYfgt0ocyq/57bYrvIfMcISzLk
         xkX3dYqy+DkAWrbzFTDZzrQvEupSFCqzN+6JqURbke6MxWzgL6gJ/2Kgqkhtjh51cCBc
         BXtxC0qRPpSEaE9GMa0K/CgOTUSB+6gVmTlojZj8Cj77tt+k2aIY0zEKF4a4P7Sfslk+
         bUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=Q/C8U37lXimY85bwOZjv1x7l/zlNsyrJpvJ5bfFOAh4=;
        b=vrO+f1/lfRRmozitG04jQXUN+eXO89j9HM2gGjn+agTR3DkqGcHZOH4OUiHcRSO7Tj
         /yoRhuaZ6vQ8rH/Z/xn+lEhHRdr8JMb3OVHsIc20xOxMB6cvBd+Y5+3D9/IpJTTHI+2a
         v2E/jk6g3J/t03TJfhGS35cokAdoV3TSQ/3gVgGa8azjDJScEv8BHoRq7Uru2kjBlY8H
         WM1YXPBmys8w41RlyjYtEHlbPbQUeF+G39vA0AumgsXFYJkT1Ivt0B6Z/JcVj0VMqQs/
         tc603S9lcXgO1gxrpWqyPDRi6mjSgQBUm1c3juTbbAhHvVyrabaEzQWOBPTsOT8FVdy3
         VyQA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=fffGHhYT;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.33.94 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=fffGHhYT;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.33.94 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 25/78] tty: goldfish: Enable 'earlycon' only
 if built-in
Thread-Topic: [PATCH AUTOSEL for 4.15 25/78] tty: goldfish: Enable 'earlycon'
 only if built-in
Thread-Index: AQHTtpnHRfCBqkbKF02yi4Ao37uDtA==
Date: Thu, 8 Mar 2018 04:56:12 +0000
Message-ID: <20180308045525.7662-25-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1111;20:VCTnyPOG2MCLoE+1WDM9F93pmsOaZ6K3AzxwCScDHO3gN44FNOyz2n2QyKAIvLCJOhWoSFduvfQk/bmrGcKnPGolNnbd7V4nHB2YTMw7ZzaEs0U3xxgU1K5Zv8uAk61Lzc48KeWQ7KCGRpEE03L2NxvM8QhF2wzFlNQEP8oaeEc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6c18c358-962f-4bb9-95fc-08d584b0f3d9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1111;
x-ms-traffictypediagnostic: DM5PR2101MB1111:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1111EAF3F812E20FF20848ABFBDF0@DM5PR2101MB1111.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1111;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1111;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(376002)(39860400002)(366004)(199004)(189003)(86612001)(22452003)(99286004)(7736002)(54906003)(305945005)(86362001)(5660300001)(66066001)(6512007)(81156014)(14454004)(53936002)(2900100001)(10090500001)(1076002)(110136005)(107886003)(575784001)(6116002)(6436002)(3846002)(72206003)(36756003)(102836004)(316002)(3280700002)(3660700001)(478600001)(106356001)(6486002)(76176011)(6666003)(81166006)(10290500003)(4326008)(2950100002)(97736004)(25786009)(59450400001)(105586002)(8676002)(26005)(2501003)(2906002)(5250100002)(8936002)(186003)(68736007)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1111;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: XmA42P/UCCPTDFkD7tGEdJkKEhojWnpcHMC2vQ+eKe9NP171IhrAF7yOHXBrttjmQOFvCMEE3s5oCR9hH0cnJQT3mzmCULzoXHGcwpdUY4Im9AxEl41Z2iYlnrqHd1/PyFibWU5X/gPqc1XuuJJyqi1cqIYm/lRK/0ULL9RCeoowR0L/FeUX95t461TsuDcmvJFrp1fkoD60yIUQ3cbwELbXdiZ6oje+kc2qo2m9FxHYDDe8n8c4p2jEsLijaonDBbLrkpEbUjYeD4ZXYGQ8o/LHKVIbSI4kLnGZbu5c0wz35qVRQsG2oSF0FNSjQCm7gT39VT64sk8yl9RUWGlS/w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c18c358-962f-4bb9-95fc-08d584b0f3d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:12.2114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1111
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594344069127920075?=
X-GMAIL-MSGID: =?utf-8?q?1594344069127920075?=
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
index 7f657bb5113c..1c1bd0afcd48 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -433,6 +433,7 @@ static int goldfish_tty_remove(struct platform_device *=
pdev)
 	return 0;
 }
=20
+#ifdef CONFIG_GOLDFISH_TTY_EARLY_CONSOLE
 static void gf_early_console_putchar(struct uart_port *port, int ch)
 {
 	__raw_writel(ch, port->membase);
@@ -456,6 +457,7 @@ static int __init gf_earlycon_setup(struct earlycon_dev=
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
