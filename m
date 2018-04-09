Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236789-2-7314998548676407517
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
    1523236788; b=VIgx3lYgmiioq4qWoDSsppChPdBjsBpJuK+7P14EAXnHcmOu4w
    IdwSqwDqW9oSu4bq5VbABuqJBzFHzR/Axh2s2BtApuaEpfVuOR9SOeKQZlDWFmvq
    mGNC33TbQ/Aaucf9WZOEQQ4zTrvMk/+5qB0So+ccfp6AOV36+ZGSCgCWXkEd6G1l
    nYsmsFByRSbdA9uPkSXj2iWAeYegcv3C48G4rOBS0c5mtx8SFtM9a4C/nreTsorB
    7cuK2kVPh0VEob1TiSnisWb9/86ALZjLTjU12MLcVvxQgedYpJnDKh+1Q5n7XDF2
    5fAA9ZJFLRELrkckXP3C4vDypBB+gd2pzvvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236788; bh=eZsKQiFgo4
    +JlR0jX00ZRgw4vgi4uQDX6CDE0xCCFAI=; b=sV1KSSmB/1n2U+HKve86acotvh
    jvLSa5nX0ovG/5lHAAE8au3GHG4dknK+8p6r1Qk00WCRNNdqXZOPvfCHrpi1R2Ux
    vmpirTjSR+P9S6wddNFkzKxCzJ+JewrtmFWOspQ4+9bZa5XkzQRUEHobnGy65sYN
    UUmxYtdhiPOr7+WVCVsE3uSQNycmBxIJajPsDFIpEgt+rllxK9xBIL+sMB42j+55
    bieZcR8bxHUujdMOeHRtzRyceL7U7zyyhk0Ir0jYXRJDbaQA8GFY8aq1sVVN1yBw
    Hyhkyf7tcJKUBPxEwX8wzXym1k4RzFx89KjskRxNcE8b+/lNnltYhB6XI5AQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jyNUJcfH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jyNUJcfH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGjhYqg1NmFFUNzq2OQ5uhcQLuHkSllb4dSBGFfIqKiJsSWrf023JsGd8gChzM2sbuaTPtkwrQarcGpmd7OrgUdVJRmn0TuLxj1xKLIOyVfkmGCujHYI
    ZAplKfxqd1wzQ98v7XrF1gSqE0rfm54kz/YOIn3U4BCFG8McUDxQNis0iNrmtlSs5m+tO9BE2wrGANuayHA6x/YPLMifGkjExnmuDZOkyAbxiiOJri4OIOrY
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=uzX0munmM0PJawDz13IA:9
    a=VMXPBGES3oMSlYbN:21 a=oUyMJkUep1U3_SyU:21 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbeDIBTj (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:19:39 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:3040
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932809AbeDIAho (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 097/162] powerpc/perf/hv-24x7: Fix passing of
 catalog version number
Thread-Topic: [PATCH AUTOSEL for 4.4 097/162] powerpc/perf/hv-24x7: Fix
 passing of catalog version number
Thread-Index: AQHTz5m+CFSn7DZ8QU+JRzQ4vB/kJA==
Date: Mon, 9 Apr 2018 00:28:55 +0000
Message-ID: <20180409002738.163941-97-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:3dJUHdEPmc10op3Rvsve1J1ouZSK9LqLnulodn3DqJKCnCwKPLTGyWSQ1HGVo9NtczKx/ZSDvd/EAm1pbc0sCSGcUWCKAsrTU6sTPobyPowoIW+S5w8NEldD4XtjGb1TotuG5+4G47Jl7LswBhSfwdU92EYeFRMx2bpKcPkIxgTbcijB6EMZ7JRTYtrFykYnXSQk/3idz86Y7g9JQIT7ZaHZ82WDhsqI0cvtAofTaE2QJre1F/A/1ZA8pbLcmunQ;20:+eATYRoLTOV1jCj7Q442GrhutYfUTL7zrvoUfpP0YqnKuF4jIfOJNPHWiCDmyI2g4q9jUDc2jkJNTFVAn5nJQYtm0ZLMDdv9bqbCxGfTt5w9zn8aYwXC0rFha9UsvMXuWstmpoZvsdR4WZwDkbhyw/7Qr10d405z+MU5KAYxNmM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9935ceda-f20c-453f-30bf-08d59db21af1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10310E091BCA05F7F5A7E3F7FBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(7736002)(11346002)(26005)(6666003)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(575784001)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: iLI704/ytxHLPitBPQqhdgoD0f4LqFe7vytqOOrfCol6Nw3qTm/tZoxcbiuxiMeh0QYUPk1+13r9slSRtPUsvXdDdUQzJlCo58nd1zc9gaC4qNRvjn3A1ySpLBd/yAb6W5psWZFiKH/HFC5sK4S59aqaYQFO9RUG94+TFAWwakNXz6fBxynMQubA9zW1vmox4GFqtQmdyRIntQBCM1TFaj7zx3tW7XOR1c5805OHNZR1ao01fvEeCfpghMT8JNfeCdpzsJo94eSe4/D21f1I74xX2QfONrkvL0ZOFtEFGfC9h6Bn+QSTp+D0QDriuPC8d+xb3Lwj/9DLJjjOnpg+fmlVVTwVnK4hRZdVpw+DqiCPWoAsoEGij8UuvAIwUmYAELJpuB6mFVp9csO3qceeN5izprilX7UAGYSX7dv9xwc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9935ceda-f20c-453f-30bf-08d59db21af1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:55.8178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
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
index e8ca0fad2e69..e267f4c3e51d 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -668,7 +668,7 @@ static int create_events_from_catalog(struct attribute =
***events_,
 	       event_data_bytes, junk_events, event_idx, event_attr_ct, i,
 	       attr_max, event_idx_last, desc_ct, long_desc_ct;
 	ssize_t ct, ev_len;
-	uint32_t catalog_version_num;
+	uint64_t catalog_version_num;
 	struct attribute **events, **event_descs, **event_long_descs;
 	struct hv_24x7_catalog_page_0 *page_0 =3D
 		kmem_cache_alloc(hv_page_cache, GFP_KERNEL);
@@ -704,8 +704,8 @@ static int create_events_from_catalog(struct attribute =
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
@@ -760,8 +760,8 @@ static int create_events_from_catalog(struct attribute =
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
