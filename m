Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0E1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB18E20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WfJNDz9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfAQGp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:45:29 -0500
Received: from mail-eopbgr1310130.outbound.protection.outlook.com ([40.107.131.130]:14490
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726720AbfAQGp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:45:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBcsHhrWY47NDp7DxHs9G6hWHxRLljm6w1RBQFtjgwQ=;
 b=WfJNDz9wMaffIp5FGmMujbqxhAZO7nFhLqBRxvzV7E/4tSoA3u01xtCAsJsfu4vEzuYy/0l1qaLjw2PmI55B9ssoWs+Mu6iR79ijw+rNTjaGTCs00dRx915sKEi2/TzCr0jNPXLTm2oNqASRfW7Yy0w36K0d6yaUSm0pkjKoFrI=
Received: from KU1P153MB0166.APCP153.PROD.OUTLOOK.COM (10.170.173.13) by
 KU1P153MB0182.APCP153.PROD.OUTLOOK.COM (10.170.175.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.2; Thu, 17 Jan 2019 06:45:14 +0000
Received: from KU1P153MB0166.APCP153.PROD.OUTLOOK.COM
 ([fe80::84f5:2b02:1afd:f72d]) by KU1P153MB0166.APCP153.PROD.OUTLOOK.COM
 ([fe80::84f5:2b02:1afd:f72d%5]) with mapi id 15.20.1558.009; Thu, 17 Jan 2019
 06:45:14 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kimbrownkd <kimbrownkd@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] Drivers: hv: vmbus: Expose counters for interrupts and
 full conditions
Thread-Topic: [PATCH v3] Drivers: hv: vmbus: Expose counters for interrupts
 and full conditions
Thread-Index: AQHUrh5ym5Od2NjzUkCFE4xnJ7s7EaWzA8Uw
Date:   Thu, 17 Jan 2019 06:45:14 +0000
Message-ID: <KU1P153MB0166DA6E76D0080C4AD43E01BF830@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
References: <20190105043518.GA4072@ubu-Virtual-Machine>
 <20190117043759.GA3395@ubu-Virtual-Machine>
In-Reply-To: <20190117043759.GA3395@ubu-Virtual-Machine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-17T06:45:11.2364825Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ec3dc672-62f0-4d7d-b131-13bfd52a3caf;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2601:600:a280:1760:ec95:7339:194b:8848]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KU1P153MB0182;6:UqMK1Fhw4Gi6i21gyMcc8koUxl/sSNu8mc5k5ZpdiBx57C3YqCh/0zYVFvTF4h4qbDCEeslhOxlL54x9GSh3/WXTuNIQAi6plvXspqgMvBchtBpJjzeFoES12go3Xn+52+wX3Ygf2dk7VA5VRsq5PYOATHDKCxx2VCw4+wsaFWZwvpQ+swiXQwRViq6OLltxOu0SPsTEk+Xhp860cDGmz6rA1VA0Q3m5xHPC7RK8g9Q3T4ebHn9rSUIAu1zGhYhI4AiM0HDCgRReSDdZlZ1a8BfeqlWwCBJ66lUDk8120f+E2n1oQ71y1gG6mfLM2YL+nEBcRDvRV8wepCDOrA5gcbi6YtGCB3gVTNWP8ELhnvoe/cga8AmT5QGdeLlYNy9QfrBVhGrilumZK/OzxMEdhjAB2FGCd9cj/T2sCKOfCXQYlIvGk1CJE6n9qDOJdrxMxHbcJXC4MORLQriGzJRgBA==;5:ZGlRCS2H4SYVXFk8m95DfFHvpyC4skbaccnaTROlA4KEgfLlSnx9QN42a7MgT7zFyimq/M7ifnpVf5xM7yDJrMp9PrbM84a9WmQmjQDXuW0WhZseuf+Ow0ed4cLGMiUiIoIbNSnERUMuGY9Qxr+/cQREaJ1Pjsmg5ZjNnxFWwv/4TuRDIKAeO/urmunHjOs1b4WcFY/aCZ6T1F7sIfU5sQ==;7:fRKsnd4s1aE7llWtG0870I/64y4DPZPR8FUMUUR5y/M3hNmgBegFkC+g7sdhAzJZAn0P+BMcnwv0e7CjwFvQTEGh+Gse6ygg1SFh+PuBQvd1dScuxDtZ0PcUdGKmC5wd3K50n7p1Sk3ozMDEIYg20g==
x-ms-office365-filtering-correlation-id: 38c0f441-ab43-4221-bdb5-08d67c47560a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7193020);SRVR:KU1P153MB0182;
x-ms-traffictypediagnostic: KU1P153MB0182:
x-ms-exchange-purlcount: -3
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <KU1P153MB01824D55B2A3AAB628EC13ACBF830@KU1P153MB0182.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(39860400002)(136003)(366004)(189003)(199004)(8936002)(110136005)(476003)(22452003)(11346002)(316002)(478600001)(1511001)(106356001)(2906002)(10290500003)(6436002)(97736004)(86612001)(33656002)(5660300001)(446003)(53936002)(6636002)(86362001)(14444005)(256004)(55016002)(71200400001)(54906003)(9686003)(71190400001)(105586002)(14454004)(305945005)(186003)(6246003)(7736002)(102836004)(76176011)(6116002)(7696005)(99286004)(6346003)(6506007)(53546011)(74316002)(39060400002)(10090500001)(8990500004)(68736007)(486006)(229853002)(25786009)(46003)(4326008)(81156014)(81166006)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:KU1P153MB0182;H:KU1P153MB0166.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5KX8cb2TzFmUffrkv+guwmbNU2vW1qrAYjNKeQ2czWTXCrT0jHsmNmNBysd7nTDcFZXea98Sluv2UYYSJqo/Cs33AZG5zEQk8YphUfOO0JJVwJl0p/Hcl6d20PPFlKmeNEDsPKZZjpaqRRp9PqGLhJtDXNXnzi7HpLyl00j7yRigNIBT1wR5cKbs6FdvBY5yhPuF6bpAW2b2jxGXMujjXM8TzP2yexmyfRiNHuKXc3epyg8UXr1loD6SEaOHyPyuAykgSsXaI1bktLxN7UqV8tLWoe8KCMnVKrAIAMUGk/IhjVEaLr+BMgveCbkHgwfubZ8BnDBpv5tcflBXRWjO6SlzINfGnYCqckss1TXz+acoDfb0yE0HtZE+2pRwzdcdMu1wd+yJj5GFaafaDJuwXtfFofvggcbN7LrsnR3n6hg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c0f441-ab43-4221-bdb5-08d67c47560a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 06:45:14.3097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1P153MB0182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Kimberly Brown <kimbrownkd@gmail.com>
> Sent: Wednesday, January 16, 2019 8:38 PM
> To: Michael Kelley <mikelley@microsoft.com>; Long Li
> <longli@microsoft.com>; Sasha Levin <Alexander.Levin@microsoft.com>;
> Dexuan Cui <decui@microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; devel@linuxdriverproject.org;
> linux-kernel@vger.kernel.org
> Subject: [PATCH v3] Drivers: hv: vmbus: Expose counters for interrupts an=
d full
> conditions
>=20
> Counter values for per-channel interrupts and ring buffer full
> conditions are useful for investigating performance.
>=20
> Expose counters in sysfs for 2 types of guest to host interrupts:
> 1) Interrupts caused by the channel's outbound ring buffer transitioning
> from empty to not empty
> 2) Interrupts caused by the channel's inbound ring buffer transitioning
> from full to not full while a packet is waiting for enough buffer space t=
o
> become available
>=20
> Expose 2 counters in sysfs for the number of times that write operations
> encountered a full outbound ring buffer:
> 1) The total number of write operations that encountered a full
> condition
> 2) The number of write operations that were the first to encounter a
> full condition
>=20
> I tested this patch by confirming that the sysfs files were created and
> observing the counter values. The values seemed to increase by a
> reasonable amount when the Hyper-v related drivers were in use.
>=20
> Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
> ---
> Changes in v3:
>  - Used the outbound ring buffer spinlock to protect the the full
>    condition counters in set_channel_pending_send_size()
>  - Corrected the KernelVersion values for the new entries in
>    Documentation/ABI/stable/sysfs-bus-vmbus
>=20
> Changes in v2:
>  - Added mailing lists to the cc list
>  - Removed the host to guest interrupt counters proposed in v1 because
>    they were not accurate
>  - Added full condition counters for the channel's outbound ring buffer
>=20
>  Documentation/ABI/stable/sysfs-bus-vmbus | 33 ++++++++++++++++++++
>  drivers/hv/ring_buffer.c                 | 14 ++++++++-
>  drivers/hv/vmbus_drv.c                   | 32 ++++++++++++++++++++
>  include/linux/hyperv.h                   | 38
> ++++++++++++++++++++++++
>  4 files changed, 116 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus
> b/Documentation/ABI/stable/sysfs-bus-vmbus
> index 3fed8fdb873d..a0304c563467 100644
> --- a/Documentation/ABI/stable/sysfs-bus-vmbus
> +++ b/Documentation/ABI/stable/sysfs-bus-vmbus
> @@ -146,3 +146,36 @@ KernelVersion:	4.16
>  Contact:	Stephen Hemminger <sthemmin@microsoft.com>
>  Description:	Binary file created by uio_hv_generic for ring buffer
>  Users:		Userspace drivers
> +
> +What:
> /sys/bus/vmbus/devices/<UUID>/channels/<N>/intr_in_full
> +Date:           January 2019
> +KernelVersion:  5.0
> +Contact:        Michael Kelley <mikelley@microsoft.com>
> +Description:    Number of guest to host interrupts caused by the inbound
> ring
> +		buffer transitioning from full to not full while a packet is
> +		waiting for buffer space to become available
> +Users:          Debugging tools
> +
> +What:
> /sys/bus/vmbus/devices/<UUID>/channels/<N>/intr_out_empty
> +Date:           January 2019
> +KernelVersion:  5.0
> +Contact:        Michael Kelley <mikelley@microsoft.com>
> +Description:    Number of guest to host interrupts caused by the outboun=
d
> ring
> +		buffer transitioning from empty to not empty
> +Users:          Debugging tools
> +
> +What:
> /sys/bus/vmbus/devices/<UUID>/channels/<N>/out_full_first
> +Date:           January 2019
> +KernelVersion:  5.0
> +Contact:        Michael Kelley <mikelley@microsoft.com>
> +Description:    Number of write operations that were the first to encoun=
ter
> an
> +		outbound ring buffer full condition
> +Users:          Debugging tools
> +
> +What:
> /sys/bus/vmbus/devices/<UUID>/channels/<N>/out_full_total
> +Date:           January 2019
> +KernelVersion:  5.0
> +Contact:        Michael Kelley <mikelley@microsoft.com>
> +Description:    Total number of write operations that encountered an
> outbound
> +		ring buffer full condition
> +Users:          Debugging tools
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index 1f1a55e07733..9e8b31ccc142 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -74,8 +74,10 @@ static void hv_signal_on_write(u32 old_write, struct
> vmbus_channel *channel)
>  	 * This is the only case we need to signal when the
>  	 * ring transitions from being empty to non-empty.
>  	 */
> -	if (old_write =3D=3D READ_ONCE(rbi->ring_buffer->read_index))
> +	if (old_write =3D=3D READ_ONCE(rbi->ring_buffer->read_index)) {
> +		++channel->intr_out_empty;
>  		vmbus_setevent(channel);
> +	}
>  }
>=20
>  /* Get the next write location for the specified ring buffer. */
> @@ -272,10 +274,19 @@ int hv_ringbuffer_write(struct vmbus_channel
> *channel,
>  	 * is empty since the read index =3D=3D write index.
>  	 */
>  	if (bytes_avail_towrite <=3D totalbytes_towrite) {
> +		++channel->out_full_total;
> +
> +		if (!channel->out_full_flag) {
> +			++channel->out_full_first;
> +			channel->out_full_flag =3D true;
> +		}
> +
>  		spin_unlock_irqrestore(&outring_info->ring_lock, flags);
>  		return -EAGAIN;
>  	}
>=20
> +	channel->out_full_flag =3D false;
> +
>  	/* Write to the ring buffer */
>  	next_write_location =3D hv_get_next_write_location(outring_info);
>=20
> @@ -530,6 +541,7 @@ void hv_pkt_iter_close(struct vmbus_channel
> *channel)
>  	if (curr_write_sz <=3D pending_sz)
>  		return;
>=20
> +	++channel->intr_in_full;
>  	vmbus_setevent(channel);
>  }
>  EXPORT_SYMBOL_GPL(hv_pkt_iter_close);
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 403fee01572c..e291a7d3180c 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1496,6 +1496,34 @@ static ssize_t channel_events_show(const struct
> vmbus_channel *channel, char *bu
>  }
>  static VMBUS_CHAN_ATTR(events, S_IRUGO, channel_events_show, NULL);
>=20
> +static ssize_t channel_intr_in_full_show(const struct vmbus_channel
> *channel,
> +					 char *buf)
> +{
> +	return sprintf(buf, "%llu\n", channel->intr_in_full);
> +}
> +static VMBUS_CHAN_ATTR(intr_in_full, 0444, channel_intr_in_full_show,
> NULL);
> +
> +static ssize_t channel_intr_out_empty_show(const struct vmbus_channel
> *channel,
> +					   char *buf)
> +{
> +	return sprintf(buf, "%llu\n", channel->intr_out_empty);
> +}
> +static VMBUS_CHAN_ATTR(intr_out_empty, 0444,
> channel_intr_out_empty_show, NULL);
> +
> +static ssize_t channel_out_full_first_show(const struct vmbus_channel
> *channel,
> +					   char *buf)
> +{
> +	return sprintf(buf, "%llu\n", channel->out_full_first);
> +}
> +static VMBUS_CHAN_ATTR(out_full_first, 0444, channel_out_full_first_show=
,
> NULL);
> +
> +static ssize_t channel_out_full_total_show(const struct vmbus_channel
> *channel,
> +					   char *buf)
> +{
> +	return sprintf(buf, "%llu\n", channel->out_full_total);
> +}
> +static VMBUS_CHAN_ATTR(out_full_total, 0444, channel_out_full_total_show=
,
> NULL);
> +
>  static ssize_t subchannel_monitor_id_show(const struct vmbus_channel
> *channel,
>  					  char *buf)
>  {
> @@ -1521,6 +1549,10 @@ static struct attribute *vmbus_chan_attrs[] =3D {
>  	&chan_attr_latency.attr,
>  	&chan_attr_interrupts.attr,
>  	&chan_attr_events.attr,
> +	&chan_attr_intr_in_full.attr,
> +	&chan_attr_intr_out_empty.attr,
> +	&chan_attr_out_full_first.attr,
> +	&chan_attr_out_full_total.attr,
>  	&chan_attr_monitor_id.attr,
>  	&chan_attr_subchannel_id.attr,
>  	NULL
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index dcb6977afce9..7e5239123276 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -751,6 +751,27 @@ struct vmbus_channel {
>  	u64	interrupts;	/* Host to Guest interrupts */
>  	u64	sig_events;	/* Guest to Host events */
>=20
> +	/* Interrupt counts for 2 types of Guest to Host interrupts */
> +	u64 intr_in_full;	/* in ring buffer, full to not full */
> +	u64 intr_out_empty;	/* out ring buffer, empty to not empty */
> +
> +	/*
> +	 * The total number of write operations that encountered a full
> +	 * outbound ring buffer.
> +	 */
> +	u64 out_full_total;
> +	/*
> +	 * The number of write operations that were the first to encounter a
> +	 * full outbound ring buffer.
> +	 */
> +	u64 out_full_first;
> +	/*
> +	 * Indicates that a full outbound ring buffer was encountered. The flag
> +	 * is set to true when a full outbound ring buffer is encountered and
> +	 * set to false when a write to the outbound ring buffer is completed.
> +	 */
> +	bool out_full_flag;
> +
>  	/* Channel callback's invoked in softirq context */
>  	struct tasklet_struct callback_event;
>  	void (*onchannel_callback)(void *context);
> @@ -936,6 +957,23 @@ static inline void *get_per_channel_state(struct
> vmbus_channel *c)
>  static inline void set_channel_pending_send_size(struct vmbus_channel *c=
,
>  						 u32 size)
>  {
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&c->outbound.ring_lock, flags);
> +
> +	if (size) {
> +		++c->out_full_total;
> +
> +		if (!c->out_full_flag) {
> +			++c->out_full_first;
> +			c->out_full_flag =3D true;
> +		}
> +	} else {
> +		c->out_full_flag =3D false;
> +	}
> +
> +	spin_unlock_irqrestore(&c->outbound.ring_lock, flags);
> +
>  	c->outbound.ring_buffer->pending_send_sz =3D size;
>  }
>=20
> --
> 2.17.1

Looks good to me.=20

Reviewed-by: Dexuan Cui <decui@microsoft.com>

-- Dexuan

