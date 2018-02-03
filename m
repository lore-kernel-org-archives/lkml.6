Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1602359-1517683293-2-7598938506907482041
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
    t=1517683292; b=j63TenlT2aCTqr9Ak27pj6uwL+dDeU92r+rnhzNaX6MrrQo
    jZZopp5DgE8NqsqLOWHNqKbDvHSpZI6a8jutWuylKcEIQhR1ICoahPci9+0uXA43
    EnnY8q8ABUtcyZ3tM5DFyummlwypgK/nRDr85xe8NTkK7KZnlqR5two5dGD68zrj
    /HFobw6KGPwIYBrCew1rXffhfuy5ireeMHr5fu5IxIZLPHFfK4D9v5Vnq8Fj/rUu
    z3pxf31kCxn0J22iAiKOkcZVEo0SWvWgQnsvy8MdAQuSYqjlsxZl24v6YL4cHTEz
    +54rV5xkeYFJpt/byZsTxiynVXbH+dw2qyNKg/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683292; bh=++ooKq
    5+H66fVoIegPKmRiLkgcmqrP0u3ZgishAgLB8=; b=EebIrjNJsxoOBut/IJ8LJI
    1J1H/KYyQWKB47hElTvEPEib/c6IWnG89wLv8kL0Q4ehWEf4f1dtctYsVUcdW1CF
    aGUd4xGFIo5G1nkjFzHpxQfNzWj4/kyGoX/WI26N6kMGkDYpsv0/TVQ1VutTJ7GO
    n9EhtHrZNn84WmbFgq7Y7AvUZfQt5TNG+bqjnkAhw6YCLRvpskHa4VD0C1Js9iPQ
    uBW+yf6EQH/eGVcqkxmIIbcJo3d1vKYO+FZ4yyOsuyQ8rpwo2QkRmZ5vSnKUcHdq
    atRpRhoCL+oDYJY27sSv7gthiHabAV1BVpLERpHEFvN9zYDOWYHTWS6zd3MLl1fg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iVs2p61S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iVs2p61S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754770AbeBCSlR (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:41:17 -0500
Received: from mail-bl2nam02on0127.outbound.protection.outlook.com ([104.47.38.127]:37417
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752919AbeBCSD1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:03:27 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 085/110] i40e: don't remove netdev->dev_addr
 when syncing uc list
Thread-Topic: [PATCH AUTOSEL for 4.14 085/110] i40e: don't remove
 netdev->dev_addr when syncing uc list
Thread-Index: AQHTnRkA8st1UHMnb0mWHyWSJnrCow==
Date: Sat, 3 Feb 2018 18:01:23 +0000
Message-ID: <20180203180015.29073-85-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1041;7:WUo4BdolIgffBAl9CjW8NMLrD4k67QNz8sLKcxP+t70N72auPQnY+unehODgWCT3jj/SWieScBnHQQjWmjPceiQ12jZi5PBfs+llW942qlqjdMaJF05qMU0EGttPK01jwZCQyLkN78M8mqEbr4G5YZR9IkhbKc0fHBCX54gCjHY8oywF1MsYLR5kLvTum/UCHF8ZJcCUU0cKuvxgyOEgtHAGSf28ED9TlYE7397ShFRA8Bp+KkHUzlhDxzAhL1cu
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bce4da15-21f6-4cb2-3623-08d56b304122
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1041;
x-ms-traffictypediagnostic: BL0PR2101MB1041:
x-microsoft-antispam-prvs: <BL0PR2101MB1041B836AA5EECC8A38B4A4BFBF80@BL0PR2101MB1041.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1041;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1041;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(2501003)(305945005)(3660700001)(5250100002)(81156014)(99286004)(81166006)(36756003)(7736002)(10290500003)(106356001)(53936002)(5660300001)(316002)(22452003)(8936002)(54906003)(110136005)(3280700002)(478600001)(72206003)(4326008)(25786009)(107886003)(102836004)(97736004)(76176011)(59450400001)(6666003)(66066001)(6506007)(2950100002)(2900100001)(68736007)(8676002)(6116002)(3846002)(186003)(1076002)(6346003)(105586002)(26005)(10090500001)(2906002)(6512007)(86612001)(14454004)(575784001)(86362001)(6436002)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1041;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: NXBoGNEXTRW1jddxRuFeeMdwfEe96Lia1Bttn/W6H920NlxUiTQtJhRZ/tgngDc2gftj6cvkMqWcqGG1/hEP8Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce4da15-21f6-4cb2-3623-08d56b304122
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:23.3940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1041
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit 458867b2ca0c987445c5d9adccd1642970e1ba07 ]

