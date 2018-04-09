Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523235963-2-8959819035586362519
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
    1523235962; b=eQ6Fb8Y8Pw9f1NoOatIqbVE0c6lpDaYe4aUCzMIAxqvbsPz8uI
    nJArA699uJYnXvI+kyquA8B/VC0DmCu172cW0vQFxsmv2MjJEbDz9m/X72/uvgGm
    5vOLFpEZq2GDN78GJJ3BffvtAmgL8o3S4yNMZaegdegYZiKlR2sWzuFgMPmJuZJ1
    xZEXiDKjHZNdxsbtDNRMLJPmX9lwmx8jUs6XhKbcKLfkDzGI5tw2oe/Lv1gj2jpC
    eIKdjcQ1q1tdyw1PPUlLf2y8TGKJNJIZQttBSvTWwGkd2nOTjl6SSEhXIxqE+GYc
    ve9FdcU9jnDqbwIF1lZ4k1FyNfSDipob6QuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235962; bh=SuHhaq51Tq
    BEz+88A0d9BbfeOaOdTgWJBQhQOoFia9I=; b=a12YEQ6KFq0ji+Ds/b71o/sCYn
    DtvJYHB/v4vd/3wv7ldSf+tpLvpCvGJWmbGcqgcDZ7wv7lLJsKG3Dk/QCFjCm44O
    9kNK778jQfzyrzj7PIeglu1FXC6Z/dEhD7AjDUEzt55BhuoSueo+npP7k4473GFp
    0z0lVjzGfOq57yysoLAM9bn1kU+3k2DUK6y9EDU578cZcMxp3waQ32NvW5Py+VXY
    C5+1n4l+iJPxEHZ4gV4Az9vUfIgz94g9R6wKSjRAXxQA2kUzARQpEZDEgnBpPqTy
    hr/h8aST51z4hww+YWDEINZZQzHDtnRy9/8jGbkwJZJyWFF48h3tBEdXc//Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZYfJ0XSh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZYfJ0XSh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC1J00U0Ur/kwPmUEB3xmVe9wCI+I73590nDog43Jcuq0dqBOwf2E8Co3WAE7r0LL2U788NBEphGpLf/AG4vgnCUL2mBRuw81vHU3iXR3K67j8ymvFFW
    SM+NVuCsQOe9glelVFGNCmXJrAsUdHN6PJJKabudPTjYCbPkbXPIuOxeBSk7qc98PdbDpU5/xRlYkW9VAlGtHvY0uZzjyPxwqNqw4jVxDgWUjx5+8CPCNyyJ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=Z4Rwk6OoAAAA:8
    a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=XapYkokd9fjVYds4b-UA:9 a=wPNLvfGTeEIA:10
    a=92Q717GQZsEA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933116AbeDIAj2 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:39:28 -0400
Received: from mail-co1nam03on0103.outbound.protection.outlook.com ([104.47.40.103]:45124
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933110AbeDIAj0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:26 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 161/162] locking/qspinlock: Ensure node->count
 is updated before initialising node
Thread-Topic: [PATCH AUTOSEL for 4.4 161/162] locking/qspinlock: Ensure
 node->count is updated before initialising node
Thread-Index: AQHTz5nicqXB/srxrk62KE5Agd7zKg==
Date: Mon, 9 Apr 2018 00:29:56 +0000
Message-ID: <20180409002738.163941-161-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1047;7:uhup+F5q6U6FjtrCNZydskw9NxalxYvX+tSwRhptxkD/A8M43ba8vGZbNiO3UFP767OcDrRcCkdOoZ2OaK0gBLbhDBYj+ujkcvfqNN2E08ByUOO9AC8iAHbq5NLvcgayAOpKWWpc9IpYZHHjhM5/7sYzOK5G2+iIRC2wpJTrYUjTYyFSddnS7BN3IvwuKJPeWymTbpQqqzvO57n5hZvPeUgHIzVyfYT8tgja4SBxxjmr7S5k0CLXJEOyjj4ZRVXn;20:6b/A41pcf/nfDeKsdWjHwH0huJ/csKbkvz08xYc4qIhnMgi93zNDw014chWFfFzTAz7uRfETS3teDrq65S9wpRu5anA5zOa13JcUYyVSCFJ0bVF4xnPrnnXxMJ9Ep1dCa6tIPz2yuPa8J4vmuyhc5TKgvExfEwo4H28/jOQPDC8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 17e2c5dd-39de-4871-fe22-08d59db25726
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1047;
x-ms-traffictypediagnostic: DM5PR2101MB1047:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB104711994D1810F13F6EC78FFBBF0@DM5PR2101MB1047.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1047;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1047;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(39380400002)(189003)(199004)(51234002)(97736004)(3660700001)(2900100001)(2906002)(8936002)(11346002)(3280700002)(106356001)(446003)(68736007)(72206003)(1076002)(966005)(86612001)(25786009)(3846002)(36756003)(107886003)(6116002)(81166006)(4326008)(486006)(81156014)(6306002)(6512007)(6436002)(53936002)(14454004)(8676002)(26005)(5250100002)(86362001)(105586002)(6666003)(305945005)(186003)(10290500003)(7736002)(10090500001)(102836004)(6486002)(2616005)(5660300001)(316002)(2501003)(66066001)(22452003)(54906003)(99286004)(110136005)(478600001)(59450400001)(476003)(76176011)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1047;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: iutPlE8DdaORd37gPk/wjAgcFPT5vYXpd2DttRGp0T+gcZT4jKveIOAalWIirrmo69Cw4i4ypqmoDPfe4j3hXBdTu0T+ttX8H3sk8FWxBC2AdH+ngZ+rjccr+J/C7bDNJy62gqO+J2koHZ2GJVBRGzWqcVztFmtZqheOTXJxwcQA1djlytkK2QZFWwC7Ek7Ex2Q+NYUuJO+nlXo3tItdlyuc9KozbRaoQQ9mZfhY8nR/6Zn6aMDteQl84bzE1oIGmiA3zmRI9vD5kM8rk5OktdWOJoyVYUGWiBsM5mL7D0Zce1/5huse+DfeLN/G1Di/zKSfe6SZgLDGu8wWNuaPi+AuydCdpPsteO04exHkEPSq7HageO9GdNP7C3xN3+dAEhRGiNjpHPVacmGCJF5av8+x/bOOzuXm+RkApg9V2Pg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e2c5dd-39de-4871-fe22-08d59db25726
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:56.5684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1047
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit 11dc13224c975efcec96647a4768a6f1bb7a19a8 ]

When queuing on the qspinlock, the count field for the current CPU's head
node is incremented. This needn't be atomic because locking in e.g. IRQ
context is balanced and so an IRQ will return with node->count as it
found it.

However, the compiler could in theory reorder the initialisation of
node[idx] before the increment of the head node->count, causing an
IRQ to overwrite the initialised node and potentially corrupt the lock
state.

Avoid the potential for this harmful compiler reordering by placing a
barrier() between the increment of the head node->count and the subsequent
node initialisation.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1518528177-19169-3-git-send-email-will.deaco=
n@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/locking/qspinlock.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 8173bc7fec92..3b40c8809e52 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -423,6 +423,14 @@ queue:
 	tail =3D encode_tail(smp_processor_id(), idx);
=20
 	node +=3D idx;
+
+	/*
+	 * Ensure that we increment the head node->count before initialising
+	 * the actual node. If the compiler is kind enough to reorder these
+	 * stores, then an IRQ could overwrite our assignments.
+	 */
+	barrier();
+
 	node->locked =3D 0;
 	node->next =3D NULL;
 	pv_init_node(node);
--=20
2.15.1
