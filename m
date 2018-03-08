Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520490586-2-13900101059796987351
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
    t=1520490585; b=i7zQSp9VAfyH/1YKBV7V2WxVl6BLQKqH5pr4smlQFjHkzJl
    2ytLjMhyzXqmiyFkM5TXk1ioi7icT9XEl9szKdXkfbxYaXk7Lm8su5g0ugwmD423
    8ndTHySB0KnvU44bv8CArjDgzVcim4ykI4H076CPpDiThZVuSAY24TDscxvMdAQh
    N3xY455f1cwBRTiouFf9We9Po4fF0A8txgNLW0GrUUW/qFcpuKquATwJYxACx1AU
    iL/+O51L8iCSxsxeS/A2jXZfcaZ0y5x9aUO2Adk41/AYX+xNriz1SIseG+T02wmr
    kVdowgKGrFBVtUoBDq5bWs5cWtS5b2p5OeYvVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490585; bh=SWZptt
    aOK9Umw0b1X6EUp4Kug4F9ISrvKGDNph72ERU=; b=VO40OZxI55um6JaJ5m2DTj
    Lve/hxR1AMcp6gSjhyyEcCn1HpZp5Bw18zb61AmvnJK4xPvhFEw3yolFXwFDZjFx
    rcHGPeeST2wwfpdBG4rF3CUBJplusW4YGDiBpym/UMbQNsD2bblXoz8fgcYEUyXH
    ZVuno1gyDNytzLvjFmZdTXSHLOnVea4OM28Tw8soxPiDMsr2EdTnrLMPX8gCSYyl
    rSfdbTYOpL7QdpCt/oo/Ys/gAX7CA8wfCESkCLvf/LDOQeEzX+8yiciuYVmrb/OE
    W/GtY4cqDCo2W6nIBHZNar3CPX/3nVenNx+rVNxHN2kYWsZJvblQS4UxIX2Ktkgg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JNVzNmkz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JNVzNmkz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755104AbeCHG3S (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:29:18 -0500
Received: from mail-bn3nam01on0102.outbound.protection.outlook.com ([104.47.33.102]:44208
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751337AbeCHFAP (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:15 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Santeri Toivonen <santeri.toivonen@vatsul.com>,
        Darren Hart <dvhart@infradead.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 025/190] platform/x86: asus-nb-wmi: Add wapf4
 quirk for the X302UA
Thread-Topic: [PATCH AUTOSEL for 4.9 025/190] platform/x86: asus-nb-wmi: Add
 wapf4 quirk for the X302UA
Thread-Index: AQHTtposmBik9FB2uEeSwWb0rNBdXQ==
Date: Thu, 8 Mar 2018 04:59:01 +0000
Message-ID: <20180308045810.8041-25-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:34TLQt9I4XALZbNh35vyhnZicmL1qGSoKihL8v1nHTGGMujWJM0r07k22AiZTGvk9TQySMy3ArOz/uazC1Mi7C7rbI6qAaLaM85TLShetbgNpMLSfHPGkSRx9q7Iu3XBaomlyCwfhSYZFGqg4M2+Apl9istovKBPyf3ntcYaqOhhwC7gg+wPrqw0os2jUvHG4CoEhdTf7qIcfYQBE34TXuNKiE8WFHKX+XXZsNgNpflqzAE571FMEzTnjz0AuilB;20:OlrpODtEpaDCzNHnF6m80OHiyN8Y85Ro6JUm/kGT/tuXg1d5QuTDiPXK0LUOysrqBFxWwkHydyx1I+u8X3A18rTEROM3UH3xH1Vi1YrFngH/58qrduLQyFFBBBo1BpnEZoijQE3PqTrjVAl7PwyhLaZuufL3nJc2An4IAVvUOY0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8980540-ae02-4436-ddd3-08d584b173c8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09834956D03A7B8574C29D21FBDF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(346002)(39860400002)(39380400002)(376002)(366004)(189003)(199004)(6512007)(22452003)(54906003)(3280700002)(186003)(316002)(6436002)(110136005)(8936002)(2900100001)(10090500001)(5660300001)(99286004)(6486002)(106356001)(86362001)(97736004)(7736002)(107886003)(25786009)(305945005)(76176011)(36756003)(8676002)(6506007)(5250100002)(105586002)(10290500003)(102836004)(59450400001)(26005)(1076002)(53936002)(81156014)(2950100002)(14454004)(81166006)(2906002)(68736007)(478600001)(66066001)(3846002)(3660700001)(2501003)(4326008)(6116002)(86612001)(72206003)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 5KPo6b8LAnx9pIBTQPESn5+cYzOXBraH8dKu7/em6BJ+N98nkYsx2aK+tps11jFbxH27oA7ZYKbRMwMoEPXer3NxX1HiEkex0QhkAxkWvYWMA+RLBR6uH9EUfAEWRIZ6bcA34V1OqUKxCY0lUtDYD36aV2eZPlcLKbPSq+Yo89kZJV9x+92Hnm9l3/B09a2u2hmyY+YhS8HP3QVFFUQtqkjodrGIY/EMi2Yf+9V+nExMzChuTmta6GqVXNtjHrFSI5S+c7oPQhFTfFhCGGWRGELvMmVT83UZpBM8OfjOWsdTAuZzzz7BTVgx0Iu4sDf2tsy72oiQCM2c1iRNhoNIJw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8980540-ae02-4436-ddd3-08d584b173c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:01.2388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Santeri Toivonen <santeri.toivonen@vatsul.com>

[ Upstream commit f35823619db8bbaa2afea8705f239c3cecb9d22f ]

Asus laptop X302UA starts up with Wi-Fi disabled,
without a way to enable it. Set wapf=3D4 to fix the problem.

Signed-off-by: Santeri Toivonen <santeri.toivonen@vatsul.com>
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/platform/x86/asus-nb-wmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus=
-nb-wmi.c
index 6eb2837f6b89..ab44326ea3e7 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -150,6 +150,15 @@ static const struct dmi_system_id asus_quirks[] =3D {
 		 */
 		.driver_data =3D &quirk_asus_wapf4,
 	},
+	{
+		.callback =3D dmi_matched,
+		.ident =3D "ASUSTeK COMPUTER INC. X302UA",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X302UA"),
+		},
+		.driver_data =3D &quirk_asus_wapf4,
+	},
 	{
 		.callback =3D dmi_matched,
 		.ident =3D "ASUSTeK COMPUTER INC. X401U",
--=20
2.14.1
