Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3089025-1524423245-2-11456436816136319197
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524423244; b=YKeayyPlgDhFhSSbLz58/78nmG0ip3OobZDzhmdkNBUFcD1YD6
    u8OECHRAf//yfhyKuLgYFHFHeM6dy0/LCo+8nNyRQuqxA4SY6PhnEDMs9kyDobAe
    8/7z+bM5TG0sNICjEWBvk7Dj9xEoYPigJ+/VrDU5HpboH3qMYebJ4gUWjOob6R6d
    f9YZQv13IpTrrsiHnVe5z+J9fNZirxpjkknCogrfvlpV0B+2YSYQBSWhEvDQ2tiY
    DOHUxrzYGOakbulkpxygMTjhGKxRpTAcvU+2rBYxvOfsxsTLjA/oVMoEImz8Bxr9
    twJD/tqvJHqnX5L60kBBUuBNWdy8fyZfxLfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524423244; bh=YJ95Q
    YjuA/h+PVn1D+3oxHF0PQ87OX58DoomgXtOUF8=; b=F2Fg11Zv1l8ARlcz1IlGE
    +Fid+/46gIc1RHuaLjGjSOtHVAIH0xVOwLU0vA5K9Ao/z/1+g9qiAgkkVQQ7znh8
    uDiwUbPnr5K7armRkINs0xxsJtUtP/YW6D/NtsN0INh9LZRV/+OkdMuBE4CZnoJS
    RflXC6jDtcyZlPXHlsvz90zY8FG5ZwnlHLNb6jpzQylB3DHOxni5gjLuMSVBkEi9
    8dCyjupHMc/Kboa0sZBcA7bZgH1jmFu76LJN2OG+Lxevfp5fAr/cs8Hu3p1wGoQk
    Jt81fno35j9I3MdssyCDxbKSD2O5LgP9X3uuVjQmdqXD/EkIIOLTaZL4sYg/KG4N
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gtdzaQWx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gtdzaQWx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGPkz1YJILSrD61GJEUMOsP6H5ybKPUvHgEw2E+TwElpw2nBjiTghDK4qQUvlhWEVxFR/ewpsS7QYStwB0UENdSVO7IqiQwO8qyOcML8vKB/AXaXi282
    oXDQFNe0Og/KkWudYVytsHufCbPPazhS4XjkEv4mpcdsqzGYy4BZggrraskouel385qJlLK8HIAfJ4UGny2b2FCl9GAwRdS23WfP0Fb8oYaTDP9ZOJTaXSSe
    SeP756TbO2yjgCU4SfJLmQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=_TKFW_rNyuwA:10 a=ezrDjaGQ7gEA:10
    a=qcIjco1Mu_QA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8
    a=yMhMjlubAAAA:8 a=6n1iNii3AAAA:8 a=yPCof4ZbAAAA:8 a=DDOyTI_5AAAA:8
    a=bLrKj6CCBsbiOs20E5MA:9 a=3-y7RFO4Y7UorcTI:21 a=8sQcNlvcgqNtBC36:21
    a=CjuIK1q_8ugA:10 a=q3R5zVSKXvcA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=qL8UFIJES1IU-uv6apQ6:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Long Li <longli@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch v2] Storvsc: Select channel based on available percentage
 of ring buffer to write
Thread-Topic: [Patch v2] Storvsc: Select channel based on available percentage
 of ring buffer to write
