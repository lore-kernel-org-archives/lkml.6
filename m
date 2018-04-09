Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122441-1523246134-2-18034118732455308516
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
    1523246133; b=CD+SPIthREQQ/NSAY+4VeWoF0yG9J1iANZIQmSwD/GJ9JHgZYX
    p8vep+nfx/cDmAMO8U9LgKTcd9eBCT1qMMPleWfrz++bYqkjUn371ZoWQreb9kNX
    yPFq5xK+dcFJDtnig7g3Mz1g9j4zrYEJmBIplSIFWicAxheenomvmDDhRK9QXXKn
    SdFxk4DCYt8j7fWnJu1hmza/1Z0GteFH9OYz3f87AIdqtzoq/CbMFoMqAI4DCCZq
    Yo6NZVr8qrn4wcJESwLIAdfAYiyj1qHgCaq766dWl7Qat15bA6IHLQMhTFy1X/7C
    OHGlEHTnqJYK+hJyY5xlCg+BxMaXIwGcK+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246133; bh=2fnMJqFijs
    mEbux3fDPHyXSPu9IXUjOA1dKxW03PaM0=; b=AtWz8bwgUhfEZTIqoevCljsokn
    Z3YBmQkUUg9sw5FcnC+Qh96NBpL9WFI1baB2jyJ/cayZaSXhJsUKHNiEI3SL14Gk
    6W5txtFt7kHH6dSnLiMQsLBogb+vhFGCBEnfAZPWw9vAkS8IBXANyG6onj1nVG6v
    XdPx3/1+6ab+NjWKretk0W8ab0k4tOwMBJpEV5MVpKuoqr2VDq2Gn9W43ZByCUpK
    XYA7LypIPS/5RuNSvd9QjpCYN5J8tBPZ9kvLY/fYJ5AuNr1MyiPFin9Souhri/RC
    eWPomFFFGg/lWyRbaZyqd+37Qe8IiT7as1MNAk49OhKB3cN22hIX1JxqKgaQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hJvi5oCh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hJvi5oCh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK9tuZm0eTJwvyfay2EL4/WaXOMTNFS2NdDFEBnQS9Je8KDriw+Kn4kNl082fk4g+Zg1g9K9ve4vbhmzn5U1fIBmzV15MoZyh1RD5ooXd3RjotbUz7QI
    jJBSvXGXkOa+MsngACUWyAqADI+C4hFwk/WHq5hsrTX22X/r8OiSjjvKl9HRHlSNGfHi49xmnUUp84gbV1h18lS6uUmcZkTcUZyQ11pLef4SVe1ZSLoTZBbE
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=w4Pm3i20ZCRjjx75D1sA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbeDIDzQ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:55:16 -0400
Received: from mail-bn3nam01on0092.outbound.protection.outlook.com ([104.47.33.92]:62923
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753814AbeDIASv (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 088/189] fm10k: fix "failed to kill vid"
 message for VF
Thread-Topic: [PATCH AUTOSEL for 4.15 088/189] fm10k: fix "failed to kill vid"
 message for VF
Thread-Index: AQHTz5g0VrnpesOQ9kay0vnMmJe/rQ==
Date: Mon, 9 Apr 2018 00:17:54 +0000
Message-ID: <20180409001637.162453-88-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1128;7:Xi8WDN2MYKRRfh40puGTvCZeeBwSEkHTKEqLhG8OTzAmX7bvKdFWBsGEITuAvNQ9akSpi5AaJb2T5HSUdg56zbEd+hKX0qEZRvof33fxAMwYqgZATZHEvlYW6sVL8VivCKOzbbT9LjVwLXwKn3w3gxgCDfxm27RpM8jjef7kBE9cKii9OpdcMPxdkp5t+mxfeNlFtGnhoVQ6USThQoCmfEBU2uoZxbpvFFjFKVLoG2065ibd+MVOQjv+2JE9iHHH;20:7tJlnP3ar3oAMfXHtlabRkVHJlvFzz2nXVyqztVQM1Y/fy6YdTJsmAB5yMwsL76RzyKbosSDR9Hfbt4hHk3DLB0JYTJ5Cz0JwwsoTXeeTim/JafxTU7F91ITcnCtEvbGR+IJDija7Ie8Mo26VGpjeimJxsbkkr8EMgWjsRBpe20=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 380a5e90-166c-482e-c8e4-08d59daf737c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1128;
x-ms-traffictypediagnostic: DM5PR2101MB1128:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11282A8A8ED7156641BEEFC4FBBF0@DM5PR2101MB1128.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1128;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1128;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(366004)(39380400002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(2900100001)(25786009)(36756003)(6506007)(76176011)(2906002)(6486002)(86612001)(99286004)(102836004)(1076002)(7736002)(97736004)(2616005)(446003)(486006)(11346002)(476003)(26005)(305945005)(6666003)(6512007)(4326008)(107886003)(478600001)(6436002)(5660300001)(10290500003)(5250100002)(22452003)(15650500001)(316002)(105586002)(186003)(8676002)(110136005)(54906003)(72206003)(53936002)(2501003)(68736007)(14454004)(6116002)(8936002)(3846002)(81156014)(10090500001)(106356001)(81166006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1128;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: FpZ3Kn+i5ELVJ08U9HquVdqdtPxfzr1Rd6BmR9e7xwPPoJYH/ydpcy5WdzReFhNBNuEKG48n/JT1uQbMzOD+6NbJ00HIByWc2DZA/rAWJDjiHPH+zSEs8ofbow0hR1EJGZGOxPU6tpoySZIN6Ri/C6YcCym6rBeWjO6hQaoKwcRn2t7COxJMUX4Ysi1g2uvsBafdxtbIqWgsjkEq5zGoXDTeBBi/2bi9jTT7qwjQ9xc5BVDs3XTHfXJrbvOvhPAlurYmtIU4u+LOstOTL7JzeYxCEFrdPnQu5XJ5SMw1A/Tqge6tsncdtOVPNvkr9mNpBBKyAVOPiYoQptPl5xRRKNipEgQOXUFY205BmPNjUoSSKn7caHOm9g01gZIobxIto5O72LsPQQbvKxlvhDpr9Xpuy2xdiZSjejcvTtMSEOo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 380a5e90-166c-482e-c8e4-08d59daf737c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:54.9917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1128
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>

[ Upstream commit cf315ea596ec26d7aa542a9ce354990875a920c0 ]

When a VF is under PF VLAN assignment:

ip link set <pf> vf <#> vlan <vid>

This will remove all previous entries in the VLAN table including those
generated by VLAN interfaces created on the VF. The issue arises when
the VF is under PF VLAN assignment and one or more of these VLAN
interfaces of the VF are deleted. When deleting these VLAN interfaces,
the following message will be generated in "dmesg":

failed to kill vid 0081/<vid> for device <vf>

This is due to the fact that "ndo_vlan_rx_kill_vid" exits with an error.
The handler for this ndo is "fm10k_update_vid". Any calls to this
function while under PF VLAN management will exit prematurely and, thus,
it will generate the failure message.

Additionally, since "fm10k_update_vid" exits prematurely, none of the
VLAN update is performed. So, even though the actual VLAN interfaces of
the VF will be deleted, the active_vlans bitmask is not cleared. When
the VF is no longer under PF VLAN assignment, the driver mistakenly
restores the previous entries of the VLAN table based on an
unsynchronized list of active VLANs.

The solution to this issue involves checking the VLAN update action type
before exiting "fm10k_update_vid". If the VLAN update action type is to
"add", this action will not be permitted while the VF is under PF VLAN
assignment and the VLAN update is abandoned like before.

However, if the VLAN update action type is to "kill", then we need to
also clear the active_vlans bitmask. However, we don't need to actually
queue any messages to the PF, because the MAC and VLAN tables have
already been cleared, and the PF would silently ignore these requests
anyways.

Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/=
ethernet/intel/fm10k/fm10k_netdev.c
index adc62fb38c49..61d062836402 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -934,8 +934,12 @@ static int fm10k_update_vid(struct net_device *netdev,=
 u16 vid, bool set)
 	if (vid >=3D VLAN_N_VID)
 		return -EINVAL;
=20
-	/* Verify we have permission to add VLANs */
-	if (hw->mac.vlan_override)
+	/* Verify that we have permission to add VLANs. If this is a request
+	 * to remove a VLAN, we still want to allow the user to remove the
+	 * VLAN device. In that case, we need to clear the bit in the
+	 * active_vlans bitmask.
+	 */
+	if (set && hw->mac.vlan_override)
 		return -EACCES;
=20
 	/* update active_vlans bitmask */
@@ -954,6 +958,12 @@ static int fm10k_update_vid(struct net_device *netdev,=
 u16 vid, bool set)
 			rx_ring->vid &=3D ~FM10K_VLAN_CLEAR;
 	}
=20
+	/* If our VLAN has been overridden, there is no reason to send VLAN
+	 * removal requests as they will be silently ignored.
+	 */
+	if (hw->mac.vlan_override)
+		return 0;
+
 	/* Do not remove default VLAN ID related entries from VLAN and MAC
 	 * tables
 	 */
--=20
2.15.1
