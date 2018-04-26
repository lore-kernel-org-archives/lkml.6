Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3336438-1524785145-2-10099241497211055354
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524785144; b=YqLEBsBY14p7i8EWbO4yNT9xI+leWaybRq70rPaKPMrRBpJzhm
    7sO2p0jV+l1w0dVBenSDa0c5sa22ZC3KrukzhDlBkWp2dewy1efY3bDmXfqrl+Nw
    q/Y095YqROA0GQ3XzpkrKZBbcqPbrGZ6LwwQsv+gboiY4HrKlFJoJF+CV+qJN+Jw
    yOOeZql4IDFZ8KtGiFipoM5UkW10HlprK08yHXX0XIukIreSAGPjuWdzXLHIx2KM
    YIWAKFmmQrdEo2hSPlrDV9e1YVc+wZlKJMDn7vw19PBzNC/yGzpRG4RjJSdycUb/
    8w5xr9igbTv9yg8AVHyUd931mFfI9pwAY2eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524785144; bh=R90Zl
    Iv1Ws2JXvF1nmmWbNGriSTh4PAItCUGTcoUxFg=; b=O1nzCwbJuIgpm04hYEola
    1aEZADZb1IVBnhEZ/NNideJkEupf5cUrop3hbepXw2PADvvzuyjmSaYjHAyl3rUH
    Jw30R63Kuzxv5+vDHDKwJ8HmyGpChYNzKaYaITd7VDvg9fuB2p75pfPWoZDsLo3c
    KfBSX9wo9IFrezPMeJuD0B5RxKZUVIoK168tdcLQgfoDRlZkcecqmm7qxjhsp7Tb
    syCX1cEwcUs2DupdPrjZCcIX3os5jPYBZxAB9HPbPBTYuNYBzGBT3YgLRj4sJdaI
    nJnya+deqSeN4reyzlj8GkThF3zmeoco24qLxUXE+fiXILgzJepqLbQ0dEs+ngPV
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cyzDuuzK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cyzDuuzK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPFmOc3TN39lcd3ea6TclVqVRDHSZT+ZG6Per/azBYlMf3/MDEviFP+HlhIzUAM4tfprkhIuZAXXZfXsxO0/j8KLyB/V9zXNWqBaUT+WJ6RWAWqNVGK8
    o3RMVph0ls3dueACF+uMNnWe9Ci9XBfjBKAgXahbZrSgk46BOXdY9XDthGF+gEL+jodcZTnfmATZbXT3RBROpDS9rVaOrPY6TzA/yFEQX8xPPWV0SprcnjSz
    lg0U92GyPys2829fKxzd+A==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=_TKFW_rNyuwA:10 a=ezrDjaGQ7gEA:10
    a=P6MAjPsMllQA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=j7VF56YW0-6AJxC12NoA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: KY Srinivasan <kys@microsoft.com>, "x86@kernel.org" <x86@kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>, Stephen Hemminger
 <sthemmin@microsoft.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH 3/5] X86: Hyper-V: Enhanced IPI enlightenment
Thread-Topic: [PATCH 3/5] X86: Hyper-V: Enhanced IPI enlightenment
Thread-Index: AQHT3MEtQv5LJ2NsXkuLuZNj3DX21KQTqanA
Date: Thu, 26 Apr 2018 23:25:33 +0000
Message-ID: <DM5PR2101MB10307C054DBD417CC471401EDC8E0@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180425181110.8683-1-kys@linuxonhyperv.com>
 <20180425181250.8740-1-kys@linuxonhyperv.com>
 <20180425181250.8740-3-kys@linuxonhyperv.com>
In-Reply-To: <20180425181250.8740-3-kys@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-04-26T23:25:32.5877443Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB0997;
 7:0YDp1RBe6WpT+XajlpzmXKzerLK8zdDjNVMvj7u213enzD9LlvRZ+V7ROUoPVh9Jpgt0H+OUai+LN/VOCVyjkOa0mCc2yPxEp9Co7JJyjOlCkkCc0JjAsxZQN1o2fJ9C1oIh5rOZsn3NqfAd1OUDSNcvYZbXHpECnKYxFdpwhAGoWgIzuL7Mf8Vum8GTTpzQhWlwduicZqUVZgyRoQkXzgzHltyXAFX9ITAAtQ8s5yeYpZgwvrcf9QXqkAp/gnPO;
 20:EtGI/Cu2GtY2QfoLqh9+GU/HoBI0EeWHwHkDD8w3+xtDz+PMIlbEJaECQp63Uj3VNxsi7AQc1cKE73YbOi+/KI3cCVVHdMbmFCZco3DN3xx67MYQ5KMse5N3GdTm3DC68N8zal9Ke/hSV2yRT0dYoISojcHyaIHVjnUKj4aO2vU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7193020);
 SRVR:DM5PR2101MB0997;
x-ms-traffictypediagnostic: DM5PR2101MB0997:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0997708017F1BF0041EEC5AFDC8E0@DM5PR2101MB0997.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231232)(944501410)(52105095)(3002001)(6055026)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);
 SRVR:DM5PR2101MB0997; BCL:0; PCL:0; RULEID:; SRVR:DM5PR2101MB0997;
x-forefront-prvs: 0654257CF5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(39380400002)(396003)(376002)(39860400002)(189003)(199004)(102836004)(478600001)(2906002)(74316002)(68736007)(7736002)(5660300001)(22452003)(86612001)(3660700001)(486006)(316002)(6506007)(3280700002)(476003)(2501003)(2900100001)(7696005)(6436002)(446003)(72206003)(76176011)(99286004)(7416002)(11346002)(14454004)(86362001)(81166006)(66066001)(8676002)(53936002)(55016002)(2201001)(229853002)(97736004)(9686003)(6116002)(3846002)(106356001)(26005)(105586002)(10290500003)(1511001)(110136005)(25786009)(5250100002)(33656002)(81156014)(305945005)(8936002)(8990500004)(6246003)(10090500001)(921003)(1121003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB0997;
 H:DM5PR2101MB1030.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
x-microsoft-antispam-message-info: gNQoyMHqdskPM/u1yhmw124tlTwsbxrvp/AjjLDUUl7v6jI6cbMf1+zdp/5LOqa6SLFUz/WnruGQPobWZTMghi4Vsn9kglOewmUExs8sMvxEDK3yodM8RvXijf8Ok0UMxp36l7s2xTcWQ+IrBfXFmnr7d0jQmBNcOLwRyJ4yLA+YHS1dmTvYyIX6FmhqGg0J
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f8962a66-72cd-4915-b670-08d5abcd0287
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8962a66-72cd-4915-b670-08d5abcd0287
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2018 23:25:34.0168 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0997
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

On Wed, 25 Apr 2018, KY Srinivasan <kys@microsoft.com> wrote:
> 
> +struct ipi_arg_ex {
> +	u32 vector;
> +	u32  reserved;
> +	struct hv_vpset vp_set;
> +};

Again, suggest moving to hyperv-tlfs.h.  And the 5.0b version
of the TLFS has:

	u32		vector;
	u8		targetvtl;
	u8		reserved[3];
	struct hv_vpset	vp_set;

....
 
> 
> +struct hv_vpset {
> +	u64 format;
> +	u64 valid_bank_mask;
> +	u64 bank_contents[];
> +};

And this as well.

Michael
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
