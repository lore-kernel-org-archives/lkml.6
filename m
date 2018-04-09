Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233021-2-10518725233360609430
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233020; b=VmZYOAm43RtomyGFBJmckZNr1el7OPw2sZLIShrYSaMiJ0l+VA
    2oQsdJgIx0KpDI4NsPFtOIF1KGfXJbjNqzFI7u+IhNfPvJ3Tt6p5DI3hnFZGOFph
    a1z7k3apI87++u1T3y4Vq4EppxSUKuaPrrvYla3XGq1v3B4O4PC9ROWhaQsa3NjQ
    ct2aNCxiFfuvpZNEAPyJ5G62MKK0f1xi91+LhLwThilmac/WKtvJZmd7dAtW83BK
    26Wwf10nXyFWkPiKxa0FSNxTCkuHYwievzvrmG4Mk+yhtKWAIUNA2HJqxsY5hnw3
    CaujGatqf4bBuZgsq+EMkDnSc597XuLUlFbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233020; bh=Reke3UTVaf
    9og/H3hf12IRRuPScPVDv4D7/Ofg2UvbE=; b=wQYBvhJdZVC8D2JhfPcgdImKwQ
    4Lpp6mTBttySaJ0RBJYcXA497Fa66cXpNdlBy/lswTj9XUnG8Mkcw33t8fMCr8gt
    fD6MQP+KfuvAUlMDkjiKUOWCY9w0E8EIKttGUfAccENntdPrIBd6I3IHnCkBwQ57
    7+IXVWmjIeboBfCccipUIdiLmorhJ0/lz3gup77ghaimaArkno1hzjcC4aHT9I3L
    +No+ccUC8NwbaCnKQU5jLQ7ylgVMXo3FLY/XiYT2rQrMke7s3kTcYnyMWn8ul/k4
    1+OjjzTQx59VtcoWwjRu1svfB13J52Fs0rV9VQfW19ORoH60QybDx863KEpA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bHGH2Y3T x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bHGH2Y3T x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE/2yWzgWQtHiBpnUf1U3akgzL6K/gO+xoBMJp71UQNj2Taca2orgLUIcu7rErSx5P9zmECF/3ZKh4SPBUCbkpFOJteaNjbsJbKsXLQDKjXn+bjgRifN
    2Yu6Bv1QjkFo+g/bSZ0Iuu6Jrhc/w7LumHBQ0214VQSEIbf2vN0YUzyP1CKLBiny+99MJl1v/DEEi5yJb3DlYq14OSSHVQkO9Ko6wsVIf2R6MyTieWoCmsbO
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=0FD05c-RAAAA:8 a=hSkVLCK3AAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=VOB_6XEYNUV0baoGuJIA:9 a=wPNLvfGTeEIA:10
    a=l1rpMCqCXRGZwUSuRcM3:22 a=cQPPKAXgyycSBL8etih5:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752898AbeDIAQz (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:16:55 -0400
Received: from mail-cys01nam02on0097.outbound.protection.outlook.com ([104.47.37.97]:28800
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752874AbeDIAQw (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:16:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jon Maloy <jon.maloy@ericsson.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 007/189] tipc: fix a potental access after
 delete in tipc_sk_join()
Thread-Topic: [PATCH AUTOSEL for 4.15 007/189] tipc: fix a potental access
 after delete in tipc_sk_join()
Thread-Index: AQHTz5gNP1h0ZcAL+Uqpvhp0zbF5og==
Date: Mon, 9 Apr 2018 00:16:49 +0000
Message-ID: <20180409001637.162453-7-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0968;7:4yxdN+OJcm0v7YRXMqOcu2e1nv2oVYK2f6g3AVVoA7Ab7Gu5xD4YuPxlxRb/XS+gA2T+Qs/923Z8P6z8kPmJMOloYuW10JhIlYB+sWBjN0URQO7DMInEYPKeFIVWyf0OJHA0EQun2ktXFXu3EX98aOgY69wTJWoYG50vFvp1yBmCyFQ8z0gGzR3vMNwiJt9eI5xjJmj/2PtZz3F5GE5VvtaE+ghLCBDQNVyGbGeZyRHb2kRkoRuF9WvcWqsAaIwh;20:bstwoGdZrrryvWplthtFfPGzWzSVwowzx9UrWarHyjaUz4URbvsxgmMfWOqcNAIDq/ymib3MwP/RaW5NUsQp/9wwTCqoYoiFcKhAPwsH2Jl7CPv6jBL0izmOaLn2Cg+6hwjhFgTr2Mr6giPFdJ+DFEnI8pBZ6nujXK8c6CTDwP0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
X-MS-Office365-Filtering-Correlation-Id: 3f2a5a8c-d336-4faf-4e64-08d59daf300e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0968;
x-ms-traffictypediagnostic: DM5PR2101MB0968:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0968E31BBF8799003F6693F9FBBF0@DM5PR2101MB0968.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(37575265505322)(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0968;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0968;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(346002)(39380400002)(396003)(189003)(199004)(6486002)(53936002)(107886003)(81156014)(36756003)(10290500003)(6436002)(81166006)(5660300001)(478600001)(8936002)(8676002)(6512007)(106356001)(105586002)(5250100002)(2900100001)(7736002)(305945005)(2501003)(10090500001)(66066001)(25786009)(476003)(3846002)(6116002)(186003)(2616005)(59450400001)(68736007)(6506007)(486006)(14454004)(575784001)(86362001)(99286004)(26005)(102836004)(22452003)(76176011)(11346002)(2906002)(316002)(3660700001)(110136005)(97736004)(86612001)(3280700002)(1076002)(4326008)(446003)(54906003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0968;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: PykL0IQD0svzbE9QYWVBRFxXOYAK2PmQVaolw39POPgawNPVyMMe8HhTAS4Or6Axqyba7sL1An1s2XJswBzWezhzTm+g+1+y2YEPaWR92JE1aUDvpzp2wIftauW5Qtlla8QdHk8Th4bpprOq1IzngclRgVxnSQTUIPw0yhWE6+sdazc4ICdfPrAAdxjkmBBupekkbKducqBTHjOp2dxErGgE8BpXIlHwuVhNIWnOj//MyPlMbdGfe5QqvUzp6N6/xaYNFZGi7hfXcnHVKkuYXGnFS3RrwQDTLYn4ftMssK83tfIFElutcipJA0PYB5wQkuuTuue1hPmM29flzKFn2XpI3qTbq5aLAuIPd4GoXGPVrX+CVpYIE7YbF7DWb5e8uhtQR06leRZhjtihEl/qSMazL5AEomNIFINYFX+bLiM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2a5a8c-d336-4faf-4e64-08d59daf300e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:16:49.2156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0968
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jon Maloy <jon.maloy@ericsson.com>

[ Upstream commit febafc8455fdbb0ba53d596075068a683b75f355 ]

In commit d12d2e12cec2 "tipc: send out join messages as soon as new
member is discovered") we added a call to the function tipc_group_join()
without considering the case that the preceding tipc_sk_publish() might
have failed, and the group item already deleted.

We fix this by returning from tipc_sk_join() directly after the
failed tipc_sk_publish.

Reported-by: syzbot+e3eeae78ea88b8d6d858@syzkaller.appspotmail.com
Signed-off-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/tipc/socket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 3b4084480377..8efd2e42de30 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -2759,6 +2759,7 @@ static int tipc_sk_join(struct tipc_sock *tsk, struct=
 tipc_group_req *mreq)
 	if (rc) {
 		tipc_group_delete(net, grp);
 		tsk->group =3D NULL;
+		return rc;
 	}
=20
 	/* Eliminate any risk that a broadcast overtakes the sent JOIN */
--=20
2.15.1
