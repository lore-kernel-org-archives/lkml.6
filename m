Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238756-2-11292003147807227175
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
    1523238755; b=NRFmcTr+LAApJyobIfVABRtUOc6/Dq5Ry7crt99hSfg2LZIxnZ
    2fKIixMiYnT7YYoO+zQx2YY0ryyj/smHPZyPj30it9z0hSWQtqB+285II9a6x7GJ
    n0u43dX0QkLoCSpF6sQShNBTX5jy3KGAq+v1OrQHj5H2TVdcPeJkLiqnfmfGm28p
    JzuM3dJC7TVX2qTcs02M4uR1mgnXtRLPzAaphV++7+xf2REx/w3qlf2EHLMX3Rvh
    HZj5736h2BUhxz1VR/CNsP7Av7jFnNX/TLMwjN4S2ajxgACxsIzFBc+yUuvGIS+g
    +s2derTWksVTTki5CUJ72U6CEx4W0bmm7+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238755; bh=IDuKw+fUq7
    86Q+EN7wUpMuRFE8IOyiVW4Nbm8HqZDxg=; b=Sna+s1pEiOAc6SvTbRSt6IRObv
    89Z0U0RV/NnvChboGJW8C3B/ueI1R+u+iXEkxAoaMhG+MRaBNSZiHj00PTTUls5S
    MsxGG/n9q8mV0ZjAF1jAAkeQ/GS2dlg3kG5c8+LEmI2Cp3vCrxZcW1QXSN1luPgF
    U00Fsa49drSckAV8CtDJtl/RMUF7hf+XGvVIQeEHpqiVq+3E5yTnOkl/E509odH5
    C9rlstExvEDaxwmZ/LQXiRcXrRIanI9YGbmaZiPsZaHNTRN+7KT+5vQweuU6UTBo
    0uto+P0p0AUQzOcdVBRP1DjeH31VHGrv6Odb4P6+XVzUrxorubR3JaGlDHTQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jZAlHYGu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jZAlHYGu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN66GwsDwjAqX6XnkNNNQVOWyUZ5FWLfeJcvSO0oShg6DAp3lQcm+uiDzKMu6fiYZ8CRxzQ1mP/MWhZTkU3a3ZPow8SC4xG6MTTcMIcTI4vu7E3qLyNJ
    rxlPTkB+thXiW2dXoN6b4CbhwdDhCCTRUiHTGlzDl1NKEmJuB5PpdAZZ6MQShGLAJ7G34PFSi98yuuLwZa/XArpHLDpyWkxpgYrE4ztABaJJawcZ6P4okhyv
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=w4Pm3i20ZCRjjx75D1sA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932287AbeDIBwa (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:52:30 -0400
Received: from mail-by2nam01on0111.outbound.protection.outlook.com ([104.47.34.111]:45024
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932233AbeDIAdo (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:33:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 244/293] fm10k: fix "failed to kill vid"
 message for VF
Thread-Topic: [PATCH AUTOSEL for 4.9 244/293] fm10k: fix "failed to kill vid"
 message for VF
Thread-Index: AQHTz5lX3vPQKL4R7Ue0IZIWSLe8xQ==
Date: Mon, 9 Apr 2018 00:26:03 +0000
Message-ID: <20180409002239.163177-244-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:xDbYhV8bGhzSIFYVLNAzVshN2NQ9crT2y3czOWJan/CuCNj6DWt87ZMSP2EBOftVbWDNpTsTNxzgHmAb9ufOzpurjsmmPaxxv/IWzdSDF+E164lCml+d+fU5WB7x015EueiwkZ3p+AJKngG3yV9vKInnKqEoFNCuCptZvHUx+BtL85vrlU/ySSEBu8Aldn6nDpuNjEaU0g7PeWwhGbmkw/qRN9Xt6tfI1rLAJQ1aVxFU2z4tqmome0x2ptUJGMl6;20:TvKtNeHgZFgO8zmFZrVRI7rFGn71Vy7uQ8F1Ct4ObgCIh7sxAnUZR2x+al1PNwTAXmoN7/Te9Hqh+Aw1CjW1D7SkitDdwhnVNiDI2d46oF1yQPHDOu455isgEWHwNJFwbduBsmUQza/5q+gI0K8sQQ32Piwn9ZdzBEbdLqXpWJs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a574429a-bc2b-4b9c-f13f-08d59db18c1c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0998C1BB383D89C657CC8CA7FBBF0@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(376002)(396003)(366004)(39860400002)(189003)(199004)(25786009)(59450400001)(105586002)(14454004)(76176011)(68736007)(2906002)(316002)(97736004)(8676002)(86612001)(3660700001)(3280700002)(102836004)(6116002)(4326008)(8936002)(36756003)(22452003)(81166006)(81156014)(54906003)(6506007)(10090500001)(2501003)(6512007)(186003)(6666003)(3846002)(486006)(5660300001)(15650500001)(26005)(7736002)(5250100002)(305945005)(99286004)(2900100001)(110136005)(1076002)(6436002)(53936002)(106356001)(107886003)(72206003)(86362001)(476003)(446003)(66066001)(11346002)(478600001)(10290500003)(2616005)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: SHNZQaHs3DRViq3rvrHs2FQd9mXsDm0vgTB/KdbEZ61k1dVTAjy1vbh6CnL/QO4G2oPuUAhUSYcXAakUZX8T8Wu0RFq2qMBXdx1Accsv1i2szfdtTfZUEAAP6XOKpnY58l3n/LHcXMZ31vCH5pSopNRUEy+eYDU4RFktalnJuNuwgYZIxN87TSZM3ZzRKkjB02a19H3wKqPRA2stFnj94aLa6QFy1j9I8BzYvxVinvywWZIrc9xu5Z9WShcS9YOpdf94VlcsRgMSgKDELXXMUogzrRTWE0AlpRIDh89dr2HhwJoEa/QLQT4VEKUrRl/Y+QLfJ/BRtrEiv38q93tQSZpchsq8p58JomMwuxTGaEgyVAZocGDS77wBsGjRoIn2wNPCbDhH3taqSKX1Qc2+C6/JXrcry8USeHu9JDlYLyU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a574429a-bc2b-4b9c-f13f-08d59db18c1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:03.4568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
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
index 05629381be6b..ea5ea653e1db 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -803,8 +803,12 @@ static int fm10k_update_vid(struct net_device *netdev,=
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
@@ -823,6 +827,12 @@ static int fm10k_update_vid(struct net_device *netdev,=
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
