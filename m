Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2051782-1521439657-5-17186736021124756073
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521439656; b=X1jYqsUpff0dW5E7rcVPX8AywAD0mxous7RU8g+WG+iZBF2
    Wu89zhq1O6zYCi+cM8ri99/LUuyzkQjMWbnMs2EiG3QlC+EY1X6CEkm2H0Q5qImb
    oX1cWx5xTp3tPxk2LADqlCCTMUuH6ieXfc4ULX3BNjxvNQEHGvj3MqMKsaZStMMu
    rSx7mP7ir+GA6vcxa47ETHioKDXP6kVo8zYg3xm+MiIbzPSePY8WmZflwBB/s4gU
    yoXbMXKt35YJWRcuI1ujGQ+XKqXNiZP+4jy85g4hqjs++quVSoooZIBT7ZpMzM6E
    Sp43niUpqI/aQZscLC83NKdPnHEpsysBOz6y3cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521439656; bh=L
    NBA5QuCexaNPcNoSNwwcIs8peccMAiZbJ6aF6BvwYg=; b=Rma78B6pwdI7HUjgr
    fqJBt1wIls/yAgbTKTnqRwsSKAalkwQYIXOxUiO0KNqVBS224c6h95sdzGICff2c
    6F4rJLhnb9FEdlfgNkn2rB8I/W7JeeV2lGCsnAMk3mpuuRzi09MRxqWdtWfeakYU
    zZE/0YrxNXSdtNXrIhrfYWWe6u4NEEZ/ToClEbhIRuRukVR4j1OtW8SjW408Mn+f
    h4ePfBjobNCM3QVQndEsfSCDOEvKs1GeRSIoC3kQcDM2nQi5xO7YyOrGjvjG99cZ
    YEJYDBxJWVCBbUAag+AVEUV5xeTTAtG8OnbcRqz5eK3pZkEVlEfs6B5/O2mEuPTO
    HCEsg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=F71FKFt3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihggphejjfegudeftdgtgfgvshesthejtddttddtvdenucfhrhhomhepmfgjucfurhhinhhivhgrshgrnhcuoehkhihssehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinheplhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgnecukfhppedugedtrddvuddurdduieeirddufeeipddviedtudemiedttdemrgdvkedtmegshedtmeekuddtudemfheflegsmeehuddtfhemvddvvdgrpdhfvgektdemmegttdelieemfhgvlegumeduudgrgeemfhelrgdtnecurfgrrhgrmhepihhnvghtpedugedtrddvuddurdduieeirddufeeipdhhvghlohepshhilhhvvghrrdhoshhuohhslhdrohhrghdpmhgrihhlfhhrohhmpeeoughrihhvvghruggvvhdquggvvhgvlhdqsghouhhntggvsheslhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgqecuuffkkgfgpeduuddtleejuceuqfffjgepjeeukffvnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=F71FKFt3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihggphejjfegudeftdgtgfgvshesthejtddttddtvdenucfhrhhomhepmfgjucfurhhinhhivhgrshgrnhcuoehkhihssehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinheplhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgnecukfhppedugedtrddvuddurdduieeirddufeeipddviedtudemiedttdemrgdvkedtmegshedtmeekuddtudemfheflegsmeehuddtfhemvddvvdgrpdhfvgektdemmegttdelieemfhgvlegumeduudgrgeemfhelrgdtnecurfgrrhgrmhepihhnvghtpedugedtrddvuddurdduieeirddufeeipdhhvghlohepshhilhhvvghrrdhoshhuohhslhdrohhrghdpmhgrihhlfhhrohhmpeeoughrihhvvghruggvvhdquggvvhgvlhdqsghouhhntggvsheslhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgqecuuffkkgfgpeduuddtleejuceuqfffjgepjeeukffvnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: KY Srinivasan <kys@microsoft.com>
To: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>, Arvind Yadav
 <arvind.yadav.cs@gmail.com>, Stephen Hemminger <sthemmin@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH] vmbus: use put_device() if device_register fail
