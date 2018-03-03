Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120184-2-17016165532535750107
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
    t=1520120184; b=X3lrwNeY8I1GcbCwlgEpk06m6LUalPSdsrocZLxd6tUgEOD
    1IyTlUZALF2ZqL27tTl7+WhCGfveRs6LaMOBMQpj+0FjG73R8ubXIM26cAg2ZRUs
    SJ9xfsQGqomVaCKfoWmQu4Xc7DVLpoCZ+akUZzAifjzkNmX/GWaVB+lOfMeMeDXD
    S9wgLgvLoXQ/lC0B07zgtROSxAYANGoyg41nFpczMMungzouk/3Jzb7iMtnuX8oT
    0fKuhZIzMWFL6TUNJlBSE8JpTo7ShHe3Xyi8DtbHL4rnPYTIyOmO/Gdx4tkQCXcb
    iB1WwzFSC/OSaDjLg/+bVvpPaK9r4TzAHAAnUbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120184; bh=KM0EMc
    0ET71g+g+BPid3VnRDgzD+L7mzepuLB6aqTP0=; b=t5oRg8pJ50vJyXcQzqSdHw
    YjQ2r8NxzvatSOqJct+Rtp7cUl6yEXLuO1Y3zls1U2+wk4o7k4nCRluYDCbNo0EI
    J3ZOXdX1LMml2eDedtfrNsF4xuqoQ8be1trZ2ECGDupnk1O6YgYMdDhri9f0QD6n
    bUfaHkqh42sGrb2DAMokAAB7hQqNf8Wtt4s/j0Zvq47BoBakIL/e95imFfNFOIfd
    PHNocCsXXbEOj8V0Qx6u786+mOx/Oq8ECGlqWr1GPjuhwh8D7s+fK72nHho79HaF
    RKBDjFtdOulzAX6bIvGsjLqLJ0AaFFTnf+tO3YAxTaKMq0xK6pw/t6YA7VJJmdkg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ILYGwbqf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ILYGwbqf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934420AbeCCXf5 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:35:57 -0500
Received: from mail-bn3nam01on0090.outbound.protection.outlook.com ([104.47.33.90]:43384
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934128AbeCCWfr (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:35:47 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexey Kardashevskiy <aik@ozlabs.ru>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 155/219] vfio/spapr_tce: Check kzalloc()
 return when preregistering memory
Thread-Topic: [PATCH AUTOSEL for 4.9 155/219] vfio/spapr_tce: Check kzalloc()
 return when preregistering memory
Thread-Index: AQHTsz8WdZBVvuGLq02hXkpw4GtmeQ==
Date: Sat, 3 Mar 2018 22:29:26 +0000
Message-ID: <20180303222716.26640-155-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1034;7:bfofbGs+eM/K31NtG6k0IPKtv7KfNkqPFAyr5Z/FaK2qNlXvXqRoKCPWa4doAK6/D6sZNzprtVj76w7KbMP6Uw46Dyy7LPH9EtK3G9Aa4rR3Ngd/czdwFym5+4tG0MqahTRhR1abtHC0PrJlid9gP6H/tLndRE3akyAn1IUTQuLSKellqDmDulTLJKRp8/12Agvgm8Gd7fpjQt8E86lFV3qv+gsvMcHwUrTUUaAoD6+UrsV0fHuDRzKzgZDSWv8V
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aeff7b41-ac7e-4f83-6c06-08d581571884
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1034;
x-ms-traffictypediagnostic: MW2PR2101MB1034:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB103411C92F723AC6E12219D5FBC40@MW2PR2101MB1034.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR2101MB1034;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1034;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(99286004)(22452003)(72206003)(316002)(3846002)(6116002)(186003)(26005)(478600001)(76176011)(54906003)(110136005)(102836004)(97736004)(1076002)(2501003)(3660700001)(66066001)(5250100002)(5660300001)(86362001)(10090500001)(10290500003)(86612001)(6506007)(68736007)(575784001)(106356001)(25786009)(8676002)(4326008)(6512007)(305945005)(2906002)(14454004)(107886003)(8936002)(7736002)(81166006)(3280700002)(53936002)(105586002)(81156014)(6666003)(6486002)(36756003)(4477795004)(2900100001)(6436002)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1034;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 44Kwi21T+y6hppWsa6XUnonB+5WQvsozVfnQGMAXcfPjWIg2L8SwCZV1o2t9DRaiF3Pue8SCj0V2hTvL84TAHR6hja6kUeZVNrJFEFB7r+FgECSgx39Jq/QfcWnTJtAkVrmiywwgSLVvh4EYxGrqlmjPE5uloQPeZP6xm1V05Lw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeff7b41-ac7e-4f83-6c06-08d581571884
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:26.9320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1034
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
