Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123994-2-6028688796863801192
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
    t=1520123993; b=QZa3jEvUA4TLjkHamXgZrkFXJwQLByve+YOQOB+HCTfox8R
    IFHhzIR7PF+AfVKlGNK7mTK2Ov2ldz7hwgkYYB+odggrh/qKdUYZtxtmSsiHgFUs
    I9Pev6Y1IUmY2PLzX7e8ucDVVpql02qP8dqqMX4VIosnwUxfLZKSKhDZWydPIeTv
    iqBnqmQ3utCwECkpLdGfshEfmqhNjEFCX27paYtji0lM/OsE8NN/rTy1coeZpyze
    1b3h0S3GMHcOkFfbwN4rdHtsChCpC0iLyE6pTMApOXCeNUlyKf374o5gAYrNJXEh
    hl/tkWlDhif61PwW4HAQHrYkWKfQYSlWtEnuAQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123993; bh=xmFpha
    huEPFKXNTcwbo8bo0cXCmVz/NkYxKZLZOeEUk=; b=aqNAu/Vl9sMScBqalJb1Kx
    FZ0c1fOyFYthfXjo6QEQzBBZKWwpuIbKnxkAWYoeAESbVqR8RquTra0Otc4lvcYl
    5MWlZab29UlVdIUA2oDhx5VcpK47C6W6TdNUIiBdj04TgkD56WVg4gq7fdGjPQwW
    /rfMKTogc17ZQi9Em8rm3g8zr/3MXqxjjPyNb85+XH7cPIkBKCEKPBBhSF6adUol
    jn4WhmblYxVZmi66bL9F9zhqD8o9KoejPkV47mFoJ6KTkiVXUURnnOWnXEK1WZPt
    5zfzpq91N05OfSMTAislwaQ4Yn3kE7MWJLpBGQ459Mf0Az7jv3uFKpHHidPKAeLw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XN59d3v2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XN59d3v2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeCDAjf (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:39:35 -0500
Received: from mail-sn1nam01on0131.outbound.protection.outlook.com ([104.47.32.131]:14704
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932675AbeCCW0Z (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:25 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Axel Lin <axel.lin@ingics.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 058/102] pwm: stmpe: Fix wrong register
 offset for hwpwm=2 case
Thread-Topic: [PATCH AUTOSEL for 4.15 058/102] pwm: stmpe: Fix wrong register
 offset for hwpwm=2 case
Thread-Index: AQHTsz5tls9zDlASYECvv4N2XOgVpw==
Date: Sat, 3 Mar 2018 22:24:43 +0000
Message-ID: <20180303222318.26006-58-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:wJLvcnLUb9jRy8aA2O1RBwGJpam298ZeeiIGJGEfWG9Y1WtDe0+liB5cUHmcvWhd8yfWXK8/gr0fnFJYUcYMbEHilqgjyfIoWfjGRoCgVygHsB840oWaLO0GLAFo5ZH2WtCA0BkCIUf6oMe1/zINBLdpNaHq8aixcd3w9OaREQr7CZda0/HsClm64IhoEydzuurkYbENrmQ8yZ9Af/QUvPCelHQO1y4IKaywP8Eg6t+0dtM9l2XzolkI8Da8QWn7
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0942153d-8902-4e27-e3a7-08d58155c791
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970B4B796CC2428B5E9C1A7FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(39380400002)(376002)(396003)(199004)(189003)(3660700001)(10290500003)(2950100002)(3846002)(2900100001)(22452003)(10090500001)(86612001)(6116002)(6666003)(68736007)(105586002)(5660300001)(5250100002)(106356001)(97736004)(2501003)(66066001)(8936002)(1076002)(99286004)(2906002)(36756003)(39060400002)(86362001)(14454004)(6506007)(110136005)(4326008)(102836004)(6512007)(81156014)(305945005)(81166006)(7736002)(8676002)(53936002)(72206003)(59450400001)(6436002)(316002)(478600001)(76176011)(25786009)(6486002)(26005)(54906003)(3280700002)(186003)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: kvDpeWX2Mue9fbuVplWTyi4w7bkes7vRD9UU81qn1Z9gxtwjDtaRaVG8MyfoLzY6C89nwUwOB182znD28VzsqZ0d5AKYwUXUPujLo5Fqj5D14ifUcrPDXCey4nKCbpsOicUYoSuqlkIvtKUCpcPSPX9XKwpCZcwNTD7q7MMeYkA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0942153d-8902-4e27-e3a7-08d58155c791
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:43.0878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Axel Lin <axel.lin@ingics.com>

[ Upstream commit 8472b529e113e0863ea064fdee51bf73c3f86fd6 ]

Fix trivial copy/paste bug.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Fixes: ef1f09eca74a ("pwm: Add a driver for the STMPE PWM")
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pwm/pwm-stmpe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-stmpe.c b/drivers/pwm/pwm-stmpe.c
index e464582a390a..3439f1e902cb 100644
--- a/drivers/pwm/pwm-stmpe.c
+++ b/drivers/pwm/pwm-stmpe.c
@@ -145,7 +145,7 @@ static int stmpe_24xx_pwm_config(struct pwm_chip *chip,=
 struct pwm_device *pwm,
 		break;
=20
 	case 2:
-		offset =3D STMPE24XX_PWMIC1;
+		offset =3D STMPE24XX_PWMIC2;
 		break;
=20
 	default:
--=20
2.14.1
