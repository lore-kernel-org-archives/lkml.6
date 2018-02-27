Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751930AbeB0UCv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 15:02:51 -0500
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:25017 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeB0UCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 15:02:50 -0500
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "will.deacon@arm.com" <will.deacon@arm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "Hocko, Michal" <mhocko@suse.com>,
        "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>
Subject: =?utf-8?B?UmU6IOetlOWkjTogW1JGQyBwYXRjaF0gaW9yZW1hcDogZG9uJ3Qgc2V0IHVw?=
 =?utf-8?Q?_huge_I/O_mappings_when_p4d/pud/pmd_is_zero?=
Thread-Topic: =?utf-8?B?562U5aSNOiBbUkZDIHBhdGNoXSBpb3JlbWFwOiBkb24ndCBzZXQgdXAgaHVn?=
 =?utf-8?Q?e_I/O_mappings_when_p4d/pud/pmd_is_zero?=
Thread-Index: AQHTf8/DU6Bn0QH47UWdTrAB037o0qOtWaOAgAEK4wCAAGk/AIAASQkAgAfKtwCAAAH3AIAAHm+AgAITRAD///YZgIAADY2A
Date: Tue, 27 Feb 2018 20:02:45 +0000
Message-ID: <1519764469.2693.4.camel@hpe.com>
References: <1514460261-65222-1-git-send-email-guohanjun@huawei.com>
         <861128ce-966f-7006-45ba-6a7298918686@codeaurora.org>
         <1519175992.16384.121.camel@hpe.com>
         <etPan.5a8d2180.1dbfd272.49b8@localhost> <20180221115758.GA7614@arm.com>
         <32c9b1c3-086b-ba54-f9e9-aefa50066730@huawei.com>
         <20180226110422.GD8736@arm.com>
         <a80e540f-f3bd-53da-185d-7fffe801f10c@huawei.com>
         <1519763686.2693.2.camel@hpe.com> <20180227195919.GA5348@arm.com>
In-Reply-To: <20180227195919.GA5348@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.211.195.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB1059;6:tXdUef78cfJ0gd/xOyzvMJ+70xhR8FTappKjze1MoWPOK7OLkTG5TCl5/BbPIjYZuJsk6/iK+Yz1lHLVi77bJFk8kvwDUEchjDgXDosWq9czyUOix3aeUdyfESwcZnpJ3zJRF5g5TVA+N91kvIdQFlO44rW1EKN+XrXSORJ8wWPsyidjSMmnSGZYwzyuDkkfCzhLpfY2MhA1Xn29czg8dYFMfvDzpcVIq0+fqacHJ7telQwZTKtJRr9GbfIjrFUMb++ZK2Pu4FLJGDmaRfkaxUaCeOA8YrAEg3QykvpmTlFwn+Tf2qyKhdTNY7IAfs+Nmxk0UXXED/S3otxT5L3ty9xHE0y5NH5BImtcJf9AaFs=;5:KAbmqL9yFOQWFb0Kek6jXYcJd/LspAXNsapv0pzPRqieXjAcRyCQyiLsFIc73f5sP/dYpa9+8i+E2KDLgEM+ogseijKIQYxGDFv8ocdALKvXH9o3fbmaX0LlbrIfcsCtIMIwiGofFZhvXUy5ryM2P/dJoEEjJo2zmlZxYZlKSW4=;24:rdRtRmYpuapru9+v4yTOvx5GRitxV/Vkflf5WU4HBXdF/0G5LwKnzG30PnSHa5cp+wBDJQRdw8UhFIyBjNV6y7v2wswtblN5Xf75PZaCij0=;7:rP6gUn5NQC6+jOc1d49UAGPw24V/tTiYBCc1b7dV3qeBx1Yb8t4JH+AWxuM1/OhnkIpEtIx8stVHA/teHUE1mEL31v2rryvb8mvGQM9Y0f/WY3hu141xL8t4QLJSdesomH92hvoaFCoIXxMCKQ2PDogsJ2cIFucnFVLowqtaYyMunacuRDmLoZzXEjHPVAOksCJKcgvu2RMEQBU/gToom3vUoYbpmGRO39PXmxnR5wA/S4ScsQfN/FujwZQXS8gw
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c147efd1-04dd-4ac8-c09e-08d57e1d1192
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:AT5PR8401MB1059;
x-ms-traffictypediagnostic: AT5PR8401MB1059:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-exchange-antispam-report-cfa: BCL:0;PCL:0;RULEID:(3231001);SRVR:AT5PR8401MB1059;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB1059;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(377424004)(199004)(52314003)(189003)(14454004)(5640700003)(966005)(2501003)(5250100002)(6436002)(6116002)(3846002)(224303003)(3280700002)(6246003)(6486002)(6512007)(6306002)(66066001)(2900100001)(105586002)(103116003)(36756003)(86362001)(575784001)(25786009)(4326008)(2351001)(106356001)(6916009)(2950100002)(97736004)(7416002)(54906003)(8936002)(186003)(81156014)(7736002)(305945005)(68736007)(26005)(93886005)(229853002)(99286004)(102836004)(6506007)(3660700001)(76176011)(5660300001)(53546011)(14583001);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1059;H:AT5PR8401MB1297.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7BCEFCFBAAFC745ADBC6D3239EFFEBE@NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c147efd1-04dd-4ac8-c09e-08d57e1d1192
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 20:02:45.5993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1059
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1RK2xFO032239

On Tue, 2018-02-27 at 19:59 +0000, Will Deacon wrote:
> On Tue, Feb 27, 2018 at 07:49:42PM +0000, Kani, Toshi wrote:
> > On Mon, 2018-02-26 at 20:53 +0800, Hanjun Guo wrote:
> > > On 2018/2/26 19:04, Will Deacon wrote:
> > > > On Mon, Feb 26, 2018 at 06:57:20PM +0800, Hanjun Guo wrote:
> > > > > Simply do something below at now (before the broken code is fixed)?
> > > > > 
> > > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > > index b2b95f7..a86148c 100644
> > > > > --- a/arch/arm64/Kconfig
> > > > > +++ b/arch/arm64/Kconfig
> > > > > @@ -84,7 +84,6 @@ config ARM64
> > > > >         select HAVE_ALIGNED_STRUCT_PAGE if SLUB
> > > > >         select HAVE_ARCH_AUDITSYSCALL
> > > > >         select HAVE_ARCH_BITREVERSE
> > > > > -   select HAVE_ARCH_HUGE_VMAP
> > > > >         select HAVE_ARCH_JUMP_LABEL
> > > > >         select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
> > > > >         select HAVE_ARCH_KGDB
> > > > 
> > > > No, that actually breaks with the use of block mappings for the kernel
> > > > text. Anyway, see:
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=15122ee2c515a253b0c66a3e618bc7ebe35105eb
> > > 
> > > Sorry, just back from holidays and didn't catch up with all the emails,
> > > thanks for taking care of this.
> > 
> > I will work on a fix for the common/x86 code.
> 
> Ace, thanks. I'm more than happy to review any changes you make to the core
> code from a break-before-make perspective. Just stick me on cc.

Thanks Will!  I will definitely keep you cc'd.
-Toshi
