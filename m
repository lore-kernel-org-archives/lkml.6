Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339826-1521479793-2-120284021564423818
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
    t=1521479793; b=huhyzexXGuRwQbwn5oZS0pSRYGyrvllvlWbSVWkMYJuHn+D
    oks8K93tLdZmKrzqWKUjrKywaWrWrJupc7mMyXjw4e/FsFTjB7TNimzfnrjkC2HI
    UUkU/obENinGegvu2WzfC7j2lCnWJWyQhmidZsIheyUCL/tv2yWQiJtMCJ56s4PG
    p2R9l0OHcJLey0vgg0zq9JlEPkFgPNb7ZiUxmWW9WBdfklg68G70PVuzRZoF7A4h
    A79rGG2S/EpbrI61KY4nZuifjTP6TN16XDNKy0u27Ww5k4O6pYs9KWsuqXe8v8Aq
    Qq1ElaEYnMjH9LdG90HMCUDdIU5NPMIBSfwGTqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479793; bh=Vi2ffZ
    zl+sN8YDDRYuhBx8scQHZ5xk64YRAu22YR1a8=; b=IMIOpJ3pcGWRreFjZuWOiH
    fwfqp0wBhxXb4WHC1FUanJodWss/+JViVb+cqNdrhN6QaakTrKsmEyKwg0Ne6HrM
    I7fUDhh86znhc/jhcfES9Db8BZlhojfSgmPcfKZKD2WyC0PRiYtJjqgV8TBq0hs8
    O9AdqwMABQhl4X4fGax+kzBLvY/jTs294Q4yVgrOIG912T1uxdlM7SOOX9E7pXGn
    yv2QNZyBqzHL+NbON9WoZBV8GzokQa/Evg5f210m4mRH51ZExNGFjsULoHYsfXUZ
    jEE3Gl3nLonC35s2FbMqGlkRuidkYWuEWXQUIltpxPe8yu+GpkenwvRk37kUBCMA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=D+D6P0ks x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekkeehnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=D+D6P0ks x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekkeehnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966566AbeCSRPP (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:15:15 -0400
Received: from mail-by2nam01on0111.outbound.protection.outlook.com ([104.47.34.111]:9825
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966548AbeCSQKC (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:02 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: NeilBrown <neilb@suse.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 107/167] SUNRPC: ensure correct error is
 reported by xs_tcp_setup_socket()
Thread-Topic: [PATCH AUTOSEL for 4.4 107/167] SUNRPC: ensure correct error is
 reported by xs_tcp_setup_socket()
Thread-Index: AQHTv5xlC0/jzdm3bUa8OdLoF4Yf9g==
Date: Mon, 19 Mar 2018 16:07:36 +0000
Message-ID: <20180319160513.16384-107-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:IzH4vINZqakoR/AAr2dO+bANqzpoewM9YXX5vA3j6y6KuJ2GKiHFKc4FQwzBxJfACuv3gf4eSkts+FsE3lI+NnqITqbWCfyFF4t1yzBfRWxfOBvhc7RDT1l4rI1aJnbwaVCaLd6mdeLaa2SuT0yp2Oaf9LrqcijJHRePUS3U1C8kGnPIQF58ITMgut9V9qgjpP5Ga/JxzRCTaouYMyKWnV5M5mgLHIfkS11ZvOFQEwYnQ1ebk2bb466QmuFVlE5l;20:wp0noioLl5sAa8cCn4bEcDtpleamgCebg2vpmrgP7opMwwA7CJSZunvwUTt8/Ks62mND7sun/UQ9KXPzBexwZ268tPofVPbfkrJnE8sKAu5lC6LydExc5RcF7E6M/9hOUguUJc2VU2Bvub1npGgY16S8+pMXfy9xKvOdBEHDuTc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 661d3471-8fdd-4480-e261-08d58db3dbbb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09197AE9BEA860C6FC72FA13FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(575784001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(59450400001)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(99286004)(102836004)(106356001)(72206003)(81156014)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Xeq5Gmozpyf0sQuhOVXdNT8uBIcMRQT2VJ7Q/tc+SXfxLAyAC/RjR3PIIxZYcqAcSpKb4wr8SyD27o2uqBeHREcR3jmG7mDIajskpp1wLNdG2gZe7eLFC9r6D6bJYz3wu1UnskV1jsdyrvcM0VantNsLUiNJuZ9YSPCL3okI/unm1/Va/BhK8aK9E7uiADVe6xjyQ0e5EoAbhcnnX1KA80HpL0MFNNmQgB/AiBdKHJoJz/drzSsXpS9SoNjLcGhnFoiaScix4t2aNZR6EHtLtEPRGfWZjVXmj/bXH19kQhH01GICZIQAvQhwZKc5SCmdaHODEgNRR6cFlh0gPKdJ3A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661d3471-8fdd-4480-e261-08d58db3dbbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:36.1822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
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
index 728d65fbab0c..c9c0976d3bbb 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2363,7 +2363,12 @@ static void xs_tcp_setup_socket(struct work_struct *=
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
