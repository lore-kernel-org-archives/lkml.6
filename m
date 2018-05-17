Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbeEQPGf convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:06:35 -0400
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:15135 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752309AbeEQPGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:06:32 -0400
From: "Ramsay, Frank" <frank.ramsay@hpe.com>
To: Baoquan He <bhe@redhat.com>, "Travis, Mike" <mike.travis@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>
CC: Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "thgarnie@google.com" <thgarnie@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>
Subject: RE: [PATCH v2 RESEND 2/2] x86/mm/KASLR: Do not adapt the size of the
 direct mapping section for SGI UV system
Thread-Topic: [PATCH v2 RESEND 2/2] x86/mm/KASLR: Do not adapt the size of the
 direct mapping section for SGI UV system
Thread-Index: AQHTJ6zuezKG6sd0lUGgql2omKFhbaLKDx6AgAAJ0ACAAAiHgIAAVmGAgWpUIwCAAMRrMA==
Date: Thu, 17 May 2018 15:06:27 +0000
Message-ID: <AT5PR8401MB0370A3560532C224307B4B9383910@AT5PR8401MB0370.NAMPRD84.PROD.OUTLOOK.COM>
References: <1504770150-25456-1-git-send-email-bhe@redhat.com>
 <1504770150-25456-3-git-send-email-bhe@redhat.com>
 <20170928075605.g74zm5xeglosmvct@gmail.com> <20170928083112.GN16025@x1>
 <20170928090143.m6sog2am2ccz5dm4@gmail.com>
 <25fc5345-3273-447e-de6a-2ac7c56d0f00@hpe.com>
 <20180517031802.GK24627@MiWiFi-R3L-srv>
