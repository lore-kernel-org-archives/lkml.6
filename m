Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752194AbeENUmV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:42:21 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:17531 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbeENUmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:42:19 -0400
X-IronPort-AV: E=Sophos;i="5.49,401,1520870400";
   d="scan'208";a="78805179"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>
CC: "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "deller@gmx.de" <deller@gmx.de>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        "hch@lst.de" <hch@lst.de>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hpa@zytor.com" <hpa@zytor.com>,
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
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "paulus@samba.org" <paulus@samba.org>
Subject: Re: [PATCH v9 1/2] arch/*: Add CONFIG_ARCH_HAVE_CMPXCHG64
Thread-Topic: [PATCH v9 1/2] arch/*: Add CONFIG_ARCH_HAVE_CMPXCHG64
Thread-Index: AQHT67Pm45cUNxHaKE2Ek+zKg1/0pqQvkWgAgAAfQIA=
Date: Mon, 14 May 2018 20:42:13 +0000
Message-ID: <cb51c6f8eb93452d405180d9da0f1e203b469d2a.camel@wdc.com>
References: <20180514184634.2160-1-bart.vanassche@wdc.com>
         <20180514184634.2160-2-bart.vanassche@wdc.com>
         <CAMo8Bf+Wgm2VrZiY+CfjN=CM=ysYBpRyTMdozV+6A8Brk4DKDQ@mail.gmail.com>
In-Reply-To: <CAMo8Bf+Wgm2VrZiY+CfjN=CM=ysYBpRyTMdozV+6A8Brk4DKDQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0609;7:SxZ1aJ9ow5mCLQcNEr4NDeV8x+O5RVwGGGzpH3V0jBljzjCtNGuy47U9bxsOAmsKOo9LjY9RvthH/tJdIBoBj3w+iUcvo4VM8iKghmFhPfJLLPlx2lzdMBBRvKmAOu9C6cqWtwLL5dXDy7vOHqHqV0lSCFkgRRwp2/huP+Z198UernHA48W0rGHdE9HzwGJm1l5GUj9hzIpymFTro0a8IhdS9s7fFiDimat+wFkyRDclltYG56MsLHCGRZq5UWR/;20:s1anCVY5POUy798ThrZvBz5IiQvrrHN8ApD7VV9/gCvdCFvRe+3izP6ph/+J/5qPmvDTEMVDnTsxuKdjxU4MT07EAaxkw0jIIk8zQSsnCwcpnHcfVHLtbIsWhodNimjnKtYJzjkIZ1S6XE+TmfoFwzxAzhGlWrpxOqgoQed5BJY=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0609;
x-ms-traffictypediagnostic: MWHPR04MB0609:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB06094E31A48FCA3EB3D96A52989C0@MWHPR04MB0609.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR04MB0609;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0609;
x-forefront-prvs: 067270ECAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(51914003)(189003)(199004)(377424004)(53546011)(15760500003)(1411001)(186003)(102836004)(6246003)(3660700001)(2906002)(3280700002)(54906003)(36756003)(106356001)(53936002)(72206003)(105586002)(6486002)(99286004)(26005)(14454004)(6506007)(97736004)(76176011)(2351001)(6116002)(3846002)(66066001)(8936002)(59450400001)(7416002)(1730700003)(81156014)(4326008)(8676002)(39060400002)(476003)(6436002)(81166006)(2616005)(1361003)(486006)(6512007)(118296001)(8666007)(6916009)(446003)(86362001)(25786009)(2900100001)(229853002)(5250100002)(5660300001)(7736002)(305945005)(478600001)(316002)(68736007)(5640700003)(2501003)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0609;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: cswIvnYXLZ72q/O7yc3aROMfoaM4/7WQBuC9tqzh1L/bMiycGhyNur5So4+XXmvrZm4BUBAtPYrvRBzS8HlQZiR/+rnee+8zJVIDgOiqFVzQXgW5D/dxii175I2wjcSE0bTH1Eqg3hHI3G9VwKjev0WbGltHgtqh8CJtKLUwc6K2lfmfGRXKKL6m4tiMfJ2i
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <09431A7734D57741BE36648C73F325FB@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 35349136-0add-41de-fabd-08d5b9db2cad
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35349136-0add-41de-fabd-08d5b9db2cad
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2018 20:42:13.9806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0609
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4EKgV3Y003273

On Mon, 2018-05-14 at 11:50 -0700, Max Filippov wrote:
> On Mon, May 14, 2018 at 11:46 AM, Bart Van Assche
> <bart.vanassche@wdc.com> wrote:
> > The next patch in this series introduces a call to cmpxchg64()
> > in the block layer core for those architectures on which this
> > functionality is available. Make it possible to test whether
> > cmpxchg64() is available by introducing CONFIG_ARCH_HAVE_CMPXCHG64.
> > 
> > ---
> 
> [...]
> 
> > diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> > index c921e8bccdc8..8234278a821d 100644
> > --- a/arch/xtensa/Kconfig
> > +++ b/arch/xtensa/Kconfig
> > @@ -23,6 +23,7 @@ config XTENSA
> >         select HAVE_DMA_CONTIGUOUS
> >         select HAVE_EXIT_THREAD
> >         select HAVE_FUNCTION_TRACER
> > +       select ARCH_HAVE_CMPXCHG64
> 
> This breaks alphabetical sorting of Kconfig entries.

Hello Max,

Thanks for the feedback. Do you perhaps know whether keeping names in
alphabetical order is a requirement for arch/xtensa/Kconfig only or
whether this is required for all arch/*/Kconfig files?

Bart.
