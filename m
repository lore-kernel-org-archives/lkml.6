Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488315-2-9436122668766288480
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
    t=1520488314; b=VHP2w/hc9JDUyicPJUv5lYPhMZFqVmlTAvP6/90QiyTDTtp
    SFbPABqw61EaR5DKNQ4tR74QKuqidY/sKn8X7IDM9EYGgIB4Z5FcsL48mQn7XxKe
    llzj+ZR1ryFs0qZgivJxcptRBBHd+o1Kv3PEFwBRWomS8My9Ump/yP3S9QG3J/50
    9XzVP0hlblJb08Zc6YYjHkubDVJCfWq1Kjm+Ju2w6UCSX7WlYe2wRsTEiC3oFKG7
    yeGaMcYUsAgnoEpa688t3L0cc/iI/ncUaxQaMlJpmBzzjZx9DTNIrY2PM9k1rv16
    J196/MZzPkTDeTXwbUFwPeYgymYaPW99HW+y2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488314; bh=xnhvZI
    DtGJA4MSTFKFPeJIQUbRz9bTmXcHt45kVHCj8=; b=eYnyX190Mh0f+LTzBXpHjT
    BSOdMOmORHS+Lry4bMKpYJbWRAGg7z9lSakhW/7bOy+Ir0rT9i7bajhysaf9tgd6
    qrZbu8JtTDkim4j56PygQa0kZMVISLNX4lqX+/czqNacHV288Bjic3ZeYWpBd5DA
    fJU0UqySjksaxh7wKUrdoJu56P5JYg5bFY7I6dDsQfMBA9b4pidxh9zvpqR1RlP4
    BKn2SJcLeTuWp38M76qb3N83o1VQAy5ZmhwyWtkbhp29poJeyRhfHoSLKGYxd43S
    N2Jmyk2GhlsMmQy+qcirULx5I5vv8hgn2exr5vOOwC+Hnl+pT5rrZdaRP1JlyKbg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OiaaC+7g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OiaaC+7g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965688AbeCHFvh (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:51:37 -0500
Received: from mail-co1nam03on0138.outbound.protection.outlook.com ([104.47.40.138]:9600
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966155AbeCHFEP (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:04:15 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Daniel Drake <drake@endlessm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 169/190] mmc: avoid removing non-removable
 hosts during suspend
Thread-Topic: [PATCH AUTOSEL for 4.9 169/190] mmc: avoid removing
 non-removable hosts during suspend
Thread-Index: AQHTtppTQQ/hGwexy02Ce3JlkCREKQ==
Date: Thu, 8 Mar 2018 05:00:07 +0000
Message-ID: <20180308045810.8041-169-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:eqCwBteut/i4XRMhbban3p/dbwCowxko4EfZyKicm5bzXravBO/GMprMnwi4FFiMo+LZole76s1OjY+fOK2pMD0ptcMhh6O4XVVA8pRpsEmT+u2iptxpA4KI3X1uVKpq2aszP0y3kWHRDo1JQYOuZPM5uhpJo3uHaczIEgIHK48MuvEvqpsrDC8oZwGahrG6lTLtdRVkENjeG3zHjN9ZlAMFX3B2nbdDLS70CkTvhA5pbvoxRpwASpGqH37b11J1;20:GPS3d7CnBV+jGxm30y6cFyJIFVWFrXKVaoXl/Jiw7SYnsuLi+6huFjN/payHh36XciFqDLeF3BRGG3h79We3hz/DggrKcDOEErWs+ZGDStXgjkyomDFdQTVFQoD1RPneVJkBj/MlfM0fXURryUQ7C8Xvpj9YUAO1XoQ77xHWHT0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3011ec0c-5d7c-41e5-4259-08d584b202f0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09190D1A73A1518CD4D623BBFBDF0@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(3846002)(305945005)(2501003)(26005)(6116002)(7736002)(186003)(2906002)(316002)(3660700001)(5250100002)(8936002)(4326008)(86362001)(575784001)(76176011)(107886003)(25786009)(5660300001)(10090500001)(66066001)(10290500003)(22452003)(3280700002)(36756003)(86612001)(1076002)(478600001)(68736007)(110136005)(14454004)(54906003)(99286004)(2950100002)(15650500001)(106356001)(6512007)(2900100001)(59450400001)(6436002)(6506007)(97736004)(102836004)(53936002)(72206003)(81156014)(6486002)(81166006)(8676002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: kLQb3CtvVtk9/NufChPJkmtSofeCSs8ykf0LR0wHDo/thI6oUvrruf6wR25STz7CeZ3iJjxOcIaCDmp5JZFo3JfUP9BRjD+0nKRmyp1ILAsVvYnt4R0o4ZXk28ZuJ15msjHfBy1vWP+iI5BDIngnrq1rcyUuLbqAcb4hq+QZEuN72/2f0/lWeuf3X4JVNI9HC9EIsw6f4WvNvke2LfBzissjiTauVCsJG+qByZGuNZaTfJB2aT0sTuaHK8lrUzqOzTK4zwjnD2ofh0yAbBLjuC0VFsJEQZjNSntfkSwAo5iOgZdQ7rWUTdLabYJ9UwTzGxSgy3XRpbG3P0mxZslZpg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3011ec0c-5d7c-41e5-4259-08d584b202f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:07.4256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
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
index 2553d903a82b..cff5829790c9 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2974,6 +2974,14 @@ static int mmc_pm_notify(struct notifier_block *noti=
fy_block,
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
