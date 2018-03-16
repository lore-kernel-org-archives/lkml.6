Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3643406-1521224835-2-17318703187685589076
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521224835; b=k3HTweQa/y+uB0crhs13Qu6MzataKkoH0DSpgK+emXncqYp
    Hbo3/lZ5717xCxQNPsaptxxXAieRB2DU0eYhvuQYIC58YRYhXumx6F3u2N+Z+wRz
    pEI783eV6VatRVh1yCJPJi8r0rA02Heg4ASlpmn1IVdYch0HAVNXXhqeYETDDtqE
    8WHxij8ziKUDozP+XXKMcTGGDM34kdQFg01/SsB2G9phKfJ8U6NAivGc2Soo0eQh
    LQnrSjCiO6u2/fF60ObIfB1blOHcdMLyDDWyNuP9tyncFMw4/ifG+XT1hsm/8vH6
    QL3+GZjNbVSTcKDc/4YezbYD8DqloecESvYwxyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521224835; bh=5
    K1jw3O0jLK/YlLf7IPqeIU9QLHgpkT40wvSC2DmVAU=; b=gTO4JlEtWzcARWxNm
    bybvreQToJmQWQPaIt8UVdejEW1esyNFIrP6J5qcknN4/Oi+tXwtCVVkhuFnzer0
    nQLupiiZo1smH9DQW+PaiGwUH/Afs4ZtrsldS6XsKv2Do8s8T00CCAQJVxarQ2+9
    Ek9qWWqPzutkoysb8txrFJjc9VvNco4bUAUGW0DVZ0LoScP+SMI6iTU/Ey3bwB2O
    ep5Xbl9P8mqdtHZwHtySlsIEDVJKr1ah4mYXobxAhwLoD1whvhTvArhrLm9/mdQ3
    IFN+WE1X4vxAE/P5o/f5dJlzny/Skx4LVl7QYtlInJk6i2xw/c5sg5dYDxRqGQeQ
    X4Zdw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YiEXxZEj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YiEXxZEj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Long Li <longli@microsoft.com>
To: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>, KY Srinivasan
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen
 Hemminger <sthemmin@microsoft.com>, "James E . J . Bottomley"
 <JBottomley@odin.com>, "Martin K . Petersen" <martin.petersen@oracle.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] storvsc: Set up correct queue depth values for IDE devices
Thread-Topic: [PATCH] storvsc: Set up correct queue depth values for IDE
 devices
Thread-Index: AQHTvLjTJ3ePeO5x9ESYCa+BVYK1xqPTBI0AgAAVpUA=
Date: Fri, 16 Mar 2018 18:27:04 +0000
Message-ID: <MWHPR2101MB0729A35B6ED1CF85E2A557BACED70@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20180315235223.19844-1-longli@exchange.microsoft.com>
 <DM5PR2101MB103058D9867D0A84E79A682CDCD70@DM5PR2101MB1030.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR2101MB103058D9867D0A84E79A682CDCD70@DM5PR2101MB1030.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:a::2e0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR2101MB0873;
 7:iEOIz+cZGNCl31oGVWbz5hLH2V8odYlifhszlF4y63nXPdgDL0n/vaTXTjHnIiiFx4Uo5xwpNLypX27M7d7e+w1sX+yUZWkRUaL0xWDxvW1ZIaMMdXQhNUKetEEK116H+Ni818DDuBkq7wu6sKO6xIJOwadHM/7g/usKiH2/yKFIOctENFkwaBoiRknYV1lzQZ8FLc4mxakeYT2cpucmMIH0YFYGVc4wFDSW8BfoJHwSi0Ygr1R+87cL/HQLsoq2;
 20:b9p+++CzXHm1qBXmRAg8XlY4/JjFSwjfk39l6xgblRaZK/xM9Yun8w49Y/GcadbqR0pVo+5QS8QshoGY6q4rrjJKaFWeFUl3v8h7m+hC9dAk3rsXwu9mEtNV/wucO9NvTiEpQ2HitiMDtZFglCbflj8BuSiAP81M/OqNnLZK5eE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 29d26457-ea33-48d0-c99e-08d58b6b84bf
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);
 SRVR:MWHPR2101MB0873;
x-ms-traffictypediagnostic: MWHPR2101MB0873:
x-microsoft-antispam-prvs: <MWHPR2101MB087366E4290FFDFD4FD3DF92CED70@MWHPR2101MB0873.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501281)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);
 SRVR:MWHPR2101MB0873; BCL:0; PCL:0; RULEID:; SRVR:MWHPR2101MB0873;
