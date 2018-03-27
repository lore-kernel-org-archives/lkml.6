Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbeC0J7P (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:59:15 -0400
Received: from mail-he1eur01on0074.outbound.protection.outlook.com ([104.47.0.74]:5440
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751078AbeC0J7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:59:13 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
Date: Tue, 27 Mar 2018 10:59:07 +0100
From: Ayan Halder <ayan.halder@arm.com>
To: liviu.dudau@arm.com, brian.starkey@arm.com, malidp@foss.arm.com,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH 8/8] drm/arm/malidp: Added the late system pm functions
Message-ID: <20180327095907.GA18146@arm.com>
References: <1522083800-30100-1-git-send-email-ayan.halder@arm.com>
 <1522083800-30100-9-git-send-email-ayan.halder@arm.com>
 <20180327082903.GS14155@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327082903.GS14155@phenom.ffwll.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: AM5P194CA0007.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::17) To DB7PR08MB3033.eurprd08.prod.outlook.com
 (2603:10a6:5:1d::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dea74f34-f53e-429c-8a65-08d593c9635c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3033;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3033;3:6XE7k0KEQIV/oDxfNqZtIfcvICFH1wydrxjxOS0sYBPsYCyrgEmk0Sx7aQbh+KBfquaQekKTBnhbC9svhqslU2cZMdDfsO5RtJVh4eLUIoiV+R8eyPQQ6vNTgqQtcK/QXwFsiXTt6aXeT7Z+RdiRd3VqDkotHHPbEBxXL40rGcT6YSeESPcWnnUyMzHa2P7u6kLqp1H6EZpFTJ6qhZSzzSYln2Myd9J/9L76bTIeeH874jhGiuPAo5nTEvI21Nrj;25:22RI/K4rT1j3J38+aJT1gH0CK7wXAwCtp9G/fVAcOSdEss21S3krnwf4k0hy3HDZuMWQ2tY0ysRbiZNHYyCPifXWyqM8NxBL6YvlY+ZQPq4WdvsZVofWBXobytgLLkH7MgH/iTLsYljcFYer5W4A1rai1y8NsNlpc2pMOlD+vINa4+9lYvgHZY8zMZ/rCdEvYq+kxW+zm97jnduXWXkZz92/8oe0wqAicEaQkmvQBxvfIue7kjSWdEojZRtqFFbeuzx99UeYDrK/lIUcd7FwyMFiwJVAJzxB32B9+k6jsZjG4PAHOO6+kahZSmbdfbwBun4llf481QyqBipDMXdYLA==;31:yrZ7p5SYQbPuA0A6MsKoJLm20BR+rQfbNF88SgOevw0++IvIsgNlAB9S0XLgtGAWwGcZWaYfJwKn7Y7MywbRScVEzfDwuX682mpuS/8LzAzlE/jmq6fl1vXJln1TbQO1nlCKoy+qMn9Bcuklopj0KovSz6vzk65IrR9qcgINnC4OX1dCy4rkJdXoU5oISDyOMBPy0bD/rLzo+MTFifSOyRWWtqUMv8Ez2iCvrikZttc=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3033:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3033;20:4FA1Ee7sCA/ndnAXDE285DnTtTofuQKL343gJnyvRd+bzlvPo05lHAxXekqxpmsxHTJIGM0/pj+Jte4/MRvYem1qQvcEWiQYXF5xZzmo/Y3FV9c1yNBUT6NPAdtZWYL7SCijEqaGKfZxJrCGW4L1o/L2dVqAcd5q2tWK56w42XUWbPwuWo4ysarS5TuQUX9MFvCkd6rPO65w6DS3h0Oniag7W+0lQhts/NF9r5RP4Z4cSZseYv7QVdhNAaDP9Xfw6e3pHhHVonXJ81WVLE+uVJJLGdCK5H9bK1gMzwJnqSyIVRjcRig159I6159azlz1sOTwVKTBAxcfnwJZeia3mjzqKbmZHee+OL74QzDv+bE6brdJ5gaMHaiBgeeZcOs5tMuDxs/2WuU8cQMmG5sCIubq+5sHTuKgyaYtbO7yX/MfRc46ZnlzePAQpcLBLa0KqRjohGoPanmuMsP9rZGN3yTNvLzWjtWIvshQX/RIB6r3auUc4/0tB9q40HL3iZ1W;4:g1h9bFYKHg5/I7fn+UOwEApmUi3tJcn8qLY3q5I8sXFQrc4GwIBYsxhN0v6xIzDql5YhCYrO5cFl3mYkfLjQ9ZWClH+dRovSUH0IvN8B2ntu82DIC3tpraPT2PduXWsiBaKTP2a9EtRQfLMytQsmZ08dGof/S3MHoz5RKGdZObjN+1VZuhpZIu2H9jdXNjkN1Xq9bYInhsPHRoKp5g5WuIghotNyQp2B3YQYsSaSIT3g4Vhwgps1TzZOF3z41mFfyRdxWsXQ3wvXaGfgtz3hFvm1tZt7j1+pRPwkZCEO1GdplynOY5e1ypJSpBLcC9utJ3LC0Tm3Wup40Gjlue2RHKuuQD9mOUue9shBHt5Y3lg=
X-Microsoft-Antispam-PRVS: <DB7PR08MB3033E4CE462B9A0A0C76CA65E4AC0@DB7PR08MB3033.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(217544274631240);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DB7PR08MB3033;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3033;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(39380400002)(366004)(396003)(376002)(346002)(40434004)(199004)(189003)(6496006)(23726003)(8676002)(1076002)(72206003)(316002)(66066001)(81166006)(81156014)(8936002)(5890100001)(3846002)(47776003)(229853002)(97736004)(33656002)(6636002)(5660300001)(478600001)(6666003)(6246003)(53386004)(6306002)(6486002)(6116002)(8746002)(53936002)(58126008)(106356001)(587094005)(2906002)(105586002)(76506005)(68736007)(50466002)(305945005)(11346002)(476003)(486005)(386003)(86362001)(7736002)(26005)(59450400001)(36756003)(25786009)(446003)(956004)(486005)(2616005)(16526019)(52116002)(76176011)(966005)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3033;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR08MB3033;23:0kO8TgeF/yF7OLg7p+jlOr0pHeIbf4B+RMwAp1r6P?=
 =?us-ascii?Q?XuFYS83K4vTG1oaIJcF42qvJQrpILPntviCQBzM5I7pkEr865RLN8iC5U7Xf?=
 =?us-ascii?Q?/n9G44ALCJ/6ui43CIZRgXbaEL45FzzywFSLb9qvA4Z2d8ZAyfEK826iC/GC?=
 =?us-ascii?Q?MX6fsFbLINzDM+9Os4WbBvr5N8Nnw/+HGEmLiCDCuGIksVSicgTgRs7auvBI?=
 =?us-ascii?Q?0b7A5jBhY7Rfm/dHxtEBu86vhHAsoy17ewkSAXRUyth+eNXoDnHHSfIlb1E1?=
 =?us-ascii?Q?RkCxJ+FjKubXmwmRSSYyzP/MCkzsMOzA4OI4Pnq+sWHgnZeb49rrLaV2emx+?=
 =?us-ascii?Q?1RPET7D5AVUUwRcAKUz0PF0dGZ0XK/GoO8c2J97gka1pB3BGdyUTLXtRys3Q?=
 =?us-ascii?Q?NfSZvhIohwhR/4eHUUq3e660fCVLYyGvnYbxPct3NxWZRLH5gK95qRxYs/GA?=
 =?us-ascii?Q?U7AU2kotv6yskyIW/JTM/3PBDRlPH/Lc5NuiYO6dUQHQEh47FlB9tVkXvR92?=
 =?us-ascii?Q?u9ryHMAlN4kVS87nQP+MrTgqvTjs59dQqm40Axrg4+QeRaa2fOIz08mCkRyE?=
 =?us-ascii?Q?PFmyUdvH1WVkx/IgaPRroLsJWwg9qbfyir5SDJd0alcDz5UwRHedtj7G+aPB?=
 =?us-ascii?Q?CW8nJI/ZkMLRcF0Iqd4yL6QC3acaOxfpsZ/4N2zfcuaBkG/W/jjFhYwWyhoF?=
 =?us-ascii?Q?5pyEZ+AMDNdsE+EjYgb9n9vML8IvKt64QkDEcMFTK/NhS/YtNHJKps3g77qD?=
 =?us-ascii?Q?M0vfhMy36Xw+5Y0TLOT5If0W6BWK9Ch4UlYgqXDyaEMdUo8sMCiLZ1VecE8U?=
 =?us-ascii?Q?K4xmOlrfXduwejJQOEk4SacNvDRO6zhqH4wqMrr+/yJBiTDAVAKa7MLbP01M?=
 =?us-ascii?Q?AAouY+Ilqqzo6NIgqrNFHH+ASQZ4fBvxNIobhogErnwJNcrDrWE1H/316b6l?=
 =?us-ascii?Q?9gg8Pvkpoc+kbDieFIWy0xijnT4yJHr15H3/YIjdqALX9cLWSDSbqXqON2nx?=
 =?us-ascii?Q?m5r2Hg8erraDKpTqvPAGVfu2oHy8sbfAj4TiNRtsqKAU8wtLPlEZjXl/nHle?=
 =?us-ascii?Q?6vbGcMGM6KJlXpTkPhV1lw6MmMWlTUL+dmZG+ax2Z/NdRHA9/JYmjGAth264?=
 =?us-ascii?Q?LkHgvg6rgoZGzPB+7fX+SQLK2nTA1H7DJl/aames+8plvbI93psFTG6ExW9I?=
 =?us-ascii?Q?Gal37Pn5p/n0rPcHW5wwnR8VG1eC+KyeGlY0u9iHFvK9ED6R4csJ/ynsrR1c?=
 =?us-ascii?Q?Q43K0x8VEhkxSlOaJkM6sD7ACIeL4ocPZp5HA1VKoMbxoo8hcMe7uLGm9UID?=
 =?us-ascii?Q?zLmmokgQSLnLRhpxbtP3dqmIze6k5STbZORvwnw70W5VTagUhoZ765BY0b2j?=
 =?us-ascii?Q?zvLQ9vgCHFl6YV6yaTJnqiPcaHx/+b9pPPDu9Q0q4CH3A3l1TUm5TmN6oXZV?=
 =?us-ascii?Q?zVJPI9nJmySwNZ50Z16fPvxkinlQaE=3D?=
X-Microsoft-Antispam-Message-Info: amnc7o/Pai/Pzmtjl4sgwBLEDqu096mElAqSOv6lRwpD1PXL+BsyOeMYsFVlCvFj0wG9d7A6zZdYI0cehQCTg9V1IOJlHXT7s/gALYrx6hnhgAnXnBKAf1fYj7433KKtyugNElAWJM6lM4rfh9R5QDG2hnUPy6NXIPgfzkeeyX8CJxHjxKcBUWFP3QxcL0bK
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3033;6:fuHMbb2CTG8Ah81rFXlHLnGNttoctS723mDSVHvORe40MeCXXShS4rKEnPT6PMehycCwmzcb/UsjAt94QrC45lVhLLqdcDuWNReO+Jv+cAMifW83Iou3N09/mFHDFJ/Yn8ZFgYqubhq3WhJrGzWJjhMIslNAzelDA31GVQYGagfaRqMvTMO0xweaKiaoNfinDXIvHO04i3tloeiJ95NkTUTGlM48i0FQGS0pwvsjXkTr0Pr9i6nXTAA/PNk0ZOg44Wy8S7hQKMw8/lXEXZlHw/mb++S+m6q0hAcf//snxSgWsxlEgJ/GT5C1jAJpoR/ToWqIF1f4sMXXLMRZSPUYVxiz6Nt3hQ86E4BSVTUDEvGu8Fs835YzGkpSTeGypNF2rxF6HeFt1houPRCqhkAwD+uoto6KNwuhx12mUa2QaXIaSc9g0xSkmxCiLvMpnoQmrUm/iG5PcQcDUY2JHyachA==;5:MxV0/ofw4k9EJ/5sUzjgCE+BJNwTWeTnwC3+kj7zF1YRoljMVdVgt7F/X+Z4zNkY5U9zC8ltQweNIokECLrRDXG6aK2Y2kKUVk5u5H+XrGxESRfwMbLMULxCFmgTW2yEFiXUwkHv2zVlJsw+zlUkOTj8MwHQkuOncsc/hAl3ZsY=;24:5L8WkAclmYj5jlUiMdqiRZcGj7latMZvT+4Y7ndXDACiiBTDsaDsOkx2g62VD0a9FJRrYvbr+tSqODATDCz6IhC9z+OqbcsMZi95iq8TlWQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3033;7:/jOdXRpjDf9FV38TDQu1UgnQy+kdL3l0pC93Wq45dC3VLyGQFxnBIDVGTiEnjk1s6bI2olb4EXZg+YuJN6JUapsfb/7FHIOR6RicVUqQt/em+EYS7rVX97IlqpSmkVhMrFFPE+GWKNB0+K+3xA32rLAGAdpiqCuLmCvipAfA54mUPHfN2f65nafNBy8O7ZTO5kbGH/aWn3UWqenJ37fXMI/OEc7cUNS/Bc1E93mmHkTOQPqjmXhSlG3+m1I4wJu7
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 09:59:10.6261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dea74f34-f53e-429c-8a65-08d593c9635c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3033
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2R9xMwJ031341

On Tue, Mar 27, 2018 at 10:29:03AM +0200, Daniel Vetter wrote:
> On Mon, Mar 26, 2018 at 06:03:20PM +0100, Ayan Kumar Halder wrote:
> > malidp_pm_suspend_late checks if the runtime status is not suspended
> > and if so, invokes malidp_runtime_pm_suspend which disables the
> > display engine/core interrupts and the clocks. It sets the runtime status
> > as suspended. Subsequently, malidp_pm_resume_early will invoke
> > malidp_runtime_pm_resume which enables the clocks and the interrupts
> > (previously disabled) and sets the runtime status as active.
> >
> > Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
> > Change-Id: I5f8c3d28f076314a1c9da2a46760a9c37039ccda
>
> Why exactly do you need late/early hooks? If you have dependencies with
> other devices, pls consider adding device_links instead. This here
> shouldn't be necessary.
> -Daniel
We need to late/early hooks to disable malidp interrupts and the
clocks.
> > ---
> >  drivers/gpu/drm/arm/malidp_drv.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> > index bd44a6d..f6124d8 100644
> > --- a/drivers/gpu/drm/arm/malidp_drv.c
> > +++ b/drivers/gpu/drm/arm/malidp_drv.c
> > @@ -766,8 +766,25 @@ static int __maybe_unused malidp_pm_resume(struct device *dev)
> >     return 0;
> >  }
> >
> > +static int __maybe_unused malidp_pm_suspend_late(struct device *dev)
> > +{
> > +   if (!pm_runtime_status_suspended(dev)) {
> > +           malidp_runtime_pm_suspend(dev);
> > +           pm_runtime_set_suspended(dev);
> > +   }
> > +   return 0;
> > +}
> > +
> > +static int __maybe_unused malidp_pm_resume_early(struct device *dev)
> > +{
> > +   malidp_runtime_pm_resume(dev);
> > +   pm_runtime_set_active(dev);
> > +   return 0;
> > +}
> > +
> >  static const struct dev_pm_ops malidp_pm_ops = {
> >     SET_SYSTEM_SLEEP_PM_OPS(malidp_pm_suspend, malidp_pm_resume) \
> > +   SET_LATE_SYSTEM_SLEEP_PM_OPS(malidp_pm_suspend_late, malidp_pm_resume_early) \
> >     SET_RUNTIME_PM_OPS(malidp_runtime_pm_suspend, malidp_runtime_pm_resume, NULL)
> >  };
> >
> > --
> > 2.7.4
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
