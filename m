Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123494-3-4163334229851338435
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520123493; b=OlEPk2KDNpV9pQnlLJDrIxeuORcr5iTVRFu7DbtqtKllPeq
    clPgfO+kYE4EjavNQRzvk15fIi49RqdEdjbqAjBsGJCnhe4P8I75KY/uP1n8HkoD
    YGET2XHI/mRqdkXVjQOEQ/+wsVyrTcuiqYA7VU7+fhLQ8n+bhawb9q6q0qVNIv4C
    Jkm/UxmaOoj3tv7U4PiUmUBaIu9RIB7LgF7sCLyicZukikl15XC/6PNJ8fRl95ym
    bQu0mIAD0Qozcowm9Aej4RVCuY4DGEv3+rtsHQYWFlrweMXysyyYSm62LefJOELR
    Q97b6wZ84G4jLAryNtyoNUw5kgehxCST4SCoyWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123493; bh=6uTnpf
    TwI8fHYqxLPRBuLz/4ZA+16reVUcXJWUpw1Gs=; b=c8tp2havumpPH6CflepPJk
    8fgSRETmQs5LsmyFhIG3+J7Ep5kIc/oHyy1q4yo4+iFybvLWg4ad6jRJCFP/bMEi
    IbhshWEpw7kX9H/t/dXQmRU8ZqcRCJdHU6vgFHsZQZa1UdX4BeKixrJplg2uq4/s
    b3YAkkZw0vLIxU9iczyBMN1ABgEiO5gqf2xqOpg7+ZTnXdRjxyL3iilsIaqW35n7
    v1ZW0kMrItfMTuxNdVkB5txUNQtAI/8KUTr87c56E2W4h+C1VVUyff5CwktzrgPp
    nlbLMMnHmOb2vr7iH7rjom1lPpHNLCoVICbU2u84cegD69m3Wr7nrduVFCNQhNJQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q3ujEJgY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q3ujEJgY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933081AbeCDAbP (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:31:15 -0500
Received: from mail-by2nam01on0124.outbound.protection.outlook.com ([104.47.34.124]:45281
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933031AbeCCW1y (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:27:54 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 095/102] mmc: mmc_test: Ensure command queue
 is disabled for testing
Thread-Topic: [PATCH AUTOSEL for 4.15 095/102] mmc: mmc_test: Ensure command
 queue is disabled for testing
Thread-Index: AQHTsz56W/P+5is5S0KDA1VvkOmH6A==
Date: Sat, 3 Mar 2018 22:25:04 +0000
Message-ID: <20180303222318.26006-95-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:lTYTi809jvyobFPtwrAP+cAJqCcTek7aGobvGt6e26s9WcZ8do5nkIxBdyBnH6Mn+A15ZVqdk4DB+VawoYGX/903fMFgSvs+zXHJ09PeaGYHQLUmm1ANPVH64qddkuUIPuVZtti96et5je11qlC0tVdxGmGTW4P0FbJ5ozIxiOybOUnuOQxnbQuI9W+HL5vo/CW41UwJG6sjZD5gvWHevCMJNftwBtAtRITSQBodCxB+j+MbQsz9Jkcy0iMHgBaI
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4b9081aa-c31a-483c-e5ca-08d581560095
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB069F288CF70711188C0F15FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(68736007)(2900100001)(97736004)(107886003)(36756003)(1076002)(76176011)(86612001)(6666003)(6116002)(99286004)(22452003)(10090500001)(3280700002)(105586002)(2950100002)(3846002)(26005)(2501003)(6506007)(4326008)(305945005)(25786009)(7736002)(66066001)(54906003)(86362001)(8936002)(72206003)(3660700001)(6512007)(110136005)(14454004)(5660300001)(5250100002)(478600001)(102836004)(106356001)(8676002)(81166006)(6486002)(186003)(316002)(10290500003)(53936002)(6436002)(59450400001)(2906002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ukcoH8TKlEN/5ONSQEkmMEVueilRn3A4S2Gd1PF4i2dIUhkWiZWrEVKH48FYRvbYGcvpkQ088sdErnzHa3xlSCCqEfPibe2O01GIW+nfxSCZXS4I4nB32x7ELRcYPf2Cqquy9lIo4aA43p1dnrCE9+2f1VhwKFxRVv0l2Hao1r0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9081aa-c31a-483c-e5ca-08d581560095
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:25:04.7441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 23a185254ace8e63dc4ca36e0315aed9440ae749 ]

mmc_test disables the command queue because none of the tests use the
command queue. However the Reset Test will re-enable it, so disable it in
that case too.

Fixes: 9d4579a85c84 ("mmc: mmc_test: Disable Command Queue while mmc_test i=
s used")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mmc/core/mmc_test.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 478869805b96..789afef66fce 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -2328,10 +2328,17 @@ static int mmc_test_reset(struct mmc_test_card *tes=
t)
 	int err;
=20
 	err =3D mmc_hw_reset(host);
-	if (!err)
+	if (!err) {
+		/*
+		 * Reset will re-enable the card's command queue, but tests
+		 * expect it to be disabled.
+		 */
+		if (card->ext_csd.cmdq_en)
+			mmc_cmdq_disable(card);
 		return RESULT_OK;
-	else if (err =3D=3D -EOPNOTSUPP)
+	} else if (err =3D=3D -EOPNOTSUPP) {
 		return RESULT_UNSUP_HOST;
+	}
=20
 	return RESULT_FAIL;
 }
--=20
2.14.1
