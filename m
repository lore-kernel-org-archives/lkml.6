Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELuknkj4pbJNki1L1v5Af9cE2MqHiwjxDcoaqdqg8VxJlnSXkIVNo3fykdWGE+p1dguvscj2
ARC-Seal: i=1; a=rsa-sha256; t=1521475699; cv=none;
        d=google.com; s=arc-20160816;
        b=gaYUGaV6Ul5j/G41GhdXMePM9u+e25L4b6yuXMfsitJZ5Dbmn88qt3Z2eurx5Fli7r
         sbe5fY/iNwPpPE8zAJcKrA//KEZlpUI2++zwNiofIsVveUrKILB/djGY3VmJx7RcJWpx
         Q/qS8umH6VqbmaNlXaGDxcv3cEvULXuG9LeaLo1pQ/tZoSrkAQ42AUw6MAgQ3ViSTqOF
         4rf6xA/2sPBUWqu5MVMKH3+Ydqfs16cVAfdfeE2PnDk9Wg+VsNMLaw/F/W4vNoPoB6dA
         OZLi/VX+VYcfqlwMEl/aZtF1L2hoHbo4Qwde6ecVX/0Tyzbt1c7iNzroBUhLxBdni6Fk
         RX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=86BXoJHSj6KhI4KOAzVvT6fDw/VqYrdyBmVycl0cjeI=;
        b=UVC3IdO+AXztc7BbLFm7iigjKPvpwcoItipDhWxJlJhIGERAgVxFQhM5T0/TBF/Mj2
         H7pwqPUjYfIPXCw8i8fpKV3WVoSMBz87ehcKR6lO/GtQ/Wer3ZDYefFpBDtWJyQQcKNs
         GHAFRQ2TArhmDTydTvS/hf9+6x/COYf4ascZZuX4yCpde2vtKwuJqysVjjPC81Gtc7y5
         tsFgkEH/iGFLg1+28jMtMkp9dXBiE4bjJTFGmGfkeqt9ho3l42t9CGGbKGxYVxzcAPuX
         9zk/nr2XtzdpXCC+ol+ZQzSjlPzjpZRD/m080w+o6XwM47PMo9cOdR3UJ2X+8LWxuSIe
         P8cg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=JRQNOmpD;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.41.121 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=JRQNOmpD;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.41.121 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Vignesh R <vigneshr@ti.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 048/167] serial: 8250: omap: Disable DMA for
 console UART
Thread-Topic: [PATCH AUTOSEL for 4.4 048/167] serial: 8250: omap: Disable DMA
 for console UART
Thread-Index: AQHTv5w4HZ0nmDOQaUSZbNxNaios/A==
Date: Mon, 19 Mar 2018 16:06:21 +0000
Message-ID: <20180319160513.16384-48-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:i+OcV4HEuRJoN018842i6+C8o2nt3diN5sfe4IBTi+BSQH1lXLwwXlBwkJhfnKCxMTdrKC4N1GL4R8f05qrGKKwCKZZhpgU2qZFzFwugssRGgSKiXXH1bafADJvpB9vmKS9fwLljwAHCq5J+gHA5Yd2u3oY6CDm5m/QclkOLhS/2028mpElWarq0rSkXe1XngN4LO9l0RbLEXgJ3QZuLVwXAtf45UEtxGw6PlBvbmoqH9lki1nscJKw0n/Ac7V3q;20:fO/uIBWdwKS8HyStxzFqMT50ElbzxrLMZcUXPb8kfuH4B4tj5p3VWKuAdzAYFd/PSbnWbd1+X3HxiO/hJZEFR4ToRBX9CDAz1WRIPUApv46L1Qp8Y+KdRCeeGl0xmHqetTBzXz1aX8nXHeXm5QEqRRLJBgOVZJpKYmQvtBzcGvI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 970c3f6c-2169-4524-fb6e-08d58db3a0b7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0805283363F17B08EDFAE512FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(2950100002)(305945005)(186003)(86362001)(6506007)(3660700001)(6666003)(5660300001)(6116002)(8936002)(3846002)(1076002)(26005)(7736002)(6486002)(2900100001)(6436002)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(59450400001)(8676002)(14454004)(105586002)(107886003)(25786009)(478600001)(2501003)(5250100002)(53936002)(3280700002)(316002)(54906003)(4326008)(6512007)(72206003)(66066001)(22452003)(10290500003)(99286004)(76176011)(36756003)(97736004)(106356001)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 97huLjfZoJiQAmf7TmnUpSPHH05owxR4PbmhuGCBW6l40Wvxm8ows5feCPUtR10XtPsvPG9XEyscGY2fYppU/ewvoqHHMRxRO/p0mmvqxb8qkLCCG6pQvfTjZD/drHmHf8bNrnkk8rd8gZHLbqWWpeUuuo0j4nb98G8IS5XWhKZ5EHnlZaWbBuA0wzWRoz5QXtx30YjbOHtBSk1eVLT0GJVMwQFp34DRLQJqUme3QuzUej9dGoPQGb7EIVNlAwpgzVS6TX9DuQWgSqhd/23RWMauFsppirkZZ4X3Mto8TloY+y0ZLSdHJU1BVMtVDlpC+7JM2BNa13G83PUB27qgvQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 970c3f6c-2169-4524-fb6e-08d58db3a0b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:21.0560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595382380868186672?=
X-GMAIL-MSGID: =?utf-8?q?1595382902711825540?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vignesh R <vigneshr@ti.com>

[ Upstream commit 84b40e3b57eef1417479c00490dd4c9f6e5ffdbc ]

Kernel always writes log messages to console via
serial8250_console_write()->serial8250_console_putchar() which directly
accesses UART_TX register _without_ using DMA.

But, if other processes like systemd using same UART port, then these
writes are handled by a different code flow using 8250_omap driver where
there is provision to use DMA.

It seems that it is possible that both DMA and CPU might simultaneously
put data to UART FIFO and lead to potential loss of data due to FIFO
overflow and weird data corruption. This happens when both kernel
console and userspace tries to write simultaneously to the same UART
port. Therefore, disable DMA on kernel console port to avoid potential
race between CPU and DMA.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/serial/8250/8250_omap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/=
8250_omap.c
index e8dd296fb25b..c4383573cf66 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -608,6 +608,10 @@ static int omap_8250_startup(struct uart_port *port)
 	up->lsr_saved_flags =3D 0;
 	up->msr_saved_flags =3D 0;
=20
+	/* Disable DMA for console UART */
+	if (uart_console(port))
+		up->dma =3D NULL;
+
 	if (up->dma) {
 		ret =3D serial8250_request_dma(up);
 		if (ret) {
--=20
2.14.1
