Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4157049-1518398069-2-16007415957603861399
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518398068; b=ngC+kPKFQ3nwFqV/VP4eBpjq318YvkHYxE3CkfhHiJ8GRt7
    xkScs/ZDGLgM/5tmSOUmfcSZgbDwkVU2Bu22xzopp+zkhqcwf8/Mwr/gT5X9f74q
    +/X6hvCI0k9J0a+Kn6ZmmAPOKqBSDWoxSlTJ98xgpR1OiPrDOxGHGgtZexwBPb8L
    +FQpJpxiKgTN53dlwsOdnaXcTAwQgFPtLFBa6aY2k8U+WvQ0qdT2M29gQ/gQOLsD
    AujZLNC/3aHZx0WQoSwt5wKNQ7vGImhmXtUwk+FtC6DbRQaF2vI6TMehNE4g+qBt
    PcjOko3WQe0OTuAblTPDwoT7OLktykzXWACJd6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518398068; bh=R
    JUYeq8Oz6VBh849w+Kqolog4t9bBatOkM4NCXENRnw=; b=YkrV7k0xcBdlnvk5d
    9DPeRFsHGpwKH3oWw4gLdXn9YCiuyMsnfcYSJIzSs0buquMle2rK66Q+qgtdSybm
    GV+TC++qjgPiUjFW+IdR4HXhCnhapK7fcDiny4SVInzdfPsW787BemGsOcsJ0X+P
    CwKs6Do21R3GijT5nJMHyoMfDLL0V2yZ1XrwJSQwV03IQtgmT5OReZZCnoJYghV5
    8nfoAY12OJwmWeuvuiB8AbzZTnRL36xcM/4SfDy1wZ4PB7t7lVJlSbM4F73VW3TA
    HmZPvcvRd0s4kiYTfJwWpSdGLih4GGUl+ySuQ9jF9mEGOjN0I3I4jyF2I/4gQMEo
    7AEeQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XfGj7FlV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XfGj7FlV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: KY Srinivasan <kys@microsoft.com>
To: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "leann.ogasawara@canonical.com"
 <leann.ogasawara@canonical.com>, "marcelo.cerri@canonical.com"
 <marcelo.cerri@canonical.com>, Stephen Hemminger <sthemmin@microsoft.com>
Subject: RE: [PATCH char-misc 1/1] Drivers: hv: vmbus: Fix ring buffer
 signaling
Thread-Topic: [PATCH char-misc 1/1] Drivers: hv: vmbus: Fix ring buffer
 signaling
Thread-Index: AQHTorCNaQB4t9RCq0qElSZLQrwNpaOf8abQ
Date: Mon, 12 Feb 2018 01:14:16 +0000
Message-ID: <DM5PR2101MB0888E82FA2CD667F9E040F6FA0F70@DM5PR2101MB0888.namprd21.prod.outlook.com>
References: <SN6PR1901MB204572CAD3159EB07D6F1043CBF10@SN6PR1901MB2045.namprd19.prod.outlook.com>
In-Reply-To: <SN6PR1901MB204572CAD3159EB07D6F1043CBF10@SN6PR1901MB2045.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:b076:3b2a:409c:285e]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB1045;
 7:0Q/C9pNTCZUOOnqJgAH+6a4S6L2eqtFByAC9NieXbANtJJMwNl7Nu8r/eNgVYRlRs+gpnpy9JVhh4/oaFZdNNPxGt98/gca/CNT3yBUTdfC67+ojvNx4BXDfjPtUC5AySvB027zQU2dib8uqdZb/o23gj6RBHK1Z8C+8JHlkoHAOs4NUqbiF99ecf3fnp9JQdzI/JKX8UhaRo4kXxsh30eSx0mPgFofGyJm5LE8V39RfrPA53DYsKSvfqDjKKmzh
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI; SCL:-1; SFV:NSPM;
 SFS:(10019020)(39380400002)(39860400002)(396003)(376002)(346002)(366004)(199004)(189003)(13464003)(86362001)(55016002)(7696005)(5660300001)(10290500003)(102836004)(68736007)(5250100002)(86612001)(2201001)(229853002)(59450400001)(22452003)(2501003)(6506007)(81156014)(3280700002)(53546011)(97736004)(81166006)(305945005)(8676002)(8936002)(74316002)(14454004)(9686003)(10090500001)(53936002)(7736002)(33656002)(110136005)(25786009)(99286004)(2950100002)(105586002)(6636002)(6436002)(76176011)(106356001)(316002)(2906002)(3660700001)(6346003)(6246003)(2900100001)(6116002)(1511001)(478600001)(8990500004)(921003)(1121003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB1045;
 H:DM5PR2101MB0888.namprd21.prod.outlook.com; FPR:; SPF:None; PTR:InfoNoRecords;
 A:1; MX:1; LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e43b9769-5343-43ed-75fb-08d571b5ef94
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);
 SRVR:DM5PR2101MB1045;
