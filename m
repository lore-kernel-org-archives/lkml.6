Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AIpwx49ZV5M6PIH0HRxXl+IeA5T5or0voBAensMjk0oPnGZMrwv8r+H8tfT57Og3mbBQ5SgvBA20
ARC-Seal: i=1; a=rsa-sha256; t=1523233885; cv=none;
        d=google.com; s=arc-20160816;
        b=mt+mRb5ny+sZusHwj5+SZMgScLiz1y5G1FFFIVILV4y6W4/k/Hj2+XP8efUKY/BWbC
         h1cobiH+2h+rdZk8odNMk4GvKCwmN/oibjychIiwpvZwLScp8Nc9Es+Z0hJQQM7iyco9
         L1OXjyBu06aHim1mORSVLTDVspZ3XqqqjqmFZdOyXL/r6/Ju2dzsmMxtSc9HwtrKI4Jl
         QtS0VYrgt7Nrcxl1Ufvofw63yrwx6I9A8l9gW4tOM1I71vkqgFptbsw7wMgzqlcCYVgv
         hMxTZLfkKGjIj8JHhCOH8TFrebzi8ALwSJ11QFbEpSiabMXShPrerjdpMAh+YxgzyPxE
         avcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=68oLYEp+XeKVoRdb3x8QRtYhM2N5IRF9Roxa/S9Ny3k=;
        b=Mu6plQ7dgmK9/axaR/YO2PFsI/R3dEL/XswzTR7B0EBnLEh1CfJ7olzzO8yDtfor61
         r7ATNoJwnlGyI+hCqXGrQcJIestmUlP1n9X/mPkYXSdUoraM35wzNPRboEWd+hqYUsYw
         Y15ARE97UJXb0rQ9rIcPTsrUxLHum+ZNnC8NiK+dCvWlBfnMK39V1IvgR08Hv/xQ4vPn
         H5MYxME6xtS0xE4VZ1afPhGFMbNrTSnvDYwgMwqbpOfLaHb4OUU+OX9Iz60cxomMXQym
         b/psLxnMAsK/3lDOVUzjhbzC/4oZd5Ud7D/78uzdeRtjOu1JURwifUgTwUVKSxSpdm4u
         dn1A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=AYVwRDWN;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.120 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=AYVwRDWN;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.120 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Vignesh R <vigneshr@ti.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 179/293] serial: 8250: 8250_omap: Fix race b/w
 dma completion and RX timeout
Thread-Topic: [PATCH AUTOSEL for 4.9 179/293] serial: 8250: 8250_omap: Fix
 race b/w dma completion and RX timeout
