Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-400001-1518412406-2-10296994434466918783
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518412405; b=lsptFUaJjhdELEhN7zIJdtdYabPrb+b1wNZXumK5B3bEgE8
    vhwPL6SXoy7xepVtPyZT8D+QLRD/jvjTBNJ27rAgl4JuD06GhaCtdCj72TY69atT
    G2Ug6V7Go/gVHH0U2jALY3gkuz1avsf/B539PXz2E25Q3o04QM0r8aek4Uua/Zpy
    NRn7OKY3yqP6nqvy9/HqKVmVQHZjvEY//YOF9tB6wt9sr0CqAR023nSHO3z9dooY
    kLNGSL+9G7YnaDxZ7jJG8L6mFZzTPEVB02BywLOSIKuljTH4pFr01y4bBBH2uIYM
    XT9goDQFs3TJWbyaNbHV0f5zdb5Z0uROiNnFhaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518412405; bh=V
    z7XwD7JBDf0+2cBLySlN8PVnOIMlTDGsJrDYiu5ZWU=; b=p9uWfAk7HHgj5GYrD
    Slkoaco40jSokvbNISdW4JCMqJ1laRYkI6/5bKFvkZ3xBEY6CbubLkAKATi25fW2
    kkgmXy2bfDhKZTh/fWynilJHn9I80TmsO17LiWxKYr7jSP0nbB0eheQeGaqPvXMF
    r1CrccTk95uElq3jJbJ4/x5N4v2pYQkXECy6HszJPK8FxtIx87aNTSYSdiY7s2FG
    3AqFQyN8O9J2OMzN3tCMEbv52xlwDfSejkrIC6NvR+OTqfEfqDDha99jX8RopX+F
    UmIgBMBzWM12x6gLPsd7qD4lJ6aQeGOZzsykevnmcTTzF7r0KioYNHdjK+JC0ZWu
    FfuOQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BRpqmBHi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BRpqmBHi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: KY Srinivasan <kys@microsoft.com>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org"
 <devel@linuxdriverproject.org>, "olaf@aepfle.de" <olaf@aepfle.de>,
 "apw@canonical.com" <apw@canonical.com>, "vkuznets@redhat.com"
 <vkuznets@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "leann.ogasawara@canonical.com" <leann.ogasawara@canonical.com>,
 "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>, Stephen
 Hemminger <sthemmin@microsoft.com>
Subject: RE: [PATCH char-misc 1/1] Drivers: hv: vmbus: Fix ring buffer
 signaling
Thread-Topic: [PATCH char-misc 1/1] Drivers: hv: vmbus: Fix ring buffer
 signaling
Thread-Index: AQHTorCNaQB4t9RCq0qElSZLQrwNpaOf8abQgABFFXA=
Date: Mon, 12 Feb 2018 05:13:07 +0000
Message-ID: <DM5PR2101MB10304037A2AE19B48ECFFEB9DCF70@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <SN6PR1901MB204572CAD3159EB07D6F1043CBF10@SN6PR1901MB2045.namprd19.prod.outlook.com>
 <DM5PR2101MB0888E82FA2CD667F9E040F6FA0F70@DM5PR2101MB0888.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR2101MB0888E82FA2CD667F9E040F6FA0F70@DM5PR2101MB0888.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-02-12T05:13:06.2328730Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB0967;
 7:E2ZBUays2W2YPFp5GF/dstEQW7R5rERIlkrXF1gQyihZfSEHSD/5jPdw5RjrofDYyWJ2gwbQBoBSo+rI/xNKO2cfvnABYam33co4lDDI1YXYPyQtToIN3u4PxjT27slpzmKVraVuLRHP35tODECjQlYtfCQVjWp+XzUuHbnTZpvnfLmAMcLU0jhipuhYxObko9tKydMFFX+ifNEOAz2A5EVmUK7DDhCAXAc2IQp0YKW6uF/n0o8UIWsFqpYv6LlR
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI; SCL:-1; SFV:NSPM;
 SFS:(10019020)(366004)(39380400002)(396003)(39860400002)(376002)(346002)(13464003)(189003)(199004)(10090500001)(7736002)(86612001)(106356001)(305945005)(74316002)(8990500004)(33656002)(6116002)(81156014)(81166006)(229853002)(8676002)(68736007)(14454004)(3846002)(97736004)(2900100001)(26005)(1511001)(6506007)(59450400001)(66066001)(6346003)(72206003)(105586002)(102836004)(2950100002)(6636002)(2906002)(25786009)(3280700002)(8936002)(110136005)(76176011)(3660700001)(6246003)(316002)(5250100002)(478600001)(53936002)(10290500003)(86362001)(2501003)(9686003)(55016002)(99286004)(5660300001)(7696005)(6436002)(2201001)(22452003)(921003)(1121003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB0967;
 H:DM5PR2101MB1030.namprd21.prod.outlook.com; FPR:; SPF:None; PTR:InfoNoRecords;
 MX:1; A:1; LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0695b209-8b5b-46b5-e440-08d571d74ddf
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);
 SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
