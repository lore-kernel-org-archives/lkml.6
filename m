Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1738054-1521430814-2-8761265582118260448
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521430814; b=Bc9s7a2zggL/EU5nJHDqHxHF1zVNjGSSgBnVW2xuo/TUt/K
    ZX+HM324UV4V0D25RWcmD+h8W/bYqBxikepz1EvFT/eFKObYsCKfRJiP68I8Cl2T
    Kwimr1bzidoinBTJSkxwuYhF/IxB13erxA82CLDGoQcRuMHDgTG1npFe5u+WSxdY
    +vOfVlyr2Fc9T3z6YCRQxxPbT1kcz0bunWHOSQ2WHniZ5FEVfXwVzS4+EPiuptWZ
    Tj3VEHU4gk8ZNHLUsevSeRGnvhfQQImrKN13PWOP7A8x0SPmO8icEDf1dq6Cl2T8
    jHiiRjfNu0t8+hbPNI9O09LoWquMhyye2fwv8jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521430814; bh=Y
    Z0GSsKJ3VjSqkjXVnv3SATq8vbXqrNgCU0a4W+tLXY=; b=KXupAlxl7BOnrWiNP
    BV0/MElSR+ackPHgrSdvoeX1Yl20PtHoBVvQwxeKfB6+XKNRQkxarv0Cxa9rs9NH
    iOFDHBEHWPOH4Pm7lg98jTo0Hq4YUj5MK4EJBt0IdCiNlZ7QIBvm4wfbLcy1KrBu
    1PcT4MjyUlysspgXo5xGH0Zg/3h28uvo2uzoo9H6tQheuD5K6tucS7SX/eENXx50
    IG+HqyDL1jUDSgP6yPfCV0v5YS1WBGu+e5GtUJYKcjcLYoP7givXLDOhBa3s/dWV
    QSu2M0u5UsuBpM1FYRZAydvqi4ZjkW5F99s5Z5ua8juLNwhYrP0Bb4b1h1I0qJ2T
    7UcXw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=apFqXpy1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=apFqXpy1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: KY Srinivasan <kys@microsoft.com>, Arvind Yadav
 <arvind.yadav.cs@gmail.com>, Stephen Hemminger <sthemmin@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH] vmbus: use put_device() if device_register fail
Thread-Topic: [PATCH] vmbus: use put_device() if device_register fail
Thread-Index: AQHTvoUgz7NIDmL0UEiY7KwnBfP37qPW4B+AgAAI0fA=
Date: Mon, 19 Mar 2018 03:40:03 +0000
Message-ID: <DM5PR2101MB103094D4CE169185B16EE0E9DCD40@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <bd6526dedf570a226ee024907be9a8f2bb04803f.1521355469.git.arvind.yadav.cs@gmail.com>
 <SN6PR2101MB0893ED30DA3AAFD4B3E2064EA0D40@SN6PR2101MB0893.namprd21.prod.outlook.com>
In-Reply-To: <SN6PR2101MB0893ED30DA3AAFD4B3E2064EA0D40@SN6PR2101MB0893.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-19T03:40:02.0159852Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB0887;
 7:i7fn2qYf14zYcy1J3qmUpPCzJzoqAqUaMHSqXqepO1PPtdHfVW4XV0qFUxqW2UjamYViFraaHx5FSn5nAT1vgQ8wtd9KW/w2WU46VOx+9Mrp7Fq+/AprqLRgiQ5xaIwKGCaVNclEp6lQPPPIGrLQO5u99r0rLDdvpPSeNRNPOGSMIKcYjPSrW8SZa5Xj+ZvdG4tuq0479hJsUuQVXr4VfEIYsa9hbnUwcd84lMJfqAId7NmtQ9EXLx2oJ4VWA6Hd;
 20:qmzLy0QR5FLxFF0mUtKfMb7qEc4wXzmwn/izTRvGM+adm2qy36vmnjqloxAKVxa7HU4TwrJDjgKaSQSsYPkb/O0R39RgRL0pxvI/wjWnY3/QTrLqnNMP6p+1EQzVDijot+QsKENtu13ji9K95z4/gkuVHInsQ34IC8O2c8HYtTQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 570b79f8-fff6-48fc-cacc-08d58d4b19ea
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);
 SRVR:DM5PR2101MB0887;
