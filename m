Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELscyxAwlWZlzkQwmCcOBzDCmbXZ6lWyABmwUXELuSlKzWvOtHj4UtWRsGJy+3SQRYts897t
ARC-Seal: i=1; a=rsa-sha256; t=1521474955; cv=none;
        d=google.com; s=arc-20160816;
        b=yDuSyiqm0hZMLvmp4doi2T6A1knbqyztmTixeU3ADO0UCzPFx5JePn4PlIPa4VpvgX
         31AqDuUbzR4HYu3pp900+JEf2y/eDmDSTDMi2ewmYiiGxBZRvR9XOI3/gSjuMlroUJU/
         ZSdw345Ie9V/YIDVp1mJwEOrzIyWVA+6jnG+m4jU0V0DtYYvZ+fyApF1G576sDiRBhwp
         ptOpiyYERCpsn0xyDKqZCdDc21T8T6nXywhth9xxcArNnAkk63R/ysGafGUdOVetaqQT
         O9pVbNv7nL0Z2vyeVBTGso7JTn3F/gVb70/BZCAms+er/k0Jmb1jvf8QLQoUV1RMGYxm
         m4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=Fr9u81r+etOWOjCGIvQnGtK8MXJwMO3IpphArNGHKrc=;
        b=mraR5NfIcqocTQsjgF+ycFxT+cGJZU5ORq6aaCc7KJmJaAtWMkht6JViugjFnB6rVJ
         YvLGjKLgG6Q3/CeyFTR/V2CVFg83LIaqDMpY8CsGZNrkUEZyFNMTikrLcHuNYakATMHY
         IKcalb0i+Gb0q67oUx5T2eOAAyGw7H4x1/rMs7DreQx0uI8aHEEc+3CEUiUFou3KaBkE
         J9zi+kPjs9hkyFCxzJRRi3nrcleX0oUajZ6lqA04iHlU4hbOVkNpN7zrGjA4c5zQ9zv9
         Oc2GTIJSW4VPe9NzL1aZwviL4T0dDyVa7E0j3lKwBCrTAz3j1Fr3ztXYlWQZky2jEv2k
         tWkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=g4FAW/qE;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.106 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=g4FAW/qE;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.106 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 51/97] iio: imu: st_lsm6dsx: fix endianness
 in st_lsm6dsx_read_oneshot()
Thread-Topic: [PATCH AUTOSEL for 4.14 51/97] iio: imu: st_lsm6dsx: fix
 endianness in st_lsm6dsx_read_oneshot()
Thread-Index: AQHTv5q1Us5JWpV5CEGYg9wqGKMkxw==
Date: Mon, 19 Mar 2018 15:55:31 +0000
Message-ID: <20180319155411.12348-51-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:TQ3QPQC3rm2hj7k7kvqFKO7a9hrzbm2alnXqWqgT3xNGdBVS8Wu9UiOnIBJ6ebTPc/hN5q0UPaUVl+6IgGntNFumwzWLzVTrzrPrFTUZ8XingYkmeSm3JpDACf7zdmKgECHphBauxxW4y3XYrkl8O87Ag74YrK32otseYWc8zWgkzs2sUQpZ3i0zJuQcAMx1Wxd6j3RvfYMluJqA0YzkRRrYdBEcFQT3HO8yt7xSKAjZ7c7rxwiu5x+g/zzaudfl;20:sWBC3rbeFcZZaKnWDSpSfJTYTxTaqqxCUPZg/KWv/OPT/mvFo3dOf+/uN2qAb7CKMB/BmV7/AIXJbYDn7iizkuYyKLhqoKPlfLr24zxtAeA/G1cooUZyPtrbru6ja01NPJ4gJM+1BWobk8hAPMRC4kA1ySH4ErTeorC9bS6TFvs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 17f3ace7-c04f-4589-829e-08d58db1e3cf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0967B21E923F9517A01ACA19FBD40@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(39380400002)(376002)(39860400002)(366004)(346002)(189003)(199004)(54906003)(59450400001)(10090500001)(110136005)(5250100002)(2501003)(1076002)(6116002)(3846002)(2900100001)(15760500003)(99286004)(22452003)(3280700002)(186003)(2906002)(76176011)(86612001)(26005)(6486002)(10290500003)(102836004)(14454004)(36756003)(68736007)(3660700001)(72206003)(478600001)(107886003)(106356001)(53936002)(6506007)(6512007)(6436002)(86362001)(575784001)(105586002)(316002)(7736002)(4326008)(305945005)(66066001)(81156014)(81166006)(5660300001)(97736004)(8936002)(25786009)(8676002)(2950100002)(6666003)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ztQHnYWnVYzzDuRzu6w8clYZybG/bcQFmhbCWyRKsb5u13xAzQC62vmwCUKqo3TA7caVe1g2+0rtH7jwqE80W+z7dZw33N5dadKHL4oqMspPc+fupe6XCR6oyxWAlwuPy15qL2zCUWkSp9fge74KoYP5w5zYNT+ahna7hu4GEsPA92wHohyySdhvwJiWq3cLAM+RFvqtzDiwAQ35SOFrU878IYTDcNCkP4hytNVYKhZIuyvgO+86itghD0jGrPPK1xzBmA8Ihk4Ncv8YPOM0nRGuu2iEg6NpoS6EC1LMNzp8qcR6LrCHr4xMHeUar7ujLWSyfVdQpYKc4L8vSlhgag==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f3ace7-c04f-4589-829e-08d58db1e3cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:31.4893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595381681069807099?=
X-GMAIL-MSGID: =?utf-8?q?1595382122987619335?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

[ Upstream commit 7b9ebe428266fb7e0a6d769bb3ff3fcb6044b15e ]

Apply le16_to_cpu() to data read from the sensor in order to take into
account architecture endianness

Fixes: 290a6ce11d93 (iio: imu: add support to lsm6dsx driver)
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu=
/st_lsm6dsx/st_lsm6dsx_core.c
index b485540da89e..cce0c93accef 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -392,7 +392,7 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_se=
nsor *sensor,
=20
 	st_lsm6dsx_sensor_disable(sensor);
=20
-	*val =3D (s16)data;
+	*val =3D (s16)le16_to_cpu(data);
=20
 	return IIO_VAL_INT;
 }
--=20
2.14.1