x-ms-traffictypediagnostic: DM5PR2101MB1045:
x-microsoft-antispam-prvs: <DM5PR2101MB10455AEEC7762E6D006C75F3A0F70@DM5PR2101MB1045.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(189930954265078)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231101)(944501161)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);
 SRVR:DM5PR2101MB1045; BCL:0; PCL:0; RULEID:; SRVR:DM5PR2101MB1045;
x-forefront-prvs: 0581B5AB35
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com;
x-microsoft-antispam-message-info: FNoUCN0htSu0J/n1ANpFrL93mV5UgLWR4Rf/BhjOwnqat541lsg9lICxeEgQixel2fGDuFTlOQB6WJtL3DUXTw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43b9769-5343-43ed-75fb-08d571b5ef94
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2018 01:14:16.2804 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1045
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
> From: Michael Kelley [mailto:mhkelley@outlook.com]
> Sent: Saturday, February 10, 2018 12:49 PM
> To: gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> vkuznets@redhat.com; jasowang@redhat.com;
> leann.ogasawara@canonical.com; marcelo.cerri@canonical.com; Stephen
> Hemminger <sthemmin@microsoft.com>; KY Srinivasan
> <kys@microsoft.com>
> Cc: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
> Subject: [PATCH char-misc 1/1] Drivers: hv: vmbus: Fix ring buffer signaling
> 
> Fix bugs in signaling the Hyper-V host when freeing space in the
> host->guest ring buffer:
> 
> 1. The interrupt_mask must not be used to determine whether to signal
>    on the host->guest ring buffer
> 2. The ring buffer write_index must be read (via hv_get_bytes_to_write)
>    *after* pending_send_sz is read in order to avoid a race condition
> 3. Comparisons with pending_send_sz must treat the "equals" case as
>    not-enough-space
> 4. Don't signal if the pending_send_sz feature is not present. Older
>    versions of Hyper-V that don't implement this feature will poll.
> 
> Fixes: 03bad714a161 ("vmbus: more host signalling avoidance")
> Signed-off-by: Michael Kelley <mhkelley@outlook.com>
> ---
>  drivers/hv/ring_buffer.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index 50e0714..b64be18 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -423,7 +423,11 @@ struct vmpacket_descriptor *
>  void hv_pkt_iter_close(struct vmbus_channel *channel)
>  {
>  	struct hv_ring_buffer_info *rbi = &channel->inbound;
> -	u32 orig_write_sz = hv_get_bytes_to_write(rbi);
> +	u32 curr_write_sz;
> +	u32 delta = rbi->ring_buffer->read_index < rbi->priv_read_index ?
> +			(rbi->priv_read_index - rbi->ring_buffer-
> >read_index) :
> +			(rbi->ring_datasize - rbi->ring_buffer->read_index +
> +			rbi->priv_read_index);
> 
>  	/*
>  	 * Make sure all reads are done before we update the read index
> since
> @@ -446,27 +450,31 @@ void hv_pkt_iter_close(struct vmbus_channel
> *channel)
>  	 */
>  	virt_mb();
> 
> -	/* If host has disabled notifications then skip */
> -	if (rbi->ring_buffer->interrupt_mask)
> -		return;
> -
>  	if (rbi->ring_buffer->feature_bits.feat_pending_send_sz) {
>  		u32 pending_sz = READ_ONCE(rbi->ring_buffer-
> >pending_send_sz);
> 
>  		/*
> +		 * Ensure the read of write_index in
> hv_get_bytes_to_write()
> +		 * happens after the read of pending_send_sz.
> +		 */
> +		virt_rmb();
We can avoid the read barrier by making the initialization of curr_write_sz conditional
on pending_send_sz being non-zero. Indeed you can make all the signaling code conditional
on pending_send_sz being non-zero.



> +		curr_write_sz = hv_get_bytes_to_write(rbi);
> +
> +		/*
>  		 * If there was space before we began iteration,
>  		 * then host was not blocked. Also handles case where
>  		 * pending_sz is zero then host has nothing pending
>  		 * and does not need to be signaled.
>  		 */
> -		if (orig_write_sz > pending_sz)
> +		if (curr_write_sz - delta > pending_sz)
>  			return;
> 
>  		/* If pending write will not fit, don't give false hope. */
> -		if (hv_get_bytes_to_write(rbi) < pending_sz)
> +		if (curr_write_sz <= pending_sz)
>  			return;
> +
> +		vmbus_setevent(channel);
>  	}
> 
> -	vmbus_setevent(channel);
>  }
>  EXPORT_SYMBOL_GPL(hv_pkt_iter_close);
> --
> 1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