x-ms-traffictypediagnostic: DM5PR2101MB0887:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08877E98FA672D052AFA0291DCD40@DM5PR2101MB0887.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);
 SRVR:DM5PR2101MB0887; BCL:0; PCL:0; RULEID:; SRVR:DM5PR2101MB0887;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(39860400002)(376002)(39380400002)(346002)(13464003)(189003)(199004)(10290500003)(26005)(7696005)(74316002)(68736007)(110136005)(478600001)(72206003)(6636002)(6246003)(99286004)(229853002)(10090500001)(305945005)(7736002)(2950100002)(33656002)(76176011)(97736004)(86612001)(6436002)(54906003)(4326008)(39060400002)(25786009)(3660700001)(53936002)(2906002)(5250100002)(81156014)(81166006)(8676002)(8936002)(86362001)(2900100001)(8990500004)(5660300001)(3846002)(6116002)(3280700002)(55016002)(9686003)(66066001)(316002)(59450400001)(53546011)(6506007)(1511001)(106356001)(22452003)(105586002)(14454004)(102836004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB0887;
 H:DM5PR2101MB1030.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
x-microsoft-antispam-message-info: Tgk5kDPPIZzuUxaMiqrufQU71nOWxdhTGCY/w39rIi4IKMcbN0MOxU1w5pNlXi1vpgVtCzomZCvBfOJRFFN4ruhmUhqlB7QSZhg/IS4CRV8t2uL+MqYm/IojyMvCSJRzyQ8RkkojMR4TKQcDQFueO5zCDWxuab8D37kiN/nM7Rsf4VcAJ0v51fFbAmkFxuMfnsfvruTvcejl87gXQk7CUG0qvenZPxQipyaJuASkbOvXeQ87do662vyPPVFmWw2PhjUQ6sOSaduE2DcneVWTDmaBFVnsEdH1+Z6aqJTP6HWZ5Jlqp5qr79/xYIQ249bmb/jCzVgAzIS7oRJE3eztuA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570b79f8-fff6-48fc-cacc-08d58d4b19ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 03:40:03.8713 (UTC)
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
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.org> On Behalf
> Of KY Srinivasan
> Sent: Sunday, March 18, 2018 8:02 PM
> To: Arvind Yadav <arvind.yadav.cs@gmail.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>
> Cc: devel@linuxdriverproject.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH] vmbus: use put_device() if device_register fail
> 
> > -----Original Message-----
> > From: devel <driverdev-devel-bounces@linuxdriverproject.org> On Behalf
> > Of Arvind Yadav
> > Sent: Saturday, March 17, 2018 11:48 PM
> > To: Stephen Hemminger <sthemmin@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>
> > Cc: devel@linuxdriverproject.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH] vmbus: use put_device() if device_register fail
> >
> > if device_register() returned an error. Always use put_device()
> > to give up the reference initialized.
> >
> > Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> > ---
> >  drivers/hv/vmbus_drv.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index bc65c4d..25da2f3 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -1358,6 +1358,7 @@ int vmbus_device_register(struct hv_device
> > *child_device_obj)
> >  	ret = device_register(&child_device_obj->device);
> >  	if (ret) {
> >  		pr_err("Unable to register child device\n");
> > +		put_device(&child_device_obj->device);
> 
> If the registration failed; we would not have acquired the reference on the device and so
> we should not be dropping the reference in the failure path.

Looking at the code for device_register() and its constituent parts
device_initialize() and device_add(), Arvind is correct.  device_initialize()
creates the object with a reference count of 1.  device_add() does not
decrement that reference count or free the object, even if it fails.  The
comments for device_register() call this out as well.

Michael  

> 
> K. Y
> >  		return ret;
> >  	}
> >
> > --
> > 2.7.4
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
