Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521498772-2-7097015535392356935
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES encait, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521498771; b=LIO/SOF6fe0yHtMHy+PDUOXC8h9SxJNvHQk+inzgZfpW2Nh
    4SkftiE9yV0XRqAW6k1nnEfRwpC6pCpejp6H4WDl07t0Xx89UUsswr88/pv50dCy
    uVqsopky9sTYsIbTNUGQu2sCoDpmdu7r5eEtVWBb/z/sQAJIebeBjVLkj5pf/dcp
    yLujW1ab6jyj5iez7aBcqFttUaFjw91NHPsy0Pxm7Xzcv/64lwUUZZIdMzCL4kaz
    QwhLf3qbiVSfCb7weSE8KtjeHiUNnVlXn5RUrqGhURhKrWUgMNinm7X/CPruyckz
    ItlDwO7dWem8eh/H5g7bHou2wn1ktbpOFDgxYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498771; bh=oKujlb
    Fechg2W4v7AKx4hJjCuuL4TdBrK4i5sgWVCT8=; b=T2eAtJCsFsQnFhJYg7idXM
    Mi9Px9rFi92yL8AhLinEHtYpI5+exIbyY7hDmo3MycMtbUGFYkDIc/kMx3laPSEk
    ttELfGV7Cq1hak6cbnEk8mXOpB0Z52mORjST3gjQ317g6QRA3bkjQKXlQQoKav8v
    bIMiQfo8e9W+VXZ/KOa6YZ1i4Q9idtyYsTyDVOxFTaiVjlTUq4fNg8LGSbw08zwC
    3MFMyaxxCu6hTingmquNnJEz1p/ElViRCUTUFVNQ8DMxCejLy0/vITTXLV7OGFz/
    Degz5MoxHdFuBP4srAymUIbE6czRSIlHi+fDaFbfilOaJmoETqAQx/giwOq3AYiQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=U3fhwARx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekgedugeenucevlhhushhtvghrufhiiigvpeejge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=U3fhwARx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekgedugeenucevlhhushhtvghrufhiiigvpeejge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936546AbeCSWcp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:32:45 -0400
