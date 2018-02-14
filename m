Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1638231-1518577136-2-10878338935706413892
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
    t=1518577135; b=vYdmGtWpwADmEOYdMbiZaFA91aMPP9gaTVcoz/gwuK8fb8v
    oTAMFShQE4GtTZk7TLU+21NTLbOnKFWIlIVcj63q2+nny4O+x3SZlbSpgX/Zg8se
    GXkGdcCo5Wb+3E1QGNgiGsbaGkOiy4fUEIDEY3T20i00vOeIahXEJI7cgrKMfoS2
    QLnqN6RtgDMfhAJEglJ320K3HrvrmJLY73YXrm1YMEMgsb4nv2hFK3LVQOt0FAS0
    6bJniHrHslN31PeJfWY2a17Jm9PI2OTPgXzEqof/UM6d/RSQ3fQnNGsUmp3iLwrm
    4itIfprdEtvCQPKHtxg5pjG5kCMXpwYtTlnHMmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518577135; bh=u
    ym4WD+Y6g/oezGKKyGAXrH+RzGHsnOkalrF/Fsax/w=; b=MPWUQvJr17WdOHnfY
    dJrSKTZzGgJjadyHYVfPy7LqjXdI5b/NwWUz9YVcR9q/tvTqvb06bblbHla9aeqg
    P3UFSf/K66jxXBD7R5OJ+5vXKlyWksN6joEeCF9fyGdz2jpmwtg3jPtTCwdZEDYa
    fA3ozTLKT2B8ZP2jk1Ui8VxiJfmhkPGliFwNcvPBywWjokeXlkSfZ4CkxBlxntUa
    cZCQVlWTLoLoBjHzS2W0r/esed53hatBV3WdZudg5Yx3Ni0V5/MNv+UJBrD9KQGu
    EP+dkhYxBQ+SzVrlYLUcoklyKV9ZJb55p0yGD/Vf299wwaVU0KlUimGI+6dO1EEI
    2GdBA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OZUODshn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OZUODshn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, KY Srinivasan
 <kys@microsoft.com>, Stephen Hemminger <stephen@networkplumber.org>
Subject: RE: [PATCH 08/12] Drivers: hv: vmbus: Implement Direct Mode for
 stimer0
Thread-Topic: [PATCH 08/12] Drivers: hv: vmbus: Implement Direct Mode for
 stimer0
Thread-Index: AQHTo5lFobNXfjOrDUmo7WDTP+0tvaOgc4WAgAC+D8A=
Date: Wed, 14 Feb 2018 02:58:41 +0000
Message-ID: <DM5PR2101MB1030958D199D3D111440F1A1DCF50@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180212002958.6679-1-kys@exchange.microsoft.com>
 <20180212003320.6748-1-kys@exchange.microsoft.com>
 <20180212003320.6748-8-kys@exchange.microsoft.com>
 <20180212084205.idjf2lwrdn2nprw7@mwanda>
In-Reply-To: <20180212084205.idjf2lwrdn2nprw7@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-02-14T02:58:35.4496918Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [72.234.30.88]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB0887;
 7:eXUkDscB7QkxuUvrLFHQJcGQQeeGSFVWu0qzRlHYUdQW2msDGY0zSGLH3SmfhFx+E2iC0SjLU2BSGchaVTYd6BjtpHM0+9kVFkoB3+7uBAtV+wdwBIvBLfd/ukY6Rx/jYZqjm2+TQAHvUi9aM/ZNgY+JU4MsOT1KoPhuycsBGLHgzoFf7B/YECFrHe1KkeYwKtFPz4DyNUiUUfglS2Ue/kR+5HlX4f+nktMb4avmkt54QkUh5PuEAXZ99HR7cohc
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI; SCL:-1; SFV:NSPM;
 SFS:(10019020)(346002)(396003)(376002)(39860400002)(39380400002)(366004)(13464003)(199004)(189003)(97736004)(10090500001)(3280700002)(107886003)(6246003)(1511001)(66066001)(229853002)(2906002)(7736002)(106356001)(74316002)(99286004)(59450400001)(5250100002)(14454004)(305945005)(8936002)(9686003)(81156014)(55016002)(76176011)(8676002)(81166006)(8990500004)(53936002)(4326008)(5660300001)(86362001)(3660700001)(68736007)(7696005)(6436002)(2950100002)(53546011)(6506007)(105586002)(3846002)(6116002)(186003)(26005)(6346003)(25786009)(86612001)(102836004)(7416002)(72206003)(10290500003)(478600001)(93886005)(22452003)(316002)(110136005)(54906003)(33656002)(2900100001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB0887;
 H:DM5PR2101MB1030.namprd21.prod.outlook.com; FPR:; SPF:None; PTR:InfoNoRecords;
 A:1; MX:1; LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c7e9e91d-e45c-4b64-0615-08d57356da80
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);
 SRVR:DM5PR2101MB0887;
x-ms-traffictypediagnostic: DM5PR2101MB0887:
x-microsoft-antispam-prvs: <DM5PR2101MB0887F5DD60283044BFFBD12FDCF50@DM5PR2101MB0887.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(140211028294663)(146099531331640)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001016)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231101)(944501161)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
 SRVR:DM5PR2101MB0887; BCL:0; PCL:0; RULEID:; SRVR:DM5PR2101MB0887;
