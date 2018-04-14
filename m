Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-765530-1523665550-2-9491878998666587957
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523665549; b=ZRankQRmV/fHLiBm3gPBr8RVSJriXKhHZdi10ApYx7f5vbxy/S
    DPhTYu8UC5yQOvDPTXUAfWP7LAdM3QZ82LE71NwY2G97vuMbYU1TFsnuvWYZCA+u
    ZwbBNvTqZmsMoeP6PBf2R3ty8t0Zy/ZbMhueruwWupsVyRA/ISRakiTxaj1StM4H
    dLfvb1AvOXIuguDixjsgg2BSezPk87QXZZpRxcP1buFx5LDOv7jXO20k4xtjEEk4
    +jFdqkhxihzyTCJxZR1sG3/04CjPFN7s2PepWUHuhcVDjLeARgAESjMkJCqSzVEq
    00GO3U2X13+bvCbsESQwrROIXPKahAz9pn/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523665549; bh=81WGx
    3qGwQUWNJPrYjrT8u6jV2tnGsp75JMGmT1a0gg=; b=ht0QHB89IQhi8BAEMOjs2
    D+BLAqeRltiGW8kovZg4HxhXGGr2wSiFf8lrppuXaNvdNV0iyM5mCDHJApY+cGDm
    hTIMzzqZ2TTgojjlg3qflp4FrAShr/lPCXqaSXH75hxdyjEaw3u282ReKKNxNq9H
    PAONhzJ9DIQBn+is1Y1luDwhiz/uv0BYYRAp4jSJsqky1yOh5FzqPkG+9Qxf1Ic/
    H7YdaSZM0XHxvtd0RBgLcNijJKfDf/Qshl6Mwe1sHPVuUgwvt4crzcpbcZVJSxCQ
    GArPvajsq+bmJwgZywtqhuW68CWuvz4pHL5eH0D6NhmPDuAFpSutqFRrUb+z4XYG
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SJMlJNAS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SJMlJNAS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIQ3nIMoCmZyOzH+QVQVOqIHdcVXLDBhbkZDw6WhrVAz0cbaI+3logGslm/VzyMOZ/8gyhj1mwW2j6qx2X8NjntClvpgKtcdVgeI1+qdFgvu6oicZCaO
    Pbab0Ipb4MwQvXrqEDxgMJ9lUBKK2OuEd0OzfQl+vRpkAkQdtoWuE97U57reixm4qp83Z2400RrVRQ2hz/9Z62LgTjQPBxR/N+bvbZUcCW4aAA1tpVqNsZ1h
    R9pkKvuD8iq0AbajGr5img==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=R4fxTKrshSIA:10 a=wYU4eDHypp4A:10
    a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=6n1iNii3AAAA:8 a=yPCof4ZbAAAA:8 a=DDOyTI_5AAAA:8 a=0_U7rEv-6FN5rD5Zhi4A:9
    a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=8F0xi9zRR1lQFnpU:21 a=Z8MvBrJDMiimzW58:21
    a=CjuIK1q_8ugA:10 a=jTGqg1QAfmIA:10 a=q3R5zVSKXvcA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=qL8UFIJES1IU-uv6apQ6:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Long Li <longli@microsoft.com>
To: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>, KY Srinivasan
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen
 Hemminger <sthemmin@microsoft.com>, "James E . J . Bottomley"
 <JBottomley@odin.com>, "Martin K . Petersen" <martin.petersen@oracle.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Resend Patch 3/3] Storvsc: Select channel based on available
 percentage of ring buffer to write
Thread-Topic: [Resend Patch 3/3] Storvsc: Select channel based on available
 percentage of ring buffer to write
Thread-Index: AQHTxi7FMhV2Xzbr2EmsxAzgm0aQn6P/ccQAgAAM6tA=
Date: Sat, 14 Apr 2018 00:25:38 +0000
Message-ID: <MWHPR2101MB07297FFF2901EA6D7ED1173ECEB20@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20180328004840.22787-1-longli@linuxonhyperv.com>
 <20180328004840.22787-3-longli@linuxonhyperv.com>
 <DM5PR2101MB1030EEAC92D8CF826480A6B2DCB30@DM5PR2101MB1030.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR2101MB1030EEAC92D8CF826480A6B2DCB30@DM5PR2101MB1030.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:f::2e0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR2101MB0810;
 7:ZW3yD3blLe6cGHjupYRdWUasQRne/0QomLhqQoMWaIrAHFsYqoCM1pV6pYIIk//77hj0NypEGn/V656aZWuys2iRsK70dl1LrPXHK4Dp7pS2upleG0c7PtOJnKT76XUBYyQG7An2JNt1bDb+hPqnI7uF1dQTae31s8wVLVaaGzukK004b9baFHMCTHjOMq10gizaKNw9q7qk1aR3A5Lch2pZzW4licAjHJz7O7eYJMOSAY18R1/not3mTPea0Z7b;
 20:FzNVP0rpfLnOei3frB5xufwevKi7K3OGcZlM83+DYmIuMcmKhnDkltb6b3dIb8tQgiJrKLMpQZMI65h30DIDelAu//Pj1R9IR1fqib76OH1BRgINz/nmR3T5hfWu3zyUboi1kMwdLVrEOy6sOpUsPqEhM4zfwLywOzXmIQejLes=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7193020);
 SRVR:MWHPR2101MB0810;
