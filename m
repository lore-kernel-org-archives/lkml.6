Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523239375-2-608305606130866451
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
    1523239374; b=bdJr0DjbJXU4v45AN2EG8ATKsbcLXW8jl7Fd/v6GBWkpM5/vDB
    dO8KPEDa4i+22uw1aEJ3qxVewQFDhti0yM/SMpm+SLn5BSH4T/hFv79LaCvdfdPJ
    VuDwd/9O/trGSP4Qfb3t0m7aosRb6jyZhtE9rh2k88ojaca35fYLjlMVnvOTqtK4
    dIVD9AYUAsTXG8Zq2dbLKZ479dtN3egCv6nmIBA9UwXZpMEH2jnYsQ75oPYx6WwK
    8fZ0XNALOKJjIuXLypUBbft3tqoB17rBEDmJwiyQEcj9fVYw8sRTxzOpHzAYWtrG
    DOX2RKrZhSM1FnaNB9Dy0N8Xt9lQIleFizLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239374; bh=wt8z4+LLP6
    Rwrv6xXzPF9QR2XFjkQu3rNv27JG+n20k=; b=PpLFA+34cChtaBD/c5Kts9a2k2
    Vw0W4F8gPMM3PHSPzpYqxw/duzfkMeGH2xPyJGnEF9ECAkW23zD+c+2bFPl1oP1B
    i8b0x2XnBoi8bTtz27Untzg7WiqIWF++7l7wtYUw1xrlUxDPBMwSd4DPQHFidyMT
    4T+lfAgDfNVF9fJuxe3sVevYJtC6QMHpGL42Auacwn3m+EH0xzRwjPoTfm3beHBp
    ne7MgKD7bzmvhWBq+tqjiIZJXLhJcrt6FjtVWp/JmxaOLHLPJ4Y53Vcq6hGkL3n2
    OVt8K3i9NXsOnmGRFm+f+rX/T/u7rDdl3MLh2m6X37+ByPPd6xcjvylJt33Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QwrPOxSg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QwrPOxSg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGZga08RCByOm+1lU7icJA+DPqfZ9UJYP52dIc0cp2847Eh5e1OctL2HRRxpg60S3heDP99u1m+aJQoXRtA2rSyAfbWzye49NZ0dIWNxdo923GZzFDvG
    HNWbpp9sYycnz4A1DJ09WRu+92Z+ac+I8Js8pIr5kf3vkpRQQ1bumQsY96unWufg86VP0DF1CDp/25zOewR7mQk9RUNdgBksGlcd2ycGNlJ0N7i942eHqUK/
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=uzX0munmM0PJawDz13IA:9
    a=VMXPBGES3oMSlYbN:21 a=oUyMJkUep1U3_SyU:21 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756419AbeDIAcI (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:32:08 -0400
Received: from mail-sn1nam01on0103.outbound.protection.outlook.com ([104.47.32.103]:45281
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756356AbeDIAcG (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 194/293] powerpc/perf/hv-24x7: Fix passing of
 catalog version number
Thread-Topic: [PATCH AUTOSEL for 4.9 194/293] powerpc/perf/hv-24x7: Fix
 passing of catalog version number
Thread-Index: AQHTz5lBL+PB01qmb0SkDjGtYUxSeA==
Date: Mon, 9 Apr 2018 00:25:25 +0000
Message-ID: <20180409002239.163177-194-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:gQaSv4cyEhAJoEijPsiwXsZIf3Fx8MejGDB2gAYzdUeIx4A4j+lMKAx6RO7x0XZmQPvRUGbqI3sY3uGmSLdqS1n0hvfx0Qaqdp3TACQyCCFNcgVSOpJkDOXVI1gdpPvMts0wsaVVet91o3Yr+ag2PVLtmQCuSYn6WW9IMoK+Ie5OH1C8s9m4UIiZPE1k/AinBQLt6I/r37Wcmy2A0Cyy0q5WOlMyip/BQ4ti/uoXic5kbc+3xoAZvzNP0ZNLP2oX;20:qIyfkCBL/kJu6n+cOXCwL9zb9q2om2JlWZB9bRWN6HGUQVtHp2/5jrVL1t87au2vz0ooJSZPO96rByuXOP4NMCMwQ5/B9mWu1rYz9AGe7lsGz6OYS6b8+kQdt1iOF5qCiVoKW6JXBE57ozC8eJpthI3MXu2RMEA1EoAvpaPr/d8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a8f011e5-1a8c-4e71-7ed2-08d59db15163
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB087018C677B9194822C30A67FBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(39380400002)(376002)(199004)(189003)(53936002)(2906002)(6512007)(102836004)(2616005)(76176011)(14454004)(446003)(10090500001)(11346002)(476003)(486006)(107886003)(2900100001)(97736004)(66066001)(6506007)(6436002)(106356001)(99286004)(105586002)(3660700001)(6116002)(86612001)(3280700002)(6666003)(2501003)(10290500003)(26005)(8676002)(8936002)(478600001)(68736007)(5250100002)(5660300001)(316002)(4326008)(72206003)(186003)(110136005)(6486002)(7736002)(25786009)(3846002)(86362001)(36756003)(22452003)(81156014)(81166006)(305945005)(54906003)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Oj8gIOUuqIk23dTNXIv4jbF2GXfJfSeXhVsFR9Ib8F3Phh5pcIjMAxNSOfqqy3x58Y9SHvM+qgFz0utW8k4TyPU34fGUpMGJmaZ0zR70XUj3Aw3Aw/hgsPYoWDP7/UGGIYQb6aC9+zI23DIzWPGYAQ99L/MCvj1+6kvNJLEh+2MGUhEiUEoCdoAeryNwf/RZebsxu3h1vBW5wxpX5mEKaMUoMcvk5JturBgql2MMdGdA0Qq8eSNX6W4PH86Hs1M06RvR/WyoE4RTPYtqOT4kANf4WJ3CanV3t0ESp/YXt+Qa9FftxMZJab8wcH/6jACBh+7ZGwsjjMaATBtNjBR9M+17tfNRWWWEqFx05voeReMYqfKmSretUDrJJmjidjRV/OPAkIIK/DvaJJRvRpXZrD/kIQ4n7p4wLqeAURYvYUU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f011e5-1a8c-4e71-7ed2-08d59db15163
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:25.9564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

[ Upstream commit 12bf85a71000af7419b19b5e90910919f36f336c ]

H_GET_24X7_CATALOG_PAGE needs to be passed the version number obtained from
the first catalog page obtained previously. This is a 64 bit number, but
create_events_from_catalog truncates it to 32-bit.

This worked on POWER8, but POWER9 actually uses the upper bits so the call
fails with H_P3 because the hypervisor doesn't recognize the version.

This patch also adds the hcall return code to the error message, which is
helpful when debugging the problem.

Fixes: 5c5cd7b50259 ("powerpc/perf/hv-24x7: parse catalog and populate sysf=
s with events")
Reviewed-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/perf/hv-24x7.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 991c6a517ddc..13cea4e8c56d 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -670,7 +670,7 @@ static int create_events_from_catalog(struct attribute =
***events_,
 	       event_data_bytes, junk_events, event_idx, event_attr_ct, i,
 	       attr_max, event_idx_last, desc_ct, long_desc_ct;
 	ssize_t ct, ev_len;
-	uint32_t catalog_version_num;
+	uint64_t catalog_version_num;
 	struct attribute **events, **event_descs, **event_long_descs;
 	struct hv_24x7_catalog_page_0 *page_0 =3D
 		kmem_cache_alloc(hv_page_cache, GFP_KERNEL);
@@ -706,8 +706,8 @@ static int create_events_from_catalog(struct attribute =
***events_,
 	event_data_offs   =3D be16_to_cpu(page_0->event_data_offs);
 	event_data_len    =3D be16_to_cpu(page_0->event_data_len);
=20
-	pr_devel("cv %zu cl %zu eec %zu edo %zu edl %zu\n",
-			(size_t)catalog_version_num, catalog_len,
+	pr_devel("cv %llu cl %zu eec %zu edo %zu edl %zu\n",
+			catalog_version_num, catalog_len,
 			event_entry_count, event_data_offs, event_data_len);
=20
 	if ((MAX_4K < event_data_len)
@@ -761,8 +761,8 @@ static int create_events_from_catalog(struct attribute =
***events_,
 				catalog_version_num,
 				i + event_data_offs);
 		if (hret) {
-			pr_err("failed to get event data in page %zu\n",
-					i + event_data_offs);
+			pr_err("Failed to get event data in page %zu: rc=3D%ld\n",
+			       i + event_data_offs, hret);
 			ret =3D -EIO;
 			goto e_event_data;
 		}
--=20
2.15.1
