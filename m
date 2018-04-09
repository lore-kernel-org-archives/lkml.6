Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523243534-2-7865645085184156822
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
    1523243530; b=jGBGPBR4xvAYYdHmWYu2Xc5RkSrfpcB6eQjiwmLfJZHyKSfBZZ
    jNlDVbODum6+cnsB3KgfVXjr9KRJfksOrWcCJsCgSbWH2WcRi2DWmnD3BZCHUtSS
    zS7HZRLa8Yt3t6sjXxTRYWvXjpPfaAynbXuuHXa2TYLx50Zq3poe4U+xGnlyRZMc
    biQPn6Op8yV0Ko0BngT/gbNJAZQWVf73eYaa9pHlNpkr3Sjs/G/jT71Egb/kJT40
    5B9vn/MskQKNNof1S4Vn04HKxRmkeAz6Yc++tMDw6r8h2MRwnVBadIvLbr5hI9/m
    wIxSeLjroduCMDLw+CNFfQItd511/e/qt2+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243530; bh=S1Gl8mo3By
    5CAc7C5aQ8/Y5CKpI5g9aSRKp7S6uU5L0=; b=ozFK3eamPeknjgznyaw99EsdaP
    1groZjxOlb0d1WS0JCytHCz6Dl5MOFiXmHf18ku69idyTR/tbFAowsQ7K12NqCOW
    7QqzpHHUVKx8vq9WgTI12IlcQTTEEIx24q3MTFSS65lA3JjyP6HR9aXc62aVDfam
    rg5lpZdlcOtaMeAbNdA5YgQJNWncuVeKUqvYDaEyY7gy+WTiNyQYUWbllS2pzZx1
    F+1IOtSyO/Todb9RqDAMcZHNsFMPraVYqt/cgv4JAP5YDkeky6DE/Jw7Pfq3yxIw
    Q16Eg0BY5NpIH3dQ5IYVeP2HaD2sQeZIyPIm6E6wMKN8rW3hnxZ/yRglDBYA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ieta2MCe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ieta2MCe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHLcqvdhQxMqVVdD7H38WCPJBuI0RK6OcE95Duy+m95jbtDeT1Te15isjbXNmv0YPFwtuROrNv05m97oe31xbZCBNgSlalWANSLP4EAUa5BvN03udX/P
    cjVszSawyOaZ1z7KnPnx6MWvyqWpk13UCKZpi+NvTDEZn99RBDL7oKCwJHX8xubDCFgVLip/+DBBJkvYeKYsll54tn6K8cjh1rd3La+y9pkrvCIzXJEhaA6M
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8
    a=DRua8eYhtxkQQkqHMTUA:9 a=iel8LSwPLIta1nLO:21 a=4dFIdG2ScD7B2G9O:21
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754965AbeDIAXz (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:23:55 -0400
Received: from mail-by2nam03on0115.outbound.protection.outlook.com ([104.47.42.115]:29467
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754916AbeDIAXv (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Corinna Vinschen <vinschen@redhat.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 072/161] igb: Allow to remove
 administratively set MAC on VFs
Thread-Topic: [PATCH AUTOSEL for 4.14 072/161] igb: Allow to remove
 administratively set MAC on VFs
Thread-Index: AQHTz5iZpEykyJyNfUuSfkDg+kmUZQ==
Date: Mon, 9 Apr 2018 00:20:44 +0000
Message-ID: <20180409001936.162706-72-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;7:KwwSP5QZarbNRXF2IrhdYwslkvAYnsR0lp4YFvb32ybrdBaOBildny+WVT02HyWXP4Ab11xWNha0x17Vux6vLtsa+jdLM34eqc5lskkhvfGdnMImfQ4yDc06jYK2ECZcVUE4D8bHU7rbRiLTkbQ/LTZ4IgQw+PXazZi+bF4txdjSspLxIWv3EbMFI1BPpEqYX/uEKDnfdIL2NkA3URU5kBVnrj3yJwAt2BBY5jy4t91ROfo1OaE9uKa3Xl3FbL7p;20:t9zi9XjKGkDhjfJrnzWxEVZmJ3+PrEChxp7Sn3UlfiegndSrgzaTS5bIFF9XlUUYvR4lC0FMoTB7SysDI+xemsm4LZMJjE1G1LxexfLzBH4gt8TycoODcLCHbpu9UXaeiAFj2CFKAoJPDnH48bVTuAKsj8JGYi1NLNiVg7HxkwI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: b73e3f96-9e21-40ac-49c0-08d59db02981
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB108090CFCA41CF830B76A5ACFBBF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39380400002)(366004)(39860400002)(199004)(189003)(2501003)(5250100002)(8936002)(10090500001)(5660300001)(3660700001)(446003)(107886003)(14454004)(36756003)(6436002)(476003)(3280700002)(2616005)(11346002)(4326008)(6666003)(53936002)(6512007)(22452003)(305945005)(10290500003)(316002)(102836004)(2906002)(6116002)(66066001)(6506007)(3846002)(7736002)(486006)(54906003)(110136005)(186003)(72206003)(26005)(1076002)(105586002)(2900100001)(6486002)(97736004)(478600001)(81156014)(81166006)(86612001)(8676002)(106356001)(99286004)(86362001)(76176011)(59450400001)(68736007)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: JmgINEEoWPxIHmWbxTzahkv5E3U8jMA9fNsb1MmpRSX06So3IoFaOyXwBG/2109qG3qX2DIXSA97Ab9jrqRocT4CmScHb7EJIaH63iavjoxfVduko6ucPgMGvMY1y+9GIeeXTfr7Qi3lpXjC3tWZeg3h8MJBcQ7jsoXYNek8LZZf3THYxoEuVj1wUU/dnc1ee5vW5wySEWemPn11o+TtIz8locrW/DjnOjj6YcFF1b7VW5cGWbKT/GHJNQm5nBUAEYzRSbKsbrsBFGHptcHo4hy2v2jBmyHD2ZEcGsdtqKjlfk967o0GkD4LpUENk1kA9ItW8efAQGuMTlwI6JZfMgXuY7QSK1v8BwdDIkwCziXnP00tMEZycuiaqXUzXB6DT2kiuIR7MKBwVBwhjWjK8MdLi4dqmumaVmcdX4Yfmf8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73e3f96-9e21-40ac-49c0-08d59db02981
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:44.8784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
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
index d1a44a84c97e..6ca580cdfd84 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8373,7 +8373,8 @@ static void igb_rar_set_index(struct igb_adapter *ada=
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
@@ -8411,17 +8412,36 @@ static int igb_set_vf_mac(struct igb_adapter *adapt=
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
