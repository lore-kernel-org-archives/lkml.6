Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480253-2-6056472623324082924
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521480252; b=lDzuNPG9EfH9hfef0PzVk0/j/wnZRwlQhFM7v6esesR0hDo
    IRm0wsEPcABWZuhGwah1ipXa/jNk3TlcUIml2KJyElRAViREw0b539Lt7tBdMa96
    tc05+Yfejx/Q1RhXW8rfWzL8QKexlzdd93CjMKc0uwNYzhjhIccmec8pRrXEqkt3
    D5mo1pTyscRvxo/gVYoiSLnsmNroGkH4w1Q/3o/L2REs6t4y4t327m5Ynx9akJXw
    C5dn8ToEdLlhWNMXZ4VSab8fLTEuli3kzVwTwiQw6En495vFiFe1qrUCb9x7msE5
    X8vgUNxA4rHIG/mXYdIhQCwEk0gvACiwb+3xcHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480252; bh=ZRFuMz
    EimiaH3nZQGJQIBDtth+UwEkT5UHxX2meMsOc=; b=ucK6285uYHcg7EKmcfdGmD
    y9Nv626wXr1KeO1bWMdTXP4JodrjdwEfMZXZ278+A53RtMfJu/qg3Z0SUtrBtSa2
    qwRoJglsSkqUPGb1SdEfN78KcIKkc6xL8Shx5i2tFm2aWdiDQxi1LSR3SQ/jx3TV
    sOUrAEYjI8KiVRndYpeJ49kxTVxc8Het+MWbBiCecu9wOqEDypfvL1TEXnI4B2sF
    iT4sKVFkxSisu2H+JK+dx19PSW89cb52dj7ImxWw9pJNbr3DinVNS5N+skYFGIWF
    V2LgEdSsLTO63lNQOnHfT9A99EABw9AFJa3pZshng6Cx8fKTtP1z6Pzi6UJ+b/0g
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WPI6/B4p x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdejudenucevlhhushhtvghrufhiiigvpeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WPI6/B4p x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdejudenucevlhhushhtvghrufhiiigvpeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965811AbeCSQIp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:08:45 -0400
Received: from mail-dm3nam03on0096.outbound.protection.outlook.com ([104.47.41.96]:30671
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966305AbeCSQIb (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:08:31 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Guoqing Jiang <gqjiang@suse.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Shaohua Li <shli@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 059/167] md-cluster: fix potential lock issue
 in add_new_disk
Thread-Topic: [PATCH AUTOSEL for 4.4 059/167] md-cluster: fix potential lock
 issue in add_new_disk
Thread-Index: AQHTv5xA4UqYS4t79UmdBzhNaBtHhw==
Date: Mon, 19 Mar 2018 16:06:34 +0000
Message-ID: <20180319160513.16384-59-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:7sLxDKGrs3/M45QCJh/hYBz6g4LcVtsiedHN55oEPNfgU5ZFu5Ox1a/42vZ2Thm8fz/cw5Y0boeKNHqC7Y84uoHR16FjeU7D+73jAaepfrhUxrJSRz4q1oqZtWEp8RXneton99SjRO/U+DgHJSgq90Ihfa4Xny79ej1dmPNin/Rtq0qESF/dN89Wiso2ZVze2RUP/dpR/F85h7H+EDm9mNDJSARRoqscvONqM4PrlCwEY/GHMkp/y13/HyzbI9lG;20:fYfONd9T3pU+oQP6iL64GaG9Ne+vFpwyion62FEID03ECIluqdkCPOvBygKmlyIl9j7LaoaTVBEoOGeH4nC4/R8XRzNO/WzYCwlZds7J+PB08AHcXMKY8JS/Hf3dFPxBFcdlIghZYOLMCfbsWvyTcdI+TescTdaHcu3QKQ7erRA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d309a273-b811-42ff-6a3e-08d58db3a40b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08054D2E88C4BE4425F2B75DFBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(575784001)(2950100002)(305945005)(186003)(86362001)(6506007)(3660700001)(6666003)(5660300001)(6116002)(8936002)(3846002)(1076002)(26005)(7736002)(6486002)(2900100001)(6436002)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(59450400001)(8676002)(14454004)(105586002)(107886003)(25786009)(478600001)(2501003)(5250100002)(53936002)(3280700002)(316002)(54906003)(4326008)(6512007)(72206003)(66066001)(22452003)(10290500003)(99286004)(76176011)(36756003)(97736004)(106356001)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: jSrJ/GoZi76pNnrHlOzMnfaQBsDj1Q6E+jr1hmkKSeTgO/CikSafmb8N6nbCv7yFFcJhaal5E9VMfGRcmAym+xRPoayxWuHFmjgedauX8lYyyNj6d3Bvb5AIQwbS7mu85kz4dHR4vMm51Ls3w2YznL0LScskeQQCFsXcYo74utw4MPNVDX1PGNedQ1m9BhYaR1Fl5g8NdwdQoC//Oij5o/LDlwbWY8JJGAP/cLjXpOuHzmrz2lnpmY2x3A955rlTfwNbBfI7U0r51oKblwwIdDQdD4FpI13wOXyxtPo3zP1OAv+5fzzHoiDwC/eTzkOtghRpLoB+nIHfA6rkAzT1DQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d309a273-b811-42ff-6a3e-08d58db3a40b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:34.6697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Guoqing Jiang <gqjiang@suse.com>

[ Upstream commit 2dffdc0724004f38f5e39907747b53e4b0d80e59 ]

The add_new_disk returns with communication locked if
__sendmsg returns failure, fix it with call unlock_comm
before return.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
CC: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/md-cluster.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index 494d01d0e92a..a7a561af05c9 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -945,8 +945,10 @@ static int add_new_disk(struct mddev *mddev, struct md=
_rdev *rdev)
 	cmsg.raid_slot =3D cpu_to_le32(rdev->desc_nr);
 	lock_comm(cinfo);
 	ret =3D __sendmsg(cinfo, &cmsg);
-	if (ret)
+	if (ret) {
+		unlock_comm(cinfo);
 		return ret;
+	}
 	cinfo->no_new_dev_lockres->flags |=3D DLM_LKF_NOQUEUE;
 	ret =3D dlm_lock_sync(cinfo->no_new_dev_lockres, DLM_LOCK_EX);
 	cinfo->no_new_dev_lockres->flags &=3D ~DLM_LKF_NOQUEUE;
--=20
2.14.1
