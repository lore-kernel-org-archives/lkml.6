Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521475845-2-14985100880798949157
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
    t=1521475844; b=dF/T9x01oGJwa7jORr147p0xZNnsXNGpixiB+EYY/ZPhc2j
    BEyTKjQk2XtOSN6o5yfgOF+r3zMWu4r1I597Sz7DdbIm9IPvZKHdMqPmtQHJfFjt
    xuJZM8x+Fp2QvTB5OE4UTnhOWTT5lwiuAkRDYsljjQ5w0lAdoCFye1VvbHLtY3sS
    KGx9gOMKlHnNvgJF+L3gDz1z7bF5DIK1KC/OelpS2iKp8bxqMOWZ9k/bvtiAZcWJ
    druXzPPr2zegRp8daojTItge4R/VwWYOVr8XYIjs1BvBk6AmTKVhyjFzZp2vapOt
    Jo93xUaO602OYHxL7FC/LSFJi4rkwKMsEqcvR2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475844; bh=aANUwu
    SsVw7tndS5a7ape7608sMBtiFaVne3D8jUQKg=; b=P7OpavArjtyprZsuGWvEr8
    7oW3Ns7VpBQV2nEa7oAzR9tWcXUjh5kA8gbgIeWGtfDNiMPeH/dIYm7ZaWOKCLuj
    +QFYf4fKQ5ddEhsHfaPd1I8H4Xv4rrwREqNt68K6nw2Ue6nHPEzoCMPg8YAHLFF1
    9n1rpnPwLdbMbxVmxgdBNwswCVKT+OD6Ex50t7Zdpyc/0J/rzA5GPoTAMulP54ik
    1daQSM+EFZBzuDdrqfxiPYjR9sXhoEC6jN7lub0iXXscupwNzKrbVm1czpg+cQlb
    S+43ZL3SxkEByEVJ7+g7Ql0/fMt/NSWijpqZ7Nwq3pMxPNMIvmIPw0vT/l4J5mPQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dEgTPRGN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedtjeeinecuvehluhhsthgvrhfuihiivgepge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dEgTPRGN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedtjeeinecuvehluhhsthgvrhfuihiivgepge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966442AbeCSQKj (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:10:39 -0400
Received: from mail-by2nam01on0091.outbound.protection.outlook.com ([104.47.34.91]:17618
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966583AbeCSQKN (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:13 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jia-Ju Bai <baijiaju1990@163.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 116/167] mISDN: Fix a sleep-in-atomic bug
Thread-Topic: [PATCH AUTOSEL for 4.4 116/167] mISDN: Fix a sleep-in-atomic bug
Thread-Index: AQHTv5xsmfWWEW5M6UiLQNRELPsJHw==
Date: Mon, 19 Mar 2018 16:07:47 +0000
Message-ID: <20180319160513.16384-116-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:syXeGtqGc1w6yCDguOGu9xTz6ihPe9Zr5Lbp9VX8HvNJ2kEhHX8zA7vLP5hUYot1crcvRq56IzkfRKeZZ5/5Bu45iQVBEIO8ya9HTI/Xldngc29kfTwuAFwtqxxWDwdKOq3kb0X+aLTbS3M57E/LJAMFqEpZfuOqg2ABMJqTA/gwn7iq0VWH6/52o2R7Ap82vgNEoQOM5f/t/5oOIVfk6JLeGbXw6jZlva6AAEdUJmhTpwIEJKXWMFtTIi7FL56b;20:Rrds6A/WkWz2u8gxYF9jzLJ2IxWJCeEvxJF/K+cD3qTh1XoHpfNoLm8AtvZOCan20/L0VkBCKJpf7enmnnwXwwKwJmdiJFamRz4pOXpxRbFu3b8gOAvu/PoFJUXZiO9OFbMMJ7i3pK0jKMkW5RLmVgvasW6TluvreEQH8naG+3k=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 27634439-6971-49f8-c339-08d58db3de8c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919E20DA15F0282F7BF08E4FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(59450400001)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(99286004)(102836004)(106356001)(72206003)(81156014)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(31853002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: JskI+DgxGu8d2qOpGP/prb1KGygIlcBvNkfGwvkHkrjnosJOk9ioaARAAaBmNYqP4hoxpqbROG34Yd604U4ulO0vbSaqJEljQsdsC0/M9csIRzWghmkHwF2UTlas69MyBbwVCeCVaOchHkIuhBofBhDPhk1NX3WqQPuPRaGCpEbM1YmmD0JeWh8sGEFzE424UXReboqLXJTFBJBTfKptX3ZXacyGmD5JEfJ5rWeXQA0duJc9Qmb87amZjiyb6jW3Dz2iwpJB9dwIFi8agXpBcvxoYUQxKiENL8z+HJi9+ViX5knD7QP1RhU/Cu7HSC5jI+pLtoPI9oqbRm5RIfAjBA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27634439-6971-49f8-c339-08d58db3de8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:47.9856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
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
