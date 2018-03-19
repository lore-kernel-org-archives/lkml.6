Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521498334-2-12296030053475533877
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
    t=1521498333; b=jWhkTUzeyhLCKPS4LuNAKteIZHiPuqeEVj7LXsIR4nJB7XT
    tTQRqiHi5DyNlrKTLQLBV4TEx+mvEzaEs+R7NZyXVUnK/UGqonL6NOgxmEpNQDrm
    vdby0jEh5di2tsObknWQY/gHKRrgMAnl3O/tB0HTq2i/24Qae+VE6hoj7tpM7TgN
    jVDRKWKRkEHoAhayr0EPxhuhiY21K0vrW598InAAu9IeHyrGTHsBprxbGPiY1a1V
    pil/4eWEVEEn0oG4y5+9sgT93EMOPsFZG79b1/DxvOCQPnHoOjfFO/8yIKikKjx6
    GRMHH/zWr6wvDLsQgVe83E6+FUPoj0r1zsoLySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498333; bh=JEgF9Q
    Tj4Dupxso5TGgH5QCGmSMtvaArXO4YgQwcwKQ=; b=Isg+3mnN6Fvg5Pap0nfN2s
    DIvGbI0t9+fq94mItSP64mn1YChfM6HPefvFXCiAn2dEpYOs925JmO/2D6CmOqLn
    6z5ms3QY+uSlf6x8wygNx7I2VaY5ukJRebQWSEXhfRjWlS6YVV2rWoOs8Y8kAHkN
    ev2RolvsnELheNvqtRRIIKwLVbMvacodfpivpFPfRgKbgXaAvAbthEFEL6Iq6n7L
    NqojYibTC8BMDtxpPhUittjvSd9ZV6ynls5ZC8ESwq098nDSbhPJeAHpnBEv0SIq
    EwplixzEAyA2ZI/nKJKJbgOiwKg/dsAS+3q9hLk1LFcCGDLl6DwqQ+6iU73iNAAQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LummLmmQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeejjeenucevlhhushhtvghrufhiiigvpeduje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LummLmmQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeejjeenucevlhhushhtvghrufhiiigvpeduje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936439AbeCSWYd (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:24:33 -0400
Received: from mail-cys01nam02on0111.outbound.protection.outlook.com ([104.47.37.111]:18692
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933844AbeCSPtE (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:04 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Colin Ian King <colin.king@canonical.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 073/124] wl1251: check return from call to
 wl1251_acx_arp_ip_filter
Thread-Topic: [PATCH AUTOSEL for 4.15 073/124] wl1251: check return from call
 to wl1251_acx_arp_ip_filter
Thread-Index: AQHTv5m0HTvppWjnfEibIfmah9gBxQ==
Date: Mon, 19 Mar 2018 15:48:20 +0000
Message-ID: <20180319154645.11350-73-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:9G/fCfsILCkTXfBepxQrjALOHxEJswnDvtujZ0VrMFojnfzaWjN/07hcuajtVb38ZgUmLjKS/zL3fdxX6BxXELWdO9Pe8yT13Opqcj3UPYRcT1tuISFRo9gEXlIB1OsiWgMIzLM0wej3GHY9j5HWqTcBeQ2Dy23Oc6fHp8dx102drDYZgWbo+EaRVHhCRDrK2OOriBPKF/OOCD2fwo0KmELBIUWJE9O/bcIZTCLom1rSZzL5531M0pdxnc/c4rjX;20:hgBevF/ts+RCrZVRGXpXWnim+e6Ql1tqPjfwbsENvtgH+yhD8HxIlo+vA6AWFaf3/bdZCmNb7Xshlw2bRBK0T+jnZ9ngnQSgBjDQGTpow56foC2dJwJvdxWwH2YQqQFRzNG+97y6PaHPcYDElo04wDTRkpeXNs3BlFv/WnE/r50=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00e85606-2e82-4d1f-6e1b-08d58db0ec73
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919012ACB426F6AFDF7305DFBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(396003)(39380400002)(346002)(199004)(189003)(6512007)(5250100002)(106356001)(99286004)(102836004)(2501003)(6116002)(1076002)(3846002)(186003)(10090500001)(76176011)(6486002)(25786009)(316002)(26005)(22452003)(68736007)(6436002)(2900100001)(15760500003)(54906003)(2950100002)(6666003)(72206003)(81156014)(3660700001)(4326008)(7736002)(110136005)(305945005)(478600001)(3280700002)(6506007)(97736004)(81166006)(8676002)(10290500003)(66066001)(2906002)(86362001)(105586002)(8936002)(53936002)(36756003)(14454004)(86612001)(5660300001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Mpy8FvV+dtVNK5w1tpltH81kRSZgo6EaVndfPudLjuEaATOV7/+MzbUfLoqcChq8s1FBx8gGx0Lh+2ZTUMmPuE/AWlB48UWv+xObkzCl/9ax/b1y9Mi2WTLApSiyGy9LoJ8u0iGRo6WF01//D8nilgQJKL/USFPnUTQHShjT65x8xzmBVtSoUUz3SnJRytnn2X67GfZjeYtFJe/nhSCjhiXfLE/ZSvbphY/MJFqKYINhl7WGFKJXi2vS9Z54wCA0nNrP77PHCB+0r/uLCJoDCj5Ulqrixju1hN+2gG+ElN4DyYrZEankyf/tMBtmGE0p9pNNjmhSz6X3r+3JQrRTNg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e85606-2e82-4d1f-6e1b-08d58db0ec73
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:20.2128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
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
index 6d02c660b4ab..037defd10b91 100644
--- a/drivers/net/wireless/ti/wl1251/main.c
+++ b/drivers/net/wireless/ti/wl1251/main.c
@@ -1200,8 +1200,7 @@ static void wl1251_op_bss_info_changed(struct ieee802=
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
