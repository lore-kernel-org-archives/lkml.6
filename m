Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3954714-1521498984-2-1430991335961966269
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521498984; b=ASq1lCVC+4l6+NuChgvpwjtOBFqkKuhpHy4ClYPA1K0v0ay
    Rbhcp8e1cppYQtYQN2sj2xd5cH+RdvXPhlLBZcY49gDUFTIrYP40qZVgjuC2y0eN
    B306N+oRxm7x8kq3/hGdh2qpjn8jjZzHNHazP+SAed7NET7TrMsyDBQot0f0Ymly
    SxvzfV87gnKmIe5qPC8AvO35N0PCKKg6iVpQr+2+I8K0jDcJUl+K9kXPJCOFp0jX
    sJyTWRhN+nbtpxHxxUOEM+Oo6aENutpd1GpvyQefeT4TcMKMeGLHtWQnzgdFvBld
    3GBhzCt4IMEV05++1GLIjdznJwGZF52V9BdgfKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498984; bh=4bWnPN
    a4yFVUteSL1ZlhdBschUOYENQJiaI6KdIUtM8=; b=ZtftlDZgGRMEkvWKvnPWuS
    OdBF5+7Yykiu0n64GBgN3Ig1DFor6mWU29dafRO0ipLrazQU300ONAzb37OjO4vU
    DKFBwHp9BaaVGQEJesYIcztZ+NrhCQ4MMaUk206UHYlqCv1q4unkJmZ67Wprt9Rp
    O8ZMPAd6FG2YiHWgpKhUy6Frymf7jt++ls2J69tfMhuLNmE6sdFHslxzvUjpTxNk
    FUTjrbYaiLDAEC/zlyfuY2lliPIbgpLj1fL9pfNYz2b2p7Nufeov7b+6McXwO3KJ
    1Q/RF3k1C9+Pz0j+RvLYGwjufIyf7d+z3+adu1DRUlBvXSO71Q2ZZpVbCmmkvCFw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CqmUcPG2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeehieenucevlhhushhtvghrufhiiigvpedvje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CqmUcPG2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeehieenucevlhhushhtvghrufhiiigvpedvje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933745AbeCSWcE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:32:04 -0400
Received: from mail-co1nam03on0136.outbound.protection.outlook.com ([104.47.40.136]:48409
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933357AbeCSPsU (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:20 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 044/124] scsi: qla2xxx: Fix NULL pointer
 access for fcport structure
Thread-Topic: [PATCH AUTOSEL for 4.15 044/124] scsi: qla2xxx: Fix NULL pointer
 access for fcport structure
Thread-Index: AQHTv5mfXssIRhhBTEOjiN1YHe81tw==
Date: Mon, 19 Mar 2018 15:47:45 +0000
Message-ID: <20180319154645.11350-44-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:8LhMooiq9tsMNSK7MGOW2QxwVvfv9Uc01EZX/cLWs9cb5xNMfcNQuU+Rk+fI+2gWbw3csfBuMaoxhziwOmiUizuydTUkb2hEJzx/+VPLKNKkhyLAzqiugr+MBTLETshM8fwtmCU9RJZjKWK/8xeQ4oOCQ52CMzOHSwfiJtqgdcu+IcPsCbbmbhm23jw4GiY5i7UFDeKWeAV1Ut+jaBTHWCaXC0WxMBxmHROIQbp5HX7IcOrc/nUQZDSW21dqfd5w;20:OdKscN8eXDsJD5coOHJvDuf4KOmxfuuGjsARHxo7avxvFvf7FP8Gv2K2rK1T3HyVfR5mh1aMTG4gYtJWd33RlnxzSVUCViLrM5N8GTnloaS3BxLTklily10zLZzM+5BmIjc/t2ImS6fhOiuPeyXN1+fzK14YZV2CyV0gUOj9I0k=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: afc713b9-760d-4cc3-b1d4-08d58db0d043
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09987256206978AC94AAE93FFBD40@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(376002)(396003)(346002)(199004)(189003)(3846002)(6116002)(8936002)(6486002)(102836004)(68736007)(6506007)(2900100001)(22452003)(25786009)(3660700001)(7736002)(76176011)(6512007)(72206003)(86362001)(53936002)(8676002)(81156014)(6436002)(81166006)(305945005)(478600001)(99286004)(2950100002)(14454004)(6666003)(10290500003)(186003)(107886003)(2501003)(106356001)(26005)(86612001)(97736004)(5660300001)(10090500001)(110136005)(54906003)(316002)(2906002)(66066001)(105586002)(4326008)(36756003)(3280700002)(1076002)(5250100002)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: +Ms1UKfuVJRT0UfnwpAvOnb0/Tg6JXRF9OBhqU+Tz2Dp+fRZgPZqu7fMny3NjP63t/tAUME9nqQp1P5lus8TG0eZp1m+YGLDp1R/N1XrVan06HDZiJnRypf0xQkK8WB6Ti3d2IcBv9wCzXrMelitxGEwuKP/Y8n9E3gfTfz0oTWar7wpyJqdjIAgBZDsYfDP0vwxUQjzvj/f2flIxlFcGcMCFHRqWeDMOf6hUZkGggOk7jn5Wj5rQm2wAP9pkEF7i/ULaxfwfT8Q7KoVAbymOQ1ty6cQKdGSWcSZ8uD/7YA/kLkfaR2/QMOE21QMK2Ovtv5UCv2KU2CXipyq1Rnbaw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc713b9-760d-4cc3-b1d4-08d58db0d043
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:45.1614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Quinn Tran <quinn.tran@cavium.com>

[ Upstream commit 5c25d451163cab9be80744cbc5448d6b95ab8d1a ]

when processing iocb in a timeout case, driver was trying to log messages
without verifying if the fcport structure could have valid data. This
results in a NULL pointer access.

Fixes: 726b85487067("qla2xxx: Add framework for async fabric discovery")
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/qla2xxx/qla_init.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_ini=
t.c
index 6082389f25c3..7b44a2c68a45 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -102,11 +102,16 @@ qla2x00_async_iocb_timeout(void *data)
 	struct srb_iocb *lio =3D &sp->u.iocb_cmd;
 	struct event_arg ea;
=20
-	ql_dbg(ql_dbg_disc, fcport->vha, 0x2071,
-	    "Async-%s timeout - hdl=3D%x portid=3D%06x %8phC.\n",
-	    sp->name, sp->handle, fcport->d_id.b24, fcport->port_name);
+	if (fcport) {
+		ql_dbg(ql_dbg_disc, fcport->vha, 0x2071,
+		    "Async-%s timeout - hdl=3D%x portid=3D%06x %8phC.\n",
+		    sp->name, sp->handle, fcport->d_id.b24, fcport->port_name);
=20
-	fcport->flags &=3D ~FCF_ASYNC_SENT;
+		fcport->flags &=3D ~FCF_ASYNC_SENT;
+	} else {
+		pr_info("Async-%s timeout - hdl=3D%x.\n",
+		    sp->name, sp->handle);
+	}
=20
 	switch (sp->type) {
 	case SRB_LOGIN_CMD:
--=20
2.14.1
