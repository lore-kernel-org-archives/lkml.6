Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3328118-1521215651-2-18439033443466229484
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521215650; b=FYeRT31fg7nZ2esGqG8flPDE6J9onTV0t6iCGvNpK9xxLUE
    TCvintEPLgh62CqOerPU7fCmHctibQY5otPFfPwW6wbehX+p+zq+fU+ZVvuDnYUR
    p6DVWZpMYo7LFpih9xwS2+Ihw674PlYXxSf118JzKIgJFcivf4clmOUnxN0LkJNb
    25avx1p3rZPB3OiaoDpbHyMWwP+YXYs3vBslKrzA1k+1zcxxU+Ssn1G6QeuuVlRR
    Z0Ty1UOlf/rub1L/NbzA+O7Sbm0dmlL6KOi35+zmzBcB+RAgYdyC18Te3xq0tJez
    KL7o90WTd4ySdyxBv0pnR8iS/GUqXsHzz0wBmXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521215650; bh=7
    YCXMOZj9ARz9BKAzVefYwmhGTxa8Pptof1tcHo7q+Y=; b=a0bfXQtZCNM6ctVCx
    yPn9fX71hB35d9g1QmTfOqgNRak25KsGsxc39xuoLQq0frzmx5/gGRqTgF11ZZjt
    SqIt1Vs8MpOuFiXqDw2DcFYgAuMIYvF04ypVoj6vYmnaaMzcXVKvg0FbiqWacefR
    g67AsTWP+omXvtGKsypCF361RCPH1s0b8G/R3yc4Y1gaY91gRWecksaVKo6EvLp3
    4UkxhNjHVgKDq3//4Fs4feT3zt+av/59YdU18AFNHL9kqfvdHgkvsbiWmuLjPGXI
    d9M9glDHpaADzt5m4wu/aBgJRx2n0PUDJSzYHNFEW3VRQqfSTuBIR2RLi4gCripl
    TuFBQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hIgoDPV+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hIgoDPV+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Long Li <longli@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>,
 "James E . J . Bottomley" <JBottomley@odin.com>, "Martin K . Petersen"
 <martin.petersen@oracle.com>, "devel@linuxdriverproject.org"
 <devel@linuxdriverproject.org>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] storvsc: Set up correct queue depth values for IDE devices
Thread-Topic: [PATCH] storvsc: Set up correct queue depth values for IDE
 devices
Thread-Index: AQHTvLjYCfXJCnGVc0WR8/+aC++pc6PS+OdA
Date: Fri, 16 Mar 2018 15:54:00 +0000
Message-ID: <DM5PR2101MB103058D9867D0A84E79A682CDCD70@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180315235223.19844-1-longli@exchange.microsoft.com>
In-Reply-To: <20180315235223.19844-1-longli@exchange.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-16T15:53:58.4761396Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB1096;
 7:Gib8lc5rbOhuPWz/+bOPu03m/T+0GkXJcEZNg1plxKlWIibHrhybekWdzmDCGJZ0M/xE/QABbXIMiqEohNvPfwAjFV7V/lxEs5OZlB5YcS1yozSR9Ii5YTS8GsvY2IqH3dTSIvq3TPzySSgpgTScQ05jd+VHRvIWoqVJloNWgBrKUHBi/SQZELhjlS/Pf//Tfq50iVSzMp/kQ/LQeVdn/mXUR3kEE7w4P6vRjzGzS7bqzZmNovwV0N1ohC56dgYi;
 20:0lUzXWXMLEB01xCDclt+NSa90AJyA+aNYVQ/uPSKY+ZwH0o5ioJPrX4c/9ePS33srGojuT7hgOmVEQ9b58/MwwHxTuXshZxbE0zTYknhCTrXSgUdWbX/fEH8kcBE7WlwGd0lZuwQqKgWOLcPXU0uaY/xVDl1qutLmtWajq4mP4k=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01c99103-160d-47c8-8a01-08d58b5622a8
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);
 SRVR:DM5PR2101MB1096;
x-ms-traffictypediagnostic: DM5PR2101MB1096:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB109604365D60CEC108FDE658DCD70@DM5PR2101MB1096.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(146099531331640); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501281)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);
 SRVR:DM5PR2101MB1096; BCL:0; PCL:0; RULEID:; SRVR:DM5PR2101MB1096;
