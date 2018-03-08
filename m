Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491789-2-17645024701806633127
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
    t=1520491788; b=iquz5F0ZIeOBsuI3ot+qFk1bIqGUZKvOOewUm5HsxZ0oZR5
    TZBIvXUo6o9tTisDo7xyaxkLHOMmf2FBMvr1vgC5SuLx9PNNaj1cz+76DMtPolzG
    OCRYPb68f0WzmM41cw/TR1StmRlvKzx0j04zZr889MLClYKdVOsvp+Ms+Xa3LQVI
    ebSAcP7YB9b+51wi/kMKpqPSRwTk4Qo0TxGtayG1GPSPZnbuMmSW0+Q8LOE4IeKq
    XL+yxr79TgEGJY0vKTOLA8pwxrqpseZojSgRT47W1PkSMP/6UmPWM3slJyoRAcTe
    zU7/Wdv6jnkXHCjlhABu65saixBYV7b6B33b8yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491788; bh=4XyhLI
    Ry9Q7rwJkEU3/7sb3exSf9cM8mDZXNFdRpwD4=; b=b/5wFvfwBkOwY7HjEoRWPw
    Vq3DSljjB5lJtR2gP8H+TNT3zmOAHcgGnfAANToSQIYsVPO0tnHmogiefyQvgpLG
    WB3ZpOPUhHP3lry5cPbSLYH4IDJYra/j02h2GCYCmrfJsxfYUusS3EvCvDPNF6vA
    h0ZTwvmlVQq8xMnCoZZJgG3tmbpQR2C9+7OFyUxkIDqf1FPwjfpG66xX9k1nuLLv
    hp0TFsw8IqOQ6l6q331fnlgh3+Dmd+lBwkgkocHUtKW7SVvM70z4UzSqV9zaZBpm
    YrkxTyz8qGPHDSDNoWicz7VhVjePKwTsnjUZpOriJkU8BZKdRs9Ryo3Obr1XYYFg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B18d5SYz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B18d5SYz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965183AbeCHGtW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:49:22 -0500
Received: from mail-sn1nam01on0120.outbound.protection.outlook.com ([104.47.32.120]:33969
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965075AbeCHE6P (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:15 -0500
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
Subject: [PATCH AUTOSEL for 4.14 14/67] rtlwifi: rtl_pci: Fix the bug when
 inactiveps is enabled.
Thread-Topic: [PATCH AUTOSEL for 4.14 14/67] rtlwifi: rtl_pci: Fix the bug
 when inactiveps is enabled.
Thread-Index: AQHTtpn60EU5v5Tz8UWACyiHGylgeA==
Date: Thu, 8 Mar 2018 04:57:37 +0000
Message-ID: <20180308045641.7814-14-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0888;7:QsPppAPq2YnLP9wx6Wk3f58+mNqUwlPEVglbJwY+CBXwbaWQF/3GV1Y8m+Y46TtvEjeHkIxRULLV7vKjLbQR0siBTdOIKrjKbqaAPy0SB5XERFjKAPY12gcR8fPJCc1uRyT7dvZtQWivKsE0831Pkh3zvlvzDl6koL6M0MXkPrtFt+tXmF+5KsAzaojtZcW6bqN+31do0xejjvIjfHkmkiw+A++ej1lC5yHay7i7IUuNiXtJcsSrCbtharPLXvDp;20:SOMcA4/97K2YYC8vMXf4mBXfuUJwkRGNLe82vkjBgAzUJ6zR+Mt3WqoFXGezjFDunzGoDaexUNhvaCHqajpgO/MS6pdppq29bcN8LS8oo+h5As3YZK+Vo7FvfNgF6INRLUc31ND8rR3ZGY5Eo7tMkc6YyXkSmuTDdqsPg8z4JLs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4bf6461d-04ac-43d9-9b4e-08d584b130fe
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0888;
x-ms-traffictypediagnostic: DM5PR2101MB0888:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08884589226056E54B43793BFBDF0@DM5PR2101MB0888.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0888;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0888;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(39380400002)(396003)(189003)(199004)(6116002)(99286004)(2950100002)(6512007)(6666003)(10290500003)(7416002)(36756003)(5660300001)(106356001)(1076002)(22452003)(3846002)(97736004)(316002)(53936002)(68736007)(105586002)(4326008)(25786009)(54906003)(478600001)(2501003)(186003)(66066001)(76176011)(3280700002)(86362001)(575784001)(14454004)(2900100001)(5250100002)(110136005)(305945005)(7736002)(72206003)(3660700001)(6436002)(2906002)(26005)(6486002)(10090500001)(8676002)(81156014)(107886003)(81166006)(86612001)(6506007)(59450400001)(8936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0888;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 68gBqouG02TocGiKdj3eEH8rDXiewW3QsYKbU7JNEP+sKf3WmAuVRD5TplpUYPcF8f5C+kR+eneya5Q8kY3RiukbUjJ0gTIFan6p7O+MmHgJ1lN1O+2/rAzJ3IL+43yxr9/yucQy+9REpTmMiykKL/eA44LBMbbY1mFIXau6ScX8NJF7CIvV/OaykGXqexuBBB4hEwyc0kt37u9i6YblquYpqwdUeJqyxecu0b7oa2GBCtJa618RRcsJ9grx6+U1EaKCFUpPzcoMDxtuNulYOnfMwn/X33F0IaeO8lM+C16YzUU4cRhLUs670ca0syHqeW0pGELbFVB8vaELTGzOAQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf6461d-04ac-43d9-9b4e-08d584b130fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:37.6741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0888
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
index 08dc8919ef60..d7331225c5f3 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -1568,7 +1568,14 @@ int rtl_pci_reset_trx_ring(struct ieee80211_hw *hw)
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