Thread-Topic: [PATCH] vmbus: use put_device() if device_register fail
Thread-Index: AQHTvoUaSaPHx26coEaurL53qMiDJaPW37dwgAALLICAACFeAA==
Date: Mon, 19 Mar 2018 05:52:16 +0000
Message-ID: <DM5PR2101MB0888249051F5FE11B0AE089AA0D40@DM5PR2101MB0888.namprd21.prod.outlook.com>
References: <bd6526dedf570a226ee024907be9a8f2bb04803f.1521355469.git.arvind.yadav.cs@gmail.com>
 <SN6PR2101MB0893ED30DA3AAFD4B3E2064EA0D40@SN6PR2101MB0893.namprd21.prod.outlook.com>
 <DM5PR2101MB103094D4CE169185B16EE0E9DCD40@DM5PR2101MB1030.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR2101MB103094D4CE169185B16EE0E9DCD40@DM5PR2101MB1030.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:8101:f39b:510f:222a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB0981;
 7:TMt3SYII1B7W+SrYuTWtDiWfGBLqmjt68GUFgjt8Ao+rh74otKbfQWoee11aQpbO5soN8Jy/V5XPCQWFWzFJBuq9JNuEZzaEDohEBlrapXTC8lc3iCJHbzXV0il6LX5mVkApguQ/YJuSJ/Cs+GqioSQ1wcmsX4sdQGA6FFfI8EmIPyqXbJyEnFr//uZxlrc0j3FPLYnz+PvKiylJby6aGcAi+v3TuwemFK/iAioZG1NmVL1SXDYz/YjMc9cQsRuo;
 20:kRklj/oqYMwzMgO6mNpOuUSKNPD2wsVunq7qMbampt3OSBtRvMkoExUnwWXdGWi5hLq6MCEuBGbFcdK4W86rZJfg8yE0V3AWaTvHryEZ7ykdAr7cUPSgEQXvfMMDvKUC67J++vzal8utNvWJB7eqzeNOBAmoUE+zNgvIWJlMarI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dca5a4ed-5331-473c-ff12-08d58d5d9302
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);
 SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0981F7A0FDDB34637E78D806A0D40@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);
 SRVR:DM5PR2101MB0981; BCL:0; PCL:0; RULEID:; SRVR:DM5PR2101MB0981;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39380400002)(366004)(376002)(346002)(39860400002)(396003)(13464003)(199004)(189003)(229853002)(1511001)(110136005)(68736007)(5660300001)(54906003)(6246003)(3280700002)(9686003)(74316002)(55016002)(102836004)(33656002)(6436002)(10290500003)(53936002)(59450400001)(14454004)(6636002)(2950100002)(6506007)(8990500004)(316002)(478600001)(106356001)(10090500001)(53546011)(105586002)(7736002)(22452003)(99286004)(3660700001)(4326008)(86362001)(76176011)(86612001)(305945005)(97736004)(5250100002)(7696005)(39060400002)(6116002)(8936002)(46003)(8676002)(2906002)(2900100001)(81156014)(25786009)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB0981;
 H:DM5PR2101MB0888.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1;
x-microsoft-antispam-message-info: Hmzd10Laz99JGOYfq8m48YgyKgpp5u1NXycTnA4OcU3CpEA5UVKcJbqzFSZpIV4psJB/e1uacGXArCF47aF/TkBRHsm00qnAJOe0WzZ31Q9ih7oRra70SrFFnJHFV1IlebEy1DoN0aItnXM/ee2bfwp+l0pRGznCMGC17+4Cp9A25THdQ1OXUGhbAG5+gke4Qj5IN4YHwxhMkTYNeyYOBEH7MMf679eVrzT+PvFrfrx7PBnQhS225IoQhu7h4p6kEBH4A1I/pngZ8l9i7ITyY2ByhzIbwvrcZMkkmV7yxTGcqJznhHM6m4dngI+LOl91gfC46UNWAbaRpqOQEAN8GA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca5a4ed-5331-473c-ff12-08d58d5d9302
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 05:52:17.8793 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
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
> From: Michael Kelley (EOSG)
> Sent: Sunday, March 18, 2018 8:40 PM
> To: KY Srinivasan <kys@microsoft.com>; Arvind Yadav
> <arvind.yadav.cs@gmail.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>
> Cc: devel@linuxdriverproject.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH] vmbus: use put_device() if device_register fail
> 
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> owner@vger.kernel.org> On Behalf
> > Of KY Srinivasan
> > Sent: Sunday, March 18, 2018 8:02 PM
> > To: Arvind Yadav <arvind.yadav.cs@gmail.com>; Stephen Hemminger
> > <sthemmin@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>
> > Cc: devel@linuxdriverproject.org; linux-kernel@vger.kernel.org
> > Subject: RE: [PATCH] vmbus: use put_device() if device_register fail
> >
> > > -----Original Message-----
> > > From: devel <driverdev-devel-bounces@linuxdriverproject.org> On
> Behalf
> > > Of Arvind Yadav
> > > Sent: Saturday, March 17, 2018 11:48 PM
> > > To: Stephen Hemminger <sthemmin@microsoft.com>; Haiyang Zhang
> > > <haiyangz@microsoft.com>
> > > Cc: devel@linuxdriverproject.org; linux-kernel@vger.kernel.org
> > > Subject: [PATCH] vmbus: use put_device() if device_register fail
> > >
> > > if device_register() returned an error. Always use put_device()
> > > to give up the reference initialized.
> > >
> > > Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> > > ---
> > >  drivers/hv/vmbus_drv.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > > index bc65c4d..25da2f3 100644
> > > --- a/drivers/hv/vmbus_drv.c
> > > +++ b/drivers/hv/vmbus_drv.c
> > > @@ -1358,6 +1358,7 @@ int vmbus_device_register(struct hv_device
> > > *child_device_obj)
> > >  	ret = device_register(&child_device_obj->device);
> > >  	if (ret) {
> > >  		pr_err("Unable to register child device\n");
> > > +		put_device(&child_device_obj->device);
> >
> > If the registration failed; we would not have acquired the reference on the
> device and so
> > we should not be dropping the reference in the failure path.
> 
> Looking at the code for device_register() and its constituent parts
> device_initialize() and device_add(), Arvind is correct.  device_initialize()
> creates the object with a reference count of 1.  device_add() does not
> decrement that reference count or free the object, even if it fails.  The
> comments for device_register() call this out as well.

Yes; agreed. I will take this patch.

K. Y
> 
> Michael
> 
> >
> > K. Y
> > >  		return ret;
> > >  	}
> > >
> > > --
> > > 2.7.4
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
