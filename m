Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-604031-1523662098-2-10263535145228491781
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523662097; b=h43/ZXc+m93Vq/D6DvOcJtj08d1xJmC8HL9ONXhTOEFKOcDnie
    2TsRKocshFo4zxY57pGiKpI3BWOD+4kmsXULUFO9PmDhnwXqW8oB1VcWkssPZnK3
    P3jNgWspvWwFRzjQ9Hn5DhUis8Klsb9Y4lEOzoP+AJI29SPi9NTAuEfaJLuqMAQO
    w2cz0jbHDETtqEG/53sdFElsp02SM3jK0X2JoSdMuPNKQ+T+GZn0xR/QBp8Wyw9C
    veK5uuKA7Q7+xHwpNaJOnjYr58YfoB6iHP/AIS4cZj4SVHGKZAzs0QrB4bjvtrnl
    hKGVwrkjcIFU++sxgm+lDZHWBMfw9pE/YtzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523662097; bh=7S+sH
    ZaGYhH3Pi/tT2c50HeHamWBdR10Jktjv16jrA0=; b=CeTJUy1etl21g5tclX/ac
    7Gan/+3pr5uBEhGcS6EYkxB+UCx0cX0brIBhrbxkZxSOZDUNrVbw5MRvhFh5oZFW
    3No8Ey7hqdNV3j+XXGQdrJdhJ4DMoafGjPszxCZ2MvUPCNnY3MDCN9y1BUG8QZMK
    KldBDdpWNdvL2hYuwe521DRscv//eRjbO3I55zmCd3Qf//Jm0OwzJtuFQllQI1mx
    LPwOT65FgUeAieYTAg0t2UGWq70MnF9zhL7zq3A7zZQpLnLG7SiJ8LD7JrS/abk4
    srnMgAk4KdHtIqRVlxc6DNLH3P7Lz4OJY1ccX+jmeaWIX9sbh5G8lJprMF3yQTGr
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FeT0ggEQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FeT0ggEQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL4SsjxIO9T5eiJug+4RpHhZphSQsXqkFpmQfFsCQVXOyptZ2axJnftqi+XasSzP+a40sY1AiRmmWtLQ1vBlDwR50Pnl+dMMbO+g5DEQDvbBjQeKWvNI
    2vKPLzUorGyQdbhUWz1Hy8RzI0MHFZpposwAlbcvyb9wc7bNw9NkjtQQogZdQrQup7JnaKUrmVOn5QFIceCu5lkLKJ00Wo2EzMj/HRlBCahAMiXCU1jT7KXN
    U2iE8gCbS1+qPG86NbX1fw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=_TKFW_rNyuwA:10 a=ezrDjaGQ7gEA:10
    a=wYU4eDHypp4A:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8
    a=yMhMjlubAAAA:8 a=6n1iNii3AAAA:8 a=yPCof4ZbAAAA:8 a=DDOyTI_5AAAA:8
    a=YE4yETFCQBwIUkyYGTcA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
    a=202BzjwEAueTV-TT:21 a=Od6yut48BJuczz3J:21 a=CjuIK1q_8ugA:10
    a=q3R5zVSKXvcA:10 a=AjGcO6oz07-iQ99wixmX:22 a=qL8UFIJES1IU-uv6apQ6:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Long Li <longli@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>,
 "James E . J . Bottomley" <JBottomley@odin.com>, "Martin K . Petersen"
 <martin.petersen@oracle.com>, "devel@linuxdriverproject.org"
 <devel@linuxdriverproject.org>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: RE: [Resend Patch 3/3] Storvsc: Select channel based on available
 percentage of ring buffer to write
Thread-Topic: [Resend Patch 3/3] Storvsc: Select channel based on available
 percentage of ring buffer to write
Thread-Index: AQHTxi7VZycA3BlyO0KRjEaTIuc2cqP/aBPg
Date: Fri, 13 Apr 2018 23:28:02 +0000
Message-ID: <DM5PR2101MB1030EEAC92D8CF826480A6B2DCB30@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180328004840.22787-1-longli@linuxonhyperv.com>
 <20180328004840.22787-3-longli@linuxonhyperv.com>
