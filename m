Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485525-2-8461966531840953575
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
    t=1520485525; b=c+FtUhxie02dpm/JYDcWnarRTRIcqrhfuHyCPMvS+fmWPHy
    hJdL51pl6QkbWaoJzKT1SwLD9oeE8ljRXjS9GMy2GaOOenxrPVnNltM/gqvxkD+n
    scUcTs0cNj8/X5bwDxSK1/CkCf26Z7dqH1oIjywVeXA0O2Js2bh3MIf8GpuG0KRK
    IymV+wCEL+IGplOL9hsGuQQuhLxuiU/CGvUD9GDDuwIl/2uXCEXV/Y8n3XgKbvHZ
    lAY73K7rgRrYYd5dp5CPrM2wvhvD2mFOEN1Up4BnYHyG5Q2ZRn4PVRPn2jHGagyX
    W1skFHcdmykfZWzvuMU85lqvdyRVP5TDn6daX8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485525; bh=ix3lc7
    b9Cl8n8NNXtFuBD114HzmHFlJeClB82xynunA=; b=n5x0vb4WMp1uJOacJ1LPsc
    T+Xn9EstAupVjuTXkL5nm0W2us2b+Pa4D20067tQaVvun4Kcn/4OEla0/s5HDHXH
    CTtVdRD9CpVvQG1KDF7jaQQiQAm6XtBCzQnlHnodsann/PIcH0XyritO9a5Nc6AT
    K6eXTcJDIx4QIeue4lGvHypTirA2wKFOkRf5CwmSsj8c3O3yn7dM2MG5HYjer07Q
    6tPMXZQUgmXEbilv6PVv/LJosEzelTz9SV7d1okGTpqv9Wa0D7Pc8bYDApsdgYPE
    vE8w5p6xdEpgeuVXO4FMc0uQl6JaC0uKFP6nw5pFej881eURjL0GcRANHAZMAGfg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ftx78g8s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ftx78g8s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966216AbeCHFFV (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:05:21 -0500
Received: from mail-bl2nam02on0126.outbound.protection.outlook.com ([104.47.38.126]:13526
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966199AbeCHFFR (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:17 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 015/101] Input: ar1021_i2c - fix too long name
 in driver's device table
Thread-Topic: [PATCH AUTOSEL for 4.4 015/101] Input: ar1021_i2c - fix too long
 name in driver's device table
Thread-Index: AQHTtpqEDPMZFO+mlUeHHqN72WxSOw==
Date: Thu, 8 Mar 2018 05:01:29 +0000
Message-ID: <20180308050023.8548-15-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:O3SRp+VNwBgKRR6gHK8T5vsdp4bMj5gv2WAst5pxIDq0oT9HPociJ/UVI4maHuEqwISlFKI6D1owFrkvSSCo5cEB3a6uYNN3Nt1Ic/8MXMC3o4TunY9KriUsp7EgFOf5aEPmZvadhx5t5mOM2SlBh3yqdZH3u0UZWPi/jS77jh6OL3qZs57L4wOMsEKCrdaPdU0kSWM+hNPBwjoY4nDDDeyQCUszLl78jfyQKZffeBomfL92xgb8o3cCvEYzv2ve;20:RcHd1VUe5eVb3tX+jw6VdseYo3fvjsff/HKEcJ9LuORVShEAhlLYhU01s7sQ6e/oOvW4F4nRS0yn+EkZ5K9cA2K3qD7atquDwhYqsw9Vq8OBRz9TNnv7kHOlaoFauj36OuFGcyIOnUzvv/j8mUEB4saj68MzAhjgsHZSpPiR+3c=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4d10eb19-5133-4f35-a868-08d584b22ade
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727FFB39084F2BCA1BCB8A2FBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(39060400002)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(72206003)(6116002)(3660700001)(6306002)(5250100002)(53936002)(107886003)(6436002)(966005)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: gXFfqkeoo3WxocT9U612Qzr8PPfegmkVbQCCO7Ba6tcSkkSg4fLDUOyO7sNe1KGU8VgXkWTNhIF5YgcbKAVHDNV4i2QQo3MDRfB1q4DHd/y0/furMuuUrdjIV8mKfksZLVNx2W8rf/n/Fcjw66vFbI56byyXcddS0jwxB377L8bvINJbmi8h65YWmyhRXlxKNcFg7l2smQaIbYAaRa6c2MOIe1bn6/nyXLJ7Y/aqO8XRXNZOQOHFrQmy6BjIrCQ01tWq66mhd8KWollKopewOCIxJx9q5xaITMz8ovJVUSapk+L849OLEgKSLny5qpa47JN3uk8tTSII2F2NWeyGzg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d10eb19-5133-4f35-a868-08d584b22ade
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:29.0724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
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
