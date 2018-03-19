Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475710-2-6457646920620358270
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521475710; b=VxS8Dal24MEscHUiV94F/RuxNbHIAuqNBy03mBlbiue/n6/
    CmVXGLRijiu2C3KTJcB3dCufTHqVMBbKVh966pqBCX3crEMY9msvEOMqIzR89EXy
    Tr/9QH5xy1CZd3zKzE+WwtQKHxiSSVIP5uYUeBBmLz428UYB8l+MZc8OI/hFVFOG
    myUjnzQqR3My1CRJ7AhvPMSjp8Oep/SbA2CPvKQ0YFSDxmSalA0gp6Z86JlDpO7e
    XbkZqFJL/crwVxS5DpTsvtlq9M/21pbJZYUjenycGzWZ1Ctq8aq3ECjjxK9qymsC
    Pm+68nB/nmbo+veitrNqxE0R9l4kk53tA4Nd0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475710; bh=9KFamC
    LxWuxD+WlrJHTSOnPLKaurr4ckA3gFCUfFk40=; b=L95PpnI3FSgLuCfZ0dyxGC
    Iruc6K+XiG3HKj246EfvpeEwcMC7BOJYrUohyCUz0Mku88s8uJFcmCJxvx7VTXvh
    bgVXxWMOaCENIlRUjhAc6cbqwFk9yLdYAQYjq21ZdqJ/pty3rU/qX7pc1hoOHHn0
    3XnMrphiSV7nru3RX9eaD3+CVooQFOamDAMMeTI3Po0i1NPYLZS4K1t7l5paTkLE
    Hd+csR5V+GZpT32YxJdlLUz3F4Mz/Jh15adbUPS6l9lUxUNPw/t2JnaJOq82L8Cu
    YiB4s2/9Hrh/5TVR3gCeSxoMKn95vYL4VLjMBhmrC+QJIznhLc5B8++Qeg0tV3gQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bkrOcbNM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeejfeeknecuvehluhhsthgvrhfuihiivgepfedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bkrOcbNM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeejfeeknecuvehluhhsthgvrhfuihiivgepfedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966151AbeCSQIX (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:08:23 -0400
Received: from mail-dm3nam03on0098.outbound.protection.outlook.com ([104.47.41.98]:60247
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965912AbeCSQIO (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:08:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jisheng Zhang <jszhang@marvell.com>,
        Peter Chen <peter.chen@nxp.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 044/167] usb: chipidea: properly handle host
 or gadget initialization failure
Thread-Topic: [PATCH AUTOSEL for 4.4 044/167] usb: chipidea: properly handle
 host or gadget initialization failure
Thread-Index: AQHTv5w1NyTUEtCQhUmuRleakaPuhw==
Date: Mon, 19 Mar 2018 16:06:16 +0000
Message-ID: <20180319160513.16384-44-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:YVj9w1oWin+ZzYBd0HSkU5tvFjVJCMxN6yRiAUf7MQjKl21iu5fnYmaok/994S7WH2+m7/D6EUB26yO9dKmKi68H4+/QUb4YS0OFgT/QjE8re5mCyC7qqVPA3yfjx0i/pngXe+Xb5CUiHuwIrcRkYo/EgitcH22zvsZdupjoJ3hPl3JAq3UavMb3fE9YniCNTQCsCfLBtvevr3xg0LfY7VlOWBzEx5WvuVZBvlQ5R/GY/QnJnXW0dGbeaB3kvwf+;20:OAWRRmUK9rawzRCROe2nMGH96wYBDyi/VAq7zeYRsrKsal+nVrqYDlzoWdgfd8Qo7iVzrobUnWZTEtpam1ON+CYsCa4yI7qBSM/xbBnSSQeGhRVvovJuIbY+cxFndCvXV+WEKwRErlJcS4B3gjrPSQuIjB1FE6p1Qq1kOgauKco=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e92d703b-dba7-48dc-5459-08d58db39d11
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0805A9C488CC616D4D9BC873FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(575784001)(2950100002)(305945005)(186003)(86362001)(6506007)(3660700001)(5660300001)(6116002)(8936002)(3846002)(1076002)(26005)(7736002)(6486002)(2900100001)(6436002)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(59450400001)(8676002)(14454004)(105586002)(107886003)(25786009)(478600001)(2501003)(5250100002)(53936002)(3280700002)(316002)(54906003)(4326008)(6512007)(72206003)(66066001)(22452003)(10290500003)(99286004)(8656006)(76176011)(36756003)(97736004)(106356001)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: dThjcPpQ/4wLcpWcNcG1OljfUiTUag73LmfvpDqAAMH8yl97Hg9CYHzfTpIIc9Wml88z0LSwzbjB5sqLuZQElfYncyNkAh8Ym8H1s5//OKTZgY3Y3NmV9IgW/rRMZF44siGyVIUuHcAOca3naPO+xle5JSAPVQrJjRE/cy/KVsvJmwcqTgckg0bgmhEq1fq4JTfqm2kmvKFIdAn7pEIOsUnudBsPPJc90AYZeJlI7YQTSM9VNw8kBVRdZsUUV6iFropFXTKIKviqZLO7avgSho21UMzxi/jA3lh3YL7Ortc3nZw5qSs1okA2GSwOgiXez2YKNiB2qe2loCZpr0wBKw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92d703b-dba7-48dc-5459-08d58db39d11
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:16.4497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jisheng Zhang <jszhang@marvell.com>

[ Upstream commit c4a0bbbdb7f6e3c37fa6deb3ef28c5ed99da6175 ]

If ci_hdrc_host_init() or ci_hdrc_gadget_init() returns error and the
error !=3D -ENXIO, as Peter pointed out, "it stands for initialization
for host or gadget has failed", so we'd better return failure rather
continue.

And before destroying the otg, i.e ci_hdrc_otg_destroy(ci), we should
also check ci->roles[CI_ROLE_GADGET].

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/usb/chipidea/core.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 939c6ad71068..57ee43512992 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -851,7 +851,7 @@ static inline void ci_role_destroy(struct ci_hdrc *ci)
 {
 	ci_hdrc_gadget_destroy(ci);
 	ci_hdrc_host_destroy(ci);
-	if (ci->is_otg)
+	if (ci->is_otg && ci->roles[CI_ROLE_GADGET])
 		ci_hdrc_otg_destroy(ci);
 }
=20
@@ -951,27 +951,35 @@ static int ci_hdrc_probe(struct platform_device *pdev=
)
 	/* initialize role(s) before the interrupt is requested */
 	if (dr_mode =3D=3D USB_DR_MODE_OTG || dr_mode =3D=3D USB_DR_MODE_HOST) {
 		ret =3D ci_hdrc_host_init(ci);
-		if (ret)
-			dev_info(dev, "doesn't support host\n");
+		if (ret) {
+			if (ret =3D=3D -ENXIO)
+				dev_info(dev, "doesn't support host\n");
+			else
+				goto deinit_phy;
+		}
 	}
=20
 	if (dr_mode =3D=3D USB_DR_MODE_OTG || dr_mode =3D=3D USB_DR_MODE_PERIPHER=
AL) {
 		ret =3D ci_hdrc_gadget_init(ci);
-		if (ret)
-			dev_info(dev, "doesn't support gadget\n");
+		if (ret) {
+			if (ret =3D=3D -ENXIO)
+				dev_info(dev, "doesn't support gadget\n");
+			else
+				goto deinit_host;
+		}
 	}
=20
 	if (!ci->roles[CI_ROLE_HOST] && !ci->roles[CI_ROLE_GADGET]) {
 		dev_err(dev, "no supported roles\n");
 		ret =3D -ENODEV;
-		goto deinit_phy;
+		goto deinit_gadget;
 	}
=20
 	if (ci->is_otg && ci->roles[CI_ROLE_GADGET]) {
 		ret =3D ci_hdrc_otg_init(ci);
 		if (ret) {
 			dev_err(dev, "init otg fails, ret =3D %d\n", ret);
-			goto stop;
+			goto deinit_gadget;
 		}
 	}
=20
@@ -1036,7 +1044,12 @@ static int ci_hdrc_probe(struct platform_device *pde=
v)
=20
 	ci_extcon_unregister(ci);
 stop:
-	ci_role_destroy(ci);
+	if (ci->is_otg && ci->roles[CI_ROLE_GADGET])
+		ci_hdrc_otg_destroy(ci);
+deinit_gadget:
+	ci_hdrc_gadget_destroy(ci);
+deinit_host:
+	ci_hdrc_host_destroy(ci);
 deinit_phy:
 	ci_usb_phy_exit(ci);
=20
--=20
2.14.1
