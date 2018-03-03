Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520124335-2-17923886660511442953
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
    t=1520124334; b=JKGAilvgpOR8FnTHYDna4nL0q9Sr/YW4lgoft1Way2VP/ZX
    10HvlZKLdwCsLwKE4TeFlO/WNNAC6NpPWAfAc45lkxWq/ip8AY1Yju+OcQHAU+/+
    /pr6kVDhXOZeZ5sRo1qPOI16GxMiKEd8ipy6R9C9dYp529Gbq+e9o+BvBfXuuSTn
    YHTNVn8YIjvOY612LqTIBWCMc6Js7w1YTaeaexlM+jAxJwtVxCmgwljKrkN5mfoO
    NiHOFDU6aPu21xENAfFHKVxBsvIWkYUS1qdI9jR50xqyyZxfIp76K3pX2CU4Wg9H
    Ck/SJ2jjRokYTlyjWeR6LRrSNjiZwExE7bjbgJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124334; bh=iSp/3b
    HPpsEahbHO65LK0Q6N1RVOIjU30/KUSYFglUE=; b=DHeBvhq110cUGCSoownSKo
    y7NjAaO13tIGpTl3pLzFeLJXIaIwimUXNuIzb1C8LMZar9c0rAIteWyHsrNXSdvc
    b19jv4F01ZKVgAWAGTwytXGAjK5uQFHoDNbq82wiLDhE4IKkd/J40Z5iKcEBzz+w
    n/jn3q0rTwoyw2lnKyD4aO9O3FgMms8j03l+NR7QRocH3crXys8jufeS2MUj76ZN
    Jxkyzscs33VEXUaqUioMdeVm9ZChxf4Um7vIRUshsUq/2CgFxb3C0WayfPUr6dj4
    8+RHeYC6zcksbjHNVjC2Mdy9HCxqnD3iKC1cOPUIlNuJTk6w3JOcwfpsxOHoZoyQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eMRFpna+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eMRFpna+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932565AbeCDApZ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:45:25 -0500
Received: from mail-bl2nam02on0099.outbound.protection.outlook.com ([104.47.38.99]:14560
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932513AbeCCWZ7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:25:59 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 032/102] gpiolib: don't allow OPEN_DRAIN &
 OPEN_SOURCE flags simultaneously
Thread-Topic: [PATCH AUTOSEL for 4.15 032/102] gpiolib: don't allow OPEN_DRAIN
 & OPEN_SOURCE flags simultaneously
Thread-Index: AQHTsz5k4fqk8wd940a6zkRRfva7PA==
Date: Sat, 3 Mar 2018 22:24:28 +0000
Message-ID: <20180303222318.26006-32-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB353;7:55g/s3fGEld+plfyc4q1ll6j4ZqDb1JyDgp2Y6lIMIyamaDUWeoAjzz2ykb61cGfyl6dyqniAsB1bOhHtcEvjur2V2bfoR4mRryGzRJnM0mcDfkvnAb8E0OvHj0YmuwLIApxhvWoFk7OdTAP57ECa4QnOOSjPAsI4nRNrFl2GXniXNYAxZzK75TU9WTVluUckfdu/6C5KkyRcP/bC2YTJk0A+N5k4eHJjl8qclc9V07/Z9aa6ckbF6XW1XPjFBaX
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ec98bcc-6060-4e3c-57ad-08d58155bbfe
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB353;
x-ms-traffictypediagnostic: MWHSPR01MB353:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB353781FC75567BDB6C24F6CFBC40@MWHSPR01MB353.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHSPR01MB353;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB353;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(199004)(189003)(6506007)(8676002)(59450400001)(8936002)(36756003)(105586002)(2900100001)(3280700002)(81166006)(81156014)(99286004)(6116002)(1076002)(316002)(110136005)(26005)(3846002)(72206003)(5660300001)(102836004)(68736007)(305945005)(10290500003)(76176011)(86612001)(2906002)(478600001)(7736002)(14454004)(86362001)(3660700001)(186003)(97736004)(54906003)(6486002)(6436002)(10090500001)(53936002)(66066001)(6512007)(25786009)(2950100002)(6666003)(2501003)(107886003)(5250100002)(106356001)(4326008)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB353;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: wenC6fMPydfJK7HxzQ3uaddD6iKako2yW/UfNu/z6IzX6zZLQf+w7QuLp+iT3Fvm2EhNdvBdEF5rhjIKLsYhKdbfVGugJ3+HtpZo1bRN0XxxyuX6fg/AFHT6YWEX5BohpkshaiyZyjDbU4DRtwtcAzvxcvlWZM/vwh4pyDrVzMQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec98bcc-6060-4e3c-57ad-08d58155bbfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:28.0878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB353
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bartosz Golaszewski <brgl@bgdev.pl>

[ Upstream commit 588fc3bceaf81bbd62e18af6f7bd475e01c2b7e8 ]

Do not allow OPEN_SOURCE & OPEN_DRAIN flags in a single request. If
the hardware actually supports enabling both at the same time the
electrical result would be disastrous.

Suggested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpio/gpiolib.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index f6efcf94f6ad..7a5cf5b08c54 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -460,6 +460,15 @@ static int linehandle_create(struct gpio_device *gdev,=
 void __user *ip)
 	if (lflags & ~GPIOHANDLE_REQUEST_VALID_FLAGS)
 		return -EINVAL;
=20
+	/*
+	 * Do not allow OPEN_SOURCE & OPEN_DRAIN flags in a single request. If
+	 * the hardware actually supports enabling both at the same time the
+	 * electrical result would be disastrous.
+	 */
+	if ((lflags & GPIOHANDLE_REQUEST_OPEN_DRAIN) &&
+	    (lflags & GPIOHANDLE_REQUEST_OPEN_SOURCE))
+		return -EINVAL;
+
 	/* OPEN_DRAIN and OPEN_SOURCE flags only make sense for output mode. */
 	if (!(lflags & GPIOHANDLE_REQUEST_OUTPUT) &&
 	    ((lflags & GPIOHANDLE_REQUEST_OPEN_DRAIN) ||
--=20
2.14.1
