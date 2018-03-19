Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521481605-2-16969964264858957985
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521481605; b=EmvG0SToPcOXua1BbNxc/+BLZoMHH8UW1gaQJ58Gidgyxvu
    dVLeFfJYSC6yirZsT5n0XhKI7yxfOQbW468o/A5J0kPoa+NOtCv/pdi+MUwYJE2P
    8llTzDJoCWJKil7x+n7tK0R8x1seUY2abR3RU9TZB30F8gEa+afRUj00VBKvW2+n
    TNu18OqMO6kSQXlP12ZSHbvkTgPuWxzUfoOSxcq+DvBVQ0PHJZ2FdQSo0r9xqdIJ
    5hucUc+XQoZ7UZS+sQD1ZaCvGiaY+otAiFrOXQLkfOR0rYnfFXUMKWuCWdNpOYgL
    EjFUS/+GKQ7PYtq8hI8unbHnB1KcQEPOL6oB2bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481605; bh=qsOsNR
    K/jcTUA6LRsMjDPHSOxNImOmZCjC/7IhRXzTA=; b=btLwnVX6a9mff2M0T59Tlr
    Gi/2E0N97LQmd0g8rB+KWeDZX+7GE0pWuJVCgbRAbhsF8CV1Ydk2o6DOgBijUFQy
    OBvI53df1PrxH89UyN7+tc48FO7UboM29lZeEWT58gWBRI9xw6YM0wOemurzPbW7
    YpMLOCnC3vhVfN+mn/JBQ3RUY302U4nqN0H9U3dz16CMrJ+klfLW47+DCbO/d4QR
    AItUxb7HyieEOlxVuddOpLwcuL7h3vaLigBErElW5pUPe2Zdckbm2otSmKMI17d+
    ucKqABBsYY6Ln+pRkXAps4mvWPD4ntUOZx6eJIU6JJx0xELsC8YXgVhCbUqwpVVQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kLeYeSPu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeelheenucevlhhushhtvghrufhiiigvpeduhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kLeYeSPu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeelheenucevlhhushhtvghrufhiiigvpeduhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968128AbeCSRqX (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:46:23 -0400
Received: from mail-bl2nam02on0126.outbound.protection.outlook.com ([104.47.38.126]:2671
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934863AbeCSQFe (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Fabio Estevam <fabio.estevam@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 243/281] net: fec: Add a
 fec_enet_clear_ethtool_stats() stub for CONFIG_M5272
Thread-Topic: [PATCH AUTOSEL for 4.9 243/281] net: fec: Add a
 fec_enet_clear_ethtool_stats() stub for CONFIG_M5272
Thread-Index: AQHTv5u2yaCI1IX7DEmkRJGToJ35qQ==
Date: Mon, 19 Mar 2018 16:02:42 +0000
Message-ID: <20180319155742.13731-243-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:pa/aZ9/yE473nkbz+7Y4k9qlkCtlYOBbZWB8GFaflpROxl8fAyzXWti5AysXVk7xvYtg76lvCzSlHmjOaiH8r+AgeXTEvMXGQwBvrFLVzloMldlZzTvjGOXzGs7BUu0jnHzp2Uqtd9nB8IUdVM8disUSJ5+V+mp8AoZMndFEIERT/YIc8ZYFAZd4L2UDPfLEOlo1J9SPlYAWSDyoKjiqmGui6VN/0t/okZYmjHsENuNKXOiwY+BDVLopodklOWrB;20:EbB/uviyErfYY+XUjkNEXmZpkxTiKi+nGjFK/N0bJgmSoNcxF599ZdIa1zFRUUlQvxqQT4KcPRrUCDPeTku+W3zqw8DtT3ePOVQpYKNQK8FYVBXuc0jKMCoRBknsLubvH9194e+45dr+blas8JYKXjAxR1wbB7qx1OSCAEZRiwM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0a272659-25bd-434e-ce18-08d58db33b65
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07273AF474D48EFDBD496674FBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(59450400001)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(86362001)(105586002)(6666003)(99286004)(36756003)(478600001)(2501003)(8656006)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(3660700001)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: fUtQO+OND8k9q15NKNBYlCwrur0u1p8tyyzwlvfgq50iSudqJtz3IgaijFrDEVXJXpeRs6/Ax6gBJPqLdwlTnyrQj6RmD0XVS7NFy3/qKcJLIcu7FYT4KHwOZb0SDvclEypdsLjj9Rti2aCBU/VsSALpWvfQX2q1vF6fRamc2j4QbLn3XJFkJyt3QJNXU02ClqrzL/Xc2BK2zWBJNsffFCQddYJQa92cvx0dVTn2UCpCbgfY7Gde87znVZ9loy8bRxU/oi9awLgf9zFgaC3e980SMOwZzmeelJS532LLqzcT7WrhKf5zGEpfTewxRt4UZhqaFibMGv95bHL2JFxs1A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a272659-25bd-434e-ce18-08d58db33b65
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:42.1600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@nxp.com>

[ Upstream commit bf292f1b2c813f1d6ac49b04bd1a9863d8314266 ]

Commit 2b30842b23b9 ("net: fec: Clear and enable MIB counters on imx51")
introduced fec_enet_clear_ethtool_stats(), but missed to add a stub
for the CONFIG_M5272=3Dy case, causing build failure for the
m5272c3_defconfig.

Add the missing empty stub to fix the build failure.

Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethern=
et/freescale/fec_main.c
index 917091871259..f90bb9ac9c19 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2371,6 +2371,10 @@ static int fec_enet_get_sset_count(struct net_device=
 *dev, int sset)
 static inline void fec_enet_update_ethtool_stats(struct net_device *dev)
 {
 }
+
+static inline void fec_enet_clear_ethtool_stats(struct net_device *dev)
+{
+}
 #endif /* !defined(CONFIG_M5272) */
=20
 static int fec_enet_nway_reset(struct net_device *dev)
--=20
2.14.1
