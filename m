Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64540C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B38C20840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kjRR/Gkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B38C20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbeJAHTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:19:53 -0400
Received: from mail-by2nam03on0136.outbound.protection.outlook.com ([104.47.42.136]:2896
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729094AbeJAHQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUAkZTAd6/NIz1ApCQbABIVrUptrscK+AR54Mk3C7u8=;
 b=kjRR/Gkpn/fJ7u6ItAnrGKmwIOX0giKg/5zV6dqv5inKbUHE5QD7Z6XBVt69oEAJOlQSAvYqCFwHQa+RGL70AsKyXRoMquq5RBNjLREwxl+mYz9jOCK4S5bqcoZqXC1rF97qVCZUmTDm9P2HM2OZd0iw21INCGo2xbBDG0cpYQ0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.5; Mon, 1 Oct 2018 00:40:44 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:44 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     vkuznets <vkuznets@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 24/26] xen/manage: don't complain about an empty
 value in control/sysrq node
Thread-Topic: [PATCH AUTOSEL 4.9 24/26] xen/manage: don't complain about an
 empty value in control/sysrq node
Thread-Index: AQHUWR9ipPr3bMpc8Um6ZNff9dPinQ==
Date:   Mon, 1 Oct 2018 00:40:43 +0000
Message-ID: <20181001004026.147201-24-alexander.levin@microsoft.com>
References: <20181001004026.147201-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004026.147201-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:NnPh+wei7NRAEkg4YD2uLv2nC1laPXMY6klbgU3PPAF8B95laaBA8hgg+KwQd2h3dEog3V253VzYLB0qz91BVACfD8NMPEeGKsk7TjqSx6woaWx8/nK6AoUgvswG/Upz2eaTm5pZnAzEuTyS+3jZuTkxpOoOGvtC7XeUXjOSaL8k4OX1g3l2Dkd/pziVLeUeMIAV9N0yZYwciwDaTElcNAiGUhrrABNNWKSL2Z+KBONEqbUMvqiS25jA0t8Pm5VBJi80D5B7WGps6pKkHLbXu00JojFS2P29NG8+xaQxK1GZKj1fZS206xVxcdLPAlZ6pcCPXu6hpER4QIgg99yI4wIlrrBLNc8K4L8o/au/rrua+g8rY/9JpRd7MzDOUn5pVbIexSS6cW3hU++PJqPQe96Jvbn1HBzwmgkrj9oW+JT/Gu1MAa5mZjH2HiLcCbNgoYrLJ9ZtKcmAAYXDQI0o4A==;5:Q9Hk0WanpwAiY1wBWV1yuBit/5J6GcvwV+l0J/LWKguuc95IZCDbDgx8envtsuy4mCvoyX60OemxSXIEpIPlZw2lK+uN0Ov0VoaepIYWXIXtD0DhDEEZzKzPsuNw5Y1LlHDKZnPYH6zJP8hz8uUaguo0VVaKR2NEDDlRsCH+nzQ=;7:TovPPTETUpcL8TOH08mBS9+tRmEMDcmsq8A5bHHNLvgaIyWhSbdhDE1wcwjXkfmGVVNsb6krbj0P+HEl0AJx31RX8CrvjJMPbTlCaXgd9SW+2QPkQlMUt6o1d6Ui5FWNdYkFWpTFCOjmeL2iFL+c0FPwt3/h9g1FkLPiZmRdRSkA5ErZjW5mTry9O7cW4JYMFV07C07xZ/oSzyDb0WVEtJHMLYAl9Mjm7Zt1Lke8cGwQrc7QU1ONsndgN9h8wM2w
x-ms-office365-filtering-correlation-id: 54d29feb-8e21-4ae9-8269-08d62736857e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB0165F5501074ED020A16E799FBEF0@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(70601490899591)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(476003)(2616005)(256004)(217873002)(486006)(6486002)(575784001)(1076002)(11346002)(446003)(86362001)(97736004)(2900100001)(3846002)(6116002)(2501003)(110136005)(478600001)(54906003)(2906002)(5250100002)(6436002)(551934003)(8936002)(316002)(53936002)(14444005)(81166006)(81156014)(68736007)(5660300001)(99286004)(8676002)(10290500003)(26005)(6346003)(4326008)(86612001)(6506007)(305945005)(106356001)(7736002)(76176011)(6512007)(72206003)(102836004)(25786009)(105586002)(107886003)(186003)(14454004)(71200400001)(34290500001)(71190400001)(22452003)(36756003)(66066001)(10090500001)(13914002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: z6dID8GmTZYXH3YZEyJbP0eMSouaxJFI5fL7/HcD4uLByKEMJ1KXsQMnBg1nurNxxoWLiXnA5VWY7Mm1E5wrnqgmdn0BTpPilMniPLbGhDqd518ixv1W0dJQDDuPXcUJdSQ3lm8bg5VO206cIqSXZ3R8hRQYI2uHDPHev+kiS0t9jJ/Z0Kt9JUezZqsXq80tLqdecAWiaOfWaaK+N9CCYxf4dRM3K+xoKSGe8rj94X7HMC7eny2EEuSMTr9GRgPXnj2dQJSlue46H4WDxCpn8LSLAxo6j9X6kdW67yLbKwhv9C54PGjY7HdV//1Q4CiNdOS+4gM70vyRWJoVACA/ArmmGtlgUcDm0t3vKRzh8vA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d29feb-8e21-4ae9-8269-08d62736857e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:40:43.9600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

[ Upstream commit 87dffe86d406bee8782cac2db035acb9a28620a7 ]

When guest receives a sysrq request from the host it acknowledges it by
writing '\0' to control/sysrq xenstore node. This, however, make xenstore
watch fire again but xenbus_scanf() fails to parse empty value with "%c"
format string:

 sysrq: SysRq : Emergency Sync
 Emergency Sync complete
 xen:manage: Error -34 reading sysrq code in control/sysrq

Ignore -ERANGE the same way we already ignore -ENOENT, empty value in
control/sysrq is totally legal.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Wei Liu <wei.liu2@citrix.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/xen/manage.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
index 7abaaa5f0f67..abd49bc7c460 100644
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -282,9 +282,11 @@ static void sysrq_handler(struct xenbus_watch *watch, =
const char **vec,
 		/*
 		 * The Xenstore watch fires directly after registering it and
 		 * after a suspend/resume cycle. So ENOENT is no error but
-		 * might happen in those cases.
+		 * might happen in those cases. ERANGE is observed when we get
+		 * an empty value (''), this happens when we acknowledge the
+		 * request by writing '\0' below.
 		 */
-		if (err !=3D -ENOENT)
+		if (err !=3D -ENOENT && err !=3D -ERANGE)
 			pr_err("Error %d reading sysrq code in control/sysrq\n",
 			       err);
 		xenbus_transaction_end(xbt, 1);
--=20
2.17.1
