Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELsLQkkeYtYaMb9xmSLWz/NYBZfkTYKzzkOTc2tzNO6HOBYAu15dQa8Mfpn340MtlaJtlcAz
ARC-Seal: i=1; a=rsa-sha256; t=1520116501; cv=none;
        d=google.com; s=arc-20160816;
        b=b/ASflp8zmzRkOZO5YJHMpxePeWPO1BXFLD4of+Qg5B5qPQhUBNKx7CbGw70jpq1y+
         HkjZC0LXhEf0DbrTgEbbaQklB/7hqn4g/n0SKZMeBWrszxqIRmLFynVnI6tE9+EviV28
         2wvyspmaOi9XfNyIc50gl1QvGb3l/f8Bs0xSq79wGXq4g83N6UIY96FCtsDAMHTYh/sX
         HsguK1qUYgq3AVNnB+qDO3mBTBucEvS/xTzutg+3M9VEQoRNK1exzjxyZooJRL32cuot
         f5w2i0qchruUhQKrv2hs3C5LJw++y1c5i5hc/SiEmZuGJyFtYhJ329+i83fpuxC8U4wz
         7Whg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=IlajqvRmZPIUU9AcRYhFguchbStJjG2QM8GWyWRG1HY=;
        b=ZP2KfoLgy6/jlpKC+3whNk5FuahrZVVqokUk/UVsJTAEDjlqwVRHPBrnNyj18RduAM
         8LUTXQyEmE5s5XYAMg0zGGEeJQ1E3JpmDdcmT7QO2JgbuowS6pnangpyHOXjyTllLy7Y
         1PKWgZnKNtwsDkM0fl7gTBwamGYP2ptMC6M6KznOGsseGAU09RTz9Q2/vQSYtX4J6iRi
         AwmIm57XSPiPQ+HTzVn7SR5o4NcOfFc1FReRiopPc3dtxeY5uPDSW8CIcMkzpKr48HBz
         eg1xVVClTUQ8kRdX5QKLu1qSV6p/Jqk4IIoPrgzSIYejbhplYPxB4orETupzvcEGqufR
         KiEA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=Kfb4VMIH;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.115 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=Kfb4VMIH;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.115 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jayachandran C <jnair@caviumnetworks.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 134/219] tty: amba-pl011: Fix spurious TX
 interrupts
Thread-Topic: [PATCH AUTOSEL for 4.9 134/219] tty: amba-pl011: Fix spurious TX
 interrupts
Thread-Index: AQHTsz8Oiq7USxOY5EqSfEjiP5FoQA==
Date: Sat, 3 Mar 2018 22:29:14 +0000
Message-ID: <20180303222716.26640-134-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0924;6:sHiDL+6kJPvA4n7sXVnXElerHsUnxw2mZbMJqG+6ikCSiBXL+wg1SKXakLzLZnrVF8IHx+UIgBYQKM5UTvscfZmFnvoHDSkMImJoyZDPWbfStkKpdM8nJCEzcE6z0Rf2ofPSGfUWjmta3M4fR2L8DDA8EsOJdSXNe0FgIJqdRL7fpGZi9HCQY1u6G1RbIHme8DJli7Sp58HS0efQXGxp4f4fehpZXRI2kmzl6ltzNP0ehKJ5Y3liJT4gCE9o04XVk+ZlrgXnA3MWHEq8rbSUDxCcYDJhMi+1cpwysu53wDHKe3fdYbH58YrjQt1R9jc6CAwV4jwkWZmLYVLlH60xMgVVEbh9BvQlRj3agD4OLqA=;5:IOE9uuSSyCsgtnugKYsa87xdjqJN+VYJ/BO/6fxwK5uHveg6ArYi0VmMkcAkqItiIzwWEqz/IzN/yDVvsw2jlNf87br444Q/mzKwF+nuHQmzpZ9UXTYVAAbo7Ghi421cdBWdLtIR+y2P75aUlWWvicjjGrEUYOVBJGyvFPtA//g=;24:Jbgqxjd4TTntzr2scJD21xNsQQ6ivies0sBqW8LgLkWemKCvhpbXvOlTIUGI/srhVmlV84xVXPY2Iw7KZiX8L+bk+wLCKjrl/s9WEazpNAA=;7:x8CRMz+gvGqFB4sivZ+fcKE8fy9gWQM3kQ6WFkciGit1KIyGM8uczir6UNMOftiUHV8/ZdjajTrdfmgzEC8+Zx+ERmsQjqGvKAF1NmOejQHSeultP6ReqVzB+6d3jcWODtcMjiF3FszTGvvsoQjGEalGUhWsWJ4/02EAGFNiaS8PQASuBjTHZUpulv2GLA7hM93JqXHmxPyKA6YXHhVwn9ssUWrunCwtyxBkXOv82rghBxznIaWytsJSVwmoLFpG
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 601a830f-7a75-4168-3bba-08d58156fab9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0924;
x-ms-traffictypediagnostic: MW2PR2101MB0924:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09246B97E9888AB9D645E545FBC40@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0924;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0924;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(189003)(199004)(102836004)(2950100002)(10090500001)(6666003)(316002)(26005)(186003)(25786009)(2900100001)(2906002)(54906003)(22452003)(110136005)(97736004)(6506007)(59450400001)(7736002)(4326008)(305945005)(5250100002)(86362001)(575784001)(2501003)(99286004)(68736007)(72206003)(53936002)(6436002)(6116002)(3846002)(5660300001)(66066001)(1076002)(76176011)(14454004)(36756003)(3660700001)(6486002)(86612001)(81156014)(8676002)(81166006)(10290500003)(6512007)(8936002)(3280700002)(478600001)(107886003)(106356001)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0924;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601a830f-7a75-4168-3bba-08d58156fab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:14.0257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957680199962483?=
X-GMAIL-MSGID: =?utf-8?q?1593957680199962483?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jayachandran C <jnair@caviumnetworks.com>