x-forefront-prvs: 0583A86C08
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-message-info: sraFbpLtLH5XRPjTL07iWhtVyPLsxugXTxupnfr5t22bDXp141Z8FFQ1HP/NV8i6KMHPN1M59dsBu2Z6Anw9Kg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e9e91d-e45c-4b64-0615-08d57356da80
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2018 02:58:41.1116 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0887
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
Cc: "olaf@aepfle.de" <olaf@aepfle.de>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
 "apw@canonical.com" <apw@canonical.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "leann.ogasawara@canonical.com" <leann.ogasawara@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Monday, February 12, 2018 12:42 AM
> To: KY Srinivasan <kys@microsoft.com>; Stephen Hemminger
> <stephen@networkplumber.org>
> Cc: gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org; devel@linuxdriverproject.org;
> olaf@aepfle.de; apw@canonical.com; vkuznets@redhat.com; jasowang@redhat.com;
> leann.ogasawara@canonical.com; marcelo.cerri@canonical.com; Stephen Hemminger
> <sthemmin@microsoft.com>; Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
> Subject: Re: [PATCH 08/12] Drivers: hv: vmbus: Implement Direct Mode for stimer0
> 
> On Sun, Feb 11, 2018 at 05:33:16PM -0700, kys@exchange.microsoft.com wrote:
> > @@ -116,9 +146,29 @@ static int hv_ce_set_oneshot(struct clock_event_device *evt)
> >  {
> >  	union hv_timer_config timer_cfg;
> >
> > +	timer_cfg.as_uint64 = 0;
> >  	timer_cfg.enable = 1;
> >  	timer_cfg.auto_enable = 1;
> > -	timer_cfg.sintx = VMBUS_MESSAGE_SINT;
> > +	if (direct_mode_enabled)
> > +		/*
> > +		 * When it expires, the timer will directly interrupt
> > +		 * on the specified hardware vector/IRQ.
> > +		 */
> > +		{
> > +		timer_cfg.direct_mode = 1;
> > +		timer_cfg.apic_vector = stimer0_vector;
> > +		hv_enable_stimer0_percpu_irq(stimer0_irq);
> > +		}
> > +	else
> > +		/*
> > +		 * When it expires, the timer will generate a VMbus message,
> > +		 * to be handled by the normal VMbus interrupt handler.
> > +		 */
> > +		{
> > +		timer_cfg.direct_mode = 0;
> > +		timer_cfg.sintx = VMBUS_MESSAGE_SINT;
> > +		}
> > +
> 
> This indenting isn't right.  We should probably zero out .apic_vector
> if .direct_mode is zero.  Or maybe it's fine.  I don't know if any
> static analysis tools will complain...

I'll fix the indenting.  Old habits ....

The " timer_cfg.as_uint64 = 0" statement already zero's out .apic_vector
along with all the other unused fields in the 64-bit value, as required by
the Hyper-V spec.

> 
> >  	hv_init_timer_config(HV_X64_MSR_STIMER0_CONFIG, timer_cfg.as_uint64);
> >
> >  	return 0;
> > @@ -191,6 +241,10 @@ int hv_synic_alloc(void)
> >  		INIT_LIST_HEAD(&hv_cpu->chan_list);
> >  	}
> >
> > +	if (direct_mode_enabled && hv_setup_stimer0_irq(
> > +		&stimer0_irq, &stimer0_vector, hv_stimer0_isr))
> > +		goto err;
> 
> 
> Can you indent it like this:
> 
> 	if (direct_mode_enabled &&
> 	    hv_setup_stimer0_irq(&stimer0_irq, &stimer0_vector,
> 				 hv_stimer0_isr))
> 		goto err;

OK -- will change.

> 
> 
> [ What follows is a long rant not directed at you ]
> 
> It's annoying because as soon as I see the "goto err;", I know the error
> handling for this function is going to be buggy...
> 
> Some rules of error handling are:
> 
> 1)  Each function should clean up after itself instead returning
>     partially allocated structures.
> 2)  Each allocation function should have a matching free function.
> 3)  Give meaningful label names based on what the label location so that
>     we can tell what the goto does just by looking at it, such as,
>     "goto free_some_variable".  This way we can just keep a mental tally
>     of the most recently allocated resource and verify based on the
>     "goto free_resource;" statemetn that it frees the correct thing.  We
>     don't need to scroll to the bottom of the function.
> 
>     Using good names means that we should avoid do-nothing gotos
>     because, by definition, the label name for a do-nothing goto is
>     going to be vague.
> 
> In this case the label looks like this:
> 
> > +
> >  	return 0;
> >  err:
> >  	return -ENOMEM;
> 
> We allocate a bunch of stuff in this function so at first glance this
> looks like we leak everything but, actually, the cleanup is done in
> vmbus_bus_init().  This is a layering violation.
> 
> Later on, we changed hv_synic_alloc() in 37cdd991fac8 ("vmbus: put
> related per-cpu variable together") and we started allocating:
> 
> 	hv_cpu->clk_evt = kzalloc(...
> 
> but we forgot to update the error handling because it was in the wrong
> place.  It's a very predictable, avoidable bug if we just use proper
> error handling style.

We'll fix this is a separate patch.  There are a couple other minor things
that should be cleaned up in hv.c as well, and can do them together.

Michael

> 
> Anyway...  Sorry for the long rant.  Summary:  Always distrust vague
> label names.
> 
> regards,
> dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