x-ms-traffictypediagnostic: MWHPR2101MB0810:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com;
x-microsoft-antispam-prvs: <MWHPR2101MB081091F0BB0E76DF08FD9DE2CEB20@MWHPR2101MB0810.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(146099531331640); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231232)(944501347)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011);
 SRVR:MWHPR2101MB0810; BCL:0; PCL:0; RULEID:; SRVR:MWHPR2101MB0810;
x-forefront-prvs: 0642A5E7BA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39380400002)(39860400002)(376002)(346002)(396003)(366004)(13464003)(189003)(199004)(6116002)(59450400001)(446003)(1511001)(46003)(97736004)(486006)(33656002)(25786009)(22452003)(316002)(3280700002)(3660700001)(2906002)(76176011)(476003)(7696005)(9686003)(55016002)(53936002)(229853002)(6436002)(6246003)(106356001)(105586002)(11346002)(478600001)(2900100001)(14454004)(5250100002)(2501003)(5660300001)(102836004)(2201001)(7736002)(86362001)(68736007)(8676002)(8990500004)(81156014)(81166006)(575784001)(10290500003)(86612001)(110136005)(8936002)(53546011)(6506007)(99286004)(305945005)(74316002)(10090500001)(921003)(1121003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR2101MB0810;
 H:MWHPR2101MB0729.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5278cfc4-2dd4-44f6-3115-08d5a19e3f7d
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5278cfc4-2dd4-44f6-3115-08d5a19e3f7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2018 00:25:38.2535 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0810
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

> Subject: RE: [Resend Patch 3/3] Storvsc: Select channel based on available
> percentage of ring buffer to write
> 
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org
> > <linux-kernel-owner@vger.kernel.org> On Behalf Of Long Li
> > Sent: Tuesday, March 27, 2018 5:49 PM
> > To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>;
> > James E . J . Bottomley <JBottomley@odin.com>; Martin K . Petersen
> > <martin.petersen@oracle.com>; devel@linuxdriverproject.org; linux-
> > scsi@vger.kernel.org; linux-kernel@vger.kernel.org;
> > netdev@vger.kernel.org
> > Cc: Long Li <longli@microsoft.com>
> > Subject: [Resend Patch 3/3] Storvsc: Select channel based on available
> > percentage of ring buffer to write
> >
> > From: Long Li <longli@microsoft.com>
> >
> > This is a best effort for estimating on how busy the ring buffer is
> > for that channel, based on available buffer to write in percentage. It
> > is still possible that at the time of actual ring buffer write, the
> > space may not be available due to other processes may be writing at the
> time.
> >
> > Selecting a channel based on how full it is can reduce the possibility
> > that a ring buffer write will fail, and avoid the situation a channel
> > is over busy.
> >
> > Now it's possible that storvsc can use a smaller ring buffer size
> > (e.g. 40k bytes) to take advantage of cache locality.
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >  drivers/scsi/storvsc_drv.c | 62
> > +++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 50 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> > index a2ec0bc9e9fa..b1a87072b3ab 100644
> > --- a/drivers/scsi/storvsc_drv.c
> > +++ b/drivers/scsi/storvsc_drv.c
> > @@ -395,6 +395,12 @@ MODULE_PARM_DESC(storvsc_ringbuffer_size,
> "Ring
> > buffer size (bytes)");
> >
> >  module_param(storvsc_vcpus_per_sub_channel, int, S_IRUGO);
> > MODULE_PARM_DESC(storvsc_vcpus_per_sub_channel, "Ratio of VCPUs
> to
> > subchannels");
> > +
> > +static int ring_avail_percent_lowater = 10;
> 
> Reserving 10% of each ring buffer by default seems like more than is needed
> in the storvsc driver.  That would be about 4Kbytes for the 40K ring buffer
> you suggest, and even more for a ring buffer of 128K.  Each outgoing record is
> only about 344 bytes (I'd have to check exactly).  With the new channel
> selection algorithm below, the only time we use a channel that is already
> below the low water mark is when no channel could be found that is above
> the low water mark.   There could be a case of two or more threads deciding
> that a channel is above the low water mark at the same time and both
> choosing it, but that's likely to be rare.  So it seems like we could set the

It's not rare for two processes checking on the same channel at the same time, when running multiple processes I/O workload. The CPU to channel is not 1:1 mapping.

> default low water mark to 5 percent or even 3 percent, which will let more of
> the ring buffer be used, and let a channel be assigned according to the
> algorithm, rather than falling through to the default because all channels
> appear to be "full".

It seems it's not about how big ring buffer is, e.g. even you have a ring buffer of infinite size, it won't help with performance if it's getting queued all the time, while other ring buffers are near empty. It's more about how multiple ring buffers are getting utilized in a reasonable and balanced way. Testing shows 10 is a good choice, while 3 is prone to return BUSY and trigger block layer retry.

> 
> > +module_param(ring_avail_percent_lowater, int, S_IRUGO);
> > +MODULE_PARM_DESC(ring_avail_percent_lowater,
> > +		"Select a channel if available ring size > this in percent");
> > +
> >  /*
> >   * Timeout in seconds for all devices managed by this driver.
> >   */
> > @@ -1285,9 +1291,9 @@ static int storvsc_do_io(struct hv_device
> > *device,  {
> >  	struct storvsc_device *stor_device;
> >  	struct vstor_packet *vstor_packet;
> > -	struct vmbus_channel *outgoing_channel;
> > +	struct vmbus_channel *outgoing_channel, *channel;
> >  	int ret = 0;
> > -	struct cpumask alloced_mask;
> > +	struct cpumask alloced_mask, other_numa_mask;
> >  	int tgt_cpu;
> >
> >  	vstor_packet = &request->vstor_packet; @@ -1301,22 +1307,53 @@
> > static int storvsc_do_io(struct hv_device *device,
> >  	/*
> >  	 * Select an an appropriate channel to send the request out.
> >  	 */
> > -
> >  	if (stor_device->stor_chns[q_num] != NULL) {
> >  		outgoing_channel = stor_device->stor_chns[q_num];
> > -		if (outgoing_channel->target_cpu == smp_processor_id()) {
> > +		if (outgoing_channel->target_cpu == q_num) {
> >  			/*
> >  			 * Ideally, we want to pick a different channel if
> >  			 * available on the same NUMA node.
> >  			 */
> >  			cpumask_and(&alloced_mask, &stor_device-
> >alloced_cpus,
> >
> cpumask_of_node(cpu_to_node(q_num)));
> > -			for_each_cpu_wrap(tgt_cpu, &alloced_mask,
> > -					outgoing_channel->target_cpu + 1) {
> > -				if (tgt_cpu != outgoing_channel->target_cpu)
> {
> > -					outgoing_channel =
> > -					stor_device->stor_chns[tgt_cpu];
> > -					break;
> > +
> > +			for_each_cpu_wrap(tgt_cpu, &alloced_mask,
> q_num + 1) {
> > +				if (tgt_cpu == q_num)
> > +					continue;
> > +				channel = stor_device->stor_chns[tgt_cpu];
> > +				if (hv_get_avail_to_write_percent(
> > +							&channel->outbound)
> > +						> ring_avail_percent_lowater)
> {
> > +					outgoing_channel = channel;
> > +					goto found_channel;
> > +				}
> > +			}
> > +
> > +			/*
> > +			 * All the other channels on the same NUMA node
> are
> > +			 * busy. Try to use the channel on the current CPU
> > +			 */
> > +			if (hv_get_avail_to_write_percent(
> > +						&outgoing_channel-
> >outbound)
> > +					> ring_avail_percent_lowater)
> > +				goto found_channel;
> > +
> > +			/*
> > +			 * If we reach here, all the channels on the current
> > +			 * NUMA node are busy. Try to find a channel in
> > +			 * other NUMA nodes
> > +			 */
> > +			cpumask_andnot(&other_numa_mask,
> > +					&stor_device->alloced_cpus,
> > +
> 	cpumask_of_node(cpu_to_node(q_num)));
> > +
> > +			for_each_cpu(tgt_cpu, &other_numa_mask) {
> > +				channel = stor_device->stor_chns[tgt_cpu];
> > +				if (hv_get_avail_to_write_percent(
> > +							&channel->outbound)
> > +						> ring_avail_percent_lowater)
> {
> > +					outgoing_channel = channel;
> > +					goto found_channel;
> >  				}
> >  			}
> >  		}
> > @@ -1324,7 +1361,7 @@ static int storvsc_do_io(struct hv_device *device,
> >  		outgoing_channel = get_og_chn(stor_device, q_num);
> >  	}
> >
> > -
> > +found_channel:
> >  	vstor_packet->flags |= REQUEST_COMPLETION_FLAG;
> >
> >  	vstor_packet->vm_srb.length = (sizeof(struct vmscsi_request) - @@
> > -1733,7 +1770,8 @@ static int storvsc_probe(struct hv_device *device,
> >  	}
> >
> >  	scsi_driver.can_queue = (max_outstanding_req_per_channel *
> > -				 (max_sub_channels + 1));
> > +				 (max_sub_channels + 1)) *
> > +				 (100 - ring_avail_percent_lowater) / 100;
> 
> A minor nit, but the use of parentheses here is inconsistent.  There's a set of
> parens around the first two expressions to explicitly code the associativity,
> but not a set to encompass the third term, which must be processed before
> the fourth one is.  C does multiplication and division with left to right
> associativity, so the result is as intended.
> But if we're depending on C's default associativity, then that set of parens
> around the first two expression really isn't needed, and one wonders why
> they are there.
> 
> Michael
> 
> >
> >  	host = scsi_host_alloc(&scsi_driver,
> >  			       sizeof(struct hv_host_device));
> > --
> > 2.14.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
