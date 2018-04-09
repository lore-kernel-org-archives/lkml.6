Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523239482-2-15823541468284770643
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
    1523239482; b=pZ9UJeojIt/nhBoV503dpqcaTkq7DSGTnV28o3IgU11I6TMR9h
    udMc4aq+uiWFyjb/YCyvzm8LAqdlvoTsEgyJgY6kulTgS4a877Qa1hwr7R/yJSiV
    4cHc2W5hv8fIZhQ/wdLq7Y6ez57KIr8pqsGaooUMlqyYkOs9pdA4LlkonqTt00mn
    04Ebqwe5MD2pnuOfBOLrlhidnxigH4Ohli/VZPLIbDnSKnhvGgTayIt/eABYXx0N
    7BPxSouXeX8rwE1Kqcj2kS1ifx8fmDwOSQDJSm9Cvat/e0XT6v0cFXfWfBWQtlnW
    +P2CxbhtXD22/9a3I5Fw74cSk0eurXrsn7YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239482; bh=VXL9QHAIu+
    GZ1MyFs0UEyxxSbWdrp8NRhe1UZ7x28oA=; b=hHoxKg+lNiGSrx463aCCRmsXCO
    bkLOvaBLUaZBD4gjCNjg3iaO+wRlpAabSDw4fuEmneUukQtlucyK8HZfhIRNUJoG
    iDmQ4EKfUAOPL41Q+Bjf1Kpm53AdV/uhX/wTV0wsF9Bkvd8110CGpG1+07iUPTwF
    Q7txaehSF/hKtktffK+lywq7f1Ejb9pOtqI5B3vQiDlr9LdF9cYEU5TVP7PUHCcS
    t2Zj+swszduRcKsTmvtMS2MI6zOuctxXAdSTzLdI+kUmLQJU7A4hsFjvqyiOHf1I
    gBhpjxgNaSWvE21IhusGHCUie/1gnClKuNcBv8UQmC0vqioGN4vUwuiBhdhA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z/B9WinY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z/B9WinY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJRoCSgqY/2Mc/tUdRWIRYBx6ZCZjchxVVHbL1WUbJA3PgkA3JENs/OfFCmlxo0QW1+5C2ZDf76N8Qkz3Ip4N66fmxK4j28iq42wrUltl+8FEqrjhKkq
    rSYXePlWT/zQolXsun6OWNt2EPnCunCRoI/Tq5kuBuZSXgpQFja29nwgonOjaCH0Tt6WgX78prjuklLNsJD7xbTJttwg99/fAPzP8IVLFDHEgiEkxZ6peJue
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
    a=yMhMjlubAAAA:8 a=EM_MaSWp-SDTO4W7sSsA:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756389AbeDICE1 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:04:27 -0400
