Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517681650-2-11346682602365832591
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
    t=1517681649; b=C42CIierqf6Xpn2Ncu2SWGn47fLweqFh1/RbTS2ZbVNlD8n
    ztQWqahkrb+l9V2V3zHuBHFI4rZzCtXgjYjd5olJQVQpVBdpPKMlRL6taDWqF9iu
    ZI+92Kwro/zOv1ppRD2KUi5wUdQjQpZVZr1LRlBm3B8MlfP1ph9eVftFvicoNwdE
    yT9gYmUxFExgO9sNAKx3AhlkfhvI2FY/4HNtf9FdkvwoB60ho/3c9LN8CYqgdh8+
    vENDzHmf3rsuwoB13lvSYq05aVBhk7nEuTwUNlI6ZIXYEUqgN0ygeVi++RslhQrF
    FiPQ5Z+5ZEUKSn2r6M8IJL9/uJKY0xYdwtfU2qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681649; bh=IUdrFS
    BU9T/8ws/AvnFOQ0qkQICSpItENrngvKjNdaM=; b=ObjnbLhM9BTX5k4hQ0wE/P
    xTKoMdMzNAy3MSPBDowugRR1fmdt1JKBqQk2ISyt7xvqwPyjQXR5o0LQG8uGOw3y
    KWMMqKZGpvEcVnCwM107Gw/zancx+iOi/romr3+XNh6JSROqWkaRexdbPtFgRTCQ
    oSEc4awz4Qm5W1IXvJVbksUAqn+nV7LWfWMMqLemJ8EgDG8tiPYr92RsEsWMlXR2
    w7J5GH3ZMpBs7QyDkK9D3BiaCclMEMx7MbRkFVMKqxqq60boDEwFQHaZHkJJ3tKM
    oJz6KCaFoZ3M8R/t5MWmzxp70cMrzuhMGgUDTL0y4w9eaOzsHgUSZOBvT3wsXwww
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KJ12csIX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KJ12csIX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753667AbeBCSI0 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:08:26 -0500
Received: from mail-by2nam03on0122.outbound.protection.outlook.com ([104.47.42.122]:54457
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753471AbeBCSGj (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:39 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexander Duyck <alexander.h.duyck@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 41/52] i40e/i40evf: Account for frags split
 over multiple descriptors in check linearize
Thread-Topic: [PATCH AUTOSEL for 4.9 41/52] i40e/i40evf: Account for frags
 split over multiple descriptors in check linearize
Thread-Index: AQHTnRlbUeTRi7vAXUOSSYC9e3FpvQ==
Date: Sat, 3 Feb 2018 18:03:56 +0000
Message-ID: <20180203180303.8490-41-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1012;7:g24JPjc1mE3LVCmiqZjWe1T/L9dZfKJhXr5dwlSPAoj+49foeiU4c8A+sEWdIyIySU1XX0dfbBwuTTNJ1alAMZXCbT8E+/947hd91+hXCmsqk6a4NNVKXLnTv8djmxkl6MReQYtyOX3U4H8I/11T7rLtUAv8mUOQvLv/ctVlkGQlSZdAkH+gFpY+wsk4TkXUeZofHndQEduz1hnSB/cSTm2jVKz2hMR6MMpFoFM52nWQClfUk4Y4E2zTIZFI9i7Q
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2bb8de12-5741-4be6-1f3a-08d56b30a0ca
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1012;
x-ms-traffictypediagnostic: BL0PR2101MB1012:
x-microsoft-antispam-prvs: <BL0PR2101MB101249C1C26D0D5725766067FBF80@BL0PR2101MB1012.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1012;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1012;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(39380400002)(199004)(189003)(316002)(26005)(54906003)(10290500003)(6512007)(2900100001)(106356001)(2950100002)(76176011)(86612001)(86362001)(81166006)(8936002)(6346003)(81156014)(107886003)(102836004)(4326008)(25786009)(110136005)(97736004)(22452003)(59450400001)(6506007)(53936002)(8676002)(5250100002)(6436002)(1076002)(186003)(2501003)(66066001)(6486002)(6116002)(7736002)(36756003)(2906002)(10090500001)(99286004)(72206003)(305945005)(105586002)(3846002)(3660700001)(15650500001)(478600001)(68736007)(14454004)(5660300001)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1012;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: CfFaK9BSm9yuevHsvicGkYqU931vu84yv/nzv6LXSxd9nLgnYkslTquAlr9P5YZVu8/xN8Uf9Qe58Ek4dpwEFg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb8de12-5741-4be6-1f3a-08d56b30a0ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:56.2058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1012
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
index c5430394fac9..28b640fa2e35 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2670,10 +2670,30 @@ bool __i40e_chk_linearize(struct sk_buff *skb)
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
@@ -2681,7 +2701,7 @@ bool __i40e_chk_linearize(struct sk_buff *skb)
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
index c03800d1000a..90ebc5ac16fd 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1872,10 +1872,30 @@ bool __i40evf_chk_linearize(struct sk_buff *skb)
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
@@ -1883,7 +1903,7 @@ bool __i40evf_chk_linearize(struct sk_buff *skb)
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
