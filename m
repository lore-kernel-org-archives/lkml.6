Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123712-5-10254499512551611640
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
    t=1520123711; b=UGmxxwiMnKlpHu0hV3A4/9oKDBgxlOnGizkR30e+4qUPvQg
    Z0XdG+IKAJ3pE5pD/0FtXLaUDRhOS7VZfDjD2KEFEst7PxY7ZruHAMKHvyV42BBr
    GZDSQkSwxjXS21BUCfeM+btC+FAvvIXk0mYgC3JMQ3LsFhhpjt6UarnlLP+KnxbH
    UQjkYZ8Y1iLda5VuMB8sYVqqgBCYejJZda1PHyxOV6yKczTLLo32rhyAZP7XPwt+
    7X8o+7RlzAazh0tAIBv+llMZTT8MPyMr92h9YxSsM3VrEkObQnDQILajXty8EKX4
    HNx5C3V5pHEfShacZIvSi+r498IEkYw+19nbmsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123711; bh=y8eQXR
    Hibfp0KGv116AMa1mE4ijJ0evctCw5RU/ZEws=; b=vwvVWvDh1ObF/3CI72/lao
    38B+Lvy+73spdeqDK9X5dEHP9f0upkYesYKoUfFmusXwVwD8wj/MhwuA/ZOP/Q7s
    k5qgegOFNjfg4zJ443Aw/mfBWNGprS7H5/j6vhX8AtVh6L0HVs5G1sQvnMcDnMM1
    t0bVIS7drc+Tex7wcnutK+RoVozjvG7HMLI84ZEZKwm1/Gm1aBcosUs4wn/nFVXL
    +anssB5bB3egY2s0QPbUEaHdtpnllhmksy/Rum+u3/zrxL5acWZLUblZqHh1VvcB
    LBBlaDRpzAzKwwklxEPRiiug5WPReKLMOq9fBDsAgiuIElcZMjq8DxLApXFSt70g
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UjNHd0qC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UjNHd0qC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932961AbeCDAek (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:34:40 -0500
Received: from mail-sn1nam01on0105.outbound.protection.outlook.com ([104.47.32.105]:19488
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932909AbeCCW1O (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:27:14 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 082/102] media: davinci: vpif_capture: add
 NULL check on devm_kzalloc return value
Thread-Topic: [PATCH AUTOSEL for 4.15 082/102] media: davinci: vpif_capture:
 add NULL check on devm_kzalloc return value
Thread-Index: AQHTsz5149M1v51UvE+uRx3gBX2cQA==
Date: Sat, 3 Mar 2018 22:24:57 +0000
Message-ID: <20180303222318.26006-82-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:ATuC96A/uRjffcIpMa3YLot+FmZpG3kQdJbArkyc5+q/wOD4sZkqylZXNJSI9z7sHb8ywG7XVahvoTJOtqOAgz1Cdb+UX5KKKBdoSVl/H5HUuDhNEArn7w+U7mTjGvLsYEjJvsnIuVkcCGCBdIh2f3OMxMGVQecKQQzWjWOcAEbpxfXNhZ4xxkjxSat3qCzAQYiB6XFNwiOXqOe520H4CSABCkxsBkaCJrDIjhOadAgRavpFiWeLImoZXmyPaLtr
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 294ac87b-c1e1-4310-b577-08d58155e66c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970CA2806AE471B581CF9C4FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(95692535739014);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(575784001)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(59450400001)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: nUnE/pPGBE7ETCnKK6v7w6p6AxKa1jRApNO6904Q1bRagOZHtoYCY/iwOxdzBkQ5lnomzKDd1Ut6zQ0OXU+MGSC+F/v75G+wsy3hmkqcDfOJUw4h0IZtyH4LvB0mtw8fDtlT4bHzuLCJKhJ2lBEQ1wxSNziWQ4IPssT4iKM+wNQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 294ac87b-c1e1-4310-b577-08d58155e66c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:57.4941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>

[ Upstream commit 5a18c2434f8bfc8bc2fb0f8af3e44f7408d63e4f ]

Check return value from call to devm_kzalloc() in order to prevent
a NULL pointer dereference.

This issue was detected with the help of Coccinelle.

Fixes: 4a5f8ae50b66 ("[media] davinci: vpif_capture: get subdevs from DT wh=
en available")

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/platform/davinci/vpif_capture.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/=
platform/davinci/vpif_capture.c
index fca4dc829f73..e45916f69def 100644
--- a/drivers/media/platform/davinci/vpif_capture.c
+++ b/drivers/media/platform/davinci/vpif_capture.c
@@ -1550,6 +1550,8 @@ vpif_capture_get_pdata(struct platform_device *pdev)
 					    sizeof(*chan->inputs) *
 					    VPIF_CAPTURE_NUM_CHANNELS,
 					    GFP_KERNEL);
+		if (!chan->inputs)
+			return NULL;
=20
 		chan->input_count++;
 		chan->inputs[i].input.type =3D V4L2_INPUT_TYPE_CAMERA;
--=20
2.14.1