x-forefront-prvs: 0613912E23
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(376002)(39860400002)(396003)(39380400002)(189003)(199004)(6116002)(10090500001)(55016002)(14454004)(3660700001)(3280700002)(9686003)(2900100001)(2906002)(6346003)(105586002)(53936002)(102836004)(2201001)(86362001)(68736007)(97736004)(46003)(8990500004)(5250100002)(478600001)(10290500003)(6436002)(25786009)(6506007)(2501003)(22452003)(8676002)(99286004)(229853002)(59450400001)(7696005)(2950100002)(8936002)(81166006)(7736002)(81156014)(6246003)(74316002)(106356001)(33656002)(305945005)(86612001)(76176011)(316002)(1511001)(5660300001)(110136005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR2101MB0873;
 H:MWHPR2101MB0729.namprd21.prod.outlook.com; FPR:; SPF:None; PTR:InfoNoRecords;
 MX:1; A:1; LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com;
x-microsoft-antispam-message-info: Lsd9LXaAkKsbAFad//bGXv8ba5ffp8W3rN0f+0Q8nofWSaRSJdKSJ7ps02svTibWXudzEnbzTRd5f0puxqufP0anqH6WvO0/TNzLc0ri677KNRY14H5QEeIHMqj+KW5NrkEGnz7mf9giAmATVLoduTEvhWsW2KceLrGBVAjvX+poWEmD2L1jsn9Lkt+Tc4uzoaq2rKvMc8rwJZcwy3CJUULCYqLi6HCwf78XoSSB3BACBacypEUpPQLMt+bSbB/VloIGpunTHycvZmpvODStOCJL/R9Ogs5+6WAfjaLqAU1Q7GPlCcLya+P9CP+msGBiS+R6z0V6Ekv3qLmbcG53Ng==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d26457-ea33-48d0-c99e-08d58b6b84bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2018 18:27:04.6153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0873
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

> > Subject: [PATCH] storvsc: Set up correct queue depth values for IDE
> > devices
> >
> > From: Long Li <longli@microsoft.com>
> >
> > Unlike SCSI and FC, we don't use multiple channels for IDE. So set
> > queue depth correctly for IDE.
> >
> > Also set the correct cmd_per_lun for all devices.
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >  drivers/scsi/storvsc_drv.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> > index 8c51d628b52e..fba170640e9c 100644
> > --- a/drivers/scsi/storvsc_drv.c
> > +++ b/drivers/scsi/storvsc_drv.c
> > @@ -1722,15 +1722,19 @@ static int storvsc_probe(struct hv_device
> *device,
> >  		max_targets = STORVSC_MAX_TARGETS;
> >  		max_channels = STORVSC_MAX_CHANNELS;
> >  		/*
> > -		 * On Windows8 and above, we support sub-channels for
> storage.
> > +		 * On Windows8 and above, we support sub-channels for
> storage
> > +		 * on SCSI and FC controllers.
> >  		 * The number of sub-channels offerred is based on the
> number of
> >  		 * VCPUs in the guest.
> >  		 */
> > -		max_sub_channels = (num_cpus /
> storvsc_vcpus_per_sub_channel);
> > +		if (!dev_is_ide)
> > +			max_sub_channels =
> > +				num_cpus / storvsc_vcpus_per_sub_channel;
> 
> This calculation of the # of sub-channels doesn't get the right answer (and it
> didn't before this patch either).  storvsc_vcpus_per_sub_channel defaults to
> 4.
> If num_cpus is 8, max_sub_channels will be 2, but it should be 1.  The sub-
> channel count should not include the main channel since we add 1 to the
> sub-channel count below when calculating can_queue.

This is a good point. I will fix the code calculating can_queue.

> 
> Furthermore, this is calculation is just a guess, in the sense that we're
> replicating the algorithm we think Hyper-V is using to determine the number
> of sub-channels to offer.   It turns out Hyper-V is changing that algorithm for
> particular devices in an upcoming new Azure VM size.  But the only use of
> max_sub_channels is in the calculation of can_queue below, so the impact is
> minimal.
> 
> >  	}
> >
> >  	scsi_driver.can_queue = (max_outstanding_req_per_channel *
> >  				 (max_sub_channels + 1));
> > +	scsi_driver.cmd_per_lun = scsi_driver.can_queue;
> 
> can_queue is defined as "int", while cmd_per_lun is defined as "short".
> The calculated value of can_queue could easily be over 32,767 with
> 15 sub-channels and max_outstanding_req_per_channel being 3036 for the
> default 1 Mbyte ring buffer.  So the assignment to cmd_per_lun could
> produce truncation and even a negative number.

This is a good catch. I think I should try calling blk_set_queue_depth() and pass the correct value. 

> 
> More broadly, since max_outstanding_req_per_channel is based on the ring
> buffer size, these calculations imply that Hyper-V storvsp's queuing capacity
> is based on the ring buffer size.  I don't think that's the case.  From
> conversations with the storvsp folks, I think Hyper-V always removes entries
> from the guest->host ring buffer and then
> lets storvsp queue them separately.   So we don't want to be linking
> cmd_per_lun (or even can_queue, for that matter) to the ring buffer size.
> The current default ring buffer size of 1 Mbyte is probably 10x bigger than
> needed, and we want to be able to adjust that without ending up with
> can_queue and cmd_per_lun values that are too small.

cmd_per_lun needs to reflect the device capacity. What value do you propose? It's not a good idea to leave them constant. Setting those values are also important because we don't' want to return BUSY on writing to ring buffer on full, that will slow down the SCSI stack.

Historically we use ring buffer size to calculate device properties (e.g. can_queue for SCSI host).

I agree this doesn't need to be based on the exact queuing capacity of ring buffer, maybe we can do 2X of that value (e.g. look at how block uses nr_request in MQ). Setting those values smaller is more conservative and I don't see an ill effect.

> 
> We would probably do better to set can_queue to a constant, and
> leave cmd_per_lun at its current value of 2048.   The can_queue
> value is already capped at 10240 in the blk-mq layer, so maybe that's a
> reasonable constant to use.

Actually this is not a good idea for smaller ring buffers. You'll see the problem when setting both ring buffer sizes to 10 pages.

> 
> Thoughts?
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