In-Reply-To: <20180328004840.22787-3-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-04-13T23:28:01.2046805Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB0999;
 7:SD3KefnSr0kJnrvjBNaGH787xK0Rg98bzZsc4bBxEAZO+TFGtdXyn/tZZdYPLO5fMqIOvsXk6xchbmeolrhB/MUjbmXG1uO3zs3Degde0RzFFU8Sr4QMJbyGlxLVJTAJ4R+MMuL4PK3oAMXWE3EqEPTFt2sYDVuWPFhPEWp0+HG3tmLiSQwSCvFsmRkfphsjfDWsk1aE1cYcHHLEk/bd+P2BhrBc+Fw5sGf5nu5GHXEqTT0Hoyr3/g+638Rf9vX4;
 20:cIhfqaRtf8hUSOGjxkfnIVvOYJdt4asIUkI3ab29A5QMk2zrCYTXu69nLiHjyJauFHH/W6KbtWTtDAAEPQH8Grs9YYo+AkIDJromBfnL/D3bDy76wRFv6Q69C+dAmb233fPwPsC94mPzBW/f0SIErmoTyUSB+XtkzqflTMT2F4I=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7193020);
 SRVR:DM5PR2101MB0999;
x-ms-traffictypediagnostic: DM5PR2101MB0999:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09998BAD07CC270A046D5DFADCB30@DM5PR2101MB0999.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(146099531331640); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231232)(944501347)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011);
 SRVR:DM5PR2101MB0999; BCL:0; PCL:0; RULEID:; SRVR:DM5PR2101MB0999;
