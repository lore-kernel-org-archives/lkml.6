Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752467AbeFDLYv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:24:51 -0400
Received: from mail-by2nam01on0047.outbound.protection.outlook.com ([104.47.34.47]:4896
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752261AbeFDLYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:24:47 -0400
From: Janek Kotas <jank@cadence.com>
To: "broonie@kernel.org" <broonie@kernel.org>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: cadence: Change usleep_range() to udelay(), for atomic
 context
Thread-Topic: [PATCH] spi: cadence: Change usleep_range() to udelay(), for
 atomic context
Thread-Index: AQHT+/ajbXqH8skDeEahfuktQgLvSA==
Date: Mon, 4 Jun 2018 11:24:44 +0000
Message-ID: <65980D27-1B52-43A3-A7CA-33B804A62AC5@cadence.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jank@cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR07MB4644;7:sH1N+DFO3/kqba5Nw3xWH/HsESsvC27RHW/xO2WL8F1P/eCJi2bBrlxIjlGQX/eLCNVHEt1PMmHnwib5BMrfFr62q+bi64gyxqlt8X1CVlIWqPuJ8IOxPA5zZrfFQmeAmIkFAWlrkxvUsqm4dNGR4GyAsqIGfMwv2bkeyMiGBUVvaNmV/Kw5KC6aLR5lCjWDMyhH6M0/FZNVkl/+SejhLhmRP4aWr9iLxNYjy10FGGnCtKtCdD9ugR1TqInSPsYa;20:ml41zvqTioOlMImAqVOsEjSV8v4s9KMRGK3mIeS+fygt1rLGiu5iJZj327Hdvcs0MKeyghy5uAUFuZ8TMRr9cbkmpiDKTkgDdLf8ov3c0i0bZDeFTXTUYAqfjurl+vv6WRhcuWFoxf5XvsbZD2+38x59tOQGMZC/jts3C1EYkuOrIB/BfxcUVlg2tmojkav8EqCJmsR9WwxceZt2q418NHM79U7VOzg0jc864rTle19Sz+E3zhh9mMjvyFuJXe2u
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4644;
x-ms-traffictypediagnostic: BN7PR07MB4644:
x-microsoft-antispam-prvs: <BN7PR07MB46449F3D864B0ADE142BE07FD0670@BN7PR07MB4644.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB4644;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4644;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(366004)(39380400002)(189003)(199004)(36092001)(1857600001)(305945005)(6436002)(2351001)(25786009)(106356001)(6916009)(105586002)(5660300001)(6486002)(4326008)(14454004)(7736002)(5640700003)(5250100002)(8936002)(4743002)(3846002)(6116002)(45080400002)(36756003)(33656002)(478600001)(3280700002)(8676002)(1730700003)(81166006)(81156014)(3660700001)(68736007)(6506007)(2906002)(97736004)(2501003)(486006)(53936002)(26005)(54906003)(86362001)(316002)(102836004)(2900100001)(82746002)(6512007)(476003)(2616005)(59450400001)(83716003)(66066001)(99286004)(186003)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4644;H:BN7PR07MB4676.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: BfzlPQ95tS716DhoyDULso/UkH5km20NDUu+4Lymwt9DPao5aHe+DzglKmeTgjTclrLlm9unDX9QAB3r28z2p11cOe7gRykEbHiMNl+sKhR6BqWcRkRkw+KRGAHm+gPqiYBbpvvR64dmZ/ciJeX9zYzx8OCnRFrjbOaOddGBgQaXQIxrUk+9kXxx0V3Nlparm6sUkCGSSz0+PXa8f8g4cQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <937B7F65D6E8BD418555E2A2FD3B4061@namprd07.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 530b56f2-bf01-4dec-b9f7-08d5ca0dc5fb
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530b56f2-bf01-4dec-b9f7-08d5ca0dc5fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 11:24:44.4635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4644
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w54BOt1G007934

The path "spi: cadence: Add usleep_range() for
cdns_spi_fill_tx_fifo()" added a usleep_range() function call,
which cannot be used in atomic context.
However the cdns_spi_fill_tx_fifo() function can be called during
an interrupt which may result in a kernel panic:

BUG: scheduling while atomic: grep/561/0x00010002
Modules linked in:
Preemption disabled at:
[<ffffff800858ea28>] wait_for_common+0x48/0x178
CPU: 0 PID: 561 Comm: grep Not tainted 4.17.0 #1
Hardware name: Cadence CSP (DT)
Call trace:
 dump_backtrace+0x0/0x198
 show_stack+0x14/0x20
 dump_stack+0x8c/0xac
 __schedule_bug+0x6c/0xb8
 __schedule+0x570/0x5d8
 schedule+0x34/0x98
 schedule_hrtimeout_range_clock+0x98/0x110
 schedule_hrtimeout_range+0x10/0x18
 usleep_range+0x64/0x98
 cdns_spi_fill_tx_fifo+0x70/0xb0
 cdns_spi_irq+0xd0/0xe0
 __handle_irq_event_percpu+0x9c/0x128
 handle_irq_event_percpu+0x34/0x88
 handle_irq_event+0x48/0x78
 handle_fasteoi_irq+0xbc/0x1b0
 generic_handle_irq+0x24/0x38
 __handle_domain_irq+0x84/0xf8
 gic_handle_irq+0xc4/0x180

This patch replaces the function call with udelay() which can be
used in an atomic context, like an interrupt.

Signed-off-by: Jan Kotas <jank@cadence.com>
---
 drivers/spi/spi-cadence.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 4a00163..02bd1eb 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -319,7 +319,7 @@ static void cdns_spi_fill_tx_fifo(struct cdns_spi *xspi)
 		 */
 		if (cdns_spi_read(xspi, CDNS_SPI_ISR) &
 		    CDNS_SPI_IXR_TXFULL)
-			usleep_range(10, 20);
+			udelay(10);
 
 		if (xspi->txbuf)
 			cdns_spi_write(xspi, CDNS_SPI_TXD, *xspi->txbuf++);
-- 
1.7.1
