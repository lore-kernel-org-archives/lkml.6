Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241097-2-3350217061871128328
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
    1523241096; b=cqDtjbu8ADgrcP6fBUAQVfCdggmutaXuTW8ZRzpyOgNquyuvdB
    ++ocf7NN0syu54SsHc4DKk/CorR8BPjhsqWIK7NIgOw4Zpk/gKAb2uVldIxwifm8
    z6frvreOCJb8SDsZDbq3wiq5M6Ab5Ltnt3mxcxYY3MskZtyMShNfHapV7s3h6UIT
    pHZW/ZcNfXrSRKG3JLXtO9PJ0twRY189p29qZXOdwyALAAwAnjJ9aExzy2Id4AkD
    wSGgw8wtt567OqF3moJs+k4M8t0l3lTvmTIDs3HssElMuu5JhQ+KOfxXfsMqKoCc
    8D+0XJrqmgj6BB9pAlOeG7qOsWO+s46fGzQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241096; bh=tHpdYjTFdq
    0XwCojAtiffjvU3OwL4PSEkdpEYl0EwsI=; b=K8cDtKLjTmCJK9hG2CRcPjoZxb
    3BwyPmzSvbExtOS0qi88b+sp0sw+e9LMS0Fv/0YTINDQkdktfTBobGNA5bDfD5ra
    lWuoBFgSYUYAo7Ln02mxzgWyxfXbftu3XSArYTqz0mGJWXKTqGX4YpiwqtwnXLfN
    FJNSi2EE+NnFUvyWTwsdO9rClJjDqCsKPDIB8lAfxrTinIKW1mn6Hw/tdQPASJjF
    CIoK6dHuGvjUcwwoWa47MGLiyJzE0tJAv6qvClHZbBDOBn9Yh6Ecpbv1D4FOwSId
    W4K/+AuJ7ERRU1sJWReXmgmJ/6fGLoBkdXheA4iIdN3QMzIvNW/7yv0uTvZw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BHfve4rj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BHfve4rj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMgaDAbQ5iImoKsoRngIb1RHtxs/aDUsXLYrfAZ0N7n2SFbrjVWivvVCQuGjz3pnHBUJE9Sa0Ny+fGRSDCOUII/2j4uLfE/FqKv4C4k3zC90rd2NgaCM
    S/ffBsBi9J2dvICp7tdI4IwsFQ5oxwwDt85nUDvsUD712i9LicWvhRgHRL+nGuTeydH7JJAqGRQTj1dGW/wMj5m0sIfW+XTLlFHaLMrGdD5tjbdXzP3oLX01
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=dq2cNPrMAAAA:8 a=yMhMjlubAAAA:8
    a=aH1ZG0Hx61DjTTwGe0YA:9 a=wPNLvfGTeEIA:10 a=UrzWRhJOTTn3oDX10iyi:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754318AbeDIA2V (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:28:21 -0400
Received: from mail-sn1nam02on0097.outbound.protection.outlook.com ([104.47.36.97]:15008
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755773AbeDIA2P (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 068/293] ixgbe: fix race condition with
 PTP_TX_IN_PROGRESS bits
Thread-Topic: [PATCH AUTOSEL for 4.9 068/293] ixgbe: fix race condition with
 PTP_TX_IN_PROGRESS bits
Thread-Index: AQHTz5kFnfKWj5NDIk2ZZRlHU652oA==
Date: Mon, 9 Apr 2018 00:23:46 +0000
Message-ID: <20180409002239.163177-68-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:aPfQ+SjwFTrlpv2+Rzet/qkjxGLLcJiUAPVLjHeVAuThdvflRGQjTKt4c9d04oIQU8E4PaWUGOBbGDqdyU49/eaOEcXLaWCLM6hko9zBBO9xrPB6d1PpCsJzveJWvf9Oa2TLcV6ZCFXQk8sVa2odmVe+HbnaJZd79yTuHMmHaZJo8sPLVJlQQFNM+prRq0NhhfcE3AKlme3P4i70+OfSaDt+M1YjZ3V+QBrMmu3HsD8Z7zFJj7kJ04cQNVrGiT6a;20:swWr/QX1WDMGeLI8p+LDx/oqt2TseFcCv5fjTTPl4g/s5r2juqmFMPx/8mCNjBV1q46evriNNDdHUT2O39z9uvrl3TFapu+3Px0KdP7k3w/1uDVcaNM/JeFCoAOmGK4s39FURDry0fji0l5wYZwsHxzlIW0Qke00YijKpfHSOpc=
X-MS-Office365-Filtering-Correlation-Id: 2ccf47a6-7c95-4d3f-4588-08d59db0c619
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08711C581BA7BB241131DF85FBBF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(278428928389397)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39380400002)(376002)(39860400002)(199004)(189003)(105586002)(8676002)(59450400001)(3660700001)(3280700002)(6506007)(81156014)(81166006)(14454004)(99286004)(72206003)(110136005)(8936002)(54906003)(305945005)(2906002)(316002)(10290500003)(478600001)(7736002)(53936002)(6512007)(486006)(11346002)(4326008)(86362001)(446003)(3846002)(102836004)(76176011)(476003)(25786009)(22452003)(36756003)(107886003)(6666003)(10090500001)(5660300001)(6486002)(86612001)(6436002)(2616005)(68736007)(26005)(1076002)(186003)(2501003)(5250100002)(2900100001)(106356001)(66066001)(6116002)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: SqhfI0xceA05UIhTCzGFcfiq7S0dIi2Yqf5mNR4eac3eFT2CnR/cu1FCjEsAG3DgaGa0UFM6tKlqTF36LqFk+lUy7On5ikUJ6rtVR/eWatNVr6CyyhBn4lYG/oZMzZH/ytC+8sw2KplOxufxmpDRgWk7rDjd0EnXs+ClRXo1/6QJrnZHGnNaiWsv76EPeNz+ANzwZWD0vEnhBM9Jn2aacY2WEqGnuCRViAt30e6mPZzF1ozTDMrasNrSA7UB9fJu+Uy/w9lQYOCGThk3uVGcpH2gtoqsMXQf0C1KXW++GyaHoi0InECtv5OXO8fS5bzVauz3dgEdbBD6uKda+X48hxANDmSc/RCHPach3Z0lWShHXo5R8BjUT20S2YCeFp+y4Tbb/65yS0zJPq8xSS7I5a4DPTjm2uwCGSqLCk/ZnNY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccf47a6-7c95-4d3f-4588-08d59db0c619
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:46.4405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit aaebaf50b502648b1d4d8c93b4be133944c2bbd0 ]

