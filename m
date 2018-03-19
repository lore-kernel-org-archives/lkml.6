Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521478269-2-7742187162985654945
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
    t=1521478268; b=jhBp+j1g3HCwM70s6Biki4ds5PoW7p8bXW50AQ/TR+/RBSl
    tK1mFMzlId45bhmTiQAejlB92cqPUm68/kkuOKaaJz3DKWCgNLPauVCWD2E1WM/B
    85gQymBLfD0hPD7TbCq1K/LlXA6QdM59yTNBZl5p1LqS3W3A8I4nLEwNVK/PzZL9
    JWWgq5VGCRqxb6Po2EuvC2XcPdB93KQT8OhPcTaj/RCZHUJOEpOKJGyVDiTIM66n
    fF1uXR0gKRCJTLIVoRL8mmNBjofA2occ/GWVBq3H74pO1Gjk2Zs3zowkHU/PcDJK
    tNojPl5RVHIqpYbWsVGV5LKkIKhDXgGpIvaSq3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478268; bh=SdqNZl
    /voLIdtjT/6QT/vZjGXPYz7iOYbwvBetUBDG8=; b=wZZg6cZfr4ePbTER9xldAp
    xfJPcSKsKghAqgwzGpPLtB5wYmZmHJO3DvUQL2GsfW+pCnl4Wec8hggKo4J6VppE
    4CrulVNLzCnz1dHw5ARXRq3PC6+/Nm5Eq08Nv5fk+6yF3mK1JKYkkUXFR/IulCwJ
    wbCVYe4fsoMpU5iZjj9wRbC6YpYpIvi39ZiML8/g/C0LLEyvLABhBWrMvyHguWH4
    tbCUVJACesRfdeDwhYKptUYOb7ePt898cnbSyc6FlZJrZ+9FFt2b1dwlCYRRUuVx
    OW+Ibww06NeG0YaIXUWhz0YXn442aWqZjmXG2KkPiRhXS6g8Cf9DkGV+9z9eYrlw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BmekOd3C x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeljedtnecuvehluhhsthgvrhfuihiivgepieeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BmekOd3C x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeljedtnecuvehluhhsthgvrhfuihiivgepieeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934919AbeCSQuh (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:50:37 -0400
Received: from mail-dm3nam03on0111.outbound.protection.outlook.com ([104.47.41.111]:6417
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935168AbeCSQLu (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 008/102] lockd: fix lockd shutdown race
Thread-Topic: [PATCH AUTOSEL for 3.18 008/102] lockd: fix lockd shutdown race
Thread-Index: AQHTv5zzC5Z53QJ/mE2W9lFRQfqlTA==
Date: Mon, 19 Mar 2018 16:11:33 +0000
Message-ID: <20180319161117.17833-8-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:Gw7su1Jpo/xTyudzoATG8wbA14bcMXs/x5KN9Zyi8oVUw2OLPUnh765jWRvLjyUMJA2Z4AplWdFme8uBYDdV9+dD3yY+WZroHvb5SJ++WxVlj3EGU4MtBx5gL0CxCFj7JCKtJOPFX3UVPEdlxBfRyWOluh+dlqGX8bwYaxzo7ycuiixheR/glnxMkNS+0I18bRWpn3i5xlM9ngjeZvT7n2bJ+dCL2c2bGs/zMNgUW8tLYJvDIruNzMpUEjxDUGUn;20:c5aKV6SCAOGJkv/wOxATpGG9kLIjVZpspRHN0KRYwDKkK66GX4xfbkBxLZoRS7seMA9kgRs+F4XIp+l6DCbtnqyW+EVhjcujCNJzm/KoQQLxvYsrJz0ZTw8+mOMzqAEUpGZOGO3aaM0r6NdwuU4fCGB7q64NjSIoJQVQBHy/S+M=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04ce3355-3aa7-4857-d519-08d58db4159b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08059FA077F729C2E7C0773AFBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(2950100002)(305945005)(186003)(86362001)(6506007)(3660700001)(5660300001)(6116002)(8936002)(3846002)(1076002)(26005)(7736002)(6486002)(2900100001)(6436002)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(59450400001)(8676002)(14454004)(105586002)(107886003)(25786009)(478600001)(2501003)(5250100002)(53936002)(3280700002)(316002)(54906003)(4326008)(6512007)(72206003)(66066001)(22452003)(10290500003)(99286004)(76176011)(36756003)(97736004)(106356001)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: C+hEdHEQyP7CXw2pp3jeLCigtHN2R/9X9JoAPqiX2ScTKdJOV2bk73VPHLOvS/U/QWs3t0bFMo9yCvtqdcR3WH2KUqsQ93XswQZTxjwo1sfG/pMeIOJ+ZE7uV5uvxg8tDpP6tI2jZjOQkqsWj0am+krk1qQwj3TUrgaiuSMFuDvk+2GiWaK1cPIGCOtyh2cHkgA42dxzfLcJtY/8doP+JB3PF8sIkKuflUZtb09tHc9WKpw7MCh3989k+3gzZ/ro7dVBDcvXkynZhaVaN5HUe2ni9OYsfHQh4L4T/ZSBxwGLlG/ckGDjQOdvspHKQrhr4qvBF5aoxuKbrQFlHgCYzA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ce3355-3aa7-4857-d519-08d58db4159b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:11:33.7766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
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
index 61024987f97b..12d339ee6e06 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -129,6 +129,8 @@ lockd(void *vrqstp)
 {
 	int		err =3D 0;
 	struct svc_rqst *rqstp =3D vrqstp;
+	struct net *net =3D &init_net;
+	struct lockd_net *ln =3D net_generic(net, lockd_net_id);
=20
 	/* try_to_freeze() is called from svc_recv() */
 	set_freezable();
@@ -173,6 +175,8 @@ lockd(void *vrqstp)
 	if (nlmsvc_ops)
 		nlmsvc_invalidate_all();
 	nlm_shutdown_hosts();
+	cancel_delayed_work_sync(&ln->grace_period_end);
+	locks_end_grace(&ln->lockd_manager);
 	return 0;
 }
=20
@@ -267,8 +271,6 @@ static void lockd_down_net(struct svc_serv *serv, struc=
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
