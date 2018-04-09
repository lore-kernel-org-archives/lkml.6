Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240906-2-6341716210289129346
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523240906; b=e7XFAIVyo3oRsgHUufBRObQAMx87t9bm0Yagfus9ubyt/V5VYy
    1apIu2YYHa6EDkyLqHhNLYqorXC6E+GbBfLSoD5+8vtjCGOV6Ji4w+YgdhHfS8+/
    b9bOFnAtb5sWj4l83ku3Q2zWytYpMUJudYx/4PVjMx3qLLavZ5npB0XWbk8qQeMR
    0FNUKqcevBAfnPmeaChQU1Di8NLDOGL52l+h7BgqVHTZAV4IuR1PojlE9vExL4cI
    0zMDT9CizgxrmNp4gq/YT/tLY9t8Iq5ndNXBs2JmKMdZ2GTcrsSfWetZOsLkFYka
    EkJDGT9ob/ywsmlo3U1uui56BP2q+9qkLWSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240906; bh=IaelpxEt6J
    WFP/M00mTAlbvgGUjlxQeh/Dt5eqIffUo=; b=XItWCEYpDdwDquuEs0C7Ob2qCi
    UjpoL00mErho9/74Omezos9JN7ufwVaBAzuo4Q9bzj4oaxW1AoWFefca6X5s903m
    HtyalauNhDNxvf50fgTFiwRqedhgezVJETQGb457RQjTHtIrvDXSL8F6a4G3+666
    8xMJdR9oF85T+yJkFgz/RP/bUep9A5bUPKcdyfKCMY9iHOGNVWcy2qAvxhfGMjee
    DJjvLl7yoQmr984+PYf2vvSPf1vyjCflN3gaszcIkPjWr/IWXuV/iZo/EIwWhJme
    SFArjRBSiiV+jdX1ghw1CsCUovLBjTdMpFJliucjImoqq+CuOzsnQdVo9w2g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nCXcaYkB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nCXcaYkB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGP2pzODH4PRqxywPLyEJviRsk5jD+mOOwAffP24d4rf+fLKJ2UqhZ1EGJ8WuqxYUPYRz5RkDUmnCWbX2Jg0koY1jeUIQ+VQUErXmO+EtAmHZG6w4Jj5
    2skcPqswy5XD1ytzLFtVk3ZNQ8oqhmj+X6x8sXE9yTjU3/C3F02KNQS6EFtQBSHJm81KOe0gzjdoIOKNDRX4oR07dY+8a1WR4jbhQAbReuNalzSDyGy58RQN
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=QyXUC8HyAAAA:8
    a=yMhMjlubAAAA:8 a=B7bxuzicBWLByr4HpmMA:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756096AbeDIC1x (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:27:53 -0400
Received: from mail-dm3nam03on0110.outbound.protection.outlook.com ([104.47.41.110]:12595
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755897AbeDIA2m (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:42 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Johan Hovold <johan@kernel.org>,
        Vincent Cuissard <cuissard@marvell.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 088/293] NFC: nfcmrvl_uart: fix device-node
 leak during probe
Thread-Topic: [PATCH AUTOSEL for 4.9 088/293] NFC: nfcmrvl_uart: fix
 device-node leak during probe
Thread-Index: AQHTz5kQz/PJRkIusUWM9uQNikuGxA==
Date: Mon, 9 Apr 2018 00:24:03 +0000
Message-ID: <20180409002239.163177-88-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:lIyCTnS2tX+1YEl53+S7TFfJBOi9fZvAs8c3qvqXwhVXr0QFKIrcg7rtuzIDYeIbslJdChqFEWAYpDHU4PRUP08kB6AL8gJMhTA+J5xxJofzmtRn/xNF6hXgjdTycuCEgRX2YwO8vARipUdAQBwCA7uhwZGG/hOW8zEdUht3CbJyulv8sDd/FWhad/uQCUqmJlLwKlb0JEDScZ/UFTGC6HbR/lj+Ra+6VhE/8kNYQnuO8tHVeKaGNPNnt1PMLwqu;20:ySOdqzOeA/elecq+hKAsSS2cPHzzIUa17WOzjfsNlrTdYC4lkzoRUaiy86+ChwFvVG/7kGRwy75L+lfraBezL2S4FmtqCwsQwRYRI/052cr1kvVovSMeyWemyilf0dzu8VAzPV44ByAzI8cSmAtF28qFpQramDCGUlSc1/d4n0c=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: fd069811-d301-4a96-4ca9-08d59db0d54c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08072B9534E7889022D63350FBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(575784001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 9pYidnOYNCZF4/reDhOpRHKM2TbZdn2N+hV7ZGmEfGgGY7WiadE4f6Va9ocHcj0dt6PZ+OIgvsrOA76pyrWJL/3IeSOxKuRbFjwtcjOQTVPHZU3d46bVLDoy+Qm7guhsPqKPcXbM+/CGk98Qilnk7VcM0o74qI8YIOr+JpQBpgVuHsrznIpFXdpgWvtTxoomur4yXlTIvxTkob1UfDiw3X+Ph5nBhBN4K/B9WXLNNQxYdTiZcFp+WmF05K2CdJFrNV0InSOyyAZvureDgvlTmo03us7dkA9nRvy4BEQTbNf3Gy1LR/LPjDXOIVNdXbv19LjT/MpjLbSIYQjx0U6PFIKB00nVqoXACdYaZiqmAL4+SS7GTLmoLZUhVdJY/mjHVPc1m7pLUbMHQR/GQfNAkkrWkJHSoRF9m97/mNQGACU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd069811-d301-4a96-4ca9-08d59db0d54c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:03.2687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Johan Hovold <johan@kernel.org>

[ Upstream commit d0607aa4aee88cb097b694caa619e68f1e0a39c6 ]

Make sure to release the device-node reference when done parsing the
node.

Fixes: e097dc624f78 ("NFC: nfcmrvl: add UART driver")
Cc: Vincent Cuissard <cuissard@marvell.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/nfc/nfcmrvl/uart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nfc/nfcmrvl/uart.c b/drivers/nfc/nfcmrvl/uart.c
index 6c0c301611c4..91162f8e0366 100644
--- a/drivers/nfc/nfcmrvl/uart.c
+++ b/drivers/nfc/nfcmrvl/uart.c
@@ -84,6 +84,7 @@ static int nfcmrvl_uart_parse_dt(struct device_node *node=
,
 	ret =3D nfcmrvl_parse_dt(matched_node, pdata);
 	if (ret < 0) {
 		pr_err("Failed to get generic entries\n");
+		of_node_put(matched_node);
 		return ret;
 	}
=20
@@ -97,6 +98,8 @@ static int nfcmrvl_uart_parse_dt(struct device_node *node=
,
 	else
 		pdata->break_control =3D 0;
=20
+	of_node_put(matched_node);
+
 	return 0;
 }
=20
--=20
2.15.1
