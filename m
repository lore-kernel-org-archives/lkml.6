Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488425-2-12978132490113888669
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
    t=1520488425; b=bck2Irrd6EP1z2rosNIY0PwZpRLhNifQib8VJutkxvIBwwB
    CIn1UXEM/xsP/v5PBMiB/UKe9w9H7jTOfoMDKlCM0xDel+9qrfhJ52qI3tetQhIE
    QotWslmQgaPuzIBEjmMf+kp3FdVxLWKMNOMkfjL7dKdfYLR5xQ4B7kSwofuGa/6N
    DUAZlbdoIEmk5yEMGBlhbMWFtro4p+7IxeM4Mh1MJi6RBsFuo9uX5wCQJlzdPvrb
    gSSA/dP5QyOyRnrkGZW4L1vJqIjhWTcc//7ngQjTLQId1QypvcXW3zGWEIaTjMmN
    mpx4sVKMB2eU1SHduKOG/9JchVgyXGJDPFnn/ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488425; bh=tKOCGQ
    OQq7zMLUYAgNRhgCJT41QivYvqHMqa7t6gS2w=; b=kZzsfyqGCWNcrp/8iuYuf3
    CUG2n3xFHdMKc5XsKfGujD7e9CqFLRBH8vUhOhCamt20sLjL9Gu3Yf+8y8Ue3MyS
    OwJRhVpulOh/NLVRDrD/52nGlzbH7mkFY0RVFTl8B1cVWxKOem4inUxhDsQDPyJK
    BJt2OW0E9wprdLNC69wYZ00lMtcBK2GWBnYsuUuZcon1nFtGJCmendDZ8bvqtXdA
    EbC9yB1/ldJ2gs6GtRuogfcDJlYscDy3JCUkfaEQEl4pAd+F1DOKyPbqsqles6et
    d2sWtXwz7C4IM8Ub5CNSBq/OT4O5WsmRrhsxZfQf+8qANFKu0XEKVNkGuUHozTxQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=U4FJRE1K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=U4FJRE1K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966255AbeCHFxI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:53:08 -0500
Received: from mail-co1nam03on0090.outbound.protection.outlook.com ([104.47.40.90]:13700
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966115AbeCHFEF (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:04:05 -0500
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
Subject: [PATCH AUTOSEL for 4.9 158/190] rtlwifi: rtl_pci: Fix the bug when
 inactiveps is enabled.
Thread-Topic: [PATCH AUTOSEL for 4.9 158/190] rtlwifi: rtl_pci: Fix the bug
 when inactiveps is enabled.
Thread-Index: AQHTtppRjJTcrBRhz021p7XSMk6Axg==
Date: Thu, 8 Mar 2018 05:00:02 +0000
Message-ID: <20180308045810.8041-158-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:Pt+inNRZ23EJr7FWszVLxR+gWnPyrZXCBmQz9divpECkjspbS47/ix4wlikpAGhp/ZmimaPPUyBCIAwWhdFcEsKunSOx3hc8kEcIfFB/L2tV8i5ywRJdmLIZyhCSJAaSFf9Q/sfxYZxsa8UAPUMOSr9X/blP/Kkbz9W8A/nEmPK0yBee7JNaXeWtLuw/K5Enr2puuYGCgwdWkn4/YZLFdj/jPLpn77UPZpnYZX6fq3cPB4dn2EIM5NMQOs749t4J;20:kMtvhzwuKXEkSHg+QR+DuoOHofZ/SGsNmgdpsNbpER9++ydkbHRznYCPCqmfJaHrYiLMFU8aSYMtyabox/nGuUvhBOIw3U9Zxd94OhtKwUo5MqMBmOFuwJt5iBeeqqJWKtQ09aXNjdpgZk+sxW20dZ+oJHgIQL3CpJ0SzG0w7rQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac911701-383f-45e4-06f3-08d584b1ff6b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919068DE46FF1D215C3866AFBDF0@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(3846002)(305945005)(2501003)(26005)(6116002)(7416002)(7736002)(186003)(2906002)(316002)(3660700001)(5250100002)(8936002)(4326008)(86362001)(575784001)(76176011)(107886003)(25786009)(5660300001)(10090500001)(66066001)(10290500003)(22452003)(3280700002)(36756003)(86612001)(1076002)(478600001)(68736007)(110136005)(14454004)(54906003)(99286004)(6666003)(2950100002)(106356001)(6512007)(2900100001)(59450400001)(6436002)(6506007)(97736004)(102836004)(53936002)(72206003)(81156014)(6486002)(81166006)(8676002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: jEcFe0itqGOCNk9E1Gww3ZfmnPplDv9wJtz5iIa/lYy4IoLkzcgdnuUFB1m/cIC4IzlvUoSCyQIz0elr9zM3svTUacchzeTyVAkMJY1I5U/FMP/Diwp4nS8GPEjdWm8Cwloo2YSaDxNPaYpxMEzu80jW4LX1rSfXMIz83supnLqDE7fE4ncqU6xtFcZw6EDXQB0uS0IIfDFJArOp/mV1UcmxK3rQO3b+gvK0IFSrU/e0atybxrLRBDiVJ2Heio7ypGUhTrSn9tIBQLbSfr9FC4WHEs6LydUNpWN7DX0EgQ7hOzWoja2BfqYaC/xwsARseqtjuMgM6zYblAbV3dxnEg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac911701-383f-45e4-06f3-08d584b1ff6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:02.5762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
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
index 75ffeaa54ed8..e15b462d096b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -1572,7 +1572,14 @@ int rtl_pci_reset_trx_ring(struct ieee80211_hw *hw)
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
