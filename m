Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521475392-2-4540868533325550857
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
    t=1521475390; b=SSHfTODFkxrnmieZy99Um8+HjMe56CYeNlFFvql6jwFstZ9
    sT5TN1Re3uA0p74lBgs+fEGjoV8C5TJsb3xvwkKKEi/VlCuM/6QSr6gvLK4+wXPI
    ggX08Udqxho7bLi2P32ug3bPIPf+re0UL76xzrOJecxRQreXAp2K22+kYCDnob6u
    Fn6HE8vNSu1J/9XDITJtRfV4V79cgKbNC1mlb50NB+7/v8NT66MVBPB2xd5sEQSs
    8xPgG/jGAOk5PsOB4J+K05oFcAeBszB0scNs7AKi3x9wJ5E+MVpQkwIK2NSb+qi7
    8574Qb63/RXfQwhQfg7KKnB9KFTG40lTWfDSTZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475390; bh=pjnORH
    9g+3ZHf6Ho+xUJ9eJA975ahLojqqNag1f2EEw=; b=HA9bPjtopLe8i41LP1IGH9
    m/XUBMPNJqSnGhI7fDdluTAjN1IMDZL0b5ELVb3CNxYHaqFCYuU1qSNVSZghlh2w
    LVGkcSltED0JdsbxklMiEE/s/9Dk2YEP1TbVr1BvABV+m6phVE+o5lJxlo3qbGE4
    ghbRTbpiaMXAZ/e1wuMX5LmBgPHQ6BXkvCKDnzky+Z7A3J8pfU/g2W+rR+KapvJs
    act8MgfLoCFyrBXwFj7lRG33Mt3SAmYgwugkZ4e5JEYtDkPWshz90o/RkWsb2Aen
    XccO7xKr7s1jeSx93KbCnWgBI3sQWDK5m5It7NZh7UWtWHHvhvSgtqSliQ5gdplQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kN9vubRP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekjeegnecuvehluhhsthgvrhfuihiivgepudefle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kN9vubRP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekjeegnecuvehluhhsthgvrhfuihiivgepudefle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965532AbeCSQDH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:03:07 -0400
Received: from mail-sn1nam01on0099.outbound.protection.outlook.com ([104.47.32.99]:27264
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934981AbeCSQDA (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:03:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: NeilBrown <neilb@suse.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 168/281] SUNRPC: ensure correct error is
 reported by xs_tcp_setup_socket()
Thread-Topic: [PATCH AUTOSEL for 4.9 168/281] SUNRPC: ensure correct error is
 reported by xs_tcp_setup_socket()
Thread-Index: AQHTv5uAdeIMJXyjx0qz+rIdGxmLcA==
Date: Mon, 19 Mar 2018 16:01:12 +0000
Message-ID: <20180319155742.13731-168-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:hJv4AnfOfSpWMoWuidI7mPTLdlywrcaTXJfJSPv3F9h26N/aLa3pqAgq7dVQ7x82NnrlSKwVv1o+o5jgDdN89sgx02oNcLRda0g4gpM/2Y/Kqr+c5/mC30pcd7tywGEq6KmdLQieGunioWoaU8NcwOco8aS2pxH2mgi/He5tDb5Kf68dLZ3vqx7DiHlfNDGX+0TjZolp6sc9Ch856XNo/xWupOfVrlBn6B/ym08TVnSkolQuyLQWqqMraoWssG9y;20:iUTT2JyMebVvzGs/A6B1N8H7fn8xylLqjS9siCUfR08A5GEGYIQ1YjwLqc+rKMrkzftjJjTldzE3UUulbqLC2VXaaOaBKZyI8BNJYbAHBQqeMckZWcyl2XubZHBunXr3D2xR/9ifdSoRkm6cmaYGZyyKE8DD2jVrOPypoETHHB8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48968e3e-b44a-491d-037d-08d58db2dffd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725391EA98DEAD98EE8B552FBD40@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(366004)(39380400002)(199004)(189003)(2900100001)(4326008)(54906003)(10090500001)(81166006)(316002)(2906002)(14454004)(110136005)(107886003)(6506007)(186003)(81156014)(22452003)(68736007)(53936002)(59450400001)(3660700001)(478600001)(5250100002)(2501003)(99286004)(36756003)(105586002)(6116002)(3846002)(5660300001)(72206003)(1076002)(2950100002)(6666003)(305945005)(6436002)(86612001)(66066001)(10290500003)(76176011)(97736004)(8676002)(7736002)(8936002)(6512007)(102836004)(106356001)(3280700002)(6486002)(86362001)(25786009)(26005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: p1VOF6TyJrKaS+DrjjbSYknU1edMLrOxD5T1soBcSYa5phcxbHQJfCInA16AX5IJQZ8Oa2iuPc8xtAnSQhJigZy15Gv38Y04hlDu0iGZqLwRQ2cgYspmioPpPw49WuVB0YDn5KwNEgreQZ7ynYVfdT5auqvEqvfag+DnG1FeS8SN0Woohbyaa2nMnm55ImaYmb68zRWo7D80Aytd2NUmyC8fHpJS+cq39zVfTQMmIEsSw4gOn6C/J4UCaj+mO9ffGBSrsDXZ3J4EdUdNcV5Ec2VD32bb3Nos1pRbvSPUHlrALy7uH1ad3AA0VhWRliQx5Qs7zX1kBZzU0dxtL4kfjQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48968e3e-b44a-491d-037d-08d58db2dffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:12.8049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: NeilBrown <neilb@suse.com>

[ Upstream commit 6ea44adce91526700535b3150f77f8639ae8c82d ]

If you attempt a TCP mount from an host that is unreachable in a way
that triggers an immediate error from kernel_connect(), that error
does not propagate up, instead EAGAIN is reported.

This results in call_connect_status receiving the wrong error.

A case that it easy to demonstrate is to attempt to mount from an
address that results in ENETUNREACH, but first deleting any default
route.
Without this patch, the mount.nfs process is persistently runnable
and is hard to kill.  With this patch it exits as it should.

The problem is caused by the fact that xs_tcp_force_close() eventually
calls
      xprt_wake_pending_tasks(xprt, -EAGAIN);
which causes an error return of -EAGAIN.  so when xs_tcp_setup_sock()
calls
      xprt_wake_pending_tasks(xprt, status);
the status is ignored.

Fixes: 4efdd92c9211 ("SUNRPC: Remove TCP client connection reset hack")
Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/sunrpc/xprtsock.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index d24d14ea8ba4..1bf9153004cd 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2384,7 +2384,12 @@ static void xs_tcp_setup_socket(struct work_struct *=
work)
 	case -EHOSTUNREACH:
 	case -EADDRINUSE:
 	case -ENOBUFS:
-		/* retry with existing socket, after a delay */
+		/*
+		 * xs_tcp_force_close() wakes tasks with -EIO.
+		 * We need to wake them first to ensure the
+		 * correct error code.
+		 */
+		xprt_wake_pending_tasks(xprt, status);
 		xs_tcp_force_close(xprt);
 		goto out;
 	}
--=20
2.14.1
