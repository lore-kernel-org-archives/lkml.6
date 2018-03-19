Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521496791-2-6378490344812387913
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
    t=1521496790; b=KlhSRFQSllvAyPjhCIvk45xmRZ5PV3wXD9Clii1/OlG3HLq
    xYmJ7QmmzJ/REdgrlwZkTmfN7KvTctcCuPa9uNomOTcz/6o4FBem6fSLiSYqS8JN
    82AKBH4drpL5T0y3ObL8l/adv0lzeT01z97s10k5+OGJ17Y8I/q8nAQoynYzILfl
    mNFzkHG+JC8gBc33f1sbfdbLKCrRF8G8pIkyONfBiAgKpZVlrxSmzPsJlzJ7Z8YK
    fs42mtxjpYOZhKVM8JMiH94Xw/hbnHvTBsnFEKJL/vifY8YPH1a7o6vWuV5r1WKf
    2nUrH6TSPkfUo8/TPoYrhyEBNZqulfFvlkOeakA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496790; bh=JEgF9Q
    Tj4Dupxso5TGgH5QCGmSMtvaArXO4YgQwcwKQ=; b=O3e1SSoxkJ9rbdkD0Pn2+h
    MjGoee4qDpWjn9afYMZ2dePQRSg5dw6ne3NfIbIDz35qYZKdcIIL7/7+HNjko1iS
    XjFn/U49mNCayMcC0zy9zrp4BqJVyFOECM0x2NZicRRJUZV+xlmVT8tXUO8BjMf9
    De4tF9slb/CSw39phqx808jMCNeV6AnKQNxTQRBF1jyFpSyzmbt7cAFugdqu7Jf/
    T7OletVysOMtx3W05f//N+KSJUii41rJ0JfO48fE1zX6dMCzOWf4YOX8W0IqbFcZ
    m6B0Ct99a5TFLThmzN3FNfnUxMDzrt2xshjLBk3vbW0lp6gpfEthDib3iSlG4htA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n9BR/XCH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeejudenucevlhhushhtvghrufhiiigvpeehhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n9BR/XCH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeejudenucevlhhushhtvghrufhiiigvpeehhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934478AbeCSP4G (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:56:06 -0400
Received: from mail-dm3nam03on0127.outbound.protection.outlook.com ([104.47.41.127]:29856
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934467AbeCSP4C (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:02 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Colin Ian King <colin.king@canonical.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 57/97] wl1251: check return from call to
 wl1251_acx_arp_ip_filter
Thread-Topic: [PATCH AUTOSEL for 4.14 57/97] wl1251: check return from call to
 wl1251_acx_arp_ip_filter
Thread-Index: AQHTv5q9SsSsuSLmK0WJCfdKLhws6g==
Date: Mon, 19 Mar 2018 15:55:44 +0000
Message-ID: <20180319155411.12348-57-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:k1Qdlvu4iREDWaWdi7IaKIczuVvrr6o3B8iJCm77OMxyXtzrheCMObVUySKBTfEN8ef8v1M84K3jYAThL6uWBcc45zuX0JDAgXi5SRshZx1ZPpsGe7FIgH5m25TbcR8nSa6FSHn3YsSZzTwp4i/+n0rQL2Rv5OVxo4LODzUo//4EbLdZvEPHFu72vRC+DG0M1WuGrWQwW8Uh97ECn3SCgXjBEXBM9gyT96ByGi0iH+8pKKLG7JQpdC6cygyV/E8o;20:5ZXnC4xJUE29isYItSaooLJY2JhQ89udSqqkraXlg/TP4b0MgvdgVI9YwkBBaPag+gumPTDiuLodRQRszOHVRJVyaHQ9VtGnKNLmPa5SIhgZGzjfWGgy8Qb3raJEOL75+YcVx6DiGSsRuIkQkTbDugfDy0wkEZZ1pbZp5isOiJU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 128b5d97-bb56-4eee-77c8-08d58db1e7b8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08075C16954B81E8C918AAAEFBD40@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39380400002)(39860400002)(199004)(189003)(26005)(10290500003)(305945005)(6666003)(68736007)(186003)(15760500003)(102836004)(4326008)(25786009)(66066001)(6506007)(8676002)(2900100001)(5660300001)(7736002)(2950100002)(81166006)(10090500001)(81156014)(97736004)(2501003)(5250100002)(3280700002)(316002)(76176011)(478600001)(8936002)(99286004)(53936002)(36756003)(86612001)(72206003)(107886003)(110136005)(54906003)(6512007)(14454004)(6436002)(22452003)(3660700001)(3846002)(6486002)(6116002)(106356001)(1076002)(105586002)(2906002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: E+vkAETyc4cbq5gLr1q1PX/2kML+vvJ5d7wC/wlcgQBMG7MZP+MDKhD0mh0JMVosUuZI/gcTrkSfAPUbzBIwv3fgCJEQ9mebXryxAirxGbhhj3HJPzITxzvD5kr+mknI0O3/mFfbe6RqtTXq/B0xniOS6Hds9YGiV/UcwP9p4UzzyyW1B5+9gIKC6MtMX7fGb+2yeociIYiN5radXgjjOQrpfVXhfhppIkCLB2fjb6qQSfwVR8fhMcFXKY+13FwfpEqnTkhe0LkxTT1DcyXVMAW1Fp7XWo9RN+thzxxSSJReKcTkswgsO4R95L5IouFqkWG+pQk2cGehZBl8nj5xsQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128b5d97-bb56-4eee-77c8-08d58db1e7b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:44.8770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
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