Thread-Index: AQHTz5k6LegX0UAFuECx3eTRdcWr6A==
Date: Mon, 9 Apr 2018 00:25:14 +0000
Message-ID: <20180409002239.163177-179-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1126;7:Pe1JO/uCfaMdnn7/2WksNZi9zC0/zJzTo76j9cijO0+lxToBk0COv2AKAA6hndl1l3TJXMgX6Yb8nntwOteNAaV9jxbU0CQyANElz0BhaX1X8CMlhpqWDDwOfxFOn1OKuLs/JloCesQNumqQkAOh7wppWJyxFUMoePxbVD5e+9s1bAAzNgh2MLRxaboOiS6JXVg+dfY8Pn7zmfjeuQKU/P8R6f1tWMFZMwTWS0OXZUiYCFqA4LcqiW8YZSEBrdZx;20:bLqH3e80eRCKSScd3nUFAOeePYL10CXiFetvfd4l5766jwibkZMizYY6LBwrO58cdC3yr1zh3uO30d+/v1kqqEtlhydTxrbjal4SV+3ZxL/+JN3sVVTdH5BNsSOBWVh4NoHyiZ88sbf8Ohl5sYr1Vf+OzctEWXSJnw6jtJu6Ki8=
X-MS-Office365-Filtering-Correlation-Id: a6359547-89ab-4b67-8f03-08d59db1390d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1126;
x-ms-traffictypediagnostic: DM5PR2101MB1126:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1126588911CC66F6F2D6C7F5FBBF0@DM5PR2101MB1126.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1126;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1126;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(39860400002)(346002)(376002)(189003)(199004)(2616005)(476003)(81156014)(8676002)(81166006)(3846002)(486006)(2900100001)(6436002)(186003)(478600001)(72206003)(110136005)(54906003)(2906002)(86612001)(6666003)(2501003)(26005)(10090500001)(102836004)(6512007)(6116002)(14454004)(5250100002)(10290500003)(1076002)(575784001)(446003)(3280700002)(3660700001)(11346002)(8936002)(25786009)(59450400001)(6506007)(106356001)(4326008)(107886003)(36756003)(105586002)(53936002)(86362001)(66066001)(6486002)(99286004)(5660300001)(316002)(22452003)(305945005)(76176011)(97736004)(68736007)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1126;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: qYrKe82pF6R5+5cPERH5MynJDtPivNLHZJQHaBcafBqPiSgwONMAWiHGO4Ra/Dlr1sTpDAn2AuRo+xMCkFCXEMJ6yeIrTKxQjwXByrGGM1ssr3cKlhjXPvtYxR/ipV1z4px6H2Ic3BtmJAE9rnWdhOaDtGCA/edFr1cxZHGA39bVRj2Izs5rop31aEqWge4tipHQSuLY3vKz8NRplmlFA19hMBLLfMtcGYVZd0rQP/41KS6UvzzL9Y5TBtA08OZzzhn0efhHqMPPdDUiN/xmzaUJ1bQlBT5MONzb6k3DsuaTgJbSTuXJ0vhMDU8erQ98aOyybtXQDGhMhY9cXw61NDNbnBkrfkkbwfVys93MeX/3GWg3rqKYYTkyKkckfCW7zrgNx6v1505g7sIvdppimdEMLOGIeby+5J2ZkiCTkdo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6359547-89ab-4b67-8f03-08d59db1390d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:14.7064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1126
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597226494406770943?=
X-GMAIL-MSGID: =?utf-8?q?1597226494406770943?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vignesh R <vigneshr@ti.com>

[ Upstream commit a1bfb6eb300d008decfbcdf13b0fda536d22dea9 ]

DMA RX completion handler for UART is called from a tasklet and hence
may be delayed depending on the system load. In meanwhile, there may be
RX timeout interrupt which can get serviced first before DMA RX
completion handler is executed for the completed transfer.
omap_8250_rx_dma_flush() which is called on RX timeout interrupt makes
sure that the DMA RX buffer is pushed and then the FIFO is drained and
also queues a new DMA request. But, when DMA RX completion handler
executes, it will erroneously flush the currently queued DMA transfer
which sometimes results in data corruption and double queueing of DMA RX
requests.

Fix this by checking whether RX completion is for the currently queued
transfer or not. And also hold port lock when in DMA completion to avoid
race wrt RX timeout handler preempting it.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/serial/8250/8250_omap.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/=
8250_omap.c
index da31159a03ec..d0a129aeae29 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -782,8 +782,27 @@ unlock:
=20
 static void __dma_rx_complete(void *param)
 {
-	__dma_rx_do_complete(param);
-	omap_8250_rx_dma(param);
+	struct uart_8250_port *p =3D param;
+	struct uart_8250_dma *dma =3D p->dma;
+	struct dma_tx_state     state;
+	unsigned long flags;
+
+	spin_lock_irqsave(&p->port.lock, flags);
+
+	/*
+	 * If the tx status is not DMA_COMPLETE, then this is a delayed
+	 * completion callback. A previous RX timeout flush would have
+	 * already pushed the data, so exit.
+	 */
+	if (dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state) !=3D
+			DMA_COMPLETE) {
+		spin_unlock_irqrestore(&p->port.lock, flags);
+		return;
+	}
+	__dma_rx_do_complete(p);
+	omap_8250_rx_dma(p);
+
+	spin_unlock_irqrestore(&p->port.lock, flags);
 }
=20
 static void omap_8250_rx_dma_flush(struct uart_8250_port *p)
--=20
2.15.1
