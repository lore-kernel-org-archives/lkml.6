Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523241792-2-9028166289056632577
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
    1523241791; b=tMmr9ju8HahGZ2IYHRmpIwIs/DpuDFFpgZ/DF8ZAHcq7QPmLxG
    Be0c/1zSHJajMBoyRduh/R28Gtd/MOK6sRIaX2G0OpHiPC+sTTpClzHWDydEui4H
    YbSS6PM5m1Nyt9sywiwaYrjASo9bKNxnu9RWddD2GlqIaExyH5VQveJYS7ve8WvU
    lHZ+PkFgWw0dYDv9vjulPaELWNHRuwYJusZpUjH4raSkYD0IWVa+I9dEWmtOnnoA
    CRy1mrj3/woEC54TH/zewREbcDGh2Wf5a51JiZASRZ7Q3QOa8ctW1sfVnIR+jSJJ
    I6bzSiNvDnLKAQvOTH4UeGAsL3cqs6eYXhlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241791; bh=Hv4+o+vExG
    aFWJJ4Vogmgnd2dljGcS6Yf/1S31uUtRo=; b=gb3dydyFPeO1/E1HWTQD6xX6ZY
    unFAip/tH1a0mi++vKoLtMhx9sqNFG0zuT9fffOeFMxXmRbpil039TkywBTj4yni
    wT2SZ87m0MlASBi7mk3X/MmHN3ttXmeXPWAnj9wxXZfWJivu6ca3lyqArAp6TByn
    RKcC39Fl8FP6g8q+jJ+3Nw/AKePzj5MRT+bfGIZ+YVsvSabbc6seTVXFrmJSZE79
    2x9zUjofBjhVL+XmOY3dSkea7iQiKgxVxemoGk5jLy1mclwJ++IMEjauVBHxlVsp
    TnYE5SQcqBgG30WzPk5RtbA2d5A6JU8z7MB6u5lJc2gkIcCpRxZJgEqqKBzA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TcmiPoSD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TcmiPoSD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLg5WsHyymnMhv9orXtIHQPrq6BMlURpWiglMl+D96rxYbY5nUGn3fGE9f3+WAflsZLGGsTGii4c8mzgHnGL/YPAgusOE1mL+Itp6CPdnjtZB9fHiCoj
    5p05tyxjLEsRGaaJbGo5LqKHIRplRWLBcuhTF9gQCuL9+6Zis+WoMazHHoQcEOgWwUQQN4vzV7kTvUcRFvfSl4FmN9lUr4rLV46nmvFPng7bBb0TSUVh2nFN
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=zAyngx5bAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=donMdxIkcKOA4bL1sPcA:9 a=wPNLvfGTeEIA:10 a=4LA4qAFo6bo561LpWNDU:22
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755691AbeDICmS (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:42:18 -0400
Received: from mail-by2nam03on0133.outbound.protection.outlook.com ([104.47.42.133]:46250
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755468AbeDIA0y (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Mintz, Yuval" <Yuval.Mintz@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 027/293] bnx2x: Allow vfs to disable txvlan
 offload
Thread-Topic: [PATCH AUTOSEL for 4.9 027/293] bnx2x: Allow vfs to disable
 txvlan offload
Thread-Index: AQHTz5jxO6acy8tZGUC6rGSOC9/Y1A==
Date: Mon, 9 Apr 2018 00:23:11 +0000
Message-ID: <20180409002239.163177-27-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:S0Q+47YzOdjQjgeyixRLdjVq2rwlUKEMoH527WsvWI1Fed0q6xgSbA84RPn3xNJ53AC1vSUlxmRjvg9iHU0zkR7veDjnlf6yRRwF9qO11sjO4upamM/7D0odD8jtAdU6MkXwiDVXgZh4pxF91j6iH46JkWPhWQx+UkcTfqRzB+QIPqWWlzda+1C9BJWwHFJJ/A+iP/gWDypJgrIb5X/1CG/G+jZJ+c/mhv1ANmPOGZI9sSU6j4yaaUzP0U68FwJs;20:c6fUZWUVoFfFJAzLYaL436GcJhlItFgIAUSrvA2kfDmmzhBXgwXo6fDN2EgRPqx/Iaj0msCypwHI/REcscBBoCqmcWUWrDtxFblqdS/x56KM8bEa2X0OnnW+a4Ch4SL3qMFvDx7VL37LlT6LL+9AwrJcyDwWGGmvfhN0RqVpI9w=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: b0917c89-d123-496b-5454-08d59db09376
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885538294F04A5EAD75D8BAFBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(396003)(39380400002)(189003)(199004)(2906002)(68736007)(22452003)(316002)(6512007)(5660300001)(6666003)(54906003)(110136005)(486006)(6486002)(102836004)(36756003)(14454004)(99286004)(86612001)(105586002)(72206003)(106356001)(2900100001)(1076002)(97736004)(10090500001)(3280700002)(5250100002)(6436002)(3660700001)(6116002)(3846002)(305945005)(86362001)(59450400001)(66066001)(10290500003)(186003)(81166006)(8936002)(478600001)(476003)(25786009)(81156014)(8676002)(4326008)(7736002)(2501003)(107886003)(6506007)(2616005)(26005)(76176011)(446003)(53936002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 38kHq/9bKy8We4TtL8UcwvoYrtYVarm7sly9L5LxNQIl5IU8kFS1pUfUt4MpRFQIeSMdixKXFS/i3SH42qAHDNuWPFUqNnUf2rl25Zu1W+cLch3md04BguUi/MekYmeCQnjx3sfHwH+3voFM201jFo13P7WYSOhcYKMRso6r13bxZM5ndfZBxb0x8D7wHXU1hgsnKGq57Ace3nAu8K0+ihQxKDNIbOZtimVeB8/6gAwg2CQwvI+T1B8d3VqlIaMBb4gQx3SpF1Ss3apBzlhX5a/Wbzw5gmJxlgonoD3k1WDWWyoUdPpbrwqIhpVzxf9oFzjdZiJ3VsNbUcTtNtJrbhANCee2di9+dRa772jSiux7nxFye36Qe77IsJ1Gqtquby7dfJY5t6x9wc0daVen8aJqUb7eNwvR/OKbd3Tk/08=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0917c89-d123-496b-5454-08d59db09376
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:11.1592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Mintz, Yuval" <Yuval.Mintz@cavium.com>

[ Upstream commit 92f85f05caa51d844af6ea14ffbc7a786446a644 ]

VF clients are configured as enforced, meaning firmware is validating
the correctness of their ethertype/vid during transmission.
Once txvlan is disabled, VF would start getting SKBs for transmission
here vlan is on the payload - but it'll pass the packet's ethertype
instead of the vid, leading to firmware declaring it as malicious.

Signed-off-by: Yuval Mintz <Yuval.Mintz@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/=
ethernet/broadcom/bnx2x/bnx2x_cmn.c
index ca6c4718000f..31287cec6e3a 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -3887,15 +3887,26 @@ netdev_tx_t bnx2x_start_xmit(struct sk_buff *skb, s=
truct net_device *dev)
 		/* when transmitting in a vf, start bd must hold the ethertype
 		 * for fw to enforce it
 		 */
+		u16 vlan_tci =3D 0;
 #ifndef BNX2X_STOP_ON_ERROR
-		if (IS_VF(bp))
+		if (IS_VF(bp)) {
 #endif
-			tx_start_bd->vlan_or_ethertype =3D
-				cpu_to_le16(ntohs(eth->h_proto));
+			/* Still need to consider inband vlan for enforced */
+			if (__vlan_get_tag(skb, &vlan_tci)) {
+				tx_start_bd->vlan_or_ethertype =3D
+					cpu_to_le16(ntohs(eth->h_proto));
+			} else {
+				tx_start_bd->bd_flags.as_bitfield |=3D
+					(X_ETH_INBAND_VLAN <<
+					 ETH_TX_BD_FLAGS_VLAN_MODE_SHIFT);
+				tx_start_bd->vlan_or_ethertype =3D
+					cpu_to_le16(vlan_tci);
+			}
 #ifndef BNX2X_STOP_ON_ERROR
-		else
+		} else {
 			/* used by FW for packet accounting */
 			tx_start_bd->vlan_or_ethertype =3D cpu_to_le16(pkt_prod);
+		}
 #endif
 	}
=20
--=20
2.15.1
