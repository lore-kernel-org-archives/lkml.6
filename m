Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELsB4i8CydDCoGUyjhXJ1IpJKKRYRVcfJKEho/CkedhOt2px7caQA9IXSw7Mfgns9X+LyppE
ARC-Seal: i=1; a=rsa-sha256; t=1521475699; cv=none;
        d=google.com; s=arc-20160816;
        b=T2g9uu851Yu8dupRRJMiVu61erP0UZp/KqLDR4WPOxFa4U/ShkywBqDbOKuWeEyxmW
         aIORbPdhZlel+bhZZHN0FOpj/bU7oihr+/VM2oeARVboJmKsVd/wNYj+OhqkM+6EkWRr
         Nh16JaC7LKvPU7le3m2Q9eD3LthxMvOUVRyy0Va16A8XP1wMqMpBbUqfd4a8Rf0C/XaH
         Ckxdy5Z4UC55/u5rEXytIkZupNTrx4Vm+ZFNuot2OlEpzK2KQ7JX3XWNoAshGTlHeIVh
         2CWKy+ke82t7d7xGmjIBDsZ4VVmMPKgSBAGpdXsGlRewCI1IlmnRwlb//5fDLt8JcGZj
         4itw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=2kNgaGefpWPG6Sh3/F1Suiz+/8kK1HdBA6iGreNSuRw=;
        b=rnEfDFUsxAJGJz8LJE9xXxZSJtSDUXJ1d5jANShrv3lruw+rAx1rQ8mcsowQ9tGnUl
         rK0SjDSjc41DHql7+pZvCXhiBMMBSOiuX1oCDrHP1Q0nA7uQoGBWYd03EoEm22pYjLbK
         m7GdiqDFeZRs0n/NNNJwg+d2FjsVKbDG2kB4WfXgOvo/KA4uMQX9ORvPNE9cI/Zo6aON
         v4WXuH4tApqxDzoxuQI8qaQovjU1cZtCnfa2YtIYrmMQvtl8U4twlGls9zN9JNAc92sX
         DU3koVjXfDVODNtByzdoOEOm+Gn7lqq1XMIcVKjh+2J43xfNkzUoFstop0OOnOcn/zZ4
         nWOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=cg87mrkY;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.34.116 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=cg87mrkY;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.34.116 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 049/167] serial: sh-sci: Fix race condition
 causing garbage during shutdown
Thread-Topic: [PATCH AUTOSEL for 4.4 049/167] serial: sh-sci: Fix race
 condition causing garbage during shutdown
