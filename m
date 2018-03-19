Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELuSYhnwM1dF70/vNqd0TXCXB9dnXg3btDR2WN2mTfPl9aXz+wmf71FIHnimi1pvHntX7KDp
ARC-Seal: i=1; a=rsa-sha256; t=1521475201; cv=none;
        d=google.com; s=arc-20160816;
        b=k0JI3MGp1bYFWE4uoeXEEAF5MGtu4BToL9sZmZaMQBTd5/4L4k7AyZhD+wVD0LYBJM
         qLPZ9lIuwea2UNr2QVUPZeMCh91wYdjSjtOn+Dg9pQ1HQc5hxSyxNHttL1uYLfClbyuP
         1RZ4GCICZTv5lOiP3UTnUHCMJCSI8BE41UAkma7o+0pE4vE/4XQriZZX4Jsy9p77TJpJ
         Ojhoq/G8A2bQOxoKmUY/bRMzt8SShHjfDsEZJfzdVPRECh5pJEwouWFAQ1rS2zEfLZ1K
         UHQpjVNacm05rtjeTAFpNq1X1kuvEcbeHvM5Y5JgJ966NtI5Kv7Vj2tM9nrwCoSlFwy0
         uUzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=kk74Mf9gqudM9bL62HeemDPBuRdn2bcNQt1SWk+tn90=;
        b=TKfxvvpac5ulO4yErN/JLNkSfqtwhiL4ysjNEi93pm48yH1Np/lz69dP8QD7lBDkOq
         UdvL2XDZzIa+URTEeyC97nstrQqtpxcuO/CXzlbsfvcY0HBHdOTDTCOI/jq6TWp8fecd
         zhFevN6jtBhXpaULs4jWMP0oNLKSOBiTP+Kv2BY/xp5TU/9ERvzM4mLXDNjbifsxeO5H
         UMFeGgwIIKIZe+vF2zKmhW7hRDa/q0vFRgOB4m1bzy8DyFfbQRo2c+kwTOovfJEycveE
         /FaHcGnfFu+D53HWv/fZJhUzwY2k45IsTe11hyhymLREsNYIvMbCNR1uKuQkA+mV8GgZ
         tXQg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=m9nHar1a;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.106 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=m9nHar1a;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.106 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 072/281] serial: sh-sci: Fix race condition
 causing garbage during shutdown
Thread-Topic: [PATCH AUTOSEL for 4.9 072/281] serial: sh-sci: Fix race
 condition causing garbage during shutdown
Thread-Index: AQHTv5s5L95EgF/EmkWj/pdNOyX03w==
Date: Mon, 19 Mar 2018 15:59:13 +0000
Message-ID: <20180319155742.13731-72-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0869;7:ao/EriwivWZdST+hIEbJf+zvn8Gn/s8ffnSIsLuCgXFr8WVETdpruOwAS3KBsFHywXxitDWWOSeDVtk1bx6B9GMUbvzG9MNRYglG/+pn/r1GHmxEYjqgd238qL/SvtOzW3jpdmALaNHnkbb16EBjO231N2rVn5zT5auMq4fohm7PSRQrfTP77GIow/XohJFzR+D1RQy+G4xQAs1WcLxFQ/8BPvmGJ/Vw6HLLUR3IlnrgJuny7SwF3AYFU3wDz6aa;20:fxhBo+ELnvtu4jAEFWC96D03WNCWBjazZyUic3JFjxmiIRhTaO4owuRMnbcitL/EH2jExlCw4JrqeGOqDhl+TgILPiKezACrDR+n/0Gxmir5exrW6By0gnMT9DRjwkHXuwcIZd6DcfDmscQ6euISqveYcyL3uXKMiBG7FsACCgQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1511a02e-3f10-4743-41df-08d58db2781e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0869;
x-ms-traffictypediagnostic: DM5PR2101MB0869:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0869BF989A43EEBA1FD45B7EFBD40@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0869;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0869;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(346002)(39860400002)(199004)(189003)(76176011)(6486002)(2950100002)(6666003)(2906002)(5660300001)(54906003)(14454004)(110136005)(7736002)(2501003)(10290500003)(106356001)(22452003)(59450400001)(3280700002)(5250100002)(305945005)(25786009)(99286004)(107886003)(10090500001)(6436002)(26005)(97736004)(53936002)(86612001)(3846002)(6116002)(186003)(1076002)(8676002)(81156014)(81166006)(68736007)(102836004)(72206003)(3660700001)(8936002)(316002)(478600001)(4326008)(36756003)(6506007)(105586002)(66066001)(6512007)(2900100001)(575784001)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0869;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: XgwPjJXYFzI7jSiEQRf3L02rKeRjUbS/uMQlVxVMgAPgO/yV+nZ8EXNsA0aN9GB7VegVJmUgBahGAfhL452oQwIMoWDBjt+FMOqYREgp0+TiWnIX3FR8IHMS2bxs4x44y8vFsGemj1y7nvXPvvN0joIIP42sKg1KxWAmJWb4+268hDLN4M4YdkB4OHjs2CwlHzif039mshzGUKnjlnMFqLUqDh9/Kr5/sgjM1kxuyKpR0YbfWbXAaD/4aAAfD31kLYQCirpbq48Z4d5n/fGjt0oszzcGSb4kuuOyEkawEvCLHV8ZUVs/Kbw7MaC4Wkce4ujc9LiZ4CpwVrpqAVWOGA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1511a02e-3f10-4743-41df-08d58db2781e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:13.8902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0869
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595382381074210323?=
X-GMAIL-MSGID: =?utf-8?q?1595382381074210323?=
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
index 15eaea53b3df..6c6ad902e6b8 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1543,7 +1543,16 @@ static void sci_free_dma(struct uart_port *port)
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
@@ -1551,7 +1560,9 @@ static inline void sci_request_dma(struct uart_port *=
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
@@ -2549,6 +2560,7 @@ static const struct uart_ops sci_uart_ops =3D {
 	.break_ctl	=3D sci_break_ctl,
 	.startup	=3D sci_startup,
 	.shutdown	=3D sci_shutdown,
+	.flush_buffer	=3D sci_flush_buffer,
 	.set_termios	=3D sci_set_termios,
 	.pm		=3D sci_pm,
 	.type		=3D sci_type,
--=20
2.14.1