x-microsoft-antispam-prvs: <DM5PR2101MB0967587297EC0DC590F0C223DCF70@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231101)(944501161)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);
 SRVR:DM5PR2101MB0967; BCL:0; PCL:0; RULEID:; SRVR:DM5PR2101MB0967;
x-forefront-prvs: 0581B5AB35
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-message-info: NjTCBsFHK0BCyW7SgB5/KVH9fTMqwxRP40horNu0HBsSMl2KUAdKjPAKMPO3rkqbZL4B8JAQaAH23+UsCHtV+Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0695b209-8b5b-46b5-e440-08d571d74ddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2018 05:13:07.9417 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
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
> From: KY Srinivasan
> Sent: Sunday, February 11, 2018 5:14 PM

--- snip ---

> >  	if (rbi->ring_buffer->feature_bits.feat_pending_send_sz) {
> >  		u32 pending_sz = READ_ONCE(rbi->ring_buffer-
> > >pending_send_sz);
> >
> >  		/*
> > +		 * Ensure the read of write_index in
> > hv_get_bytes_to_write()
> > +		 * happens after the read of pending_send_sz.
> > +		 */
> > +		virt_rmb();
> We can avoid the read barrier by making the initialization of curr_write_sz conditional
> on pending_send_sz being non-zero. Indeed you can make all the signaling code conditional
> on pending_send_sz being non-zero.
> 
> 

I agree that we can immediately test pending_send_sz for zero, and exit
if zero.  A  zero value will be by far the most common path, and would
save executing the read barrier and hv_get_bytes_to_write().  Can also
move the calculation of "delta" to after the test for zero.

But I believe the read barrier is still needed on the path where
pending_send_sz is non-zero.  Just the testing the value of pending_send_sz
doesn't guarantee that the write_index wouldn't be speculatively read,
and potentially out-of-order.   And we have to consider the out-of-order
behaviors on ARM64 as well.

> 
> > +		curr_write_sz = hv_get_bytes_to_write(rbi);
> > +
> > +		/*
> >  		 * If there was space before we began iteration,
> >  		 * then host was not blocked. Also handles case where
> >  		 * pending_sz is zero then host has nothing pending
> >  		 * and does not need to be signaled.
> >  		 */
> > -		if (orig_write_sz > pending_sz)
> > +		if (curr_write_sz - delta > pending_sz)
> >  			return;
> >
> >  		/* If pending write will not fit, don't give false hope. */
> > -		if (hv_get_bytes_to_write(rbi) < pending_sz)
> > +		if (curr_write_sz <= pending_sz)
> >  			return;
> > +
> > +		vmbus_setevent(channel);
> >  	}
> >
> > -	vmbus_setevent(channel);
> >  }
> >  EXPORT_SYMBOL_GPL(hv_pkt_iter_close);
> > --
> > 1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
