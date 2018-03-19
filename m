Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELsEuZzub0dA4vnVISMTjtT6gtSSO3KX4u4RgOGxQzT/bvZad75T5ueZSKGzj5dIrGN2dntx
ARC-Seal: i=1; a=rsa-sha256; t=1521475196; cv=none;
        d=google.com; s=arc-20160816;
        b=jGVa72oVPIjBAoDNUS3udMzZOHoH5YgLNRgIgEmjN3rrt3q7YU9hVXpmWA32G72f07
         f0LvdI3dx5T1wvy3ptOu7WD7NG9cCgscye3qXhtI+6IE0URFoRqQSAPQ66+Yhhsusf0c
         B8QMiSkssNBwIEiJ0FgHL+H+SEBDnyJ8Is2+doFpwJU4Zjtty8cJYfMX9+7dktT1ZfBA
         0mVM7hOQ4+W9hwUiucRzv/2imF52eoePLKOAmaGg6DKjnyZS2pk6tixWtficupfQus0W
         v1/KzkO7DGnER8kCMkEhnyAI81gMhKNRp4AEysUEc0fhaR/hAL3pt9zZZ98zuxM59jEH
         Ka/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=R6Ep0p0kmfv9aZ+UO19+Tojti3NkRi5DKoH3sh5YEOs=;
        b=i5oOHoTDieTPU3FJWS8zsYh1nbwzOXLth7Nklqb6E9SHAjJ7iMLSb7fi2JVGgoWlSK
         6m/mSXnpBCXhJlmbRX85MhKOwQpZldBntrE5z0TcJRJnnhi2ylQ/dUDa6ky3fHgTswWW
         SB3scU/asSe/VdYnmnPbUR6HsbvfXqy6LhodbfPAS4k9ckgxs6GBSyKKsuJSOh5wPG3d
         /5gQ0BnofxJ9cDTEmweccLkYhN8fL7HnW13qYqOrMZWxEFgufyJBByzev/VXyWkA6WHz
         TDvznzdXaljOaOwMw6jhLiS9PeyRE0HzB2ZppVyIRDiwUhYIbWm4gIknhXoGtvm9+bPv
         Fo6A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=SGrPwA3p;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.34.136 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=SGrPwA3p;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.34.136 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Suman Anna <s-anna@ti.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 062/281] uio: fix incorrect memory leak
 cleanup
Thread-Topic: [PATCH AUTOSEL for 4.9 062/281] uio: fix incorrect memory leak
 cleanup
