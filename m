Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122606-2-14139661079696550839
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520122606; b=PXfaeLPDFW7mKI+QCDBdihdPafeN+ejbVlV6P4orM/nHVnd
    8Kh65JBFvRAcnl2+N5gJM7F0EHWpfVrjeNrBXJ1cigQ+gSTzHT0kY7GskqK0kiZz
    +i9WGPv34XjTHkkfNxR08j9dEF/STg97C/UdGWeqQBbTlPF2NDJlsSjCokvBIvL0
    4EXYctm709SZ4ubLO5MtlB4Nf5jYMzJi6OZxL+gdZ+IQBDAJ5SV+O0pHttX4nykW
    hQEuUM3IThyZBeq3Nj/VPqWTo5flEJB4K9/bKw+Xr22HAfWltYIB86SMyac7gu8e
    1oQgkgFS/IGsEL+eDhHz9ZyDsDDy3I2UiB10DxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122606; bh=LH8f4W
    DYuR4KIxWdbwqjOvMRFf71y3druclk4FMHd8w=; b=exgpTWbg2aamfLNs4OQngh
    LTLVF+yVNRTKkbqZtPGASSQopsuuS3uEcmyDs24GlmN6R/R70pUFiiUWBGdFlojx
    L9IICHKCY4Lb9MWwMzfWSDFM5eh5ZeQRp5zyLDdMoFJlsdQvO62EyPW1+vXbPtMx
    X2RuIX+u0me/Nut5ukZfh+IhSdmMWn+tGTHGSq93Di5KKKzLqB3DAJZnqhfg96a5
    URKBGNZxOQYS16dEMUTUJV3Cp0J1NtGpYgIKR3MPRZFYAaSlSFW7U87JTr/Jy/kC
    CFgbGXii2KyNt8X3Mheh7hhVQkyLdsXHSMmSJ+uip9s04oYAbV6DsTUxv/wO68OQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HdUvo6mB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HdUvo6mB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933424AbeCCWaK (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:30:10 -0500
Received: from mail-bn3nam01on0135.outbound.protection.outlook.com ([104.47.33.135]:45024
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933058AbeCCWaI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ben Greear <greearb@candelatech.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 54/84] ath10k: fix invalid
 STS_CAP_OFFSET_MASK
Thread-Topic: [PATCH AUTOSEL for 4.14 54/84] ath10k: fix invalid
 STS_CAP_OFFSET_MASK
Thread-Index: AQHTsz6utiG6/ejH206Nzbv+cwYxiA==
Date: Sat, 3 Mar 2018 22:26:31 +0000
Message-ID: <20180303222518.26271-54-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;7:CfFMX7076YHbuQKUNTPeV4wse2SPsQ0vnfFRgUWgRJx7qGvTvidJFF4UC9Psj2HddZnes9o/3jRggFyPGlnkNjmYPiVDRDTLez8lxfXRcRHHIVoiNwCHL+ODtOD3PMNlDybCKtOhpvzLV/ha37wKwVzVEJZCz1XpWOY//yAyq0qrD+C9lDT9frOcSIEyrZVHzuo/DTqU6iUSkKTJxHgc8JrYqaIXcqeO8iwkdcuNIPEfOC9W1w+hWn55cZbgxF5Z
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fd5e63f2-acbf-462d-aa69-08d581564fa7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1065702ACCF2F31DE3414FB7FBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(6666003)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(59450400001)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(575784001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ez/OMxWNGuDcrlaVOuGUscmQOW87khuB1y0qtyt21Lz6EPOcbpguS13f8htm1B1oflf05Uz5j0Bw0fqwBHLxJt9QCr8J0jl3K6Zb+4QYExW22aZoy1mjPgVFZKUjJHuJ2z8HlGGoJkpEzWXqC2CaN5Jt/JNTTfOaY0tMSsTaYvA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5e63f2-acbf-462d-aa69-08d581564fa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:31.4629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ben Greear <greearb@candelatech.com>

[ Upstream commit 8cec57f5277ef0e354e37a0bf909dc71bc1f865b ]

The 10.4 firmware defines this as a 3-bit field, as does the
mac80211 stack.  The 4th bit is defined as CONF_IMPLICIT_BF
at least in the firmware header I have seen.  This patch
fixes the ath10k wmi header to match the firmware.

Signed-off-by: Ben Greear <greearb@candelatech.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath10k/wmi.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/a=
th/ath10k/wmi.h
index 7a3606dde227..bab876cf25fe 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -5235,7 +5235,8 @@ enum wmi_10_4_vdev_param {
 #define WMI_VDEV_PARAM_TXBF_MU_TX_BFER BIT(3)
=20
 #define WMI_TXBF_STS_CAP_OFFSET_LSB	4
-#define WMI_TXBF_STS_CAP_OFFSET_MASK	0xf0
+#define WMI_TXBF_STS_CAP_OFFSET_MASK	0x70
+#define WMI_TXBF_CONF_IMPLICIT_BF       BIT(7)
 #define WMI_BF_SOUND_DIM_OFFSET_LSB	8
 #define WMI_BF_SOUND_DIM_OFFSET_MASK	0xf00
=20
--=20
2.14.1
