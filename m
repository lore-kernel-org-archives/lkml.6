Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491664-2-17383377809016605700
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
    t=1520491663; b=svzakJ1UMgRstYWnLpY8xG9RXKPvYnHrtPI9nmUrGCnS8uY
    566Ajq8PYmap74RPGPVzBfqNyvOxnZeXDANbJ3c8scie9HrjebZMW94Z4M1JfrT5
    wn0dm9VMEB32Vb/ic/YyYu+b5nRYDT3DzBG8SIVu70V2loSGJSNPCqItKr4/7PDo
    rh+uGmB2s9yercXjCOncOf4bl7RbSWsvFQ2Bh9o7wN5bs+w4VhWyGhNzZSf5T9Wg
    ixXOmckSQgKnOUqrCWM5spCrkOVJpma3elOJUJD/0fiRsnnvgIUBztbGoSBv5n+g
    OWSpuA5cVUZInn1lAbudkIAfj0YcsuDOB6VQXyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491663; bh=E/OMy+
    9WnUASCdu6J7ZMVqtMR2FSl1MLVJn7w8GvDX8=; b=oj7sdtW2DHhUHB3aKT+fn7
    EMrv6LGjKg0fCS+xWWNdeF5a5nkP8anrAMKDhANX/JkydT+WJN/tkZdqdIHRKmf3
    zvvg9vViMtQEOoRqqdSL0sgbfz8SPqsK8gxrfWA8xrKWgLUsPr62MU4VqXf4HDYR
    R1c4ZzYzKTgNMNTdH4e7g4zx4AU2/mZbJe/M/Nb2ddXUoX1SylemTH+H3+OF0qso
    unvxdbVDa/aQbgLVP2m7/I1MOwGV15BVPUzfEQmFxrJU2RKcX1+aFbDPYX+Q6L31
    NWoSQ6klaI1wC7e/b0czbnUiiMYt5NExuW3XA0Br91F9oXzL46qZqfs3UGhsPLRg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZvaAJtWi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZvaAJtWi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965269AbeCHGrR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:47:17 -0500
Received: from mail-by2nam03on0121.outbound.protection.outlook.com ([104.47.42.121]:43475
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965103AbeCHE6V (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:21 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Daniel Drake <drake@endlessm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 28/67] mmc: avoid removing non-removable
 hosts during suspend
Thread-Topic: [PATCH AUTOSEL for 4.14 28/67] mmc: avoid removing non-removable
 hosts during suspend
Thread-Index: AQHTtpn+Fl0M8yDXhU+ejPYG93PVig==
Date: Thu, 8 Mar 2018 04:57:43 +0000
Message-ID: <20180308045641.7814-28-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:zuqU/DoFZzjo83xnsnO/vPYGAGjYhnetaTTEyr0Hefh2Y7LP0zdowgKTX437AJQrTV+EuAbxB6/UKpNG1q21Zwi9+IBftLHdG7n1VIqrmvFwtsakalz32A097ipYVO6LuOji0iAqorL3CGqU0EouP5sNCQEFXLlRBEeeak+zbqctmfWaiIhqvR+zP2+Wm030BAP8ywRleT95vmg1yRxTCIGreObuDc9P/8MHyz49KaGf3s0c4EAfw+iXda9V0BQP;20:rxQPZtfQkecu3H8E2xYaL3JqXQpJf4f0DeNEA1AlnKx1p4ZUzFRI4hFmKxr9UWuqtlgQH/DehFlQf4jZG/6VjeInMCCxW1ywTczv+i5KbfMVtjUPizP7GzuB3mafErkHXMc8P0IPvBIuWaE3J2HeQA3rriU0V1EuEbQppPK2c8U=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5cc70b80-b60e-4434-8bd2-08d584b13502
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08857BCAD69D5E8EA5B3D77EFBDF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(305945005)(10290500003)(14454004)(2906002)(6116002)(6512007)(3280700002)(1076002)(7736002)(86612001)(2501003)(99286004)(5250100002)(186003)(3846002)(6436002)(59450400001)(22452003)(6486002)(26005)(53936002)(102836004)(76176011)(72206003)(478600001)(36756003)(81156014)(54906003)(25786009)(97736004)(105586002)(10090500001)(316002)(107886003)(15650500001)(110136005)(4326008)(575784001)(6666003)(6506007)(81166006)(8936002)(8676002)(68736007)(3660700001)(86362001)(5660300001)(106356001)(2900100001)(66066001)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: dFkJ1YNIueR1nX5QvIY6U7fhyVGsj/e5uWhrRGGbCm8oLqV0gGnWvubU/mQq2SCZPEugtXyy0siHmTYO6WepmjijzYP1B3rLhVO7s2SUfIbBL5HxtBLPVShrENGrSq5kVYoYgQavT/ELiXM70tOea/03MOOzb66r7n0d9U+Pgy2xbs4l6+VfZLkF1M1yzrBz7MzRBk7rZZol+sCkCmxw6WuFn2THK/xykgHNqHyZtTWBGlg7WDhIozOAecJkukYTqWizP8c1s5bUmYx94m+eyQRtaJDUbeKcgJkt/mol+bUxQwCvAqrGZ1Hf6oAjCZl9bL/sDF/okTYfLB4VSDuxyg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc70b80-b60e-4434-8bd2-08d584b13502
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:43.8774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
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
index 66c9cf49ad2f..29bfff2ed4d3 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2751,6 +2751,14 @@ static int mmc_pm_notify(struct notifier_block *noti=
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
