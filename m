Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521480048-2-2814462647204984937
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521480048; b=os5yXX4BFTclfvVqHhs/5CvKNCnzVCAV84pvbZRDwFKyh4H
    cbswibZ6JpduISSnT6jO8WZ2RrmpplseHoUvPKcoPzCkIAucGJHDj2UudL1GQ8Br
    cHP4JjOO4ZhU+EDxCWC56ex2R6ZVyPropBZXJ7+tUoRkJ64V40qojqdh4UfGLpRW
    FJLKqC86nx9PWHZAfSRVC1Ofm2BkOoRcf8E58UaxLoUqIPxj+bi9Ij+nfVtT5UbS
    vsW524RkWJiRokC0d7huDGQ/AtQicPbNAmYK5fpsKnN6qBsT5qaYax+HcIRQ11JA
    C0KPergOBbKXdwty68rzSDT8OuC9RwIY8AiezKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480048; bh=yUp1xD
    8fjBTLk697rpNllNFGsML68U/P7wvjmjvDzl0=; b=jXwaz3/tCh1BQRKN9CthR7
    eojoPOSDHuCZMFL0XDLBoaARFxDFVP9Uuuc8fwDDgma5KVaBi4zfM14KdpJsTUSC
    ehWh1hcGyqmcor6uk0GFmn6limF7JSVrdF/Ka54fJpG62AnUNuQMrpgBnUHS95vT
    skv/qr0sR7Jkif995QuH5N8fMVJ2G94m/nt3y08n6bgDBkQG94qDiw/I46Hpg5DU
    ibL2NFCaj4De27rGclI7D5J25GPdM/wbOajqjHtYU8le9uDTdkNqPEzlSBp2+yTz
    627g0b7hAtG2dXG04Z+zxcuxMAP7fF0AY6XpRFS5cWh9Y57l62EEVLUMQ9IOF94g
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OJ6g80S0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeehieenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OJ6g80S0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeehieenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966366AbeCSRTZ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:19:25 -0400
Received: from mail-sn1nam01on0124.outbound.protection.outlook.com ([104.47.32.124]:21024
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966421AbeCSQJP (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 086/167] rds; Reset rs->rs_bound_addr in
 rds_add_bound() failure path
Thread-Topic: [PATCH AUTOSEL for 4.4 086/167] rds; Reset rs->rs_bound_addr in
 rds_add_bound() failure path
Thread-Index: AQHTv5xVg8RK15FBe0OUAbOG2gUpCg==
Date: Mon, 19 Mar 2018 16:07:10 +0000
Message-ID: <20180319160513.16384-86-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:Fxzd8uBjOtCsQEmf5U4gC965nW6SRA2liD3RPXSTJ42bo/IgfRtDdpau/7I8LgsIvYVxvymE86EEb1ubrN4+Ws894SdsOzaFLzd0zXzIjDOC/q54LQXXtv35W+zByYm/GnKhZxfJ8+QEI9sd3PgrltZU4Of5jHYgfixqweJt2AH0A/6N+UxuUJZc864rR+yNxBtxMjxYHIf/a2QBcSj7M23oG+UZMf08/C4MYgNYZcPXkTAADpea4Zd+WYlFnjet;20:x8B5dulVWLymI5q8qZJDJuZ7ISaed6rzXi7pZd/fL3PD5xnWwwyMJVrVCwoAnSkQGZg3fBLpJASFLc3UKm0ctZ07g63Yr0fXqrEahURxp1yvfaGlYohmxQsMNSctpxoL3gPEDXygaDXc4fJbBynzqQD3fJR3VSEOcr/w3r5gfr8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 47d51788-0226-4c90-11d2-08d58db3be32
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09026A5D61E1E69D30D1EC52FBD40@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(396003)(39380400002)(376002)(199004)(189003)(4326008)(305945005)(7736002)(66066001)(105586002)(316002)(8676002)(25786009)(8936002)(6666003)(2950100002)(5660300001)(97736004)(81166006)(81156014)(3280700002)(22452003)(99286004)(186003)(2906002)(76176011)(5250100002)(59450400001)(54906003)(10090500001)(110136005)(6116002)(2900100001)(3846002)(2501003)(1076002)(86612001)(107886003)(106356001)(6436002)(6512007)(575784001)(86362001)(53936002)(6506007)(6486002)(26005)(14454004)(10290500003)(102836004)(68736007)(3660700001)(478600001)(72206003)(36756003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 4+zKtPp4CadaBFj/0IkSZ4Tuh9oDAtc9fwm0oJv3OFtBd91tSizcdrvaahzZ4/1jKq2342s02p8CbyP4RAWhNJAJZC8pRB7dR2swKsj+PKNx1eLN51YjsAzw5lrjLQylgSW1UUBsxDmo1HpddF0XzUok+X4c75xhdSl7OrPyOeK29qbDfl+pw/WcJ2kwEiQUaBLrvORozBrpuFI3i7dy309sScLk563XutshlwAtk/KGOL9S41Pfhwtnl/L34RVq9TNoeYSGYlU5WcLP0ZSiBgZn/1si1zx3P7DfEJ7Ap8inRnVKDSb90cUuT/vekPTtBdxWKoobIeoBLKfM5CKKxA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d51788-0226-4c90-11d2-08d58db3be32
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:10.1148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>

[ Upstream commit 7ae0c649c47f1c5d2db8cee6dd75855970af1669 ]

If the rds_sock is not added to the bind_hash_table, we must
reset rs_bound_addr so that rds_remove_bound will not trip on
this rds_sock.

rds_add_bound() does a rds_sock_put() in this failure path, so
failing to reset rs_bound_addr will result in a socket refcount
bug, and will trigger a WARN_ON with the stack shown below when
the application subsequently tries to close the PF_RDS socket.

     WARNING: CPU: 20 PID: 19499 at net/rds/af_rds.c:496 \
		rds_sock_destruct+0x15/0x30 [rds]
       :
     __sk_destruct+0x21/0x190
     rds_remove_bound.part.13+0xb6/0x140 [rds]
     rds_release+0x71/0x120 [rds]
     sock_release+0x1a/0x70
     sock_close+0xe/0x20
     __fput+0xd5/0x210
     task_work_run+0x82/0xa0
     do_exit+0x2ce/0xb30
     ? syscall_trace_enter+0x1cc/0x2b0
     do_group_exit+0x39/0xa0
     SyS_exit_group+0x10/0x10
     do_syscall_64+0x61/0x1a0

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/rds/bind.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/rds/bind.c b/net/rds/bind.c
index b22ea956522b..e29b47193645 100644
--- a/net/rds/bind.c
+++ b/net/rds/bind.c
@@ -108,6 +108,7 @@ static int rds_add_bound(struct rds_sock *rs, __be32 ad=
dr, __be16 *port)
 			  rs, &addr, (int)ntohs(*port));
 			break;
 		} else {
+			rs->rs_bound_addr =3D 0;
 			rds_sock_put(rs);
 			ret =3D -ENOMEM;
 			break;
--=20
2.14.1
