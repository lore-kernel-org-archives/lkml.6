Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240205-2-7655151916786626770
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
    1523240204; b=hLcORvKwIF+m0HtS1Rhoz/3bFKMkETFLqfJ8Wp9J3jZigv8+YC
    cHfeUdfC1dkDrWfJ+xTCri+wk7aafsNJ9LtHKJ1o00qw7ljRuDnbs1wDZDgrJ+z5
    MmqJHi3XEeazKgtxLeA4yYD4InAo7JPENZqBNB8jEfmb1aIp7jpttVpn203MzOuo
    hYEAaUPmDqjLyqfvLNse5s9pFHlhxMpxnxGvM6slRV1NWmT9To4F81xKEiOQidut
    TbrNAEzzrSBbYgV1QgFI1kUc/rjQypQAx5q5Ke5sZqBPN5VgOYPGuOadAKK44hUy
    OExWhOoU9dkMEn50qHdbZFUJIK6vz/B938qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240204; bh=rEiLyWdzEc
    TBKvUl1wWhDb71+YfW4Cg+mTk2INAVt7c=; b=KR92+P5mBEQNMTYhGpD8aPFm7V
    hp8bE7u3vrlS3LDN5JQ6svgJpzV3Z7mX1f8LvzFk1HiO/YGShfcitjz0M308/KpC
    tnJwM7HnGICDZXip+yVRd7IfOusvN9bUy/3USX/hzzE4bjPirlRjGPxQxb6UNaFK
    Wsc9atqyst7sZBqEd5IChcGjZBrhBTBd41eEnStR0sbBWZg4o5hnX1GLmLkB27B3
    7MrwHl/Ledf/xdnX4SzB1Mq/HB9uLYWR0lnK3lhndjiEnV+8ruLZ77K7z87O8jrB
    AzxkfwbnMWI1z5Dgun60lffrSIWLiSXmpBC2P5zJlLrXza4EtQSK3Xpffj7A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Qs/9nJi2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Qs/9nJi2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAg+JIA2yDhScEb38bu43DWZp08Je3QLr+fVXzqF/y5Xg6wQnI8CpRDGZqNc5wsO3RB3jvu2QjY9d/hPCXKYhBX7gMSRVQwwHXa1CYFOaioZIgcz5N36
    7fgP/DVPIvYUCGp7aAPL8JvoejvD199ABoPYGTxYtQpJahUoKCRahH/ghH1IaRXCTLBRNnvMINZQsdcPPzXlprXU4dOWs9qBKGev6SZ7vlD3uprEaRQrS0z/
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=zAyngx5bAAAA:8 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8
    a=9jACeLF6CP6i2qlCW0IA:9 a=wPNLvfGTeEIA:10 a=4LA4qAFo6bo561LpWNDU:22
    a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757820AbeDICQl (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:16:41 -0400
Received: from mail-dm3nam03on0093.outbound.protection.outlook.com ([104.47.41.93]:60032
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755154AbeDIAaa (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:30 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Sunil Goutham <sgoutham@cavium.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 135/293] iommu/arm-smmu-v3: Increase CMDQ
 drain timeout value
Thread-Topic: [PATCH AUTOSEL for 4.9 135/293] iommu/arm-smmu-v3: Increase CMDQ
 drain timeout value
Thread-Index: AQHTz5kkstlDnN0SlUiUipCZ9Ww4ew==
Date: Mon, 9 Apr 2018 00:24:38 +0000
Message-ID: <20180409002239.163177-135-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:C+BNYYrtWQVna8ZLmjSXpUAuziqrGyYGZYhRTx6MZN+rMxpV9BQ7MV3EzHDc2yiAVFPQmjDlloAsElqk/QVtx828kI2N4CFfrjptMWVye3qIZ3Vk4UdhP1o9S9EOxHKogkKmYgKoKD+5qc18J+iveBiIINDp9ZPhnGExJVW9oS+j8QP29asx0cr4p9mk72q4/gr+RFZlMc0lbVy6LOXDAzy/OasWm+ZHYv8Z/ssMIq9oTibNurtulglmMVGXWb2I;20:4r6lybb0wNH0oZUGIQFRVezEE+nJMGH9JPgeCFizexYF1Ab1MZI3kDpjytVjN955riwYe84NJSHG/3ndBV8mfUGbS13IDIvB4iLnSs3EHTT/5X7y3ylqeJaaQ3lTGU5Ah7D0NRdcYhIgmcWYg6ut7Nq57YJTWAPPLgyHAGjkw3g=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0dfc504f-3558-4a89-84a5-08d59db116c0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08074B018EBC9E88B5514D9EFBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: IWBFPLj2jEX06d+g9Hv6tkSaV4JvrD3azO9caYXORbCHcwQBm8p9+/kLapky45vQ1L8HfLyB2w9QzkxZjIzfxj+Wwz0kezZZy+s9V3nsQzbSkWyu0Cy9x4v13oKixHQV9TqJl0iYiDJ6k1tAjtZV7P8kvCLSjfxyL4jerFHYX3y0IKg1HO6/PX/xPxOQqELr2weHqkqDANzNRJLENX9owCc5pTi8Q/BRTlhABF1D5xcnfxm6puuoB5QXJUEj2tIcnC+r4QSTDDVBLoHDW6YNX9A+zXkGQZlU7ZI+IjGl7HRzLssO6mDnTlHkbb6WOpmrAaDx/iCiw3MqDnftBH04uwXFnSYYQybX0orY5KDxRblkMIPXmyQckOQvWbsRVgoVgxELdPcwwBxS0JJwGCxP543OG2Hv5y1Fn7iymAHwcaI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dfc504f-3558-4a89-84a5-08d59db116c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:38.1125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sunil Goutham <sgoutham@cavium.com>

[ Upstream commit b847de4e5087fc8577c38a697d14fd2a5ce93352 ]

Waiting for a CMD_SYNC to be processed involves waiting for the command
queue to drain, which can take an awful lot longer than waiting for a
single entry to become available. Consequently, the common timeout value
of 100us has been observed to be too short on some platforms when a
CMD_SYNC is issued into a queued full of TLBI commands.

This patch resolves the issue by using a different (1s) timeout when
waiting for the CMDQ to drain and using a simple back-off mechanism
when polling the cons pointer in the absence of WFE support.

Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
[will: rewrote commit message and cosmetic changes]
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iommu/arm-smmu-v3.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 7f294f785ce6..399b7f31fccb 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -409,6 +409,7 @@
=20
 /* High-level queue structures */
 #define ARM_SMMU_POLL_TIMEOUT_US	100
+#define ARM_SMMU_CMDQ_DRAIN_TIMEOUT_US	1000000 /* 1s! */
=20
 static bool disable_bypass;
 module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
@@ -726,7 +727,13 @@ static void queue_inc_prod(struct arm_smmu_queue *q)
  */
 static int queue_poll_cons(struct arm_smmu_queue *q, bool drain, bool wfe)
 {
-	ktime_t timeout =3D ktime_add_us(ktime_get(), ARM_SMMU_POLL_TIMEOUT_US);
+	ktime_t timeout;
+	unsigned int delay =3D 1;
+
+	/* Wait longer if it's queue drain */
+	timeout =3D ktime_add_us(ktime_get(), drain ?
+					    ARM_SMMU_CMDQ_DRAIN_TIMEOUT_US :
+					    ARM_SMMU_POLL_TIMEOUT_US);
=20
 	while (queue_sync_cons(q), (drain ? !queue_empty(q) : queue_full(q))) {
 		if (ktime_compare(ktime_get(), timeout) > 0)
@@ -736,7 +743,8 @@ static int queue_poll_cons(struct arm_smmu_queue *q, bo=
ol drain, bool wfe)
 			wfe();
 		} else {
 			cpu_relax();
-			udelay(1);
+			udelay(delay);
+			delay *=3D 2;
 		}
 	}
=20
--=20
2.15.1
