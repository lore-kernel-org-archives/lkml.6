Return-Path: <prvs=574ef6db7=Stanislav.Nijnikov@wdc.com>
X-Google-Smtp-Source: AH8x224WkeCoQdgsy2jM05cew+ZQcEpceuPLc8K4I/x6Rb2iE3egEh/f8J92k4OpevuhIstIVWK4
ARC-Seal: i=1; a=rsa-sha256; t=1518434489; cv=none;
        d=google.com; s=arc-20160816;
        b=aSl2voy2so0dAXg4aYddchBTQEaoFVXOBNgVAqWMhkpZBpCG5Z7rFnKRb0ybBxBChJ
         eqTlSn0b59AWHWg7Gjsh3P75rMHacPEtCT/tc5GpgcJugpyHoDwLcjOlMiC1SU+Cr+s5
         Pbgk6hvvpwrhVa2Fg+tpTGZF8KLIFDyvZ0LheJPvg8ab15Tec3juzp3Jf7ze00sJKt91
         tzMydBTdLV2OgkT63N8bbFqcYstZKO9akFPqESaE2Prv1PB0UMOwAnwfOHaBNEHA2dEL
         DgNRRfrJ00Vd+2xU8Ww1rn3OdQ0e+qER3Q8R5wn0Uai3WaOMwbcMHRYfOj6ICw8PrAAu
         eqdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:wdcipoutbound:content-language:accept-language
         :in-reply-to:references:message-id:date:thread-index:thread-topic
         :subject:cc:to:from:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=cDHo6sgKmfqyONI7e8M6HdYPSrN+6WtJmg/VycUnslc=;
        b=FES1abEtAkABOFaZausUks1h0nXrEEjN7q5xTR6r9uqIaBWqD0NPALDh615kmFUrD8
         /Hyi4H8L/h1NXdmh4cGS8Xd3NTVOf1nl9c/s2TCik3zw9ErS/v1vRdQPX/QsenZz/XV6
         uz5yWw7uCfUQMAS8K5BZvuKrAIWL2e0Y8114EPRZnzVklzgX5abHlu70QzS6v95R8RoX
         BcOKnRAVPoDq3ADk4ryu4aG9DDpTCxrmET3ZYtS4rQMi5RKOloJlZ7fXScZ+lH/HxF2w
         mEBJupb14euWVx/KHU3q/H4lTJbsSbNXGQR1Wmgkt1+5dVNB7+Zyv51uVT0JqsqV0/6d
         kAzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=MXe7elT8;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=S7KTKbD7;
       spf=pass (google.com: domain of prvs=574ef6db7=stanislav.nijnikov@wdc.com designates 68.232.143.124 as permitted sender) smtp.mailfrom=prvs=574ef6db7=Stanislav.Nijnikov@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=MXe7elT8;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=S7KTKbD7;
       spf=pass (google.com: domain of prvs=574ef6db7=stanislav.nijnikov@wdc.com designates 68.232.143.124 as permitted sender) smtp.mailfrom=prvs=574ef6db7=Stanislav.Nijnikov@wdc.com
X-IronPort-AV: E=Sophos;i="5.46,501,1511798400";
   d="scan'208";a="167590764"
From: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Alex Lemberg
	<Alex.Lemberg@wdc.com>
Subject: RE: [PATCH v5 02/11] scsi: ufs: sysfs: device descriptor
Thread-Topic: [PATCH v5 02/11] scsi: ufs: sysfs: device descriptor
Thread-Index: AQHTn2R4OAtuPERqL0SEA54NVjMkFqOf/PYAgACnVbA=
Date: Mon, 12 Feb 2018 11:21:26 +0000
Message-ID: <CY1PR0401MB0969E1C484E519EBB3F714309AF70@CY1PR0401MB0969.namprd04.prod.outlook.com>
References: <1517933183-30892-1-git-send-email-stanislav.nijnikov@wdc.com>
 <1517933183-30892-3-git-send-email-stanislav.nijnikov@wdc.com>
 <20180212010738.GD44666@jaegeuk-macbookpro.roam.corp.google.com>
