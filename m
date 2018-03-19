Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521497117-2-12341731392190594972
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
    t=1521497117; b=Ks1zdjEcWZunouS4jlj253Db6+2ekFl9+0wPnABL04GTxXq
    GdyzHrwrI0idylDV1Mb0tTjZ4MI128Hx14c7Mcf9sk9thfTCrRRfYVvcbCUE3LrP
    pUTlPQHkKDKYzG8bvHW4qfHxiop4kBEaP6+xQysfSLtHwsWtsrCiW8LfeHuP0tCt
    sbNuAub1pPykl4jrcV0LJ0zEoL5LAjeqV8gTvkBqwFU8pYXSrRF3CWtXTNVjSgKj
    4LF9PQjeVcMMQWZBs1cvvqHc2TfvUAbN0Nt3gPfEXoX3Gm62gflO9BgaJ13+/R6s
    nep2ATpVI20z7u05mHMrzjhBD3MKCL22PmEyfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497117; bh=e51q0M
    OhchCmZbxyGGPS3F3Y+lbu7r+pE7ZFl1nvCiM=; b=SXK+CfeaRLCgnpWi+QLhSj
    RxyEyxcKQOCo0zVseGC7QDT1B6Vz+aZR7ysT/z1gmOMScm6C4SIWtOq+AehdpX3K
    sETjNUAQ0GVpsHx76nZeN0jG7Pe2HO4inu8VHQ6ac5KZkI/cI74vi8hP7prwt+no
    rayM3KT1/WIbK/0ipTNS9Cmthc7oWeOGL/Mg1bLTrlCy+s8iLfI+4ryqqTxjaW74
    9ulNP5iEY3arjbVm9nhChdub1sHLcYXJOhhaGg3jd8b5jVftD6AIYaPWG5urtnG4
    Qjlt6fWfeBOez3ughWfafE9An69SjPQ1YLOJ4lD7/oVXMVXVjrO2naihpcTBRFiw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=euWmlF3z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeegjeenucevlhhushhtvghrufhiiigvpeduud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=euWmlF3z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeegjeenucevlhhushhtvghrufhiiigvpeduud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934383AbeCSPzo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:55:44 -0400
Received: from mail-by2nam03on0118.outbound.protection.outlook.com ([104.47.42.118]:16736
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933556AbeCSPzi (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:38 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 33/97] scsi: qla2xxx: Fix NULL pointer access
 for fcport structure
Thread-Topic: [PATCH AUTOSEL for 4.14 33/97] scsi: qla2xxx: Fix NULL pointer
 access for fcport structure
Thread-Index: AQHTv5qnnWP4UCZC2ECYTh4TH77sLA==
Date: Mon, 19 Mar 2018 15:55:07 +0000
Message-ID: <20180319155411.12348-33-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:8n7KNZBg5XpvWbVn7+b/MG3p3Fj0A0GLCBuGQS5ZLmd08gYsSKyjgCEWkrJ9BnxKlK+JsVEP2X7TT61MVg3gZ9QhKOQe2QDZjdumocTaAw3Kbyb0k/43JndkGZGzAfaqwPJEDwIWG08J8XZDJoB6SxfQ4BerIm2W/4VEC26GbYU9I5ZVorJGf3RZuCODPh23qs69z4Z4HvHxv/zDrgWvTBbTFEwc86pDG7424bx9TD+Aus9z1KUJopwVQBarqhj+;20:4CYyBF01cMhknzmOgY5hOgaQ32nbBI5BTCRVSxJR9Du03CO3f6JtlYt1ZHrVFsWDjt98+yOgtKOOnMmQiRDPrJvNeS5EcPq4s/CrG1QL3O31N4o8TPrWTJ9T0BkNwWI4G3oWdg/ewj+XUY8c+FhjqsGtHDz4xwyD0R8F21StHeY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 17cb7ca9-cd7e-4b01-4d27-08d58db1db1b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0967315FA59DCDDF7293BC6DFBD40@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(39860400002)(366004)(346002)(189003)(199004)(54906003)(59450400001)(10090500001)(110136005)(5250100002)(2501003)(1076002)(6116002)(3846002)(2900100001)(99286004)(22452003)(3280700002)(186003)(2906002)(76176011)(86612001)(26005)(6486002)(10290500003)(102836004)(14454004)(36756003)(68736007)(3660700001)(72206003)(478600001)(107886003)(106356001)(53936002)(6506007)(6512007)(6436002)(86362001)(105586002)(316002)(7736002)(4326008)(305945005)(66066001)(81156014)(81166006)(5660300001)(97736004)(8936002)(25786009)(8676002)(2950100002)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: cLP3L0uwD4wAeAycQ7nmoQO9tnL8z8EBHL0L0bqDYFdZnOsVu1+SQhpLHvW/RKb9H3aPhHqYsEbYV5PYBHVhxYzHxvb/EtAtQIgJ3pLNgje6OmVyeINhWzIIBmP0tOlEiq0VEGh1/q9tkruYB27dn2u5aK+uOjJaNhZI3FkSFcF3cvKnAVO1BAryNA145TsndhWDjOGK6ANnLli2IwNCJ9c7Y0q/AnKeziEbs+aeOlfSZHzomXXuxtfOvxUCX6A7YEI20tcOFaYYbnixWgQnTD2ZznPUs97MC17sxyLr08dVJiKGFZR0GbO/hzTHq60Vf3PF9R5Np3VlM+Hub90IDw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17cb7ca9-cd7e-4b01-4d27-08d58db1db1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:07.5454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
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
index 9603886737b5..2300c02ab5e6 100644
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
