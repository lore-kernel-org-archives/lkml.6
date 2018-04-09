Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240379-2-9508863287148282058
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
    1523240378; b=Aj/mBoZS0EKzOyMUO48z+QsyJ1AVe+duYvz7pnXueO/hBh0nb6
    Jw0oPD2ZCFxOL3VDn0G6nhkeJNEGfr4xp/WbQ2TszKo1B9SsDahdpdDFe2nRhQZf
    I8J1GKjQWUnSQnx2lLaZvbuoGY582yKo9o4ChqNsc9sU8Pd6TXJUy2ZJ0rsGIGaF
    5aXADmUObYmaNXsC3g7U23QLNMG1kJytxIo4itp2pHtZnvO1mhbx7fuIwIk4YvzT
    8wmoy1unzzEomF148y5cpIDEjgr58JF8Lfs2fhhVbNMrK5vOwO3DT+7sShBJe9ge
    doyX2QiHDcy7RrWd8MZFQa21QQ/+3h1S+ETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240378; bh=dqFsZtedQe
    kzDiF6zjl7Lbqt1QPvlcNtKPe4uZ+ai54=; b=UKhAtT9YBwlE3ICHA+7MXDxXq+
    oDA7oGJMFCWqco/FG324cYJ++wSl6rd6+gkQGErvSnqk9T0TWr+f3ZyBgoVu11LH
    GBsdSbyZ3cE7y4Cg75sKynoKz4aQeg+sa5JZfencRz+3dr1sHjO3NdDxUe6bclVH
    cgIhow2coOrxXRQP6dhBySMI9xx1bdqXzhxOhCyyJ9QSLlCmJYQcrLZ+78HWiRDg
    QZIDenQZi6sSmwj/JfGWM4s4gHDy05c/cR2pkE27Ey1LdCXIvS/ZvYFJDHWkjdsQ
    JLmuZvwh34L7giO/86r5xKXh2DWvBlW/Qr5r4bri115SlH0bnfxo1iGIkt7g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZsIzZGXK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZsIzZGXK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHKCkB59e7fVd6y3TRS/3ocvePmlJFRqswXULjP2IeuSlTkxQfulp8Kc9RpeBZilAqKulqx5zv47/lEwfCnJUUNpFHt9acs7NVXlWnpbTwmixntsYM4n
    w3K214RGccTB6If9tNEtxKqLcICr3Op2W5S7KBjvF+ngihuF657SBjFD1aIR9z6+uTZhwmTwk4avNJP5ecDFPs459XOYNY9yBuLnyqJF2hXilSCteF53lDgS
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yMhMjlubAAAA:8 a=J1Y8HTJGAAAA:8 a=n1V2pPDkoRpHzeVkx7cA:9
    a=VxQv4m5mwp1jTIv5:21 a=GdIW1SjrAcGUdRtX:21 a=wPNLvfGTeEIA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755781AbeDIAaW (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:30:22 -0400
Received: from mail-sn1nam02on0125.outbound.protection.outlook.com ([104.47.36.125]:10314
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753157AbeDIAaU (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:20 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Haiyang Zhang <haiyangz@microsoft.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 125/293] hv_netvsc: Fix the carrier state
 error when data path is off
Thread-Topic: [PATCH AUTOSEL for 4.9 125/293] hv_netvsc: Fix the carrier state
 error when data path is off
Thread-Index: AQHTz5kgV3Vc1TFUHkSzuvXfOPVZRQ==
Date: Mon, 9 Apr 2018 00:24:30 +0000
Message-ID: <20180409002239.163177-125-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:TpPPJVMRiacY2YzXZS7KkGe74g9uXzhEKoRc55bUcVf50v+/fio2UmSk+hKgTUAClJj7HNr9v9ecxioYDO/rWxyLSJisSpAQbSe1c+SlSHAz6tPkYdQMbmvP34sDZuYE3DjwYk0n/6M9KwcPNvWoyLxZQUTBteu7BdRIEiGUtdZ9v9Mv6j/xLlneceXBeJ1VQ2Hv5LZavJ3ytjjS0JU46L8wGQoT/WV8TMiknfUEVtrurnrnZXClubIYaP4KLtjJ;20:WizWWXoKnz7/Vegeo7VZC+ZV8mntsiUJ3YKaLpj3zWFLnUy0f0z4TneTOyrWNh93fZoyl1sOVRMeLmJ+XndoXpBn5hJK1Z0GW8nQcunwMHU/0OWSPhu72f4nJtcYqZoNWdFehAcI6HFdPofh2fpohY7HBSlSbuQzsmnMhkZAqNk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 27edb172-924e-427e-3add-08d59db11106
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1032486716C7FE2CB08DD374FBBF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(39860400002)(376002)(366004)(189003)(199004)(40224003)(5660300001)(76176011)(99286004)(10090500001)(2900100001)(105586002)(305945005)(7736002)(107886003)(2501003)(5250100002)(14454004)(53936002)(4326008)(8936002)(68736007)(25786009)(86612001)(3846002)(66066001)(1076002)(486006)(316002)(72206003)(22452003)(106356001)(186003)(97736004)(6436002)(6116002)(476003)(2616005)(478600001)(6486002)(10290500003)(2906002)(110136005)(54906003)(6512007)(81156014)(81166006)(8676002)(36756003)(11346002)(3660700001)(446003)(6666003)(86362001)(26005)(102836004)(3280700002)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: B5XMei1xw4VpyJVppqOh4hhd8kR4MnJ6/Ynh1Pw0MEHSEDDS6mQCUNJjDCk4xM+oPn0XEQy6t1tGkYUqakooFw4U3XI+FpYk/bxiI7m/2d+RPtYYloZ0c+5lQuKu89NtUF3Ml9FncChlIzB5Opwl8AKi+UFyH7AAzmjuCOvRY60qdj1cj2LKbGO4i4seP4p3ssUZIru7ilNc6PTPHB2vqyrVR2Pyvnr/1TsdW5oGHzFAtfB0jhNyUudrATtfdn4yraQtLYLqLds7t4r0caOtl8Xo5opuR/R63V2S3EySbFBtzTHO18sM8qTR3JxJxT2ZtqFOp/iAWBd1BsvgLRjuBRqTutpq0mqYeGY2BBa4at3CbBP/856KoaNIjf9vE79JrpxyusgzjvcHitQkUBuaXpGuDxiEuQ1dLLQSsrOrBSE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27edb172-924e-427e-3add-08d59db11106
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:30.4719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Haiyang Zhang <haiyangz@microsoft.com>

[ Upstream commit 53fa1a6f33520f01f9dbee48369074b34d77616b ]

When the VF NIC is opened, the synthetic NIC's carrier state is set to
off. This tells the host to transitions data path to the VF device. But
if startup script or user manipulates the admin state of the netvsc
device directly for example:
        # ifconfig eth0 down
	# ifconfig eth0 up
Then the carrier state of the synthetic NIC would be on, even though the
data path was still over the VF NIC. This patch sets the carrier state
of synthetic NIC with consideration of the related VF state.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/hyperv/hyperv_net.h | 2 ++
 drivers/net/hyperv/netvsc.c     | 2 ++
 drivers/net/hyperv/netvsc_drv.c | 8 +++++---
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_ne=
t.h
index f4fbcb5aa24a..29dd65108810 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -703,6 +703,8 @@ struct net_device_context {
 	u32 vf_alloc;
 	/* Serial number of the VF to team with */
 	u32 vf_serial;
+
+	bool datapath;	/* 0 - synthetic, 1 - VF nic */
 };
=20
 /* Per netvsc device */
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 14f58b60d1b5..ef470ce01d7c 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -57,6 +57,8 @@ void netvsc_switch_datapath(struct net_device *ndev, bool=
 vf)
 			       sizeof(struct nvsp_message),
 			       (unsigned long)init_pkt,
 			       VM_PKT_DATA_INBAND, 0);
+
+	net_device_ctx->datapath =3D vf;
 }
