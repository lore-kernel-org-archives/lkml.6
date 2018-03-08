Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520492704-2-2009094942775422639
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
    t=1520492704; b=hJ8nc+b+JwO0NELwmznYzTedpL/hDPa8LHL5Rx1R/Pi+I+X
    CtgspLAjZ7aRK/tT1y+aHjfwr9K450cITh8HWN0M6DScJLa6A3w9A0XjFSqPZBAq
    pysThwAGb9+c4mhiXrvmiNXO09FIRpuicA1oE10MFx5esZqPuW0NW7ZxtMpl2SnL
    yQKNrTax7fuNXggFpn4X28O10ELcpm+67AYrbrDyth7ti+RZnM0jyM34vqco6W0h
    0D/5l0ilM7t5xF26grqXPAGp+sWx7OQyBSxEzMAslUh+pDCNznK3eJJYM8vYDNxI
    mfVN1zKuxUPXa8/wrdPDHJLZGQ1KivxoG7f0Ikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492704; bh=elanxn
    A2z4eXclXOlsZNwwVeA1Tgd4RmwkZmfoqc47s=; b=XkH76SBa4TZB7WTUdSJbdv
    1KjxwpJ+mmKpfAoGG2U0eOwajdxc9hCdlWIrRSzs/gl7pHCjpSDBufLcOpTEKFtk
    CLEIBINtUZrxqmx7n3GzGswdQCKLIbPMfDGVRG0ApsKIDMqm9usDyR2j58rTk+A9
    11LKJ2PIhD1TKq+zSCbrwz4vXXHOzjxxcg4ZgHYAO0WejTyMajj9ARXzLW56vsia
    9+LpDtZL3lrmEVd2eZwqLV6HOaUN7daDJpa4UfsCVJZIFY6+TnMXX7ZFbO7s380G
    3jeIFVc2ZOzhGdq2T0475xrN8B7ga4T1JjtiMK8qeyNuGl/FbEx+iHTimSRfHGmQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Kq839Y0m x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Kq839Y0m x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935058AbeCHHEH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:04:07 -0500
Received: from mail-bn3nam01on0102.outbound.protection.outlook.com ([104.47.33.102]:13054
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755300AbeCHE5F (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:05 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Daniel Drake <drake@endlessm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 33/78] mmc: avoid removing non-removable
 hosts during suspend
Thread-Topic: [PATCH AUTOSEL for 4.15 33/78] mmc: avoid removing non-removable
 hosts during suspend
Thread-Index: AQHTtpnK8k3o0cj9JkmN890GOvpr+w==
Date: Thu, 8 Mar 2018 04:56:16 +0000
Message-ID: <20180308045525.7662-33-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1079;7:oB0p6FyoniI5Wj1okQmHctuUkPjZthTJZBBU9pKq5ui/vPtJraRsViIvY9Iw/VOP1//FIZAhuU8vJIDrvwdIMemZz+xF0sOQHRzeulefW1xN+toccVq8DwwDQ34Q5waoJcQ7/vxhbc0vB2BX0HyARBu/CkWLb2N8CYmtANZrXqBr9l1q//sU/Se08HOcCG4/ET+i9x3uxPdrF5GNTdmJzyIztNd8KvHECaSIzIvj3QI8NG9Aw4/nK+y4SP4UxW8f;20:iMRP6MbtkJX75tLSBmarsq8aL2I2DJC3TLjsCTg7A3eamDQAUSipchK4DNJJrSB1e84/IJJQ5T60NZMVDQDm0SmJYMvvhA6WTXIA0vPWChzvP4d+kywzOYlNowXX88BzOrrsP/NimaaPhCOcO/HLytH2nzQWLSAjIcE2hmbpkm4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a69ee051-b14c-4934-0a75-08d584b1085f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1079;
x-ms-traffictypediagnostic: DM5PR2101MB1079:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1079E8CB2D2101BF16A21B52FBDF0@DM5PR2101MB1079.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1079;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1079;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(36756003)(107886003)(4326008)(97736004)(2906002)(2950100002)(1076002)(6666003)(105586002)(7736002)(186003)(3660700001)(5660300001)(106356001)(305945005)(6512007)(3280700002)(25786009)(14454004)(575784001)(86362001)(86612001)(81156014)(10090500001)(76176011)(26005)(99286004)(15650500001)(66066001)(102836004)(110136005)(81166006)(72206003)(54906003)(5250100002)(478600001)(59450400001)(10290500003)(6116002)(2501003)(8936002)(68736007)(53936002)(6506007)(6486002)(8676002)(6436002)(3846002)(22452003)(316002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1079;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: CRKg/7Rk9FR2YS8sj+RlKcJkUZAG2fh66DFgJVnFjgQwev+IA4pf9z8FYpHQxH2xoQ3kTX/y5XVZ4zJM9cAeBDBr4RPUTje7atctFLKbZ+TCJuFsPM9VKxKP+/jf3946TSp7iTvT8sA/HVBufQUeEtE1ir2TmzV9NGEth4XV7z9Od6+WCIdRgBpTnd1a5TY4arn5a/JnV2dHlaMS3M+vNP6uSxNqaWeKUkR+suUcDrHdaGO9KgFYVMbBRocTDbfGgoVtZP21XJ4d0CWH7wXErVhuodm41wOX4u39yDeqv8IRgg7ABg2eH++PXlDhRyMk3owm6LyrmgqOnx94zim6Rw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69ee051-b14c-4934-0a75-08d584b1085f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:16.0271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1079
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
index 1f0f44f4dd5f..af194640dbc6 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2959,6 +2959,14 @@ static int mmc_pm_notify(struct notifier_block *noti=
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