Hardware related to the ixgbe driver is limited to handling a single Tx
timestamp request at a time. Thus, the driver ignores requests for Tx
timestamp while waiting for the current request to finish. It uses
a state bit lock which enforces that only one timestamp request is
honored at a time.

Unfortunately this suffers from a simple race condition. The bit lock is
not cleared until after skb_tstamp_tx() is called notifying applications
of a new Tx timestamp. Even a well behaved application sending only one
packet at a time and waiting for a response can wake up and send a new
packet before the bit lock is cleared. This results in needlessly
dropping some Tx timestamp requests.

We can fix this by unlocking the state bit as soon as we read the
Timestamp register, as this is the first point at which it is safe to
unlock.

To avoid issues with the skb pointer, we'll use a copy of the pointer
and set the global variable in the driver structure to NULL first. This
ensures that the next timestamp request does not modify our local copy
of the skb pointer.

This ensures that well behaved applications do not accidentally race
with the unlock bit. Obviously an application which sends multiple Tx
timestamp requests at once will still only timestamp one packet at
a time. Unfortunately there is nothing we can do about this.

Reported-by: David Mirabito <davidm@metamako.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/eth=
ernet/intel/ixgbe/ixgbe_ptp.c
index a92277683a64..079fe5ecb39c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -672,17 +672,26 @@ static void ixgbe_ptp_clear_tx_timestamp(struct ixgbe=
_adapter *adapter)
  */
 static void ixgbe_ptp_tx_hwtstamp(struct ixgbe_adapter *adapter)
 {
+	struct sk_buff *skb =3D adapter->ptp_tx_skb;
 	struct ixgbe_hw *hw =3D &adapter->hw;
 	struct skb_shared_hwtstamps shhwtstamps;
 	u64 regval =3D 0;
=20
 	regval |=3D (u64)IXGBE_READ_REG(hw, IXGBE_TXSTMPL);
 	regval |=3D (u64)IXGBE_READ_REG(hw, IXGBE_TXSTMPH) << 32;
-
 	ixgbe_ptp_convert_to_hwtstamp(adapter, &shhwtstamps, regval);
-	skb_tstamp_tx(adapter->ptp_tx_skb, &shhwtstamps);
=20
-	ixgbe_ptp_clear_tx_timestamp(adapter);
+	/* Handle cleanup of the ptp_tx_skb ourselves, and unlock the state
+	 * bit prior to notifying the stack via skb_tstamp_tx(). This prevents
+	 * well behaved applications from attempting to timestamp again prior
+	 * to the lock bit being clear.
+	 */
+	adapter->ptp_tx_skb =3D NULL;
+	clear_bit_unlock(__IXGBE_PTP_TX_IN_PROGRESS, &adapter->state);
+
+	/* Notify the stack and then free the skb after we've unlocked */
+	skb_tstamp_tx(skb, &shhwtstamps);
+	dev_kfree_skb_any(skb);
 }
=20
 /**
--=20
2.15.1
