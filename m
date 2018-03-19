Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475586-2-8566237948452361675
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
    t=1521475586; b=cvP8PWKc1z9fw+mHC1MRWhy2tvRkkvtfe7J7INovrYQf45k
    TIRVH8hGNsF/rrVTG8WVVY/moHUyov2bpwBCqQJxu3c2E4vJvnorSeyTidcMDvA5
    YCOpsnsgi1DeSapLHxmhSt830DSu9HQh2gA2AfjT5bC+EHyD0txFdSWyKhSHEGWf
    d73/6n67vgO5LQtaf7bGhq/lIwmbe0fkrJy6CMOoXCI+REI7zXVuiCrqbvBTGTIe
    Az0abPxpIBnhRESmW37Yp0G+v5j1gVhbvtw8WwJyCH6sisfKb1wN90DbwZaEFyCu
    JdXjhIrLZ7PfZ27MKECxXp/UZjcTAJZuRoWAPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475586; bh=xGxIKq
    vDqwylkXCy8boJ3iHNp1fUZIAVNlME8w4wE7c=; b=qS+JU3BxGNKlpBsDOEe3+V
    ncLkfngv2xSXWza60L7JfRbff+zyGwCcuiosYT6tofjltmNeo3piLpolMhYiCeiy
    lKQ9/Mnume4Z/rejQpVAHmt54E8kbBzLzGpMeRRhPjy4BEKPgumPTaGu141E4iSK
    1nQztTABlwkd6phFqC2Jy8227zUgS/QxIGzMSqhEUjObh+6iCaNqvLb1j9DErEy8
    yBFm2kVknYQhiBjo1kGak1ZQ6Pa+VPY5Vu9Fa4+8VaiDm2aA2yUFskKhf+YfUeCb
    /XuF0l9Ws3oq69ZN4n6HlRUywFiGov8teLydUUDT/4vcFRx/DrPmKliKzzm8PLsw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GhOsEWoM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdekleenucevlhhushhtvghrufhiiigvpeduvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GhOsEWoM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdekleenucevlhhushhtvghrufhiiigvpeduvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965874AbeCSQGV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:06:21 -0400
Received: from mail-dm3nam03on0092.outbound.protection.outlook.com ([104.47.41.92]:19136
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965910AbeCSQGM (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:12 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-edac <linux-edac@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 270/281] EDAC, mv64x60: Fix an error handling
 path
Thread-Topic: [PATCH AUTOSEL for 4.9 270/281] EDAC, mv64x60: Fix an error
 handling path
Thread-Index: AQHTv5vJzYjungmlo0WHWnTGLq8WLQ==
Date: Mon, 19 Mar 2018 16:03:15 +0000
Message-ID: <20180319155742.13731-270-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:sYqylvGyZzWeuG054ZSrZzYlwpAqzLu5tcZmB9svSJKCz26YwI8KEJbt/KcIkjDsKZ2adPO/JFQNS6xbgP+k9SxGW0cY/PGu5qxK9cte892Ka2Bah1r+KDruJlAhae7SFLUciomsw+rjRlC8s+i08Ik/0VAfyPjuieJOlFzBG9wM7NA2aRi+EjcfVOVDDcbHjW7jJhtX6DwUL+Z6XJFAzlYK6oRi5+5hNULYgBVIPk5M7fKP4Lw/ubMjVI6/m43p;20:sJz83ph+rAsY8Ozwg7PiWmua26tVmb2r9KEn6qs9/ReL5qEpXUogFGp4z583huUUDnWJvMd6ETx+/eJpXhdD0jyeZxAFTmJZp3tIjShakzzd3EC+2PSiiKvTIleNiZ26JsodxLIAkL5yxlWFeBMWDSRJej9hr0evFS3GiJ7XMZY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2c54263d-338f-4359-a851-08d58db34fbd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015583F18157C1A53028AA4FBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(155761271638844)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(396003)(346002)(199004)(189003)(6506007)(106356001)(107886003)(2950100002)(6666003)(22452003)(316002)(10090500001)(59450400001)(76176011)(8676002)(81156014)(105586002)(81166006)(3280700002)(3660700001)(305945005)(7736002)(2501003)(6436002)(68736007)(6486002)(5250100002)(8936002)(6116002)(3846002)(2906002)(1076002)(186003)(36756003)(25786009)(10290500003)(4326008)(97736004)(6306002)(72206003)(2900100001)(99286004)(53936002)(5660300001)(6512007)(14454004)(966005)(478600001)(102836004)(66066001)(86612001)(86362001)(26005)(54906003)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 2ohg65DlncihiN6AiEm6oV1x6cnnhfpXvba+fVxeMt/JfNb94lTR7kT9kmMinFeRm1xTghLMJgj0ValHoehmzm6qKR7ivt8nZDF+GxMXrcEgnYnGZ6xJjqDrF6scFIF7RQ+UdH2KvDf4NnDASamaoZVPAVvGhTwVu7MC50taqqPJuu7kX8PwtYQQh37CfXB1yNFbkHQmNFXVdx3ssU9w/HHqfPGM7PCbk1hSvVi6P1vAzjZL0QT3FSI+7kNKCB2XIFWrKeIhmbB5MeB1MRt3Jd1RHjJ+diScELnz3RHdIUaJ0EV1tbcONEvZROHIa8KwFF9Q3lb/Y2xrn7l8khs1Lg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c54263d-338f-4359-a851-08d58db34fbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:03:15.4345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 68fa24f9121c04ef146b5158f538c8b32f285be5 ]

We should not call edac_mc_del_mc() if a corresponding call to
edac_mc_add_mc() has not been performed yet.

So here, we should go to err instead of err2 to branch at the right
place of the error handling path.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180107205400.14068-1-christophe.jaillet@wa=
nadoo.fr
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/edac/mv64x60_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/mv64x60_edac.c b/drivers/edac/mv64x60_edac.c
index cb9b8577acbc..61c19b81ed81 100644
--- a/drivers/edac/mv64x60_edac.c
+++ b/drivers/edac/mv64x60_edac.c
@@ -759,7 +759,7 @@ static int mv64x60_mc_err_probe(struct platform_device =
*pdev)
 		/* Non-ECC RAM? */
 		printk(KERN_WARNING "%s: No ECC DIMMs discovered\n", __func__);
 		res =3D -ENODEV;
-		goto err2;
+		goto err;
 	}
=20
 	edac_dbg(3, "init mci\n");
--=20
2.14.1