x-forefront-prvs: 0613912E23
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(376002)(346002)(39380400002)(39860400002)(189003)(199004)(13464003)(22452003)(316002)(25786009)(2950100002)(7696005)(2201001)(53936002)(4326008)(6246003)(3280700002)(107886003)(1511001)(53546011)(229853002)(99286004)(72206003)(5660300001)(10290500003)(14454004)(110136005)(59450400001)(8990500004)(86612001)(76176011)(68736007)(6506007)(102836004)(478600001)(26005)(86362001)(10090500001)(2501003)(5250100002)(3660700001)(81156014)(8676002)(81166006)(106356001)(7736002)(97736004)(305945005)(33656002)(74316002)(8936002)(2900100001)(105586002)(3846002)(66066001)(6436002)(6116002)(2906002)(55016002)(9686003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB1096;
 H:DM5PR2101MB1030.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
x-microsoft-antispam-message-info: FIFaJecav3Rt2RshMfAoSInZnTFOj5FBLt7L6AcsiwFZFor16wBBh6twEUc2b7BZ3vCv4XMGhQe3eDmJgzW3fMLjLrPg6TpXQrDhbY4l2t8By8r9ksAYDKed0R1N0f0I98HGedCDalCkpdi9IO6XDs7lyP2q8GKE38KHf98rcGOJ8buOs5CCkPOiLOo0OGpK2o2+8cfEFCbL69WbO6V61uF3VMebBCsKcuog+D8u3yInrsOlTT+K9JViLZF4L+VXVbhBz8YcinOD9GgHtRbFPUbunqJwt6glb+5u22Y/Um7jxr9SSWJaKM+uXXm4SQGF6mOtJmceadIrcexM1H042w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c99103-160d-47c8-8a01-08d58b5622a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2018 15:54:00.5420 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1096
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.org> On Behalf
> Of Long Li
> Sent: Thursday, March 15, 2018 4:52 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; James E . J . Bottomley <JBottomley@odin.com>;
> Martin K . Petersen <martin.petersen@oracle.com>; devel@linuxdriverproject.org; linux-
> scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Long Li <longli@microsoft.com>
> Subject: [PATCH] storvsc: Set up correct queue depth values for IDE devices
> 
> From: Long Li <longli@microsoft.com>
> 
> Unlike SCSI and FC, we don't use multiple channels for IDE. So set queue depth
> correctly for IDE.
> 
> Also set the correct cmd_per_lun for all devices.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/scsi/storvsc_drv.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 8c51d628b52e..fba170640e9c 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1722,15 +1722,19 @@ static int storvsc_probe(struct hv_device *device,
>  		max_targets = STORVSC_MAX_TARGETS;
>  		max_channels = STORVSC_MAX_CHANNELS;
>  		/*
> -		 * On Windows8 and above, we support sub-channels for storage.
> +		 * On Windows8 and above, we support sub-channels for storage
> +		 * on SCSI and FC controllers.
>  		 * The number of sub-channels offerred is based on the number of
>  		 * VCPUs in the guest.
>  		 */
> -		max_sub_channels = (num_cpus / storvsc_vcpus_per_sub_channel);
> +		if (!dev_is_ide)
> +			max_sub_channels =
> +				num_cpus / storvsc_vcpus_per_sub_channel;

This calculation of the # of sub-channels doesn't get the right answer (and it
didn't before this patch either).  storvsc_vcpus_per_sub_channel defaults to 4.
If num_cpus is 8, max_sub_channels will be 2, but it should be 1.  The
sub-channel count should not include the main channel since we add 1 to the
sub-channel count below when calculating can_queue.

Furthermore, this is calculation is just a guess, in the sense that we're
replicating the algorithm we think Hyper-V is using to determine the number
of sub-channels to offer.   It turns out Hyper-V is changing that algorithm for
particular devices in an upcoming new Azure VM size.  But the only use of
max_sub_channels is in the calculation of can_queue below, so the impact
is minimal.

>  	}
> 
>  	scsi_driver.can_queue = (max_outstanding_req_per_channel *
>  				 (max_sub_channels + 1));
> +	scsi_driver.cmd_per_lun = scsi_driver.can_queue;

can_queue is defined as "int", while cmd_per_lun is defined as "short".
The calculated value of can_queue could easily be over 32,767 with
15 sub-channels and max_outstanding_req_per_channel being 3036
for the default 1 Mbyte ring buffer.  So the assignment to cmd_per_lun
could produce truncation and even a negative number.

More broadly, since max_outstanding_req_per_channel is based on
the ring buffer size, these calculations imply that Hyper-V storvsp's
queuing capacity is based on the ring buffer size.  I don't think that's
the case.  From conversations with the storvsp folks, I think Hyper-V
always removes entries from the guest->host ring buffer and then
lets storvsp queue them separately.   So we don't want to be linking
cmd_per_lun (or even can_queue, for that matter) to the ring buffer
size.  The current default ring buffer size of 1 Mbyte is probably 10x
bigger than needed, and we want to be able to adjust that without
ending up with can_queue and cmd_per_lun values that are too
small.

We would probably do better to set can_queue to a constant, and
leave cmd_per_lun at its current value of 2048.   The can_queue
value is already capped at 10240 in the blk-mq layer, so maybe
that's a reasonable constant to use.

Thoughts?

> 
>  	host = scsi_host_alloc(&scsi_driver,
>  			       sizeof(struct hv_host_device));
> --
> 2.14.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
