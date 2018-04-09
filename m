Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523244928-2-12053916559664340682
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
    1523244927; b=udEl3G6nIC9VXYH8M3TX0GMY8bNZOuKgdxEpBii9hbGnLaq8Ad
    t7pWkZA8vho0HNrZLdWwThpqkfkYdJHRes+ZWk/eRXKhlfhxqJG1JLGJ5bm2tHrS
    3VkccRoddqD2rG6tmQzXeCX/GUz/jh3bJGyII9pTw5HZJEkn9eq6OJb9LN2dnT28
    0fQKfKHENjNedOrZqgftHVsuhL6/WrZrOhoqjDt8LOqntuETudVH8p2QMnHp7yHH
    oVyKE971pqcu9aKUuJdrAr6J6KwJNSDlykA4K7W1I1LjMGEoRZRekIE1fZMYZiOk
    n9P1wiRg64mLabv0SFs6FiBVx1GIF5pu6QTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244927; bh=i29+go92zk
    4ryS/tJ/9O12hsF805V9pPVEV5EZQeIP4=; b=PBf3ew2ubBKv1sWl4ZPaKT6RQc
    1aAYHXrqczXVIgrtYfJ3t8ilSQWIL0rfF1gI5qlD3v13pjlGEhdag9DE8ZGJTUTC
    e7y27fSEE2yAubOG963KmUlhQljJ4+zUWuMaUJCHv+jkhjM8AruIaAqSesbDYCCa
    V+qSzKCgEofZGgjC+MvzSYurgB4MY4PvlYeBUnZhEWATUM0OYsegwsKsrdlnaFZA
    y1r4x3ifIi/aaUE6GwW83PBt8JMMLJ8c9UFdkOxADqp/lyes5kI+7FGm1PliVgtL
    rJNLLrtsV5UPCmRLZ2iWhwDwVyz5EbjhMe6axdHjNdtWK/43XbeVZwrjTAgw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SLCN9U6M x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SLCN9U6M x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJGLm9FEJik1uVL11G3sPE0nfPdI4HVG3xMGDWAb+b+EASu4PrtNY6Y0Au//M4+H8gmZl8PBWBC4115srS4eTlYzDE4CDH1PsdsOot/82J8mAQcfflp+
    zT65xDXRoZyzPMLjPN/Un6469t6Zum+2IklA7w0EtnLwNEjuDrjx4MSByFXvQtPwfx2BymheY0gEJwB1Zu2JzadJ1sW5/fhL2JbOqNqt47lsb0rqG2UahtpG
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=ZJDvWMtrAAAA:8 a=0FD05c-RAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=Tn4_V8GKXMdFmcoTaOUA:9 a=wPNLvfGTeEIA:10
    a=taArsEmj-UlvVZUXL4BI:22 a=l1rpMCqCXRGZwUSuRcM3:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbeDIDfH (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:35:07 -0400
Received: from mail-bl2nam02on0107.outbound.protection.outlook.com ([104.47.38.107]:21664
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754417AbeDIAVQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:16 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Hoang Le <hoang.h.le@dektek.com.au>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 172/189] tipc: fix skb truesize/datasize
 ratio control
Thread-Topic: [PATCH AUTOSEL for 4.15 172/189] tipc: fix skb truesize/datasize
 ratio control
Thread-Index: AQHTz5heujeJ1c5eakyfP9EYSKwlbg==
Date: Mon, 9 Apr 2018 00:19:05 +0000
Message-ID: <20180409001637.162453-172-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:RDarRnrSvgWM+kooLooMgz0SfDkxB/SSsTEPzUB4BtjlhMKc7TQ7vRt9saWI4nhOBIsITc9kX90lWS+EsBVTZGmfY5nNlidLTmtmHKCqqBMpgJGxNEOrm2Sf8fqmdAmh++BxA9sJu3ivuDHvAhz2mLC7kfD7OM1oIV+KCrHFYnW2bHPFKrJ7Tw36zmze+t5o+88g3C9uDa/lugQJulytE+fCbT+RIf7p7Z4PZpPnJLz2W/DdYw6FEJbO5KFBCakf;20:F5OXB/fC0XPbe4xYnV08D6QY9lgdUw0tKbFd8ke/4dZO3ezfi+GRHDKcI3AWP6+j1XWrzOKxCZ1PcVM0cEog++imLJsU+oq9gTprM2pDoD0exxDoQLbEFyS3u+unGh6U53MffTaZx//WyA4G+2ovwC2gefH4TopS4KdzBBNs1bc=
X-MS-Office365-Filtering-Correlation-Id: f6ae27a9-7926-45e6-fea4-08d59dafcc49
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11257C5744491B201EF1A203FBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(37575265505322)(28532068793085)(89211679590171)(788757137089)(46150409022019);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(105586002)(7736002)(8676002)(97736004)(81166006)(59450400001)(106356001)(81156014)(305945005)(14454004)(66066001)(1076002)(102836004)(5250100002)(478600001)(2501003)(2900100001)(22452003)(72206003)(68736007)(26005)(86362001)(575784001)(8936002)(76176011)(6506007)(6116002)(6486002)(186003)(5660300001)(3660700001)(316002)(54906003)(110136005)(25786009)(2906002)(10090500001)(6512007)(3280700002)(6666003)(10290500003)(53936002)(99286004)(86612001)(3846002)(6436002)(486006)(4326008)(2616005)(11346002)(107886003)(36756003)(476003)(446003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 5vIhuuf+aCOxpBQwrO7v2IB4fMeQoMwZnR/IJbCQ/m2ebEHd0Tj5dTxTRiQ7VY+RwVRYfHwAbgQF9JzEXsGJmZR4g4TqEIKp0jqJp39nliI1EwSbqNIdr+rZwZeNgF21oJhZyZfIU51N7y6lymxrXb73U54IGjl9mqVzOVdr0Z8hQ8S9ipZsNoxoCBTpxA+B3a1/bXsSr+mvMaKm7f+W8oqAqdjR40HuxLi5TEdJlqfjBHuFhdo14kfJxqV6Zl2FxsdHhvxbYmFaY/1RIVLOUHtPiKMMV/ew7xyJfUcDYgz9g4ahTGxG0jnhoIH5UFx++v1jOYr5TFLhRv10QSVb6KFrtLyNRR/qOOfNgH5fzJx1XIILTzjbIKWoLhtuVyqMyh1/qLGbXXSWZOG1EYULgT2g+gwnX+RWFQPqVISncIY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ae27a9-7926-45e6-fea4-08d59dafcc49
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:05.4240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hoang Le <hoang.h.le@dektek.com.au>

[ Upstream commit 55b3280d1e471795c08dbbe17325720a843e104c ]

In commit d618d09a68e4 ("tipc: enforce valid ratio between skb truesize
and contents") we introduced a test for ensuring that the condition
truesize/datasize <=3D 4 is true for a received buffer. Unfortunately this
test has two problems.

- Because of the integer arithmetics the test
  if (skb->truesize / buf_roundup_len(skb) > 4) will miss all
  ratios [4 < ratio < 5], which was not the intention.
- The buffer returned by skb_copy() inherits skb->truesize of the
  original buffer, which doesn't help the situation at all.

In this commit, we change the ratio condition and replace skb_copy()
with a call to skb_copy_expand() to finally get this right.

Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/tipc/msg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tipc/msg.c b/net/tipc/msg.c
index b0d07b35909d..fb8dda66db6d 100644
--- a/net/tipc/msg.c
+++ b/net/tipc/msg.c
@@ -208,8 +208,8 @@ bool tipc_msg_validate(struct sk_buff **_skb)
 	int msz, hsz;
=20
 	/* Ensure that flow control ratio condition is satisfied */
-	if (unlikely(skb->truesize / buf_roundup_len(skb) > 4)) {
-		skb =3D skb_copy(skb, GFP_ATOMIC);
+	if (unlikely(skb->truesize / buf_roundup_len(skb) >=3D 4)) {
+		skb =3D skb_copy_expand(skb, BUF_HEADROOM, 0, GFP_ATOMIC);
 		if (!skb)
 			return false;
 		kfree_skb(*_skb);
--=20
2.15.1