In-Reply-To: <20180517031802.GK24627@MiWiFi-R3L-srv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=frank.ramsay@hpe.com;
x-originating-ip: [66.187.232.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0610;7:8mz1iatmsnYw/3DMl2LA3XW9CAmOwv1ju155GKysRxDmOrRVSlojH5aT+UL2fzzJ2IzatZEcpNeXZDvrhUBFzLKNu5G7PK1VV8OfWEYEzbzAQgMWguIt0XAjHqM9ZTy9hdTNWuXFqLQrNpun5Q7dh8di73NoP4r2WetEwPvYEKJPPdfMKNUzY5PcC8m2NuBWCy6A5FUDHnTT9HueZxgq1Znu+Feg1CkXswb/iNxclES91peU5ct/HGIZvQDXpGUN
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39860400002)(39380400002)(13464003)(199004)(189003)(6636002)(55016002)(3846002)(97736004)(74316002)(3660700001)(7736002)(68736007)(6506007)(2906002)(7416002)(3280700002)(486006)(478600001)(33656002)(5660300001)(6116002)(476003)(8676002)(305945005)(81156014)(11346002)(8936002)(81166006)(25786009)(229853002)(446003)(14454004)(59450400001)(316002)(53546011)(86362001)(54906003)(110136005)(93886005)(4326008)(2900100001)(6246003)(9686003)(7696005)(186003)(6436002)(26005)(99286004)(53936002)(106356001)(66066001)(76176011)(5250100002)(102836004)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0610;H:AT5PR8401MB0370.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0610;
x-ms-traffictypediagnostic: AT5PR8401MB0610:
x-microsoft-antispam-prvs: <AT5PR8401MB06101E8E9537E60560C6D79D83910@AT5PR8401MB0610.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(9452136761055)(211936372134217)(222181515654134)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AT5PR8401MB0610;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0610;
x-forefront-prvs: 067553F396
x-microsoft-antispam-message-info: MULJi5P01gH7be4haLgU4L7KvYS7vo7WiEc2Q74CFLp7evFo8XxIqzLVoWZqhUlyuFhMEK25w020avkyukiGTDx4JFODoxgzC4r9GQYhsohEjb3TXPaynSATpSg987iRe4wMk3z7ZQqaFcSm3RVUlb68G06NnVizBPzgxXt9Wn3+ZU7RpTzoy10yVi29PeDr
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d6b624fc-9d6e-4230-bc37-08d5bc07c3ba
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b624fc-9d6e-4230-bc37-08d5bc07c3ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2018 15:06:27.5759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0610
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Baoquan He [mailto:bhe@redhat.com]
> Sent: Wednesday, May 16, 2018 11:18 PM
> To: Travis, Mike <mike.travis@hpe.com>; Anderson, Russ
> <russ.anderson@hpe.com>; Ramsay, Frank <frank.ramsay@hpe.com>
> Cc: Ingo Molnar <mingo@kernel.org>; linux-kernel@vger.kernel.org;
> x86@kernel.org; mingo@redhat.com; tglx@linutronix.de; hpa@zytor.com;
> thgarnie@google.com; keescook@chromium.org; akpm@linux-
> foundation.org; yamada.masahiro@socionext.com; Sivanich, Dimitri
> <dimitri.sivanich@hpe.com>; dyoung@redhat.com
> Subject: Re: [PATCH v2 RESEND 2/2] x86/mm/KASLR: Do not adapt the size of
> the direct mapping section for SGI UV system
> 
> Hi Mike, Russ and Frank,
> 
> On 09/28/17 at 07:10am, Mike Travis wrote:
> >
> >
> > On 9/28/2017 2:01 AM, Ingo Molnar wrote:
> > >
> > > * Baoquan He <bhe@redhat.com> wrote:
> > >
> > > > > > @@ -123,7 +124,7 @@ void __init
> kernel_randomize_memory(void)
> > > > > >
> 	CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
> > > > > >   	/* Adapt phyiscal memory region size based on available
> memory */
> > > > > > -	if (memory_tb < kaslr_regions[0].size_tb)
> > > > > > +	if (memory_tb < kaslr_regions[0].size_tb &&
> > > > > > +!is_early_uv_system())
> > > > > >   		kaslr_regions[0].size_tb = memory_tb;
> > > > > This is really an ugly hack. Is kaslr_regions[] incorrect? If so
> > > > > then it should be corrected instead of uglifying the code that uses it...
> > > >
> > > > Thanks for looking into this!
> > > >
> > > > If on SGI UV system, the kaslr_regions[0].size_tb, namely the size
> > > > of the direct mapping section, is incorrect.
> > > >
> > > > Its direct mapping size includes two parts:
> > > > #1 RAM size of system
> > > > #2 MMIOH region size which only SGI UV system has.
> > > >
> > > > However, the #2 can only be got till uv_system_init() is called in
> > > > native_smp_prepare_cpus(). That is too late for mm KASLR calculation.
> > > > That's why I made this hack.
> > > >
> > > > I checked uv_system_init() code, seems not easy to know the size
> > > > of MMIOH region before or inside kernel_randomize_memory(). I have
> > > > CCed UV devel experts, not sure if they have any idea about this.
> > > > Otherwise, this patch could be the only way I can think of.
> > > >
> > > > Hi Mike and Russ,
> > > >
> > > > Is there any chance we can get the size of MMIOH region before mm
> > > > KASLR code, namely before we call kernel_randomize_memory()?
> >
> > The sizes of the MMIOL and MMIOH areas are tied into the HUB design
> > and how it is communicated to BIOS and the kernel.  This is via some
> > of the config MMR's found in the HUB and it would be impossible to
> > provide any access to these registers as they change with each new UV
> architecture.
> >
> > The kernel does reserve the memory in the EFI memmap.  I can send you
> > a console log of the full startup that includes the MMIOH
> > reservations. Note that it is dependent on what I/O devices are
> > actually present as UV does not map empty slots unless forced (because
> > we'd quickly run out of resources.) Also, the EFI memmap entries do
> > not specify the exact usage of the contained areas.
> 
> This one is still a regression bug in our newer rhel since I just fixed them with
> rhel-only patch. Now I still need the console log which includes the MMIOH
> reservations.
> 

Does the system need to have an external IO device for this?  If not you should just be able to boot one of the SGI UV systems in the beaker lab (possibly also the HPE Superdome Flex that is in beaker; hpe-flex-01.rhts.eng.bos.redhat.com)

> Could you help provide a console log with MMIOH info, or I need request
> one from redhat's lab?
> 
> Or expert from HPE UV team can make a patch based on the finding and
> analysis?
> 
> Thanks
> Baoquan
> >
> > >
> > > I don't mind system specific quirks to hardware enumeration details,
> > > as long as they don't pollute generic code with such special hacks.
> > >
> > > I.e. in this case it's wrong to allow kaslr_regions[0].size_tb to be
> > > wrong. Any other code that relies on it in the future will be wrong as well
> on UV systems.
> >
> > Which may come into play on other arches with the new upcoming
> memory
> > technologies.
> > >
> > > The right quirk would be to fix that up where it gets introduced, or
> > > something like that.
> >
> > Yes, does make sense.
> > >
> > > Thanks,
> > >
> > > 	Ingo
> > >
