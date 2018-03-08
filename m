Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490407-2-11278847806031712439
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520490406; b=wzmlEVhPMN3nIU8K3HbZon24RTQvCY2sF18jcqPMiONfbjG
    KQ+8D3YuyXQfB7riKiZFJURj7rcGsWJOt54bQIVX6I+ngGRfwH1BB/f/t4cz/rwP
    TtWil34NrLAKZAgeX22bht6TVQ2HuiRRpg+RXDJtHpB5GRvQ0PagSKmr47nbcu2f
    xkx7QyRo2oprMMeJvhSJJa1c1dGZ8pnnRjie8tBjOp3j2hGnC59EHLObxPlBsPIj
    +WQLKjkPW4hAhts8PYsxdZ9q5deejCfZZGezxm5ah/u8bQjVlBSubTvw3q8el8s8
    Cf0SvYVx8zgC9tr4BdSTtZgkt32bLXAQvUIJNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490406; bh=ix3lc7
    b9Cl8n8NNXtFuBD114HzmHFlJeClB82xynunA=; b=VK1pcq+taQlgIBJ5dkyHoo
    +cCffhyGkfvWnXuLJSL791rLU5gFif1GspLlOhSj3RNxbFpB4m6QimlSeFSpSUIm
    YizxmEiHT84IV2HKeWnqHMtnzKNNi3+qG3f4oipkfpOiR/ezkWBgf78dbQszdgYs
    DXaNufRMPTSF167d73mvwNwdtBTU9S1w0jfvnHQkCSD2uCLxw/Ee8iTiDTz0tSxf
    O4ZxLTH6WTAYLgE341diSvH3yhkFNwQ0/usq5YDZPU/Y0z4veqtZisf8Vx1gQZJu
    9p7Bbq4cvs83w3jU8pzrSkfaVF17DMQEWMwcnu/Q65nVAoOZVTfWA5hghynvjhpQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=daCLrIVm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=daCLrIVm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755293AbeCHFAk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:00:40 -0500
Received: from mail-sn1nam01on0111.outbound.protection.outlook.com ([104.47.32.111]:53598
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751111AbeCHFAh (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:37 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 031/190] Input: ar1021_i2c - fix too long name
 in driver's device table
Thread-Topic: [PATCH AUTOSEL for 4.9 031/190] Input: ar1021_i2c - fix too long
 name in driver's device table
Thread-Index: AQHTtpou2kgRSXx79UiWhxhATqDYuA==
Date: Thu, 8 Mar 2018 04:59:03 +0000
Message-ID: <20180308045810.8041-31-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;7:Xm57IjrsPophduJV30JFrf25xuNtSx/OEaWMREswYq318JAu25lAn4Bkq701yXG252D3ASKGRgYHIQkmA3oX8HXEBqfxlfbYtq65r/libnmb2iguNY7bt3x4Meoq1b+9H2jlopPzituR2XrZwD288m4ZnW28ZRaDvWIEEi9ic0N1wQOJJOIsG+IagB/dXRPsU0m/dH9YxnKfHdjXfzMbTrDQJKNfLthH8yOwZ7YHGulldaSPBjb1mJkB7u9o0TRg;20:vAkx4fXunt8BdEcCgSOT/ll/CwVG0lkh9i1iLJiZxJwV+/5SLWsa2PE9n9qL6u0X+cx+Xt+0DEEiQjKIjPIaSZ5YKFW4WTknohYmJObjyFMcT99X5x9HZU/3r8hERYf8ga+nFbtZt3dTLmonvJF3KA+OGoh7M40J7vIrY0nJ8Io=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 42578d09-2efc-4a4c-1d0b-08d584b18771
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB111214ABA831E0515FA7AB44FBDF0@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(189003)(199004)(54906003)(81156014)(7736002)(86612001)(25786009)(81166006)(6512007)(6486002)(4326008)(3846002)(1076002)(39060400002)(6436002)(6306002)(36756003)(305945005)(6116002)(8936002)(2900100001)(6666003)(97736004)(966005)(66066001)(2950100002)(105586002)(68736007)(14454004)(72206003)(3660700001)(478600001)(10290500003)(3280700002)(53936002)(106356001)(10090500001)(5660300001)(102836004)(107886003)(316002)(59450400001)(110136005)(22452003)(86362001)(2501003)(5250100002)(6506007)(76176011)(99286004)(2906002)(26005)(186003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: mO81LOoJh8fX9u9oZzwAykPNZVCJUQO+EZZ0YzPzav2njvfPx94TijEGP6koD+h9pWyrLYkYuHzQF1xMiodAMomzBt28ogXN7iOqGLJb6ibJKJ0hfPQr+F103+nCku5zoOc3PxtMeQgowLJFMdQ44VYdqoQMZxreAjgbr8xaf8225YhgqS6ejV+My1+GsJhPJxrQxHuSCO8bTKx/R7PVADEJBLuSAc1snJBwl4vbnRkXpWFfbxSBbpO9n8wVkYosjM4pbyELB68kq/qVLCHAxYZhsmXSWmlAvtYaUqlGz68fgBodpHkzFSS5gg/G5W3JpvPRCKs4hNA9ihWu4IyJpA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42578d09-2efc-4a4c-1d0b-08d584b18771
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:03.9267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 95123fc43560d6f4a60e74f72836e63cd8848f76 ]

The name field in structure i2c_device_id is 20 characters, and we expect
it to be NULL-terminated, however we are trying to stuff it with 21 bytes
and thus NULL-terminator is lost. This causes issues when one creates
device with name "MICROCHIP_AR1021_I2C" as i2c core cuts off the last "C",
and automatic module loading by alias does not work as result.

The -I2C suffix in the device name is superfluous, we know what bus we are
dealing with, so let's drop it. Also, no other driver uses capitals, and
the manufacturer name is normally not included, except in very rare cases
of incompatible name collisions.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D116211
Fixes: dd4cae8bf166 ("Input: Add Microchip AR1021 i2c touchscreen")
Reviewed-By: Christian Gmeiner <christian.gmeiner@gmail.com>
Tested-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/touchscreen/ar1021_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchsc=
reen/ar1021_i2c.c
index 71b5a634cf6d..e7bb155911d0 100644
--- a/drivers/input/touchscreen/ar1021_i2c.c
+++ b/drivers/input/touchscreen/ar1021_i2c.c
@@ -152,7 +152,7 @@ static int __maybe_unused ar1021_i2c_resume(struct devi=
ce *dev)
 static SIMPLE_DEV_PM_OPS(ar1021_i2c_pm, ar1021_i2c_suspend, ar1021_i2c_res=
ume);
=20
 static const struct i2c_device_id ar1021_i2c_id[] =3D {
-	{ "MICROCHIP_AR1021_I2C", 0 },
+	{ "ar1021", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, ar1021_i2c_id);
--=20
2.14.1
