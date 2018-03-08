Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1282308-1520493116-2-10320176186412693209
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520493116; b=JPJ9NVPSFcZoQOu3b55p/01ML2Xnu2tqj8jsR/AyHoMUu3O
    Lwfb+VQ2Dnt5R38LRKcIVc//KzF8O7+0dlx5+fmPOD1usWsAed90GLZNmWZaYjXh
    IPcn58DoEJ36qTVHZiU9XCEXXLpJ+Jgb9IEPTvurHjy6gnjLNhDMutFESEZnwJHS
    vLq6x6Z0ZGSSEN/AjcMzeKal1oLx6Skiyog+I+/Y4zthUXaAHTttf+6Ya0S3ub6d
    n49pnF85EJAtZB8VhZZ0X6qYUZidkONTlQQkj+HyE/7i0cmebDiiMWZax0Por8j1
    oyzZLpHYdv9RziD56X8If+H7j9qBQwW3di9dCKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520493116; bh=/1GXPH
    5nmS0CMQNJxf7FGYSpOEHTE3q8ZMHXbucL+3w=; b=qga9OUYi8Pssfd0xWo96fR
    ejmPuzsTOgR6JHcXrXhKzvkYgZHSfmJ5Xv7+WxAIl+mzE8FQ9cMAQATprYcRV1Pd
    GumirXD/9NrehHbwTSMigl4ppiZfBEWq8aaBzktoK2TFfh5TIjc87Q7fwDYjVbli
    y3u3EjQZ4TyRyHp7WXDriOAng4CzGgaCZJ0YhYDQ2AiUVvQScmZzCuBRA8tDWp30
    4o2bu1SIhP3eBeaQbf5dc1807L4mMqBmOZdaoJSoO2pAcQF5WeoMpXh2vb+UMq3P
    OQYVi7v0eTpUa1Ifb0wniSmzxuq3dUV7UqRowTv1cFPZbmacIkc4e0C1dR7AbruA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XURpB+Qg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XURpB+Qg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755065AbeCHE4I (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:56:08 -0500
Received: from mail-by2nam03on0095.outbound.protection.outlook.com ([104.47.42.95]:43489
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754997AbeCHE4F (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:56:05 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Loic Poulain <loic.poulain@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 04/78] Bluetooth: btqcomsmd: Fix skb double
 free corruption
Thread-Topic: [PATCH AUTOSEL for 4.15 04/78] Bluetooth: btqcomsmd: Fix skb
 double free corruption
Thread-Index: AQHTtpnBg/Lz5y61L0awhM+uj730kQ==
Date: Thu, 8 Mar 2018 04:56:02 +0000
Message-ID: <20180308045525.7662-4-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;20:D+Hn7hRlMB1LS8F70bE7x2i/GaZJ0xNs+8v7fFgCtaKEa/wb70LBfodEA5qJTjpRR+3g7ayTmShHN+NgSYst9RkrEqln/D2xR+JLMncTTgSfHmzV2Bb9e0Zq/rQ1OGrE2hieP/KN/b8gynmrMrEsxeYq8jSp174OV1kifA/0DA0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 212ed212-170c-4c68-4f44-08d584b0e46a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB090206575A548EE3170557FDFBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(2950100002)(106356001)(10090500001)(575784001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(54906003)(110136005)(68736007)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(59450400001)(2900100001)(102836004)(76176011)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: CsOHPNZbDKzdLZckCtPfImBGPUejEiUNS63PqpB7wnk8Wh+KHmYFC/tYUvjFRQQkjhKOKPDiwueOj/E5SWN3TBVZduHRABxGwUgLJG/db/kdaTcz5BAbkyd3YvtIz0I0s5pgWAz/AEvBdZANhiQ8fW/R4vohbtK5Y0nyOS+OkQ75GeE9BnVbcyNkKvTkNFU9UZw1jXlZtp3UwxPClGTSv9H7/TGm3NitTjetsQfhxWvF9jwF0ptt410y6ofuZ98ap5PBrgQ3yC5IeuJMZz0E4URh9ew/pmpYEFL4KVd6B/Q59q5OoLonzGzg9gc7CntIctYnc4NWD3vBI1KLVvhHqA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212ed212-170c-4c68-4f44-08d584b0e46a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:02.2725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Loic Poulain <loic.poulain@linaro.org>

[ Upstream commit 67b8fbead4685b36d290a0ef91c6ddffc4920ec9 ]

In case of hci send frame failure, skb is still owned
by the caller (hci_core) and then should not be freed.

This fixes crash on dragonboard-410c when sending SCO
packet. skb is freed by both btqcomsmd and hci_core.

Fixes: 1511cc750c3d ("Bluetooth: Introduce Qualcomm WCNSS SMD based HCI dri=
ver")
Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/bluetooth/btqcomsmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
index 663bed63b871..2c9a5fc9137d 100644
--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -88,7 +88,8 @@ static int btqcomsmd_send(struct hci_dev *hdev, struct sk=
_buff *skb)
 		break;
 	}
=20
-	kfree_skb(skb);
+	if (!ret)
+		kfree_skb(skb);
=20
 	return ret;
 }
--=20
2.14.1
