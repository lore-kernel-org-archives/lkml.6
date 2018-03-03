Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520119544-2-15557348426989599089
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
    t=1520119544; b=q3semqJgY/+MSfjygsGaNXAmYlQ9+HqHEQOdJGMzWxPkP1i
    L2ByvpVJRYqjmg7PCvkrhw1fUdyN+FQc6WKM04cMyYVZgjfSg4pIR79/PJU0tcBw
    ggM+Ipb9yV5xbuhcn4wGcyXrvTI11zpORFVYfN8bBLbLZwsJUrKMJZMrgknHy1lm
    eFPLQuP3xXhNXtX5FpXG5KCEj3XIG0MQXZkiWvpMpdz+sYEE1iFqA8nURR8cnozs
    2oEiNEX01zaWBHTc2H4dfcSd0Uqe2bc0eaFv+/n4prcaLCxHwoqras6G7avvw7yq
    uKisFfg5hPPSwIb67po+LBxCXq/BoauITcPi+6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119544; bh=qAcdZS
    1Kg5FWY0VT2R5JweLoWNkr31mFjDvs+Zx8T54=; b=Wj1cIrmmIyUIgZuCBQLtju
    IcbBsAGqgEJ9hAoi3scCW0smaUIjLRG4iqhLmJ6qgeSN+cpfPKr30dzPd2dqPiea
    xCHfhnQh71T/VbWUvQScX4gOt0Or24kDBaJ2YAvgRF+m5rgo9GizoRo/aUjNHMNg
    6uW1j79+BAEYEWKTS6upUGpqCf0SAf9VsVIRchWR2nmB61Ul8ITTLex2ogpRMQnI
    qRSsZ8e607x0GM1MHroqIsHEEg4JyHGO2T+HeGC8zO6smoHy1V0ycogAcw5c+TBK
    nweG9XadQL3XOfqup4zicpPW+jaWcwzU8hHakJb3PLPaj7VMwUHolvRILR+w1gTw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N3M1+FvS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N3M1+FvS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933274AbeCCXZP (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:25:15 -0500
Received: from mail-by2nam03on0136.outbound.protection.outlook.com ([104.47.42.136]:28821
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934054AbeCCWhJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ben Greear <greearb@candelatech.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 200/219] ath10k: fix invalid
 STS_CAP_OFFSET_MASK
Thread-Topic: [PATCH AUTOSEL for 4.9 200/219] ath10k: fix invalid
 STS_CAP_OFFSET_MASK
Thread-Index: AQHTsz8mZU/FRnoGTEijXRScg5gzhA==
Date: Sat, 3 Mar 2018 22:29:52 +0000
Message-ID: <20180303222716.26640-200-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0969;7:E1C8mlqzgM3ntU0iDzT2ED4ugtbB86PwUp3+Grnb8YkGm1sN1wvbbD4lED72CzUWxkATyx1jKqwgPk4F45KUAu9PUJZ37CBF76b6fbtKmhdFLO8n74F+TDcm9EkSdnivrRcxPE3dB9UJhB7mFtoZ4cxDndWnXm4ThPL5wysCbEWA1EVewWXhXhjao9ToWa9EDoE76is0itrctCn1A8ztHRik06E3k1QxInEcwCK/DgPLlylErM+xtKSMztT+QM21
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66feb8f9-02b8-4b77-c1c9-08d581574316
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0969;
x-ms-traffictypediagnostic: MW2PR2101MB0969:
x-microsoft-antispam-prvs: <MW2PR2101MB0969A872EF8AE296887EACB5FBC40@MW2PR2101MB0969.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0969;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0969;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(366004)(396003)(39860400002)(189003)(199004)(105586002)(5250100002)(53936002)(107886003)(36756003)(6436002)(4326008)(2501003)(6486002)(1076002)(2906002)(6512007)(2900100001)(54906003)(110136005)(305945005)(106356001)(7736002)(316002)(3280700002)(478600001)(14454004)(59450400001)(10290500003)(68736007)(2950100002)(72206003)(3660700001)(66066001)(3846002)(6116002)(102836004)(6506007)(5660300001)(10090500001)(25786009)(186003)(26005)(99286004)(22452003)(81166006)(76176011)(575784001)(86362001)(81156014)(97736004)(86612001)(8676002)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0969;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: GmfdP/y1jXAyNu14GvfAG8zIrmtdO/Fiti5GTzzWcUOFPyJ188mmuRpmEbSs+/gKhX1iT1tKoLPGYSbxSMgRFBFPYoqO9Zby09kB11QoBJgXror9YUjz3QXStybZcYxm7A1UaUf3QGXyLIhgpZ08IvUK3HFwlCnceD68yxgwWOs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66feb8f9-02b8-4b77-c1c9-08d581574316
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:52.9476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0969
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
index 1b243c899bef..9b8562ff6698 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -5017,7 +5017,8 @@ enum wmi_10_4_vdev_param {
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
