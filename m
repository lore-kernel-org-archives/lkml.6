Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752102AbeDFTC0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 15:02:26 -0400
Received: from mail-he1eur01on0082.outbound.protection.outlook.com ([104.47.0.82]:23339
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751849AbeDFTCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 15:02:21 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
Date: Fri, 6 Apr 2018 20:02:16 +0100
From: Ayan Halder <ayan.halder@arm.com>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH 8/8] drm/arm/malidp: Added the late system pm functions
Message-ID: <20180406190216.GA18433@arm.com>
References: <1522083800-30100-1-git-send-email-ayan.halder@arm.com>
 <1522083800-30100-9-git-send-email-ayan.halder@arm.com>
 <20180327082903.GS14155@phenom.ffwll.local>
 <20180327095907.GA18146@arm.com>
 <CAKMK7uF8mmLOBQtwfQgkdpPHfoy7yM9UApWgc9YiEudoP5WEyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uF8mmLOBQtwfQgkdpPHfoy7yM9UApWgc9YiEudoP5WEyw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: AM5P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::23) To DB7PR08MB3035.eurprd08.prod.outlook.com
 (2603:10a6:5:1d::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1cac6d94-da07-43fe-8dbe-08d59bf0eb30
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3035;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3035;3:kY5TPRynqC8bnMVRHZSepwp5IGk1lLNhWyiH5u51boJUZe/WDUPRt74oDLmmalg3XjiNvprKKsqYodzbPV8HiFXbdsuFqN35zMRDjTB5q2DtiJ+uf6gFkm79iZgxHpNuOLPCTZ5z7Ls6qk9rJmLSqhhh42o2pfFHjx4xOLbW4wQEQeBhIy/+kNMdagDK+uO0vqApWw06GfwjFce7Dd4hp7d/iIOHHXCF5opDpdFUiajWF4i+ajS/aoSTfC9Rsxev;25:fjrpaA/2HvJ2tHhldqPvKTw5Ut3cryVO/i1aK36ghzyVhmzTmwjkj4U6wAIw5cX6/BjyJFZcKYUfSn75KvP2RTN5aHBfmPX30zXb3bGJ5sZvJX53mO2RAnKTmagEcQ74lZ3FochM6Bd3VEdJMFy2JemPgF2FzumYZHpe3zYXpWR9S+3xb4yf4zI0SXwaV1TTRKnd1caJf4avlsBi9Wcsk6HRcSBYs2N9tOmYfAw86SEc2d+ot728Hxeby9BWPIvDXiHFWISn5dIl2TvCQTGpGSsADsTjjcKdFWWPjQlp6Vpe2xH7cCa1vKKkk9Ug4Jscg8O7G42P3j40NOwIDHDeoA==;31:Bh+U6uKCwfb4zyh5zlfBZI8dG7vDJCGVKtT9eKc6ul2hQPXQSQAECwN1k4A9NHZQiv1z6nnvoAY+Zc/eCKg9dWrSjQJT/RkzRo4OahM9BpEOtqLdllOqjsQ+kL2KDZYUw54YB8UYOoRRj7mW/4JA8HJXqoEQGC9n3woSuzV5NIAa6emGBtl4kfVLb9BAXxb3/O4VU8hMAzzi/YaH7ia5VALM3Hq9/1Oy1AgyT9/XyOE=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3035:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3035;20:G3F/4nSPk0++2RzsgEpwqHEcdQXKJQuUROys1h7oUTAKSFtJa5m4LYho8iCOXZSIPVQSI7AgTK2sjp786ph2vPMlDOHlCoqG62N/uPwxaMt4BSU5hoKPxT5SqSQUGdzU9xLDwgAQqC6emdigF4IRTapkfDJDAeBFeGxAZlqCzns=;4:ZgAHBZ/u64606rx5LYZZOUUIWCFjfidd4zdU6Jmf0JjpIvnXUWJDGp4m4EhytDShQy/r0GV8VpjVfP5v1b4y34awI2y1wxZYMiZ9GBMMlqcJmMqjvdTroji9ZyDeBS/v61b81KizAxKMsFwwB1nMehehFoM2zocUWtCT4m1REIWeqMl6WN7JAKKUjnE+x8w43ujRWVr3mTbQRLed1014yk+3mFmSfa5eSFQDQOvlN03rLy3xVbaJtMi/Z23f21NhjG+2znnd6uNyqZFwDbJd4+DjSsPlOIfAUFu55nTSEXEKLFORpEfIJM+9Ddx5Moz1Na96XeunaN7HLRZ4T9J/6mImlLDUKFAj/xLu59h8vr4=
X-Microsoft-Antispam-PRVS: <DB7PR08MB30350F8B4C99B1FDB3036971E4BA0@DB7PR08MB3035.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(217544274631240);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DB7PR08MB3035;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3035;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(376002)(39380400002)(346002)(366004)(396003)(11905935001)(199004)(189003)(40434004)(58126008)(33656002)(81166006)(7736002)(105586002)(587094005)(2906002)(16586007)(316002)(53546011)(59450400001)(76176011)(2616005)(486006)(11346002)(305945005)(446003)(5890100001)(386003)(956004)(81156014)(8676002)(476003)(97736004)(5660300001)(106356001)(50466002)(6306002)(36756003)(53386004)(26005)(229853002)(186003)(4326008)(6916009)(16526019)(47776003)(966005)(72206003)(23726003)(8936002)(6116002)(6496006)(54906003)(53936002)(478600001)(25786009)(93886005)(86362001)(76506005)(1076002)(52116002)(68736007)(6246003)(3846002)(6486002)(66066001)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3035;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR08MB3035;23:oFyi3dI6uDTv+H3jytc5lCdd0BuHCb9UES9fgtSBx?=
 =?us-ascii?Q?J9zQ0Fx9wmclr/uWWTiHjwTIpfgP2dYTZJzn/mUQA8KmDRejR8eP6i5P+qWz?=
 =?us-ascii?Q?XEmqySOBe/2+de6hpJ/R/mNNXsqVLdPdnSZZdMT3vWdTCz+dOCVnvOPz9SEC?=
 =?us-ascii?Q?5sDRaZyN90B+PeM4EBC1dlcLV3PuktJXIi3sxTu8DlmC8o2XYolTTVIUTfRg?=
 =?us-ascii?Q?2Bf1cTlQTne5JQtiybafl/at8RZWBwv4fLjCD8h+2WnTE8xzLP4cDSJyJEet?=
 =?us-ascii?Q?y2TtK1WwC82INSzMBjou5yXXwc7r55CPWNJ2w8haZok4kSe2DNqW2PuiGO/Z?=
 =?us-ascii?Q?MmnST7duPKdd09GR1w/bsu7DgQM8ULkdPcE9Ks3hvLnJ+o99O4In0jcjVxFS?=
 =?us-ascii?Q?pkW7n/qKW6wSuhmkkDUxIB9bp39NZeAuELCdg3qasyu7CpPzbE7Hig6M3u7n?=
 =?us-ascii?Q?Jk2r94Cg2hUV9/L1wJOWir0a959CN7bmgnWgJQaU4Oyp1RQWOTr25VuaqXpL?=
 =?us-ascii?Q?DVPnWGIRygoKjOD+T63SuzQt+mjdW3l7NJvp9ZJfE9xDQkGe0K0vVKQwg5DB?=
 =?us-ascii?Q?YJN0QWqlXJ/x84X/IIeq9trNXoF6y8RLI1VM7orz4q7yDIJo4vPEo938ezwF?=
 =?us-ascii?Q?UvvyGOwVoTV4yWLdto3XCSMO3wY+VgLjybODeci5FmkujpKaB356TEzrHzjR?=
 =?us-ascii?Q?SIG2ReUvNpENgn9dDr8CuKqiRZC2GXo1QZOcwnqcWgn0sWcBLfWX17ly0UEj?=
 =?us-ascii?Q?l9jIwBfwC3tsD6Z3/Aw1ULLKhKFBqg6xJDNIEA5/r5oJ8/glOgBs8s6x2OuI?=
 =?us-ascii?Q?q+VcXePdEJDoyVpewiAWnyJXdeAZySTW7idsKg0P6t7IXbsUaGFgNQ3bYcVk?=
 =?us-ascii?Q?sIxWolg4Eu1+pNASCmQ9FirWV8NwDAcWbz+1CtfZyMaEI0tDhJhCHc3VU5Iy?=
 =?us-ascii?Q?Ta+2Ou+F55VfBsWSOBc7UJV4eRu45O8P/qxDf12DW17aA6bJcbxgJBEcudwi?=
 =?us-ascii?Q?qlznsETusPLdCOh5F5a+dW9Mt3L8SihEXRBSpeDKVYo2Iu4g780dGYOc3wju?=
 =?us-ascii?Q?rjlKA4+ZLYXQ6Dbq38YUkF6NUf8XZJRi4J2iNUN3iKhHhoyYImqKZk0nw/AB?=
 =?us-ascii?Q?R8LSV9/EZ3lz2Jn5oZadTkK9nSTeUgCyKmf5flYp4xIHoKU4+6EatlVhtUS6?=
 =?us-ascii?Q?Ysc66q8yqHQt+yNXxdWTZXeqYLY6mFOQyGpesUwyw+swmS3rAlWa4pqRtWn8?=
 =?us-ascii?Q?xKipMOCogg6oo+ykpDS4qRxo5Q7MqdrmD0GHxkMbb27sat5R8p7zg1xYvNDQ?=
 =?us-ascii?Q?XRYP7ySrqtFIVvT32PPPV+3E9XiTmue7RT0fD3Dmz7CG1e6F8etpMc+nbxD9?=
 =?us-ascii?Q?tP6VMMDBzQ7AwDdnayLTjUprUpkJobofxhZomHbcIU9NaGLWust/LDBI+NpU?=
 =?us-ascii?Q?Kxz65ERDNtidqtTiN8zXCfDio+k6/Z3fXofR9oDgX+A8ZvrxOKp52pRuv11A?=
 =?us-ascii?Q?JYqGzvqnr/UMLFkgClB5DNbjsEG+WAZ+vXnvLR0GvPxO4vyOuUPwULY?=
X-Microsoft-Antispam-Message-Info: Wk1F1WQMDylrZ89sWXiMXhofM8GQOSV52qZFJj3mS3pXZYvaUPTt22TzbwvfE0ME5Pu+ZtX+u2wdge3c41wHTwiJOWHGBQJd04+d0UdcIvitZVP9Ojdfhu+Wj5EniLOvPT+d3sNXVahGR42hG7duFGXeciQMOIAB3R7YXmVvu4T00TwzYLl2N39X9LdCj8sE
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3035;6:kpFDizZJEAVFbGrHHiL7eEFFwslGYbspcW7qXp/wURTYXPBJuPmRA9e3SqWj427v2YvPJrBV9+vjd8i8MtiIwP46ZucOFBcxjU4MbO93uLSWR8O/ECC9GFX4qt44bEZsyfWgzlcr9kh/XwNJHo95IxIVjBHk5daPrY0rL7hp5CgezAlFsytjnxUcy/y7vtdfi/fImMI2HP0893FVwpbsgqGYVCQD754p1nb3eFT4C/gfW0TcNwSyLnrpjPhVpLi/5/lrsgzzjlH7ER9MUtvFn04Bh6HHcxEGzu6+s0iIrT59q2YJfB4qPFNOLg6Xr6AF71xfOqf4YNa5vcPRKDBEZCB53KNxbPRJMJFb9qv5Ye+JpTXORR6P61ijt2LTX8DOdJHRrrs4moi/f05hPB1vKgm/kIMhxU73Dpx0weNCol+h/R1+rL36+Cr/Ydv1H9Mbt6c/Yq9d6rpUDrWKNfBdBQ==;5:Zkvy9x1yh7Hk7+JcSjojLorvwTFRfuYDef0Tft6RlvmvlA8TbKnn0NHW2eE7j/VKfzwHATO4hMUvivJ/vvenbMvXWaUrU3zSiPLbWqOu9CtYQgrHZ1SAIZ3RwXxh476ud/QP9Rea19kkg6aHR1SQ8lsR6wf6wCiAybqDt0OG0MM=;24:S4uDvesKerxSLLc9YB96u9k8i35Vl6NAMAkphvo3fdHKco7kwdqv9F/sZGOtqdqvKavsMUvKS5aYKO8AzpscwnVKwjyvJqJ08H4GupRhzIM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3035;7:YOfSbGWRfFNOb0lnAdOuJ0b61N8il8WLGNQ8LU1ZSn4kuO/BkSb3HslAeJi9SA7sTpMrb/ZGsHX1VVuXvg5xRnUu54jPLE94VPvkpSoExU2FCRp1qURF5ng/hn8YjCMXUUVVvuug2oA3Qv42kyoZ/Y4y4Ean7EzbGVHelh4VW7Pm1c0xzgsBpr/M/qWrqrG53TGr82H+8FJ/47bxm7mfU3T+EIgBFh4IEEHPzatuKJAOh6Ki90xx6gHs4Gt9HoNo
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 19:02:18.1983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cac6d94-da07-43fe-8dbe-08d59bf0eb30
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3035
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 01:09:36PM +0200, Daniel Vetter wrote:
> On Tue, Mar 27, 2018 at 11:59 AM, Ayan Halder <ayan.halder@arm.com> wrote:
> > On Tue, Mar 27, 2018 at 10:29:03AM +0200, Daniel Vetter wrote:
> >> On Mon, Mar 26, 2018 at 06:03:20PM +0100, Ayan Kumar Halder wrote:
> >> > malidp_pm_suspend_late checks if the runtime status is not suspended
> >> > and if so, invokes malidp_runtime_pm_suspend which disables the
> >> > display engine/core interrupts and the clocks. It sets the runtime status
> >> > as suspended. Subsequently, malidp_pm_resume_early will invoke
> >> > malidp_runtime_pm_resume which enables the clocks and the interrupts
> >> > (previously disabled) and sets the runtime status as active.
> >> >
> >> > Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
> >> > Change-Id: I5f8c3d28f076314a1c9da2a46760a9c37039ccda
> >>
> >> Why exactly do you need late/early hooks? If you have dependencies with
> >> other devices, pls consider adding device_links instead. This here
> >> shouldn't be necessary.
> >> -Daniel
> > We need to late/early hooks to disable malidp interrupts and the
> > clocks.
> 
> Yes, but why this ordering constraint? Why can't you just disable the
> interrupts/clocks in the normal suspend code. I see that the patch
> does this, I want to understand why it does it.
> -Daniel
Apologies for my delayed response on this. 

With reference to https://lwn.net/Articles/505683/ :-
1. "suspend() should leave the device in a quiescent state." We invoke
drm_mode_config_helper_suspend() which deactivates the crtc. I
understand that this is the quiescent state.

2. "suspend_late() can often be the same as runtime_suspend()."  We
invoke runtime suspend/resume calls in late/early hooks.

> >> > ---
> >> >  drivers/gpu/drm/arm/malidp_drv.c | 17 +++++++++++++++++
> >> >  1 file changed, 17 insertions(+)
> >> >
> >> > diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> >> > index bd44a6d..f6124d8 100644
> >> > --- a/drivers/gpu/drm/arm/malidp_drv.c
> >> > +++ b/drivers/gpu/drm/arm/malidp_drv.c
> >> > @@ -766,8 +766,25 @@ static int __maybe_unused malidp_pm_resume(struct device *dev)
> >> >     return 0;
> >> >  }
> >> >
> >> > +static int __maybe_unused malidp_pm_suspend_late(struct device *dev)
> >> > +{
> >> > +   if (!pm_runtime_status_suspended(dev)) {
> >> > +           malidp_runtime_pm_suspend(dev);
> >> > +           pm_runtime_set_suspended(dev);
> >> > +   }
> >> > +   return 0;
> >> > +}
> >> > +
> >> > +static int __maybe_unused malidp_pm_resume_early(struct device *dev)
> >> > +{
> >> > +   malidp_runtime_pm_resume(dev);
> >> > +   pm_runtime_set_active(dev);
> >> > +   return 0;
> >> > +}
> >> > +
> >> >  static const struct dev_pm_ops malidp_pm_ops = {
> >> >     SET_SYSTEM_SLEEP_PM_OPS(malidp_pm_suspend, malidp_pm_resume) \
> >> > +   SET_LATE_SYSTEM_SLEEP_PM_OPS(malidp_pm_suspend_late, malidp_pm_resume_early) \
> >> >     SET_RUNTIME_PM_OPS(malidp_runtime_pm_suspend, malidp_runtime_pm_resume, NULL)
> >> >  };
> >> >
> >> > --
> >> > 2.7.4
> >> >
> >> > _______________________________________________
> >> > dri-devel mailing list
> >> > dri-devel@lists.freedesktop.org
> >> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >>
> >> --
> >> Daniel Vetter
> >> Software Engineer, Intel Corporation
> >> http://blog.ffwll.ch
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
