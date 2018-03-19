Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521474946-2-11501136752356916733
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521474945; b=BXGEwDR2aVmbLTmjW4I6tons5UMitkOgMESAEuUea4z4p2m
    V4GWRHMdXbdd0z2xSEtY81a3A4MINf7E6CE4d2hc5R9mxHwnmGmnHpliq8TTRY/g
    ebrwCmULLqYooLshe0anFLcIgyzDbUoTz9JIp5bvOOOM1ubn1ukEHr6fgc4rtEq6
    0QhAr+Dozmjur6sOYMS7DkdJOF+4Juc3cxrCOCNKPvUnF0x+mTg7xXBn7fNadU8V
    dzzF43cH0lAAjpKA0LqfNHFwp2KeODxjKECHKZLPv6WmsR2MpVm+ekRKh0EvIvoU
    WtauymdhHFddrlpk8GDW0NmrGH7zWHqurIoEtGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474945; bh=yEa3sq
    tBmNH/+D1pSQkL2TPaccwva80Hz6EQdmx1NXs=; b=sf9k0/jr4fCOwbz/XE02lf
    oBs1ox5tBbB5qUVHdPR73tjJbKigZGZh08p3kR085N4eUJvoNNTI7RJY/7p9tO0t
    5B4/tgbz3qFpFmvI4xmzmfHAfel22lkfN0412zJrq0gAlnLFLwgeWH2ykgcPKe8R
    2VAbrcqyWYSrHCu+2/jXgeAB2ariKoIhgYUchpxgP0fGinYw3R53wH5a23cvMj/x
    vsBPqhtPPEgxT4ZuxAKm5soWdKCpyo7WUKwbKIDFf4WNCLLxqs54UbdKVEgqZNtL
    qpsA6cZpzKe1auPqG8t+idjm+JPPEBz7JnjPABLc0CEtzkZOv08H4smCm0RI4sOw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VPQSxT0a x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekuddtleenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VPQSxT0a x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekuddtleenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933531AbeCSPzT (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:55:19 -0400
Received: from mail-co1nam03on0099.outbound.protection.outlook.com ([104.47.40.99]:16428
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934334AbeCSPzL (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:11 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 30/97] spi: sh-msiof: Fix timeout failures
 for TX-only DMA transfers
Thread-Topic: [PATCH AUTOSEL for 4.14 30/97] spi: sh-msiof: Fix timeout
 failures for TX-only DMA transfers
Thread-Index: AQHTv5qkZhQEROkaSECqhhjeW6fg1w==
Date: Mon, 19 Mar 2018 15:55:03 +0000
Message-ID: <20180319155411.12348-30-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0982;7:uujXJ2OxhATtYoQqVVh8I/ioEjIG3X8QZnP3FNSwTjxuwx9DL/x+MN0zJcdHBqFGQOyakCr4nTYvQIa5rEBpo4ujFi/xEpHjJIDqOOwnMiLv+9ZwG1N8+VDPxVxnvN1Q8nzHX0SDi8uZpVQSp9srP+xUK28PcA0fXeZnHx7JyrOah2kpc40KYomEPwZ7ZQAS+p9rPchVowl4IVZt7Xv7IuXf2WUws+GU4YfZYyrrTDYKANoPK+fR7JLS/gOypRQw;20:8maDQjuuUKt7dL0XF06/UW4zwVxTtBrZ+k52gKijJk1n/3Up7xW+6Cpg7YcWAibhClq0qUwydJNbkXs3bE+feXZX0HzzXlLC25fMAJXdLjbAkeoRPzZHmqi7UrQOWPFOqiNAP8V7RymdF1eCJZPrXpgPI30ax1JwY/UkgITCxEI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9b21b7a0-1a83-4bc5-7d86-08d58db1c777
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0982;
x-ms-traffictypediagnostic: DM5PR2101MB0982:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0982D288E227EAC754F2B0A6FBD40@DM5PR2101MB0982.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0982;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0982;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(1076002)(106356001)(316002)(36756003)(76176011)(8936002)(81156014)(81166006)(22452003)(8676002)(3660700001)(59450400001)(2906002)(2900100001)(97736004)(305945005)(7736002)(53936002)(3280700002)(5660300001)(99286004)(107886003)(2501003)(5250100002)(2950100002)(10290500003)(25786009)(72206003)(3846002)(478600001)(54906003)(6116002)(4326008)(105586002)(14454004)(110136005)(6512007)(6506007)(10090500001)(102836004)(66066001)(68736007)(186003)(86612001)(6486002)(26005)(6436002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0982;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: bIrou1q/JoH1gZqlFchz7lGWltTUk/PEfzyY8HlET8ieIBBINAHF1fLgYeAEUYe8UvkqdGlCMJe6R6TXqZ+65vO2isst8R5nmMycd0lpAmELYm8KxykZAxftf8rDfURKdAL3mavSBeHCjbe+urr6Ee/ay3feJkvkRjpaYTi3J1cMnKg9LSdF9kNtlF9eBq/OtKk5O0FgxbSSt1QzNKa1+4mjFuiyPB7vPCTYXB4Pk9uMezbWddZOs+uWKDrH1WkrLOuCLhO+kQe4DwYnmN40WcyXll5JiM31XqYDk40+mWVcSagWvDhuK0tFpgU/VO1xe1w8riKsDl/0anGcOBa2Ow==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b21b7a0-1a83-4bc5-7d86-08d58db1c777
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:03.6706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0982
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 89434c3c35081439627baa2225622d5bd12242fe ]

When using RX (with or without TX), the DMA interrupt triggers
completion when the RX FIFO has been emptied, i.e. after the full
transfer has finished.

However, when using TX without RX, the DMA interrupt triggers completion
as soon as the DMA engine has filled the TX FIFO, i.e. before the full
transfer has finished.  Then sh_msiof_modify_ctr_wait() will spin until
the transfer has really finished and the TFSE bit is cleared, for at
most 1 ms.  For slow speeds and/or large transfers, this may cause
timeouts and transfer failures:

    spi_sh_msiof e6e10000.spi: failed to shut down hardware
    74x164 spi2.0: SPI transfer failed: -110
    spi_master spi2: failed to transfer one message from queue
    74x164 spi2.0: Failed writing: -110

Fix this by waiting explicitly until the TX FIFO has been emptied.

Based on a patch in the BSP by Hiromitsu Yamasaki.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/spi/spi-sh-msiof.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 837bb95eea62..ddd4cf4baee7 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -784,11 +784,21 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv=
 *p, const void *tx,
 		goto stop_dma;
 	}
=20
-	/* wait for tx fifo to be emptied / rx fifo to be filled */
+	/* wait for tx/rx DMA completion */
 	ret =3D sh_msiof_wait_for_completion(p);
 	if (ret)
 		goto stop_reset;
=20
+	if (!rx) {
+		reinit_completion(&p->done);
+		sh_msiof_write(p, IER, IER_TEOFE);
+
+		/* wait for tx fifo to be emptied */
+		ret =3D sh_msiof_wait_for_completion(p);
+		if (ret)
+			goto stop_reset;
+	}
+
 	/* clear status bits */
 	sh_msiof_reset_str(p);
=20
--=20
2.14.1
