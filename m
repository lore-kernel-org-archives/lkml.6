Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3764808-1521493666-2-3645502637560145863
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521493665; b=VKATHsG8JI4NtPGHNkeubR78vCQTHdRXdw0T9d5M97HWxU0
    qe/uHhjxRVDbcY66G424906EpqH/VHxB7ZSYjfj+Z4d2+k30IutBCObq/DHbwYNq
    9/CwvpFCexG6AQo2TWGJCUFHxUGKpN+m5uRYnx5GUHbFOwncsTgwUS7RR7pW7y6w
    G7BU9g/PPQOAjUty2X4SlMYzcA1mE59FY3BShd41zKIoKj8MxgJpYIJjbx2Sk2aC
    ewSLcDFsaREQ2GGVn0mkvl2+8rgQ0zAwD8Jt1Ov/uZ8+G1u/xC8YNyxWOD5ASwid
    /bHrwHESqTRhd8cV0DPt3aMotK3B0HnpJ5Miz9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493665; bh=UY957g
    oKfmD2EwMM+CCX6x4Egy7QETYoKNX9o5Hd+wk=; b=qrwmkTctPacuRokWDdxszX
    rs58Uq2lnPqdUXaipadXRkhfxe20zRLZ46SPI5sy4n58he1gMhuM7Lli4nfnSkWS
    14eUUszoCruX5SJHK+56RfeA71xcPAslwsUF9hbNkLnI3DuLFdsb3yfkSPgBt4qk
    KkoTD2HB5c/Y5O28+ZblJWszjj1AXePfs6euPHFbksWyDqwxNDhAMSBqCtfHwlE4
    lH/qX2EBfYfJx9P4gjypnblO5PpL1cvaeGunlJdv44PEo4PZgg8suwN5ykRfCWxW
    BOsl+FWmQ6iT1GNw8EuQ5UZ7Lld9VJkiQ1O6dftXJ5+eeS9uT6+PQGq5OMVQIA6w
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RqnLg4mt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekudelgeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RqnLg4mt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekudelgeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935294AbeCSVHl (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:07:41 -0400
Received: from mail-co1nam03on0123.outbound.protection.outlook.com ([104.47.40.123]:22550
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965374AbeCSQCE (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:04 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 144/281] IB/rdmavt: Allocate CQ memory on the
 correct node
Thread-Topic: [PATCH AUTOSEL for 4.9 144/281] IB/rdmavt: Allocate CQ memory on
 the correct node
Thread-Index: AQHTv5tvF+LtIBahX02cyJHKEZvD3w==
Date: Mon, 19 Mar 2018 16:00:44 +0000
Message-ID: <20180319155742.13731-144-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:Meu6mqWvdVWc6ZbVGT7MiR96lMjXn7w7h5Ga7dPIhs2IQTvgCOqIdB94G2nX9vi75nN5ap7PwHnTedLfYxPFt7a5MU3PFZXq5HrQqOfpHfWFZpK7j1tJj/WMp/s+hFU4myulGuwpL7c4JYx6qG6U/R1hoA0E431MLPSMx4U1dQt6j0hRvNz6naTd20dEfH8q5G5xQ/AZH85lQOo2/cXHUiwEKaMssVFI486na1HANlq9yUA5fl7IlmqPul4y4Dnx;20:4rTS1wPR/gpAfghoDLt1tsvCGf7Hq8klQOJ3Gm/mPbxMp8Otr3JTEIbQnZmtQKPfj1llA9jHKJk2iW6AFO8OS5dy4SBSFCZS1rCMqFwuRzvSLbRL0X71a/y1IqaK7EHyLqjiePGBZ/Ns96YIgN1L+za4SVv3yTzedUuWpUfEiCc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94bd0c5b-87f8-4dd5-b552-08d58db2bcfe
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB09338AE2DC04C55BD112114DFBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6666003)(6346003)(102836004)(575784001)(22452003)(86612001)(3660700001)(186003)(2900100001)(25786009)(478600001)(5250100002)(26005)(6486002)(6436002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 2cjVs4Wr8zzsYmLmNLTyyzZt3e+S5PUrleIpoOiiNNi5XsT7yn9jN5FwZV+I4ulEd5vN0A1wl5SJZ8dmeZpUC72W9yb8RZ2DJ/UxYUsRIfrQ0XGJBCIOiUsLAlDhfHGYptnaBZqVgbgXncgZ3y9VkjpDj1/4r7HApNnNm+cUD0EqGuFrHikR9/OESEeIjm0hnkBGFsFE56V7mJUgNkolJkjCvrdRsW0UqNY5xbOpRONMjebpoIiF9kupykREuGNhTKLRba6HQNzEHk+ijt9Hzr/rKx1XKuJSyiLjmCb/kGrGAMVe3+58DTWs/cM7yKQ/EMcG7uD+fj25ifFHfAuzzw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bd0c5b-87f8-4dd5-b552-08d58db2bcfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:44.0612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

[ Upstream commit db9a2c6f9b6196b889b98e961cb9a37617b11ccf ]

CQ allocation does not ensure that completion queue entries
and the completion queue structure are allocated on the correct
numa node.

Fix by allocating the rvt_cq and kernel CQ entries on the device node,
leaving the user CQ entries on the default local node.  Also ensure
CQ resizes use the correct allocator when extending a CQ.

Reviewed-by: Sebastian Sanchez <sebastian.sanchez@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/sw/rdmavt/cq.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdma=
vt/cq.c
index 6d9904a4a0ab..29dc5278d7be 100644
--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -197,7 +197,7 @@ struct ib_cq *rvt_create_cq(struct ib_device *ibdev,
 		return ERR_PTR(-EINVAL);
=20
 	/* Allocate the completion queue structure. */
-	cq =3D kzalloc(sizeof(*cq), GFP_KERNEL);
+	cq =3D kzalloc_node(sizeof(*cq), GFP_KERNEL, rdi->dparms.node);
 	if (!cq)
 		return ERR_PTR(-ENOMEM);
=20
@@ -213,7 +213,9 @@ struct ib_cq *rvt_create_cq(struct ib_device *ibdev,
 		sz +=3D sizeof(struct ib_uverbs_wc) * (entries + 1);
 	else
 		sz +=3D sizeof(struct ib_wc) * (entries + 1);
-	wc =3D vmalloc_user(sz);
+	wc =3D udata ?
+		vmalloc_user(sz) :
+		vzalloc_node(sz, rdi->dparms.node);
 	if (!wc) {
 		ret =3D ERR_PTR(-ENOMEM);
 		goto bail_cq;
@@ -368,7 +370,9 @@ int rvt_resize_cq(struct ib_cq *ibcq, int cqe, struct i=
b_udata *udata)
 		sz +=3D sizeof(struct ib_uverbs_wc) * (cqe + 1);
 	else
 		sz +=3D sizeof(struct ib_wc) * (cqe + 1);
-	wc =3D vmalloc_user(sz);
+	wc =3D udata ?
+		vmalloc_user(sz) :
+		vzalloc_node(sz, rdi->dparms.node);
 	if (!wc)
 		return -ENOMEM;
=20
--=20
2.14.1
