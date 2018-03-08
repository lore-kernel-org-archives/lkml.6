Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490792-2-776186975846694551
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520490792; b=qLk2ujB9SMzKlHJFGFMo7mKOqvx52nP/OU7f8RpIPiq0Yns
    0NEQ5mF1nQCKvv6CxDqVD64aS4CglR3QxQaW5h6Kyn2nSlgIySQyQ3FI3KZKcDFO
    nVMhEQgmBN/H0W+o538WaWvVkj/vj93gRI+E/W/r44gv/7tURx64K8MCg7kdjKOK
    C6fg+f1+KRVS3n/xkkNu5kHjehApBsR+NCTMLlCH/SPdzrEYdP5knOjDAdptIF0I
    iUuShNfm1FpKK5Wrwx0jJ/1BKik+htO3ZUATj4eNM8fb5PNT3vp1X+8w4ZuQ/o/A
    hj747GDs93QI7dfSTzPXcXp94TjhrYZNpztXRNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490792; bh=KM0EMc
    0ET71g+g+BPid3VnRDgzD+L7mzepuLB6aqTP0=; b=h1C4nwMcpEWIRZ2Nb24b5V
    RjwEbh0yc6L8jHtthDvvfP6L8ocFf9GuwnSVuAT7fhSp8OYcR5oJdZl0jC5RzkZF
    1VExvFt1mBs0y8QbABaD4yGu0Sl2G+YUArYKKblweBvvdlNjOWV83+fLSJUrSKUA
    Olvg5cZ0yOhc/cx/MovVF46KK//IWASz2szKKjo5+V5jEUXIYJV+Zygl/R5X/uYZ
    QLMSpUFcfSG8WJm5Zfur3vJXvPGPsj8gTeh949CoV1Wui2TJ8bZpvITU36pMpA5D
    pjoCMW5SPbRo4yDT875e0g2kNbyEhd6HhiZigVTohhovciAez1eCw9vVsZSmnJHA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XsJCgZGc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XsJCgZGc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751684AbeCHGcm (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:32:42 -0500
Received: from mail-co1nam03on0137.outbound.protection.outlook.com ([104.47.40.137]:7440
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964809AbeCHFAC (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexey Kardashevskiy <aik@ozlabs.ru>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 009/190] vfio/spapr_tce: Check kzalloc()
 return when preregistering memory
Thread-Topic: [PATCH AUTOSEL for 4.9 009/190] vfio/spapr_tce: Check kzalloc()
 return when preregistering memory
Thread-Index: AQHTtpomZ5z3pWBUa0a07PNPiCzymA==
Date: Thu, 8 Mar 2018 04:58:50 +0000
Message-ID: <20180308045810.8041-9-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:XEV1EYrsYboExCDtFSGjJFOrxJPysWSj2vuk/56XDZHNuo1X17XastKfiyC/ZAcLKmX23EwgWRzqV+x6vtgxei/tieaB3NNVI0rG+R1Uhm9hjXaYjJoSFseCHEyikGgKdr01WaU5fCWUKo+2laagMUeyY3Xi+YdV22O+wtQKl8+uVIJFgXL34ElzOz9batMv7eDF1qz0TSWFjzMl+FN04K8b2YwSy7QG8ixSZHl0TKYiX/l1SxyY0ErRQhrb+onZ;20:xVFZYGlGsVX2bLwnZeD/Z0HpWZqkjaZm/OYBGe8/vD/JZCRVP1q1Yh+NlCfCAZdE6KidI6GYGEH1Xp8xWLdeU2SuHhRnJsoUqsESQ9GdcVaxTh5SbQyvHzNiC1kUnGKD39mqNdinXVQmM48K1Efx+7mvmjtg4fze2TcB2Wimcmo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c52c023f-0e19-47a8-b1a2-08d584b16ef7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB092012EA32C333C0D6D2F72BFBDF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(189003)(199004)(81156014)(81166006)(5250100002)(8936002)(54906003)(2501003)(305945005)(8676002)(107886003)(110136005)(97736004)(99286004)(6436002)(36756003)(4477795004)(316002)(72206003)(76176011)(14454004)(6486002)(7736002)(478600001)(10290500003)(186003)(22452003)(68736007)(105586002)(2950100002)(106356001)(102836004)(575784001)(26005)(6506007)(86362001)(3660700001)(5660300001)(2906002)(10090500001)(1076002)(25786009)(2900100001)(53936002)(4326008)(66066001)(6512007)(6666003)(6116002)(3280700002)(3846002)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: daLjJuXmuZ+5MqJyI4vJHwfzkDxJTyeyrYEF+w0MNUFD8SQ6qnr7xz5KaFd67DLrVZ2QrEsqxFnKaExGjIq5clw7fvzc2uiWnNRFCrQZfiuBr5b7AF4WGNk55u5doIAX/PHthZJYZ2PTvafsakOYhbRd9LCl81o9wztCxmm3W+XN5udBbuaM40P/VyLq+HdU3ChTjBDgcX2Eea2udDGApvpKHTNyLePuNanWLtzy/1ahznHGWGEpIDCgKfgrVET1lbKgMvgQFbwfzBRe5COVML4Wji50/H199WmZQzC1cI0mOkHu4EDKphGcC3poKLwKGMcHiu+Glzj2SJde6R1a0Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c52c023f-0e19-47a8-b1a2-08d584b16ef7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:58:50.5892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

[ Upstream commit 3393af24b665cb0aea7353b05e522b03ab1e7d73 ]

This adds missing checking for kzalloc() return value.

Fixes: 4b6fad7097f8 ("powerpc/mm/iommu, vfio/spapr: Put pages on VFIO conta=
iner shutdown")
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_=
spapr_tce.c
index 87ad0d72d8a9..70c748a5fbcc 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -195,6 +195,11 @@ static long tce_iommu_register_pages(struct tce_contai=
ner *container,
 		return ret;
=20
 	tcemem =3D kzalloc(sizeof(*tcemem), GFP_KERNEL);
+	if (!tcemem) {
+		mm_iommu_put(container->mm, mem);
+		return -ENOMEM;
+	}
+
 	tcemem->mem =3D mem;
 	list_add(&tcemem->next, &container->prereg_list);
=20
--=20
2.14.1
