Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521475410-2-2284062088769702606
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
    t=1521475410; b=hiIIfo3QS4jNGxgywUCCJjngcMkhfN03ToxvyeuiiGVry5X
    RewY+Plbu+uhDqDzWHej0zXtdfcMwQNhr/QGlx2r2vKw19PkFa5i9Ebmgf5Zi+Kk
    Ui3t384L4DL04XrSo7sKXUSkZvf0ay56QFGu005FMyjVugfF8X4X4THW8z5PaDVC
    6IkMa76aVifEtmWf04ITI+VjteONjL/k6hhyq51DdvXPyXcbxSUt9Wmv/QWw0f8K
    UfS013Y73FXjjJvGUdwqhNS1Wa0c+GA5slraHrAN57G48dkI61SH1L4Y1jEf5L9g
    wKhigdBboYf8miew51K4rNe3jMXa17t08HTVhbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475410; bh=rdVSOO
    TRQ/Nb1A1uKIEFFAkbRUYBhvyXsDTAhcsE4Ds=; b=sy6x4aYMseKTYRaexvyfhp
    baglezLN2x+V9ukboPELRk3JtMXd27yVhV+rlNVXwFRimvQZAPn6X9/aZ0+ZvXsM
    NkX5v0ER0KEBMoFurHZ1GbdVFvO/xFkwqlm4LsKk9oieibJhxF98SI1W/WHPCBW4
    4jAORNG+vQDW1wn7RwwBC7N6B//SdpSqAXpjbM7BhuV+4stUBivOsDncqvzo1tDG
    k2j4Ukuhz9djRnbx0D0SpPdH2x5VfYMceVq3N9FbSya+mJNkSC+Mtyuq9lEnHVfv
    RGaa40h7TEHl1a+g+R7oS0+Eyy1xchRVptdjepyK/RKpqIi8/f0/sVWThzPGVMbQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S/iUefpk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvkeefnecuvehluhhsthgvrhfuihiivgepjeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S/iUefpk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvkeefnecuvehluhhsthgvrhfuihiivgepjeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935012AbeCSQDY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:03:24 -0400
Received: from mail-by2nam03on0139.outbound.protection.outlook.com ([104.47.42.139]:32544
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965567AbeCSQDR (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:03:17 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 178/281] clk: Fix __set_clk_rates error
 print-string
Thread-Topic: [PATCH AUTOSEL for 4.9 178/281] clk: Fix __set_clk_rates error
 print-string
Thread-Index: AQHTv5uH66apn1ES40mCoeACLc4m6w==
Date: Mon, 19 Mar 2018 16:01:23 +0000
Message-ID: <20180319155742.13731-178-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:L8r+40wtEClQGjM5xanglFG0JjpCDDHfWVaaTvpqkkWOVBdCxGDokspUNVScrnf1qgOEWwrmCUmPEnRoaq1931fbBd+jav02n40qciEa1W/WHMrZyX9i2TtEkcy8JrktwWVnAkr9yT4r9VWFEUhU5FShjx3qxOtAfD8atG+F2QvHz0qdczbeA4/d140dSuu5OQzn/eGOWmRXwd3MH8H4ZTGf7TGDKygBig3dbdSuE3VmVTgUzIvkWp71Ytcm5t9N;20:gs6jq2jDA3O6/VZ6+LsRiBXQxD8MCv7WNngJItcaQWvL+ljQTIHZTRuSQlks5lZIkNsbGNuQ0Hf/os5tb6gLDhR4OIjeVYT8ewNioXORW2anmi+f/JQ2louhB96HBAo41MAWnFVYR+6YnO7scFJLgMHbS8zGkNpFytK9NbitDd0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: de007729-c344-4a5e-94be-08d58db2ec85
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09197226A74B1536579A8807FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(59450400001)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(99286004)(102836004)(106356001)(72206003)(81156014)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: +aXvKMpixQJOr+02K4VuoOzbEkUPN3qGXseERYuVELMka3syCEDXrbw1LjzHqavolDrzmx7y/iJ6cXYgUKt6eFDN9KAZ4e2Kq79G+PgAxBa2cC0Q0V7p/nDJBku/1/zO6dCwRHtp8YFAV8Ge0C9UIHBc/100x19nt7azp3XNVyti1OqWjWEMrhYzY3NWaicrzc6G7SSrKh655dTYLWV57J20iInmWBhBNLdbt+4H6ByL6ybymCPxADjNK5L+GLOpmmGMo5SYPNAcJX2WwKx/6IFGa/VXQoYOSTo6f3pNMvfaJF+EMJtkxOFBOD+XynNSlMGub60seuNUXc0jw3+88Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de007729-c344-4a5e-94be-08d58db2ec85
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:23.8528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bryan O'Donoghue <pure.logic@nexus-software.ie>

[ Upstream commit ee177c5d6369f8e5d3e4793dce501cf4431313a1 ]

When failing to set a clock the printout emitted is incorrect.
"u32 rate" is formatted as %d and should be %u whereas "unsigned long
clk_set_rate()" is formatted as %ld and should be %lu as per
Documentation/printk-formats.txt.

Fixes: 2885c3b2a3da ("clk: Show correct information when fail to set clock =
rate")
Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/clk-conf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
index 674785d968a3..f02900922bbe 100644
--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -106,7 +106,7 @@ static int __set_clk_rates(struct device_node *node, bo=
ol clk_supplier)
=20
 			rc =3D clk_set_rate(clk, rate);
 			if (rc < 0)
-				pr_err("clk: couldn't set %s clk rate to %d (%d), current rate: %ld\n"=
,
+				pr_err("clk: couldn't set %s clk rate to %u (%d), current rate: %lu\n"=
,
 				       __clk_get_name(clk), rate, rc,
 				       clk_get_rate(clk));
 			clk_put(clk);
--=20
2.14.1
