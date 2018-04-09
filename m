Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122441-1523246204-2-1697488861441497728
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523246203; b=SmoCWwVFH663pfVuzOUnUa0OxIXKBK+FOOyPFG+Ela1hoeU5at
    rWRbFR4wpadIrAhDldUhGSCZ4TiKL8Kfq3LFGmv1F6UbgEyKST+Vqk6Zy+pxmION
    9WD6562Hq4bgvoK6SgW+afwjwutqCD0UeW1EBx7BEQLN9Mvy6zPDtY+cl19bx54W
    8AhkU7PaG+uID1omuoxwJRCXe9/dyXdcO6RCJs5lbzc1auC8f3LHUPhFcVfpT4eN
    ypfQEAfqjVrm867TIE7/2X84xXZf2CABDlY34EL8+63L57QR1QUpbnd9qqzQTZsy
    ji2iz8RexdbITX0/ZuCcqJX3sxz7BbTIE5MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246203; bh=IvyQm4+lXV
    2qFY9KOOWwhu3BcfIySIk+TC4BZwMQ0vo=; b=nC44E2z8jMf8lmBtuUcosbitOC
    /+enKDFNnXZGKpDyTJfU4itiMXrnknor/v1FE2w/kFcV2fwBThMI1gJp8zfkXAq+
    VHy9HIUSksOKYBCJk7N99RnZfVPCU0TTjDbDY2nxVDH2MOt2l3Z7xb1Qanpornmt
    3IcvjPyQXlgCTH+NxtE2IoukLGIMaVFfS6IJycGbKEr+jblbVTAmeq8fUVRDaKTa
    Q7SN5Ev5NTDuBZ/B9SXlFhZeBf/PyY8wvjbhwAqMJMfN3Lxho6ryG62jcac/FH08
    b91Yhe2Iho38ojNLFOjdqbme2eXnio6FruOo1WZF6VuhsRmgsMc7ukNuG6uA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d5BrOOJO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d5BrOOJO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBsbs0eeJ4QpO8QlcZcgRPgW5oSGnSWu8tZlpgRWPmJaWYUUsdZ8Yoxclwr34uVmXF9pZYcNpcSfpqYD68cabFDwUBdZQgXidjf2Rq+YnIZTN/zUE6M+
    pR9xwN2U1cqA0E7PR/b1b4wSd7tc9q9ztPE7beh34R4TD5RGRr3ajjRiuhM+yEe80rARAtYHUMTGIabLSCG3ReowSkk3X8O4GRE+13cbEPz9r9uttlQCl4jO
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8
    a=DRua8eYhtxkQQkqHMTUA:9 a=iel8LSwPLIta1nLO:21 a=4dFIdG2ScD7B2G9O:21
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbeDID4P (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:56:15 -0400
Received: from mail-bn3nam01on0092.outbound.protection.outlook.com ([104.47.33.92]:62923
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753651AbeDIASt (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Corinna Vinschen <vinschen@redhat.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 086/189] igb: Allow to remove
 administratively set MAC on VFs
Thread-Topic: [PATCH AUTOSEL for 4.15 086/189] igb: Allow to remove
 administratively set MAC on VFs
Thread-Index: AQHTz5gz+Oyql4m4KUyysA6r22OHHA==
Date: Mon, 9 Apr 2018 00:17:53 +0000
Message-ID: <20180409001637.162453-86-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1128;7:uqfyf2e3SMrQckUFfUKsuJSsbqjLhP5D/YQMysB90HY9eOIThKpKRte1oNybubnPmAPIcOQ/Kb33ilzq+wbszBtFMNZu+ui/i84RkglZjVyetH98D8B3B0qUvT/BHglhCT4xo2KSG+zXLd+6ferCHIs0778C8vEYqD+Y/zG5FipstfmRRWpGwSTG6Hh/QyxETZKLv8lbG0z0JivyNiNyo/be4g8yB7oL7mCGwOPLzw9b5YxetP89kAvI3MnAxe5q;20:1DwAs+m85A3QLU0uj3w1gv/iwPGsbSoNYJee95LJIdtmHfrmkmNuvs2awL/2Xm1evELunMiZeDrisvANe38SrdTHuwQff8rTP2cNvOR6/wyulDfDNBPdcWjmEcMXfmDXWupc76w429Qh81lwchqGpkFzUK4jjI9hgr5YuvCqrK0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4a7698f4-495d-4937-0b8e-08d59daf72fc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1128;
x-ms-traffictypediagnostic: DM5PR2101MB1128:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1128CA133A9252D6408668DAFBBF0@DM5PR2101MB1128.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1128;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1128;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(366004)(39380400002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(2900100001)(25786009)(36756003)(6506007)(76176011)(2906002)(6486002)(86612001)(99286004)(102836004)(1076002)(7736002)(97736004)(2616005)(446003)(486006)(11346002)(476003)(26005)(305945005)(6666003)(6512007)(4326008)(107886003)(478600001)(6436002)(5660300001)(10290500003)(5250100002)(22452003)(316002)(105586002)(186003)(8676002)(110136005)(54906003)(72206003)(53936002)(2501003)(68736007)(14454004)(6116002)(8936002)(3846002)(81156014)(10090500001)(106356001)(81166006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1128;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: vYW/smTqAiRYb6gE/03tpa306k4oVzmLzT+L0lEbK8zuPNaY6CwOdvFRGnzhCmVUpbCHWC1h2ifRuCdh6XHBaPdnBKEJtGHYXk9oenHO6s9030T5kDPlLIe9PHXJNoB252WoA/DNfR0jAeaavzcmepWvowj0lo4Jn0HbIt4j7rZg8vApo4sXuVLdON0SpPqRR4kgzOpZ+FUzPBfl66X9jBtq4e3pejQ4RSPw4v6FnUVla/tmqMBNfoUsYPUhhidOr+KaDfLPCrpZ+H7s3pCpm1iW2IsBOwwxWxdoQorScFICzAeKYrfjTIJZ7CS+HpB00XEIzsQl1r3hY+jrYCUC/jTUXRxXCFnplhNCxTl6NEX6QinSSdcKviyc6+74W33H8H70hx5Vh4Z6Jca7Mlhz+/MVVTxgPK/g5E+6tjsRDqg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7698f4-495d-4937-0b8e-08d59daf72fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:53.5699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1128
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Corinna Vinschen <vinschen@redhat.com>

[ Upstream commit 177132df5e45b134c147f419f567a3b56aafaf2b ]

Before libvirt modifies the MAC address and vlan tag for an SRIOV VF
for use by a virtual machine (either using vfio device assignment or
macvtap passthru mode), it saves the current MAC address and vlan tag
so that it can reset them to their original value when the guest is
done.  Libvirt can't leave the VF MAC set to the value used by the
now-defunct guest since it may be started again later using a
different VF, but it certainly shouldn't just pick any random value,
either. So it saves the state of everything prior to using the VF, and
resets it to that.

The igb driver initializes the MAC addresses of all VFs to
00:00:00:00:00:00, and reports that when asked (via an RTM_GETLINK
netlink message, also visible in the list of VFs in the output of "ip
link show"). But when libvirt attempts to restore the MAC address back
to 00:00:00:00:00:00 (using an RTM_SETLINK netlink message) the kernel
responds with "Invalid argument".

Forbidding a reset back to the original value leaves the VF MAC at the
value set for the now-defunct virtual machine. Especially on a system
with NetworkManager enabled, this has very bad consequences, since
NetworkManager forces all interfacess to be IFF_UP all the time - if
the same virtual machine is restarted using a different VF (or even on
a different host), there will be multiple interfaces watching for
traffic with the same MAC address.

To allow libvirt to revert to the original state, we need a way to
remove the administrative set MAC on a VF, to allow normal host
operation again, and to reset/overwrite the VF MAC via VF netdev.

This patch implements the outlined scenario by allowing to set the
VF MAC to 00:00:00:00:00:00 via RTM_SETLINK on the PF.
igb_ndo_set_vf_mac resets the IGB_VF_FLAG_PF_SET_MAC flag to 0,
so it's possible to reset the VF MAC back to the original value via
the VF netdev.

Note: Recent patches to libvirt allow for a workaround if the NIC
isn't capable of resetting the administrative MAC back to all 0, but
in theory the NIC should allow resetting the MAC in the first place.

Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
Tested-by: Aaron Brown <arron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 42 +++++++++++++++++++++++----=
----
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethern=
et/intel/igb/igb_main.c
index c69a5b3ae8c8..13dd7d2d90fe 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8718,7 +8718,8 @@ static void igb_rar_set_index(struct igb_adapter *ada=
pter, u32 index)
=20
 	/* Indicate to hardware the Address is Valid. */
 	if (adapter->mac_table[index].state & IGB_MAC_STATE_IN_USE) {
-		rar_high |=3D E1000_RAH_AV;
+		if (is_valid_ether_addr(addr))
+			rar_high |=3D E1000_RAH_AV;
=20
 		if (hw->mac.type =3D=3D e1000_82575)
 			rar_high |=3D E1000_RAH_POOL_1 *
@@ -8756,17 +8757,36 @@ static int igb_set_vf_mac(struct igb_adapter *adapt=
er,
 static int igb_ndo_set_vf_mac(struct net_device *netdev, int vf, u8 *mac)
 {
 	struct igb_adapter *adapter =3D netdev_priv(netdev);
-	if (!is_valid_ether_addr(mac) || (vf >=3D adapter->vfs_allocated_count))
+
+	if (vf >=3D adapter->vfs_allocated_count)
+		return -EINVAL;
+
+	/* Setting the VF MAC to 0 reverts the IGB_VF_FLAG_PF_SET_MAC
+	 * flag and allows to overwrite the MAC via VF netdev.  This
+	 * is necessary to allow libvirt a way to restore the original
+	 * MAC after unbinding vfio-pci and reloading igbvf after shutting
+	 * down a VM.
+	 */
+	if (is_zero_ether_addr(mac)) {
+		adapter->vf_data[vf].flags &=3D ~IGB_VF_FLAG_PF_SET_MAC;
+		dev_info(&adapter->pdev->dev,
+			 "remove administratively set MAC on VF %d\n",
+			 vf);
+	} else if (is_valid_ether_addr(mac)) {
+		adapter->vf_data[vf].flags |=3D IGB_VF_FLAG_PF_SET_MAC;
+		dev_info(&adapter->pdev->dev, "setting MAC %pM on VF %d\n",
+			 mac, vf);
+		dev_info(&adapter->pdev->dev,
+			 "Reload the VF driver to make this change effective.");
+		/* Generate additional warning if PF is down */
+		if (test_bit(__IGB_DOWN, &adapter->state)) {
+			dev_warn(&adapter->pdev->dev,
+				 "The VF MAC address has been set, but the PF device is not up.\n");
+			dev_warn(&adapter->pdev->dev,
+				 "Bring the PF device up before attempting to use the VF device.\n");
+		}
+	} else {
 		return -EINVAL;
-	adapter->vf_data[vf].flags |=3D IGB_VF_FLAG_PF_SET_MAC;
-	dev_info(&adapter->pdev->dev, "setting MAC %pM on VF %d\n", mac, vf);
-	dev_info(&adapter->pdev->dev,
-		 "Reload the VF driver to make this change effective.");
-	if (test_bit(__IGB_DOWN, &adapter->state)) {
-		dev_warn(&adapter->pdev->dev,
-			 "The VF MAC address has been set, but the PF device is not up.\n");
-		dev_warn(&adapter->pdev->dev,
-			 "Bring the PF device up before attempting to use the VF device.\n");
 	}
 	return igb_set_vf_mac(adapter, vf, mac);
 }
--=20
2.15.1
