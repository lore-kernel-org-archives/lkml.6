Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122441-1523246717-2-14438079322698804568
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523246717; b=egTtDI9ki3R4JxEbYfanhvkdmfLxGhFR6z+ZM9OkHgNwSS0JJx
    mdmja/Jp9CkZRlHC/ZHz1M+Mmbze+/ZiMVvDHdnnt07UKW8gbDTJFi1uwzT0xPGk
    SD+n29TfS961wkvdttGGi6At0sjcCT00aQf74uO9BkTyBE3RWyVPNtl8/uprUPAR
    6YzQrFhI7FoOdEFVaJZwA3dJaY/nlfhji2vY6vHpxgBRTHy0+4CEcON66E8YHUer
    uu4Bms7WIcxJWFLsMvOpgFomAybZUSFtBVJnlplLHTJ21Ub7o6zd0ajsT/lASzBp
    o0Nj2Cy98JqcBItTalsjuC5FGCLMY+daK+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246717; bh=YAIqU376av
    Gt5rApDYNSLCe3US6Ay6S8lfSTNoEYNt0=; b=VLBYNHR9yRPpFL9Tq9QULjp5ra
    xgBb0JbVBGwOJYATVBCUONxkIFUMu9Tb07Dq59JaB1NdlwFbpLDgbdmcR+pfMZwB
    1BjGJKgsajxpDObfClWtxxt9wzk7HEF31+e+Ebb8jpc7RR9izbTHiUUmXRdnPP1R
    PluW4UgwndqxuqTw6pnbnb4kz3gxuFQMUdSfbOBz3/2qMuikvIIPCfplgnuYn4GW
    Y3wiVOunxlYECEZdmNLE+DmvytIXIKcj8Q+r6RfQnqZkp/L1eOreeAzCPixDSwa6
    b52NIpiRD96fdzv7Z4yQvksvqTh8wGSFo429qU14ns41bkl5EWG/a9oSIrfQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oKYe06wB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oKYe06wB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNFJQeNfeXre3IiP/k7Rd43D+uNJFvENFpQid9yjgIPt10zFuxh8Sx9XrThJqPH+my4aH5ZCDDcdKV/p288mQO/kCKWgyzRd9rl9X12vcUo5MbJcgYn8
    DZIshmFdgzoOiCW3uys44CVVvfJtIuggY8ZLw5kH2+BVyDItNukLd9HaNZhT0ETiw7fW9rKzkHIzViIaI12MvIrfKKsZDf4BI1C9VofVGfaOTCNp+aWLHoJp
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=HsNsRZ5Jv7CSo935JNUA:9
    a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754140AbeDIEFL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:05:11 -0400
Received: from mail-bl2nam02on0131.outbound.protection.outlook.com ([104.47.38.131]:5451
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753268AbeDIARy (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Maxime Chevallier <maxime.chevallier@smile.fr>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 043/189] spi: a3700: Clear DATA_OUT when
 performing a read
Thread-Topic: [PATCH AUTOSEL for 4.15 043/189] spi: a3700: Clear DATA_OUT when
 performing a read
Thread-Index: AQHTz5gfnlxVEAkmv0idypDJRGiFew==
Date: Mon, 9 Apr 2018 00:17:19 +0000
Message-ID: <20180409001637.162453-43-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:3LJ/ELOB1ZtafgNLb56qVj/SG3L9A8mGoadqlJzZWPYjiF1jA3Ycf6SmgFm8GE3gvvrGqJXtAqNTJErhHD3QAOo9Cdh/3beuVsKD4ZFDP8k9MEmfdXXXc2IfTopV5YMmxkcaT+p46wv+2fdGYDqXeUCSCyu196zJNRo2U8YWqm8NtkpxFr05vv23SZ76/hIEtEywus+lL7fYFvu4mYIEC7pg985jvVnxJLwMlEND0oj2plYAgbNxqZ0nxod7R4uL;20:zdZfVqlLF4ri6NrCUr0b5fKvVOIXA8yXfZL1q2yqNbFGdEDd5iBvHEHSkXf+L3pH8qE8BFb6NJyiXX3lrgf3N4+spohEqzcOJikNI2CtIArueCewLDC1/KklPQv+y1ErCoaQfnt8rCHwhGqsgQiJc681ZBsHFuaTUMaeFFJD2xM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97138065-cbfc-44f6-06cf-08d59daf528f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB104898D23F74A6471FEEFD76FBBF0@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(346002)(396003)(189003)(199004)(86362001)(1076002)(575784001)(99286004)(6116002)(110136005)(3846002)(54906003)(22452003)(3280700002)(105586002)(2906002)(76176011)(4326008)(6512007)(6436002)(6486002)(3660700001)(6666003)(7736002)(86612001)(25786009)(2900100001)(14454004)(97736004)(53936002)(107886003)(68736007)(102836004)(36756003)(6506007)(26005)(186003)(106356001)(305945005)(5250100002)(72206003)(478600001)(2501003)(10290500003)(81166006)(5660300001)(8676002)(66066001)(316002)(81156014)(2616005)(10090500001)(11346002)(446003)(476003)(8936002)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: /0OMsk47N5fq4ubppgVyeqQ/zlAhAOdX+0Wvd7NIo/M7cfH0wiLUGNXoMrom1FxAgd8RpLhnQ2U60Pkb0FtLcUcRqjfB3qePcWCCnHNBxgXU1tcsXOg8YrRNGwJTbk3fNEHb7zKa4QiuJWV+fCDe1iIs2ITzrK3p8wYwqL4UmBozzhqQ0jH1BDCrh7Qwz8ZuyDmmpo1Q2k8g4SZeuXk0JasHe7S6nt1XPdGw133e2RntFq5E4OA6JhOz+O9POFODpbDEnJxQwnj1NTRtOLUpSe1diqfSJR+PUCbkrdTCnY18ElH/5iiNTptwQw+/VCrLV4EHaLPWvy7QmEgPt9P53zu6Nw6fVo2di+cNmbF9HSEkGFHFqvo0shyxoGlZtP0UeubKekXvT9NDiwYTo61mKh3F4PlKwmrwBHmjmzUlCiM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97138065-cbfc-44f6-06cf-08d59daf528f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:19.9792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Maxime Chevallier <maxime.chevallier@smile.fr>

[ Upstream commit 44a5f423e70374e5b42cecd85e78f2d79334e0f2 ]

When performing a read using FIFO mode, the spi controller shifts out
the last 2 bytes that were written in a previous transfer on MOSI.

This undocumented behaviour can cause devices to misinterpret the
transfer, so we explicitly clear the WFIFO before each read.

This behaviour was noticed on EspressoBin.

Signed-off-by: Maxime Chevallier <maxime.chevallier@smile.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/spi/spi-armada-3700.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index d65345312527..c11ea6c169a4 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -615,6 +615,11 @@ static int a3700_spi_transfer_one(struct spi_master *m=
aster,
 	a3700_spi_header_set(a3700_spi);
=20
 	if (xfer->rx_buf) {
+		/* Clear WFIFO, since it's last 2 bytes are shifted out during
+		 * a read operation
+		 */
+		spireg_write(a3700_spi, A3700_SPI_DATA_OUT_REG, 0);
+
 		/* Set read data length */
 		spireg_write(a3700_spi, A3700_SPI_IF_DIN_CNT_REG,
 			     a3700_spi->buf_len);
--=20
2.15.1
