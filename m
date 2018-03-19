Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521475806-2-9960860341284620013
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
    t=1521475805; b=PEOrKiHUjTptuXgVPEHpii1Yo5klqlOZ1jhPACLQ7KdMjP0
    wS03KBRtfe2gJ6iq2/DMOJDChOh0ehOsYY2HykG/WinZDuQ8eo35Sy0k5kPm8/RY
    nsVgeHrGx7gT5005zHy7kpDR3eTmvtNIgvY7ErDlZLrcnEl9z4SDhHPpJ1tso8cY
    O34jxWcgEuyd0SAkTfhS7pQC8B+NfZ8CIH6MWn1IqoSy7np7W1AkDLxe5jCcZqaE
    Osm3QLYAwd90OHh4tAJn12+q5DbC285Skc7GvN9UVlUtFs+HHMnwwJWDrZR+pHkN
    KRmPRuo5+k+AUOCFotr62JE9C44nbJ6UYgKZvqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475805; bh=93orrF
    h7uce423ugO7ZGY/lIZwrBN4yeGfr4twWcKow=; b=Akb4naLnC5JfmYiLZ8sR+C
    i/09JcmK7TKPnH06S5+9Ih48RSktZ44bA8XfPzdny4NvcmBr2rW0VViCInsmjKHt
    SQ9VTHY4toDs3Mk9kPjPPnJ23cE4xZVtX+/Vus5aiXJJyGHnNhSderBQkHe/wpcf
    cZ5izuQSyPJfx8KVkhqH9rrkGFo0VFC06r1VVabuse5uf2n5GSfGyQ9m7Edustb/
    +7kAO8vtbmLkF8oX4kacG5YiqQ+pqSQCA7RntjR/jNqGgYHNwk7NkIEWYw0QQs6v
    pKzi2mYn+QdReB7V5oQ/afbiXj5QVLEmdB5+gu7bRDq2hQna9Jrt86pjk9ou7xOA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=E6RIrH5h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeefjedvnecuvehluhhsthgvrhfuihiivgepuddtud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=E6RIrH5h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeefjedvnecuvehluhhsthgvrhfuihiivgepuddtud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965835AbeCSQKA (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:10:00 -0400
Received: from mail-bn3nam01on0122.outbound.protection.outlook.com ([104.47.33.122]:60672
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966394AbeCSQJu (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Colin Ian King <colin.king@canonical.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 096/167] wl1251: check return from call to
 wl1251_acx_arp_ip_filter
Thread-Topic: [PATCH AUTOSEL for 4.4 096/167] wl1251: check return from call
 to wl1251_acx_arp_ip_filter
Thread-Index: AQHTv5xdYvGx0TNgwUqgsDCuJ3Skdw==
Date: Mon, 19 Mar 2018 16:07:22 +0000
Message-ID: <20180319160513.16384-96-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:t6DANIfFw0/gI4y5eoTjJZVV13uQsP/to50CR0ux7anI3mmv5P654WbjLa9JcwmpE/XF1YZHTNIrb8TWbiLRkR/0DxtnEXDecKUvi0OvT0esJ53AP0gM9JizT79amQ/H+nmhHoQVKg5rRBN7BLaMZSBn5mcGSGo71RxlTeiFsSzKN8oDP1OlCk2KgWMnYlCgZkskVJva2FpS2UD0dIhOmZW0ooQjf7FbRtspJeAYYMRxesQn9Hy8wocaSv0s9Vg/;20:mCBQY6fXpogbStBdmjMJWY1VZHHUeHDuaOnjVZ/HH+M+X1clsXHIZLiUtUDoHWNe0t0q670nlw9Qw2K7Ac8FPqpMnK9sR2Wf2HaiupvJRTUS+LB6+qQKEUYIZ076CBfLkUVCE+rjDZuLsZII8cZZiD2rQfv38vdjb1cvgprXGww=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b9325c4-f5a6-4d86-1d2c-08d58db3d531
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1095F94CED93B86CA420F36BFBD40@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(189003)(199004)(15760500003)(305945005)(316002)(1076002)(7736002)(14454004)(86612001)(25786009)(8936002)(2950100002)(110136005)(66066001)(186003)(10090500001)(6666003)(5250100002)(2501003)(99286004)(76176011)(86362001)(4326008)(68736007)(3660700001)(105586002)(8676002)(81166006)(81156014)(106356001)(3280700002)(72206003)(10290500003)(478600001)(2900100001)(97736004)(54906003)(6512007)(53936002)(6506007)(102836004)(6436002)(5660300001)(6486002)(107886003)(26005)(2906002)(22452003)(6116002)(3846002)(36756003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: wMp/xx1FbaYHPzFuwyh/kNHuyBuEpIdOwK/B5R6OZfourWA7Ge92YIjaoqYqQcTVQc7QyR48HbdJLwsqxtoXTYW0iwit5ri1iJMg0PR7f32muFqptiwqG2zwMD55L900JwTArF1ac/jEXq2xtOMyEcYW3pLrsUf2BFQ2fxgZLOpNLUTSXysIkx+j6shfTBGBg51+vaMT8giRzUO0VvLlB377QVorJ+c/ULEtnA4ctYsve0INHB1iRqX3rvg2Is+r0fc685TA/NJyhEErQ+iCnkPlT8KArLVfH5/QNyCH7Q38YP0YppJA9m/W03wseJ+ckrzVtBq3PRMLS7hPqK0OWw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9325c4-f5a6-4d86-1d2c-08d58db3d531
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:22.6657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit ac1181c60822292176ab96912208ec9f9819faf8 ]

Currently the less than zero error check on ret is incorrect
as it is checking a far earlier ret assignment rather than the
return from the call to wl1251_acx_arp_ip_filter. Fix this by
adding in the missing assginment.

Detected by CoverityScan, CID#1164835 ("Logically dead code")

Fixes: 204cc5c44fb6 ("wl1251: implement hardware ARP filtering")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ti/wl1251/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ti/wl1251/main.c b/drivers/net/wireless/t=
i/wl1251/main.c
index 9bee3f11898a..869411f55d88 100644
--- a/drivers/net/wireless/ti/wl1251/main.c
+++ b/drivers/net/wireless/ti/wl1251/main.c
@@ -1196,8 +1196,7 @@ static void wl1251_op_bss_info_changed(struct ieee802=
11_hw *hw,
 		WARN_ON(wl->bss_type !=3D BSS_TYPE_STA_BSS);
=20
 		enable =3D bss_conf->arp_addr_cnt =3D=3D 1 && bss_conf->assoc;
-		wl1251_acx_arp_ip_filter(wl, enable, addr);
-
+		ret =3D wl1251_acx_arp_ip_filter(wl, enable, addr);
 		if (ret < 0)
 			goto out_sleep;
 	}
--=20
2.14.1
