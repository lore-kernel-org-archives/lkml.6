Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523243578-2-13516797318920670665
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
    1523243578; b=pHZXfvwxRu4Ypn4TcQC0xkmU8o7K9xZHv9Zywgj1uMQc4OMuGf
    Rr9VToTbkhDjcvmNasCpwdTDNQx8Z3+af8PgTHBLhuQm7z0xtu9CC+aQy/doHZWG
    yYWE9nw8u1SI8hUuX+KwJ7kzCqrpxH3qxlpSJ9UBVZfmJph3eT65SKm4g9d8HPcG
    uIGnair++F6BEwpmDLLP8EGwbRizeiDwjWvchbWgKkJV1Ma84HKUOXEvSHCpchbs
    UW3yCvVLhtSfWr/LSABCrNxqMO9dHc+gHvakFv0CVGFxCTzblUrTy8Dh2034wIEt
    7OT4ik9C11jGqO39/MvwZ/HzoeWBbaFkm76A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243578; bh=aDSAjr4NB5
    fl3HqrNDicVW4rPx+2x0J6HOwV6lrUBlI=; b=ExiUZ7Tlces2ZT50Q6ie/XJWFg
    xVoh47l0sGJLtzHAWyVxZRdTwA7kDpsOatosZ4/dBJ+BS7rPwC8YgaJP6OQtjiIT
    4EYM5i1Mi5b4X7pZFvcm/qMyIsADozVhqxHgiO7tesZw6Li7pHuKb0ezZbruBjYJ
    sSMsPt0fTw8yFR+tRcOHdbdJCoiUPLRIx/g4CgJYWocTXpt1wGK6LWO6VUcEgLyN
    mtaapyBVsP8BoIwp0dEKioYcgvI8cPZu/tMLwtIGdKu49u5zLYSsamALRkfFcuGw
    IKwP8anY3Fiz632Dtm73W1Qs13lO8eQYoEcJDK/XibK8qvvnFp4BomNfk4AA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SwQm569F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SwQm569F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMuI59sNm+pOxWmDv3zbRVOCVhl9492s39VxDMX76BI4PseV4ZCPY1CwsPRarc0LoB2s6pkZMSsMT2Y+PJuwX1EmlprIo9pKw5g3tqTj3CFjYonZaqEk
    bPV4uNk3kSHEubMravK6ZVXaJ+dFSUZhesM8Hk/0lrNNP8s8Vz2/RHh6c8cM+HDxyTnPgno4lRoesARVu7i0e0k57BFlf36uQXV2dT9R6k0kRjEXW4x4dQj7
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=w4Pm3i20ZCRjjx75D1sA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755112AbeDIDMy (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:12:54 -0400
Received: from mail-by2nam03on0115.outbound.protection.outlook.com ([104.47.42.115]:29467
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754962AbeDIAXy (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 074/161] fm10k: fix "failed to kill vid"
 message for VF
Thread-Topic: [PATCH AUTOSEL for 4.14 074/161] fm10k: fix "failed to kill vid"
 message for VF
Thread-Index: AQHTz5iaug310ASGP0aShbTsOZWL6w==
Date: Mon, 9 Apr 2018 00:20:46 +0000
Message-ID: <20180409001936.162706-74-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;7:p+HONh3sKrJ5+bFVeREjyn7rWKZHD62vZE1of1HnKD6DZGs0Wv0EEald4013ZB+bhXwZ4ITAgsLqklQ9bCUaESphcxkcB32MS5mdjXPgZKrXOovYnwTzemQ4SDkg7u2FcdRUyKbSr3uSHtTG+o+qqV7ItEvF5IOW6Jov3zlYi30/yFvsFHJlEQS0+tNfK7MgouCIcOD+jbLI/ABTvU8Nt/PW8d9vCJP8ojtPQwMLyFTZQ2lhC2xGLSHih9UPd3u7;20:hBu+bY1jhsL+tpzUum6rDBpZMJK+n8I5C7e8QgM7FOqB5tPRRY9zHJnjhP8bcV28VLVcytuX5ZXsubXusuBK6edOt0e4cExjw7VSAglRV6N74QVBURIHqL/Pch0yZVst7Ya5q3UqHHO39eUK7Rnhy/kwVITGyFzO5rR0RlBKKSk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25eedfe6-7006-413b-641d-08d59db02a9f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1080A87E02BD73F646618D1FFBBF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39380400002)(366004)(39860400002)(199004)(189003)(2501003)(5250100002)(8936002)(10090500001)(5660300001)(3660700001)(446003)(107886003)(14454004)(36756003)(6436002)(15650500001)(476003)(3280700002)(2616005)(11346002)(4326008)(6666003)(53936002)(6512007)(22452003)(305945005)(10290500003)(316002)(102836004)(2906002)(6116002)(66066001)(6506007)(3846002)(7736002)(486006)(54906003)(110136005)(186003)(72206003)(26005)(1076002)(105586002)(2900100001)(6486002)(97736004)(478600001)(81156014)(81166006)(86612001)(8676002)(106356001)(99286004)(86362001)(76176011)(59450400001)(68736007)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: MGO+kMdg37O3AjwWgNPFOV9D3OdGiOoVcpUHt4dZ27MJ+8iYgAX4Jbp2pNpee/wKx8OAOImXtpg5yMXyPTPisyvAGPE0ub+0jLRHljcD8SrwwW7om4CwlpO8rlbdtraq9FPlwgrZ1BJ5RiI0LDfBvGHlsNJwj/YnPnK+NyLj6+IsKIv0cR1JJM7uW6pVboAkv41GvN5T539H36W/PBgw2kTXCIyVIZSum+EXZvLlRv9g32zRJhV/WGdBuNiqvf+Z9sCz+e172oShUZ/zJyFHGBOlrBOhKEscysaIXgZNSaeSRXo67CaaCwKylxefcPi5dmvSRaFYiHfiouz10AcUkCHiweorW75+D3hwJt08M8ED9Wyq+t6X2x5SYZandvRK1QHyrFqcPwCTu7nnNurdi0DmKRwySd5heLWWTu50ces=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25eedfe6-7006-413b-641d-08d59db02a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:46.4409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
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
index e69d49d91d67..914258310ddd 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -815,8 +815,12 @@ static int fm10k_update_vid(struct net_device *netdev,=
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
@@ -835,6 +839,12 @@ static int fm10k_update_vid(struct net_device *netdev,=
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
