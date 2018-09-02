Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C238FC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707C720652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="A8wMzP/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707C720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbeIBRcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:32:25 -0400
Received: from mail-dm3nam03on0125.outbound.protection.outlook.com ([104.47.41.125]:63162
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728738AbeIBRcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3InGLKA0ypfgPRHpvwQlNBi1hfq8pApD4VtR9VHLwSg=;
 b=A8wMzP/s5CJHoKbWQ5RdCSyFyTU+gJviQ1fhsCIlGUSvae+ZaS3foeDnsHX2PgB7xCGgA3X8e7PQMEApiiftpX1b9lPGpaJS+8oS1tnq4N2agYK5Tc3NRSLq8JReXOlWoeBmxE3kQ9WXLXZUdAA9rDfBSSB082XKEUQ4Kw+/ejQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:16:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Finn Thain <fthain@telegraphics.com.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 14/47] macintosh/via-pmu: Add missing mmio
 accessors
Thread-Topic: [PATCH AUTOSEL 4.4 14/47] macintosh/via-pmu: Add missing mmio
 accessors
Thread-Index: AQHUQr8T8Pavf9rxuEWIzNNjXwdMqg==
Date:   Sun, 2 Sep 2018 13:15:52 +0000
Message-ID: <20180902131533.184092-14-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:ln2qBn+qguRrvkI8gOfHmZb4v6EBVULhum8w0B+BC64gR8Ph5dX59e26fStttc/fuudKQz3AtNCeZn4rzJ4Wv2sat61Hz1KvZH/DJuX5HFu7K8P6OCq6gK2BFN/1WInSX/0KcQxtSCMW6CvwJcOSRvMHmbxBTveKpsAvUn8TK3H0I715sCYm0qJFi94p5xjmr6lbqrPdLg/j+1ccWcrU2Jl61SP0rYzDt4HnxrpLkTtVCRjHaAEYkuFclzDm1JPq5WFWwuoO3/iC/H5SJLUpfgo4dQV9nECXZQRHnDh5hqQITzVE5hGY0cZNAx9CFjCaOWALUQhhsyiFhOuDWo1Qo7okrw8njtsZZYzzBuimjYG5nvT2hH9KE33RCuyn3eO5PkSi8gnuKOLaJI+E5kyJ6g4pypJ2CCUq5vm00TRQIpLwmWtdZiG/HpjPCPQt1trcf+VvYGD36zZXSTQzgr41bw==;5:toYL13MHQ5767DMJDQYe75dQlbvah/w5/aFU0073hnJRkSwIj9eCd2yey766sTQFUmjauVgzp+JdY4rVq5YJaJxWMrKxwykVqWwCkQQKInoGvPbPlerSlHtSCiuDZ9tRZrcD3gxAx1uee3IQAkzpwT42RUBD6GWmHoynIcu1qXc=;7:8zi5KB1mP7cXc7CmsABuy+DgjjiEiV1pSR4FxFZR4mcmOiyUR/mhUdWPxeqYsbAlhb2Qw0Et/zCBXQJ0CdzYEsV+E9pjebTGHXgDGwUWZzW0Sx91VVGWJcK1Av/Eu5mlr3YlxShfn+zelP/MFovIcnR7f+j1pm9NqBbfl/mx3kuinSdqjVMPHZXiX2vb/d6m1mrjEtCNhwTnI37uNgI7xA8PBmL69vKO47rvAjcB57+bvNJiC/zH6q6UoK0mB04R
x-ms-office365-filtering-correlation-id: c87186d9-27f4-4acd-4480-08d610d6467a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB062979CFCB0CD4FC7529DCE6FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(46150409022019)(201166117486090);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(8676002)(478600001)(10090500001)(14454004)(10290500003)(72206003)(476003)(5660300001)(5250100002)(106356001)(110136005)(54906003)(316002)(105586002)(86612001)(102836004)(14444005)(26005)(256004)(6506007)(2616005)(6116002)(217873002)(305945005)(446003)(1076002)(3846002)(2906002)(11346002)(97736004)(6346003)(81166006)(81156014)(7736002)(6436002)(66066001)(25786009)(86362001)(4326008)(186003)(53936002)(8936002)(6486002)(22452003)(6512007)(99286004)(2501003)(36756003)(68736007)(6666003)(2900100001)(486006)(107886003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: MN97RSrqvlzfiuMb4licfGHmtrSGXOhfDL5ufVySbu0+Nw3cq4jLhSTQZovZcapnPCcYBzzZYH4SKuJdO+CjNiehHy1OQ/u+6VmJLTOf+wPgXJf5mnxAL3G516bonKGhHivS8zmlC2hbRtmAece56/HBACP5mUbJ9oey0RipAA/IpgQyG+EB7i6X0G3Hk6RZi6T7N+2BVP/ijv56Z204BbHzxwP7VKKNbcPrO3pZZJFx1HHLHqYIn0DEnqBINEqtIENKgUzxSIAo09bScXoZOkz/2b3s3C/uxg1g8NN71XDUYJQbbUJhmLfthMOJ/LLbxB34kfXj6qoD+5zPpp6Svp6cOJv0QiVbl5C0VlVv2ew=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c87186d9-27f4-4acd-4480-08d610d6467a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:52.9876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>

[ Upstream commit 576d5290d678a651b9f36050fc1717e0573aca13 ]

Add missing in_8() accessors to init_pmu() and pmu_sr_intr().

This fixes several sparse warnings:
drivers/macintosh/via-pmu.c:536:29: warning: dereference of noderef express=
ion
drivers/macintosh/via-pmu.c:537:33: warning: dereference of noderef express=
ion
drivers/macintosh/via-pmu.c:1455:17: warning: dereference of noderef expres=
sion
drivers/macintosh/via-pmu.c:1456:69: warning: dereference of noderef expres=
sion

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/macintosh/via-pmu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index f9512bfa6c3c..0a41132ffba7 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -530,8 +530,9 @@ init_pmu(void)
 	int timeout;
 	struct adb_request req;
=20
-	out_8(&via[B], via[B] | TREQ);			/* negate TREQ */
-	out_8(&via[DIRB], (via[DIRB] | TREQ) & ~TACK);	/* TACK in, TREQ out */
+	/* Negate TREQ. Set TACK to input and TREQ to output. */
+	out_8(&via[B], in_8(&via[B]) | TREQ);
+	out_8(&via[DIRB], (in_8(&via[DIRB]) | TREQ) & ~TACK);
=20
 	pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, pmu_intr_mask);
 	timeout =3D  100000;
@@ -1453,8 +1454,8 @@ pmu_sr_intr(void)
 	struct adb_request *req;
 	int bite =3D 0;
=20
-	if (via[B] & TREQ) {
-		printk(KERN_ERR "PMU: spurious SR intr (%x)\n", via[B]);
+	if (in_8(&via[B]) & TREQ) {
+		printk(KERN_ERR "PMU: spurious SR intr (%x)\n", in_8(&via[B]));
 		out_8(&via[IFR], SR_INT);
 		return NULL;
 	}
--=20
2.17.1
