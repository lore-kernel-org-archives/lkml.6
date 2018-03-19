Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480165-2-7383801225105349954
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
    t=1521480164; b=U0pEqtjZ7L1QX78WT5rBlQkqHb4CHugtazfR4qh9DNTnsc/
    JrJHVyT+7djPkpp8XBGq/6zbTXmjOKhmuz1I2axq+HEe5guzOtabjshsy/LUVSYy
    BSVJyiVxKJj2kB76vmSEMFm911dyoDGcTI/WelI8OiEsU9wmgLFBPcvEYzpatT6v
    3M4S9I6f0YvEw8MHN7eLNSnTWc0WM3crTcZ2HsQiMfnAGH4vNUV/733XiqIJgKN3
    QbAp713msk4ldKI5d1wY7nVZICpu3VbUbOFoN/KLCT5KGw2yAsgzPujYih34/Z4W
    CvYao9jZXprgbRuFBaeR5BUXuu4tVKn6G9Df3Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480164; bh=4/NVtt
    s7KV+rmKtRtRBvjN3mkQeozkI9SQEdeWIpYKE=; b=nw5oHxOWgQ74b9zTYrDRyo
    e2t+0BCXgg3pcBnxWKse0MTc3V8tScP8l4Ue+BXZ/UvKM9pk1bPHmofx2brAf20R
    o/XoY/eghxTm8vz4JmSfif3GkLjGihpCWLK1CvumM5rScW3CCMTt0Wzxt9Wsa9YC
    Xadr8Njc6LvCjw1WBMtGNKf6ue61F6G042KIKk3JO4M7FDskeNrDqubEOmai33S+
    OFzV5o9wy48ddD4vGhak7KPOUN+G83rPa86owCCuYVWzfp+BhZHbYMG9ENKtwkTU
    8+420x8HnHstgWfQfRi3cKHWr9YaagiLtR9VLzWO51t4KT4+IzMpqgSTWn8FoUiw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ube82VwP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeektdenucevlhhushhtvghrufhiiigvpeduhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ube82VwP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeektdenucevlhhushhtvghrufhiiigvpeduhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968049AbeCSRVs (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:21:48 -0400
Received: from mail-cys01nam02on0124.outbound.protection.outlook.com ([104.47.37.124]:59524
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966390AbeCSQJF (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:05 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jesper Dangaard Brouer <brouer@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 067/167] mlx5: fix bug reading rss_hash_type
 from CQE
Thread-Topic: [PATCH AUTOSEL for 4.4 067/167] mlx5: fix bug reading
 rss_hash_type from CQE
Thread-Index: AQHTv5xHFWAInscKtkShLEfxWlrVDQ==
Date: Mon, 19 Mar 2018 16:06:45 +0000
Message-ID: <20180319160513.16384-67-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0965;7:eSHSAlNEWgYHkisn5gSh/A9S5myrDjQy4XgvuDcjQPeOjZLDuiSzMFna0U+hwFx+dqa0I11VWE0A8qEMtBmRahJ+4F6RrNz+Tj8JaLVauBVzzSM4eiWf9bfv6CPz8e3Q7PORuLu/6nYFfNVhpgYR0IO/7r1LAjT/fmOz51PSQz4oCEvCviA21GnUi/Pm5uqz0TeW8fq3eOiTL3HaTHOvfUufyxLAGzBpzzTPhTxdMYajvPPJofq9xydddXPurwhi;20:Z4xd5Mi0njPYiW41R5duKZ7/FGAc5qKsVSQ0XNmF4vHwOIBnHmeh7Nk4jOkVRUHKiT1DN3xBPzyqXfehO35PyvP9NlnU2blLGZvQZ7BcG7DXoXmDrSjYPMnJk1W43bri4JB2/tSLe62JwvmA2QF8TrQzG5KH5GGWEZMUbiGKlmU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cedf63ed-1aca-496d-908a-08d58db3b85a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0965;
x-ms-traffictypediagnostic: DM5PR2101MB0965:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB096526FC2D3A2C404E6CFC13FBD40@DM5PR2101MB0965.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0965;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0965;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(39380400002)(189003)(199004)(25786009)(7736002)(6506007)(86362001)(86612001)(10090500001)(478600001)(53936002)(6666003)(6512007)(36756003)(2950100002)(8936002)(110136005)(54906003)(105586002)(14454004)(107886003)(72206003)(10290500003)(316002)(102836004)(2501003)(5250100002)(99286004)(22452003)(305945005)(6436002)(6486002)(1076002)(76176011)(26005)(4326008)(186003)(97736004)(106356001)(3660700001)(3846002)(6116002)(5660300001)(68736007)(2900100001)(8676002)(81166006)(81156014)(3280700002)(2906002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0965;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: +/rDwIYDwRn8FSL85Dd4l3BGb2TOal4dn/MrEdIZ72CD2/mS2B1K0oSSiqRioTZxO6dyR/vousIyY0uj1Nh7MCNpf+ZKLtTmD42SacgBlteleKOYfMJOD71/HaOsJipxYlU7CXvtlvV2/Qh89/fm/Iy87+NF2rvGAmtnicJBEcbUOSn8PrsL/wJABFTDlQugQNv1HMznNYcAOm4i/uIDQeA6X1JpXlWVpMzRH7LBA5b8ZcWPUeBP+oZBgYw4b65tbOu5nScA6cwTgQhhCg2RipPx7RG+J9vo9FTLCG7QnFgwd+GO+s7u2b2dhpmoAjM5WCcmEMl6eUGDQpeWih0rmQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cedf63ed-1aca-496d-908a-08d58db3b85a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:45.3742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0965
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jesper Dangaard Brouer <brouer@redhat.com>

[ Upstream commit 12e8b570e732eaa5eae3a2895ba3fbcf91bde2b4 ]

Masks for extracting part of the Completion Queue Entry (CQE)
field rss_hash_type was swapped, namely CQE_RSS_HTYPE_IP and
CQE_RSS_HTYPE_L4.

The bug resulted in setting skb->l4_hash, even-though the
rss_hash_type indicated that hash was NOT computed over the
L4 (UDP or TCP) part of the packet.

Added comments from the datasheet, to make it more clear what
these masks are selecting.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/linux/mlx5/device.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index a91b67b18a73..5c93f4a89afa 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -635,8 +635,14 @@ enum {
 };
=20
 enum {
-	CQE_RSS_HTYPE_IP	=3D 0x3 << 6,
-	CQE_RSS_HTYPE_L4	=3D 0x3 << 2,
+	CQE_RSS_HTYPE_IP	=3D 0x3 << 2,
+	/* cqe->rss_hash_type[3:2] - IP destination selected for hash
+	 * (00 =3D none,  01 =3D IPv4, 10 =3D IPv6, 11 =3D Reserved)
+	 */
+	CQE_RSS_HTYPE_L4	=3D 0x3 << 6,
+	/* cqe->rss_hash_type[7:6] - L4 destination selected for hash
+	 * (00 =3D none, 01 =3D TCP. 10 =3D UDP, 11 =3D IPSEC.SPI
+	 */
 };
=20
 enum {
--=20
2.14.1
