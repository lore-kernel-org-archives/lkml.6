Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520489011-2-10599095805264292850
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
    t=1520489011; b=jB3BJfLTdCOmnxMyTvJkiEui+5nsCvrTrOLGjPgx7A+ci5a
    0NgVSQRLTYqRYeMpr9jdLID3xOgNzy0CsdiyGrUN0UiXRlEYrju9S/n9HgHRlB41
    xQ/O19HOq9fLeAkAaPx5Km8wWcVxniS7Kl985ZmL52mQ1Z5YGNjcnA220TgQyHzP
    9rJui7ljaFnw0Hw3aJ73UMZII+re0crfh5h7UjZY10ZQykto0Ms/u5xIVtuskDnI
    a9Xqfx5X6wDTa5uU5gjqAD9RDvpxAB+xJh8OjA+mG9RIhRKzSPxjxw8nRFvlSf0W
    oi6lDr6DdfyGR4fpgZWrDDz7NvuT40WXgnmOqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489011; bh=PrRXTH
    2CrT0kDkdn7Qn31D1B+rXi1cPqh61Qb2IVoS4=; b=QxFvLSzRxon9bQDnzvrSPp
    1meDwnS3YTDC8Q2HCHs/xoXWaNFJFJMlIDC/dZxnwAM3A9UsQniAJdLHbfTNh+8S
    QojEwiuKrABiUYaJJbINhTh/mZ2e0UFwbI1FOOMieuhB+8HwvKTYzDu+FZqtplL6
    +QyQztWl7cH+muuNr6UpB7xY/v8r9J7y0rq0Jl+jqWWc6Y+Q7HnlE3ZwyfHv5F4z
    9PkWyXYhgxgJJ8ehIOj+kuHQOJifPYaEnMhnlAp4aTOdYEg5+sNGJOAWD6fz22wO
    fBwYhDyWB725iSOI3wjnWoedla0yCNRYdDrfwGwNUsK6pMle0F9t1619icBY8lqQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YvT3BOCR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YvT3BOCR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755380AbeCHGD3 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:03:29 -0500
Received: from mail-by2nam03on0118.outbound.protection.outlook.com ([104.47.42.118]:45129
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965875AbeCHFC0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:26 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 110/190] netfilter: x_tables: unlock on error
 in xt_find_table_lock()
Thread-Topic: [PATCH AUTOSEL for 4.9 110/190] netfilter: x_tables: unlock on
 error in xt_find_table_lock()
Thread-Index: AQHTtppDYaEQ0+HgWkOf6yzY0aojTQ==
Date: Thu, 8 Mar 2018 04:59:40 +0000
Message-ID: <20180308045810.8041-110-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0997;20:w86SjcWeEHq+jo23a5KmkhepKQVW9wBbYPruF+Ix8ZzMFvkDV68G+QdigbgXegt6r/9Mjsr8zyZp0fxFNpRj2JeIwL9Xw9e9amRhhowjlVYLW2hhzhcLapYFOzHQzsnjBQXd/n0K6GXllTzcJxNEmqpW+tYTCyzdkxL8ISCjjbo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7be32a0-edca-4705-27cc-08d584b1c2db
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0997;
x-ms-traffictypediagnostic: DM5PR2101MB0997:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0997BFF1BDC384D72FDE5B43FBDF0@DM5PR2101MB0997.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0997;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0997;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(366004)(346002)(189003)(199004)(97736004)(54906003)(76176011)(2900100001)(106356001)(99286004)(110136005)(316002)(3280700002)(22452003)(10290500003)(105586002)(36756003)(25786009)(72206003)(66066001)(3846002)(6116002)(3660700001)(4326008)(14454004)(1076002)(478600001)(2906002)(10090500001)(5250100002)(6486002)(86362001)(575784001)(5660300001)(186003)(305945005)(8936002)(81166006)(2501003)(26005)(2950100002)(107886003)(81156014)(6512007)(86612001)(6666003)(8676002)(102836004)(6506007)(53936002)(59450400001)(68736007)(7736002)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0997;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 4H8M/JuI6xGr+eQyJoMi7+pVim9gk2HbV0sNmF5YPWQplRpfJB0seFSqHdyCMq50zEneyCh6See+xWtefGknQ++qacdSCBwj8uHaJR2UdnYW6fXcW3rsu5MZbQTzyUr2ltpf3r/fPbI9PCwt/mGBI625RBh8ajUNF/U0hCVK2hqh/5YmOw9RzzQk5fQ0DypaZfvSa94j3W7h010f3BeZatRYCu5ui8avo3pS9uPSUBjCDWBzXQn8fRT1ghGZTuBWC/Cr5xpzyWLLVcOaKNTibCsQgdpcuBDEfQJ7DEIJh6UFykIoWErACBlfHvGa9WvINac0Hqt6ZeExd2OuC+o0rg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7be32a0-edca-4705-27cc-08d584b1c2db
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:40.4005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0997
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 7dde07e9c53617549d67dd3e1d791496d0d3868e ]

According to my static checker we should unlock here before the return.
That seems reasonable to me as well.

Fixes" b9e69e127397 ("netfilter: xtables: don't hook tables by default")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/netfilter/x_tables.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index e47ade305a46..fdf90221b4a7 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1004,8 +1004,10 @@ struct xt_table *xt_find_table_lock(struct net *net,=
 u_int8_t af,
 	list_for_each_entry(t, &init_net.xt.tables[af], list) {
 		if (strcmp(t->name, name))
 			continue;
-		if (!try_module_get(t->me))
+		if (!try_module_get(t->me)) {
+			mutex_unlock(&xt[af].mutex);
 			return NULL;
+		}
=20
 		mutex_unlock(&xt[af].mutex);
 		if (t->table_init(net) !=3D 0) {
--=20
2.14.1