Thread-Index: AQHT2CkqR9YezLI5XE6FO01srmeVR6QJ19gA
Date: Sun, 22 Apr 2018 18:53:50 +0000
Message-ID: <DM5PR2101MB1030DC17E849B106A223E40EDC8A0@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180419215424.3557-1-longli@linuxonhyperv.com>
In-Reply-To: <20180419215424.3557-1-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-04-22T18:53:49.0243569Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB1031;
 7:zm/0UltpFU2c6EqlpEO8ZUKbVDf/6vfggxbDqLksk3yAWbY/xlWfFyG3404Q0zvfIb+mV+dOthj9FzqzjfXjuE/v3i+VtrIpQwo2Sc5hHgIhuqRK21BgZpjHnVZFMBSiTeFluJEVf69xV8jNBk+CNIpdlFscX1+1B+4lYzXQpFqABEkK3r8J+/bjw/8XjN4rXK7UQyv/ikgIWTPLHLqF13tz17xwlPpu6awOu+cYQw5pUo6EONGxEhdSaKcs6tle;
 20:2AzyKWt3X0+6HLnUd97WGLWXnUl4Z6J7k5yEn84PJEeMpg4E7Ey0WkBGySeqIElvAai823v4keepYwtRV/IMqqJSfpYk22XEUIAnjT1pVB907CrkDi1lpDwroukLgAGBlRvjTOgsEnBBSmBAPIX4SOBVb9Ct8UeWZjh5+1jbXLA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7193020);
 SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: outbound.protection.outlook.com; spf=skipped
 (originating message); dkim=none (message not signed) header.d=none;
 dmarc=none action=none header.from=microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10310CD228373B1ECD144003DC8A0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(146099531331640); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);
 SRVR:DM5PR2101MB1031; BCL:0; PCL:0; RULEID:; SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0650714AAA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(39380400002)(39860400002)(346002)(396003)(13464003)(6246003)(81166006)(229853002)(3660700001)(53936002)(9686003)(5250100002)(2501003)(86612001)(476003)(6116002)(3846002)(25786009)(6506007)(53546011)(86362001)(2201001)(6436002)(575784001)(8936002)(8676002)(74316002)(55016002)(1511001)(66066001)(7736002)(305945005)(10290500003)(5660300001)(478600001)(110136005)(72206003)(11346002)(316002)(22452003)(7696005)(33656002)(2900100001)(76176011)(446003)(3280700002)(2906002)(26005)(59450400001)(102836004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB1031;
 H:DM5PR2101MB1030.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en; MLV:sfv;
x-microsoft-antispam-message-info: Iq7PtflckQbqIjjFzqxs0oDzvI68SwVQEDZCocoAPqyY7AYi3cgcIDpzhwI0OvylgHLQwIwAZ3jTWXV3N4Ue/kYT5iybRUfTmPssyyhrBH9PfzaDpwICKy6FfwLb8JAnqmOrfKyYaTsQCsbRcvxZ7Mbhh5HAx6wjHAMnwPw45m5dpz8wkfBIDYOsNtP/OpNc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 315d3c19-3111-42e9-b97e-08d5a8826346
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315d3c19-3111-42e9-b97e-08d5a8826346
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2018 18:53:50.5105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
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
> Sent: Thursday, April 19, 2018 2:54 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; James E . J . Bottomley <JBottomley@odin.com>;
> Martin K . Petersen <martin.petersen@oracle.com>; devel@linuxdriverproject.org; linux-
> scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Long Li <longli@microsoft.com>
> Subject: [Patch v2] Storvsc: Select channel based on available percentage of ring buffer to
> write
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
> Changes.
> v2: Pre-allocate struct cpumask on the heap.
> Struct cpumask is a big structure (1k bytes) when CONFIG_NR_CPUS=8192 (default
> value when CONFIG_MAXSMP=y). Don't use kernel stack for it by pre-allocating
> them using kmalloc when channels are first initialized.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/scsi/storvsc_drv.c | 90 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 72 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index a2ec0bc9e9fa..2a9fff94dd1a 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -395,6 +395,12 @@ MODULE_PARM_DESC(storvsc_ringbuffer_size, "Ring buffer size
> (bytes)");
> 
>  module_param(storvsc_vcpus_per_sub_channel, int, S_IRUGO);
>  MODULE_PARM_DESC(storvsc_vcpus_per_sub_channel, "Ratio of VCPUs to subchannels");
> +
> +static int ring_avail_percent_lowater = 10;
> +module_param(ring_avail_percent_lowater, int, S_IRUGO);
> +MODULE_PARM_DESC(ring_avail_percent_lowater,
> +		"Select a channel if available ring size > this in percent");
> +
>  /*
>   * Timeout in seconds for all devices managed by this driver.
>   */
> @@ -468,6 +474,13 @@ struct storvsc_device {
>  	 * Mask of CPUs bound to subchannels.
>  	 */
>  	struct cpumask alloced_cpus;
> +	/*
> +	 * Pre-allocated struct cpumask for each hardware queue.
> +	 * struct cpumask is used by selecting out-going channels. It is a
> +	 * big structure, default to 1024k bytes when CONFIG_MAXSMP=y.

I think you mean "1024 bytes" or "1k bytes" in the above comment.

> +	 * Pre-allocate it to avoid allocation on the kernel stack.
> +	 */
> +	struct cpumask *cpumask_chns;
>  	/* Used for vsc/vsp channel reset process */
>  	struct storvsc_cmd_request init_request;
>  	struct storvsc_cmd_request reset_request;
> @@ -872,6 +885,13 @@ static int storvsc_channel_init(struct hv_device *device, bool is_fc)
>  	if (stor_device->stor_chns == NULL)
>  		return -ENOMEM;
> 
> +	stor_device->cpumask_chns = kcalloc(num_possible_cpus(),
> +			sizeof(struct cpumask), GFP_KERNEL);

Note that num_possible_cpus() is 240 for a Hyper-V 2016 guest unless 
overridden on the kernel boot line, so this is going to allocate 240 Kbytes for each
synthetic SCSI controller.  On an Azure VM, which has two IDE and two SCSI
controllers, this is nearly 1 Mbyte.  It's unfortunate to have to allocate this much
memory for a what is essentially a temporary variable.   Further down in these
comments, I've proposed an alternate implementation of the code that avoids
the need for the temporary variable, and hence avoids the need for this
allocation.

> +	if (stor_device->cpumask_chns == NULL) {
> +		kfree(stor_device->stor_chns);
> +		return -ENOMEM;
> +	}
> +
>  	stor_device->stor_chns[device->channel->target_cpu] = device->channel;
>  	cpumask_set_cpu(device->channel->target_cpu,
>  			&stor_device->alloced_cpus);
> @@ -1232,6 +1252,7 @@ static int storvsc_dev_remove(struct hv_device *device)
>  	vmbus_close(device->channel);
> 
>  	kfree(stor_device->stor_chns);
> +	kfree(stor_device->cpumask_chns);
>  	kfree(stor_device);
>  	return 0;
>  }
> @@ -1241,7 +1262,7 @@ static struct vmbus_channel *get_og_chn(struct storvsc_device
> *stor_device,
>  {1G/
>  	u16 slot = 0;
>  	u16 hash_qnum;
> -	struct cpumask alloced_mask;
> +	struct cpumask *alloced_mask = &stor_device->cpumask_chns[q_num];
>  	int num_channels, tgt_cpu;
> 
>  	if (stor_device->num_sc == 0)
> @@ -1257,10 +1278,10 @@ static struct vmbus_channel *get_og_chn(struct storvsc_device
> *stor_device,
>  	 * III. Mapping is persistent.
>  	 */
> 
> -	cpumask_and(&alloced_mask, &stor_device->alloced_cpus,
> +	cpumask_and(alloced_mask, &stor_device->alloced_cpus,
>  		    cpumask_of_node(cpu_to_node(q_num)));
> 
> -	num_channels = cpumask_weight(&alloced_mask);
> +	num_channels = cpumask_weight(alloced_mask);
>  	if (num_channels == 0)
>  		return stor_device->device->channel;
> 
> @@ -1268,7 +1289,7 @@ static struct vmbus_channel *get_og_chn(struct storvsc_device
> *stor_device,
>  	while (hash_qnum >= num_channels)
>  		hash_qnum -= num_channels;
> 
> -	for_each_cpu(tgt_cpu, &alloced_mask) {
> +	for_each_cpu(tgt_cpu, alloced_mask) {
>  		if (slot == hash_qnum)
>  			break;
>  		slot++;

Here's an alternate implementation of the core code in get_og_chn() that avoids
the need for a struct cpumask as a temporary variable.  It checks the node
cpumask on-the-fly, rather than precomputing the logical AND.  This
implementation might be slightly slower from a CPU standpoint, but the
alloced_cpus mask is sparse, and get_og_chn() is only called a few
times at the beginning of the usage of the synthetic SCSI controller, so it
has no material impact.

	const struct cpumask *node_mask;

	node_mask = cpumask_of_node(cpu_to_node(q_num));

	num_channels = 0;
	for_each_cpu(tgt_cpu, &stor_device->alloced_cpus) {
		if (cpumask_test_cpu(tgt_cpu, node_mask))
			num_channels++;
	}
	if (num_channels == 0)
		return stor_device->device->channel;

	hash_qnum = q_num;
	while (hash_qnum >= num_channels)
		hash_qnum -= num_channels;

	for_each_cpu(tgt_cpu, &stor_device->alloced_cpus) {
		if (!cpumask_test_cpu(tgt_cpu, node_mask))
			continue;
		if (slot == hash_qnum)
			break;
		slot++;
	}

The same approach of checking the node cpumask on-the-fly instead of
pre-computing can also be used in storvsc_do_io().   The perf impact in
storvsc_do_io() is probably nil.   Then with both uses of the temp cpumask
eliminated, the large memory allocation for it could be removed.

> @@ -1285,9 +1306,9 @@ static int storvsc_do_io(struct hv_device *device,
>  {
>  	struct storvsc_device *stor_device;
>  	struct vstor_packet *vstor_packet;
> -	struct vmbus_channel *outgoing_channel;
> +	struct vmbus_channel *outgoing_channel, *channel;
>  	int ret = 0;
> -	struct cpumask alloced_mask;
> +	struct cpumask *alloced_mask;
>  	int tgt_cpu;
> 
>  	vstor_packet = &request->vstor_packet;
> @@ -1301,22 +1322,53 @@ static int storvsc_do_io(struct hv_device *device,
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
> -			cpumask_and(&alloced_mask, &stor_device->alloced_cpus,
> +			alloced_mask = &stor_device->cpumask_chns[q_num];
> +			cpumask_and(alloced_mask, &stor_device->alloced_cpus,
>  				    cpumask_of_node(cpu_to_node(q_num)));
> -			for_each_cpu_wrap(tgt_cpu, &alloced_mask,
> -					outgoing_channel->target_cpu + 1) {
> -				if (tgt_cpu != outgoing_channel->target_cpu) {
> -					outgoing_channel =
> -					stor_device->stor_chns[tgt_cpu];
> -					break;
> +
> +			for_each_cpu_wrap(tgt_cpu, alloced_mask, q_num + 1) {
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
> +			cpumask_andnot(alloced_mask, &stor_device->alloced_cpus,
> +					cpumask_of_node(cpu_to_node(q_num)));
> +
> +			for_each_cpu(tgt_cpu, alloced_mask) {
> +				channel = stor_device->stor_chns[tgt_cpu];
> +				if (hv_get_avail_to_write_percent(
> +							&channel->outbound)
> +						> ring_avail_percent_lowater) {
> +					outgoing_channel = channel;
> +					goto found_channel;
>  				}
>  			}
>  		}
> @@ -1324,7 +1376,7 @@ static int storvsc_do_io(struct hv_device *device,
>  		outgoing_channel = get_og_chn(stor_device, q_num);
>  	}
> 
> -
> +found_channel:
>  	vstor_packet->flags |= REQUEST_COMPLETION_FLAG;
> 
>  	vstor_packet->vm_srb.length = (sizeof(struct vmscsi_request) -
> @@ -1732,8 +1784,9 @@ static int storvsc_probe(struct hv_device *device,
>  				(num_cpus - 1) / storvsc_vcpus_per_sub_channel;
>  	}
> 
> -	scsi_driver.can_queue = (max_outstanding_req_per_channel *
> -				 (max_sub_channels + 1));
> +	scsi_driver.can_queue = max_outstanding_req_per_channel *
> +				(max_sub_channels + 1) *
> +				(100 - ring_avail_percent_lowater) / 100;
> 
>  	host = scsi_host_alloc(&scsi_driver,
>  			       sizeof(struct hv_host_device));
> @@ -1864,6 +1917,7 @@ static int storvsc_probe(struct hv_device *device,
> 
>  err_out1:
>  	kfree(stor_device->stor_chns);
> +	kfree(stor_device->cpumask_chns);
>  	kfree(stor_device);

I don't think the memory freeing in err_out1 is correct.  You end up
in err_out1 when storvsc_connect_to_vsp() fails.  But it could fail in
multiple scenarios, some of which leave cpumask_chns allocated, and
some of which don't.   As a result you could free memory that isn't allocated
or that has already been freed.  In fact, the same problem already exists
for stor_chns.  I'm not sure about stor_device itself.

> 
>  err_out0:
> --
> 2.14.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
