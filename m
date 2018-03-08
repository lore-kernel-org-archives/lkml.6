Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELsB02cWEuC/zGLiRiz/AiTjl3bA2PZSE+i5Jmulb7s2IjogOt7W7KKvFIlNyor2Q8OfAsDx
ARC-Seal: i=1; a=rsa-sha256; t=1520485335; cv=none;
        d=google.com; s=arc-20160816;
        b=fPuuJi/UPx+AeJfD5EI6eeqQfnjU2OzBrXSvGjBGJZ8WmpRBkQCaONJXnC4GtsugjA
         y3uQmS4YJtmHIA8CcQO+xNt1lsABBtkdI7G65q/Bs2Lv0H8bTLHQq0mjGr5C33HB9FYp
         xbG9O6xVnJ3SVhBztBqay7d7nB/qZ8NUiyQFl5tr1ZxIqrha7oLeYtK9tJuepzhZJVBg
         dJrVMqXD/pEKaoQPwK7w02HIrZLInYarCAql0TdFZMdz5/Pqa+Il/jHd/MZAmbD1cIL4
         8s19nVJOG0slQx5YN/3KozzzxtYoVvpeVu8XuvLbtZTV+UH/Gr2FrNRCG1hWi89I51ST
         jEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=cv4Il1ak3UdrS9sI0y4dZnagKEpA7LBoKXYNKftvtCU=;
        b=LHibAHdlrTzsfEt/tyt8p5F6+B73KNwGZ7tN9ZUWMjs8RBt8gSUse8vLZlWSp5ZNTP
         60k8Mm/w0KIuShUMTs0o57tx1hbzyrFkb6OsHFAmxToaeyLD/yjBhmGoWoo0mHo/scgO
         8NgHEl+ONTjYaV+VY5UYbmeXXNsPSp3a97KcWUO5jKvttrhLo5boy5wRQnJ0+vek+oRO
         M39wvL0Z1W0gTXguotUYDert6jL5h1sp6GG0uql+6w0EQfU12CXrSUIEjqS4vV5X/Pfq
         gEhWYlMNotWLN+yS0/wKScbS0tZYkU9mjHy/NKDCGIejsTHapBuaEEQPCSWGUhtjKboC
         jzzA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=NcBprmkW;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.90 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=NcBprmkW;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.90 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sameer Wadgaonkar <sameer.wadgaonkar@unisys.com>, David Kershner
	<david.kershner@unisys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 105/190] staging: unisys: visorhba: fix s-Par
 to boot with option CONFIG_VMAP_STACK set to y
Thread-Topic: [PATCH AUTOSEL for 4.9 105/190] staging: unisys: visorhba: fix
 s-Par to boot with option CONFIG_VMAP_STACK set to y
Thread-Index: AQHTtppCSfyCcoKdFESuL4izOlLGJA==
Date: Thu, 8 Mar 2018 04:59:37 +0000
Message-ID: <20180308045810.8041-105-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0997;7:chp/afG0BQ4LdiVg/uF8naLWme3v0U6LvuY0/7MrqOZ2bmm035ppYJ+KfNqzm9gcqbqU5sZTtVH+A8Of/UlsO+7DzZT+pUZekiXPIRO8Qk6EBoKd1A/4QU0hhllKb5i7/Erf+a/P8jhauorLnmq8GriOxqU12ihIauIEw5bgs0rH5bfo47+I6cQVjBWGNfeu8oq+Pwi9dnu3yzA06m2n+lUJXKccIOjf4INQCKYWB7xCTn+ZDuBU5QELmYUvKTTT;20:pgGP5UYvav3QUsZ6wnwIV2a7e6NKBkAsfo2e8tR1W3gBkKMji3F8P/vOBsxNpZLfL1tuhqeuY/N3XK5wnMck8OzyMZR2UF/Qi6GFWjgBy3ZB/FpPwAYHEVmLkKHuITGmB6PtVyNdUgARBQl+EAtts5aW3nZU0k5cfUfOMErRlCw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8aa8b395-5880-40ff-6ca5-08d584b1c166
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0997;
x-ms-traffictypediagnostic: DM5PR2101MB0997:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0997B9F77692078BA0D6F75FFBDF0@DM5PR2101MB0997.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(174360191007938);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0997;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0997;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(366004)(346002)(189003)(199004)(97736004)(54906003)(76176011)(2900100001)(106356001)(99286004)(110136005)(316002)(3280700002)(22452003)(10290500003)(105586002)(36756003)(25786009)(72206003)(66066001)(3846002)(6116002)(3660700001)(4326008)(14454004)(1076002)(478600001)(2906002)(10090500001)(5250100002)(6486002)(86362001)(575784001)(5660300001)(186003)(305945005)(8936002)(81166006)(2501003)(26005)(2950100002)(107886003)(81156014)(6512007)(86612001)(6666003)(8676002)(102836004)(6506007)(53936002)(59450400001)(68736007)(7736002)(6436002)(22906009)(129723003)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0997;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: SIdDd/Lr7RZlcE4RZ4lhxfFmaNkJR1duOAKZVRN9WZiBKLZil3VYuWeQi88g3iJgAdEsqPtXxu4PP4CiudfsateLEBXgViG8+cHqr9W9rgVosU+ow9Er3u1+JAceapzhiEeJ93+cS66cxvCMDZiwiZ9HbWT+iHgxuqoQ9NEe3gqCxmDfPFfbRII5ICqpDrRa6IrvZ3ImGUNEop8PQc8Hln8aXJOVZ0cE4G8xvLdyHwepceLKv0zixMbOMLYjSOgHo+SAiex35sh0icZDNeDNVFUhfN7jRPen4m65DnvvKZO2lyD+vlIcVcCd1dwVWIZ4IaWLsvcbONT0V/5HjTIAGg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa8b395-5880-40ff-6ca5-08d584b1c166
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:37.7736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0997
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594344430683766742?=
X-GMAIL-MSGID: =?utf-8?q?1594344430683766742?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sameer Wadgaonkar <sameer.wadgaonkar@unisys.com>