In some circumstances, such as with bridging, it is possible that the
stack will add a devices own MAC address to its unicast address list.

If, later, the stack deletes this address, then the i40e driver will
receive a request to remove this address.

The driver stores its current MAC address as part of the MAC/VLAN hash
array, since it is convenient and matches exactly how the hardware
expects to be told which traffic to receive.

This causes a problem, since for more devices, the MAC address is stored
separately, and requests to delete a unicast address should not have the
ability to remove the filter for the MAC address.

Fix this by forcing a check on every address sync to ensure we do not
remove the device address.

There is a very narrow possibility of a race between .set_mac and
.set_rx_mode, if we don't change netdev->dev_addr before updating our
internal MAC list in .set_mac. This might be possible if .set_rx_mode is
going to remove MAC "XYZ" from the list, at the same time as .set_mac
changes our dev_addr to MAC "XYZ", we might possibly queue a delete,
then an add in .set_mac, then queue a delete in .set_rx_mode's
dev_uc_sync and then update netdev->dev_addr. We can avoid this by
moving the copy into dev_addr prior to the changes to the MAC filter
list.

A similar race on the other side does not cause problems, as if we're
changing our MAC form A to B, and we race with .set_rx_mode, it could
queue a delete from A, we'd update our address, and allow the delete.
This seems like a race, but in reality we're about to queue a delete of
A anyways, so it would not cause any issues.

A race in the initialization code is unlikely because the netdevice has
not yet been fully initialized and the stack should not be adding or
removing addresses yet.

Note that we don't (yet) need similar code for the VF driver because it
does not make use of __dev_uc_sync and __dev_mc_sync, but instead roles
its own method for handling updates to the MAC/VLAN list, which already
has code to protect against removal of the hardware address.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethe=
rnet/intel/i40e/i40e_main.c
index b2cde9b16d82..b1cde1b051a4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1553,11 +1553,18 @@ static int i40e_set_mac(struct net_device *netdev, =
void *p)
 	else
 		netdev_info(netdev, "set new mac address %pM\n", addr->sa_data);
=20
+	/* Copy the address first, so that we avoid a possible race with
+	 * .set_rx_mode(). If we copy after changing the address in the filter
+	 * list, we might open ourselves to a narrow race window where
+	 * .set_rx_mode could delete our dev_addr filter and prevent traffic
+	 * from passing.
+	 */
+	ether_addr_copy(netdev->dev_addr, addr->sa_data);
+
 	spin_lock_bh(&vsi->mac_filter_hash_lock);
 	i40e_del_mac_filter(vsi, netdev->dev_addr);
 	i40e_add_mac_filter(vsi, addr->sa_data);
 	spin_unlock_bh(&vsi->mac_filter_hash_lock);
-	ether_addr_copy(netdev->dev_addr, addr->sa_data);
 	if (vsi->type =3D=3D I40E_VSI_MAIN) {
 		i40e_status ret;
=20
@@ -1739,6 +1746,14 @@ static int i40e_addr_unsync(struct net_device *netde=
v, const u8 *addr)
 	struct i40e_netdev_priv *np =3D netdev_priv(netdev);
 	struct i40e_vsi *vsi =3D np->vsi;
=20
+	/* Under some circumstances, we might receive a request to delete
+	 * our own device address from our uc list. Because we store the
+	 * device address in the VSI's MAC/VLAN filter list, we need to ignore
+	 * such requests and not delete our device address from this list.
+	 */
+	if (ether_addr_equal(addr, netdev->dev_addr))
+		return 0;
+
 	i40e_del_mac_filter(vsi, addr);
=20
 	return 0;
--=20
2.11.0
