Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247637-1521477308-2-3334175446109994701
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521477307; b=MC1XtplZhgjMiVXKhobuC8P9s8pU1bahr6CbKts55rjpxG/
    5J1cgFUkIxa/0yGOS4Mpsx0KAVEX5q7M2NQeldE+hsHmn5UuG7u7phBjUpPTT3ZL
    zTUG/oVyqzEKIEzqyp0Ft+EuwCeb/SJNe0D1mrRLldAERvyzx8N2lRkEOa5QjcTP
    vMbuFbKVrc/msrzODFhtTVI7whywwF7xkV9rIG//YSLe/p6mt3os8pbgKEaE74W2
    g5GQOVVKWKH5VqEmUHgpbaRCZi2S0KwMhbmZ8OZ6pidTzEhsCphHR8B8974ghWp+
    LQWi8exg9k53ohP+B2LcjDkkKCJRACLsiJ8/FUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477307; bh=aANUwu
    SsVw7tndS5a7ape7608sMBtiFaVne3D8jUQKg=; b=trxrKZ5PFJfW1v3pWUCBl3
    R/fHoJZ2L6D97mWMDEbK/f34n7bVX4nefw8S6mbGuhxz49DPh0ZwlrTzshcvpMcN
    4nTt5s4mpFRc6fFXhO0oY7AMIC2CvxkzlpTNOP7P4tu2ssCgmDyzQwprHyMNZco0
    5o/ZpnIU3Nrs87OKKpfGXeSqfWeQtjVPTFnclIN2kXqvpnL/RbL6WCnSW05w/K+1
    esiBw/7Q07U6xDh3DkSuQjiTrWl3gLMmFdzZvSQ0112IY9UQQmYgZz7xXiUM2lRQ
    iH2J9DFSYCu/ZXbtVMgiPiaX4w/m/2F25TM09eM9TQ5S09Q1f9jGM8z+YMzKfEmA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GMcFk0Ao x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedtjeelnecuvehluhhsthgvrhfuihiivgepuddt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GMcFk0Ao x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedtjeelnecuvehluhhsthgvrhfuihiivgepuddt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934069AbeCSQfD (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:35:03 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:64207
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935296AbeCSQN1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:13:27 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jia-Ju Bai <baijiaju1990@163.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 065/102] mISDN: Fix a sleep-in-atomic bug
Thread-Topic: [PATCH AUTOSEL for 3.18 065/102] mISDN: Fix a sleep-in-atomic
 bug
Thread-Index: AQHTv50gxVbFTVPuOE6UD3oSdmbZCg==
Date: Mon, 19 Mar 2018 16:12:50 +0000
Message-ID: <20180319161117.17833-65-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:i0booekJv3pULmk1rmJDEYHtGOHnHmJsX9SjNLDQkVsJ8uHp38989eCiojXrQEOcFTc/VcN9xl1rAkxZdMkM5sRKvH3rDnDp0F6Tj0JD7fpANb6OqIwCapkzqEtnESQockxVn7Ke7TuIWGXMe+eUWe/GS3SUwXUJDPEIk2h5P9AvWbiZwrCYogOln7Lx1+s10zF9bzNxSsUbndP9CyBbbmjBb3FXLeMUjxgHt5HA5K3tPKGuX3BiScFETQN+LG57;20:90NbKzNbkMfppi+26E7Ta4wBAftn2Et3JN7GozM5q0oxc2Gt5SKI5lmVjd60xH1eUR1X79Iy/aNV2jtoqeBBwiWYWjxiDQOTnIjF4zo1WHXUneSNK5uo7NiaZTiE92UzyIpCOG9uGiUtv5yVXKb0F4qHJoxA+Iok2IaJjz7AzDE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f6e5c67d-7f9f-4766-d229-08d58db45480
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10480B5C14D40D6B53E39B21FBD40@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(39860400002)(366004)(376002)(189003)(199004)(10090500001)(107886003)(25786009)(106356001)(102836004)(26005)(6506007)(8936002)(2906002)(6666003)(186003)(86362001)(2950100002)(5250100002)(66066001)(3280700002)(5660300001)(4326008)(72206003)(68736007)(10290500003)(86612001)(2501003)(478600001)(81156014)(81166006)(8676002)(2900100001)(1076002)(105586002)(6436002)(54906003)(110136005)(53936002)(36756003)(6116002)(59450400001)(3846002)(305945005)(316002)(6512007)(6486002)(14454004)(97736004)(3660700001)(7736002)(76176011)(22452003)(99286004)(22906009)(31853002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: YSCNOBWpLKh3VYy1bjDeZGKAPwyR9IOGsSF2Gi1GBCt6sbNyQLexST9e/PtxHo2vqZMmGdGKtMur+E7vWsUDbOacQb7j6xvsUwkIKP5JweV7nnX29DLSBPvtVu4fKfhMD3b6kgWFRjoqrp9uzK+79qbUnaGOxTmVKGODgn3aOgND6XQjoaCG/t5i1LUITXKql2wJP3U6qeNe3cy2VEZHLklufr7y/rppU7GejgcE5Q6CUnDL72GfiWgz8dorvlZtGwSvmsyo2vglJ9boqOvVcrw5FLUdT+Og9uTwpf9Z/HuVqDZz0VsM3mJwmAu/O9xEqh/J5xvYciNrw1uYT6JVMA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e5c67d-7f9f-4766-d229-08d58db45480
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:50.4697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jia-Ju Bai <baijiaju1990@163.com>

[ Upstream commit 93818da5eed63fbc17b64080406ea53b86b23309 ]

The driver may sleep under a read spin lock, and the function call path is:
send_socklist (acquire the lock by read_lock)
  skb_copy(GFP_KERNEL) --> may sleep

To fix it, the "GFP_KERNEL" is replaced with "GFP_ATOMIC".

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/isdn/mISDN/stack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/mISDN/stack.c b/drivers/isdn/mISDN/stack.c
index 9cb4b621fbc3..b92a19a594a1 100644
--- a/drivers/isdn/mISDN/stack.c
+++ b/drivers/isdn/mISDN/stack.c
@@ -72,7 +72,7 @@ send_socklist(struct mISDN_sock_list *sl, struct sk_buff =
*skb)
 		if (sk->sk_state !=3D MISDN_BOUND)
 			continue;
 		if (!cskb)
-			cskb =3D skb_copy(skb, GFP_KERNEL);
+			cskb =3D skb_copy(skb, GFP_ATOMIC);
 		if (!cskb) {
 			printk(KERN_WARNING "%s no skb\n", __func__);
 			break;
--=20
2.14.1
