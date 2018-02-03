Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682041-2-11996611876282643061
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682040; b=nkjtXCP5dyM1bzmolhBTraF6Vw6NxGLNvc0Dty1nS8UIgwi
    7DIfI6PXDBQx1KA5LeXY39aT56rIm+QDFpfUrUyVGVb6P76TFFgEi1GI3meXzs9U
    r6OLqCYFlixXHO45tJ1yDrNwllElKfOQPezF6djo2yD+y9w+peJr2/yzeOzFbQl8
    0FLYImKm5UoEz/6CAstqe/uhP5w9iXc4xAqAf+ve5T67jWLkCfLxWy0nj5jzA3N6
    GQooyCHdu7b6/cyMMwvvZeGIRBYOliCDDeQKFKTGRwnn/gBKZYCwfmbRh2FlzJjz
    GVYziroHCRaZQTwNxSzhHwzjfVZT9nrf+yiIUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682040; bh=p2G35H
    uqmIMy5hdGXTVbZZ1Rfn1dWFEhBIgGljkBX6k=; b=wEHxKQLrMV8NVTjIrFzKqP
    uJcSPNEsS0n6jCaHT7wNQgXfCQZB/b9vTaOlFxFrDq5C0KZ1iKNGqNiDTboKRyJj
    ujnjRZ6ot24KcQ+Gk/l1+Ju58481iGgjrwrEPJF45IfNhxSq7p4lR0sfjlKn0EBF
    TA73AvS9CklsqnQQmwckN+MigHk/ui9f1kRzcz6oT+xRa4X6Sfcw2wYjESdZkVGc
    bGO02aiTa6+DiqCVHG87WV2nHryFFmJhNoMkgGMi/LFBncWlQy9fhB84EsIgpofX
    UTlU2KK4kUwfXCfFN2XplDyYER6BaRpA14kBDFX+/riWtWRW3VKa3Wsok/N3ESEA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Mpd9524h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Mpd9524h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754208AbeBCSUa (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:20:30 -0500
Received: from mail-bl2nam02on0091.outbound.protection.outlook.com ([104.47.38.91]:45338
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753478AbeBCSGl (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:41 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Radu Pirea <radu.pirea@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 05/24] spi: atmel: fixed spin_lock usage
 inside atmel_spi_remove
Thread-Topic: [PATCH AUTOSEL for 3.18 05/24] spi: atmel: fixed spin_lock usage
 inside atmel_spi_remove
Thread-Index: AQHTnRmBGGGEUo0PcEi2fzeYvv+a2A==
Date: Sat, 3 Feb 2018 18:05:00 +0000
Message-ID: <20180203180444.10801-5-alexander.levin@microsoft.com>
References: <20180203180444.10801-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180444.10801-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:jRM5x/mQfitb/S7AflCHO+m7WuDw49VzoFaPBZV8nzVeYpOQW/bTbLrHz9i6RilmU5f8dQ4HzrM7MnO9g6Z0kvZh+o80T2KxbGUIEbJzT0dOARe/Y3/1kHPXdys9Q6WPSDB78nKlCtGePZylzbm0rAIECCK771jsrz/8nF65mgRbgTXrCS4/Z16LZi5/4HQH/FG+TSB1hfQry2utKoxsUxxCRqohNQYgYZZNaVr77PZYEP7pT5wFIMdcDxfptK1X
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4143cc63-72ff-4c64-2910-08d56b30cb87
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB09936EC7F430EAB62ABCF1E8FBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(6666003)(81156014)(86362001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(59450400001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: Fb8dOwFDhcRa4KGumoSXh1d4LrlTLGMUsIzGf6mzhJnx9L4wjXYZdjPdQSP9759DPYIYSincI6fuKb8U+1soTw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4143cc63-72ff-4c64-2910-08d56b30cb87
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:05:00.0808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Radu Pirea <radu.pirea@microchip.com>

[ Upstream commit 66e900a3d225575c8b48b59ae1fe74bb6e5a65cc ]

The only part of atmel_spi_remove which needs to be atomic is hardware
reset.

atmel_spi_stop_dma calls dma_terminate_all and this needs interrupts
enabled.
atmel_spi_release_dma calls dma_release_channel and dma_release_channel
locks a mutex inside of spin_lock.

So the call of these functions can't be inside a spin_lock.

Reported-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/spi/spi-atmel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 4bf337aa4fd5..fab124d3b8a6 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1416,12 +1416,12 @@ static int atmel_spi_remove(struct platform_device =
*pdev)
 	struct atmel_spi	*as =3D spi_master_get_devdata(master);
=20
 	/* reset the hardware and block queue progress */
-	spin_lock_irq(&as->lock);
 	if (as->use_dma) {
 		atmel_spi_stop_dma(as);
 		atmel_spi_release_dma(as);
 	}
=20
+	spin_lock_irq(&as->lock);
 	spi_writel(as, CR, SPI_BIT(SWRST));
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
 	spi_readl(as, SR);
--=20
2.11.0
