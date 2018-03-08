Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486405-2-17256677877116012888
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
    t=1520486405; b=TR8WAl+bCVOYcSCIU+Ba7oT/SkSFKTu+r0Xtq3FUEUxER6z
    S4UxkqKY04/esgeU9ex5+5da0KkEGBonto91rVuNAXPUGSA9xMTUZG3asS1p6AFT
    x0CUPgJzQyTBzhKykhr41O/bbzFN2mVpTJUDfIStDRsYgAd3iLgvrlxStCNc3vyl
    ENF4ujy+m7ogtyeTBdRr/ADFtyaXLeXne1jnO6P4O+sxPF4Np0UBRmmvF6m3si9J
    lGuEKzSBbxLJ/mZUSqzdO3VlfJM0H5wI4lhi0HQmovCg1GwcAzhJM0UDC77HPnI6
    cTx7DiM45qu1T/+62chND306rlyKuI/odrsDpHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486405; bh=ZC5KWx
    Y70TrjkaFzBEAJsO3uw/Axbrg/2Pm1nsoAM64=; b=fp/Qwiu/SzyTXOPhRsPBco
    0gCvy6bwc060sqruaPOMfKvVHH9W3qP8JRtHAX7UWsW3Gl3O2V424mwepGsmn5ZS
    PY4jb4K+JaTqUCV3g7uuR/djVTcMBkVXhF9LPdAA0CWn9jFgIhPQMrifJf7vgq//
    gFjXH+hScqmNSWb4n+tZugyQ7ocVX/GKFFbiyhxvf6ICWUgP2Fb0N1u9UNjPMZ9Y
    QIm7GdCjieNEP66NlPgu5129zJqgVgSpUm6uIyxCmItIaCW08jSvF0qdlkvqOPIj
    JgtHAtc6dKWVYRQ16ofAl26mJEGqFth3Z+axou6qKf5DmbFMUa/TOmxIeVfXtcvw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k0FsDGUX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k0FsDGUX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966742AbeCHFTu (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:19:50 -0500
Received: from mail-cys01nam02on0131.outbound.protection.outlook.com ([104.47.37.131]:48480
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966707AbeCHFIJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 10/53] Input: ar1021_i2c - fix too long name
 in driver's device table
Thread-Topic: [PATCH AUTOSEL for 3.18 10/53] Input: ar1021_i2c - fix too long
 name in driver's device table
Thread-Index: AQHTtprA2f/Bsomg/0+IsYZGX74/qw==
Date: Thu, 8 Mar 2018 05:03:10 +0000
Message-ID: <20180308050230.8876-10-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:MwqtJZ2EsCLaWbgF6lInlYpiiJu6+AY6BDdj/b3x6MNYSWtAT1mbl/lwaOOllA8Aa/3l0DOhzRRmeUtQx//Z9xPbiBjAznbe5QUmcaSxntomxcBNUS8nycq/pt6Cq+qPwpme7pSXrxXTI60m8+aX0KHtVkdYAoCAILgbwhL/oR0pJeCkXHhuuWkmQHr1g/awfaYF9HkZJ0TEISAOIj8TBI7jPUtp1gFnrt03Rrxr9O2UjnGEzQJ/n/171Td1ckOH;20:Waqn0N19zAFruSuEi770pV0NnR9UmfMyK1FDd1l0i+KkPtju8+eQEsdM8Vwn7Llxh5ovo/YMlHi3Kf90C/AtXaA7YlCjT+woYnhAtsV2N4ahFpWr11omGZU+nNTtCwi4ERQjrZOErzi+ebB1Zy/CqqLvFmtjXVx+yKe4VWXV4mg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c679da6e-882e-4b14-336f-08d584b29305
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08712D2D2F93D8820D6FFB9DFBDF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(189003)(199004)(7736002)(14454004)(3660700001)(68736007)(305945005)(2900100001)(10090500001)(66066001)(97736004)(81166006)(105586002)(10290500003)(8676002)(72206003)(966005)(8936002)(102836004)(59450400001)(86612001)(53936002)(6512007)(6506007)(110136005)(107886003)(478600001)(54906003)(106356001)(81156014)(6306002)(25786009)(4326008)(39060400002)(26005)(316002)(186003)(5250100002)(2501003)(2906002)(86362001)(6666003)(3280700002)(22452003)(36756003)(2950100002)(1076002)(6486002)(76176011)(5660300001)(99286004)(6436002)(3846002)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: vOvNIHEC18anempUJWLX5XtmA7ozKsIbAjAav6QCSE4phUE3+/sDgCz5dFWE7RpqF+lNaFaSGUW06D5DkW66e3kUygug46Y0WLadpsYqolw1MxKPjj1QpTvS0QI3DbkLZQ/m0UnftgVk6jHRk1us+ONh69uqV/H6gt9snVdZMDzAoXh69v4i2hEuN2QgFR93m1ciWm9h0eedeKktWl5o0xg3WRF4HnelpkRp8pPrSTvIGcstXpBXBCax6Gwf+sZ1kEgd/Oq4WgEm0xbwHjtPuteSBjBQDfWu/CZDjR7+Ze0ZEYoH5USAtffnq/KpPhqmi4Z2ehYNj+l0eyrW9aV9Dw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c679da6e-882e-4b14-336f-08d584b29305
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:10.2442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
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
index ba30578e296e..845bfda99d74 100644
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
