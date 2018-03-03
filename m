Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520119653-2-16834130238349185957
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
    t=1520119653; b=Am4ejxJWlEIHwldj0dOK++UGTRAIvUmprjsK8jTAxyPUHIC
    SpalxDgr1i7SSlLRnj+jnFuJCqLCkH8poJonm0rPfAtvhR6SspLkmPt3bJDASf/Z
    RAuDV6WgMXze/jOjXOkt9KqKKcjX0pcMFvsyU9ge2Auf0Didy/CZWQ8Izq2NWcNj
    N9VG2Gin+lBPXV5XJ1oHTJ2g4FrdzWT+5WPbO+YHk7Nx4rjRXiBR5pErxzSS5nkA
    Qm+L34i7J5S7bbHtmi/A0VOs1ksx52SN7aPWtf2lWm/Js6oA981zQvdU7FOvEUt+
    cye3imAuENngXPkZHX+/9M3AZcRQqDugTMpY73g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119653; bh=xmFpha
    huEPFKXNTcwbo8bo0cXCmVz/NkYxKZLZOeEUk=; b=UTnyPCSLc/k5tcSamWBs92
    MeYG6//4TTEMz2fQ/JJDAVaLKYO1Y1hFtRXwGIS/dkOrYMoCsijW0Hd1WDm5bF4N
    glVO1RAYvUB0zA3guKWBzDytY+BdCqEm4Um/JUTZ+ckeHq8HBiyV+XAxtx1KZEn+
    3aYac7YM6pDFBzzIEiAIYF/ZSUBhUvBHm4KGcQPfsF0NEF5LwCAXgRzB18CFvIqQ
    m1CW6OMWXjz9KN/9v8LEUyAaCV7t/8KuvZnjDFCKEaoXHlIh5sn/dO7bm5uI2jCZ
    +FzXUoiDMpbX7t7chjQkrh+QERQBFcXRgb36nR18nB4a7YffU8xuyZwxN0vjuezg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=E67486lB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=E67486lB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933220AbeCCX1E (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:27:04 -0500
Received: from mail-by2nam03on0133.outbound.protection.outlook.com ([104.47.42.133]:4477
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934663AbeCCWhF (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:05 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Axel Lin <axel.lin@ingics.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 197/219] pwm: stmpe: Fix wrong register offset
 for hwpwm=2 case
Thread-Topic: [PATCH AUTOSEL for 4.9 197/219] pwm: stmpe: Fix wrong register
 offset for hwpwm=2 case
Thread-Index: AQHTsz8l7KTVah3dq0Ci75vJyeiB/w==
Date: Sat, 3 Mar 2018 22:29:51 +0000
Message-ID: <20180303222716.26640-197-alexander.levin@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0969;7:MVpHlioiihj1LUyVtXnwW9FIQ6P2dxWV5jk2tagW9dHcpPdZOvEgoNjpfOePiJhNh3WZ3eSY4SPoNvlh9Sofa+3bNZVi2NK+Gq9ubZjVdNvFZENaj1sFTt84JdkrGvGkTaIF2ZrwdO6hXnfmgiUFM3y9OLk59n32DR8Xyxo/8UblHaDKjtxP//BDm2v4VBWho+hcbAUkYL4jAvpMmifea2bHa04M8AoDTXPJFlSF3xCeLBd1+MvnUWrPvGWWUpVV
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f5653887-27ce-418d-b819-08d58157422a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0969;
x-ms-traffictypediagnostic: MW2PR2101MB0969:
x-microsoft-antispam-prvs: <MW2PR2101MB0969C7943AF3E042C2DA0A39FBC40@MW2PR2101MB0969.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0969;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0969;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(366004)(396003)(39860400002)(189003)(199004)(105586002)(5250100002)(53936002)(39060400002)(107886003)(36756003)(6436002)(4326008)(2501003)(6486002)(1076002)(2906002)(6512007)(2900100001)(54906003)(110136005)(305945005)(106356001)(7736002)(316002)(3280700002)(478600001)(14454004)(59450400001)(10290500003)(68736007)(2950100002)(72206003)(3660700001)(66066001)(3846002)(6116002)(102836004)(6506007)(5660300001)(10090500001)(25786009)(186003)(26005)(99286004)(22452003)(81166006)(76176011)(86362001)(81156014)(97736004)(86612001)(8676002)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0969;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: dT3q2NNSqw26WEXbc74wJbzha49N8/sYcfgsO7MlGfp1fNv3tF4n3xvE5rQ3FB7cw4skE1JQ24PTUpS8uieCB3BUQHk7rnOBOFyhW6DQhrfCF4CzrytJXXtaDJTg4pOUjzHe+vAj2jfdOEGVloHJWTiKxD6MTt6TtOguozALdQc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5653887-27ce-418d-b819-08d58157422a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:51.3695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0969
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
