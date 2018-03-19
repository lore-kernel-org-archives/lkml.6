Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELvI9u+X0RiUDtTHnGf+K3Vs/n+S0CPZfsyxWlQzPXIKxVfGEuLu6nocDXcBaK+VKnp7y6F8
ARC-Seal: i=1; a=rsa-sha256; t=1521475930; cv=none;
        d=google.com; s=arc-20160816;
        b=CkAY/4KuJ9XQadstrMSMzLdAXBjdvpV5RRIM2HKzS3Rl838LsuyVCUqvYmQkWERbeh
         cgzEFsPzQ18GWT1jtbLRzZ8U82sxqknI/5VTkFYzGnY72iXZ+AhmQIBOUOrfa90SySQ7
         lu6XZsJFGW0WvqxGaq3UtzqtuRB35WX0azH5XFuw/UOGarzpPhkUjpTXZHs7J/NUYmxO
         OYd0ZWvD1rstJkwuyIjoofoOxHYClR2jPXVWGFYfq55U2ZJ1KZJTehzVH6mQZS1v1q48
         8UlL0hVod6v7u4c3GvhqQ8q1j7TEL2IwZ0OlyPSNvVEuSKxgk64KyKM3Dl8Z7YCYJWe2
         V+1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=uQa+y9GhoR+VL1ruJzkiRzENJU81JjxeenxodPCoy+g=;
        b=zQguxuK53g72rpIwqWDkoseKm4w4HUJhu34Wqr08t/1T2f1cLTHFpHoFK4W+c16WvV
         uVc30WS+CZnYycLFBVOzra3m8v3y3IGGhMOTqoo5pAoXtheQ3BKaph5ndEoObc0uwBpO
         3RXXuOS3IX6gTonPQXaTurVZ2s8Z81N+ZTqw/ANHVdmrjjediawPOp4Dy8RPpg9xgsKR
         ZMMwAXM8JJWikuzVu7b1V1w7amjFSiS91c6ORnXwlKgjYkIzMP4xrnsZW6bbE86RYjp+
         PF1BAlEPRPX5ATajJrXhGlvGLyREyqPWDvQkp//QJrEoQke/abDihdAI0wwZFtavTsXC
         mXlw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=GFMuH9lu;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.102 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=GFMuH9lu;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.102 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 030/102] USB: ene_usb6250: fix first command
 execution
Thread-Topic: [PATCH AUTOSEL for 3.18 030/102] USB: ene_usb6250: fix first
 command execution
Thread-Index: AQHTv50FmIiHINGX4EqGk3usikYIFQ==
Date: Mon, 19 Mar 2018 16:12:04 +0000
Message-ID: <20180319161117.17833-30-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:1GAUv2Wx0P1i6EwnB6afQSqu+n9V1OYIqu+alFSmTFmIH3dc7v8N8g99hLJCR0d5HtTadxeQpopx9IIrP3s8hU7cpbEfsfHXzAertdoiExOSI5hcQWKkbyYugby3nQEz1/po/+d4I36U9eL3yReat7t0Y5I7Hr44wfkn0g7nXcljelHOTVvaRPObqIfBHXloy0hj6kY5OmAwmvznGaC+n/npilroFL2saLbc7Xmd2Ez+v3A/bHHcmHwNNFh9h9y/;20:DY7WAUr9uoZvpf3X3iU6TiGjEm7gMnjTvcgtVid/Yd6BY6lT5kxzcHyP8FQp6pkgSLwg+D7r5XmzNFQfbFHXTJN+u7tmJXY/kYnqUM6Un2yGHP4qGe6oBjc8cp3bGAJYs2EN2oEJ4QDPmB5e+CVERSmLVtP8xyhZq/REK4W5gvs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 96928fec-641f-44b7-693a-08d58db42a91
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920539EDBAEBC42A90234AAFBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(35762410373642);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(59450400001)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(575784001)(107886003)(6666003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 0XTdS+wnT8e+PuA14mOt98XP0fFNyKQQroBRFhQh2/MRnfuo1CnxxSWZEQdTgOgjTieRmty2QMD+zLYogq+shf0j4gRS0spjUt6WISZyMfPK2MEg8xSR+SNe5fFDcGNgVOb1iQXK2crg+NTQPWW8UgXir+XZIZTvboIre/xg8ROwgtTcaBDENwurbnD83gbMOeGofryQmjFy3A3qGRgFGzvGHVtX9msTbHGgdL1hXq7csyMiET1Y+qvbb24OftI8VpgVWSlvtPhc2tASA/9n7LRHQ5f+VkgMIzO7F2Nw08HOsjACYjB0PzV/LtwskDWsBPP6eW9D8psTFO+LlKz97g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96928fec-641f-44b7-693a-08d58db42a91
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:04.7255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595382379241586262?=
X-GMAIL-MSGID: =?utf-8?q?1595383145898729720?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alan Stern <stern@rowland.harvard.edu>

[ Upstream commit 4b309f1c4972c8f09e03ac64fc63510dbf5591a4 ]

In the ene_usb6250 sub-driver for usb-storage, the ene_transport()
routine is supposed to initialize the driver before executing the
current command, if the initialization has not already been performed.
However, a bug in the routine causes it to skip the command after
doing the initialization.  Also, the routine does not return an
appropriate error code if either the initialization or the command
fails.

As a result of the first bug, the first command (a SCSI INQUIRY) is
not carried out.  The results can be seen in the system log, in the
form of a warning message and empty or garbage INQUIRY data:

Apr 18 22:40:08 notebook2 kernel: scsi host6: scsi scan: INQUIRY result too=
 short (5), using 36
Apr 18 22:40:08 notebook2 kernel: scsi 6:0:0:0: Direct-Access              =
                      PQ: 0 ANSI: 0

This patch fixes both errors.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-and-tested-by: Andreas Hartmann <andihartmann@01019freenet.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/usb/storage/ene_ub6250.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/storage/ene_ub6250.c b/drivers/usb/storage/ene_ub6=
250.c
index 26c26e3e21d3..7e0bb58f7944 100644
--- a/drivers/usb/storage/ene_ub6250.c
+++ b/drivers/usb/storage/ene_ub6250.c
@@ -2303,21 +2303,22 @@ static int ms_scsi_irp(struct us_data *us, struct s=
csi_cmnd *srb)
=20
 static int ene_transport(struct scsi_cmnd *srb, struct us_data *us)
 {
-	int result =3D 0;
+	int result =3D USB_STOR_XFER_GOOD;
 	struct ene_ub6250_info *info =3D (struct ene_ub6250_info *)(us->extra);
=20
 	/*US_DEBUG(usb_stor_show_command(us, srb)); */
 	scsi_set_resid(srb, 0);
-	if (unlikely(!(info->SD_Status.Ready || info->MS_Status.Ready))) {
+	if (unlikely(!(info->SD_Status.Ready || info->MS_Status.Ready)))
 		result =3D ene_init(us);
-	} else {
+	if (result =3D=3D USB_STOR_XFER_GOOD) {
+		result =3D USB_STOR_TRANSPORT_ERROR;
 		if (info->SD_Status.Ready)
 			result =3D sd_scsi_irp(us, srb);
=20
 		if (info->MS_Status.Ready)
 			result =3D ms_scsi_irp(us, srb);
 	}
-	return 0;
+	return result;
 }
=20
=20
--=20
2.14.1
