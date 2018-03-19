Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521477658-2-15792204698685627338
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
    t=1521477657; b=L7xrDY2WRUqrcS0iXIVMrYBz1CNUyHwkBJ7x+cViwb1foPp
    93dWTN/m95ytkArSL5kIQue3YVw005QQ1cDC5p0ahlohpBv+WpLaLnAKYqH2j6C6
    ISyAQiPTyEwzZ3dSThk9cs3gtBCEn3wu5vdu4y4zchQAAMgze/Cr/1b9PUrKl5mH
    KhoCxfvtKFNWDWzT03I8A7GLlNBje2pyIonng9QSJLUbW/TI05gSVWH8uUilTQp2
    64E3QndkTdThtusiDX3aWqvSgJSowP666Gic1uIIXcBmKrNKJtERYYF+Ei8ZYDH4
    ofZpB8gWIGuc4jnVjYQaAyXu6T1m7+UcMJHmKNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477657; bh=1lid0k
    OKIBvZINx+ORVKbTHYZ6YCFnGWONletGAJXMU=; b=s9HhHMvx+AqURId6qey5Zl
    5aj9WqfOsE4LM2anHKgpJBgSELi95xn1Ate+q75yZWvrJqsZ+KV/hmr/3hQKFB/J
    ul8bYpbkbN50+Rrt35iLXlpJ+CbnpszxRTHpr/sT0Yrc2JmTXA9KofiNb/tVDbzr
    BO4AisxgYzU8fzszn77DsoRPYmWF+Jm9c5Bmb0XnPzj6Sd0mv1I5zCTTTOwgMHf4
    kRXDIyeYi4iSf6lUYAd8XEMjWCxnd4tf7cBWcU9csDNNmPliUW+Smkt6fKKrTJwQ
    EwuUMuDAxypxexfLY/D0VkcRceBHpjBZT7NuFFz+1F4tnMiDhNO/vYpbkdmlq9Cw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Qt8IFRLr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeludculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeiiedvnecuvehluhhsthgvrhfuihiivgepgedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Qt8IFRLr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeludculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeiiedvnecuvehluhhsthgvrhfuihiivgepgedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934447AbeCSQko (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:40:44 -0400
Received: from mail-dm3nam03on0095.outbound.protection.outlook.com ([104.47.41.95]:57888
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966846AbeCSQNA (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:13:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: linzhang <xiaolou4617@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 049/102] net: llc: add lock_sock in
 llc_ui_bind to avoid a race condition
Thread-Topic: [PATCH AUTOSEL for 3.18 049/102] net: llc: add lock_sock in
 llc_ui_bind to avoid a race condition
Thread-Index: AQHTv50V0tpwxDkSaEOsum/84uMZPw==
Date: Mon, 19 Mar 2018 16:12:32 +0000
Message-ID: <20180319161117.17833-49-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:RSYCeqI15DpdLksrgHwC7tHzMu6Qs8X068mA03Y1NUtEDM8tavEGnKOB5imHR2k7U/jkyvYNFsQJR1F2Cd4UXRw1ls//MblTZ50fYo0IvST3Nx+wgZtRCxWdLm3kh9vMZXuNJorkmQuxjCwMcqs03AZZjulHtD4sx6prPpduWN1iy7tCnV8Gw9aeun/gBA3yFR0DbkjYaVEpD2KEioreYB4Hg861TKwSzkem0o+F1yhE5YbhXVVkAmg0a5cf2+/Z;20:Y6wjCymlPrwe6CUlG0TwSPDK1iVi6XNbRK1RYe+vCUn0EuoUWvboK5PXOcWyljzk7zuem69x1Gnz29IifR0iMJistWXozr4aqrzxlPHjgE0VVfxUHK3mkwh7oTx7H1MiGIbyLy4vx4tOc1afuwlthsiJLE0degE+mNNl5yoVFWk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1d65179-34b9-44f1-0166-08d58db4465f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1032C6CD34AA7020DB371BABFBD40@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(3660700001)(5250100002)(3280700002)(8936002)(3846002)(6116002)(1076002)(10090500001)(105586002)(72206003)(81156014)(8676002)(81166006)(2906002)(5660300001)(97736004)(2501003)(36756003)(6666003)(2900100001)(14454004)(6512007)(6436002)(2950100002)(39060400002)(53936002)(4326008)(54906003)(305945005)(6486002)(25786009)(68736007)(22452003)(316002)(59450400001)(6506007)(86612001)(66066001)(76176011)(102836004)(7736002)(10290500003)(110136005)(106356001)(99286004)(107886003)(26005)(186003)(86362001)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: c2XIuPbJp3pmHYmzqBxoZxtFMkVAraXpFoPmuJC0uZeSoFGex9By0Xp/vBl6Vnp9IebK0tZu1FMFPkFvYcrH/ZWdkcY9S0xsyRDkgHxWPdOXRnVdEFC9PuHAqFEUSkCawGOaj5SbZtHVI+Ftud5msqGLmO4AGa4geRgiHzVx7+hx60nro+uyy6ncoO2cN/fTkRLmAXJibebfAZybIs6jJO1XDPhxSJn3rXCvnUJfOkn9P5NuK10Im2I9479KSFYH4r1Q5n4gr4/6dEXBpEU1/d0DKCEtpQoOQgBfK9PQTCGAq8DOAgsMW5+qnuxw4CY/WVJRXL+u2/WfdVX2qRxXKA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d65179-34b9-44f1-0166-08d58db4465f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:32.3689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: linzhang <xiaolou4617@gmail.com>

[ Upstream commit 0908cf4dfef35fc6ac12329007052ebe93ff1081 ]

There is a race condition in llc_ui_bind if two or more processes/threads
try to bind a same socket.

If more processes/threads bind a same socket success that will lead to
two problems, one is this action is not what we expected, another is
will lead to kernel in unstable status or oops(in my simple test case,
cause llc2.ko can't unload).

The current code is test SOCK_ZAPPED bit to avoid a process to
bind a same socket twice but that is can't avoid more processes/threads
try to bind a same socket at the same time.

So, add lock_sock in llc_ui_bind like others, such as llc_ui_connect.

Signed-off-by: Lin Zhang <xiaolou4617@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/llc/af_llc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 3e8691895385..944fd5f6b069 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -309,6 +309,8 @@ static int llc_ui_bind(struct socket *sock, struct sock=
addr *uaddr, int addrlen)
 	int rc =3D -EINVAL;
=20
 	dprintk("%s: binding %02X\n", __func__, addr->sllc_sap);
+
+	lock_sock(sk);
 	if (unlikely(!sock_flag(sk, SOCK_ZAPPED) || addrlen !=3D sizeof(*addr)))
 		goto out;
 	rc =3D -EAFNOSUPPORT;
@@ -380,6 +382,7 @@ static int llc_ui_bind(struct socket *sock, struct sock=
addr *uaddr, int addrlen)
 out_put:
 	llc_sap_put(sap);
 out:
+	release_sock(sk);
 	return rc;
 }
=20
--=20
2.14.1
