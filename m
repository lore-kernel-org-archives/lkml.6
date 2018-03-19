Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521495988-2-15824656388049840531
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
    t=1521495988; b=di/flwUmORCnQO2TFAA54QLfSqfoZ/ztGpfN3Kp6rYmrNx1
    J7tPzaLTcwe/IPgS0TTao/7JWEfmaCHR+hmYkTKc3hC6t52eeW+jEoXypn1GIppW
    x7jVsHIV93kL9FKIVO3W0O0J/1cWqDfLRbCT0N2UWwlB01UZ0ks5jWMzynMceP1x
    P+m4hJOw2NwpSRLJZqhdvE2IRuO+mXWs9GvVTeXxs24UUOKIMwkG76GLwyfLoD7Z
    EqGkR2Z4PFkf1jGrPKZziCb27HDAV8yXnnnrchCTEFY3lMqOXKAEf0n5w8HqhpCy
    y7rYDKk1vsd/wH6aV5ZE/GyEJNrzMVjk//MXODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495988; bh=EvwKOw
    s2eR5OURXBkb60yAeumPMb0LNmAYQLfkuIMe4=; b=HwjNY2kXbHmgD9i6rR+eFC
    GtPQJ12l1xN93yoNI+JUsyBEopJ8N4djAbP1BZGGa0Sc1KgxbjJRgeYsdyJcxLD8
    L3iv2CGdNuuAUsP2AQKg99P1GU0hsgP22xVM7K8QcJbh0uwD697ugUEiQxFsZhq3
    R+zxYfcgpZCsdmKIMBrYhID2+J0ROt4hvefr59aku3xj4q3KB9LQHmFEyiJYei1M
    Eji+VoClQFABrMfx+iU+W2WQVf4HAW3RAEnBkcs4JT452F73D0ZgXZFoDB4oLAlr
    1lKx05yXJAoS0OmZCtOoX+XRSU8gwSI0kOO4O7Gen2AKS1UBP3gClV6EL5BhNmWQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N2ni3C8F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejleektdenucevlhhushhtvghrufhiiigvpeel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N2ni3C8F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejleektdenucevlhhushhtvghrufhiiigvpeel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964910AbeCSVpy (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:45:54 -0400
Received: from mail-by2nam01on0127.outbound.protection.outlook.com ([104.47.34.127]:11541
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964922AbeCSP6Y (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:58:24 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 020/281] lockd: fix lockd shutdown race
Thread-Topic: [PATCH AUTOSEL for 4.9 020/281] lockd: fix lockd shutdown race
Thread-Index: AQHTv5sVHjt34w+3MkOUCcp8tAF0zg==
Date: Mon, 19 Mar 2018 15:58:13 +0000
Message-ID: <20180319155742.13731-20-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:rYL/O0nFyv071lKmXngadridR4Bh6eNSOZ3FHFoeEN7sfCCPVSO3L+CgJ82m8ufvqa4ePru4aBuSXmwLa0Pwi7TPQz4T2g6Kp1L2NMcndqrrhpxcdXTQLTP0wiT5e97FEc8BepzUplZVC0HMC37dmpf3F+udfQQd6O43cqsrEmHUTu+xrBzDfLw45w+d4Hqpb/Qiv5QaLCxchS614wfe8GuQk6wsuQgEw6MydbkgN+CDulpRbazm0eppZpbKtlG0;20:v8ay842u0sKybFSeOM+8LLEUdVMeIIRrvSqbUgLRqd6Eqp8lD2nwYyQNNR8QeuhkUT+Y/Wd74pDgIG+ITIi8OSj6A2us4Yn0NPDRwSbbS7EM4nGCfJ6YCp6BaV1ovkAeqbbRvp9A7Oj8kT69PRgHmeJewi9Qq2Ro4iv3Kbg0S2k=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f5b96b51-8935-48e8-0ba8-08d58db23889
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07268398AEA4FEFCED8FA466FBD40@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(396003)(366004)(376002)(199004)(189003)(81166006)(22452003)(2906002)(3660700001)(10090500001)(102836004)(53936002)(26005)(316002)(14454004)(2950100002)(97736004)(54906003)(86362001)(575784001)(76176011)(110136005)(99286004)(105586002)(7736002)(10290500003)(66066001)(478600001)(5660300001)(86612001)(6512007)(81156014)(36756003)(305945005)(6506007)(6486002)(6436002)(72206003)(2900100001)(2501003)(5250100002)(59450400001)(186003)(1076002)(3846002)(25786009)(106356001)(8676002)(4326008)(8936002)(6116002)(3280700002)(68736007)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: hukacUpH6XCfM+XJPQTPYYjNxgDMHZipN2AWXn8NbBOuzjyRaPLL3dd1FmRhqVj90IVqZmxxCF63qOJ+vX7csriPipEyNNyDnqFT4n0Pltq5WDcZj5+Z9mYRwtllPafPTB5l6OWdQLH9juIKcekNmYf8RhMKCEjug2Lrb4C6bP+gzo/sdbUIXmS1AGkK8EEpWoRzr91ejnlMTsUk2Va6f8+cVLP5p/XPDzLC910acsTYFa99CC6Ec0jRlQvD8KBYkY1zZfn8ixUuxc3pdyezMemUgWy0ZZNhsaZazWiQVE6aJs3thTn7o7aVgzS4+DB/uNAjXf12fQ1AixOqomMERg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b96b51-8935-48e8-0ba8-08d58db23889
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:13.3562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "J. Bruce Fields" <bfields@redhat.com>

[ Upstream commit efda760fe95ea15291853c8fa9235c32d319cd98 ]

As reported by David Jeffery: "a signal was sent to lockd while lockd
was shutting down from a request to stop nfs.  The signal causes lockd
to call restart_grace() which puts the lockd_net structure on the grace
list.  If this signal is received at the wrong time, it will occur after
lockd_down_net() has called locks_end_grace() but before
lockd_down_net() stops the lockd thread.  This leads to lockd putting
the lockd_net structure back on the grace list, then exiting without
anything removing it from the list."

So, perform the final locks_end_grace() from the the lockd thread; this
ensures it's serialized with respect to restart_grace().

Reported-by: David Jeffery <djeffery@redhat.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/lockd/svc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 9d373247222c..85135df0eb34 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -132,6 +132,8 @@ lockd(void *vrqstp)
 {
 	int		err =3D 0;
 	struct svc_rqst *rqstp =3D vrqstp;
+	struct net *net =3D &init_net;
+	struct lockd_net *ln =3D net_generic(net, lockd_net_id);
=20
 	/* try_to_freeze() is called from svc_recv() */
 	set_freezable();
@@ -176,6 +178,8 @@ lockd(void *vrqstp)
 	if (nlmsvc_ops)
 		nlmsvc_invalidate_all();
 	nlm_shutdown_hosts();
+	cancel_delayed_work_sync(&ln->grace_period_end);
+	locks_end_grace(&ln->lockd_manager);
 	return 0;
 }
=20
@@ -270,8 +274,6 @@ static void lockd_down_net(struct svc_serv *serv, struc=
t net *net)
 	if (ln->nlmsvc_users) {
 		if (--ln->nlmsvc_users =3D=3D 0) {
 			nlm_shutdown_hosts_net(net);
-			cancel_delayed_work_sync(&ln->grace_period_end);
-			locks_end_grace(&ln->lockd_manager);
 			svc_shutdown_net(serv, net);
 			dprintk("lockd_down_net: per-net data destroyed; net=3D%p\n", net);
 		}
--=20
2.14.1