In-Reply-To: <20180212010738.GD44666@jaegeuk-macbookpro.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Stanislav.Nijnikov@wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0401MB1631;7:TxzDx7NgLdbkOINXuyxOQWDplkiOM8xbr4oMXQ7OAn9Zoda/4aB+4+SbH++lUhQK+55JsoUxcZ0280lrIwvhWv5TwUHsW90L6OqNz2oVrOhrH8yoZWyWX687DTuv3KOScn0NjwPzk5oUqJTSJbsDSNYR7JqjFiPMqc5RU39asRAbs1xqAvn5auUBMiaWs5+yOBqd/bhHbvbVRf+uAKewa3TFKF3k7arMJtpK8ev/dsPpy3hwzko/Hk5n/EKmSKf1;20:hhBJvH0lCTWsa3rWX+b6yYGeRruh6Mkky1SqZxiXG4fUIJNE5+8WzOxhYc6FqdIx6OHfZEqhbCXokTV7WGKxk0dEzltVvR8wAlGVuo/NBoD9sQGh4LZQ2fyr722Tqed1tWaomJoZmSEOrkXzexBcsMsHhH7O/210X2pMlcZuUIU=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66fbd6c8-209f-45ad-c13c-08d5720ac17f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:CY1PR0401MB1631;
x-ms-traffictypediagnostic: CY1PR0401MB1631:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR0401MB1631D9EF0D4B83F4F9ABDCF69AF70@CY1PR0401MB1631.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231101)(2400082)(944501161)(6055026)(6041288)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:CY1PR0401MB1631;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0401MB1631;
x-forefront-prvs: 0581B5AB35
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(376002)(346002)(396003)(13464003)(189003)(199004)(50944005)(478600001)(6116002)(3846002)(66066001)(33656002)(102836004)(186003)(8676002)(53546011)(6506007)(8936002)(59450400001)(26005)(77096007)(106356001)(97736004)(5660300001)(2900100001)(81166006)(81156014)(76176011)(7696005)(54906003)(575784001)(74316002)(86362001)(25786009)(14454004)(105586002)(4326008)(53936002)(3280700002)(68736007)(72206003)(229853002)(9686003)(55016002)(53946003)(2906002)(99286004)(305945005)(6916009)(3660700001)(7736002)(2950100002)(6436002)(316002)(6246003)(579004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0401MB1631;H:CY1PR0401MB0969.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: AXac2D5/7LhNIAdsbZiuFLsh20fTcF/PCERpqM1+cQCrdOEJT+/A+AkxQpdG84fTiX5mp+GYkO3qS9X4dlK1sg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fbd6c8-209f-45ad-c13c-08d5720ac17f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2018 11:21:26.3001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0401MB1631
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591668318034296035?=
X-GMAIL-MSGID: =?utf-8?q?1592193963823916832?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Monday, February 12, 2018 3:08 AM
> To: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
> Cc: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org;
> gregkh@linuxfoundation.org; Alex Lemberg <Alex.Lemberg@wdc.com>
> Subject: Re: [PATCH v5 02/11] scsi: ufs: sysfs: device descriptor
>=20
> On 02/06, Stanislav Nijnikov wrote:
> > This patch introduces a sysfs group entry for the UFS device
> > descriptor parameters. The group adds "device_descriptor" folder under
> > the UFS driver sysfs entry (/sys/bus/platform/drivers/ufshcd/*). The
> > parameters are shown as hexadecimal numbers. The full information
> > about the parameters could be found at UFS specifications 2.1.
> >
> > Signed-off-by: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > ---
> >  Documentation/ABI/testing/sysfs-driver-ufs | 223
> +++++++++++++++++++++++++++++
> >  drivers/scsi/ufs/ufs-sysfs.c               | 116 +++++++++++++++
> >  drivers/scsi/ufs/ufs.h                     |   8 ++
> >  drivers/scsi/ufs/ufshcd.c                  |  12 +-
> >  drivers/scsi/ufs/ufshcd.h                  |   6 +
> >  5 files changed, 359 insertions(+), 6 deletions(-)  create mode
> > 100644 Documentation/ABI/testing/sysfs-driver-ufs
> >
> > diff --git a/Documentation/ABI/testing/sysfs-driver-ufs
> > b/Documentation/ABI/testing/sysfs-driver-ufs
> > new file mode 100644
> > index 0000000..8da7b84
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-driver-ufs
> > @@ -0,0 +1,223 @@
> > +What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/device_type
> > +Date:		February 2018
> > +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > +Description:	This file shows the device type. This is one of the UFS
> > +		device descriptor parameters. The full information about
> > +		the descriptor could be found at UFS specifications 2.1.
> > +		The file is read only.
> > +
> > +What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/device_class
> > +Date:		February 2018
> > +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > +Description:	This file shows the device class. This is one of the UFS
> > +		device descriptor parameters. The full information about
> > +		the descriptor could be found at UFS specifications 2.1.
> > +		The file is read only.
> > +
> > +What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/device_sub_
> class
> > +Date:		February 2018
> > +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > +Description:	This file shows the UFS storage subclass. This is one of
> > +		the UFS device descriptor parameters. The full information
> > +		about the descriptor could be found at UFS specifications 2.1.
> > +		The file is read only.
> > +
> > +What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/protocol
> > +Date:		February 2018
> > +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > +Description:	This file shows the protocol supported by an UFS device.
> > +		This is one of the UFS device descriptor parameters.
> > +		The full information about the descriptor could be found
> > +		at UFS specifications 2.1.
> > +		The file is read only.
> > +
> > +What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/number_of_
> luns
> > +Date:		February 2018
> > +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > +Description:	This file shows number of logical units. This is one of
> > +		the UFS device descriptor parameters. The full information
> > +		about the descriptor could be found at UFS specifications 2.1.
> > +		The file is read only.
> > +
> > +What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/number_of_
> wluns
> > +Date:		February 2018
> > +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > +Description:	This file shows number of well known logical units.
> > +		This is one of the UFS device descriptor parameters.
> > +		The full information about the descriptor could be found
> > +		at UFS specifications 2.1.
> > +		The file is read only.
> > +
> > +What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/boot_enable
> > +Date:		February 2018
> > +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > +Description:	This file shows value that indicates whether the device i=
s
> > +		enabled for boot. This is one of the UFS device descriptor
> > +		parameters. The full information about the descriptor could
> > +		be found at UFS specifications 2.1.
> > +		The file is read only.
> > +
> > +What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/descriptor_a
> ccess_enable
> > +Date:		February 2018
> > +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > +Description:	This file shows value that indicates whether the device
> > +		descriptor could be read after partial initialization phase
> > +		of the boot sequence. This is one of the UFS device
> descriptor
> > +		parameters. The full information about the descriptor could
> > +		be found at UFS specifications 2.1.
> > +		The file is read only.
> > +
> > +What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/initial_powe
> r_mode
> > +Date:		February 2018
> > +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > +Description:	This file shows value that defines the power mode after
> > +		device initialization or hardware reset. This is one of
> > +		the UFS device descriptor parameters. The full information
> > +		about the descriptor could be found at UFS specifications 2.1.
> > +		The file is read only.
> > +
> > +What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/high_priority
> _lun
> > +Date:		February 2018
> > +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > +Description:	This file shows the high priority lun. This is one of
> > +		the UFS device descriptor parameters. The full information
> > +		about the descriptor could be found at UFS specifications 2.1.
> > +		The file is read only.
> > +
> > +What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/secure_rem
> oval_type
> > +Date:		February 2018
> > +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > +Description:	This file shows the secure removal type. This is one of
> > +		the UFS device descriptor parameters. The full information
> > +		about the descriptor could be found at UFS specifications 2.1.
> > +		The file is read only.
> > +
> > +What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/support_sec
> urity_lun
> > +Date:		February 2018
> > +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > +Description:	This file shows whether the security lun is supported.
> > +		This is one of the UFS device descriptor parameters.
> > +		The full information about the descriptor could be found
> > +		at UFS specifications 2.1.
> > +		The file is read only.
> > +
> > +What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/bkops_termi
> nation_latency
> > +Date:		February 2018
> > +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > +Description:	This file shows the background operations termination
> > +		latency. This is one of the UFS device descriptor parameters.
> > +		The full information about the descriptor could be found
> > +		at UFS specifications 2.1.
> > +		The file is read only.
> > +
> > +What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/initial_active
> _icc_level
> > +Date:		February 2018
> > +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > +Description:	This file shows the initial active ICC level. This is one
> > +		of the UFS device descriptor parameters. The full information
> > +		about the descriptor could be found at UFS specifications 2.1.
> > +		The file is read only.
> > +
> > +What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/specification
> _version
> > +Date:		February 2018
> > +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > +Description:	This file shows the specification version. This is one
> > +		of the UFS device descriptor parameters. The full information
> > +		about the descriptor could be found at UFS specifications 2.1.
> > +		The file is read only.
> > +
> > +What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/manufacturi
> ng_date
> > +Date:		February 2018
> > +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > +Description:	This file shows the manufacturing date in BCD format.
> > +		This is one of the UFS device descriptor parameters.
> > +		The full information about the descriptor could be found
> > +		at UFS specifications 2.1.
> > +		The file is read only.
> > +
> > +What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/manufacture
> r_id
> > +Date:		February 2018
> > +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > +Description:	This file shows the manufacturee ID. This is one of the
> > +		UFS device descriptor parameters. The full information about
> > +		the descriptor could be found at UFS specifications 2.1.
> > +		The file is read only.
> > +
> > +What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/rtt_capabilit
> y
> > +Date:		February 2018
> > +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > +Description:	This file shows the maximum number of outstanding RTTs
> > +		supported by the device. This is one of the UFS device
> > +		descriptor parameters. The full information about
> > +		the descriptor could be found at UFS specifications 2.1.
> > +		The file is read only.
> > +
> > +What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/rtc_update
> > +Date:		February 2018
> > +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > +Description:	This file shows the frequency and method of the realtime
> > +		clock update. This is one of the UFS device descriptor
> > +		parameters. The full information about the descriptor
> > +		could be found at UFS specifications 2.1.
> > +		The file is read only.
> > +
> > +What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/ufs_features
> > +Date:		February 2018
> > +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > +Description:	This file shows which features are supported by the devic=
e.
> > +		This is one of the UFS device descriptor parameters.
> > +		The full information about the descriptor could be
> > +		found at UFS specifications 2.1.
> > +		The file is read only.
> > +
> > +What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/ffu_timeout
> > +Date:		February 2018
> > +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > +Description:	This file shows the FFU timeout. This is one of the
> > +		UFS device descriptor parameters. The full information
> > +		about the descriptor could be found at UFS specifications 2.1.
> > +		The file is read only.
> > +
> > +What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/queue_dept
> h
> > +Date:		February 2018
> > +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > +Description:	This file shows the device queue depth. This is one of th=
e
> > +		UFS device descriptor parameters. The full information
> > +		about the descriptor could be found at UFS specifications 2.1.
> > +		The file is read only.
> > +
> > +What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/device_versi
> on
> > +Date:		February 2018
> > +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > +Description:	This file shows the device version. This is one of the
> > +		UFS device descriptor parameters. The full information
> > +		about the descriptor could be found at UFS specifications 2.1.
> > +		The file is read only.
> > +
> > +What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/number_of_
> secure_wpa
> > +Date:		February 2018
> > +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > +Description:	This file shows number of secure write protect areas
> > +		supported by the device. This is one of the UFS device
> > +		descriptor parameters. The full information about
> > +		the descriptor could be found at UFS specifications 2.1.
> > +		The file is read only.
> > +
> > +What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/psa_max_da
> ta_size
> > +Date:		February 2018
> > +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > +Description:	This file shows the maximum amount of data that may be
> > +		written during the pre-soldering phase of the PSA flow.
> > +		This is one of the UFS device descriptor parameters.
> > +		The full information about the descriptor could be found
> > +		at UFS specifications 2.1.
> > +		The file is read only.
> > +
> > +What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/psa_state_ti
> meout
> > +Date:		February 2018
> > +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > +Description:	This file shows the command maximum timeout for a change
> > +		in PSA state. This is one of the UFS device descriptor
> > +		parameters. The full information about the descriptor could
> > +		be found at UFS specifications 2.1.
> > +		The file is read only.
> > diff --git a/drivers/scsi/ufs/ufs-sysfs.c
> > b/drivers/scsi/ufs/ufs-sysfs.c index ce8dcb6..aa2779a 100644
> > --- a/drivers/scsi/ufs/ufs-sysfs.c
> > +++ b/drivers/scsi/ufs/ufs-sysfs.c
> > @@ -3,7 +3,9 @@
> >
> >  #include <linux/err.h>
> >  #include <linux/string.h>
> > +#include <asm/unaligned.h>
> >
> > +#include "ufs.h"
> >  #include "ufs-sysfs.h"
> >
> >  static const char *ufschd_uic_link_state_to_string( @@ -134,8
> > +136,122 @@ static const struct attribute_group ufs_sysfs_default_group
> =3D {
> >  	.attrs =3D ufs_sysfs_ufshcd_attrs,
> >  };
> >
> > +static ssize_t ufs_sysfs_read_desc_param(struct ufs_hba *hba,
> > +				  enum desc_idn desc_id,
> > +				  u8 desc_index,
> > +				  u8 param_offset,
> > +				  u8 *sysfs_buf,
> > +				  u8 param_size)
> > +{
> > +	u8 desc_buf[8] =3D {0};
> > +	int ret;
> > +
> > +	if (param_size > 8)
> > +		return -EINVAL;
> > +
> > +	ret =3D ufshcd_read_desc_param(hba, desc_id, desc_index,
> > +				param_offset, desc_buf, param_size);
> > +	if (ret)
> > +		return -EINVAL;
> > +	switch (param_size) {
> > +	case 1:
> > +		ret =3D sprintf(sysfs_buf, "0x%02X\n", *desc_buf);
> > +		break;
> > +	case 2:
> > +		ret =3D sprintf(sysfs_buf, "0x%04X\n",
> > +			get_unaligned_be16(desc_buf));
> > +		break;
> > +	case 4:
> > +		ret =3D sprintf(sysfs_buf, "0x%08X\n",
> > +			get_unaligned_be32(desc_buf));
> > +		break;
> > +	case 8:
> > +		ret =3D sprintf(sysfs_buf, "0x%016llX\n",
> > +			get_unaligned_be64(desc_buf));
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +#define UFS_DESC_PARAM(_name, _puname, _duname, _size)
> 		\
> > +static ssize_t _name##_show(struct device *dev,
> 	\
> > +	struct device_attribute *attr, char *buf)			\
> > +{									\
> > +	struct ufs_hba *hba =3D dev_get_drvdata(dev);			\
> > +	return ufs_sysfs_read_desc_param(hba,
> QUERY_DESC_IDN_##_duname,	\
> > +		0, _duname##_DESC_PARAM##_puname, buf, _size);
> 	\
> > +}									\
> > +static DEVICE_ATTR_RO(_name)
> > +
> > +#define UFS_DEVICE_DESC_PARAM(_name, _uname, _size)
> 		\
> > +	UFS_DESC_PARAM(_name, _uname, DEVICE, _size)
> > +
> > +UFS_DEVICE_DESC_PARAM(device_type, _DEVICE_TYPE, 1);
> > +UFS_DEVICE_DESC_PARAM(device_class, _DEVICE_CLASS, 1);
> > +UFS_DEVICE_DESC_PARAM(device_sub_class, _DEVICE_SUB_CLASS, 1);
> > +UFS_DEVICE_DESC_PARAM(protocol, _PRTCL, 1);
> > +UFS_DEVICE_DESC_PARAM(number_of_luns, _NUM_LU, 1);
> > +UFS_DEVICE_DESC_PARAM(number_of_wluns, _NUM_WLU, 1);
> > +UFS_DEVICE_DESC_PARAM(boot_enable, _BOOT_ENBL, 1);
> > +UFS_DEVICE_DESC_PARAM(descriptor_access_enable,
> _DESC_ACCSS_ENBL, 1);
> > +UFS_DEVICE_DESC_PARAM(initial_power_mode, _INIT_PWR_MODE, 1);
> > +UFS_DEVICE_DESC_PARAM(high_priority_lun, _HIGH_PR_LUN, 1);
> > +UFS_DEVICE_DESC_PARAM(secure_removal_type, _SEC_RMV_TYPE, 1);
> > +UFS_DEVICE_DESC_PARAM(support_security_lun, _SEC_LU, 1);
> > +UFS_DEVICE_DESC_PARAM(bkops_termination_latency,
> _BKOP_TERM_LT, 1);
> > +UFS_DEVICE_DESC_PARAM(initial_active_icc_level, _ACTVE_ICC_LVL, 1);
> > +UFS_DEVICE_DESC_PARAM(specification_version, _SPEC_VER, 2);
> > +UFS_DEVICE_DESC_PARAM(manufacturing_date, _MANF_DATE, 2);
> > +UFS_DEVICE_DESC_PARAM(manufacturer_id, _MANF_ID, 2);
> > +UFS_DEVICE_DESC_PARAM(rtt_capability, _RTT_CAP, 1);
> > +UFS_DEVICE_DESC_PARAM(rtc_update, _FRQ_RTC, 2);
> > +UFS_DEVICE_DESC_PARAM(ufs_features, _UFS_FEAT, 1);
> > +UFS_DEVICE_DESC_PARAM(ffu_timeout, _FFU_TMT, 1);
> > +UFS_DEVICE_DESC_PARAM(queue_depth, _Q_DPTH, 1);
> > +UFS_DEVICE_DESC_PARAM(device_version, _DEV_VER, 2);
> > +UFS_DEVICE_DESC_PARAM(number_of_secure_wpa, _NUM_SEC_WPA,
> 1);
> > +UFS_DEVICE_DESC_PARAM(psa_max_data_size, _PSA_MAX_DATA, 4);
> > +UFS_DEVICE_DESC_PARAM(psa_state_timeout, _PSA_TMT, 1);
>=20
> Could you add this case as well?
>=20
> DEVICE_DESC_PARAM_PRDCT_REV		=3D 0x2A,
>=20

This value was omitted intentionally. It holds an index of the string descr=
iptor with the
product revision. There are 4 more such fields in the device descriptor:
 - DEVICE_DESC_PARAM_MANF_NAME =3D 0x14
 - DEVICE_DESC_PARAM_PRDCT_NAME  =3D 0x15,
 - DEVICE_DESC_PARAM_SN =3D 0x16,
 - DEVICE_DESC_PARAM_OEM_ID  =3D 0x17,
The indexes itself don't provide any useful information to users and the
corresponding strings are shown by the string descriptors (see "[PATCH v5 0=
7/11]=20
scsi: ufs: sysfs: string descriptors")

Regards

> > +
> > +static struct attribute *ufs_sysfs_device_descriptor[] =3D {
> > +	&dev_attr_device_type.attr,
> > +	&dev_attr_device_class.attr,
> > +	&dev_attr_device_sub_class.attr,
> > +	&dev_attr_protocol.attr,
> > +	&dev_attr_number_of_luns.attr,
> > +	&dev_attr_number_of_wluns.attr,
> > +	&dev_attr_boot_enable.attr,
> > +	&dev_attr_descriptor_access_enable.attr,
> > +	&dev_attr_initial_power_mode.attr,
> > +	&dev_attr_high_priority_lun.attr,
> > +	&dev_attr_secure_removal_type.attr,
> > +	&dev_attr_support_security_lun.attr,
> > +	&dev_attr_bkops_termination_latency.attr,
> > +	&dev_attr_initial_active_icc_level.attr,
> > +	&dev_attr_specification_version.attr,
> > +	&dev_attr_manufacturing_date.attr,
> > +	&dev_attr_manufacturer_id.attr,
> > +	&dev_attr_rtt_capability.attr,
> > +	&dev_attr_rtc_update.attr,
> > +	&dev_attr_ufs_features.attr,
> > +	&dev_attr_ffu_timeout.attr,
> > +	&dev_attr_queue_depth.attr,
> > +	&dev_attr_device_version.attr,
> > +	&dev_attr_number_of_secure_wpa.attr,
> > +	&dev_attr_psa_max_data_size.attr,
> > +	&dev_attr_psa_state_timeout.attr,
> > +	NULL,
> > +};
> > +
> > +static const struct attribute_group ufs_sysfs_device_descriptor_group =
=3D {
> > +	.name =3D "device_descriptor",
> > +	.attrs =3D ufs_sysfs_device_descriptor, };
> > +
> >  static const struct attribute_group *ufs_sysfs_groups[] =3D {
> >  	&ufs_sysfs_default_group,
> > +	&ufs_sysfs_device_descriptor_group,
> >  	NULL,
> >  };
> >
> > diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h index
> > 54deeb7..6ae1e08 100644
> > --- a/drivers/scsi/ufs/ufs.h
> > +++ b/drivers/scsi/ufs/ufs.h
> > @@ -220,6 +220,14 @@ enum device_desc_param {
> >  	DEVICE_DESC_PARAM_UD_LEN		=3D 0x1B,
> >  	DEVICE_DESC_PARAM_RTT_CAP		=3D 0x1C,
> >  	DEVICE_DESC_PARAM_FRQ_RTC		=3D 0x1D,
> > +	DEVICE_DESC_PARAM_UFS_FEAT		=3D 0x1F,
> > +	DEVICE_DESC_PARAM_FFU_TMT		=3D 0x20,
> > +	DEVICE_DESC_PARAM_Q_DPTH		=3D 0x21,
> > +	DEVICE_DESC_PARAM_DEV_VER		=3D 0x22,
> > +	DEVICE_DESC_PARAM_NUM_SEC_WPA		=3D 0x24,
> > +	DEVICE_DESC_PARAM_PSA_MAX_DATA		=3D 0x25,
> > +	DEVICE_DESC_PARAM_PSA_TMT		=3D 0x29,
> > +	DEVICE_DESC_PARAM_PRDCT_REV		=3D 0x2A,
> >  };
> >
> >  /*
> > diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> > index e7621a0a..540a431 100644
> > --- a/drivers/scsi/ufs/ufshcd.c
> > +++ b/drivers/scsi/ufs/ufshcd.c
> > @@ -2989,12 +2989,12 @@
> EXPORT_SYMBOL(ufshcd_map_desc_id_to_length);
> >   *
> >   * Return 0 in case of success, non-zero otherwise
> >   */
> > -static int ufshcd_read_desc_param(struct ufs_hba *hba,
> > -				  enum desc_idn desc_id,
> > -				  int desc_index,
> > -				  u8 param_offset,
> > -				  u8 *param_read_buf,
> > -				  u8 param_size)
> > +int ufshcd_read_desc_param(struct ufs_hba *hba,
> > +			   enum desc_idn desc_id,
> > +			   int desc_index,
> > +			   u8 param_offset,
> > +			   u8 *param_read_buf,
> > +			   u8 param_size)
> >  {
> >  	int ret;
> >  	u8 *desc_buf;
> > diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> > index 53e2779..38c307d 100644
> > --- a/drivers/scsi/ufs/ufshcd.h
> > +++ b/drivers/scsi/ufs/ufshcd.h
> > @@ -841,6 +841,12 @@ static inline bool ufshcd_is_hs_mode(struct
> > ufs_pa_layer_attr *pwr_info)  }
> >
> >  /* Expose Query-Request API */
> > +int ufshcd_read_desc_param(struct ufs_hba *hba,
> > +			   enum desc_idn desc_id,
> > +			   int desc_index,
> > +			   u8 param_offset,
> > +			   u8 *param_read_buf,
> > +			   u8 param_size);
> >  int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
> >  	enum flag_idn idn, bool *flag_res);
> >  int ufshcd_hold(struct ufs_hba *hba, bool async);
> > --
> > 2.7.4
