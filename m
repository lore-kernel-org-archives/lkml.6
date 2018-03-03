Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520124135-2-18228291002785492295
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520124135; b=d9fqg/vsk9cA1BLdU65H8G7UK7iViIznRZRKglhj6kT0PIT
    84CSKqkOYKMX4I8QxA5EWOnH1kfElynlqUMdm+5+zte/2qdBOfCVzSRxouVxlsh6
    ABuQUTMudUfCpXoAZq7nWELkfLTxmV4EKRSIPoOaYtDS3ZwvKEsmixgpnFTEq6vz
    kejCEXdy9aDr4SDZuJt59IRYrPK3y2YpR+l9CxCE0mW/pfZ6dXU5YRU56Vd5PT63
    Yhwo3EOJU12VTLbpT9PkGtEuGL+YVrcLHCpphPQndIplS32SW7RnajSmcg3Mqib/
    ppj17hPHSvnM7IFxLYoLQXogowSDtJ/yFCVQnRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124135; bh=Eo0MdA
    Ybu+Mz644qEbSDsAqFOaGO1cX+rSXW+JLLiqg=; b=d2VQhCU+Yur1K9GBR1sq1/
    iLdYpWH/g6rvsKSqIQyGKURoCoP1sPuZN1LshqkIQX4FiEFdnP1YeFCPmAbg6w8x
    8orW7skZoQDv3pRVc6Ml8o294+LUUUlzKcYDEWRgnxSEMvcw+rL609OpvZVE/eEr
    WKBlgaIq6bqX9s8XmpYHlBDs1vfDWyvPwfx6aZZwVWBJcici3ldTlmZp7fGkGAj0
    Cwm3iCS1vS4Y1YPjfl3HXqXYmgf85eiAmR6fVoJ/yH8HSsyk06/E8EL+lufRcmt/
    549OZF+Cm1ZP3EU7r6bzkZccFInDPyw2B5P9DdfcKcOGRYa5nepYZwyHAA9jTRBw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FI2y7qZ9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FI2y7qZ9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932628AbeCDAlb (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:41:31 -0500
Received: from mail-bn3nam01on0098.outbound.protection.outlook.com ([104.47.33.98]:35904
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932455AbeCCW0R (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:17 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 049/102] iio: health: max30102: Add power
 enable parameter to get_temp function
Thread-Topic: [PATCH AUTOSEL for 4.15 049/102] iio: health: max30102: Add
 power enable parameter to get_temp function
Thread-Index: AQHTsz5q+5KnbGgKrEeYpLtjNqggig==
Date: Sat, 3 Mar 2018 22:24:37 +0000
Message-ID: <20180303222318.26006-49-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:ng6/2z9qmHVNBVmSvFLfkXjDWIA9Csz7m6o9idTCn1o3LGpNqzqNObKYlK1ylb9zrvZskUoVTBjqhU3wJKu5I1taS5l01aOw9OlNY8ajfucIzgIimLdFwBeTZJ0WXJdceA7xOz6SeO6a0+1AWVeTTlSYlqu0erZQVoyl1XIKkDMkLFWEbhuvore5Mj9mloc+6jQ5odazzVFPYAEZa8c8pqJcYIxBDQtFcm2uaqz09bIZ4cAx0wi8W6Arn6XEsdoX
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4fa7cf64-e7b6-451f-3c71-08d58155c35c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09703315049C86F7757FAB34FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(39380400002)(376002)(396003)(199004)(189003)(3660700001)(10290500003)(2950100002)(3846002)(2900100001)(22452003)(10090500001)(86612001)(6116002)(6666003)(68736007)(105586002)(5660300001)(5250100002)(106356001)(97736004)(2501003)(66066001)(8936002)(1076002)(99286004)(2906002)(36756003)(86362001)(14454004)(6506007)(110136005)(4326008)(102836004)(6512007)(81156014)(305945005)(81166006)(7736002)(8676002)(53936002)(72206003)(59450400001)(6436002)(316002)(478600001)(76176011)(25786009)(6486002)(26005)(54906003)(3280700002)(186003)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: tcsRxH48Q+DnN9qhB7QD+GQ8Q7H5j+ytJzmiifC7FL7g4f93HVd+XIqytbZCYFHfCRiwCaSQMwmXJF3pP/QAG73MCMX1HV2aZW0RQC20pf+VHdYaI3gIMRGe8WehFQhTW5JE2E/Z1HbYXPYERAWLhFlPTEbZJZPxl5UE6URXYj8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa7cf64-e7b6-451f-3c71-08d58155c35c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:37.5721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>

[ Upstream commit a9c47abbdd71dceeaf1b923e5ce10e700e036905 ]

Chip must not be in shutdown for reading temperature, so briefly leave
shutdown if buffer is not already running

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/health/max30102.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 147a8c14235f..a14fc2eb1fe9 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -329,20 +329,31 @@ static int max30102_read_temp(struct max30102_data *d=
ata, int *val)
 	return 0;
 }
=20
-static int max30102_get_temp(struct max30102_data *data, int *val)
+static int max30102_get_temp(struct max30102_data *data, int *val, bool en=
)
 {
 	int ret;
=20
+	if (en) {
+		ret =3D max30102_set_powermode(data, true);
+		if (ret)
+			return ret;
+	}
+
 	/* start acquisition */
 	ret =3D regmap_update_bits(data->regmap, MAX30102_REG_TEMP_CONFIG,
 				 MAX30102_REG_TEMP_CONFIG_TEMP_EN,
 				 MAX30102_REG_TEMP_CONFIG_TEMP_EN);
 	if (ret)
-		return ret;
+		goto out;
=20
 	msleep(35);
+	ret =3D max30102_read_temp(data, val);
+
+out:
+	if (en)
+		max30102_set_powermode(data, false);
=20
-	return max30102_read_temp(data, val);
+	return ret;
 }
=20
 static int max30102_read_raw(struct iio_dev *indio_dev,
@@ -355,20 +366,19 @@ static int max30102_read_raw(struct iio_dev *indio_de=
v,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		/*
-		 * Temperature reading can only be acquired while engine
-		 * is running
+		 * Temperature reading can only be acquired when not in
+		 * shutdown; leave shutdown briefly when buffer not running
 		 */
 		mutex_lock(&indio_dev->mlock);
-
 		if (!iio_buffer_enabled(indio_dev))
-			ret =3D -EBUSY;
-		else {
-			ret =3D max30102_get_temp(data, val);
-			if (!ret)
-				ret =3D IIO_VAL_INT;
-		}
-
+			ret =3D max30102_get_temp(data, val, true);
+		else
+			ret =3D max30102_get_temp(data, val, false);
 		mutex_unlock(&indio_dev->mlock);
+		if (ret)
+			return ret;
+
+		ret =3D IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SCALE:
 		*val =3D 1000;  /* 62.5 */
--=20
2.14.1
