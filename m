Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520492913-2-802546506309253953
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520492913; b=t698MRt6lXue/ir9dyIgueZCQpO3sEMqSzDIwv9Hl4+VO//
    rzosU5OXtwPQblFEeBNsXIH4X6ec7H5DwCKkTHPVr9T+6W5L9lAQkqBfLx/ryAdc
    ojeUxKF8LkuZ8ajLsXjNkspFLP03igm6puBqzpQmRHQhny8eOiMiRWRtHtsmIovV
    MSNttgaoyQOx8DSz8bQuC9ZEukVgfnGoB48nuvKXwfEkVL0t/oEjkpRgCjeCkSzE
    ggsreA2Q9AgirdPKjyD1nc2DvR9gMJXYQHZO6RAXQIbvlyROpuMIWALXGUNHZ6wB
    gMap+PuA+Y1jE3tL8bxecTRfdltwLFz3AEPJx5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492913; bh=hLCzV6
    HIMfGQNaGbR0oyTkItqdETuf4JzxnX32NvxRw=; b=gVC0OpmG67fLeO9Vgo+KO1
    bG3HPwo9cWJPirNIxHLKrzweGORaXfNlL/4KX69CeGsp1pakhdBbWOwIiawGLc8D
    J1dJg3ouAt23Ap55FPMoZ+4v/ItTuUDWWg4w//2YIsA4MzCDoxAccDWShc1sCbxJ
    iI+RKQwqLcYZYpXGRIMTMAarVaDcmu957/fHiegfnLYWykm3MgIjQU/rbB1zbJJQ
    Hmh34Lp5wu1e7rpHKZMh52I0UsUjOkE7o3H6Gl/fC45jYc4zi+wbXx7VN38cFvHD
    KeDBy06U2X2Tdlh/0Wfv2E++c8EJMmHbUpApBm2cOX8LVcCKUvhdP77Z4powJq3w
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hkhV8oId x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hkhV8oId x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeCHHIQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:08:16 -0500
Received: from mail-bn3nam01on0130.outbound.protection.outlook.com ([104.47.33.130]:45246
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933352AbeCHE43 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:56:29 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Balaji Pothunoori <bpothuno@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 22/78] ath10k: handling qos at STA side based
 on AP WMM enable/disable
Thread-Topic: [PATCH AUTOSEL for 4.15 22/78] ath10k: handling qos at STA side
 based on AP WMM enable/disable
Thread-Index: AQHTtpnGipLsnlISi0OQfM1PMxIQMA==
Date: Thu, 8 Mar 2018 04:56:10 +0000
Message-ID: <20180308045525.7662-22-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1111;7:kd80suXELs7JlUoYEiXOrkn/mIMWGogrB0GEp3xthkVPFIOXyFYCeI2QB0uMusmFBzJdUNuoOYpmT2l86e4sbn8PkKQMr1P7BKJVDSjwvDD4oQCUVJbhYNBBkBWbfbcD+1HM4uVj71j9u4v4vm6hbMUQZPJ6fvr/L5NUjugRCtFfthLjFKj72GZg1oM7gROuWN+1rjZGplgCJIDvG2ui2+uwNEwbzYYO9SSTOIOmeEO/00Upu7+vTnL5h1ZYXK9q;20:2J1uv1EpLtnO0WfNMR8GOq1YyC7KHWK/Y50Kw7K7E9g6mAZVzB5qAz+VbnSOxGSkLl2zyz5fnpeCATXKQD0wlI+CTeTbtj0XuSnRzVDNHvV72L2fvXF8+QYPO6X6rmYNJ0DBFUsgVzYWVzJWGGrJk+m2s5redjTouyQbp1MliLg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d3aa3d5e-2356-429a-0d12-08d584b0eca3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1111;
x-ms-traffictypediagnostic: DM5PR2101MB1111:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11113E616695177516162BB1FBDF0@DM5PR2101MB1111.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1111;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1111;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(376002)(39860400002)(366004)(199004)(189003)(86612001)(22452003)(99286004)(7736002)(54906003)(305945005)(86362001)(5660300001)(66066001)(6512007)(81156014)(14454004)(53936002)(2900100001)(10090500001)(1076002)(110136005)(107886003)(6116002)(6436002)(3846002)(72206003)(36756003)(102836004)(316002)(3280700002)(3660700001)(478600001)(106356001)(6486002)(76176011)(6666003)(81166006)(10290500003)(4326008)(2950100002)(97736004)(25786009)(59450400001)(105586002)(8676002)(26005)(2501003)(2906002)(5250100002)(8936002)(186003)(68736007)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1111;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: bBwstnvWwGXEE8K3TgJ1AgMdcG7hMTekxseJGDdA9LUIxKCWw95P5//fccbH8X59V/1WbDgl7ePPm+7Ppn746y4ZE1WdQkk0yGaO27sxfmPKBUQhoYCgLxsmWVqnIXysXB3GhkMOb8zbhL1WZ7SfpR/hjBob+iWuddUwmI9Nm9NWLlvKWSGFYXsKv2p2fm/98OtKVTmfnM53IVygBPsI5Ao+Rr5V+1bzvD4kjlzOHvizoZsA9VwQBGjfDmNpAoLW1VdFsmBQMsrLlSWCJJZKJvxWElxnmSweWo9qbTLc+EotLNHM2okE6H34/TYR8U2/5aN3vh5Uq15ZwqVS3MIcaA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3aa3d5e-2356-429a-0d12-08d584b0eca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:10.8615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1111
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Balaji Pothunoori <bpothuno@qti.qualcomm.com>

[ Upstream commit 07ffb4497360ae8789f05555fec8171ee952304d ]

Data packets are not sent by STA in case of STA joined to
non QOS AP (WMM disabled AP). This is happening because of STA
is sending data packets to firmware from host with qos enabled
along with non qos queue value(TID =3D 16).
Due to qos enabled, firmware is discarding the packet.

This patch fixes this issue by updating the qos based on station
WME capability field if WMM is disabled in AP.

This patch is required by 10.4 family chipsets like
QCA4019/QCA9888/QCA9884/QCA99X0.
Firmware Versoin : 10.4-3.5.1-00018.

For 10.2.4 family chipsets QCA988X/QCA9887 and QCA6174 this patch
has no effect.

Signed-off-by: Balaji Pothunoori <bpothuno@qti.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/a=
th/ath10k/mac.c
index 0a947eef348d..2616b9938077 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -2563,7 +2563,7 @@ static void ath10k_peer_assoc_h_qos(struct ath10k *ar=
,
 		}
 		break;
 	case WMI_VDEV_TYPE_STA:
-		if (vif->bss_conf.qos)
+		if (sta->wme)
 			arg->peer_flags |=3D arvif->ar->wmi.peer_flags->qos;
 		break;
 	case WMI_VDEV_TYPE_IBSS:
--=20
2.14.1