Received: from mail-cys01nam02on0114.outbound.protection.outlook.com ([104.47.37.114]:45246
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933724AbeCSPsI (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alex Estrin <alex.estrin@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 039/124] IB/ipoib: Fix for notify send CQ
 failure messages
Thread-Topic: [PATCH AUTOSEL for 4.15 039/124] IB/ipoib: Fix for notify send
 CQ failure messages
Thread-Index: AQHTv5mchxTtfgEOtUikblTCUbzQyQ==
Date: Mon, 19 Mar 2018 15:47:39 +0000
Message-ID: <20180319154645.11350-39-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:R7DKK4F8vDFnOhiQ91SeCuql0HfF1s3NhIZRJB6j33Ha6fetvYsKkChvaEdTPPgKSLtuJQZ94WWUVKbZS9XbK1nwtpHF55kbHk0g8vd47eDuxCaaou/1qG6ckFiAVqucBN/nIzU/KN8MJt07duCxK5CS86IZDprUy3Nrxv8pwZwLaW/tDL1BGWquWOGsOydYrsWfCydAgeltQGV/kIfzFgPVt+EguCeLKA/G+0UDuG+TKF5WMR1I1JcEiL11YlEb;20:48WP00zxUnbQWe8wZ5hUPY4f2K60ApBZJIovDbG6UMr5yS429cExJ7iLiHGXWHLiHToJd+SdbpuIxk4070CZqiOP0M6F0UjKFuYjRpzLYYJFKY3cUP4n9X5YZW2poOvNRjbuUDfAqR1/oTseO5cG0lDLUO21mglpeePuSxuTRBI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: be8213be-933d-499d-7f42-08d58db0ceb1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09980A6B894D2593F82FB487FBD40@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(376002)(396003)(346002)(199004)(189003)(3846002)(6116002)(8936002)(6486002)(102836004)(68736007)(6506007)(2900100001)(22452003)(25786009)(15650500001)(3660700001)(7736002)(76176011)(6512007)(72206003)(86362001)(575784001)(53936002)(8676002)(81156014)(6436002)(81166006)(305945005)(478600001)(99286004)(2950100002)(14454004)(6666003)(10290500003)(186003)(107886003)(2501003)(106356001)(26005)(86612001)(97736004)(5660300001)(10090500001)(110136005)(54906003)(316002)(2906002)(66066001)(105586002)(4326008)(36756003)(3280700002)(1076002)(5250100002)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: sUBul9M7Q+RpjzOiFh3/0Kth/aZyCNbFIzfQkQIyqYv6A6o5v6GbQA0wOzBGM6daPODt6CLSvOo44NvSu7QWMx62XX7XC3+KbjrXTCyR9mPvwoUijs4EBbIVe/c3Xc6QqmG0LCgoKU17G4ULCzmK2C54dTisTaFtg48A76QfXToo1HDtteSRPz/jn5sjLBdDCJwdJZi4h2ww4i1IvIJSW0z0Q8rbmsXZ1gAhbHBBkTIe84zBaw+4VyudaUrfj9krx1w3OpD5PS42luatkuiCyqbHrF3HKBcJdiXunYtlCr9syPffCcHYv1Ttl9dvDRMeN9zJCu+dLDpkigS96bmPoA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8213be-933d-499d-7f42-08d58db0ceb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:39.6675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alex Estrin <alex.estrin@intel.com>

[ Upstream commit 809cb6955650d892c6ef95f1d55f28fceded0ce1 ]

If IB_CQ_REPORT_MISSED_EVENTS flag is passed in ib_req_notify_cq()
it may return positive value indicating non-empty CQ.
If return code not verified the log might be flooded with false
warning messages "request notify on send CQ failed".

Fixes: 8966e28d2e40 ("IB/ipoib: Use NAPI in UD/TX flows")
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Alex Estrin <alex.estrin@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_cm.c | 10 ++++++----
 drivers/infiniband/ulp/ipoib/ipoib_ib.c |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/u=
lp/ipoib/ipoib_cm.c
index 71ea9e26666c..c075d6850ed3 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -766,12 +766,14 @@ void ipoib_cm_send(struct net_device *dev, struct sk_=
buff *skb, struct ipoib_cm_
 	skb_orphan(skb);
 	skb_dst_drop(skb);
=20
-	if (netif_queue_stopped(dev))
-		if (ib_req_notify_cq(priv->send_cq, IB_CQ_NEXT_COMP |
-				     IB_CQ_REPORT_MISSED_EVENTS)) {
+	if (netif_queue_stopped(dev)) {
+		rc =3D ib_req_notify_cq(priv->send_cq, IB_CQ_NEXT_COMP |
+				      IB_CQ_REPORT_MISSED_EVENTS);
+		if (unlikely(rc < 0))
 			ipoib_warn(priv, "IPoIB/CM:request notify on send CQ failed\n");
+		else if (rc)
 			napi_schedule(&priv->send_napi);
-		}
+	}
=20
 	rc =3D post_send(priv, tx, tx->tx_head & (ipoib_sendq_size - 1), tx_req);
 	if (unlikely(rc)) {
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/u=
lp/ipoib/ipoib_ib.c
index e6151a29c412..28658080e761 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -644,7 +644,7 @@ int ipoib_send(struct net_device *dev, struct sk_buff *=
skb,
=20
 	if (netif_queue_stopped(dev))
 		if (ib_req_notify_cq(priv->send_cq, IB_CQ_NEXT_COMP |
-				     IB_CQ_REPORT_MISSED_EVENTS))
+				     IB_CQ_REPORT_MISSED_EVENTS) < 0)
 			ipoib_warn(priv, "request notify on send CQ failed\n");
=20
 	rc =3D post_send(priv, priv->tx_head & (ipoib_sendq_size - 1),
--=20
2.14.1
