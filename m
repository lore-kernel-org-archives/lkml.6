Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AIpwx4+HgBhdevPd0GO0xQ2Hontv9u5kXjB9j6F961sx3caFaWxxaWa+WMZjN0uH9p3Tw1JOkQm2
ARC-Seal: i=1; a=rsa-sha256; t=1523233435; cv=none;
        d=google.com; s=arc-20160816;
        b=ZGDcrv4Z8Ytj+AupTJqzsNm0d6sFe9HRbPhdU/ZxuLWFzXn8nqh/V8yWqKLYG/2Ub7
         prYWWrAW2i/fMF9pyK1B+9li/zEFl2b5RNvULiVdbuvEgbh1qZa9Ys7DFim0g7SLTV9E
         LY6NPxVgDmxZ9PLobIRd4NS6OCdyb+EJ4gw3lO/2SbjINUD1yAMfpzlI6wMp5ZQryL9i
         56KRbnqXHM3V90OpI4tVKL6kZyzWR9Za2N6aV/xNEbpqlgZ7YjGq96sV+SD5XUPlKyGz
         csLys5B5xK08NcqKQI6SgmVumI9I/QGtSKkQfqJ2mZGCaZg9S9q1Q41wJgslCL2VX+Aj
         GGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=Wj9FUVSW7K+5tU1QhFyD7iaiaEkFF+zBEs5JH1H9JTg=;
        b=m2T7ATc2EyCXK3zrEaT5VGWpJpnkLSvyj5HiJyKylmtELRf7IZWD57mZhp/kUxOFur
         fxWQtuzTzFncfX8J9xRj6Zj2L33gvyz80hRjJ42dDvB9gygI4IEaW4cLtTEvjK+eOHzw
         DpK7UI0DLyhn2ETnNxrstfO1TxJl8jQBgkOhiC/x2ZGmtDMl2xCw2EkNt+kszRHC8S4S
         GkSfEIxbOu6yGSYJ6Yod3yVxcUlJJPeSOWWjw/sWV5+LUdzcCBN2RaxZrZqSVO/HmNaK
         leUDjMPiYIGw1nHhrJ9zOrL+sLR71e8bqZuVo/02S/C4X+//NSwns9+DztIonsrAwnd4
         VXMA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=XzWKfCxd;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.107 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=XzWKfCxd;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.107 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Corey Minyard
	<minyard@acm.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha
 Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 077/161] device property: Define type of
 PROPERTY_ENRTY_*() macros
Thread-Topic: [PATCH AUTOSEL for 4.14 077/161] device property: Define type of
 PROPERTY_ENRTY_*() macros
