Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754064AbeEOPOZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 11:14:25 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:16695 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752770AbeEOPOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 11:14:22 -0400
X-IronPort-AV: E=Sophos;i="5.49,403,1520870400";
   d="scan'208";a="78874178"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "deller@gmx.de" <deller@gmx.de>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        "hch@lst.de" <hch@lst.de>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "jejb@parisc-linux.org" <jejb@parisc-linux.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "chris@zankel.net" <chris@zankel.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>,
        "paulus@samba.org" <paulus@samba.org>
Subject: Re: [PATCH v9 1/2] arch/*: Add CONFIG_ARCH_HAVE_CMPXCHG64
Thread-Topic: [PATCH v9 1/2] arch/*: Add CONFIG_ARCH_HAVE_CMPXCHG64
Thread-Index: AQHT67Pm45cUNxHaKE2Ek+zKg1/0pqQwGIyAgADOzgA=
Date: Tue, 15 May 2018 15:14:14 +0000
Message-ID: <7b1813846c2ad915f5432394ccbf7966065b5e45.camel@wdc.com>
References: <20180514184634.2160-1-bart.vanassche@wdc.com>
         <20180514184634.2160-2-bart.vanassche@wdc.com>
         <87lgclpr1y.fsf@concordia.ellerman.id.au>
In-Reply-To: <87lgclpr1y.fsf@concordia.ellerman.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0465;7:IOwk8dhLg9Ef3WNwffBxz88Vw1hODuL96bGKXjjWj4HB3xe3x70+nRF32krTrj7yP97Uhg/44/VlOluPIjfR8B5lVVzTlWYovZphDV7hU0H0Zc15iGLCgkUX1iMxlJIYsHCgEbGl2JfcYs/apHDI2+dA581asrIYDAYJ1rThUVHFuZ9SpZGZKrzNFqEXOKu/mAX+VsZBhExTSl4Cf2Z0Fl4zajx7bnVLoNIuOm1dFDzKLjf3fnXm3cJlyvGPYaSf;20:s3Pl4Lx1gu8uRKkymhMU6Awf7tPUV8FhCwpnCIbBwDXslJ+M5RkaWMgZ6ppV52zEdX/2SdiTi3uzLzKsyeGhhlfRi0LB9xZMB9RSAWGYnUgEHKuA1U2MNTJqV1MZSZ6tqY8T8aFqwhmAiSnXHj616sG1/7RfZsehvX3QooVsJAw=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0465;
x-ms-traffictypediagnostic: MWHPR04MB0465:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0465FF92CD02431C5B954D4C98930@MWHPR04MB0465.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR04MB0465;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0465;
x-forefront-prvs: 0673F5BE31
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(39860400002)(39380400002)(377424004)(51444003)(189003)(199004)(106356001)(118296001)(72206003)(5250100002)(2501003)(26005)(97736004)(7736002)(478600001)(2900100001)(305945005)(36756003)(105586002)(8666007)(186003)(3846002)(4326008)(39060400002)(25786009)(6246003)(14454004)(53936002)(6116002)(66066001)(6512007)(486006)(8676002)(76176011)(3660700001)(3280700002)(229853002)(5660300001)(6486002)(86362001)(110136005)(99286004)(54906003)(6436002)(7416002)(15760500003)(316002)(81166006)(8936002)(81156014)(2906002)(102836004)(476003)(446003)(68736007)(6506007)(2616005)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0465;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: AOaUxCL/Px8Lktgj7JiIT0jmdTVZYQrQgdsfi97xwryYFzAsaK2jVucecoGvT2gyzU8OqE77TIWMJILoGhYNfpCtx9l2HPsHbqjXmRBTGCN69e/GkTC6wmeKBon3Rb5a5detqg72N+msD/LB//wB5bDMSDB6i//ztTb5FwLoxaj9mxpqIuaMNFAfxFgOudOV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6519733FEF410C4DB45C0ACABBFD181D@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: b7706ef8-2f54-4f88-9d13-08d5ba768564
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7706ef8-2f54-4f88-9d13-08d5ba768564
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2018 15:14:14.7164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0465
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4FFEVuv029258

On Tue, 2018-05-15 at 12:54 +1000, Michael Ellerman wrote:
> Bart Van Assche <bart.vanassche@wdc.com> writes:
> > 
> > +    -----------------------
> > +    |         arch |status|
> > +    -----------------------
> > +    |       alpha: |  ok  |
> > +    |         arc: | TODO |
> > +    |         arm: |!thumb|
> > +    |       arm64: |  ok  |
> > +    |         c6x: | TODO |
> > +    |       h8300: | TODO |
> > +    |     hexagon: | TODO |
> > +    |        ia64: |  ok  |
> > +    |        m68k: |  ok  |
> > +    |  microblaze: | TODO |
> > +    |        mips: |64-bit|
> > +    |       nios2: | TODO |
> > +    |    openrisc: | TODO |
> > +    |      parisc: |  ok  |
> > +    |     powerpc: |64-bit|
> 
> I think that is correct for powerpc, we don't have a 32-bit
> implementation and there's no fallback it seems.
> 
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -150,6 +150,7 @@ config PPC
> >  	select ARCH_HAS_UBSAN_SANITIZE_ALL
> >  	select ARCH_HAS_ZONE_DEVICE		if PPC_BOOK3S_64
> >  	select ARCH_HAVE_NMI_SAFE_CMPXCHG
> > +	select ARCH_HAVE_CMPXCHG64
> 
> So shouldn't this should be:
> 
> +	select ARCH_HAVE_CMPXCHG64		if PPC64
> 
> And it should be sorted alphabetically, ie. above the previous NMI entry.

Hello Michael,

Thanks, I will make these changes.

Bart.