Thread-Index: AQHTv5w5qIczdbR8J0KN4IAKRYD8PA==
Date: Mon, 19 Mar 2018 16:06:22 +0000
Message-ID: <20180319160513.16384-49-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1094;7:yHDoBnldHKhYDg48D0QLngq0lF4vc8EDIJisUse2ULKI2abQlOGhR1zorpcP+c12pkiJ6U8AHbgtX2oSt+Kj+txceDzdLXBUy/WiZD/8n7t1DLmZHjfsjtX/WcKxDE95+CQSM9Ewm0C9/idv7T9lBFBbV9Z13VuyXkfr8SlxR0KQyzNjwPG0SRRXtCce6f36ANmA/vDM5edVZQuYo7gvlTrXD0tnY6AWuxlf9juqmelpn048ReJYj+CDTu13NGth;20:Sc4OM4OzqQpLZVTpvj80j3QjjHA7YPBnKSQB9e18Gr1lYgMFS5PptO9qALu442gTD+E0fyxbR3Obj+hfdcx9Jgl2TGz+gCYERJjMrLCwrojUl006xG2qc6xV2FQUNdav8Ih3JR27ARoC/DqCszXVw/k3QYVcSvfGbwyueqeUSEg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 63aa0887-59db-4592-3156-08d58db3a102
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1094;
x-ms-traffictypediagnostic: DM5PR2101MB1094:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10940F27D86EF4155A2D7E18FBD40@DM5PR2101MB1094.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1094;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1094;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(376002)(39380400002)(199004)(189003)(106356001)(10290500003)(110136005)(22452003)(3280700002)(478600001)(6666003)(54906003)(2906002)(2900100001)(2950100002)(10090500001)(186003)(26005)(97736004)(5660300001)(72206003)(66066001)(107886003)(102836004)(53936002)(59450400001)(6506007)(6512007)(316002)(7736002)(305945005)(1076002)(6436002)(36756003)(3846002)(6116002)(6486002)(105586002)(8676002)(8936002)(86612001)(68736007)(3660700001)(86362001)(575784001)(81166006)(81156014)(25786009)(2501003)(4326008)(76176011)(5250100002)(14454004)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1094;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: DrLCw3ShNgmPT+9P/+1200LTokD/za36JuyuONwHbYZv6H541Vo5VudMWgt2C1uvFfKkq5wy3CkxhbgykzPP0EpNLSwLkBiEoLjRjL1X7YnnWTOkFt/I7T/g7rjWdmLJ7sNnbZtZUOvUIIaxbxgOxUclkPab103n0OXt6D5+e81P8uKiK3z6NvIsoUvaHWhnJ5H16SYNAeC6yw5xqjpNI5Q5F267YOppKUIpYj3OxRpKibVhoPV9QN0xMJptLGW0mPPfQpn9L7WFwC2jWPTrEfJzfcfXijQDSPAhn/th2veWB9wo5tZeqWEKIFXHGog1nCxie4iIazIFOFAzpCZvZQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63aa0887-59db-4592-3156-08d58db3a102
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:22.4630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1094
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595382381074210323?=
X-GMAIL-MSGID: =?utf-8?q?1595382903653789292?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 1cf4a7efdc71cab84c42cfea7200608711ea954f ]

If DMA is enabled and used, a burst of old data may be seen on the
serial console during "poweroff" or "reboot".  uart_flush_buffer()
clears the circular buffer, but sci_port.tx_dma_len is not reset.
This leads to a circular buffer overflow, dumping (UART_XMIT_SIZE -
sci_port.tx_dma_len) bytes.

To fix this, add a .flush_buffer() callback that resets
sci_port.tx_dma_len.

Inspired by commit 31ca2c63fdc0aee7 ("tty/serial: atmel: fix race
condition (TX+DMA)").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/serial/sh-sci.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 80d0ffe7abc1..b2a7c3d9dcaf 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1455,7 +1455,16 @@ static void sci_free_dma(struct uart_port *port)
 	if (s->chan_rx)
 		sci_rx_dma_release(s, false);
 }
-#else
+
+static void sci_flush_buffer(struct uart_port *port)
+{
+	/*
+	 * In uart_flush_buffer(), the xmit circular buffer has just been
+	 * cleared, so we have to reset tx_dma_len accordingly.
+	 */
+	to_sci_port(port)->tx_dma_len =3D 0;
+}
+#else /* !CONFIG_SERIAL_SH_SCI_DMA */
 static inline void sci_request_dma(struct uart_port *port)
 {
 }
@@ -1463,7 +1472,9 @@ static inline void sci_request_dma(struct uart_port *=
port)
 static inline void sci_free_dma(struct uart_port *port)
 {
 }
-#endif
+
+#define sci_flush_buffer	NULL
+#endif /* !CONFIG_SERIAL_SH_SCI_DMA */
=20
 static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 {
@@ -2203,6 +2214,7 @@ static struct uart_ops sci_uart_ops =3D {
 	.break_ctl	=3D sci_break_ctl,
 	.startup	=3D sci_startup,
 	.shutdown	=3D sci_shutdown,
+	.flush_buffer	=3D sci_flush_buffer,
 	.set_termios	=3D sci_set_termios,
 	.pm		=3D sci_pm,
 	.type		=3D sci_type,
--=20
2.14.1