Thread-Index: AQHTz5icJkNoN0BHxkagENnnT4xuGA==
Date: Mon, 9 Apr 2018 00:20:49 +0000
Message-ID: <20180409001936.162706-77-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:IMGoDMfuadtjcxx3TZroj+PDxnaPH761bvkFW1kNSGJrhIncb3+mQomouKZ5/EtAQ/JFq3P9yloHqMnWN3WtPAqmbhawiG17Bc3VMLzOZlscviw8+jH41lqqDPyWLlbePbVPiWYs8GfhGK7rpwfQ1gikSz3JuUHBnCFyjNgxpxFrFBkh9bs3rPgYBXGv0Qh24v41XcK6NjvCZG7LvUKSEsftttmShW3XA5L3PWFQbr35GAfD+joTtAHZiMrm89Qk;20:eLyCHsnC6Z7bt6ZEYb2L/GM6e8xhrddMeKn/Qu3HA+4Gh9TmPfCLwj85qysTGlQNfaJqSQE4g+rZlyJZR1iFIMaLY3lyI6KOzudNCsVMlswXW76hHwAb3V4vbYtOBDnZt1BC6yozUkYBRKv6BZXRfpHYokhVdepBReBQ3Ki97i8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: e2092c9a-624a-40c6-ff6c-08d59db02c80
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0984862140AA43B0AB477A4FFBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(213716511872227)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(366004)(39860400002)(396003)(189003)(199004)(5250100002)(2501003)(110136005)(54906003)(6116002)(6436002)(11346002)(1076002)(486006)(25786009)(105586002)(2900100001)(102836004)(86612001)(3846002)(68736007)(107886003)(316002)(10290500003)(5660300001)(86362001)(2616005)(305945005)(4326008)(446003)(6486002)(22452003)(7736002)(476003)(8676002)(81156014)(81166006)(8936002)(6512007)(10090500001)(186003)(3280700002)(106356001)(76176011)(2906002)(99286004)(26005)(97736004)(14454004)(6666003)(478600001)(53936002)(6506007)(36756003)(72206003)(66066001)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: AVkGRRhu5Vz/8ZSWAE81naIkzQxeGjSiZDolLo02zt+mdBxt5DjBR6afVr6X0CZ6p05HonUYpXCEXDNS3Oqz2oQwKbVMTxTtXnRRXaIdi2mVr8THMUd8PDjvanEPaCEy8hPUR7NWESssP4McApBan6ezOu+xJA5fsS3csL1SWaTjjsYpGwjzArx0zj6p5GY7G57EL674ha4NCmCI5oZV2JJzVrDhN2xXQFuDvmLHTMQQX/mG/rtszDzTP6OOq6U4mbAFkNn/T0bro20zNnmBQw+uSmnGIBo5Zr0WlRNGV2tP83QVd0zEAxnH4NjKG/Ig40wFaCalVCelbHlibxrT+EXPXEl+/z+GIvYd4piGmH3zpEhOOh9o1IN7FXEOUUttnxFgVpCJPPZaGNyEVS3UvMQCDQLZhaLVEoq1cQhWxvg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2092c9a-624a-40c6-ff6c-08d59db02c80
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:49.5503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597225731447440120?=
X-GMAIL-MSGID: =?utf-8?q?1597226022778220762?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit c505cbd45f6e9c539d57dd171d95ec7e5e9f9cd0 ]

Some of the drivers may use the macro at runtime flow, like

  struct property_entry p[10];
...
  p[index++] =3D PROPERTY_ENTRY_U8("u8 property", u8_data);

In that case and absence of the data type compiler fails the build:

drivers/char/ipmi/ipmi_dmi.c:79:29: error: Expected ; at end of statement
drivers/char/ipmi/ipmi_dmi.c:79:29: error: got {

Acked-by: Corey Minyard <cminyard@mvista.com>
Cc: Corey Minyard <minyard@acm.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/linux/property.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index 6bebee13c5e0..89d94b349912 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -206,7 +206,7 @@ struct property_entry {
  */
=20
 #define PROPERTY_ENTRY_INTEGER_ARRAY(_name_, _type_, _val_)	\
-{								\
+(struct property_entry) {					\
 	.name =3D _name_,						\
 	.length =3D ARRAY_SIZE(_val_) * sizeof(_type_),		\
 	.is_array =3D true,					\
@@ -224,7 +224,7 @@ struct property_entry {
 	PROPERTY_ENTRY_INTEGER_ARRAY(_name_, u64, _val_)
=20
 #define PROPERTY_ENTRY_STRING_ARRAY(_name_, _val_)		\
-{								\
+(struct property_entry) {					\
 	.name =3D _name_,						\
 	.length =3D ARRAY_SIZE(_val_) * sizeof(const char *),	\
 	.is_array =3D true,					\
@@ -233,7 +233,7 @@ struct property_entry {
 }
=20
 #define PROPERTY_ENTRY_INTEGER(_name_, _type_, _val_)	\
-{							\
+(struct property_entry) {				\
 	.name =3D _name_,					\
 	.length =3D sizeof(_type_),			\
 	.is_string =3D false,				\
@@ -250,7 +250,7 @@ struct property_entry {
 	PROPERTY_ENTRY_INTEGER(_name_, u64, _val_)
=20
 #define PROPERTY_ENTRY_STRING(_name_, _val_)		\
-{							\
+(struct property_entry) {				\
 	.name =3D _name_,					\
 	.length =3D sizeof(_val_),			\
 	.is_string =3D true,				\
@@ -258,7 +258,7 @@ struct property_entry {
 }
=20
 #define PROPERTY_ENTRY_BOOL(_name_)		\
-{						\
+(struct property_entry) {			\
 	.name =3D _name_,				\
 }
=20
--=20
2.15.1
