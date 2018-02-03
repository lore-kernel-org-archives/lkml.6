Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517683292-2-9170594282581895143
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
    t=1517683291; b=eESo7nUP0iXDKk2gaV78NiPnUhoeOCVzPiX8hAspL780zUp
    HktHJh9G71vj8QsD2Gupi+qHkaSpBu5+/mQyBipLYnTyI9esE4k6b1KCQIbuiIAL
    tbz5YJXwCYugm+0Hga3nSyrPQVX4A1LZ17NkzQD++uLnT2H8SK7jbpkxYg18NMNH
    /iRmD/J2+HS/ZiBOr9lHdfo83B1rKn6jpevTXEWVE8uNKw+lYNVPXrNq2P3PdqmJ
    NxtaP5UHFf3nvRqjcip+yeeTyziv9LRFcUW6YtJmqeHYUwUwQ0kOVn/PsMMxvJWY
    SplyyKst2dSQA2DBXIW57ZJKcMKUhamvzSIcI7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683291; bh=ul8xie
    pjwgf4rkzQw9AHFHJHT2m2LPOch4iiBz6ABXk=; b=KhcSGl3I3WJUZUBlS+ESnm
    ravGFWOz8SnH2Cc/gobZwFS92iLhiNeQhSnQQZXbjor1yS2hRWacrOJ+Mylv6wCa
    nSt6/06ZrQR5K+7PmPmChjtzScUi0OxA9Qp6l0KAIaxZNlB3PBfsb8WSiywXWY7O
    GQOX+D0td+mO0MBEskJHd3svRWrK0RGObAw3emj+pZSDK7T/9tfV19Lh3Jy9TONc
    VrMjMIajbUBzCqFT/HwWnFzzmS5cbCyuS57KYOVpCAhG62gtaEcznYsXmtda2xHT
    693zJZ3xAxHKptSJStSyofh8mRNtSxxYZ0d5FPQrcj4alZ8JrAoO1TouchI68OBA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jFja/i/j x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jFja/i/j x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754694AbeBCSl2 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:41:28 -0500
