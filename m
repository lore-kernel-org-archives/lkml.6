Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521479140-2-10967803625160992116
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
    t=1521479139; b=nGVAsdP5gw9P49C6CKy29Cm58yAG8nto7qK/uVL+hwB0WSA
    EU5p3fLXx86mrVK+HAV/ivvQH212mrsYE4IkL8rrXl/3LARuAsmO46bo9xhS4hMA
    LGSHNV1ZgSh8qNHKKv/K5Yswgp7/w+TcE8if1jM2/tGYbn3HWUzILc22eTjSmZhM
    B783KB7PhbJCj1CNZhtm/lbeFmP8EJl6HaOq+3/OcV8Hdi3E086QbX9py20Q7pBN
    +GMIlrJY8x9rVcBq3pMH48w9UTsu6GFbCsZASSDNICH/SdqsPj4s4TY6V+EzBYqC
    /d+KNdeq9x8RpVcyTaxjtGNuM6oLpGdGB7M5GAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479139; bh=6cNabe
    p6jnYGOzPK5HNaO1YvKlXVuJ3sdKk2MKj7I+E=; b=p3LfGuo1hRZwMvGTRUEZrz
    gg9+njfHXOvf75xPyR41IOtfAV2QdgykH15KYiu58+oLWfxJjOojnl2shYzhFk3G
    F/NFBXLTj8/jaAYGlNi3JHxKMF1XHjT7WDWftGkSm+2jds3z88EbMntaoy0hzJlw
    grt0XOuGBhQJbkV1LRvb1PsniwsP17fnIdofwqZRKaZvFodL5H8dgMCjUqLO2l7y
    uYK73yuAMz3E9jBctxGjWwidRHax5vQogbQULu5I/8Vf6ugRRJ/+D0veG8yRHGHz
    2aGgKRc5Wp1X/jpjjv+92g2VMBhXICRxlT8wTAI8QrwN4rkWRzWr5j81ZyBp6T8g
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TIkememk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeduieefnecuvehluhhsthgvrhfuihiivgepudeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TIkememk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeduieefnecuvehluhhsthgvrhfuihiivgepudeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965268AbeCSRFY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:05:24 -0400
Received: from mail-sn1nam02on0118.outbound.protection.outlook.com ([104.47.36.118]:57012
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966691AbeCSQLB (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:01 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Lorenzo Bianconi <lorenzo.bianconi@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 146/167] iio: magnetometer: st_magn_spi: fix
 spi_device_id table
Thread-Topic: [PATCH AUTOSEL for 4.4 146/167] iio: magnetometer: st_magn_spi:
 fix spi_device_id table
Thread-Index: AQHTv5yD7fzixhW0U0SqaWMJV2UCug==
Date: Mon, 19 Mar 2018 16:08:26 +0000
Message-ID: <20180319160513.16384-146-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:O+8uXRay8L3YOku8ZlLuqJ1lM+qBX82z7NlXUixUKlcto6bGgzMwF9eKmL8xOBvt5te/7aUTLmh2zXYJYTR/WJPXacC/9ElOx2gJD25ZCVnpije/gqUSsVdXjz8sbFXCWs2GiNYlMJXPxuOSa40IzAseUmeEIM3QG9cRSX+KrVwSImKWNA/O4OqINrdZQvVZwiu/pEcRnZ1b9uqNqlDAKAsR3cylDP0mSP2r09ncvEZWQZMR/kwHyXCb8ze8gBBL;20:cnMC9BlYVN2cNUDIqjLhanRJPbQU+1HJlliABBnpWkULzoDZJPtQGe0IaX9s22iGkKte3qCRt1SVGuHGogrWBLBAz3vs8nARfdemHQZHKrajCmZ1WK5cpdIHZ2sJLvYuceBjvE5QpGlSn1M71ZdGYpHE0EtYeEJJ7R92ZNkvH4c=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f2270dad-40a3-47d2-cc73-08d58db3fa60
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10958DE004A6D9DB358BAC30FBD40@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(189003)(199004)(305945005)(316002)(1076002)(7736002)(14454004)(86612001)(25786009)(8936002)(2950100002)(110136005)(66066001)(186003)(10090500001)(6666003)(5250100002)(39060400002)(2501003)(99286004)(76176011)(86362001)(575784001)(4326008)(68736007)(3660700001)(105586002)(8676002)(81166006)(81156014)(106356001)(3280700002)(72206003)(10290500003)(478600001)(2900100001)(97736004)(54906003)(6512007)(53936002)(6506007)(102836004)(6436002)(5660300001)(6486002)(107886003)(26005)(2906002)(22452003)(6116002)(3846002)(36756003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ZtwxSI6X7x77sb6z/qywyA0juWumm1I3boQDeNHWZ2oHZoYjC+qYn6fXIJhLuWove6Ep7s7NeUb2ecx631SSBR2t10dmDU4Q1VDKJlR+uj9jdELu5sHf0I+ZmQPcUBd8vqKGvxC9Khe/hKLchqTUBwUNV308mLE3k0vFfptk2s9MfVuqwInZa1jasJWzSjmfiXmM/DBprUoWWFhRRV67xRFivJ3a4SDIG740eKKhTdei5R7Q3Kl7fK/A7hRoP3uprjEI7a0XLVXuo8c0M7TnOGLMRTiuEQ18TaqEiYAY0RiUdNGtaBEVyZqt4ASswqZMkTvCKSV+q3sse35njqxb3Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2270dad-40a3-47d2-cc73-08d58db3fa60
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:26.0346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>

[ Upstream commit c83761ff0aac954aa368c623bb0f0d1a3214e834 ]

Remove LSM303DLHC, LSM303DLM from st_magn_id_table since LSM303DL series
does not support spi interface

Fixes: 872e79add756 (iio: magn: Add STMicroelectronics magn driver)
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/magnetometer/st_magn_spi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetome=
ter/st_magn_spi.c
index 6325e7dc8e03..f3cb4dc05391 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -48,8 +48,6 @@ static int st_magn_spi_remove(struct spi_device *spi)
 }
=20
 static const struct spi_device_id st_magn_id_table[] =3D {
-	{ LSM303DLHC_MAGN_DEV_NAME },
-	{ LSM303DLM_MAGN_DEV_NAME },
 	{ LIS3MDL_MAGN_DEV_NAME },
 	{ LSM303AGR_MAGN_DEV_NAME },
 	{},
--=20
2.14.1