=20
 static struct netvsc_device *alloc_net_device(void)
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_dr=
v.c
index 36a04e182af1..71a431d27660 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -101,7 +101,8 @@ static void netvsc_set_multicast_list(struct net_device=
 *net)
=20
 static int netvsc_open(struct net_device *net)
 {
-	struct netvsc_device *nvdev =3D net_device_to_netvsc_device(net);
+	struct net_device_context *ndev_ctx =3D netdev_priv(net);
+	struct netvsc_device *nvdev =3D ndev_ctx->nvdev;
 	struct rndis_device *rdev;
 	int ret =3D 0;
=20
@@ -117,7 +118,7 @@ static int netvsc_open(struct net_device *net)
 	netif_tx_wake_all_queues(net);
=20
 	rdev =3D nvdev->extension;
-	if (!rdev->link_state)
+	if (!rdev->link_state && !ndev_ctx->datapath)
 		netif_carrier_on(net);
=20
 	return ret;
@@ -1128,7 +1129,8 @@ static void netvsc_link_change(struct work_struct *w)
 	case RNDIS_STATUS_MEDIA_CONNECT:
 		if (rdev->link_state) {
 			rdev->link_state =3D false;
-			netif_carrier_on(net);
+			if (!ndev_ctx->datapath)
+				netif_carrier_on(net);
 			netif_tx_wake_all_queues(net);
 		} else {
 			notify =3D true;
--=20
2.15.1
