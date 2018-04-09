Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237450-2-10367133809661111094
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237450; b=LvMCnGmuugHIjVrEZmL4ErjDn8Lm28DfCz9W+EQ+p+ar5pRnN/
    rZna8Q0hr8VvkIUc75kPgKLYuRO0QwwKOPwOuwxMq/Xzv36qFhXm5Iv8B3eTS9a1
    Ms1aZPw1+q8YiLQMhacW46bq/9plDICJpq3Y+MfUxSPLPLA+Oc/tnNqG7bOQGvvb
    YINsNhW6BowK45lr8nCwtsGENOqKJFPc13iDfRml6PaZkOuKBUqIgwxHKB5cjK/+
    Xm6X4QjxyjfSF8A56ro4BR9K+l6tShptdH5UhSmxcYw8SXqAwxRTccYke4g8GrKy
    iuD+ZVOgJEvSA7IL/e2SGZjp0lN9110u04hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237450; bh=RTgP62oIne
    AC7f1t9X7OeSjI5LWPLeAxRzTkq2qgoG0=; b=vvP4DSWFTYVW7BJ8y5seSppf0w
    9jmCpIlEftsvsRI16u7YTF5E1qtLgIBt8kzlqPdKjdnTBb2yUF4wqMNCmkKdB9rf
    jFdIF7K9DC7TS4dcoJhpA1AOuPNhsZ589HQ7IM78juaqKSgbLNTiUGMQ9/os0tR+
    fW3JJtjUT/yhib2n4DVDqg6ody00oUp7i+BQuC2KdmD+wX6A+O42Q5PYLjL5DGKw
    712FJJpBa5o2K1GPrT9RApkChwfqMIcrnkdZagahlyxy0G/dmay6kuhRbEWffYdu
    gCNSYIxchb/4MpZfnuyKEaXzE0SUmqb6xvAgIqv6P35+y3PXYIBa3h9WAJcQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AGC5BHRA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AGC5BHRA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIAoDhxivhY9MLHPp939UuDmDN+M3VaFV8Ni5d5PoEjFzJeeSr88rJzqa0HXP1oKv3FoGb+G+gkRA9UnfvBhODWoH/1JZgzPxEcFUzinm/BQzdFPc0Zk
    6QdG7NXaSemZdZxwwsHsaIun9oHc9m7kjNNHY2N0iUxRuxpKig73E+xB2shSgQ3iWV9+sT+qhfXf7neD/IGSCFiDzPyG+D3sF6yB9ZTcnOJ+Uhq7hdnsNLAC
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=R5C9hjxsAAAA:8 a=1XWaLZrsAAAA:8 a=P8mRVJMrAAAA:8
    a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=Xs3aoZ8RMfsy61njctYA:9 a=wPNLvfGTeEIA:10
    a=KpS7wOGxO9l4JKx0McS0:22 a=Vc1QvrjMcIoGonisw6Ob:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756901AbeDIBad (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:30:33 -0400
Received: from mail-sn1nam02on0133.outbound.protection.outlook.com ([104.47.36.133]:9440
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756626AbeDIAf6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:58 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 044/162] ip_tunnel: fix potential issue in
 ip_tunnel_rcv
Thread-Topic: [PATCH AUTOSEL for 4.4 044/162] ip_tunnel: fix potential issue
 in ip_tunnel_rcv
Thread-Index: AQHTz5mljPkSZTURlECEKPTzOMGCbQ==
Date: Mon, 9 Apr 2018 00:28:14 +0000
Message-ID: <20180409002738.163941-44-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:aHNlkpLcCVh8J1zy1uY9SoEupeH666iVwXQ8usf9aUDtU5lFL9J9ig2g4ExRBmsNHdWHk8qPlKp3B3gnGuLFynffM+XB3wKJYX1uWVPln6lY41R+4vGBZm2nCQiFgWUmosVIl/kO4P+v7beEs0XegP6BVJLiYM+MxahDCeOdxj3mmcNue4HJYZTnBOlUzUicEW/TeBTk4H0eOxUNg33Ao8D7HwpvlPXn8Cm3ObO3nzpm8yp7OQ9aVaSEq5qOPuso;20:mitWHJFp5PHzQse9WW+w8sqN8w4Nbkq2u87EDJeBCwdAJZtgw7A1CsrmvtcwAk0nNrycdhGsLtSo7eNUF6nOim7KpnUWY3CXxXCwuXCprfw7/hXO5D2FKDF3maTla5A4WxqG0/fonRObMAJ3ydf1XxJn7vEMUQtNwCpRGDiB0NI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 32be3e48-d0be-4fb5-e523-08d59db1db65
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725FF16B9BA52EBCBF62971FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(173505980823694)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(39380400002)(346002)(366004)(189003)(199004)(86612001)(575784001)(102836004)(5660300001)(14454004)(476003)(68736007)(11346002)(66066001)(446003)(99286004)(76176011)(486006)(10090500001)(3660700001)(110136005)(305945005)(106356001)(316002)(105586002)(3280700002)(3846002)(10290500003)(6116002)(22452003)(6506007)(2616005)(1076002)(7736002)(54906003)(478600001)(2900100001)(2501003)(5250100002)(8936002)(25786009)(81156014)(8676002)(6666003)(6436002)(4326008)(26005)(6512007)(6486002)(81166006)(107886003)(53936002)(2906002)(86362001)(186003)(97736004)(36756003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: nz3nDHwL4eh+iFf2SEKrwyXh5fAe5aCG9pSCb/cN1w2YPNtfx/jLh+Trp0wKTVARxyF9whTd6/8bP2pkZyojJ+BLE1fSeJdYlnNI1SeJSIwB454csepuKDYPbVXr1Qk47NHEFMZDdPwUKmcIV9VZndV8SLsho5hR6wJNGOiUUyuFyLsryL86GgaXAJs6YU4tTRHUSxWoFvaah1IpuoeJRmnEfCaP5TmzypgV/6mEa9HwXMvUJZZIbiZEfaDZ4kSsqTXz8TCt0rYwrdUh9fWbN8VBM1H5dGcz7Co8bhilzu5kYFgcpqN6PCRRseWl9I63PviR/8IjGiCDIl0vAzlzJkmIXxxuiRz+JwdfBZdj3JtL6gOdOuWbl6j+fNzEJjwutXRw8wa+IBs72Nbp6HHY3qH3JXc/BRk26QNOzV53PHw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32be3e48-d0be-4fb5-e523-08d59db1db65
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:14.6143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

[ Upstream commit 469f87e158628fe66dcbbce9dd5e7b7acfe934a9 ]

When ip_tunnel_rcv fails, the tun_dst won't be freed, so call
dst_release to free it in error code path.

Fixes: 2e15ea390e6f ("ip_gre: Add support to collect tunnel metadata.")
Acked-by: Eric Dumazet <edumazet@google.com>
Acked-by: Pravin B Shelar <pshelar@ovn.org>
Tested-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv4/ip_tunnel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 80e2d1b0c08c..f26749d450f7 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -439,6 +439,8 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_b=
uff *skb,
 	return 0;
=20
 drop:
+	if (tun_dst)
+		dst_release((struct dst_entry *)tun_dst);
 	kfree_skb(skb);
 	return 0;
 }
--=20
2.15.1
