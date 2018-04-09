Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246224-2-5213516096075875647
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
    1523246223; b=wztQb291LR1Hv5RYWxlH4/xOB70y/ekWbp/OIXDCziztgjCvT/
    0ukV1ywvWlikOeKxnBzW2Fn+Wk+grLBccHNuJyOkvQaJNZ1gY49Mx9avkR32g8aJ
    ygMGJ2kM5T17wFzQy3bFuQlbD0RKXRHEWWDYVIIy2kDr4nOiIhH6vAJJRiEB5y37
    TUHg/sabZLVVi0teb8/C755NjLizBXmS1vun11FHZawbOZaJ8l8G0DPkgTEbSHb/
    f92dzzqQs3X2VH10Uz5bP+KxLUKxysiBC14IexgnvlJicb82pt4KdEDK4DFsFN2w
    IIb5NXuIrvfQ7toY90LjRoDq0Kd2PoT1N/Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246223; bh=mcBQ2gCj89
    DBBquLT+hsRqR1RNwnzb3S+pGoWuSaBo4=; b=D7VOFA8kD/0sbyyMNpodybu8I9
    GsyWTPsPntEGv2ZiNpUxWovVO8llgGXua/qyOJOQhLIFWYZfJkzE08TQY3wgq27L
    p3H/fkpmmAncKyy6BwknTGnb16/GzairqZGmxmEcE60T2tiERfd3875D0VW1Q6lH
    lNQ83/ixvzreh1mvnV1xPs5Oww/sF9h/wBnt8DdKjJLogj/B8YCR14nWuxEu+97d
    Tt88ujuynT//FQh7rMf9I6700iRCopdatCvjTmImb7bZo+KHx+T7QxmcFRYbWfVt
    oxKhOzqVYNOLwx3XlN1ZwhPAL7sM83lgWROgBoSb4nxOFNaRt1QfEIJ77hUg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SB1faA0U x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SB1faA0U x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHu5CtXfWejiIN7wFvDztNCwpSuTPW8CB8+I7ami2fVS6c70HvhkvJd9kaODwW4LEkCD3ZCYdQvVUlFZ7qzwROZr5UVznhRjJXwHzTAyL/49ukYQXvcP
    gUkihSjSMisXcj9PCRiBmjn4wHrU7e9aaSfaakmG03NL7GR7m63M4xUtglaSBdc4nmC/LjH6YREe/s3s80+hRgJ1AT3bcZ1XhC48wFFEvVk/6/asrr+vkxI1
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=K1sXOyfe0bMs6rlRlcsA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754507AbeDID4v (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:56:51 -0400
Received: from mail-by2nam01on0126.outbound.protection.outlook.com ([104.47.34.126]:59343
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753738AbeDIASo (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alan Brady <alan.brady@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 079/189] i40evf: ignore link up if not
 running
Thread-Topic: [PATCH AUTOSEL for 4.15 079/189] i40evf: ignore link up if not
 running
Thread-Index: AQHTz5gwo09usvWbtk2p0S/mcjsUFg==
Date: Mon, 9 Apr 2018 00:17:47 +0000
Message-ID: <20180409001637.162453-79-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1128;7:OIjk1fOd+VvNp+8cNthBtKb4C2DX+2AVPPzleWXwl3SJWnf778FrHk2QhhE/YT+dLZT+v14SNICGvXNd5tN5w7B32wYLJYz8O6sxIsUscZQITg7OQQ5apRejlckrh6Ucr9TPP9AI5m1Bzsf57iuVrcy7/jfsSc0JNXIQ/BjIUNRstsm61L3Tfabj3DBu3xBbq0uiQyJL1yIkUub9ePTQsi7KeudeyILRvIfnRc9jv6TFQ0zVsWNZMgrgsyrtWipz;20:n3t+B/3wJwM9073EmaHwxj5LZtA1Jmz4uNEohOUW413Jn7AeGbcy/R9pe2geeeA9LK1t8novdDNBfsbB1yY03X60bDHXUSHJaXIko9209DUdJmnBuOKFhUjMp3/pfkTiDhC/ggo256gym3e5CDtJpZJGuYFfcwA4wIO3sFN5GGk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3c0d66ee-31aa-4e69-de74-08d59daf70bf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1128;
x-ms-traffictypediagnostic: DM5PR2101MB1128:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1128C35E24A5A01AC5C47186FBBF0@DM5PR2101MB1128.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1128;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1128;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(366004)(39380400002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(2900100001)(25786009)(36756003)(6506007)(76176011)(2906002)(6486002)(86612001)(99286004)(102836004)(1076002)(7736002)(97736004)(2616005)(446003)(486006)(11346002)(476003)(26005)(305945005)(6666003)(6512007)(4326008)(107886003)(478600001)(6436002)(5660300001)(10290500003)(5250100002)(22452003)(316002)(105586002)(186003)(8676002)(110136005)(54906003)(72206003)(53936002)(2501003)(68736007)(14454004)(6116002)(8936002)(3846002)(81156014)(10090500001)(106356001)(81166006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1128;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: yDYHzaQ2Kuqp8fKpfJ01fjo6lWApsTDUahZOzCXiBeFk31ptV93HH5tW7Brk5J/in90whCkY6LrwIA+8s/BNdWn5J47ZJWsaD0BsTbNZqDBkYzr18+M8oVn8hK1Oyt+S1dDw0lFydk58M1VUb5uJJ7paNiIAy9Ex1PGxT5RE9NZmvZuA6+WXCerMGUNqvKBPLwEziJTs9U79Em0LJ1Lqvyi1Ac3zfO1FWPVkBd7Snfujdr8OamjBYxpv5f/yRXLxM2hVWkZnqvlXFhY5GsVnmcSkmnTHOMGRe07UYtfVwmlnK+xrlRBYOPhzE5052yS+wu4ZZ3g3CtJpj5c/Uu04X1MHNCmX/0QZ0kFHNGtpGYP8/ZOHMa1eSNMByfr1zEXBHcMHndjurHh0e/Wkrkhd6b4EEYv/WBkCYrRs7CkG8P8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0d66ee-31aa-4e69-de74-08d59daf70bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:47.2579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1128
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alan Brady <alan.brady@intel.com>

[ Upstream commit e0346f9fcb6c636d2f870e6666de8781413f34ea ]

If we receive the link status message from PF with link up before queues
are actually enabled, it will trigger a TX hang.  This fixes the issue
by ignoring a link up message if the VF state is not yet in RUNNING
state.

Signed-off-by: Alan Brady <alan.brady@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 35 ++++++++++++++----=
----
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/=
net/ethernet/intel/i40evf/i40evf_virtchnl.c
index 46c8b8a3907c..23635f5a2388 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -965,23 +965,34 @@ void i40evf_virtchnl_completion(struct i40evf_adapter=
 *adapter,
 	if (v_opcode =3D=3D VIRTCHNL_OP_EVENT) {
 		struct virtchnl_pf_event *vpe =3D
 			(struct virtchnl_pf_event *)msg;
+		bool link_up =3D vpe->event_data.link_event.link_status;
 		switch (vpe->event) {
 		case VIRTCHNL_EVENT_LINK_CHANGE:
 			adapter->link_speed =3D
 				vpe->event_data.link_event.link_speed;
-			if (adapter->link_up !=3D
-			    vpe->event_data.link_event.link_status) {
-				adapter->link_up =3D
-					vpe->event_data.link_event.link_status;
-				if (adapter->link_up) {
-					netif_tx_start_all_queues(netdev);
-					netif_carrier_on(netdev);
-				} else {
-					netif_tx_stop_all_queues(netdev);
-					netif_carrier_off(netdev);
-				}
-				i40evf_print_link_message(adapter);
+
+			/* we've already got the right link status, bail */
+			if (adapter->link_up =3D=3D link_up)
+				break;
+
+			/* If we get link up message and start queues before
+			 * our queues are configured it will trigger a TX hang.
+			 * In that case, just ignore the link status message,
+			 * we'll get another one after we enable queues and
+			 * actually prepared to send traffic.
+			 */
+			if (link_up && adapter->state !=3D __I40EVF_RUNNING)
+				break;
+
+			adapter->link_up =3D link_up;
+			if (link_up) {
+				netif_tx_start_all_queues(netdev);
+				netif_carrier_on(netdev);
+			} else {
+				netif_tx_stop_all_queues(netdev);
+				netif_carrier_off(netdev);
 			}
+			i40evf_print_link_message(adapter);
 			break;
 		case VIRTCHNL_EVENT_RESET_IMPENDING:
 			dev_info(&adapter->pdev->dev, "PF reset warning received\n");
--=20
2.15.1
