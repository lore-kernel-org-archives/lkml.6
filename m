Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523237179-2-5431724075585628310
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237179; b=G76Be7U+cMZhSmpZcROReYIMmzSzB2m+pERw6i1q4YsJLDNaSh
    B1ocEjREEjS27ggRIoZFMa+vc57zIeH2XrXxUjtzj3jHroQf1u89QMc2Uhq2Y+IN
    /oSSgaYQcA+yiUtP5q3ulw94XwC1Mt7A8msqOVA2ohd7i38QFlFFai0TXf2tmV3T
    V8B8+6N8EmOk3m0M7z9BqvcOuBINKLlZXJncvUxGLAo1A4Aml0jOGBYBsASnbwj/
    1IB8i0LGMlVOokwU+XDSxX3aoXJOXs3G5LM1Z/LrizS+kf9w52qEajHezvkA89cU
    o/azxai5dlq+Cg9XaQTwjpUaQ44mhm83tGyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237179; bh=SskrIacZzG
    mkdzakoPFCUb84IK1h0hGCAA5jSPgW2fc=; b=bB6GJBXBO2xWUZTmNP3Mf7OqdP
    idykZjU/JAGSnyOUQK95IK59czoA3HUaMXxVRvWLyUEeiXFFHO1XfCyd4Vmrh8Ed
    s8L1/tdngk3fA3TaQRSM37cT1PFUPDGtE3X64D2j6hdWpja0RLaGpXtjiPAJCFPk
    QdZwuJQf0Ku/zM486aWR0zry98DN15x9t6cbJaGQPlzeleZgopo7pBSDX3/FG5d0
    VAdJWdNA1m4g3ba84LxQX0MdbcxogA205MwObTG3u5MYLNX+cMOBOmOt4R5htX4F
    5+8dcHCacULpf3mHDGUxZNNWR2r29/zTomL1Sf5OjfwocuSXa98hQTsAk4Yg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CWhj1ZAL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CWhj1ZAL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCEKsg5Fgs4N1CyqTYavF4gnVlYkC2wXAKaXFQPbvudKXuRXjHAAynlv3GlCSaqS76U7pixH2a2Wv4IPYpWGvWbxJzlz8ISQtjBweeYjJMpcfIlffTl5
    ie3T3mdlRVNakge/X/cd3LOtoYiqBWD3AAdANqtmC2MET1jdfto7kq6H6V4Qcks+LDjZeRMJEvvvqeBAfjpqbBVku7TiYjD8wXdJZDYY5w/sRnYEb/gohM7u
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=92hT1TDex09zFRy9lPEA:9 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932809AbeDIBZx (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:25:53 -0400
Received: from mail-sn1nam02on0127.outbound.protection.outlook.com ([104.47.36.127]:39469
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755937AbeDIAgu (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:36:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Chenbo Feng <fengc@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 065/162] tcp: Add a tcp_filter hook before
 handle ack packet
Thread-Topic: [PATCH AUTOSEL for 4.4 065/162] tcp: Add a tcp_filter hook
 before handle ack packet
Thread-Index: AQHTz5muPOAMHA8h+kOm3imPN1eGhA==
Date: Mon, 9 Apr 2018 00:28:29 +0000
Message-ID: <20180409002738.163941-65-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:rkskAWaTxFsJGmtgTApeHJFlw7y2Ho5mSOzHLUbCW03PWtWkOwRoShs4PvtEc5DPSzASF4ZlUpjI2US3nwzHBPNsy6LiZiN4pi93U8SCnseXQwJ23Rblb2Ir4A6o2zZp4BJrJ64LFFJULJsnYJRV8OW9Qh0dXkEKnKycUQKui7BJ7k9pJ1hbvivnhU/mZrg3FXz4ytY1CG8CBBzccQ+68WDRdfZY+0NpoS6hvH1KUuEY6got9yosXSIskUEpFyV3;20:B8vEKB5FK57Il7sR0AgMH/CN7N/K8VBH8K390xCNFlLyFW4tD9ZfGrs2V9BvsMfNzjgjj1YLkXHqQ0xG3i/XsFiXt8ZQXdwnNzfhaJJz1CNSCx95Ro/4H6Fzoi2auORgAu66Wzbc6Cf0aOon+ib//KiB87K8F84p869PD943bVY=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 796e0cb7-e3bc-4b62-139c-08d59db1f9e6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885EF244D290DA1A921A426FBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(66066001)(3846002)(6116002)(59450400001)(86362001)(305945005)(10290500003)(6436002)(5250100002)(3280700002)(10090500001)(3660700001)(6506007)(2501003)(107886003)(446003)(53936002)(11346002)(2616005)(26005)(76176011)(7736002)(478600001)(476003)(81156014)(25786009)(8676002)(81166006)(186003)(8936002)(4326008)(97736004)(102836004)(99286004)(14454004)(36756003)(6512007)(316002)(2906002)(22452003)(68736007)(54906003)(110136005)(486006)(6486002)(6666003)(5660300001)(2900100001)(1076002)(72206003)(86612001)(105586002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: L8IN79hnCd1HV16Z0DOAb3dA5eFdLnXbTgmmrZQOZ7jqznWXvHxA9UIyHNZ/tW47hzEmVbKcjieu3jlYQrN2NiaWYyO2iJkCrd/QJTfbwQeQs0O60hXsNu2yTIbLKpP0Aa7iQgxnqi2rBPqcSdC36ezvZVl2deWRLvG9xfgYe43ootGR5EJfcZMDsOF/Ea/e7WzxNVZ9Njrjr9oFXySbibwNuVf0cdPo/wK8Dfopn6u1g+OD+L5cAZBaCLHaFqaF9JA2RtZfJjb2PC6DLdoFhYMhiYbYkDsYfvyk9EVelW0MKMdeT68/YJXsz060ccZAVJ8xsaE7Tv3UCw7gnR8JiJw1vNHrJyPayE/qFkcqhdsij/aysazUPVY1k5BCucY0L38UNv+mI26IRN2soUooehj3/SeGA+q86k22xEiahNc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796e0cb7-e3bc-4b62-139c-08d59db1f9e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:29.8332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chenbo Feng <fengc@google.com>

[ Upstream commit 8fac365f63c866a00015fa13932d8ffc584518b8 ]

Currently in both ipv4 and ipv6 code path, the ack packet received when
sk at TCP_NEW_SYN_RECV state is not filtered by socket filter or cgroup
filter since it is handled from tcp_child_process and never reaches the
tcp_filter inside tcp_v4_rcv or tcp_v6_rcv. Adding a tcp_filter hooks
here can make sure all the ingress tcp packet can be correctly filtered.

Signed-off-by: Chenbo Feng <fengc@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv4/tcp_ipv4.c | 2 ++
 net/ipv6/tcp_ipv6.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 61c93a93f228..2eb9a1747f25 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1639,6 +1639,8 @@ process:
 		}
 		if (nsk =3D=3D sk) {
 			reqsk_put(req);
+		} else if (tcp_filter(sk, skb)) {
+			goto discard_and_relse;
 		} else if (tcp_child_process(sk, nsk, skb)) {
 			tcp_v4_send_reset(nsk, skb);
 			goto discard_and_relse;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 74cbcc4b399c..7d7f0999a919 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1428,6 +1428,8 @@ process:
 		if (nsk =3D=3D sk) {
 			reqsk_put(req);
 			tcp_v6_restore_cb(skb);
+		} else if (tcp_filter(sk, skb)) {
+			goto discard_and_relse;
 		} else if (tcp_child_process(sk, nsk, skb)) {
 			tcp_v6_send_reset(nsk, skb);
 			goto discard_and_relse;
--=20
2.15.1
