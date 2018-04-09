Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243298-2-2264898504619186100
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
    1523243298; b=n+QotvAYAceyOMDpsaQUzKkA4HJedanUP6N8C5I8PhAVrNC/QP
    75GSmH0JCGozCutGi/y54NFv+w6u6Y+yXiWfObTTgR+C3TgoQ581Sf3v6ReYF2KG
    gOlTvrCUMAXq1eaZ6lMuabWuS4//vLmau+yFyCIPnWjW0QViwZ1RG2Ho4POTebc/
    k1izvaE83QoI804rVUpZmRSmzxrzqii8rjo4DP03HPj/8H2g5S3MHzfuTNFlZ3/5
    APnGwZleeLXVpL/8XtooWTBH9H0ecrrcmYjqRspMTpYbBZfHjp7zE2uk7E67gnzu
    MqmnV7kt5ZV+bNRm4BMjDDLVwZFDP8eGKHLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243298; bh=Mu6AAgV+06
    4yHX06Aa3/YRUBpVYDTxVLagaZqulEd+E=; b=Ya9XtrF0rLsEiLH9QaHBXFHEoo
    T+biKYXAbduj8Nf2WhNbRwofeh14hJX6Z1BlT12NnQzZmdxC5wQoaq5TGhQve4HI
    fIz8NCOSSj8KKZ4J8lLyfdjvgEcoPhaunPe0jrjYND3sxV3pZrlrfOL/d2ihmbXl
    IXUMxzAJcRtTBaL67hr1vbiuq1mXTtf+B1bUxLlzxuIZx9nGN6lYyhAqjaOtszub
    OHb44EsJTZ/WlBzyqE3NMNvc0oDnqQJk8IAk5gztVPznpNvnPl/gH5WQJn7ddjGs
    dlpBXnAvWJbx83O0yRKxXFldapMK3vZ5AuC+Qox69BihmGy/43eUiZxZiqyA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iwlJMBWL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iwlJMBWL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDITTbi6/iHatlJt1KLYGbA2PgOQel7J7++vQ25AvEC9kqIgySv2SKsp1QUm61VbGm2sx9CepZQUX1E3Fheb8Kt+Is6c4F9rui86FK5EkS7f/2UsCnlz
    nbFVhnM91eqfSZhbotwIWDRb6GL1fCUALxDwWHjsiX679Wt6Qv2zXKb8P4o0mOtfBH9UQrxx5abU30VEpLXShClW3wyvSXtLjD/ZBeUbqcj0SY70kKVhfzMa
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=_Wotqz80AAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=3QStbVbEtIqWIzV9RIIA:9 a=wPNLvfGTeEIA:10 a=buJP51TR1BpY-zbLSsyS:22
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754118AbeDIDHz (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:07:55 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:63840
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932084AbeDIAYh (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:24:37 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 092/161] tcp_nv: fix potential integer
 overflow in tcpnv_acked
Thread-Topic: [PATCH AUTOSEL for 4.14 092/161] tcp_nv: fix potential integer
 overflow in tcpnv_acked
Thread-Index: AQHTz5ikrQ/M50ayzUaqkui/pvzBnA==
Date: Mon, 9 Apr 2018 00:21:03 +0000
Message-ID: <20180409001936.162706-92-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:aeVOLyv8qz2GnznqcjlLEV8GNCkVwoKYnBXDKLXIqFDlMEhSA+gSbeGm7fgx2Yeo3UoWRm5Ffz87F51A8pM8uR0jKMmWW9GNY0MnCCEltXJUXLL9OL8z1TO4XEebrHbHI/JSfhd0J9EhoQzOAt5cG9W79cWLIDopXDqfvoCJ9CPTFYifsA+d+BYMEV7HJwnyogagmFIxFElaWffIGXBp+4eIffdqhzN05H0jF1reXLTRE77M6GK2dgjhKPCcylIY;20:P4t45n7y7gwBeRBF8gtK3s0iN/RwzWzYok2cMPATpNaA9XBrpSYOxPsxLn7brmjwONiDGQRooOR2ZbL6v/b6UfEigtZxAsKGDuxDNz37VbODXP1/6WNzUTe/iOb0IFSjMqgb0wvF+gowilYZq2FTKIpaYGjXh/1Ajqllv70dBQw=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 522cadaa-3468-4a85-0b62-08d59db044de
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0984E96DBFE0D0A3EBAE4F5FFBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(366004)(39860400002)(396003)(189003)(199004)(5250100002)(2501003)(110136005)(54906003)(6116002)(6436002)(11346002)(1076002)(486006)(25786009)(105586002)(2900100001)(102836004)(86612001)(3846002)(68736007)(107886003)(316002)(10290500003)(5660300001)(86362001)(2616005)(305945005)(4326008)(446003)(6486002)(22452003)(7736002)(476003)(8676002)(81156014)(81166006)(8936002)(6512007)(10090500001)(186003)(3280700002)(106356001)(76176011)(2906002)(99286004)(26005)(97736004)(59450400001)(14454004)(6666003)(478600001)(53936002)(6506007)(36756003)(72206003)(66066001)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 48MQeHAySWmuEDE8ZEDU20JQ+IjRmEvlsg3td+nj0fmTnuaVytLTOJ9CUoi1+6KcxEX6oE+5cqWeqVlA6IbudNbL4bp9tghUNDomr5heAEKUxtCum/IrzqkV5ZPxoEtYae3uOKm3o4zq08xb/OgTOg8Q99B5IX+PXIEYxdVVpKpV8ETc/EDidJxzlbAD8IGbJnjjWtGjBfQfBDjZ3ejfdQvzbkdIxxhtz+GImfr5KuXv0nvSQQ420P5jd0CSSn74jnDiaQorEfLcCBosv1DoYlUGAZ4HKWm3xWs16tZqqBuy9Z39NCloIVbrpMVMOGJcn1YXvtVORyuN5JupLIHjXyhXMv6Qp806y2SicNmX9s77KAtEvsGAmfesAkDRpzqQSYJ7KmYoT/7jSIfCqJf0WdwUvBDt5xvNtdz1fIsDFRQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522cadaa-3468-4a85-0b62-08d59db044de
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:03.5189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

[ Upstream commit e4823fbd229bfbba368b40cdadb8f4eeb20604cc ]

Add suffix ULL to constant 80000 in order to avoid a potential integer
overflow and give the compiler complete information about the proper
arithmetic to use. Notice that this constant is used in a context that
expects an expression of type u64.

The current cast to u64 effectively applies to the whole expression
as an argument of type u64 to be passed to div64_u64, but it does
not prevent it from being evaluated using 32-bit arithmetic instead
of 64-bit arithmetic.

Also, once the expression is properly evaluated using 64-bit arithmentic,
there is no need for the parentheses and the external cast to u64.

Addresses-Coverity-ID: 1357588 ("Unintentional integer overflow")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv4/tcp_nv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_nv.c b/net/ipv4/tcp_nv.c
index 125fc1450b01..09f8773fd769 100644
--- a/net/ipv4/tcp_nv.c
+++ b/net/ipv4/tcp_nv.c
@@ -327,7 +327,7 @@ static void tcpnv_acked(struct sock *sk, const struct a=
ck_sample *sample)
 		 */
 		cwnd_by_slope =3D (u32)
 			div64_u64(((u64)ca->nv_rtt_max_rate) * ca->nv_min_rtt,
-				  (u64)(80000 * tp->mss_cache));
+				  80000ULL * tp->mss_cache);
 		max_win =3D cwnd_by_slope + nv_pad;
=20
 		/* If cwnd > max_win, decrease cwnd
--=20
2.15.1
