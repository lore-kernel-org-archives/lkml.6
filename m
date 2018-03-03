Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520119991-2-13092153702663702256
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520119990; b=KBi7R9qWY0Smd+Iuj6ZORxhy0DiCvplCvwlJcU8k9wMAwqH
    47h+g/ftKkCeSA3NJZG51MxLlBLl7NJpasX4fFLbG9iQYy/ntkgmJ072TJ8+U9LC
    CgPEKAvylOxOEb2pFefMvbxh4dLD/G5C93ZGu/gSqr/tGwUr9RPTtbYGzaxTigVH
    WR6se4PXtQHrZHEQCB27oQng7SP4ATdJS3OTzyGELD0l53ewpvrkc7z/0SOexUSS
    DiPaW2973oxZ6WzjdvJ1NOy7asFTukPdPHiGhuvXom4ThQnW0OEr5SrCPzid4uZN
    VN4jEt++S3n5FPzJMDzLtoCW0ZiScTDAqaCjH8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119990; bh=uMrB+6
    zi67e7mqjpRDXSJNaFAr5r22xyDd3qLIA2DNk=; b=tIcs2RjK3XR6OseaAmt1Wy
    npOv5hMhFC8tZKKk+KV9xDPPUzyQVQIrGjs0NiUB2VdLywuEvokxsP2njyKhZtUn
    niqbexzjeX2/gE4Iz+jbodz1D/FkE8X/XO4drQ5CJVm2cdi6MLQvXnkP9BsfctOU
    IOdZ7uT3FjrC9XlETcdTqH/0GhBw3kBr66iiGvZxkF2o8s0TiwtEvto9rew8NtE1
    AHLmlNsbFpz1iKgEIXJt289RIQy81HqtQIDvZOzC5xhHOICis0Y1BuGnirEL/Wpe
    94N94ay49AWgv6AbIujG07jJ2ucEf+lCELfA0xrpoWY/aokKuV1bGmz3t0GjL+oQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WqEXNwDR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WqEXNwDR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934643AbeCCXcX (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:32:23 -0500
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:45280
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934504AbeCCWgJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:36:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>,
        Michal Kazior <michal.kazior@tieto.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 166/219] ath10k: fix compile time sanity check
 for CE4 buffer size
Thread-Topic: [PATCH AUTOSEL for 4.9 166/219] ath10k: fix compile time sanity
 check for CE4 buffer size
Thread-Index: AQHTsz8atC6iZXhK9UuYLi3oT0qXWQ==
Date: Sat, 3 Mar 2018 22:29:33 +0000
Message-ID: <20180303222716.26640-166-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1034;7:CClf+cA2555mSjXU0bCH8lg6Rk+wkeAUzeVm2NO8RhLbSPXuQb8Jn8C/TuNIYznP08Gp0HPB/GwjdcSGT90X6/lglLAVuBlqpkaN2+LNXDyb7MAu+HBObQKpzmk2mxgEob28Bk3RJ9EWoJj+t+tzbWPHZs93iqQpY7IhrZsFdgfL1HPY+uAW3aZA3OxAEwwFfYkrQhWDxmIl4XGmuXE3dwVGCYd1lraWTRxe23fAYjx0eswhwSbufQJmrCjn1JlU
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 05ee9369-eb93-4189-9113-08d581572421
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1034;
x-ms-traffictypediagnostic: MW2PR2101MB1034:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1034A558E0864606578A4629FBC40@MW2PR2101MB1034.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR2101MB1034;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1034;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(99286004)(22452003)(72206003)(316002)(3846002)(6116002)(186003)(26005)(478600001)(76176011)(54906003)(110136005)(102836004)(97736004)(1076002)(2501003)(3660700001)(66066001)(5250100002)(5660300001)(86362001)(10090500001)(10290500003)(86612001)(6506007)(68736007)(575784001)(106356001)(25786009)(8676002)(4326008)(59450400001)(6512007)(305945005)(2906002)(14454004)(107886003)(8936002)(7736002)(81166006)(3280700002)(53936002)(105586002)(81156014)(6666003)(6486002)(36756003)(2900100001)(6436002)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1034;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: YUXWcO2R8NK+9dJ59BE/ni9YgY5foSactyEtSpFvgAiE7oYXw8qiWeBmCZQxheuAck3yg9Ob7RhJPCZhTDcs7cVlhqxSjpwLiLtstOd9RNE+1zwDNWK/ydhD2lTPHKppSg+8jNxP34NkjVfwiiKabNd6+dxu/2SwianavfUcnPQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ee9369-eb93-4189-9113-08d581572421
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:33.7288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1034
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>

[ Upstream commit 62ca0690cd495bb7c1414cdf0cf790c2922a1d79 ]

In 'ath10k_ce_alloc_pipe' the compile time sanity check to
ensure that there is sufficient buffers in CE4 for HTT Tx
MSDU descriptors, but this did not take into account of the
case with 'peer flow control' enabled, fix this.

Cc: Michal Kazior <michal.kazior@tieto.com>
Signed-off-by: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath10k/ce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/at=
h/ath10k/ce.c
index 0b4d79659884..041ef3be87b9 100644
--- a/drivers/net/wireless/ath/ath10k/ce.c
+++ b/drivers/net/wireless/ath/ath10k/ce.c
@@ -1059,7 +1059,7 @@ int ath10k_ce_alloc_pipe(struct ath10k *ar, int ce_id=
,
 	 */
 	BUILD_BUG_ON(2 * TARGET_NUM_MSDU_DESC >
 		     (CE_HTT_H2T_MSG_SRC_NENTRIES - 1));
-	BUILD_BUG_ON(2 * TARGET_10X_NUM_MSDU_DESC >
+	BUILD_BUG_ON(2 * TARGET_10_4_NUM_MSDU_DESC_PFC >
 		     (CE_HTT_H2T_MSG_SRC_NENTRIES - 1));
 	BUILD_BUG_ON(2 * TARGET_TLV_NUM_MSDU_DESC >
 		     (CE_HTT_H2T_MSG_SRC_NENTRIES - 1));
--=20
2.14.1
