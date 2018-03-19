Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521495868-2-10108386634477154808
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endait, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521495868; b=wpu8nPxJOqjLIm5c6QQSlVkAQKI1G+rwdTyM9gP5FriAbnR
    YqBE+ckTXQugyrwGInZJE+RhIB//AZiv2UtCabUpKRCC+3isMV0wTr3x69jNSfTV
    3CzKiBeow1po2YqxOztOqD902teerRCUbRauMEjsY7W49Qu6FOAYr/KfxgYT2a+d
    ucpV6qUoVg3Io1W1TTFWN5IGdNYnROiEDZlMZ2OIEcX8SjEFHDfltRzLeM9XRRE2
    Ur011/EPjfsMwnMjahbGmvBbye0zziLobCMOK/yLadpvpp47nhcnlkyYuevtXFnr
    X2umJmMrIL11J2I9x5cgWn2B68otweAR1EnC4Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495868; bh=sqXp3q
    OuVrMLThyQDu0ldLqz1ifs5JnnejbahKcB8+k=; b=cYZ/plFXp1elq817+8SN8B
    frJ74T8S3mJTIJ+KP6bNT/FT9Vfi9GWfwCeTdiW3Z1kbMuBtB5RBT+T5plK3lAFW
    E4wYea8IzFf/4aFs+NTxRrG4MclVqidir59u8/x/A71fwVAe39EMySzWTeVGj532
    M7USdF2QXAbpoT56XmHoG4e3OZcWw0C6HYClBzH8uI8krJkJ/meYSYgUip2AeWJ+
    AM6K7TTrcuLwdqV9iVKkckO6nqQOaoyylyO8PlxizqKsVAcoq5sLckGsfvPEbcZH
    OOdlFtj8vKBWX1R8mtvZAG8c1MDGvaez71QktSaDf0PH56ng1zC80UXKISI4nP4Q
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=j8v7irXc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejhedtieenucevlhhushhtvghrufhiiigvpeeihe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=j8v7irXc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejhedtieenucevlhhushhtvghrufhiiigvpeeihe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934806AbeCSVn6 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:43:58 -0400
Received: from mail-bn3nam01on0122.outbound.protection.outlook.com ([104.47.33.122]:16414
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964830AbeCSP6b (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:58:31 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ram Amrani <Ram.Amrani@cavium.com>,
        Yuval Mintz <Yuval.Mintz@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 025/281] qed: Correct doorbell configuration
 for !4Kb pages
Thread-Topic: [PATCH AUTOSEL for 4.9 025/281] qed: Correct doorbell
 configuration for !4Kb pages
Thread-Index: AQHTv5salE6sHdvFQkuIb8xGkEmeQw==
Date: Mon, 19 Mar 2018 15:58:20 +0000
Message-ID: <20180319155742.13731-25-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:5nOzrMcFQEEU/fxmcVxAWsMazuDP4cN09G0vBIu+Ic8TDQpkpIlFZMXwKQiGK7kp0S8KqOcRWYBZiFIQj5SIP3U5QEMPqjWXDxuf0rGPT1HLFSAJ8GjVwqjBONIKPkre4RKb/4PwRK8SsvQhjk83U/TPP7NZOWvGwdX2P3OjtiCwwhX0CrJBpJ1eAmmmIAlA8H4zUBq7ZnhCJ1ydyAFubslSQfuWe0dPYwcfasspThpWKxlvpAtlbgyoakfzo9qV;20:+rm60NC+fo0Pg0ZBnilLXKiEnDdGiLB6+mJX9+e5VRS4HGZLjQenrtxRVhyeLBil9VQ2SQp8lnO6p+B2raK95qm3vFjQpnLBJ8hZwGiYUPWftIOcF1VSwCJCPfoD93bUB0WDA3vdWDv6XTvUEz/iXUR5IzkpFu08ydTTbtKHwII=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6ef390df-f745-4968-b7ec-08d58db23cd3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07267723292129E9474B9BD2FBD40@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(278428928389397)(89211679590171)(192374486261705);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(396003)(366004)(376002)(199004)(189003)(81166006)(22452003)(2906002)(3660700001)(10090500001)(102836004)(53936002)(26005)(316002)(14454004)(2950100002)(97736004)(54906003)(86362001)(76176011)(110136005)(99286004)(105586002)(7736002)(10290500003)(66066001)(478600001)(5660300001)(86612001)(6512007)(81156014)(36756003)(305945005)(6506007)(6486002)(6436002)(72206003)(2900100001)(2501003)(5250100002)(59450400001)(186003)(1076002)(3846002)(25786009)(106356001)(8676002)(4326008)(8936002)(6116002)(3280700002)(68736007)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Rtfv32Z3I0UauBHJR6o0JDrC8e6Dt/tw+/2LJlNIdvaX6BVlUGFUDD3juGRyYFt8kPVafozgVvd9vG2vQnJwCIwZl9VtJAorMRYFG6pwXiulxpypnJQ2SHELVPegqgP6bW9RvW4+uMy3gIU1mm4UIuDXREG1jOzu9VS80iYxJmM6nl/iM/vE19yZjTGHYa+EeMhjdFGYx03nbo2eZRAqj6hXCjR3PuAS+cKRPtuA1aUBPZ/E3Fp0wpReGK7QhOxgcj08QK18tAzbdsL7owo4Ghi+RCCmPl3oa2DZ71CckuRcIKjDTznQOU3abOA1wVlQV0yP9W5nX0xqGth3M7+mhw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef390df-f745-4968-b7ec-08d58db23cd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:20.5305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ram Amrani <Ram.Amrani@cavium.com>

[ Upstream commit a82dadbce47395747824971db08a128130786fdc ]

When configuring the doorbell DPI address, driver aligns the start
address to 4KB [HW-pages] instead of host PAGE_SIZE.
As a result, RoCE applications might receive addresses which are
unaligned to pages [when PAGE_SIZE > 4KB], which is a security risk.

Fixes: 51ff17251c9c ("qed: Add support for RoCE hw init")
Signed-off-by: Ram Amrani <Ram.Amrani@cavium.com>
Signed-off-by: Yuval Mintz <Yuval.Mintz@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/qlogic/qed/qed_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev.c b/drivers/net/ethern=
et/qlogic/qed/qed_dev.c
index 9a6adbd9ed34..d02313770fc2 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -850,7 +850,7 @@ qed_hw_init_pf_doorbell_bar(struct qed_hwfn *p_hwfn, st=
ruct qed_ptt *p_ptt)
 						   NULL) +
 		       qed_cxt_get_proto_cid_count(p_hwfn, PROTOCOLID_ETH,
 						   NULL);
-	norm_regsize =3D roundup(QED_PF_DEMS_SIZE * non_pwm_conn, 4096);
+	norm_regsize =3D roundup(QED_PF_DEMS_SIZE * non_pwm_conn, PAGE_SIZE);
 	min_addr_reg1 =3D norm_regsize / 4096;
 	pwm_regsize =3D db_bar_size - norm_regsize;
=20
--=20
2.14.1