x-forefront-prvs: 0641678E68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39380400002)(396003)(366004)(346002)(39860400002)(376002)(199004)(189003)(13464003)(10290500003)(59450400001)(5660300001)(446003)(478600001)(486006)(106356001)(86612001)(14454004)(55016002)(76176011)(72206003)(22452003)(2900100001)(7696005)(476003)(99286004)(316002)(11346002)(3846002)(33656002)(6116002)(3280700002)(3660700001)(2906002)(105586002)(81166006)(81156014)(86362001)(53546011)(8676002)(8936002)(6246003)(25786009)(68736007)(305945005)(66066001)(53936002)(110136005)(8990500004)(7736002)(74316002)(26005)(2501003)(5250100002)(575784001)(1511001)(2201001)(102836004)(9686003)(229853002)(6506007)(97736004)(10090500001)(6436002)(921003)(1121003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB0999;
 H:DM5PR2101MB1030.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3cb51acb-c127-448e-d349-08d5a19633c9
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb51acb-c127-448e-d349-08d5a19633c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2018 23:28:02.7433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0999
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
> Sent: Tuesday, March 27, 2018 5:49 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; James E . J . Bottomley <JBottomley@odin.com>;
> Martin K . Petersen <martin.petersen@oracle.com>; devel@linuxdriverproject.org; linux-
> scsi@vger.kernel.org; linux-kernel@vger.kernel.org; netdev@vger.kernel.org
> Cc: Long Li <longli@microsoft.com>
> Subject: [Resend Patch 3/3] Storvsc: Select channel based on available percentage of ring
> buffer to write
> 
> From: Long Li <longli@microsoft.com>
> 
> This is a best effort for estimating on how busy the ring buffer is for
> that channel, based on available buffer to write in percentage. It is still
> possible that at the time of actual ring buffer write, the space may not be
> available due to other processes may be writing at the time.
> 
> Selecting a channel based on how full it is can reduce the possibility that
> a ring buffer write will fail, and avoid the situation a channel is over
> busy.
> 
> Now it's possible that storvsc can use a smaller ring buffer size
> (e.g. 40k bytes) to take advantage of cache locality.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/scsi/storvsc_drv.c | 62 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 50 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index a2ec0bc9e9fa..b1a87072b3ab 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -395,6 +395,12 @@ MODULE_PARM_DESC(storvsc_ringbuffer_size, "Ring buffer size
> (bytes)");
> 
>  module_param(storvsc_vcpus_per_sub_channel, int, S_IRUGO);
>  MODULE_PARM_DESC(storvsc_vcpus_per_sub_channel, "Ratio of VCPUs to subchannels");
> +
> +static int ring_avail_percent_lowater = 10;

Reserving 10% of each ring buffer by default seems like more than is needed
in the storvsc driver.  That would be about 4Kbytes for the 40K ring buffer
you suggest, and even more for a ring buffer of 128K.  Each outgoing record
is only about 344 bytes (I'd have to check exactly).  With the new channel
selection algorithm below, the only time we use a channel that is already
below the low water mark is when no channel could be found that is above
the low water mark.   There could be a case of two or more threads deciding
that a channel is above the low water mark at the same time and both
choosing it, but that's likely to be rare.  So it seems like we could set the
default low water mark to 5 percent or even 3 percent, which will let more
of the ring buffer be used, and let a channel be assigned according to the
algorithm, rather than falling through to the default because all channels
appear to be "full".

> +module_param(ring_avail_percent_lowater, int, S_IRUGO);
> +MODULE_PARM_DESC(ring_avail_percent_lowater,
> +		"Select a channel if available ring size > this in percent");
> +
>  /*
>   * Timeout in seconds for all devices managed by this driver.
>   */
> @@ -1285,9 +1291,9 @@ static int storvsc_do_io(struct hv_device *device,
>  {
>  	struct storvsc_device *stor_device;
>  	struct vstor_packet *vstor_packet;
> -	struct vmbus_channel *outgoing_channel;
> +	struct vmbus_channel *outgoing_channel, *channel;
>  	int ret = 0;
> -	struct cpumask alloced_mask;
> +	struct cpumask alloced_mask, other_numa_mask;
>  	int tgt_cpu;
> 
>  	vstor_packet = &request->vstor_packet;
> @@ -1301,22 +1307,53 @@ static int storvsc_do_io(struct hv_device *device,
>  	/*
>  	 * Select an an appropriate channel to send the request out.
>  	 */
> -
>  	if (stor_device->stor_chns[q_num] != NULL) {
>  		outgoing_channel = stor_device->stor_chns[q_num];
> -		if (outgoing_channel->target_cpu == smp_processor_id()) {
> +		if (outgoing_channel->target_cpu == q_num) {
>  			/*
>  			 * Ideally, we want to pick a different channel if
>  			 * available on the same NUMA node.
>  			 */
>  			cpumask_and(&alloced_mask, &stor_device->alloced_cpus,
>  				    cpumask_of_node(cpu_to_node(q_num)));
> -			for_each_cpu_wrap(tgt_cpu, &alloced_mask,
> -					outgoing_channel->target_cpu + 1) {
> -				if (tgt_cpu != outgoing_channel->target_cpu) {
> -					outgoing_channel =
> -					stor_device->stor_chns[tgt_cpu];
> -					break;
> +
> +			for_each_cpu_wrap(tgt_cpu, &alloced_mask, q_num + 1) {
> +				if (tgt_cpu == q_num)
> +					continue;
> +				channel = stor_device->stor_chns[tgt_cpu];
> +				if (hv_get_avail_to_write_percent(
> +							&channel->outbound)
> +						> ring_avail_percent_lowater) {
> +					outgoing_channel = channel;
> +					goto found_channel;
> +				}
> +			}
> +
> +			/*
> +			 * All the other channels on the same NUMA node are
> +			 * busy. Try to use the channel on the current CPU
> +			 */
> +			if (hv_get_avail_to_write_percent(
> +						&outgoing_channel->outbound)
> +					> ring_avail_percent_lowater)
> +				goto found_channel;
> +
> +			/*
> +			 * If we reach here, all the channels on the current
> +			 * NUMA node are busy. Try to find a channel in
> +			 * other NUMA nodes
> +			 */
> +			cpumask_andnot(&other_numa_mask,
> +					&stor_device->alloced_cpus,
> +					cpumask_of_node(cpu_to_node(q_num)));
> +
> +			for_each_cpu(tgt_cpu, &other_numa_mask) {
> +				channel = stor_device->stor_chns[tgt_cpu];
> +				if (hv_get_avail_to_write_percent(
> +							&channel->outbound)
> +						> ring_avail_percent_lowater) {
> +					outgoing_channel = channel;
> +					goto found_channel;
>  				}
>  			}
>  		}
> @@ -1324,7 +1361,7 @@ static int storvsc_do_io(struct hv_device *device,
>  		outgoing_channel = get_og_chn(stor_device, q_num);
>  	}
> 
> -
> +found_channel:
>  	vstor_packet->flags |= REQUEST_COMPLETION_FLAG;
> 
>  	vstor_packet->vm_srb.length = (sizeof(struct vmscsi_request) -
> @@ -1733,7 +1770,8 @@ static int storvsc_probe(struct hv_device *device,
>  	}
> 
>  	scsi_driver.can_queue = (max_outstanding_req_per_channel *
> -				 (max_sub_channels + 1));
> +				 (max_sub_channels + 1)) *
> +				 (100 - ring_avail_percent_lowater) / 100;

A minor nit, but the use of parentheses here is inconsistent.  There's a
set of parens around the first two expressions to explicitly code the
associativity, but not a set to encompass the third term, which must
be processed before the fourth one is.  C does multiplication and
division with left to right associativity, so the result is as intended.
But if we're depending on C's default associativity, then that set of
parens around the first two expression really isn't needed, and one
wonders why they are there.

Michael

> 
>  	host = scsi_host_alloc(&scsi_driver,
>  			       sizeof(struct hv_host_device));
> --
> 2.14.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