[ Upstream commit 7d05587c9e0e4611650bb403812e2d492c178a9f ]

On SMP systems, we see a lot of spurious TX interrupts when a
program generates a steady stream of output to the pl011 UART.

The problem can be easily seen when one CPU generates the output
while another CPU handles the pl011 interrupts, and the rate of
output is low enough not to fill the TX FIFO. The problem seems
to be:

    -- CPU a --                        -- CPU b --
   (take port lock)
   pl011_start_tx
      pl011_start_tx_pio
         enable TXIM in REG_IMSC   ->  causes uart tx intr (pl011_int)
         pl011_tx_chars                pl011_int
            ...tx chars, all done...       (wait for port lock)
            pl011_stop_tx                   .
               disable TXIM                 .
    (release port lock)            ->      (take port lock)
                                           check for TXIM, not enabled
                                           (release port lock)
                                           return IRQ_NONE

Enabling the TXIM in pl011_start_tx_pio() causes the interrupt
to be generated and delivered to CPU b, even though pl011_tx_chars()
is able to complete the TX and then disable the tx interrupt.

Fix this by enabling TXIM only after pl011_tx_chars, if it is needed.
pl011_tx_chars will return a boolean indicating whether the TX
interrupts have to be enabled.

Debugged-by: Vijaya Kumar <Vijaya.Kumar@cavium.com>
Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/serial/amba-pl011.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl01=
1.c
index e2c33b9528d8..b42d7f1c9089 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1302,14 +1302,15 @@ static void pl011_stop_tx(struct uart_port *port)
 	pl011_dma_tx_stop(uap);
 }
=20
-static void pl011_tx_chars(struct uart_amba_port *uap, bool from_irq);
+static bool pl011_tx_chars(struct uart_amba_port *uap, bool from_irq);
=20
 /* Start TX with programmed I/O only (no DMA) */
 static void pl011_start_tx_pio(struct uart_amba_port *uap)
 {
-	uap->im |=3D UART011_TXIM;
-	pl011_write(uap->im, uap, REG_IMSC);
-	pl011_tx_chars(uap, false);
+	if (pl011_tx_chars(uap, false)) {
+		uap->im |=3D UART011_TXIM;
+		pl011_write(uap->im, uap, REG_IMSC);
+	}
 }
=20
 static void pl011_start_tx(struct uart_port *port)
@@ -1389,25 +1390,26 @@ static bool pl011_tx_char(struct uart_amba_port *ua=
p, unsigned char c,
 	return true;
 }
=20
-static void pl011_tx_chars(struct uart_amba_port *uap, bool from_irq)
+/* Returns true if tx interrupts have to be (kept) enabled  */
+static bool pl011_tx_chars(struct uart_amba_port *uap, bool from_irq)
 {
 	struct circ_buf *xmit =3D &uap->port.state->xmit;
 	int count =3D uap->fifosize >> 1;
=20
 	if (uap->port.x_char) {
 		if (!pl011_tx_char(uap, uap->port.x_char, from_irq))
-			return;
+			return true;
 		uap->port.x_char =3D 0;
 		--count;
 	}
 	if (uart_circ_empty(xmit) || uart_tx_stopped(&uap->port)) {
 		pl011_stop_tx(&uap->port);
-		return;
+		return false;
 	}
=20
 	/* If we are using DMA mode, try to send some characters. */
 	if (pl011_dma_tx_irq(uap))
-		return;
+		return true;
=20
 	do {
 		if (likely(from_irq) && count-- =3D=3D 0)
@@ -1422,8 +1424,11 @@ static void pl011_tx_chars(struct uart_amba_port *ua=
p, bool from_irq)
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&uap->port);
=20
-	if (uart_circ_empty(xmit))
+	if (uart_circ_empty(xmit)) {
 		pl011_stop_tx(&uap->port);
+		return false;
+	}
+	return true;
 }
=20
 static void pl011_modem_status(struct uart_amba_port *uap)
--=20
2.14.1
