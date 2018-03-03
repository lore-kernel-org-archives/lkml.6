Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520121784-2-16352643398501110561
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520121784; b=Hnb4SnIwHiBcFCpkbEPtLsEXTfaYS/7eKTdRO8CaVuzNSKS
    iD1Qsn6+5d6Bivc2FF6cR2Aosa3lNJGFWw3RAfvdm0MEYExf/imI/Cg1a7T3BxWY
    lLiPY/umH+Eo5dnk4C7uN6r4bxb8QXWO7yyUm931WFHtHmAE07a7xoRWlw9tAb7/
    aRwhVn7HQt+H4MptCb+jgLGnsoIqlbPziRYQbnBn1orWZwt4wrZDwiY4kjQziBk5
    Om8G3xpUQfF8tXcLhame9Q3f/2B2O8hlbpJroohlHtRQT1Pu1Y3+sEX1sJW42Mgd
    zxFnEmARV15tHGgVL/kJ4aEVRVuQaXhK5+rf67w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121784; bh=ZGGXvV
    Ajl3g8/QUQk3e1DvaAg59WJD1mBMzedmN5CSw=; b=OMIzw9pcjWyFvGFuYoLiSh
    RL3egSb72mPyyngTqh/Q2jECezgn5CUUiUeZZrlLFFgJFJwhpf5zWQGjRAe2fCNX
    hM0ZauH2ooT5kqpTgVnp8h04zvM/Jg7JHaOTx3xkTMEJ0pizmCd8KFZe4AqVP/1Y
    Flq5whC5/lqcHSQbzt9tnVwlEeK7ERSBmhFrNBVMTkM35hrKYUtoPmU2+w5PsDQw
    9jRb2zF67++B0b5Vux2yj056o9IIsayMO22fhcYYpCS5xxL/lGTNmN+hwhU6fbNe
    34coF3BKlzmHChoPAxjzadqYfnd5GLQKC5XACOJbz3FN57Mm/Pz8ptPG14cOWegg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PoGeZ7/T x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PoGeZ7/T x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932459AbeCDADA (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:03:00 -0500
Received: from mail-co1nam03on0109.outbound.protection.outlook.com ([104.47.40.109]:6764
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932852AbeCCWb5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:31:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Quan Nguyen <qnguyen@apm.com>,
        Iyappan Subramanian <isubramanian@apm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 032/219] drivers: net: xgene: Fix wrong
 logical operation
Thread-Topic: [PATCH AUTOSEL for 4.9 032/219] drivers: net: xgene: Fix wrong
 logical operation
Thread-Index: AQHTsz7rRcsrP6bRMEys91Uit55uHg==
Date: Sat, 3 Mar 2018 22:28:14 +0000
Message-ID: <20180303222716.26640-32-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1083;7:VX/FaBTe9fhF8uh1J4/RL9WbVDuYRu7OMU47r0wstfkeJLE7XRW9saCM3BZUGkE15k1UGOAlAj5RCXBKD0cPVXza4Knh8y1TvMuobWCbkhc47icPZ0/eGIcptYwoQaLD1jNPxdxvZut0maFmqKdHV2qfW03AgLtdHDPCAAzKJAkHiHP8VWf3HUpUWnTK/bP130S0zsECHsT6pM1E2A+xTolS9ZaPXl3+lQEtWAkk7E3RU3QM/KC5oo9LVj2EW3bW
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58d7085d-bbf1-431c-9787-08d58156916a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1083;
x-ms-traffictypediagnostic: MW2PR2101MB1083:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB108321A50AFF6B86CE0D2E05FBC40@MW2PR2101MB1083.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1083;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1083;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(106356001)(53936002)(316002)(305945005)(7736002)(3280700002)(107886003)(2906002)(6512007)(6436002)(97736004)(3660700001)(6486002)(99286004)(81166006)(8936002)(81156014)(76176011)(8676002)(25786009)(2950100002)(6506007)(4326008)(110136005)(5250100002)(54906003)(36756003)(575784001)(105586002)(6116002)(6666003)(22452003)(86612001)(10090500001)(186003)(68736007)(26005)(2900100001)(86362001)(66066001)(102836004)(3846002)(14454004)(478600001)(72206003)(10290500003)(5660300001)(1076002)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1083;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Y5gaNdABjIXjYM8k87x2kIN7fWtE0MOMTo4P5GEclhiMLjSJe5KS6rXsG1HspHNdN+Lz4fXRmdxa6VodRfRwL2wTvJIgFIYjTdYvwe3ntAvu4Y8fklAULC0KIgH6/QXiQR6vTg0kdojVcCuq0GpfdDBfLwgBAllTHObWADmX8VQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d7085d-bbf1-431c-9787-08d58156916a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:14.2600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1083
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Quan Nguyen <qnguyen@apm.com>

[ Upstream commit 11623fce0f9afef30c45e3f2120b063de3809a8f ]

This patch fixes the wrong logical OR operation by changing it to
bit-wise OR operation.

Fixes: 3bb502f83080 ("drivers: net: xgene: fix statistics counters race con=
dition")
Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Signed-off-by: Quan Nguyen <qnguyen@apm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c b/drivers/net=
/ethernet/apm/xgene/xgene_enet_main.c
index 8158d4698734..de1546a63a7f 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
@@ -537,9 +537,9 @@ static int xgene_enet_rx_frame(struct xgene_enet_desc_r=
ing *rx_ring,
 	buf_pool->rx_skb[skb_index] =3D NULL;
=20
 	/* checking for error */
-	status =3D (GET_VAL(ELERR, le64_to_cpu(raw_desc->m0)) << LERR_LEN) ||
+	status =3D (GET_VAL(ELERR, le64_to_cpu(raw_desc->m0)) << LERR_LEN) |
 		  GET_VAL(LERR, le64_to_cpu(raw_desc->m0));
-	if (unlikely(status > 2)) {
+	if (unlikely(status)) {
 		dev_kfree_skb_any(skb);
 		xgene_enet_parse_error(rx_ring, netdev_priv(rx_ring->ndev),
 				       status);
--=20
2.14.1
