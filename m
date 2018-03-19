Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521496194-2-4239236514768981881
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
    t=1521496193; b=LjlqnJ1OcKu30KOGNZe2hxQ6XSqlwUbGrk35mKMWgKDtCg1
    R7Gg3/sH1BepxQyEirLWkYsciYmoUzknAubraFd+Tqr4yDkLVSnufQ5UZe/24/FB
    6b4PbnHdw4mt+jWHqwiew9+F95BTouw9/3amA8oHuek9auOLf1Md1Fup8Dw+yHkW
    44Tn038lmoatatau53+Mz+9jUWrfQNzof2TmQwameKpSezf8D1UVGd3M+7f8mTum
    j8Rgf1ty1MKNCVnn6ddi+h9ZqewBMHKpqln5GWvDEphsszP3f9RjgQuYOmqNkXbe
    ELSmBjkQup/9amAHiSe1BTTtS7A/8sBhgDE0DPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496193; bh=BAmM+V
    dbFEjXZsYdKIVTcU9m5HwZY9g18JsLBKfjJ0c=; b=qlkc4EhUeJDdRKAK1cq6PS
    yZYzZKhStuk7TzMnRqBaCDLhnHAOO1CMq7Gm/GHND4ES/TP4AqmZaSmuTb9chO+I
    aBDsl40MHD2tOXVElPyPkzCfuHzEVsn9xLmxWVAFS/8QHsCI+T+FFiSgD/m9tuKB
    CbvDV0TYrHPUCFaK9Fl1r0knhzAbgzxc9kTT8upqlHdzw0aEwWGfimfHZQvUijw9
    E3mYTTCcOQ2MMRsWXpnehkJa2TQpn1vwvqJGLDzbuWyiQKAd+fFhTTGvYXTnZZdA
    PL/YD4sMZSZkXK29qWaKyTCT3E5kySNS4UvLw+a5Kdaro5KD59V390ayZB+Vak7A
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QgD/r4In x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeehieenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QgD/r4In x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeehieenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965882AbeCSVtH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:49:07 -0400
Received: from mail-by2nam01on0127.outbound.protection.outlook.com ([104.47.34.127]:11541
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933581AbeCSP6M (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:58:12 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kees Cook <keescook@chromium.org>,
        Daniel Micay <danielmicay@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 014/281] bna: Avoid reading past end of buffer
Thread-Topic: [PATCH AUTOSEL for 4.9 014/281] bna: Avoid reading past end of
 buffer
Thread-Index: AQHTv5sRp3d/a9RssUKYtfO32disaQ==
Date: Mon, 19 Mar 2018 15:58:06 +0000
Message-ID: <20180319155742.13731-14-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:eX3LFf2yQe9tgT1apN81HznvA3QYzXD9ST+QyRg/sHcP6wOHBQ4r5yVRYfi9XJv2JWZqgJRWXc/Mgg0A05LRKBeabhMNY2Z/pod/QMXu/T+FGlr0KOWQHsNuoajn2Lc2ep+5c0QZxB2t1NkFwcwfpzWEEYTOwyBCIctxueWR/mlpsoUAw6BKJCqbE3UFZiEzp/tlZrZjVxbnAnphvDxLu1gqZEuz0CLKkFtC0O+RkxfXR6y/+TopyF7Qy7Wt0ov5;20:yQsqCrNWz4ZwVOGteceO20HL/LRkVQ5VOkHL3qhjWwpIYiXJe+fonHBvGyAjYYxdTH6JK9/HXnLjlxdo76a1AbZZyfeQ+vndHf2vRsgj6t4330urHIxNBZfgeoyvSNHfLhCCqE7ppwSLJCV8QIjaBnf3Av2Yerf5drRmOh+AxaQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf1b4af9-a955-4e5e-5832-08d58db23475
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07268EF8BE48EE4603716663FBD40@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(396003)(366004)(376002)(199004)(189003)(81166006)(22452003)(2906002)(3660700001)(10090500001)(102836004)(53936002)(26005)(316002)(14454004)(2950100002)(97736004)(54906003)(86362001)(76176011)(110136005)(99286004)(105586002)(7736002)(10290500003)(66066001)(478600001)(5660300001)(86612001)(6512007)(81156014)(36756003)(305945005)(6506007)(6486002)(6436002)(72206003)(2900100001)(2501003)(5250100002)(59450400001)(186003)(39060400002)(1076002)(3846002)(25786009)(106356001)(8676002)(4326008)(8936002)(6116002)(3280700002)(68736007)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: bfLEEAxlJYEG/8UlAVnuY+ACx+1o6AbublMal3Z0kg7fdpsbuY47eDr6PI/c2fVDfNVlVdetqkmxo/gpvd8P2etqCP4KUeW9RJmO1DkUpWTWWqwN72KvUYrgn9m1LiIFzUEiC81aQjli+WaiOxiRvvS9uOUyxXh25pQ07HdEDQGxyjG/7fgyR8t+9OuY1tI/3AHuqUhnj2qxNaWRiY74FHsB21rJ/DeZSgXtXmj+vZzi1a+ioeMW35hE2Cz55Dx3KIeL/xQ3yaLNKqS1BLDuTqQWROuZ+AL4DAw7fjq229p8bDeGAF0Rptd/lcFjiGU9ZIKqa1m1eDInJg/szbX/TQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1b4af9-a955-4e5e-5832-08d58db23475
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:06.5162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 9e4eb1ce472fbf7b007f23c88ec11c37265e401c ]

Using memcpy() from a string that is shorter than the length copied means
the destination buffer is being filled with arbitrary data from the kernel
rodata segment. Instead, use strncpy() which will fill the trailing bytes
with zeros.

This was found with the future CONFIG_FORTIFY_SOURCE feature.

Cc: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/brocade/bna/bfa_ioc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/brocade/bna/bfa_ioc.c b/drivers/net/ether=
net/brocade/bna/bfa_ioc.c
index 0f6811860ad5..a36e38676640 100644
--- a/drivers/net/ethernet/brocade/bna/bfa_ioc.c
+++ b/drivers/net/ethernet/brocade/bna/bfa_ioc.c
@@ -2845,7 +2845,7 @@ bfa_ioc_get_adapter_optrom_ver(struct bfa_ioc *ioc, c=
har *optrom_ver)
 static void
 bfa_ioc_get_adapter_manufacturer(struct bfa_ioc *ioc, char *manufacturer)
 {
-	memcpy(manufacturer, BFA_MFG_NAME, BFA_ADAPTER_MFG_NAME_LEN);
+	strncpy(manufacturer, BFA_MFG_NAME, BFA_ADAPTER_MFG_NAME_LEN);
 }
=20
 static void
--=20
2.14.1
