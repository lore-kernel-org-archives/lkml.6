Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523242952-2-15982574395494488834
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
    1523242952; b=qPVr7qs/xfciSAoTsZbwZno+Q1hUhWdkweD1p/YKaJDYHDboW+
    tZ0gbyW0BaWxtzCyCzS0DxA5Dliz3/ySq/uEJnasYRGN00nvsb/bqQqigy7zjDjO
    s7nYvLK67QO1ZgNvYqT7dC/B/E8viw1uhjzzcwWm+rlSsy/bQb8TmJ93FU9lWNMv
    DFdQwGB77+PCnib31Bw86F3LUfF/UImgqHTInGaMAknCvDBlo7HaMI7P0VdRtnQi
    4b2K9FLTggzVYDACRxmPc1ybY/yhbsmCJjLN1BdB4nVRxJ20pAnjxmmZqjpVVgOz
    Hgb3jHrb1aKJ5NFDhGVuu+JY7ICPEj42l6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242952; bh=McpGHOlV65
    NQrr9XiwCAlyRs7FF2BW0DUTfi+58imOo=; b=nahRYq3ohL9wdr1iwjrIjiJYwO
    euU+0oy9D/6ifHubA4SU+YZeanRGoSMVXSa0z6+W4n2gc8Rx0f82oLdMATeW8UVS
    5MMSmcUcxDQ9w2jmPGzZ+1vZDCXFQRWP+njoIBHaRN7uGoBXTXkD9CwZ0SHabknT
    fPE7xaqFVWbpQ0axIDNhWOs36F9o21idCZFV3W0Kv6PUbzpcbHqi4iNsc/4GepRt
    8FTmSJ3B38XuwzwE0kFhwLR8VXy5EESt++2vSn0ut26oraYJnqxmWEQGMcvf1HtR
    uxfLJB2GxP14d0vy4hGgDXCLQgY348+m+2tk7iYcu3Yren6/5AKtOOk2ClOQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bGuklzVq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bGuklzVq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIfUgZzAavR4KIpaHKKtNirnqXAGWSaD9S6eSzsOi55sswN5G8uVI5Wqp8CK+wtQjXKWAayWDNHzz8lLUOrXqT06rATOqK5ltsv1/Fk9oktBFORVReBA
    13eixKvaT6IZMBfBD41zPGovvHWkEh++r9HAatEp+oEg5O+uKVRfptF4cHeg0jOAXgm+XIY5MwLcKKwyzrPldHfasoNCc/+sUVzmbpx8YUcSi/WIlyLOwcJR
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=LpQP-O61AAAA:8 a=3HDBlxybAAAA:8 a=yMhMjlubAAAA:8
    a=xUU9fX4g5_KzQUx6nhQA:9 a=wPNLvfGTeEIA:10 a=pioyyrs4ZptJ924tMmac:22
    a=laEoCiVfU_Unz3mSdgXN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbeDIDC2 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:02:28 -0400
Received: from mail-sn1nam02on0138.outbound.protection.outlook.com ([104.47.36.138]:39392
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754290AbeDIAZY (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:24 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 115/161] netfilter: ipv6: nf_defrag: Kill
 frag queue on RFC2460 failure
Thread-Topic: [PATCH AUTOSEL for 4.14 115/161] netfilter: ipv6: nf_defrag:
 Kill frag queue on RFC2460 failure
Thread-Index: AQHTz5iyTXKsLF7xiEmj58hRjJnsVw==
Date: Mon, 9 Apr 2018 00:21:26 +0000
Message-ID: <20180409001936.162706-115-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:xkF9+w4fFwK07zjViedlWKRkMenZzj66gLyfsbnQIQAvsookMRId/s0WE5V7Yv2PqEFGodYZ8+YtG4Mf1+Jw5W1w0tPoyq8H3IqjfJs8iPHM15ycNzpEKFbH8yXgV24Ph4IBXH5i1hOJiBhraD31+dCQ6OK5bah+FM4sCqegLmhar+8U4lOEKc2f7BhW5wFN2wkj/NiJpBL4s1KJE6gQNTj9fSXgUW3Y9Dn/8y0LpaPQENY4KvET5zgWmg1NFEkN;20:9NcsdQFLn8Ew5vQcq6uKaJhyx9ipyL/PEYeby56ANyXIyg5Ni7RPmBjECfDtxOLfqdSUecX11z8uiAAokC+n6vluSc8sqX/9m4eqFj3bc5YaJK4EyghZZGlu9sjexL3JOFydS55PnRJmfAQ4qPXwP79kesGAlhYSAsEn++hCZP4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 79d3a9e1-a395-4a14-215c-08d59db06173
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0983ECDEBD7027EA36B73775FBBF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(39380400002)(366004)(199004)(189003)(478600001)(59450400001)(72206003)(10290500003)(3846002)(102836004)(6506007)(6116002)(25786009)(6436002)(66066001)(99286004)(54906003)(86612001)(105586002)(53936002)(76176011)(316002)(486006)(7736002)(22452003)(3660700001)(86362001)(97736004)(106356001)(8936002)(110136005)(5660300001)(11346002)(446003)(81166006)(81156014)(2906002)(8676002)(2900100001)(1076002)(476003)(2616005)(10090500001)(6486002)(107886003)(36756003)(4326008)(2501003)(68736007)(186003)(305945005)(3280700002)(5250100002)(6512007)(26005)(14454004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: zFMCqTEp1Ik+ODrhs97+Qy5HE5vhSKnN5pslw5Nf8iuCudPVMeS03uzP72Dj47PUuPDQjdRDQ984phvKKDPVs3u0Johstt5PFKhrBCH9pV3QSrJY+BltHDaInEBUmuhlzkEODTR1GGsa+iiKdi5B+WgermisD9h+FJJGVVduUGePKlty72s6vanVKjQ8MCBW6eT2hMb9mzUv6GZP3nxv/LhqF4jCG1Z8D79nYFg0yMCNtX1E6LHGkG38rEDnMsCE/FiWBrLKcl1+OIqskGOeCfCwaVZWfEoWoH3TF6SjZNiSvu8mMOSvglrkv78jaWC75SZMSgd5AdujDtZvwESPVI4ZSCFSa6A3e7FS+X8VJoDXDp3WyWQVwXXVFZteJI8Z3HjHo6nqbozNAZdWutP78yscooy4raa+dcFh7EyF0Gg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d3a9e1-a395-4a14-215c-08d59db06173
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:26.9718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
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
