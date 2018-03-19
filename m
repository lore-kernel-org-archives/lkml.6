Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3444635-1521482825-2-6456456047643221035
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
    t=1521482824; b=a6T1AHYDNo5hUIf6PrDdMPqnrxqGwAyTw+zokEk5jJROn7e
    QW6MVqzUl8eLh1s0nnpQgNx4slmRnNnbTd4VUFVg2I+zMCpBM8UYx3D1lx7Sroyp
    i8r58GFyNYgwEkrhmyV5SciL5LHgAzLDAJ0KvZ0EIM2rYf5tz6OynzcdH9GLKJZ0
    fWnocl3+IJDhfuOIAmVVfgTm9hK5ZDufltc7JkD16Huf82qeqENOUTmLhWxbrjkl
    AImQ5lVCtKB89kAKegybSu6qnrJN7XFsPF19kiONGZtRoxlxx32Dn/Wv8nhzwpfw
    OD/d/C0MurSg0EbFPfNDxXzxg8y+hBJHqPvvjmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482824; bh=Z/ooAt
    cqnlUADXQ0ViwZIO1IA0G5ZdfpoQYYD+/aHAM=; b=YCjZqgfGfYWL0OdVSOTC38
    rAJdGArBndE+FSmRUZinxTeENL/vUiO3Na0oArttFDBBx/2tw94x1E1IrQwLAKOa
    fSSIWzA4oyj8EtskkI7LuLCEglzGaw4uKr7ZlTwLGZugsj9G6bnIwSD7L6pVxBIp
    6P5jCJmCt+rYnnv45kQbjDlsKyFjoDvdzg1WfKBu5kyNDyLN4Sx295stCujVpHB8
    cPj5uMPdZLIAuRGZGvvMHJkoKB+DFe1AeJFvD3ICjDPRg6xtTzfQsZcBNoiBQpRc
    QlVodtNWT+XPgmCru9opMTxyYrLpJM31tM3EVffMDD2qgBsyrxLJafzUtrOArVTg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DkWlg3uF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeegkeenucevlhhushhtvghrufhiiigvpeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DkWlg3uF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeegkeenucevlhhushhtvghrufhiiigvpeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935019AbeCSQD0 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:03:26 -0400
Received: from mail-cys01nam02on0139.outbound.protection.outlook.com ([104.47.37.139]:43744
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965570AbeCSQDS (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:03:18 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 174/281] mtd: nand: gpmi: Fix gpmi_nand_init()
 error path
Thread-Topic: [PATCH AUTOSEL for 4.9 174/281] mtd: nand: gpmi: Fix
 gpmi_nand_init() error path
Thread-Index: AQHTv5uEeRdyUND5s0KTO3nG4dVOPQ==
Date: Mon, 19 Mar 2018 16:01:19 +0000
Message-ID: <20180319155742.13731-174-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:yJspRFz00FRmbNSdCUTpmMscHLIl/GgEI14wXAEDSuLxYvW9ppTI/Fn+TlIx9/7Fd4qBmuOCOxXf5gJoZw9qAKmxRGIb4oh+JjW/WvE8lEDBqzfe2DT7cToI2+K0Z9RIGc7i/fGfscjIXCuWuURdS/oB+nLje0QpYv2gcoe7pyQ254T5ec/ZGKV3B42D0ImwqBRJot0kpyjEqDB3xAoV/XTljqWok+3sV7o6K26ZH3Korb+oYvGtXXpvvLZdWUSt;20:XcVbRR35BlfQSVpOnquxFKkUuhIB+hTIPm6fQEr4/bc7wSIESvN6MYT3/kn0ljxQ1L5yLwcgO9K7f5YqRctxjtOOVb5r82gzU5JSpBuQTzaBTe4KpKiT9X/WJ7nyKl/Cy2EvwpOe3zvd5SkxPNj6AO30IJa7WIzKDq4+ZCkPrU8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4a97d179-98e1-4a86-c66d-08d58db2eb1a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07258478735DDFF518B2C06EFBD40@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197)(85827821059158)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(366004)(39380400002)(199004)(189003)(2900100001)(4326008)(54906003)(10090500001)(81166006)(316002)(2906002)(14454004)(110136005)(107886003)(6506007)(186003)(81156014)(22452003)(68736007)(53936002)(3660700001)(478600001)(5250100002)(2501003)(99286004)(36756003)(105586002)(6116002)(3846002)(5660300001)(72206003)(1076002)(2950100002)(305945005)(6436002)(86612001)(66066001)(10290500003)(76176011)(97736004)(8676002)(7736002)(8936002)(6512007)(102836004)(106356001)(3280700002)(6486002)(86362001)(25786009)(26005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: +5/o+CfxWgWj7VMztqLeC1mBPqsMxATGyWHUwLciuaJAXZ4hoqQi0pAKC7hTL25S6lRc8Y3Q5qxOuokC41LpySEII+Ye98QJBWIILfDFNrWM2LzE1z9T4UO8m3PoSi3UbBBnGI4DuLLDR+GDoQ8eNBiK02phQ44Jk+fc4vOAAwNQe5pndV5xR8/ECoxn1e+4FawNprF05OyfDDQRdB56KuaZCA+exWDfiTCPt6jI8mRZAbkLnm+mgEIf2TtMO4mJL8Cy+SEa+jJoGEucy/5hPynzvS+zfA7Aq/j9nrE3bMf/e/OAA47NTeSFoxFMzUsPXS5oFJYCVFYdQ9W4WERYVA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a97d179-98e1-4a86-c66d-08d58db2eb1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:19.2235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Boris Brezillon <boris.brezillon@free-electrons.com>

[ Upstream commit 4d02423e9afe6c46142ce98bbcaf5167316dbfbf ]

The GPMI driver is wrongly assuming that nand_release() can safely be
called on an uninitialized/unregistered NAND device.

Add a new err_nand_cleanup label in the error path and only execute if
nand_scan_tail() succeeded.

Note that we now call nand_cleanup() instead of nand_release()
(nand_release() is actually grouping the mtd_device_unregister() and
nand_cleanup() in one call) because there's no point in trying to
unregister a device that has never been registered.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
Acked-by: Han Xu <han.xu@nxp.com>
Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi=
-nand/gpmi-nand.c
index 427039b77668..d9dab4275859 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -2047,18 +2047,20 @@ static int gpmi_nand_init(struct gpmi_nand_data *th=
is)
=20
 	ret =3D nand_boot_init(this);
 	if (ret)
-		goto err_out;
+		goto err_nand_cleanup;
 	ret =3D chip->scan_bbt(mtd);
 	if (ret)
-		goto err_out;
+		goto err_nand_cleanup;
=20
 	ret =3D mtd_device_register(mtd, NULL, 0);
 	if (ret)
-		goto err_out;
+		goto err_nand_cleanup;
 	return 0;
=20
+err_nand_cleanup:
+	nand_cleanup(chip);
 err_out:
-	gpmi_nand_exit(this);
+	gpmi_free_dma_buffer(this);
 	return ret;
 }
=20
--=20
2.14.1
