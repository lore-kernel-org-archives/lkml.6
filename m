Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238462-2-8777352346219418800
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
    1523238461; b=WHputdOipMJlQY+uYp77wVUl6e/xnS9WLEMZ7GposLZM/z+Q2G
    niV+pYdlOoT+Kw04prH3skSPj8ySwy3Lkm+zvaIGZB/p7RvjA0lhtJt+6IuNNiwT
    N0TOz9cYKonkjN0KhoJ6vwZdaZgEMfNpDEReYiTMjrP60XmkjVwpskcDhJKio1sB
    XpzYApOJqe+VAPM0ead24BPhDFYz7dVXYzmpnviSbOvFVerMvDzp0YBV7YTtpcey
    2Z1FeCfhMGbuvzIiTH3S8ZxW/UEOfRZG2tmJdNNu1ro2Sztpj++MARPyNjQ4OWad
    zksPVLTOOMxGRMpDj5tjIRzNB1QAdo/icivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238461; bh=McpGHOlV65
    NQrr9XiwCAlyRs7FF2BW0DUTfi+58imOo=; b=vHxQ5c/0wFncjjq+B7OT2TgvlW
    A5PdS8XKbonvJb26WK4np+GpMeYkHKxrHnEDrQwdhYPwVZBp2i3QQTuXkb5fIRTW
    OQ9WclLe4ieKZoTJHQerazYYFt0b7i3s8rhhV7N8faiYr8MJIrl7WwC6spAvvn79
    iyj269mWZmjuULqhXI5KWE8V+SZiYflYJzolP+JoMLfy/Ee9xPGZ8cSAG71qW1fz
    wrzSx6Twz2dQeqKGUscty6N22y9cC5LMuUW6cVq5L1kkmeWJbOEOPPz087wtIL8l
    9hT0KAu/Wxaw/HT5WXMRibqOyDmeI0d03n7EWsQord4mfUZbHGQK0n+Addrg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ezbPHEwd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ezbPHEwd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD26YqRJ8d/Kz6XDslARYR9puCElosu94XdwUrwyM+wJ7caBuT1ZUmCxYYUSktFdkHpU9tls2Ix63utoyhp+iA0938CjgZUjls+NmRm9TjG5162G7ZFs
    9gkQA+mA4BYrUgRTkS5Vumf77LyOb3n51oLBaA9wHYci4tdCC4vDpQ1tsPuPa/oUfLJpeQm6/+HcbcvWmyWn5YU5mF/pnAB2L0Sfm3ztafR6tCwue5S/lsdG
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=LpQP-O61AAAA:8 a=3HDBlxybAAAA:8 a=yMhMjlubAAAA:8
    a=xUU9fX4g5_KzQUx6nhQA:9 a=wPNLvfGTeEIA:10 a=pioyyrs4ZptJ924tMmac:22
    a=laEoCiVfU_Unz3mSdgXN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932438AbeDIBrY (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:47:24 -0400
Received: from mail-bl2nam02on0114.outbound.protection.outlook.com ([104.47.38.114]:2685
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932332AbeDIAeF (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:05 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 267/293] netfilter: ipv6: nf_defrag: Kill frag
 queue on RFC2460 failure
Thread-Topic: [PATCH AUTOSEL for 4.9 267/293] netfilter: ipv6: nf_defrag: Kill
 frag queue on RFC2460 failure
Thread-Index: AQHTz5ljRGpaOlc0K0u4sS2txGW0KA==
Date: Mon, 9 Apr 2018 00:26:23 +0000
Message-ID: <20180409002239.163177-267-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:bIKADZ1zU+yiGhpu/quHyEkTCL2Y8joti2OvNMV3KKLgjJH1Cyq6zbGel0aA562C42kNk3aqhGLei5sPXTWRz9cq/RYwPh0EzeNij7XJAuqNg4qq06nzDgjL8nizsRh60BQvrmdY4KUksYXsow9OtB3C03kGCsbR5bIav3H67GtGsWs4CrO78TY6la2vG3Ynzk6koHd6y/emLD0daB0hNKcD20+gLEOqiPrdU9kajnBiZBVvWR0s2Zx4GnFYLAN5;20:Yp5Xuz9ZqJ+iAVFXoc9nPAE6xSmgPirVCGa8jFm4m7Vd+3A9SrQA0kaI5UuuPCD8LLKYbvrAIwXQpG803NztEW560WTe8jbMeuvUnyJNzrpJYWoApb0226tZwZkL0sCsRJfmxjT2FDeXlXkKNiAl0Suhh+HuBYSC0786dhFoIFU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3052fef7-857e-4171-c437-08d59db1972f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB098424D8DB810272D7FB461DFBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(346002)(376002)(199004)(189003)(26005)(99286004)(2906002)(14454004)(97736004)(59450400001)(8676002)(81156014)(81166006)(8936002)(6512007)(106356001)(76176011)(186003)(3280700002)(10090500001)(36756003)(6506007)(66066001)(3660700001)(72206003)(478600001)(6666003)(53936002)(2900100001)(105586002)(102836004)(2501003)(110136005)(54906003)(5250100002)(486006)(1076002)(25786009)(6116002)(6436002)(11346002)(6486002)(22452003)(4326008)(446003)(7736002)(86362001)(305945005)(2616005)(476003)(68736007)(3846002)(86612001)(5660300001)(10290500003)(107886003)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 0fw8CG3KH8GoRNNGmIWkMkjMfIPMckuSRFeQG8ot2pDZb9Hd/VL4k9EWNKF8JZRcDJBhwZOJMBK8e+HwN7lm1slbRZqGxZEsax8kVxsIEoAiQwaEbukPBHFCBQaeX8+wuVux4Ie4o4G/57L+ympvugFn/TB0x3gxDegAxemHPtojYff4oVYYvRqsxQS5HNsQyvVXA7dg7TazoaelBPobMFPIunfl9Lxm2xCWFSvaVE75vR1YsJaGpZlgTYw5g0NVbwO5hQpKcB+b/AeOSXM2x8TDfUbjsAiibuVx90/X1+W1+RIRFSzquiLSixOFedf9pDfLG6tDBvsSJT3JBfeA+wHtTeTMeJWn64NFitIetnlasDDMTr0cC2CuhQNfRJ0bmoXhbe0Bku9QNnJmtQH1c+3yAGQV/TGPZblo1bpl7/8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3052fef7-857e-4171-c437-08d59db1972f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:23.8007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>

[ Upstream commit ea23d5e3bf340e413b8e05c13da233c99c64142b ]

Failures were seen in ICMPv6 fragmentation timeout tests if they were
run after the RFC2460 failure tests. Kernel was not sending out the
ICMPv6 fragment reassembly time exceeded packet after the fragmentation
reassembly timeout of 1 minute had elapsed.

This happened because the frag queue was not released if an error in
IPv6 fragmentation header was detected by RFC2460.

Fixes: 83f1999caeb1 ("netfilter: ipv6: nf_defrag: Pass on packets to stack =
per RFC2460")
Signed-off-by: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv6/netfilter/nf_conntrack_reasm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/n=
f_conntrack_reasm.c
index 5edfe66a3d7a..64ec23388450 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -263,6 +263,7 @@ static int nf_ct_frag6_queue(struct frag_queue *fq, str=
uct sk_buff *skb,
 			 * this case. -DaveM
 			 */
 			pr_debug("end of fragment not rounded to 8 bytes.\n");
+			inet_frag_kill(&fq->q, &nf_frags);
 			return -EPROTO;
 		}
 		if (end > fq->q.len) {
--=20
2.15.1
