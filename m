Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4147991-1523246809-2-371962773222012627
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
    1523246809; b=R/4ZmQ7Cn6w/UfDCvCVToIbXf21eia2J2seRbEnwZsy0CC2oi7
    dHgiVcNVRLA9Me2Rk7cf9REmELuuMI8LX7ZKRxulOx/HSHMuJrZQO0iJb6uGccbi
    hrQUpuLd69i7oBKG1J+g0lZZ6vkds61IZke7FSeD5uCME6kLGjCrA5puIQXoJuAm
    9B+C1zb4m7cZ7fqlGpOBEG2D8aSEz/fXDkSVXbfN/U+BowqhJrLTZbgiCMUCbCMe
    EnIcyknUgOavt/2ThT+FFEQkUXqwtXfYVZZhfDVVJEa3E0kLIFyNRCiUckQmYXHx
    1L1DeAXZh0YMeIcjSGpnuKA2wTbfjZzTSyeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246809; bh=tiAHAELgC+
    UZxkzcQctYIREiWGkTCqch6zAd9X/GPo4=; b=CL+HbZRJ0ZTklBwopR9ic9ys0l
    qG2Uop9rWu7CdG5hzW7jzxIeuquWCoVy7idpAeNIBnfvlTxiNPLsOt0Z9r4fYIKm
    h5TQvRIHsikbMSksiSL9AAaLSaOdvjC8yytRE2aiPZNQBEFKnN7FK+6G2Ag4HHOm
    lvwaVMXTpIVJtydEVayU+1B2ee5MX/FIdYYNb/xJxUgGBXGuOu2jsr9NGVbZRV1v
    5zUFdIqJhtijDewmkWuHYrR1Kr/HvEyQhQYrA/42/N0Qx/PdUJjE191+/zSn5WTX
    vrUpc31ikegu18YDP4zezBwesrgvuP9ApcHEYPiYQyQ3qKEZmI9LMA9059+Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jyE6XNji x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jyE6XNji x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLPRKMNoWr1Mf4Al0j3BcGZ5TT3n4glGZ0tnAM+zZiCyr5o/J06wmUfweUunm6E2QJ3bDsJMC75STWYeg9BzvmH3Gklfy9RHLTvn7nkVNkCWuuokdpG2
    K7Q0rUVvgl/MnEtUfIKpOyX57GXz5hhhe+x57YiRDLCZSSx47y4nEDanh7aTAIq9fojWoHdMKVOgK5YbDIlwqEVt096/n7ncnRHbV0YbdvJmiEhKq1Ha1wyJ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=hD80L64hAAAA:8 a=yMhMjlubAAAA:8
    a=85aJO9LEH5Yzzx1ur0YA:9 a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753220AbeDIARt (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:17:49 -0400
Received: from mail-bl2nam02on0136.outbound.protection.outlook.com ([104.47.38.136]:51875
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753181AbeDIARq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 033/189] iommu/exynos: Don't unconditionally
 steal bus ops
Thread-Topic: [PATCH AUTOSEL for 4.15 033/189] iommu/exynos: Don't
 unconditionally steal bus ops
Thread-Index: AQHTz5gbLMV3/hptckWs7xQRnYURzg==
Date: Mon, 9 Apr 2018 00:17:12 +0000
Message-ID: <20180409001637.162453-33-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:TYnoqXk/V8f3N8AB26WoqmHTL+aaNx98l0gt9B+t7KZD0Efvka0t1IdEmkYXY7Zja6MlLbmXS6xTyppnbM7mYrwO0oHcvREAAkvUgkiExQlUAuDpCaWqiJ7D8VmcwPDU2P3FOKBHqXWmJabU8hESNceB32r6DhiTBnQLFoBPAA67FpW/7ulWWIPqiq/XJvJ9+tF8H0cbRPLz5rFxE/z1mMh92Az+dBrMOJIZUNoO9CVr3uJrOaQdX272231aRvWY;20:dFUOvs9HX5ZlWg7qKwE3GF6GugaAA6RVm0nvrU99oaugPbxwoc1S2fuLHPzUVk5WpSkv8ZXQNRaJDNRI1OqTrW4WIGURbz1CW8Ifn66dUWF+iKpa5AUvam2Ld3+yWFqJZtFxz73o6LEuGiCgFlRQGMuHkVEEX3o6QURSKCd77nc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 28d1b077-d08a-4af5-74b4-08d59daf4fa2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1048854084E184884898C53CFBBF0@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(346002)(396003)(189003)(199004)(86362001)(1076002)(575784001)(99286004)(6116002)(110136005)(3846002)(54906003)(22452003)(3280700002)(105586002)(2906002)(76176011)(4326008)(6512007)(6436002)(6486002)(3660700001)(6666003)(7736002)(86612001)(25786009)(2900100001)(14454004)(97736004)(53936002)(107886003)(68736007)(102836004)(36756003)(6506007)(26005)(186003)(106356001)(305945005)(5250100002)(72206003)(478600001)(2501003)(10290500003)(81166006)(5660300001)(8676002)(66066001)(316002)(81156014)(2616005)(10090500001)(11346002)(446003)(476003)(8936002)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: tcoZ1gZAHUShxkg9V6bjrRq6W8S9pB7TNIrP57fdk5TlSzCYCKHF0M88XdbuLJVj9Gcg4px+DFrY4hU9BphTS9YRKU0mEUBjccdrApllkZvzuAF+SLJwFr2OwDIxXINww8V+6T+cZ2Aa6/eWEDXqFQpSmozo+NFhnTW1375M72zQgXY8ZuY4TD1SR9CDkeL7l4jbmXCGo8wbpAijJxhnh4/gOyVTzOvetMXFgG0qdpjCjRSsDOQTj466+iCWFybF9l8FyBZzm0SxFyECWvi4EL97s0c8S4OsflLXYDeE6ZIoHO+kazXM5bpjcWwokTkN5aSxF9DOdVfv38dNcQpsT4BxRW3yUMqeg1VT2Wj6DMCCKLylnYEUcH2b+1ywh0yQXrZLS7mhurfsBeAKN4CKpfyD23H/0PF7h6ayJad9rgk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d1b077-d08a-4af5-74b4-08d59daf4fa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:12.6050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
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
index 79c45650f8de..736d4552d96f 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1353,8 +1353,15 @@ static const struct iommu_ops exynos_iommu_ops =3D {
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
