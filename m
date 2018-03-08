Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485220-2-2019770278635886468
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520485219; b=YgENhaYb0ih9EGC401lu3ug7KrFEuGzRSDY3LB/UZw8+OJV
    mNa6oZGtb2t4CaVTCArsFox82FPSXlAwRA5YI+CqmAKnf8g3TRJ8Lr9XN02DxmCI
    p5HwZ9l+Oo4BZVJoIDe+e9dec6BwrhlEjITqiUKAf0UiRqWiwQ+qlnlYgWsyeqKe
    CglVvMmIBTVIiDRcJRgdC/BiZYQBYuOQOkW2TI5vRBHjLz+jtifGRANfdEsvjYqb
    /LK1UgbZQcr9de4oK3Zlnda11It4RpntkVaEMZJUEbQ7/4f9qLdHIiBdQtx9HCsp
    CIImRxNOLTw9LGeCt/wH56V4HDXe0UlAzadbR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485219; bh=uMrB+6
    zi67e7mqjpRDXSJNaFAr5r22xyDd3qLIA2DNk=; b=YhY8ooJEbbufeJUd1qf5Cb
    YkEiz58iRk1KzvaHCF2w/BZU/KiIT2MXqDinHURo/aJ6vCxWfZWMstvPRiFlfLhP
    VUOrOIEkhKaEdWNnfNVU50EDzuxC+Qj5rMA51t8DGhrFhzahc39X9CBDtqSzxM2l
    xOXABvkOeo0x9z10mJvMuFIljTJa/kuxwwH72CpBZQnphNdCgbQD6gM0uL6KnJ68
    wz2vx6vbxPXJyjiODZI+mHbVDHtcjcjwV7+svm0V7vliALxoRy4BiSHQpvYkHAM0
    lNwvcipIXRkchyedSTa4xRkT76tmByi4BWAwwndB8ZLRDZy3eMgwyJiIznyUYGzg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A96OauGi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A96OauGi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751419AbeCHFAQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:00:16 -0500
Received: from mail-bn3nam01on0102.outbound.protection.outlook.com ([104.47.33.102]:44208
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751254AbeCHFAK (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>,
        Michal Kazior <michal.kazior@tieto.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 020/190] ath10k: fix compile time sanity check
 for CE4 buffer size
Thread-Topic: [PATCH AUTOSEL for 4.9 020/190] ath10k: fix compile time sanity
 check for CE4 buffer size
Thread-Index: AQHTtporuVkFGkjnPUOk2ahiFFocPw==
Date: Thu, 8 Mar 2018 04:58:58 +0000
Message-ID: <20180308045810.8041-20-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:L/iyFYQ0WSfUN9Nus/QS730QDFRoII8gT+YvLD4EqlBhWEKhP0K12H5uk0rx4iOHK58XrHLq7NFshyTuIay94oWLgAkXvRuJKMnMHsnAn/Mm0bSkGH92B1ytDzZuUZFjd/fPIx5h/uqJ9FEWGP1cbjOmhMHN5X3PekXZim7OWyA2lYBVDbIMHjscM62tZwQI/0FH9IrJwjC6jWmfV6sVXd9D2P2/RMHmAI52xDaX80eC2keK7aorPI1QW6O1Eo6K;20:w0VObmrdxFgwQPRAZwfcpPb3yUhwXs4W/c8bQeZWvjnqsZ4JwKN0uP1lBWTfwH0LdNuUb/tgWkwokyios20RjrJQidsMVeRuW/d+tURqDxyDVXR3n27p2fAB91tydkqGLV9RPU1EPB2xcYaB6Ik+5Jq0kvFLC1O/jaPgnhcrIog=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 63ac6ea2-9617-4e51-e927-08d584b1723e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09830974952380782EEFE781FBDF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(39380400002)(376002)(366004)(189003)(199004)(6512007)(22452003)(54906003)(3280700002)(186003)(316002)(6436002)(110136005)(8936002)(2900100001)(10090500001)(5660300001)(99286004)(6486002)(106356001)(86362001)(575784001)(97736004)(7736002)(107886003)(25786009)(305945005)(76176011)(36756003)(8676002)(6506007)(5250100002)(105586002)(10290500003)(102836004)(59450400001)(26005)(1076002)(53936002)(81156014)(2950100002)(14454004)(81166006)(2906002)(68736007)(478600001)(66066001)(3846002)(3660700001)(2501003)(4326008)(6116002)(86612001)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: kNic4q+DLfimsksMRSDDRCTmnwMW5G6cgGFylWX06ygL1VSN/a6T/vZRvPCZyB8Os7kl8MKoTiPHyb9LSabsRnwJ91LIsFPq8T4pW77oaaYB1v81ty6Hny1EC1IgLsKw3XoDCc2AN3qLYfgFalC/n13GpcWeVI7CUP7DY8WCEnmGB+nLelZ4z/I7GOTymJMF7Bm936EO33yhU/j7sd7TjGX7ox6kmtkGdeRbMR2kx5zAFEykZhzLYJf3Y8Dmi0o6riknkxF71jEyxWY973YhXHlHmLiaJ0vW1fhGWWyaxwP469AE7QvH2Sc3F3U9NUyt9Fy5u9I4Zp37ygOpY2x0Sg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ac6ea2-9617-4e51-e927-08d584b1723e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:58:58.8671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
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
