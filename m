Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520116269-2-6766461215301812865
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
    t=1520116268; b=mMoZD8kWPsA99kqwmjTjAafpeXEu3ZWuIL+YCkwPFcVPLuf
    y0ZQscTq+/n7gXMuNn2LqG2Jx0WNMJg9eEviZl5waz3mC1HjGMSgG3QtJ/AnZxMB
    E5wwty8/C+JGg/qt8W2Yk1plH0j+A8FNooDROUrs3f07gpX3kIpE/f/TW7zrRnVY
    1orYlaE0GGknMx91MjKVGKtsoCr+PAtlOe/DqD2WZgWiNGc4yjqaFhw0jSczKHrI
    CZNB6AyYYMk1YGQTcgzCkqjWALBMd1QLLtkPyYSBGyxssyxXUPdMTFIpfavbuVMc
    oXLhi3QUKSMVHIAvlLdwv1uHPdbst5kM/ql1Z2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116268; bh=6uTnpf
    TwI8fHYqxLPRBuLz/4ZA+16reVUcXJWUpw1Gs=; b=gaThFc8KNn10k9Gng2K9X9
    Vs9a59bWtq7MgQ6d5LPAn5rgXPNAQBbahKNACpNLV51tV4AHv+1TBs/2s5YYnIPq
    njeFFuK7hd6sWNNUfunMelF4BNmVlmQqKTNiusR7SrvBU8VFYwSFVcoawWkgsi2G
    7OdeyckMdtRp5M5maRLpIm+y1/DTnQCkp8GKctkgfq1oU1vuAvqNf3AqGSqWq3QM
    JRVdnN6ifuubXdlG5lWVHB6LpbJe5j2UhjhqiMqlkyCGhKEd0dNW2S2eigk2YsQA
    GCvfch3BR0v8AB56Kfg39pJEfX2VjFUNR9Gg8Xh9bbTdtA07+yNsRmW0g+xiJQ+A
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dckcjG7Y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dckcjG7Y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933531AbeCCWa4 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:30:56 -0500
Received: from mail-by2nam01on0117.outbound.protection.outlook.com ([104.47.34.117]:32496
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933530AbeCCWay (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:54 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 77/84] mmc: mmc_test: Ensure command queue is
 disabled for testing
Thread-Topic: [PATCH AUTOSEL for 4.14 77/84] mmc: mmc_test: Ensure command
 queue is disabled for testing
Thread-Index: AQHTsz62xUrvHSKzIEKZUaZzouIlHg==
Date: Sat, 3 Mar 2018 22:26:45 +0000
Message-ID: <20180303222518.26271-77-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;7:hzgCTRll7wNYdGQMqGkG5tCZzHNJQ8T1l1p34lUSWmzejcYzS7VuUfrEgxioLcF7exIrZN3e2V3eBYt9IENQLLdjLP2cQWaG53i9W4ylFnHYC8M6Brd382gUPS+CKTwWoBqA/Jshkgsx3ofg+enQW8vDE0PJE6Rq3iwmW/msLVPN56Wsy9/v/iibTk9S5NVJCCJDeYXbv4JytDc8ooRojq2XZpz5zuQnWbS5rzBC0Oz5hlFGWOnwrocgh/ezWAC9
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 734b0bf2-3410-44d8-55bc-08d581566b10
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1115075C98350FC129309490FBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(59450400001)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 5ikEoHYTROAKgENLx9d+WEHj67Bo+NMpuH2iMD/FN7xkccC8V2/QaOEmsbpEkIw0ZXg5d1vvr1LD1yauIy2cWnxKio+vLA7JNqVHnxTnj3MoE5h5lEKfJWxO6J64QipVTTfWKxRlQxGlVx04As8o8U4XQPHTljD2WyDR3hgwbsY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734b0bf2-3410-44d8-55bc-08d581566b10
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:45.2911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
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
