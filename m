Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246169-2-15785666943105332004
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
    1523246168; b=MoIWdjW/jcbV05oUaA/eo82pX6KNKidI0rXbC2iyKhd+ugbpXg
    8RtEii8XxbtjKhOSTlgVkhk4iQpOV2cW2Bflomk9gRcV2QaVb53nF1S2ryKAVGRV
    wCvHgTONewh0vNR/CdbCQ+Ghm9PBDExZfUOmdj4JVjFxAwhxiEcUUPpyF6bX9Jb5
    f0fibN4kuOVqhRbImg45acoUDnvDKuN/0RzrhlRLuPfR06/R+3lzJEDqU963Hode
    f1z0k/3tskSOwtMv+YxW4yTgXP4eW++qeffEDeqdgAgrU4LuyKAO0XzAbrJZB1Ja
    uFsKGhmd9yeZVKLiPfB9sQ0Qtn6q6uECpDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246168; bh=19ekOJhaoJ
    VctcLj3EB29G0NtaYS67uAEk/j3Q8faEs=; b=hYanTo0AOQENqvIDG67A+vyuqm
    IvQmgXnyyHnYOWL2m9KlYKKQuGHjj6704e/PH4mzZOUHYBEX3P48e2EK8QhCD/L8
    dnVh9vh8RaykG2c+KetkTbQrtRkAtZXO+kWkrmFuCXwUJrVwGKrBnHxG1xBYQjd+
    N2ZCYpmfPaGWO4dncN/vbqgIEoptCbk16Q5ZsdHjL9CX2zhxVfLkKBSJJYibbO2d
    hOa5517txNp7M8tPpD38DJQ60jsa5EuMjQhNLkRSXzO3ds3o96KUPAQCzGursDF9
    fZjgnRdAuFX3B79I6nn3PMIiz/v0isVfe8OvkbdS/NgJEoFoXtZ5omKEf3Tg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O6Mco+tT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O6Mco+tT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBSGUMYqqZ3ERLX+On9VvUPKIVi+5ks/NTtffaWiVFDLJx65jHiOjkNo/lVNyzBKRsOwxoygSozuFubrdV3bPLmcqalup8FrKLbUaWOIr2RV0rG+e22l
    yQodG2cIIOFSpd7bxgWmbfpsk8hJktkCqdQATRUAmTFxKvh5yWe48EniLNcPeVISDt1YRnN0GhadwgwSNI0v+zS1c3y1x17HACdP9iB41QSZ7P3dtJhi/ZNh
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=gVGD3344AAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8
    a=Hb0Uqtfb04O3FyaSReIA:9 a=wPNLvfGTeEIA:10 a=xQEvYfgLW3QvObN0DhJi:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753815AbeDIDzw (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:55:52 -0400
Received: from mail-by2nam01on0126.outbound.protection.outlook.com ([104.47.34.126]:59343
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753788AbeDIASt (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Daniel Hua <daniel.hua@ni.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 087/189] igb: Clear TXSTMP when ptp_tx_work()
 is timeout
Thread-Topic: [PATCH AUTOSEL for 4.15 087/189] igb: Clear TXSTMP when
 ptp_tx_work() is timeout
Thread-Index: AQHTz5g0RYIIzWb8nUaXVNSjUQtqwg==
Date: Mon, 9 Apr 2018 00:17:54 +0000
Message-ID: <20180409001637.162453-87-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1128;7:i3yToUFnBk5Nia31jEB8zSCsNiAIlzALSIbTfGXLwXAs4aFqE7aizqVi0x4dI9VsWClKWex1aKuY9fWK8aFhqFoZlPLHquli4zzunRdYtwnOmL+/mRlUnskud5UTOY9CdWtFoGXj98NrnjFER0doxCcmg7HE4MjsJrgQl3c4BLWQK3Zw2wZyK63XkfVN3+GgFIUOT4Rro4Ngs/kwq3f/rPxIwAA7o1WhwcIqaAbV2o7BSY1XWhZjVzSqcqO17wHU;20:cE2+SbEXrprXzK/6tocVQeeEqT2iNgPq01eVZeBlG7EoKrsZJrtwA/x8hLnJSiHI+Cy34ZmS1heVYByt427912f1WnnJiNdco0ujUIGLU9H0y7nsYxIi2Pnmdoa8iK0551Ccq7XutPn4g+5L5HUh5lcInjzizn3QrsweH3jCoeg=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: d97435fd-7562-408d-07e3-08d59daf733a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1128;
x-ms-traffictypediagnostic: DM5PR2101MB1128:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB112851961816825C16EF437AFBBF0@DM5PR2101MB1128.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(21532816269658)(228905959029699)(145744241990776);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1128;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1128;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(366004)(39380400002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(2900100001)(25786009)(36756003)(6506007)(76176011)(2906002)(6486002)(86612001)(99286004)(102836004)(1076002)(7736002)(575784001)(97736004)(2616005)(446003)(486006)(11346002)(476003)(26005)(305945005)(6666003)(6512007)(4326008)(107886003)(478600001)(6436002)(5660300001)(10290500003)(5250100002)(22452003)(316002)(105586002)(186003)(8676002)(110136005)(54906003)(72206003)(53936002)(2501003)(68736007)(14454004)(6116002)(8936002)(3846002)(81156014)(10090500001)(106356001)(81166006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1128;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: vFfI/bAazCupAYJ0scHPHGyl0R+KmkXlLNhdRHczI+QyWX29icZvJ4uS4mv5Z4fbJFXoOyLBWIItUflvqvxrD2f2VfddgdG1R9mKvabRArcXYArswxuU0BqfqVQXLuCg0BlQdni31LxkWlm6q1FkPfR1of92WVGen3xDyA4f2bklVTtCB73EeXfJ+kswUkQPijpCCYaN9+ANIQ0a1qso9mCQGZMuumPILMCSMjqnllNbeTIpuqr1aIAZAjOZ4oVB/ziPZ2rV/kr7JYvMzlRMZsI5542BhDBhLaB8IOpvk1VTz2h9B1noILvWmArtlb5xZU2mrbkdU06rq7shSTApS6nmbyuch/LO87LI8vpD1qmhgkIoz2cjPuPARzwM1O6TB8XwRP+H0/nNVOt7AmmKVPgCV058W5e8Wy9YxPLfb2k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d97435fd-7562-408d-07e3-08d59daf733a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:54.2574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1128
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Daniel Hua <daniel.hua@ni.com>

[ Upstream commit 3a53285228165225a7f76c7d5ff1ddc0213ce0e4 ]

Problem description:
After ethernet cable connect and disconnect for several iterations on a
device with i210, tx timestamp will stop being put into the socket.

Steps to reproduce:
1. Setup a device with i210 and wire it to a 802.1AS capable switch (
Extreme Networks Summit x440 is used in our case)
2. Have the gptp daemon running on the device and make sure it is synced
with the switch
3. Have the switch disable and enable the port, wait for the device gets
resynced with the switch
4. Iterates step 3 until the device is not albe to get resynced
5. Review the log in dmesg and you will see warning message "igb : clearing
Tx timestamp hang"

Root cause:
If ptp_tx_work() gets scheduled just before the port gets disabled, a LINK
DOWN event will be processed before ptp_tx_work(), which may cause timeout
in ptp_tx_work(). In the timeout logic, the TSYNCTXCTL's TXTT bit (Transmit
timestamp valid bit) is not cleared, causing no new timestamp loaded to
TXSTMP register. Consequently therefore, no new interrupt is triggerred by
TSICR.TXTS bit and no more Tx timestamp send to the socket.

Signed-off-by: Daniel Hua <daniel.hua@ni.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/etherne=
t/intel/igb/igb_ptp.c
index 841c2a083349..0746b19ec6d3 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -643,6 +643,10 @@ static void igb_ptp_tx_work(struct work_struct *work)
 		adapter->ptp_tx_skb =3D NULL;
 		clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);
 		adapter->tx_hwtstamp_timeouts++;
+		/* Clear the tx valid bit in TSYNCTXCTL register to enable
+		 * interrupt
+		 */
+		rd32(E1000_TXSTMPH);
 		dev_warn(&adapter->pdev->dev, "clearing Tx timestamp hang\n");
 		return;
 	}
@@ -717,6 +721,7 @@ void igb_ptp_rx_hang(struct igb_adapter *adapter)
  */
 void igb_ptp_tx_hang(struct igb_adapter *adapter)
 {
+	struct e1000_hw *hw =3D &adapter->hw;
 	bool timeout =3D time_is_before_jiffies(adapter->ptp_tx_start +
 					      IGB_PTP_TX_TIMEOUT);
=20
@@ -736,6 +741,10 @@ void igb_ptp_tx_hang(struct igb_adapter *adapter)
 		adapter->ptp_tx_skb =3D NULL;
 		clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);
 		adapter->tx_hwtstamp_timeouts++;
+		/* Clear the tx valid bit in TSYNCTXCTL register to enable
+		 * interrupt
+		 */
+		rd32(E1000_TXSTMPH);
 		dev_warn(&adapter->pdev->dev, "clearing Tx timestamp hang\n");
 	}
 }
--=20
2.15.1
