Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELtpN6f630qYiTVmZqi2ptqFltKJuq3kI0fuo6i9PRHaEo+9v1bevGiUhSf9bYlbNl0Nt+KV
ARC-Seal: i=1; a=rsa-sha256; t=1521475200; cv=none;
        d=google.com; s=arc-20160816;
        b=rf2Lgo+dAOKrd9XNN8yLGuVI+i7Ynet9Ql9tCoWehz2D2WMQbHM3R7XrBHnZBJxQp0
         9xMZEdB5DWCdbj6LwWSrnBM0MMXD494ldng1BRAcrmgvGKTaGHMxN05MdHtStoRwgHqV
         mR7ZwgjFCAsKCMdWZZlMOWH9CsE6wGanVXzsTqr7pOMTq3+ip0cDdl0ApnuRmmF3jsuG
         UzoJJkYocHIJcRulY2dz9TZ6xvRpU6JzvZng8ieSLpCrDLjS/pH+zAVsCzmLkT7eQSJr
         7fmujiSKYJAVj20xKmKBqMABYd9uLpiNtXuWfKf0S4D7n/QZvZgpQKWQ1COQ8oGUKkTe
         lBEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=MG49SRfUViZLlts40iGA1t+KEtup0oRJTMnGQsHpWz8=;
        b=0ZJQkyHZWoGVkPz9WrCqOVUxfr1WLCTOVZrxOeFf981LXnC+ztO1aIr6EJT0LvoJJo
         Jx7bBqEBlnWLibh4cfE1+87SN1TPtWkgC92leQtipHBWNPlvf8NKKpVyWD1d4Cp177X5
         1z6pJEevdFaV+ru+aFkgcbDM+oXsqH5jmos6CisNECH+QDieGHem9s1kFhflJ1+1vizB
         wZJf9gVbWctsU7/k7i2bfjBoXgVE1dslSUOOIf+nuiiyM6JfsR0++PQ1W/rYoLHo2wss
         KBn8ibFquHeTzxRZ8UTg+tmG9kh0lrOpjw8Sd3u9HDRA/FTM6QkASB1eZDOI4uuqLwWH
         rUUg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=NEXX3vHM;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.132 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=NEXX3vHM;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.132 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 070/281] USB: ene_usb6250: fix SCSI residue
 overwriting
Thread-Topic: [PATCH AUTOSEL for 4.9 070/281] USB: ene_usb6250: fix SCSI
 residue overwriting
Thread-Index: AQHTv5s4un9K7Tcz00eGcqYglC3wwQ==
Date: Mon, 19 Mar 2018 15:59:11 +0000
Message-ID: <20180319155742.13731-70-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0869;7:fFSYzpOooBwsJ85dYj8qhXLT6XtqQLjN5RRYmbyKxndfH/bKMncd+n2h8QomS/Z/FHdltqsbwmkOPCudoXGAM5Cs3k2f21scT1qEhvl6njBfY7YEhNI0Zp8hkbC6pBy0BK8Sgzm+nnjjFY5HuDNqbSYOChaBhgLoRIPfKp2QVRERyxljJxQf6zObg562EzuhVmnINLiTzyc93gPkBwvxdMywWIZrAXBquLDddPYKm9qXjET428GNmuKg8ff0dmDj;20:QoQX0gbo1OAa7FhrrCnXLWlcx6q2KnNKRrVdZdfn+UTE4vLsKxA/dfNu4btgM5mm6qIq2nQfDNS9eEebaVv0y/LNrcQBTAmIoWx5si8mSQArMdn0kHYXHIxPkeMmOPCKhspgV3qPAJ8O5Gv2JSNT5aBT1m6PfCosDml10EpCs6Q=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 55c6592d-c8c6-44c7-2914-08d58db2777d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0869;
x-ms-traffictypediagnostic: DM5PR2101MB0869:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0869F131C55805CB8958462BFBD40@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(35762410373642);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0869;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0869;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(346002)(39860400002)(199004)(189003)(76176011)(6486002)(2950100002)(6666003)(2906002)(5660300001)(54906003)(14454004)(110136005)(7736002)(2501003)(10290500003)(106356001)(22452003)(59450400001)(3280700002)(5250100002)(305945005)(25786009)(99286004)(107886003)(10090500001)(6436002)(26005)(97736004)(53936002)(86612001)(3846002)(6116002)(186003)(1076002)(8676002)(81156014)(81166006)(68736007)(102836004)(72206003)(3660700001)(8936002)(316002)(478600001)(4326008)(36756003)(6506007)(105586002)(66066001)(6512007)(2900100001)(575784001)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0869;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: eSWpUDAM/dbO1RFPvDi1wK/rILrIGWsC/bZRu3of2rNxWDDqXjSTvny/hbpZsebHDFRsz473Pg4y0uPGXMkz16rWqxaCrbqDOv/QRIhT096t0mTKZX6o3TzvyAKgzNEYdT8iZiCkdMHmpYov1izKdRhnlEVdiLkGWqitEuvNCWMgAMD1q1sdjNbycrePeCxlDQ4Ja8ERqfZd+y/yD+WldR613bvbBh8Z3MiT6AU45iiOQRMYc8tfevfNh3oZDWkPbqXJtQeyDQzcK/LTnH3IBkPxZk3KDVCdEy1eyhK6cfdaeb7FB1/eyknsEcO/GLCjz46zsGSE32v5OIVmj1tMbw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c6592d-c8c6-44c7-2914-08d58db2777d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:11.5725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0869
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595382379893976957?=
X-GMAIL-MSGID: =?utf-8?q?1595382379893976957?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alan Stern <stern@rowland.harvard.edu>

[ Upstream commit aa18c4b6e0e39bfb00af48734ec24bc189ac9909 ]

In the ene_usb6250 sub-driver for usb-storage, the SCSI residue is not
reported correctly.  The residue is initialized to 0, but this value
is overwritten whenever the driver sends firmware to the card reader
before performing the current command.  As a result, a valid READ or
WRITE operation appears to have failed, causing the SCSI core to retry
the command multiple times and eventually fail.

This patch fixes the problem by resetting the SCSI residue to 0 after
sending firmware to the device.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-and-tested-by: Andreas Hartmann <andihartmann@01019freenet.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/usb/storage/ene_ub6250.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/storage/ene_ub6250.c b/drivers/usb/storage/ene_ub6=
250.c
index 4199fe563c71..4d6eb48b2c45 100644
--- a/drivers/usb/storage/ene_ub6250.c
+++ b/drivers/usb/storage/ene_ub6250.c
@@ -1942,6 +1942,8 @@ static int ene_load_bincode(struct us_data *us, unsig=
ned char flag)
 	bcb->CDB[0] =3D 0xEF;
=20
 	result =3D ene_send_scsi_cmd(us, FDIR_WRITE, buf, 0);
+	if (us->srb !=3D NULL)
+		scsi_set_resid(us->srb, 0);
 	info->BIN_FLAG =3D flag;
 	kfree(buf);
=20
--=20
2.14.1
