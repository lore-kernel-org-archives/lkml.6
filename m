Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520492845-2-5957756009741974957
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520492844; b=DWOFLpBpl72ShsTmc5WENdGpEcGTUlYSlX2j6VmeZXs2w3U
    A6TftxHZ7ksj/cqVrzBmIi00VRYFSYUYT4Dxr1ZsmHEgUj4yeywbVQd/yDMGxHgS
    Q4xvCPubXXUTB6Nrt+sA8jz833XlrSoTfIsDYvGVKHsgTrEe770SQq7evI25Hpjd
    TUCian+dkmjWSWHxYuZh3WzDn2jv/rVXPQMK8jEVnwZ65fMzXAHfdJvSW8t4UhdC
    zs+c4LSbyjV6cDg1W2/Mk10jw03wzzRZeCTUMkKuNs/4lgutE2JP003fIEjPyGiO
    tdduPIWM5MEm9PLV9Mtul7p/GJsDsMfbPJyZC/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492844; bh=B5b02W
    3Jjm+hXRN9EV7PWnr3PNG9wHu7mkKRj6Ybjqc=; b=SlenSsK2m8Rn2AAeN/2KYU
    RDRV12ScSr3n1b/g7EES0NLv5pXS0Wmy8jmvVNuycJeOCfiYYaDUM77qK56Ng07K
    opp2kcuqcB8d70UAgFXS+6YjdWhQGza7gvlmaYwppVI7Uda91RwUeELpU677eX5q
    YixSMBDr+Nf+vpNUEspIh11i8T15YQWCkwi/iZP+i8TNMUmkYtzbDPJG5UieityI
    FGyWWHHpX3G2ck6PL0RFjsiFvg3T/dcElnIHHo5D/8nAk9g78ZObkur7HLN4vK2W
    KKceyp+0iwwcq0uaNlMhTBeGJ1gcbeGwZYQtZSSRgORPOHhbvm68RYJO6u9U2Rbg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ba48fV6P x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ba48fV6P x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934431AbeCHE4b (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:56:31 -0500
Received: from mail-bn3nam01on0130.outbound.protection.outlook.com ([104.47.33.130]:45246
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755187AbeCHE42 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:56:28 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tsang-Shian Lin <thlin@realtek.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Birming Chiu <birming@realtek.com>,
        Shaofu <shaofu@realtek.com>,
        Steven Ting <steventing@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 19/78] rtlwifi: rtl_pci: Fix the bug when
 inactiveps is enabled.
Thread-Topic: [PATCH AUTOSEL for 4.15 19/78] rtlwifi: rtl_pci: Fix the bug
 when inactiveps is enabled.
Thread-Index: AQHTtpnGmFK7VJZiIky52NXqXinzxA==
Date: Thu, 8 Mar 2018 04:56:09 +0000
Message-ID: <20180308045525.7662-19-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1111;7:tgGc/G1YD8Qz2iqYXwu3v6+POnO+/Ef8+KKwOK38XlOz5W9VGB4GBzgjG65CwivVJRkCrexMpA+VIzKo7imiBGiX+XsfxPa1nJV3oamEWzttySp1QFoRHq41GTeg1gE+0uaFaKLjIWo0oo5oAMEwspCQvLfg0zb+P8YqPk+1Clwi0LEX7Zvs/P8cd7SKdJ+GQlZAM87Y9T1/BG4MiJx6EzOf3PLfcTYfvz1zP1xA0BdYVjOJ7QIiuIUbdHx1B2ZP;20:dB8RuUyavbMg7Mkhqc8H5RUUYXCKIYoVC5Cxskm7AvOLsEduIT9X8xgWUPP3b9jkTOhx8Bw+Ux9PU2ROThyG6aXQcDiry00PonETseq4v2K7d9JFf9rYwifywgZV20Xh16TK1q/oVfU3c4n/Mr0WYDjnQlOVMCpIE413Kqy3b3g=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d62dd738-8343-42e7-cf03-08d584b0eb49
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1111;
x-ms-traffictypediagnostic: DM5PR2101MB1111:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11111F3F7A4C0A35ABEC9A65FBDF0@DM5PR2101MB1111.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1111;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1111;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(376002)(39860400002)(366004)(199004)(189003)(86612001)(22452003)(99286004)(7736002)(54906003)(305945005)(86362001)(5660300001)(66066001)(6512007)(81156014)(14454004)(53936002)(2900100001)(10090500001)(1076002)(110136005)(107886003)(575784001)(6116002)(6436002)(3846002)(7416002)(72206003)(36756003)(102836004)(316002)(3280700002)(3660700001)(478600001)(106356001)(6486002)(76176011)(6666003)(81166006)(10290500003)(4326008)(2950100002)(97736004)(25786009)(59450400001)(105586002)(8676002)(26005)(2501003)(2906002)(5250100002)(8936002)(186003)(68736007)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1111;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: n+lrtHJrM3OsOtLejolOX561MXxjIM/ZKuyMHfV4tlCvMwTa8j5Yxg3EsN85tcqsou6dj/iaGi1HPfKSlxT5y3c/9UkucebZYEsa7nXcY4LbsTRMOO8M2vM3/U9hB4TyYcGWkqM1UWk8i3DWNoQVSpx4sFi/7eUrP2sMFOw56CZqiQDxuvQj3/rCfwZfMB+LTJsBNW1XDsgOpqEtMpmso3tQBFZLilfehmTFTFI8+XCYfyuayh+ycBAKUmzYXHRL8YcWJ8xJgg+l2DLKMXwYS964bpH0C2fEgJix4GkPR8f2ynuR4acEokAJQgPzV1c3qlo1B01Q8jmRe8S3bYwJ6Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d62dd738-8343-42e7-cf03-08d584b0eb49
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:09.5626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1111
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tsang-Shian Lin <thlin@realtek.com>

[ Upstream commit b7573a0a27bfa8270dea9b145448f6884b7cacc1 ]

Reset the driver current tx read/write index to zero when inactiveps
nic out of sync with HW state. Wrong driver tx read/write index will
cause Tx fail.

Signed-off-by: Tsang-Shian Lin <thlin@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Yan-Hsuan Chuang <yhchuang@realtek.com>
Cc: Birming Chiu <birming@realtek.com>
Cc: Shaofu <shaofu@realtek.com>
Cc: Steven Ting <steventing@realtek.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wirel=
ess/realtek/rtlwifi/pci.c
index c2575b0b9440..1b7715fd13b1 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -1555,7 +1555,14 @@ int rtl_pci_reset_trx_ring(struct ieee80211_hw *hw)
 				dev_kfree_skb_irq(skb);
 				ring->idx =3D (ring->idx + 1) % ring->entries;
 			}
+
+			if (rtlpriv->use_new_trx_flow) {
+				rtlpci->tx_ring[i].cur_tx_rp =3D 0;
+				rtlpci->tx_ring[i].cur_tx_wp =3D 0;
+			}
+
 			ring->idx =3D 0;
+			ring->entries =3D rtlpci->txringcount[i];
 		}
 	}
 	spin_unlock_irqrestore(&rtlpriv->locks.irq_th_lock, flags);
--=20
2.14.1