Received: from mail-bl2nam02on0115.outbound.protection.outlook.com ([104.47.38.115]:21822
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753223AbeBCSDT (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:03:19 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexander Duyck <alexander.h.duyck@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 084/110] i40e/i40evf: Account for frags split
 over multiple descriptors in check linearize
Thread-Topic: [PATCH AUTOSEL for 4.14 084/110] i40e/i40evf: Account for frags
 split over multiple descriptors in check linearize
Thread-Index: AQHTnRkA6uAFkaYaiUetXFWwMPLX2g==
Date: Sat, 3 Feb 2018 18:01:22 +0000
Message-ID: <20180203180015.29073-84-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1041;6:9nME+7loLrD1uUk+It4GioLG40yh6MAA2AOlzfnTrpOP2k152QCjB3uRImiAxw0yihbPa7ZnjGU+WhzFKjT/QxH8JrDevXIJfyUIgN/gdZPsi+poSd1amsBWKWKKLkI1P57FJNeqb6XGzCkEesq9CyrBq52WQpIBYkqZtvRkJllS+kzLb2LtWD5WP7dE8dMUQh1Xs62vBEJRDNfjbhMG1+VNZwbhnDpfIikXL6bPNv4GX60tbFq4qiAUX9Ny7mNrKuv8IckSkIJc8AL0wClRLXDf5eK5dXA/aUZoks1SNabfbDHot/gz7m/WcPx/qwcc0LcnVeL8P7ReRewMkVnF0h7gcs2YFYTdf5uST3IL26nwMyvXDsevuFCTE3K0kJYJ;5:qLaihyuFsQAgg1IJISTQjOU40xBhoQhEOpBK01Zpou21cbUTgnwWqF/VxmHNE8rPZe38IQ1E5fz91Z8U8tDRd5Q2w4OxOJuUj1LC4/60hgB3wdiaZZzwl8WdXFKWV0D4ggie+XRf2TrGMxcADIEwP/Q4YwtRp/MjcC7xUWsM5io=;24:Rsz/OHnlcOxx24vAuK/N/eQaNyktw6anGpd/EEdGUIfz9ua9ydSKx1NY9vADKji7hMhosYVz5TUoUlix9GyTPFjZqAj1I7Df5A4jaAI8DGs=;7:LtwekPcfoTWPw0fcRDWiw3KBMbJwoHYp61LoQXF/QIHgfX0DnxkzZK4RHpcsVsQHa9+70lEWBAIbKIuD9Peegu7XsNQTnVk+eXOA5hmnJPq+I2TpG4pVxWP3lnNsDvQXOd3VuOy7X6AwtjAWpx3RY7pWTaFIjlSn5Qa8n8BRCakeQEb8Pl/qOS1uWIrVDnH+jGYPDD3+QoAwUvzzpuZw63mdGuAFBqNdu33oQm27WnhqKH2nEZ7c51ET9lXYVAbp
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 12a7fc9a-218a-4c1d-3913-08d56b3040e4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1041;
x-ms-traffictypediagnostic: BL0PR2101MB1041:
x-microsoft-antispam-prvs: <BL0PR2101MB1041EFA75ABB226B2CCA0589FBF80@BL0PR2101MB1041.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1041;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1041;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(2501003)(305945005)(3660700001)(15650500001)(5250100002)(81156014)(99286004)(81166006)(36756003)(7736002)(10290500003)(106356001)(53936002)(5660300001)(316002)(22452003)(8936002)(54906003)(110136005)(3280700002)(478600001)(72206003)(4326008)(25786009)(107886003)(102836004)(97736004)(76176011)(59450400001)(6666003)(66066001)(6506007)(2950100002)(2900100001)(68736007)(8676002)(6116002)(3846002)(186003)(1076002)(6346003)(105586002)(26005)(10090500001)(2906002)(6512007)(86612001)(14454004)(575784001)(86362001)(6436002)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1041;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: UEPQOszPIwZZsUt/mYXnuzfJcGW/GpRHWrqVYfWZOKIqh8BveEUsGvno1SHBb8MSCxkMq2x0tn/vibGXtcTBjA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a7fc9a-218a-4c1d-3913-08d56b3040e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:22.9565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1041
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

[ Upstream commit 248de22e638f10bd5bfc7624a357f940f66ba137 ]

The original code for __i40e_chk_linearize didn't take into account the
fact that if a fragment is 16K in size or larger it has to be split over 2
descriptors and the smaller of those 2 descriptors will be on the trailing
edge of the transmit. As a result we can get into situations where we didn'=
t
catch requests that could result in a Tx hang.

This patch takes care of that by subtracting the length of all but the
trailing edge of the stale fragment before we test for sum. By doing this
we can guarantee that we have all cases covered, including the case of a
fragment that spans multiple descriptors. We don't need to worry about
checking the inner portions of this since 12K is the maximum aligned DMA
size and that is larger than any MSS will ever be since the MTU limit for
jumbos is something on the order of 9K.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 26 +++++++++++++++++++++++=
---
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 26 +++++++++++++++++++++++=
---
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethe=
rnet/intel/i40e/i40e_txrx.c
index 3c07ff171ddc..542c00b1c823 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -3048,10 +3048,30 @@ bool __i40e_chk_linearize(struct sk_buff *skb)
 	/* Walk through fragments adding latest fragment, testing it, and
 	 * then removing stale fragments from the sum.
 	 */
-	stale =3D &skb_shinfo(skb)->frags[0];
-	for (;;) {
+	for (stale =3D &skb_shinfo(skb)->frags[0];; stale++) {
+		int stale_size =3D skb_frag_size(stale);
+
 		sum +=3D skb_frag_size(frag++);
=20
+		/* The stale fragment may present us with a smaller
+		 * descriptor than the actual fragment size. To account
+		 * for that we need to remove all the data on the front and
+		 * figure out what the remainder would be in the last
+		 * descriptor associated with the fragment.
+		 */
+		if (stale_size > I40E_MAX_DATA_PER_TXD) {
+			int align_pad =3D -(stale->page_offset) &
+					(I40E_MAX_READ_REQ_SIZE - 1);
+
+			sum -=3D align_pad;
+			stale_size -=3D align_pad;
+
+			do {
+				sum -=3D I40E_MAX_DATA_PER_TXD_ALIGNED;
+				stale_size -=3D I40E_MAX_DATA_PER_TXD_ALIGNED;
+			} while (stale_size > I40E_MAX_DATA_PER_TXD);
+		}
+
 		/* if sum is negative we failed to make sufficient progress */
 		if (sum < 0)
 			return true;
@@ -3059,7 +3079,7 @@ bool __i40e_chk_linearize(struct sk_buff *skb)
 		if (!nr_frags--)
 			break;
=20
-		sum -=3D skb_frag_size(stale++);
+		sum -=3D stale_size;
 	}
=20
 	return false;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/et=
hernet/intel/i40evf/i40e_txrx.c
index 07a4e6e13925..7368b0dc3af8 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -2014,10 +2014,30 @@ bool __i40evf_chk_linearize(struct sk_buff *skb)
 	/* Walk through fragments adding latest fragment, testing it, and
 	 * then removing stale fragments from the sum.
 	 */
-	stale =3D &skb_shinfo(skb)->frags[0];
-	for (;;) {
+	for (stale =3D &skb_shinfo(skb)->frags[0];; stale++) {
+		int stale_size =3D skb_frag_size(stale);
+
 		sum +=3D skb_frag_size(frag++);
=20
+		/* The stale fragment may present us with a smaller
+		 * descriptor than the actual fragment size. To account
+		 * for that we need to remove all the data on the front and
+		 * figure out what the remainder would be in the last
+		 * descriptor associated with the fragment.
+		 */
+		if (stale_size > I40E_MAX_DATA_PER_TXD) {
+			int align_pad =3D -(stale->page_offset) &
+					(I40E_MAX_READ_REQ_SIZE - 1);
+
+			sum -=3D align_pad;
+			stale_size -=3D align_pad;
+
+			do {
+				sum -=3D I40E_MAX_DATA_PER_TXD_ALIGNED;
+				stale_size -=3D I40E_MAX_DATA_PER_TXD_ALIGNED;
+			} while (stale_size > I40E_MAX_DATA_PER_TXD);
+		}
+
 		/* if sum is negative we failed to make sufficient progress */
 		if (sum < 0)
 			return true;
@@ -2025,7 +2045,7 @@ bool __i40evf_chk_linearize(struct sk_buff *skb)
 		if (!nr_frags--)
 			break;
=20
-		sum -=3D skb_frag_size(stale++);
+		sum -=3D stale_size;
 	}
=20
 	return false;
--=20
2.11.0