Received: from mail-sn1nam01on0133.outbound.protection.outlook.com ([104.47.32.133]:23728
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755010AbeDIAcC (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:02 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 191/293] perf intel-pt: Do not use TSC packets
 for calculating CPU cycles to TSC
Thread-Topic: [PATCH AUTOSEL for 4.9 191/293] perf intel-pt: Do not use TSC
 packets for calculating CPU cycles to TSC
Thread-Index: AQHTz5lA3Ph9q99S3kuNhtKoVv3tCA==
Date: Mon, 9 Apr 2018 00:25:23 +0000
Message-ID: <20180409002239.163177-191-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:GDyotU3a6pX0O1PPbRJNJ32u30xaAD+A9e7k8no4UAuIogwQ05F6PMZLPQhJInU27+qEeKD3YCn670vVZWMUd96T6LsOO3NjKYU7u5HLuHG7e9PSoJQ5QAOsQJLKYfbCxqbMXRWTdqyDGztXl2OZdQ71FuW6H/WWacyVLNTfaRWp2oQq91p6BnQxSOeZBhGW9G3ZfOdmlgmOteKr/VXi/oxZlKA3cMP4qAHIjuvNQQYuZEP/xg6s02pS5NZb3BHo;20:L8+JlPHRMfM+aA2nlRPzH0zKm7pPzlbSecQ8dCrY5wDjViJ136umwp2GeokvUjPfcZR/k7H+0n/mmGDWZ7A6iTRpvLmmxAqbtmbIm/8qaYft8bvUZANMFe6uw3kdheqKQJLLFRxKkLAWXWyv6LcRhEMbpBg4MIS+5uf1z8PZHXw=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1f3f54cd-fae8-40db-6ed9-08d59db14f4d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0870005EA3ECCA4A3FC45839FBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(39380400002)(376002)(199004)(189003)(53936002)(2906002)(6512007)(6306002)(102836004)(2616005)(76176011)(14454004)(446003)(10090500001)(11346002)(476003)(486006)(107886003)(2900100001)(97736004)(966005)(66066001)(6506007)(6436002)(106356001)(99286004)(105586002)(3660700001)(6116002)(86612001)(3280700002)(6666003)(2501003)(10290500003)(26005)(8676002)(8936002)(478600001)(68736007)(5250100002)(5660300001)(316002)(4326008)(72206003)(186003)(110136005)(6486002)(7736002)(25786009)(3846002)(86362001)(36756003)(22452003)(81156014)(81166006)(575784001)(305945005)(54906003)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: OKtwy7+wgsQQBig10Eld8k/gPa1D/iUB8Upj4ah9AD5o1tzSC2LCOUJlY/LkxrlzUBJF5txm75zx91cDNKTcsxf+UPPXvOe7sCYkfuBx1oeqJmxqZzqZQtvxjjuJeQ58pNEX6wkzGuzYeRRr7VqscGBH1r3acRBBCoVoQmRigh8YE94KSfyZV5HCXmm9/368fj9BUece9T88sTt8pCI1grLEaGScEMFTFYBEViewgBrNTRrmSR2IaXq+xCYOsplmIdMt15lLp2TwHzlOLAXIZCIVt4Vo+l4hH8B+NSmVIMqq/T45811zvqPd+AFKfd+X0x3j6JcKJJR7SqgF4EtAtdtGUPkdtD5uChIDfko7u/lIGf0Cs6WnEjSLZv0leoMGSrLNL9QZQwNYQSejNPAh4di0SAgltI1JbdJhlXKKntk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3f54cd-fae8-40db-6ed9-08d59db14f4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:23.8314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 38b65b0891dc129dc0a5ce148a21c481e667b395 ]

CBR (core-to-bus ratio) packets provide an indication of CPU frequency. A
more accurate measure can be made by counting the cycles (given by CYC
packets) in between other timing packets (either MTC or TSC). Using TSC
packets has at least 2 issues: 1) timing might have stopped (e.g. mwait) or
2) TSC packets within PSB+ might slip past CYC packets. For now, simply do
not use TSC packets for calculating CPU cycles to TSC. That leaves the case
where 2 MTC packets are used, otherwise falling back to the CBR value.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Link: http://lkml.kernel.org/r/1495786658-18063-37-git-send-email-adrian.hu=
nter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/pe=
rf/util/intel-pt-decoder/intel-pt-decoder.c
index 7e27207d0f45..3964b1fe3605 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -698,6 +698,12 @@ static int intel_pt_calc_cyc_cb(struct intel_pt_pkt_in=
fo *pkt_info)
 		break;
=20
 	case INTEL_PT_TSC:
+		/*
+		 * For now, do not support using TSC packets - refer
+		 * intel_pt_calc_cyc_to_tsc().
+		 */
+		if (data->from_mtc)
+			return 1;
 		timestamp =3D pkt_info->packet.payload |
 			    (data->timestamp & (0xffULL << 56));
 		if (data->from_mtc && timestamp < data->timestamp &&
@@ -810,6 +816,14 @@ static void intel_pt_calc_cyc_to_tsc(struct intel_pt_d=
ecoder *decoder,
 		.cbr_cyc_to_tsc =3D 0,
 	};
=20
+	/*
+	 * For now, do not support using TSC packets for at least the reasons:
+	 * 1) timing might have stopped
+	 * 2) TSC packets within PSB+ can slip against CYC packets
+	 */
+	if (!from_mtc)
+		return;
+
 	intel_pt_pkt_lookahead(decoder, intel_pt_calc_cyc_cb, &data);
 }
=20
--=20
2.15.1
