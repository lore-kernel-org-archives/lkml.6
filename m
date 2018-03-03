Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520116066-2-11099825485042741361
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
    t=1520116065; b=APDoIUJLaF+hBPevtA6iPmOAK1eH7hLm9Eg8cnKoa3sjw8p
    Stmkwy4lZ6l4yTL5/NNxxOiDxhDN2w5UOnwR5uNGKERg9rIbjr4xk+LxHvxif4bm
    JrEJdxTmTnu7FQII43WdUle6O3wSzYiXMX+/yJ0HiPn+nAO29LWATH6v9WTtBE9n
    XXPoAeyQA2NXsDBIfZ7Ubs3cSggSABrx6v846W6JXqCQCRHKwq/zbEzsAS8Z0CuS
    N/FaIunyzdgFk66A29CKik0xg0qsfA1EFwyF5/m2rB2yE8KquOeWALcLxHL2XkXW
    xD6MUeRY9qiBV41iiaoLgmuBK6ii1HsEYCF60Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116065; bh=pJBv59
    eXEv1HYdpJmIgmztWNDwS1es/AwAS03tJFnv4=; b=Lhej1oQc2vui1iaXfl1Rtb
    plTkDhpX1QaFtTqxD1uH0sbkjgiDytW9EAk4Ee8dYcE3uI9cRH2ICAenjeaxPVnu
    BcEVhDaY0AjAT4YOZhjQlY6Pzm5PViLH3QXPCw2eZuzxx3jra2NKyp6MmU9FvYh7
    BB9mQYNyG0Gbh1ISO7WEe4kbc483jlybQmA6ZzLi3NFWYgl0O5Og2brkKGahe7xy
    mwMExkepmfCvtLH8qQUHz1tGFXVnAoSdVyAjpQ0sARXcmXDxCdu/Kx+j0+nRcDnT
    iU9UGnUm2WhHWQGnOASjZ+6q1Hs/1fVixEeLF8fIDpCkzC/O7jl0Wi3QZHIveauA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gZCkvZZA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gZCkvZZA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932852AbeCCW1E (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:27:04 -0500
Received: from mail-by2nam01on0124.outbound.protection.outlook.com ([104.47.34.124]:53740
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932847AbeCCW1C (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:27:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ben Greear <greearb@candelatech.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 070/102] ath10k: fix invalid
 STS_CAP_OFFSET_MASK
Thread-Topic: [PATCH AUTOSEL for 4.15 070/102] ath10k: fix invalid
 STS_CAP_OFFSET_MASK
Thread-Index: AQHTsz5xTsaDodcvF0GnDjobUa3sHg==
Date: Sat, 3 Mar 2018 22:24:50 +0000
Message-ID: <20180303222318.26006-70-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:rULS5wasRB2U17nnpjKpJ8ObSwDfWfeRE56gWkEylrNI63cIwndsHr4UOI5xltcgOadxh1eYTWy03CdwJ7qmzrOiuHqRpEBp2QFx+a/w855NFTf+/QyV/pC7+bNMn6CKCbU/iYqYnOpxzxKA7aLZmU0/v2T3e3sfsXsdlmWDTQGxZ/CErMRWMXnEadi61zROYfKZgWJUPfQQQCuzX28GRoKi8zp64Sd7hkVDduLNmP8NFuUjXHMpAQCE1YNqCFBp
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b4c70eb-0bf9-40d0-8192-08d58155e0c5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB06660A7E65D6EF05E5C5E2FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(68736007)(2900100001)(97736004)(107886003)(36756003)(1076002)(76176011)(86612001)(6666003)(6116002)(99286004)(22452003)(10090500001)(3280700002)(105586002)(2950100002)(3846002)(26005)(2501003)(6506007)(4326008)(305945005)(25786009)(7736002)(66066001)(54906003)(86362001)(575784001)(8936002)(72206003)(3660700001)(6512007)(110136005)(14454004)(5660300001)(5250100002)(478600001)(102836004)(106356001)(8676002)(81166006)(6486002)(186003)(316002)(10290500003)(53936002)(6436002)(59450400001)(2906002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: EpwH8NxefdIAZqtHpHk0nrf8zBTaw+CcSuTKUnSQO6GWl65GiT5Nqp7sWooSDRabw43w7QWx2o3D6xsQgyAWu+/J2Pj6Je/GpdGvhFsA8nyiiaT143U/zmzcw3mJgDvE5wkW6eDzII5+qNXzXpo6yarAFXNsfNVwz/Q+JF2WXdo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4c70eb-0bf9-40d0-8192-08d58155e0c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:50.1347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
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
index c02b21cff38d..3cb8fe4374c5 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -5236,7 +5236,8 @@ enum wmi_10_4_vdev_param {
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