Thread-Index: AQHTv5sz9quVrKCnTkSJB/hrvviQAA==
Date: Mon, 19 Mar 2018 15:59:02 +0000
Message-ID: <20180319155742.13731-62-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0965;7:US3Zs0j02vQ59ji3Wj4wR+goe8XCIYLP/k/CAojThIjGV127xbavOAxOvuVzUERyE0yBO1b9qHrtajoT1pvGUbhs0HjBSMzH+++xdovzT5FdXKyw+SYHW1s7whvPfYnijhv8Eo8KU3MyGy4se19H4QtUjNpu6a50kaa6FAcOKYmQukFYg2+6sdh2FmWdwpTR/JGe65vDg1dUzHJvid6rrPeXKZV5TaegzYIJ8QATSoOvzBZd0rGnHfs5NlX5OpG6;20:0cM0MKeO8Gz4FuVdKLXYxxBK+QZKiX523pwMmfOdLnM1aim8KWXcfLx5wkBJChDDPE9iZHJLFHHlh2NeMkRqRIM2pk33l94NKHUTcy2g7Lm7snIrEQoH5Mqepdf1uN8hcsT5j8eflLEo42rthjXejEgkDFHMgSIOG0LbNggzJhs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7f5f0e1-dd88-4fc7-df25-08d58db274f5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0965;
x-ms-traffictypediagnostic: DM5PR2101MB0965:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0965C575B0051816D3B3A079FBD40@DM5PR2101MB0965.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0965;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0965;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(39380400002)(189003)(199004)(25786009)(7736002)(6506007)(86362001)(575784001)(86612001)(10090500001)(478600001)(53936002)(6666003)(6512007)(36756003)(2950100002)(8936002)(110136005)(54906003)(105586002)(14454004)(107886003)(72206003)(10290500003)(316002)(102836004)(2501003)(59450400001)(5250100002)(99286004)(22452003)(305945005)(6436002)(6486002)(1076002)(76176011)(26005)(4326008)(186003)(97736004)(106356001)(3660700001)(3846002)(6116002)(5660300001)(68736007)(2900100001)(8676002)(81166006)(81156014)(3280700002)(2906002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0965;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Y3TJAvsUnRZ/kJ6oDUSxVMY2DGFxLCcwBy4GeKaZZnKm1YrQKiv7YnqO4j0h4mhLRvRn295LIFdekTu8dQtVIGugJ22TcA62PaC7SdJTuTQvIc1RocQKeziEk+XCnE+pJ5i6qckIdvHmCOm1naZCKmJYcrhe3m673iPWmyCEUn0MBbY6zVSrOylPiTEkrk6VSoCp9MDRcd9LhCVAxECmXEYr3WEU3G1zYbQNjRIyaKzb4Ili0VaD2GbCLKaQVj9+ewkRphtHruH3FYzYp403bd6vdIOl907ervNS2SbwON+YCzjRT7XgjlURq7NJyw2eKSQ4OXCv5GR0YCj9WcXdxg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f5f0e1-dd88-4fc7-df25-08d58db274f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:02.6410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0965
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595382375727223996?=
X-GMAIL-MSGID: =?utf-8?q?1595382375727223996?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Suman Anna <s-anna@ti.com>

[ Upstream commit 0d83539092ddb1ab79b4d65bccb866bf07ea2ccd ]

Commit 75f0aef6220d ("uio: fix memory leak") has fixed up some
memory leaks during the failure paths of the addition of uio
attributes, but still is not correct entirely. A kobject_uevent()
failure still needs a kobject_put() and the kobject container
structure allocation failure before the kobject_init() doesn't
need a kobject_put(). Fix this properly.

Fixes: 75f0aef6220d ("uio: fix memory leak")
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/uio/uio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index fba021f5736a..208bc52fc84d 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -279,7 +279,7 @@ static int uio_dev_add_attributes(struct uio_device *id=
ev)
 		map =3D kzalloc(sizeof(*map), GFP_KERNEL);
 		if (!map) {
 			ret =3D -ENOMEM;
-			goto err_map_kobj;
+			goto err_map;
 		}
 		kobject_init(&map->kobj, &map_attr_type);
 		map->mem =3D mem;
@@ -289,7 +289,7 @@ static int uio_dev_add_attributes(struct uio_device *id=
ev)
 			goto err_map_kobj;
 		ret =3D kobject_uevent(&map->kobj, KOBJ_ADD);
 		if (ret)
-			goto err_map;
+			goto err_map_kobj;
 	}
=20
 	for (pi =3D 0; pi < MAX_UIO_PORT_REGIONS; pi++) {
@@ -308,7 +308,7 @@ static int uio_dev_add_attributes(struct uio_device *id=
ev)
 		portio =3D kzalloc(sizeof(*portio), GFP_KERNEL);
 		if (!portio) {
 			ret =3D -ENOMEM;
-			goto err_portio_kobj;
+			goto err_portio;
 		}
 		kobject_init(&portio->kobj, &portio_attr_type);
 		portio->port =3D port;
@@ -319,7 +319,7 @@ static int uio_dev_add_attributes(struct uio_device *id=
ev)
 			goto err_portio_kobj;
 		ret =3D kobject_uevent(&portio->kobj, KOBJ_ADD);
 		if (ret)
-			goto err_portio;
+			goto err_portio_kobj;
 	}
=20
 	return 0;
--=20
2.14.1