[ Upstream commit 3c2bf0bd08123f3497bd3e84bd9088c937b0cb40 ]

The root issue is that we are not allowed to have items on the
stack being passed to "DMA" like operations. In this case we have
a vmcall and an inline completion of scsi command.

This patch fixes the issue by moving the variables on stack in
do_scsi_nolinuxstat() to heap memory.

Signed-off-by: Sameer Wadgaonkar <sameer.wadgaonkar@unisys.com>
Signed-off-by: David Kershner <david.kershner@unisys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/staging/unisys/visorhba/visorhba_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/unisys/visorhba/visorhba_main.c b/drivers/stag=
ing/unisys/visorhba/visorhba_main.c
index 5a7a87efed27..28b5392153a8 100644
--- a/drivers/staging/unisys/visorhba/visorhba_main.c
+++ b/drivers/staging/unisys/visorhba/visorhba_main.c
@@ -842,7 +842,7 @@ static void
 do_scsi_nolinuxstat(struct uiscmdrsp *cmdrsp, struct scsi_cmnd *scsicmd)
 {
 	struct scsi_device *scsidev;
-	unsigned char buf[36];
+	unsigned char *buf;
 	struct scatterlist *sg;
 	unsigned int i;
 	char *this_page;
@@ -857,6 +857,10 @@ do_scsi_nolinuxstat(struct uiscmdrsp *cmdrsp, struct s=
csi_cmnd *scsicmd)
 		if (cmdrsp->scsi.no_disk_result =3D=3D 0)
 			return;
=20
+		buf =3D kzalloc(sizeof(char) * 36, GFP_KERNEL);
+		if (!buf)
+			return;
+
 		/* Linux scsi code wants a device at Lun 0
 		 * to issue report luns, but we don't want
 		 * a disk there so we'll present a processor
@@ -868,6 +872,7 @@ do_scsi_nolinuxstat(struct uiscmdrsp *cmdrsp, struct sc=
si_cmnd *scsicmd)
 		if (scsi_sg_count(scsicmd) =3D=3D 0) {
 			memcpy(scsi_sglist(scsicmd), buf,
 			       cmdrsp->scsi.bufflen);
+			kfree(buf);
 			return;
 		}
=20
@@ -879,6 +884,7 @@ do_scsi_nolinuxstat(struct uiscmdrsp *cmdrsp, struct sc=
si_cmnd *scsicmd)
 			memcpy(this_page, buf + bufind, sg[i].length);
 			kunmap_atomic(this_page_orig);
 		}
+		kfree(buf);
 	} else {
 		devdata =3D (struct visorhba_devdata *)scsidev->host->hostdata;
 		for_each_vdisk_match(vdisk, devdata, scsidev) {
--=20
2.14.1
