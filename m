Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1639138-1517683906-2-13036020160888197386
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683905; b=w3k1058EKR18L1HFbc8NKgErpgDuVs5lgpzy4Qb5crB3CGW
    CrFruovcWZGI0BgfKwjTuz/0BblhOEyHgpfxRwpxbPvYtb6WPQvWvpd70/Ko2o84
    ypG5jzd2hu882E1qzyJ0ZUO4qyHebYx9H6C4tTbN40mnglf3Em013d65s7NZf1jv
    uEbG3o+g8CvIYEDtY8mxxWZaM+ZTaoOZfjmppoFDmLtErIVLPnHE1q11K17sHDBt
    wT8LUed1/+PSltl5hLQVOlFUwB9/7aSO5xU3f1EjEi9Zl7ygYxNi7q2zKr9Z7MJ2
    WEKlZ3eK3neHluDeYRT7SXGxRGbZMwGTtGTNnRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683905; bh=PAYC7C
    q03pB4dSwiowHhrmA+27nVju8+7eFO0dH4K0k=; b=bQAvjWb1dzwULtw7UIFZJ6
    V3w/jSIBRMd4psA1VBibQn+YR86unmi/2HEHP0WIHE0FoUTf6GWoic5KcsmFjztQ
    aGj63UheHT1A0tTdMCGsntZWlFdTYNdmv84YuEL/wMlRH4RhW8kr7Qlq+30g5x9P
    WXzJuKMfPY1bcfDbdSoxxiNvx270v+M21v75Gh0ZTxq9z1OaXVg/htRwZAjF+vpr
    yi3z4os05BIrpwH9PUKGX+2xFGaVQGws1lXEn2zMmmLUNLh4IkxLcahxiGLcK2q2
    ryptiMUGFgtKZt+/elizufW9VnXH2xjwnnJH/zC2qnsrjnx0sI1RzZZ6ZU5+972A
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fHsn6qq6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fHsn6qq6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754033AbeBCSvm (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:51:42 -0500
Received: from mail-bl2nam02on0134.outbound.protection.outlook.com ([104.47.38.134]:35168
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752882AbeBCSBW (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:01:22 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jia-Ju Bai <baijiaju1990@163.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 027/110] mac80211_hwsim: Fix a possible
 sleep-in-atomic bug in hwsim_get_radio_nl
Thread-Topic: [PATCH AUTOSEL for 4.14 027/110] mac80211_hwsim: Fix a possible
 sleep-in-atomic bug in hwsim_get_radio_nl
Thread-Index: AQHTnRjnCQJhuYMgOUi4uncjYFp40w==
Date: Sat, 3 Feb 2018 18:00:41 +0000
Message-ID: <20180203180015.29073-27-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1090;7:um8zo3b/UVzrzmHss1yw7wFs3NGfyCwyMzYV3ijMmjJ+1QiLs2OvkCyrQGqdMUBLTzGtSZtaC09HFk6M1aMSOfJybyIcIWJ9+/7qb8GACw6Ssv/SMKka49sgC8uVI+ajZJrhVLVj/tBVqoXPjL9/umHZMmPe7/e0/ysa+QKMHkDo2nwyRq8AuPorb44S0GpxOCdthnmwV2DOErRpUcJ0AuribAxYY+fjLmUSHAtyZW0KIwf5tF1cC1Q4JXymWNWu
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2456e8d1-0b7d-4c03-f6b9-08d56b300b5b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1090;
x-ms-traffictypediagnostic: BL0PR2101MB1090:
x-microsoft-antispam-prvs: <BL0PR2101MB10902DA5FDE731889FD80C08FBF80@BL0PR2101MB1090.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1090;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1090;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(2900100001)(5660300001)(316002)(25786009)(4326008)(14454004)(2950100002)(478600001)(107886003)(72206003)(22452003)(10290500003)(186003)(3660700001)(86612001)(76176011)(86362001)(53936002)(3280700002)(106356001)(6436002)(6486002)(59450400001)(81166006)(81156014)(2501003)(6506007)(97736004)(26005)(7736002)(6512007)(6346003)(102836004)(105586002)(68736007)(8936002)(5250100002)(305945005)(36756003)(1076002)(6116002)(3846002)(8676002)(110136005)(66066001)(54906003)(2906002)(10090500001)(99286004)(22906009)(31853002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1090;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 3UH8vvU07kQc8SjM+vPgK3Tr1gOoL0tz2hluPbvXGAMXljPxfobEbcR6rXT+g/mo0yHMVHrD5Ms5E3s+pcgUhg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2456e8d1-0b7d-4c03-f6b9-08d56b300b5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:41.2221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1090
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jia-Ju Bai <baijiaju1990@163.com>

[ Upstream commit 162bd5e5fd921785077b5862d8f2ffabe2fe11e5 ]

The driver may sleep under a spinlock.
The function call path is:
hwsim_get_radio_nl (acquire the spinlock)
  nlmsg_new(GFP_KERNEL) --> may sleep

To fix it, GFP_KERNEL is replaced with GFP_ATOMIC.

This bug is found by my static analysis tool(DSAC) and checked by my code r=
eview.

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/m=
ac80211_hwsim.c
index a59b54328c07..1cc6e97fec8d 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3215,7 +3215,7 @@ static int hwsim_get_radio_nl(struct sk_buff *msg, st=
ruct genl_info *info)
 		if (!net_eq(wiphy_net(data->hw->wiphy), genl_info_net(info)))
 			continue;
=20
-		skb =3D nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+		skb =3D nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
 		if (!skb) {
 			res =3D -ENOMEM;
 			goto out_err;
--=20
2.11.0
