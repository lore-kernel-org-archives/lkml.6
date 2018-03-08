Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELuZYYA++U66hzwi7gQQgLrluX/LPGbF3l5wySOewhpIwDBmBQWIum6CgSxRxJ3Awzt6wN7E
ARC-Seal: i=1; a=rsa-sha256; t=1520485577; cv=none;
        d=google.com; s=arc-20160816;
        b=Rxp0WcVUEq4MxVT5kNZjlH324AD30VZoYUCZNPRPvwK6TCM7ifoYH+/2aFO4lWN43m
         6II6igNgOTl7kATstSnFyFxCyTHFkm9d3gfiuFXvmqQicHw/e/TslxdEr/c8QZXSjXs/
         kMMqdy+YpVZZuXybeWksUTsUl+5xDuhhoxH9p/XQ7pnb1ws0erxhQ0rtzoOj91ygrkT9
         UTtNUowV9nHtrIvBjF58EF4LNdi6bAfomtwVkBg5xKAIRDCOhN2a94xKug2SfnMkkUCt
         1Pgc+EPkp7TOkTUnMvRuWyhX3TQpBa7tEjzjpwBX6mvc4KURvg2dcKPz09mHl3k1QAf9
         KWZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=f34cNCekkjiB3tyzKc7GY5QDXMw47+ngrfr35S4UIkg=;
        b=WxORe/fuh16fXuJfTAwCqg7HfF41Cz4amRK3AqfAaD3czunNR3NEZuJ8fjSVfuYCRB
         fMKhhaqqnKfIaVemwl8gfPYYlzVqv27KCbktDCR7YBo/Ahi9GWCfJqpXavcwMVRgUXUo
         xZtFL1/x8oqJYOpFRe5TrLUIG+bbdBW1zTAGSmJBw2GvPJP+gIrOu3rbSuwzev9yjUDT
         NfUbdEZN5KA6bqw2jlHzS17b2eMjiCkgGxmqDN8eytUIb3JH+P3xZEcvQWb3FfuTFH/F
         8PkUojC3nnVJHX5iY4RAgK8Ln8za2WF80yCkGPVBQj0yY6vpmv77Xl/pWLY/GNmopGv4
         LT8A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=PnSCT38g;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.111 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=PnSCT38g;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.111 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sameer Wadgaonkar <sameer.wadgaonkar@unisys.com>, David Kershner
	<david.kershner@unisys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 058/101] staging: unisys: visorhba: fix s-Par
 to boot with option CONFIG_VMAP_STACK set to y
Thread-Topic: [PATCH AUTOSEL for 4.4 058/101] staging: unisys: visorhba: fix
 s-Par to boot with option CONFIG_VMAP_STACK set to y
Thread-Index: AQHTtpqUGM9lHmfN8U2BDseaShv/Kg==
Date: Thu, 8 Mar 2018 05:01:55 +0000
Message-ID: <20180308050023.8548-58-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:NJjFK5AxMiYndy3+nZKoE1zxiCv3d2XORpRVIkWMli3O2buPv7oLdLJ3uQIGpSxwMjLEmJ3AdabhCG819BfZOpcpoKkSa7N70omvKJ0PZOp2ZRKV9H88NC7wTBtqiPSXeM82GiHkfXvImOfAisnkgIBRrwRGqBctCefAHzyTIqMCpuhIR8KuhThooiojYMlnr9DWNlNiNs/+vO+jb0qio++gDdkEd5/9llzHVnmAMv4LTO/MXz+zkHeYgZ4kYrfg;20:SQUYK6X08aOT4G3aeZK6j7VEwZ/2fgh2ODjkoOGswYWy+51evf8LjbAmsQHbjCDtAotfRGA1vNhewiAAEY8HsxdEtiumqUNFQ5otAVKvJecClTRWBAHbl8TXxpjXjPR35HGd1U41DFGGKMAFKk0wxrZIvipIqot6ro1TpTi6lJw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 32e3a755-6aea-42f0-cab9-08d584b251e2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09173811F3A43A0F59ED6535FBDF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(174360191007938);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(478600001)(2906002)(6512007)(6116002)(1076002)(7736002)(3280700002)(5250100002)(2501003)(6436002)(3846002)(186003)(99286004)(86612001)(59450400001)(53936002)(26005)(36756003)(305945005)(22452003)(6486002)(102836004)(10290500003)(72206003)(76176011)(110136005)(4326008)(10090500001)(105586002)(316002)(25786009)(97736004)(107886003)(6506007)(81156014)(14454004)(81166006)(575784001)(54906003)(8936002)(68736007)(8676002)(106356001)(6666003)(3660700001)(5660300001)(66066001)(2900100001)(2950100002)(86362001)(22906009)(129723003)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Dq1oiojM2okC+nZvHYA6u81+M2MuDmMEigyhtCbmHjxeC51E6HHYU315YYSlprzhZXhtW1+2VTje1dcVlq8yx2OKDTluGX6VEGqEjSFT0+Slps+5rwWc59SONegJ01Q2qTYDTOmYtC9y1qBcettyGrs1jBYiZ1JDeZd2MOS+YVCnfhDi6AV1v3ln3kgdk9/MoUprJko8RwD6m9nQ9FTJSurx5L2hfxCVSLwFGe2vT5jKn6fTXZo1iB9aJM3tKdUykCvs5VfVyv+XVtqeTvbntdJ03o3t1WMyRAi1Cbqa/+JZBDeg39483FlcuNU0vMXo1qtO2luwpmjlbx96R8sGZw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e3a755-6aea-42f0-cab9-08d584b251e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:55.9984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594344430683766742?=
X-GMAIL-MSGID: =?utf-8?q?1594344685049956404?=
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
index c119f20dfd44..3f2ccf9d7358 100644
--- a/drivers/staging/unisys/visorhba/visorhba_main.c
+++ b/drivers/staging/unisys/visorhba/visorhba_main.c
@@ -792,7 +792,7 @@ static void
 do_scsi_nolinuxstat(struct uiscmdrsp *cmdrsp, struct scsi_cmnd *scsicmd)
 {
 	struct scsi_device *scsidev;
-	unsigned char buf[36];
+	unsigned char *buf;
 	struct scatterlist *sg;
 	unsigned int i;
 	char *this_page;
@@ -807,6 +807,10 @@ do_scsi_nolinuxstat(struct uiscmdrsp *cmdrsp, struct s=
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
@@ -820,6 +824,7 @@ do_scsi_nolinuxstat(struct uiscmdrsp *cmdrsp, struct sc=
si_cmnd *scsicmd)
 		if (scsi_sg_count(scsicmd) =3D=3D 0) {
 			memcpy(scsi_sglist(scsicmd), buf,
 			       cmdrsp->scsi.bufflen);
+			kfree(buf);
 			return;
 		}
=20
@@ -831,6 +836,7 @@ do_scsi_nolinuxstat(struct uiscmdrsp *cmdrsp, struct sc=
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
