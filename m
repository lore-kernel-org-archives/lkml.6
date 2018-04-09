Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523245857-2-7090271164072814503
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
    1523245856; b=k8JkNSp1YtFR7zo2jPFTSgK4qA+lkSFFKDTCBjLSy5XvI+Iwo9
    ryrn8zPNaYiRsJNiepynur/za8eMalvw+vIivU59mRv41VLIORM0V4LM2RhyVHlY
    vJzDRy+hcgTDvChJId0pXnKsy+Cng8rE1NeUf7KuvT38j6EkSOke27GP44Buk5Hz
    F7GDPPxzSqVZr98cqwFsyJg0S0rZHzFYbTbSkYNcM/bAWdgK2UR+Td7lFsKxeqmA
    ERrph5sybzK8uuOpdgFoTTRT+N0Lc5QPapJ6DAgYx2WW3g7qF1tdqIyF6RqGGHsq
    MbhWoqWkfmY2ooC6iARdqBzK5Pdah783DRZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245856; bh=1lJ3fgWiEa
    MAMMytfEkRnvvYOIc+Ee2D6Xdwm1XaONs=; b=IB6dfu4o8SdL06y1jNIvgJ3ztG
    w2u5DHXUEOGiIqTjG/H7wXyw04DiJzLoATCRKEKpBUcB28PZgJixBWcEL+eOwt5l
    aMnsPv/0pMRUwEFfvnSPCYQvkqWAsAIdEf8P2GTc5L+sQ3HfBDXKqdyBER7UGjes
    dHDHQeRDLZKtbtf+xWKXCkDXvFfUAiRkZeo9Ds92syR2I6Gc0lrY8iQpuV8eqODA
    wk1hXNSKhSAxqrxdCo41h9DFF+OD2eWOqs8DzGU45wZSq715HA51uEZWxwhiiA8h
    yql1q59WOFPbPxYPbghVSCx25/2s5WCke4e/WAEnsTQqhmqjrZuMwLFYm2iQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nAZ8Ryct x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nAZ8Ryct x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFjfi7E0h7vL//tA4UUdJ5JUj9jMYxOAgwRZKudqk7ZS/Pfoi0XO/YfF/w04cOx5OLSWluXCWfxuN0VrNFNJvxpK1wrJKi1Y1ptcDFBE0vxHUUNVo7NY
    mIqplnptw0qPuN3aDA3HcqeFgEx5bEj1GFHwMp1+h2M619sjAeEAkRnfRIishnNEP9wOlbDJlmItLTUczMvaqL0dt0L9fy/7LgSuLWoooDxmbEOPRw6BFqle
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=_Wotqz80AAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=3QStbVbEtIqWIzV9RIIA:9 a=wPNLvfGTeEIA:10 a=buJP51TR1BpY-zbLSsyS:22
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754451AbeDIDui (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:50:38 -0400
Received: from mail-sn1nam02on0102.outbound.protection.outlook.com ([104.47.36.102]:30848
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754056AbeDIAT3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:19:29 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 112/189] tcp_nv: fix potential integer
 overflow in tcpnv_acked
Thread-Topic: [PATCH AUTOSEL for 4.15 112/189] tcp_nv: fix potential integer
 overflow in tcpnv_acked
Thread-Index: AQHTz5hAGNlBI1tgiE2ugMFgxKAUAQ==
Date: Mon, 9 Apr 2018 00:18:14 +0000
Message-ID: <20180409001637.162453-112-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:tCo66M/PKX/oJzYlqG1M03lqSSL0HD73ZTKC18yLho/4AhSDqTLumC7GQQrvCPEg7xL7AVKWvPwC99jnXH16BjDg6SMHr6SM9viUUEPK8HZsnsufsmqofYxrhbW9hwwk9uqV6MHKqCgU4gFsUC7MNzFJdvga5r8xkJhZCD484Lz14wa64VbgkwHVE/cf6Gn2vtN4hn8I0lJFQ0y5mA4kjESKxEgVWWdpfHXSgRkTAqtr7na8hA6uinpTUtigU5WX;20:HueNMBhdAbWlzWx/qqgU/yjoUszJSgxggVnROMFOLiRPZe+xK930fkZKLwy14TSrhQ0MvhAnA/WgXznBrf/mMydzNgy9vCPo18gOS2RlNuxZ6VrFGU2TCAV2raRF9q22RRLuicYBOGkY+M6yVUBDqox1f5tZlA2wnaVZxmAHWEA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e6d87c1-0527-42b5-8abb-08d59daf8d7f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0726E62C3C01BC6B304DD9E7FBBF0@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(6486002)(26005)(6512007)(4326008)(81166006)(6666003)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(86362001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(59450400001)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: +EcaegKWa0oPGLGHQjE5asrgbzdGrPOnSi6m8seD0K1GQ8jMZWGdDE4MpQH3b7OO/1L59G/inCYYvtVq7dQGGoNrPBy9FADhRsekhtuZyuH7VSs4sP2V6N1gVdlmSdD9fZnZnK8FKxlE5yiw1dS7OUEOUUJpDxLYMZx70pw/6+Qm3Qt3xWto+c3ujeWymYuGpOVAM3a2b7JBFq0h5bdw8neiPbcwlSjqI46q6qaxwyKT1OfdShJJQojCUk8R6zdjpVc0WsE1CqzgOfgUTHl0/IrVkma9r8jATdKVuQ5DLnL0BeLzHcFvQF6VqRpl/MBdJ8cXX33w8sG3cM06w+GFS0GF3fA3MIGBtSXyJxUt2Tc1mZ/9cPlUKH56aNvx0ywuLYPG2GGHYwXLl7xVJ/WpAYkcTWjK+V6Zx01Mo0z3D9Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6d87c1-0527-42b5-8abb-08d59daf8d7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:14.5841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
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
index 0b5a05bd82e3..d18f4672beae 100644
--- a/net/ipv4/tcp_nv.c
+++ b/net/ipv4/tcp_nv.c
@@ -364,7 +364,7 @@ static void tcpnv_acked(struct sock *sk, const struct a=
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
