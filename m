Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682558-2-2598050284720009785
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
    t=1517682557; b=LEQEG0WVs0zW2sLvydZHzMLlwpcEsMcoJfkS+afmL1H5CL4
    zoGB0umvsdOtyCrj/ZaOE555vXKg0/A53RxzXL4XwtQdvDVnnX+FRzpOEzhXxEYM
    f0DrlaNRaGAdzYbPBR3SvaM9PmoBtePQ6lTq1Sg6JB//YAVNKog/9B9p8mtKQWKf
    HCwSeBs15TlfO5OxCKJ855ht9NJBsvg+Wozx1xALWqFjs1XStvmrs8INDp013OLt
    vK9V2m50Of8PJsdVieYzWNVM5X36O1vYdb4mAPNdkh6J5C0+r9KHdW2uJOYMc4vk
    njZPJ1UMI3akxrzChgg6AjVgv8hQ29X2N8WXD2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682557; bh=SBBE5h
    j4nK5bMwgF5p8uzhWvGl2wdZHxfXEuQSaph0Q=; b=HZDP9NxRB8XyU0V2JzOrg5
    YvrDWMKu8fNI3xnhpIrnAB4m/5h803LqSr9p6+M2NEb4iz7VO/97wa3smECpW+Qm
    xsb4W6uzLj8qhGqGnxlLDWOr7t0o4//zfgPeWobBypBJu3kwkn32wklknLTsv641
    NvZvd4CjDxiKYRCMPBQ4Hk6o5eqj7Im0JxHKWjgI89rl09TOJZd9eEPfMYc7eieV
    Xu/rM/L7W8YMxJSrcNLGbqIa/m2GuTZghBlChZbXHezglvi5GYX0J9cD46Li0hhq
    01QKd0jh9DgLrEhStaiFf/L4/R8h98eTfmUw+1AoqHAvjOllPt/uTkdh26jQWUow
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bAIpziny x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bAIpziny x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754371AbeBCS3K (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:29:10 -0500
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:50784
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753294AbeBCSEe (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:04:34 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jia-Ju Bai <baijiaju1990@163.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 13/52] mac80211_hwsim: Fix a possible
 sleep-in-atomic bug in hwsim_get_radio_nl
Thread-Topic: [PATCH AUTOSEL for 4.9 13/52] mac80211_hwsim: Fix a possible
 sleep-in-atomic bug in hwsim_get_radio_nl
Thread-Index: AQHTnRlSBD/iSd9sU0eGt8DTZVmcnA==
Date: Sat, 3 Feb 2018 18:03:40 +0000
Message-ID: <20180203180303.8490-13-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1091;7:yHs/OjtX4vdx+ThW51BNv2L3yEJeA+PN9kB+vAUQU7bndFKbU0rNDK5h0U7wulGjlj2s+i50esoK8U//Wz4DnGAUbP7tcqwvU8OAJYtd56/G+YQs8U4BpYDa+NAVxwzniAaYL1DaZyRPKUvPgKVUk3ovK040D0EP4By0udUgsBImQ+Vp2s6UV8r0ql02UOam72gwyJ3S8+4DxrKB1+zlOgsN0UATy4qJlV3csTunfBM/8lAXKOyyqnBsclMp/zHf
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 33084258-c7cc-4461-fb31-08d56b3074ee
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1091;
x-ms-traffictypediagnostic: BL0PR2101MB1091:
x-microsoft-antispam-prvs: <BL0PR2101MB1091F1465862A44DE4B80B39FBF80@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1091;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1091;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(346002)(376002)(366004)(39860400002)(199004)(189003)(86362001)(106356001)(22452003)(4326008)(97736004)(25786009)(2950100002)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(2900100001)(107886003)(3846002)(102836004)(1076002)(26005)(6346003)(66066001)(10090500001)(76176011)(6506007)(10290500003)(14454004)(186003)(6486002)(59450400001)(6436002)(53936002)(72206003)(7736002)(316002)(305945005)(99286004)(110136005)(54906003)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(31853002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1091;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 4x7Zm1fzsW7fh3mjPYhLju99b7yzxzxlHPI9ImUnLYPAQ3bfmiw33QPTMGj3tgOkQ7Q8jKbcE65ocRgjROyLnQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33084258-c7cc-4461-fb31-08d56b3074ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:40.4870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
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
index 4b462dc21c41..61e85eac706a 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3154,7 +3154,7 @@ static int hwsim_get_radio_nl(struct sk_buff *msg, st=
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
