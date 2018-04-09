Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523244287-2-4822995352935243572
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523244287; b=ZCPXTvu6xcCHt8docoHZro/VP1MH1Atouy+eb/bDfMbZrTIpry
    OKluSMHn5BxslYWFWLW419EyqrY6WU+8L7P+P+d97dEv5LEiNSVF/2pE4jusc7hA
    sCGSB+gMnqElYYNhaGSrUG75YXkZk/KJlQsdEZf1dcij1sCpbN7M3mSMVrnYAr+D
    LLp4C4r142/7e4DMi1gkUlQnZcPiMr4GluGPYvcuk8bHeedNKQAURHXl2sA63qrK
    P9Tdayh0EKe00Z8fv5pRQeJxzXoARf2Rp43NrxRZHuc2H0vKyJOKHOefK9PVRrdg
    GNJLb2vcZz36PN/thtao6XOh52O3NSPOM6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244287; bh=Pp7r0ETXRk
    UEgZRBZYGu0M6ZTm+p+m+GvZpIZ2Lu3Hk=; b=i93U4ZC94rZvwxN38mSiTgdSWh
    zbZcqasiUePZ3uprZOnHRSZ12YwWk1nRGNmNw+hCYFvYVO2SpAwpZmQ9kagUYMf9
    HXh9f9mKxYQ+xacqGtneiZA/3KzQj5tcr/gB8uAbbdLwApQYEnJn1UQOh4GVbw06
    Aa4Dtx6MtxLBEl7+12qIsfvvMi1eNs023XT64TYn7zSfCaMHlTjCzNk6cZe3WMJn
    fa3W4uBMmrrkDCLIHs3Szcvv2Mo1ZdOV/ncLus61Y11a6yvvoVFHljZV7XWRL9BS
    B/Bt1RR9mYfCJIoXUde5U+/GQnhneG9auGGKJUmyk7yUauHqqOC6YYFnU8hg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BDvDS/2Z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BDvDS/2Z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJgWzmOv1gU52ZRXC1/QhJoLNbaWTYQYDHtGemaqYsLxafd0NOUHnO8OUFVPg2jxDCNnAkG9NyaPh816OH5hXLV7Gh9ob3jslpndB8V8hbh12ZhnUkjW
    dmVjDYSUpoU8S7KnEFBTxdMO/onBZ7eWFjkjxhRUF+KB4BA3oWLps0bx2ULzr3BdaZhRb6lFLs7PbZwmuDaPxQ/AjkSCf0ktklVAOGvWoZZ+x1YuvDX52mZM
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=hD80L64hAAAA:8 a=yMhMjlubAAAA:8
    a=85aJO9LEH5Yzzx1ur0YA:9 a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752929AbeDIDYV (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:24:21 -0400
Received: from mail-sn1nam01on0122.outbound.protection.outlook.com ([104.47.32.122]:20813
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754713AbeDIAWq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 029/161] iommu/exynos: Don't unconditionally
 steal bus ops
Thread-Topic: [PATCH AUTOSEL for 4.14 029/161] iommu/exynos: Don't
 unconditionally steal bus ops
Thread-Index: AQHTz5iC24o1od6AeUS4b4q7HepoDg==
Date: Mon, 9 Apr 2018 00:20:06 +0000
Message-ID: <20180409001936.162706-29-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:ewGY3/yR83dlaKcc2/EJQpU1RxzcFH9HXpxGMPM14aI/pV98XOrQfGy6CBHLXl0n+4UNR2/PIh9f+DzuPB8bjM3ug9xwZTzTFeQqvAg581p9bNHLzvs6HAFPemXIW8yHZWM4QPWeM0vduamwSxCo0fziW1+55+oihnBieW21IdlPtxmMh7DIaQZQx48Wk0Zt8uZLE8kxi6G/9nZfDBx1NvQxNuqXPjk1tQhWakIlVba1MRzpJdLMe7Yoaemwx4Yk;20:1qGlotD5PZbKKds/+nb2qYHReA8JKF2OOTbBfXdQH5Gp0P+whtDmcp0AX6nye+iaUL/79zBvwxjoxU0WhyIE8uMzhy9kFySXplkXBVQW8C/KgpaL90zdJAMCxeusSuLtBl9ISVZ9voOaHt5rj5jwHITItoUXxMwGknz09jza6QI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 23cac41d-a425-48b3-0c6a-08d59db002c3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0966E8999A24739B3542C9B5FBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(396003)(366004)(199004)(189003)(6512007)(316002)(6436002)(186003)(6666003)(2900100001)(8936002)(486006)(6486002)(6506007)(10290500003)(81166006)(22452003)(25786009)(1076002)(81156014)(53936002)(106356001)(10090500001)(5250100002)(107886003)(102836004)(76176011)(8676002)(66066001)(2501003)(446003)(476003)(36756003)(99286004)(575784001)(478600001)(86362001)(72206003)(2616005)(68736007)(5660300001)(305945005)(3846002)(6116002)(26005)(86612001)(14454004)(97736004)(3660700001)(4326008)(2906002)(110136005)(54906003)(3280700002)(105586002)(7736002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: a/+TYa3N5Je0Hnz9yPOHAOA8nEte1OAMX6SMYBP/AIYENN0hHYjJjUUdDspr4olnZbzj9X2wg5Ox4LhE7d5BSNtD0T9bfC9OVulVJ1YwfW6x0awPpXwroRmGcehCBviYHivpFo9VUQrERoMYarF6un5JuLbWSctIWoby7uJyaifUqZxxOwhAib7OcMYwsH15BQfOEGKnv45wGnlAtttWA8yGHzPdl1FiU1aVvrQ0ATsHqKiLzjw03O7XVcPTHEFZ9ewJ7wDR8+3qQoFV8ioWEDtO4MDxFJ8XSOM2KZf9cbA10583IXvhtxjHeIDiR9YcICQ3AQLgGaSWMXhAbhJgf/0TXMEXc3QPRFAWyOz4sPUqODz74j9SV3PoDdhDk4ylGZeqqv3foOoK3a36DsZ6e0jSKW+wdUGQGO2CW2nYM0o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23cac41d-a425-48b3-0c6a-08d59db002c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:06.0822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit dc98b8480d8a68c2ce9aa28b9f0d714fd258bc0b ]

Removing the early device registration hook overlooked the fact that
it only ran conditionally on a compatible device being present in the
DT. With exynos_iommu_init() now running as an unconditional initcall,
problems arise on non-Exynos systems when other IOMMU drivers find
themselves unable to install their ops on the platform bus, or at worst
the Exynos ops get called with someone else's domain and all hell breaks
loose.

The global ops/cache setup could probably all now be triggered from the
first IOMMU probe, as with dma_dev assigment, but for the time being the
simplest fix is to resurrect the logic from commit a7b67cd5d9af
("iommu/exynos: Play nice in multi-platform builds") to explicitly check
the DT for the presence of an Exynos IOMMU before trying anything.

Fixes: 928055a01b3f ("iommu/exynos: Remove custom platform device registrat=
ion code")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iommu/exynos-iommu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 25c2c75f5332..13485a40dd46 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1344,8 +1344,15 @@ static const struct iommu_ops exynos_iommu_ops =3D {
=20
 static int __init exynos_iommu_init(void)
 {
+	struct device_node *np;
 	int ret;
=20
+	np =3D of_find_matching_node(NULL, sysmmu_of_match);
+	if (!np)
+		return 0;
+
+	of_node_put(np);
+
 	lv2table_kmem_cache =3D kmem_cache_create("exynos-iommu-lv2table",
 				LV2TABLE_SIZE, LV2TABLE_SIZE, 0, NULL);
 	if (!lv2table_kmem_cache) {
--=20
2.15.1
