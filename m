Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520486708-2-12762964451839204354
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
    t=1520486707; b=JTw3cbbdGrvh2GXUvmOF/Pt//jglyfeUEPGGAHzbft+BQIW
    uLqaaNjRiw16v8ezI9RLGFyQzwwR+Zy3LSzYSaE+1UxStlR9knuui+5zENTLlMI5
    o6nxqw7MSJZPjt3wSjsuogtsXfxc1RHHcgR7hgELcA5rsXIcg/TBgxGNof1RGmp4
    GZgjcSfhGnITFID21kTqLNWEWydcbGnZWD1M5P9KqsIcyxzt024+sqxx2nJomLaY
    +wFu05dh+1pJXVwMX9NOTvevG+GbRlWQTUMXRc9xzPfvx+7jnuAQrmnXYzBEm/6m
    TY7eNgfK9fNp4OUqy9S062P4fkYULbXOb4ZQCBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486707; bh=6JjhT0
    6wQe7Bu8/Z9VkbpBShmO0mQn7Zl0qOQ21SdC0=; b=eETib22vziRE8foS0dhrLq
    UsC5VTixsBrXZux9zd4OfGT8ZbrHW4oXNP3wZlvavUCE5JTZB8b9bpC+hUvHLvLr
    mK+zE93wpVF2Bl/0l8M8YJkb5k47RpBxR0qx4xxfD8xbkJGATQA1MS6JJfKX0jMF
    +5uG/ml1x11nc7jto9BEH22OFiKnxNrJ5uvS6DYNonKG37rgYO2xOOFdD2YIyJEM
    ViLKsUaMhI1SMM1yZ9+WIQxvb+aZCrxgBB7A5N6YEKLWcipTbS4oZ7uKkrycaDu7
    4AidLSKqHn2in16weB2j/FqIObkZhIZTXkihJ9wcT6Wg+sqEwCdlrTFF/a6enx9A
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WepfE+y6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WepfE+y6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbeCHFYt (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:24:49 -0500
Received: from mail-bn3nam01on0110.outbound.protection.outlook.com ([104.47.33.110]:54752
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966583AbeCHFHW (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:07:22 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Daniel Drake <drake@endlessm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 087/101] mmc: avoid removing non-removable
 hosts during suspend
Thread-Topic: [PATCH AUTOSEL for 4.4 087/101] mmc: avoid removing
 non-removable hosts during suspend
Thread-Index: AQHTtpqdQJIB2FU8n0OgHFyeRZZHcg==
Date: Thu, 8 Mar 2018 05:02:11 +0000
Message-ID: <20180308050023.8548-87-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;7:wiBo7lcH384ERc5EaI6ek/q2GEXQnXqR/8+FKMuXuZ1Q8RnR8xImtdHkioaeC3LkF/p/+87kgZRdjCrbVPxbrXmwVvaBE2vi7lFd/Lp+X5yqM0UBtrxFEM+s5cRarzKb7jZeNFBdpw1LpX3cThI9XEFlvmm8tG5Yox5lMnZ0w0TGAwYKaSPxsOtdkGotOCkBfnHFokuLHbgahBNoXHjbXCJJnOAQBrPBYOIi5k06l3ukk7u5XGjXz4ZaRyhB1gDp;20:7rUMD1j3h4L0cxQXx5CFBaq8G5MF031TLKCRIr80IaTs8Sr8M2qO5baObG+jX1Z6dRX2uoVKb4Re3U6KT0JAjopY9GukM3xYradH91mW/aEXSsYTLt3tuznjdFRz5R7F+08z78TU/zwFil9Lz7dUMEgZKR6lIuTvj1hGNngnJRM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 42849fc4-d2c6-4231-d012-08d584b27657
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10778846CEE3E4AE3175BAF8FBDF0@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39380400002)(396003)(39860400002)(199004)(189003)(86362001)(102836004)(575784001)(6506007)(59450400001)(22452003)(2950100002)(186003)(15650500001)(68736007)(26005)(106356001)(105586002)(66066001)(6666003)(86612001)(3846002)(3280700002)(2900100001)(25786009)(53936002)(5660300001)(2906002)(3660700001)(10090500001)(6512007)(1076002)(4326008)(6116002)(305945005)(110136005)(107886003)(54906003)(2501003)(5250100002)(8676002)(8936002)(81156014)(81166006)(14454004)(76176011)(7736002)(72206003)(10290500003)(478600001)(6486002)(6436002)(99286004)(36756003)(97736004)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: +sUNayPfLcQT0CXebiHcVtGxX/+k9hE7WNRl8RxwwvRk4zRgo+duO0MJTYJb+qvFa9RcotMeu/U0jpQuj2yCJyoMSjLzWW4PAbWTVh2cPu4zkN95JSAbaug/5s6WviJplylWeHH0amcvWpE/O3aPd9Y2cgslCA2Mv3Ejkhgcr4O2GuFYo5qVP4CMgqITLG+J5TBhJlw1Qyltoyiz6EqM1w0euAQoTxfeq0WB4zaPard5gOEW7PVkNh3xjRXRSBdIJHPtBMahi0j9/WKd1REfvPneMg3mGntzxyfqlMRkbzbBFgDoeCRL6nc/WT5KdVnMdBokpMEIm3H40YI0nvWmdA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42849fc4-d2c6-4231-d012-08d584b27657
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:11.3683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Daniel Drake <drake@endlessm.com>

[ Upstream commit de8dcc3d2c0e08e5068ee1e26fc46415c15e3637 ]

The Weibu F3C MiniPC has an onboard AP6255 module, presenting
two SDIO functions on a single MMC host (Bluetooth/btsdio and
WiFi/brcmfmac), and the mmc layer correctly detects this as
non-removable.

After suspend/resume, the wifi and bluetooth interfaces disappear
and do not get probed again.

The conditions here are:

 1. During suspend, we reach mmc_pm_notify()

 2. mmc_pm_notify() calls mmc_sdio_pre_suspend() to see if we can
    suspend the SDIO host. However, mmc_sdio_pre_suspend() returns
    -ENOSYS because btsdio_driver does not have a suspend method.

 3. mmc_pm_notify() proceeds to remove the card

 4. Upon resume, mmc_rescan() does nothing with this host, because of
    the rescan_entered check which aims to only scan a non-removable
    device a single time (i.e. during boot).

Fix the loss of functionality by detecting that we are unable to
suspend a non-removable host, so avoid the forced removal in that
case. The comment above this function already indicates that this
code was only intended for removable devices.

Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mmc/core/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5f7d10ba498a..299a83f1ad38 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2791,6 +2791,14 @@ int mmc_pm_notify(struct notifier_block *notify_bloc=
k,
 		if (!err)
 			break;
=20
+		if (!mmc_card_is_removable(host)) {
+			dev_warn(mmc_dev(host),
+				 "pre_suspend failed for non-removable host: "
+				 "%d\n", err);
+			/* Avoid removing non-removable hosts */
+			break;
+		}
+
 		/* Calling bus_ops->remove() with a claimed host can deadlock */
 		host->bus_ops->remove(host);
 		mmc_claim_host(host);
--=20
2.14.1
