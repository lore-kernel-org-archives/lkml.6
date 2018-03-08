Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520486733-2-17086779688026394429
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
    t=1520486733; b=bVggvzdYnTS8pN/D1wecdPUIb0iIJLqXGNYWpPLNxw4Udoj
    NXmOKHyObun/Mi+RpYROZG8/MsWEHIUFGBPlCReFtmbqLCXjTvCTgOv2XVz56FFB
    mSDeU8K2uvllscfUWUtiGOGrEs64Tkk94C51RgTALaHdz7N97BkFAf+jVB8Fin7+
    87RMlVfMz2dsT3zAw4APDWVzy3LbLZATh1whDE5pQEjUOOeFQ9aT5two3rDP5WnA
    gT1gSlYuQWmQ/z1982msuw3zv/lP+OF93FsXd1ANtH4yh6SN7wGsXjncrHi9G4QK
    3wU35ypcjBo3Gjx/GxyaToQcBRxxYEOWPQoMBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486733; bh=tLVQ11
    laLWYY7z/zmDxIKCxMU8UvqQcg7MfAad2xh0E=; b=LtdOePUooGEFvfPgoubyP8
    gZu40tpZ4q3d680Bc2BV5lPRfw6N3YM+I9XyFeI/KEPPoXvhAG8NZA+ig7KrzJzT
    s8qM5ovYwgHdUjDzkf9PXxm/rPG2i7hyNJSQtreoZxhAZZ92yyNGCrKlNWsfUzah
    6/Jk6655mSAGd5G2UbTrCgsr6tmOe2BsdoqwPJ331qaM3DeiC+A6+hniFtcNteJz
    DRKdboLh1X4btj+ehACYlhfIfdsazTUrE4tuztTGdnK0p0otnMnMOM03p0VyFDa+
    QzRV9q3OdpSN2IDb62482k4pFSAl8Y9HE0G/Ju1S9C6MPgSRdqlyuv+HsA/cKHMQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Fp4Fl/d4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Fp4Fl/d4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966590AbeCHFHU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:07:20 -0500
Received: from mail-bn3nam01on0110.outbound.protection.outlook.com ([104.47.33.110]:54752
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966583AbeCHFHS (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:07:18 -0500
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
Subject: [PATCH AUTOSEL for 4.4 082/101] rtlwifi: rtl_pci: Fix the bug when
 inactiveps is enabled.
Thread-Topic: [PATCH AUTOSEL for 4.4 082/101] rtlwifi: rtl_pci: Fix the bug
 when inactiveps is enabled.
Thread-Index: AQHTtpqcCcsGcoQfJ0eGCY07pi+xqA==
Date: Thu, 8 Mar 2018 05:02:09 +0000
Message-ID: <20180308050023.8548-82-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;7:byFE+ISxp1Hs2LiY84ueHJ9H17vaKwsl1oFM60DmO+SWvmYeCNz6MUl8ZFWCb1cD1M/cMzedXwmpwAeJfVy5KpV6X2E2xSOTCVrpMOX2H/ujJkJScDf+8BhFI97cQKiwJIqgWgGiNthn4rJWTfJBYNDxOOqNBYVY5h5aPr52ALcZdt9liLO/uDaj+vrWbv0TZV5I4E+k/3PsTcu81SZbLhfQjHCNBz8SJWQseCt2AM0EK6BvrhnJxZknLA7N8nzD;20:mMEjAxf+set01Rs+2Lo1kdRrrru/GaFxX52y3Ux732nImbi4Vksbwg571Af3n32ZWBSmc0QHuqvbW7+w5sA+mqhWR+LPsFuavY22Eznp+TwkDbP28+Z4RmbnSe0ldRChQQiCSThX7JH7A+NMRjLrHCmrmpJLGPe2Sx/B7ZND5gQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b251e24b-8998-44f1-2062-08d584b274f1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1077286F87A3CDF2E01F19F4FBDF0@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39380400002)(396003)(39860400002)(199004)(189003)(86362001)(102836004)(575784001)(6506007)(7416002)(59450400001)(22452003)(2950100002)(186003)(68736007)(26005)(106356001)(105586002)(66066001)(6666003)(86612001)(3846002)(3280700002)(2900100001)(25786009)(53936002)(5660300001)(2906002)(3660700001)(10090500001)(6512007)(1076002)(4326008)(6116002)(305945005)(110136005)(107886003)(54906003)(2501003)(5250100002)(8676002)(8936002)(81156014)(81166006)(14454004)(76176011)(7736002)(72206003)(10290500003)(478600001)(6486002)(6436002)(99286004)(36756003)(97736004)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: YMVsXFDGH4Dxv9u70M9YyknkrHdH1p5ghkuuByzZ0Erb/wXaJ+WhgEYpd7/MrRtAbXkKkm3AMSidb63eR8XXQxaZLzB0hzXiGDDlhFzIAski2RBlPBKvvgZ3nkdsjXkiAGmNuj6xXM25yy5iWGdIM9zYek0jWpjdxwn79cxJALyfQ9YdJYcuAeKPnelCwrtg0m865GgQtb8jCAYu0AFxlry+5+trHNvMb0aks1OuN2hR7YgexhmryIdCZQY1CmW1uKth9yZfr9Yj5mJOD92sv/KvtcTEIlpkYGQbNr/Yp58RK6JKJPGZxJcYOQMg0cXLyTwRqQofOE5vwCLAZPpoeg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b251e24b-8998-44f1-2062-08d584b274f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:09.2508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
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
index c48b7e8ee0d6..b51815eccdb3 100644
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
