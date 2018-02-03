Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682495-2-4275964215905623925
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
    t=1517682494; b=omFnK+lYjFOoLJLUsZ8a4xwt5+6g+lLhtLqGNc9+dWhtIPt
    sKpSIfUqtdlHTX1YRphliKUMhb8uRxtmvgYDMXS2SuNgT4nNhdtxx0y5ymeH8qTF
    YMTLeifxNCmvftLiAsp5TJ5aDkRjKcdGgy2yOX+EK97HtF+lp2LfHgL7T7UlihuA
    78MFtBQPLxkoxbKi6Tr6U4BdZzT93oj+4IxORBUA5tgGn4+gCK5HuXqDUyZTQH1I
    znqcNCdnqtBd6tlHVuWM+ZtKJ1sgB6gngDtrtok1PSCIgdIXlloN0/Rcjbt9s17O
    m6JJKWGSKXaEiByt+a4EC+8g4XgarCraUkjOwHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682494; bh=W6178P
    6Km+jbTnngNGKvNpUl0A/NoJi9cyrNcr6AQCI=; b=GLYRxxyY8xdYX5sxTCF5xf
    FT+EWBVVCnGTbV7cbZ2a2IAasv08kxSXX3y02TElweK2oBBiUGeNd8tZO8uvAQe+
    pUdUTquouXie5/s1jC1u0rACV4yxHllwO4RlWheyDLQgsE9yE3bmf3OZuC5IGM+R
    wvQgZ2otyNHOmRPkVeom63Ky2ssCP1jOpddasUGwYeYrBGrd96U7MJJKuRkkP6IM
    ZKUIk3Hc//0dh0ZoA91MdyktoC+EpPEucMQPIkMCNRkzrmrZPTgK8/XF6dt0nZVs
    S/CKZdRg1YCxYqJF/xtPIYMHKvpA/bnLC7j/9840JQgwZueMdoEhcLs9jgOe8zUQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cwBMnZuQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cwBMnZuQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754610AbeBCS2N (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:28:13 -0500
Received: from mail-bl2nam02on0139.outbound.protection.outlook.com ([104.47.38.139]:53600
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752995AbeBCSFA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stefan Haberland <sth@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 31/52] s390/dasd: fix wrongly assigned
 configuration data
Thread-Topic: [PATCH AUTOSEL for 4.9 31/52] s390/dasd: fix wrongly assigned
 configuration data
Thread-Index: AQHTnRlYQNuzwgYBLkOrlfN37baz0A==
Date: Sat, 3 Feb 2018 18:03:50 +0000
Message-ID: <20180203180303.8490-31-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1012;7:CctWy9oVI5lq9lcd+0/V31+RBaEojhAKIM4J/1UY9XWVFsttQz0y5SaSZeXZAIgT/xuc44HyyMesYyK28ywIqQJ2QWZD5Sl6vPZuL8aLqXbiMgXMRxMTAaZD7BwzUbXyVtVagWIayyq5Qvh99lweLpNzlK18AVOLpmzvoo0uZ9QiO0b592LKSEVerUQ+uNCMD91r7UPwMqoFGH9ylVC6yprLTRPtUtPiDakKtRWP6qRqFb/oo2d7ZNRTT7+fpPR2
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a5f23222-8f2d-4be5-e019-08d56b308d06
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1012;
x-ms-traffictypediagnostic: BL0PR2101MB1012:
x-microsoft-antispam-prvs: <BL0PR2101MB1012A070AFB6552D260D6810FBF80@BL0PR2101MB1012.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1012;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1012;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(39380400002)(199004)(189003)(316002)(26005)(54906003)(10290500003)(6512007)(6666003)(2900100001)(106356001)(2950100002)(76176011)(86612001)(86362001)(81166006)(8936002)(6346003)(81156014)(107886003)(102836004)(4326008)(25786009)(110136005)(97736004)(22452003)(59450400001)(6506007)(53936002)(8676002)(5250100002)(6436002)(1076002)(186003)(2501003)(66066001)(6486002)(6116002)(7736002)(36756003)(2906002)(10090500001)(99286004)(72206003)(305945005)(105586002)(3846002)(3660700001)(478600001)(68736007)(14454004)(5660300001)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1012;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: aWkkS5V766uoOKfhbDuSPXxacIQb8fHZyWFkql/OPcqu4OzdSrWkM3Lxanj17VeYRqcmb69ADO0EuNNEsJ2FIQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f23222-8f2d-4be5-e019-08d56b308d06
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:50.9558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1012
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Stefan Haberland <sth@linux.vnet.ibm.com>

[ Upstream commit 8a9bd4f8ebc6800bfc0596e28631ff6809a2f615 ]

We store per path and per device configuration data to identify the
path or device correctly. The per path configuration data might get
mixed up if the original request gets into error recovery and is
started with a random path mask.

This would lead to a wrong identification of a path in case of a CUIR
event for example.

Fix by copying the path mask from the original request to the error
recovery request in case it is a path verification request.

Signed-off-by: Stefan Haberland <sth@linux.vnet.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/s390/block/dasd_3990_erp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3=
990_erp.c
index 8305ab688d57..a20dc2940d2d 100644
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -2755,6 +2755,16 @@ dasd_3990_erp_action(struct dasd_ccw_req * cqr)
 		erp =3D dasd_3990_erp_handle_match_erp(cqr, erp);
 	}
=20
+
+	/*
+	 * For path verification work we need to stick with the path that was
+	 * originally chosen so that the per path configuration data is
+	 * assigned correctly.
+	 */
+	if (test_bit(DASD_CQR_VERIFY_PATH, &erp->flags) && cqr->lpm) {
+		erp->lpm =3D cqr->lpm;
+	}
+
 	if (device->features & DASD_FEATURE_ERPLOG) {
 		/* print current erp_chain */
 		dev_err(&device->cdev->dev,
--=20
2.11.0
