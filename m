Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752200AbeENKBn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 06:01:43 -0400
Received: from mail-eopbgr10070.outbound.protection.outlook.com ([40.107.1.70]:46400
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751219AbeENKBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 06:01:41 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
Date: Mon, 14 May 2018 11:01:26 +0100
From: Ayan Halder <ayan.halder@arm.com>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>, Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, nd@arm.com
Subject: Re: [PATCH v3 5/5] drm/arm/malidp: Added the late system pm functions
Message-ID: <20180514100126.GA24437@arm.com>
References: <1524593567-5559-1-git-send-email-ayan.halder@arm.com>
 <1524593567-5559-6-git-send-email-ayan.halder@arm.com>
 <20180425071722.GN25142@phenom.ffwll.local>
 <20180425112604.GP14661@e110455-lin.cambridge.arm.com>
 <CAKMK7uGeptRT+oeTQQQ4U6LgAVQg2SOofTrqDo9MfFwRkKhj4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uGeptRT+oeTQQQ4U6LgAVQg2SOofTrqDo9MfFwRkKhj4A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: CWLP265CA0057.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:12::21) To DB7PR08MB3034.eurprd08.prod.outlook.com
 (2603:10a6:5:1d::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3034;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3034;3:jlV8NrAp5lZhBBz1ot4/nihauhUR3Q/V09uvG3kTWghD+XPBNCr7PzHzWb8pzo01tezlnTtSzfimvHolMpVjht8KGAjfpGuHqtvaGqQyOAFiZpARubEvrRGV9IwGWoaK/FBXe40FU7JOl9lVdw4R4RTBLX1TwkkypF0fZ2hwH9FLaIUABNjALzQq7SD8wAtDj6dffmdcJ/CJKSW1H9g3DOTGRrfb0PQn1r1ePlBL3lZusvZBEpVtbxAdvXCz1mRP;25:BTdnHYNrv0O4458iOpB5XDsP5ZlSohTD7Mf5lwJC6wzuFt9nspN6SocwGQL7Hl21i++ZdeTaWrW00yXON67P004ti2bhliJh+uKL6aO3A5rprpuhZjiF0Zb9Hl299wxdBLuFSoS5gNP5SH2JEp4y0UptDBWJDcb7AOOhNgxXQ9y/lqR39JcX292d/fPjChQ4jQ9sagr+/Hcqu8CRAj9s9RJKN1SlxQISP3spY4/mbXLwbdnTY7cqrS+vjLplFKByBMDe7RF+FkpYaofxaudUumpb4OB/GRU+O1RT7RoZaNRhinasDvG+xemiB9QjxpleSmoMk5mhSnZfpcbHO/jwsg==;31:A1wf9pPsEplVPiT2jFVrpVyfS/6P42j295nC+Sir1Bq16MSSVPfZHaJ90ZH5MxnJTUjC7VJiyN7wI+0s7cXM+JPwv1tyD2+Rd9dzOGExLpmmrJMJ5E7+HNwzwN83UgIgQTtQTj7F8qdOpcLBEuxIGFH7SKiaHycvO3XUmpvnpxMVfoqVi7o0TTf1kM3/abNk5aTmTINkgIcCq2j4k1SGZDyQXnqJ4Smms14UQ/ZCq14=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3034:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3034;20:m38SJD5rcZtzcdBk4WpzokHH99ztVnoFLDoH9EgEu0Qs0pog4FxDSIg62tR/mm+RWe2gRKJgL9T0qrG9YXWnHF1auXEOn8YS9bcDmS6hyeVB+i9fx8w1mmLF1fDZ7UvxwVni5nnLGCoiaPdlzWLw2vnD6sKKR3kiYVSx13FGITGCaf7GnlsOgy+abE+Hz4/TPq7/bYtMD5Kycsfvdw/sJ8SocDe6DDLjMC4sml/qr8H8F/hEJewuvwjdhNv02fp9;4:8Rr4MWBLSjVM0Nf3H+csCzIN0Q6qVRFdukXABKSUK/l4Dx2DMkGdFjtNgujgioXU9e0/RfOmvv02QgjvYYTyMngrDeiL9F2zzVkkp8G9RXTXAZ3lPa1BK0LOaQ6J/oE8tGvZ5Hmn/KiisKAbpgWrcdLmjVVCmh+5dd52ByWJfZ5bXac0uDQ61HgU+2Gdbb+c2dS2dneJ/KQ2JhzBwnSDyMnz0ZqwxxZJ6BzsUbxKgXWuYV0HKH9VLkejh5lzU2EXh5DwdZvddu5gbozjrrBEgfMiIc+B8d5wsW1XVynlWMm2xP6nPlvHBsc8qV0K7GTgplYpYvAIJwSkEqC42p1quSdd+2iWWNnb8HIbCzV++1E=
X-Microsoft-Antispam-PRVS: <DB7PR08MB303465B71BF8DB983E29DED6E49C0@DB7PR08MB3034.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(217544274631240);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DB7PR08MB3034;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3034;
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(346002)(366004)(39380400002)(39860400002)(396003)(199004)(189003)(4326008)(6306002)(6486002)(966005)(72206003)(478600001)(16526019)(186003)(25786009)(7736002)(66066001)(587094005)(26005)(53936002)(53546011)(446003)(47776003)(305945005)(76176011)(11346002)(6916009)(59450400001)(44832011)(52116002)(6666003)(6246003)(86362001)(53386004)(956004)(486006)(6496006)(2616005)(50466002)(386003)(476003)(229853002)(1076002)(93886005)(33656002)(16586007)(23726003)(54906003)(6116002)(81166006)(58126008)(8676002)(5660300001)(81156014)(316002)(97736004)(8936002)(2906002)(105586002)(36756003)(76506005)(68736007)(3846002)(106356001)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3034;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR08MB3034;23:mEloQlrgnrODgNjf/Pzk5MrQodCvd6UHuk0F49yD+?=
 =?us-ascii?Q?tRU4K9roXZOj0CjFUGaxNHk36HEBFdxihbYXZiuh9xXAkJWlVXn+LBXnK8NO?=
 =?us-ascii?Q?QUjzIkYsU2DrFwB/T5JyyhQa8jyC+YiPLSeBLMa3WyrgwGSHsiBmpMPyW6ms?=
 =?us-ascii?Q?YkGx1h9nduqZijgXKDojw6dW2zgthOf+5lLwLZI0JVrJdX7267ikv8QADxgW?=
 =?us-ascii?Q?U+6UO7UNjMNndCjKlQvWRNYmy4oCxQg+uy47lTyue4K6Uh9sznkYuHhU2+zk?=
 =?us-ascii?Q?FufLjuepTY24Y9J5wGKIhXObjwqIFG7oE0ju4e6K+dQ0EO5yrX1dyTHLpUWq?=
 =?us-ascii?Q?miZEmKTesiOnJuQRy1AQ/cmZANCIesocPncy4/Fgfa2dzXlduRVKF13ATz6E?=
 =?us-ascii?Q?VZrG+MGzFN9K5QNN9v40Hyrlw4TogHKD9LKiMK5udTw5/PxZFxC8LHPiy5rw?=
 =?us-ascii?Q?dn74NfBbFHr1mfrTorJslZxWoJa95Zb6sH+bTdCrEF+wyj54Cw6W68yo1BgP?=
 =?us-ascii?Q?mGTDF9lkYll+6zvMNj9Y0yZBr0MwilEMi2s21JuH2X/bsnxUGH8Lb1NMgJUh?=
 =?us-ascii?Q?vKbYhXT6FpOwgMb6gzyWH9O63qs4TKnAGQKZvP4JBmz1V7KuvaQDhHFnw0/h?=
 =?us-ascii?Q?Wd1XvYQ/EXaPKWB9p4nytsw3Dk6FcRZNAV2zQrq3Qxkcu6JPIezzbm9duguA?=
 =?us-ascii?Q?eykuZOLbw69wHHq10WQoy+sBvAhAAAI/qoJiDkrFPF5hh+Zdl7E5NxPL6TGL?=
 =?us-ascii?Q?vgXsAvOnXMkbqezX+3ALgbCInNXapNuVqucRsEES+zD5480XfX9wTytdfPmM?=
 =?us-ascii?Q?+ur+JuWi2PvCwmN0UjKLE6+MYEt5q31PRP+QSQTKFMfCJ5+FsMvNxWbef3fG?=
 =?us-ascii?Q?fxXGAFBPZ1G1WwzB0h4HTD8Ht5kMbc+im8hh+PDArY3NQfhJob9sp+R0rhFN?=
 =?us-ascii?Q?baGDchK+Zh3JeClid79FpyTMpf9X7Z+W1t9IAqCLJ5J+oxPiyolNN2yVl98z?=
 =?us-ascii?Q?h4UIKTBNbSOzA7JXNR3YjYmKRtJaJxwQxUBkE/7YwYJ9QyJ67YRw6t5zJ3hr?=
 =?us-ascii?Q?mnxCv5j9saR5KsduM9UIY6ApJ5S06F6ZpLAuD0Y5MntP/+mZyc5ztZBzByca?=
 =?us-ascii?Q?Xh5l2rTSWAWg1dJ/v4YjIY/yBvh2zfAp3Y6PsJiNXE82FEIzjtA/qrEnIeNh?=
 =?us-ascii?Q?RQH90USh3sZYwHuQRPDL4ESlP3iNw9DZFfrqmw7veWKQ/+z5zxHRK941oayO?=
 =?us-ascii?Q?/1cPP6Nj10OwywvuiIl5He/BweQqc0qr2rOZCNlofeY8DAhkoek4hLkwY/ZO?=
 =?us-ascii?Q?BqzqS7a1q1kpPUUiq+M2k1B17NJycibeM+0xbpTdn3vBgLpKCblZlrpy1fY8?=
 =?us-ascii?Q?p40+SFiWk1TQAU9NfylNr0EMv/fAgreSPerG1rYxFq4weJUAPff8nHUz8XLG?=
 =?us-ascii?Q?TF3ONDVeqkD326un7mUdH1v6bqpvdobPkQPSL7lzU2MYKCwXExEcIJVIo96K?=
 =?us-ascii?Q?0dRL8z0tU0ReaHcZn+sq8L6T753/GOZnqU=3D?=
X-Microsoft-Antispam-Message-Info: Dkrp7jhjuC9OjFSiT1CgFMDaZnKTIHyU3gmfG6/EgFuBsDxZ7Op06l2pRCzXK+FWfEPhQs8jzMFxVyJNeHSX8koZT/rG5hUw4Wx8IeS41Rb1YzOcB8hQPCS+wMrHzSIIlPbd68BL0PVw54Z+560qTJmVDUIhzKYpzdT24aOz8XQeun8dsPm6e3bqvu2sW9zf
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3034;6:Pmkus3/WFQ7s2QQEaKzJBiMAzCRNHN2kBkRojOiK/TTPgATniBiDukg4eaAQG8yINB04Fx1UJyOVlt8hVmdmq7XPLmOOy8Xkh8z4yPFCO6i5Y2dYWdNvDCn8QpfjEwaxHtyoYikPnJMioofpk2gvgN/I0D+icP7d2rgISsHjGzBMzKD38c/H2FZAY3EhUGVdm/s/YByQqbzhxlXCT2q53PmsdFM968nwn8Gk34vPM3Lqyl4iJf3Mb2/fBLgvLclzkESicjxpOBcg8TvpOLDcO5aCniZ+9daAXJgO+YkdhKw15eOJ4062EOZwJxOKzVc8bvsJb7wbKrQpsepLJ5mPD0Xku9JxfOz5EZbe2yG5UelczqTJhz/LpY45o+QTnah0k8HzBV2xfThZKLa6wdYhfLPOcJXgx08jMzsbRyXHTwpYuVY2qMz4Gpm3Ks/n0aiQeEU1FJJmjjynwArXUS0GhA==;5:3xqdCdb7h2/SGurkojTzVIaGhqY37GZ4SwMbwmLeiQEomzN59A922wrquZGbKsbGDRfiZI+OoDUuZp3OepSqkMj44jBtskPNmnbj3qSJzrVeY72SUA6nG2hpyDwOKyxMFQwvX2QZ+H2CuRNHDUaqKr7i3KfIc1mcdufw7GC2aJc=;24:/lBL5r/KvC1CYsIYyGfeYfbGo+jShXjN7eVPR3tbp6LIWR/SCDXCs+WbNJmTVsZPdB4aZp7iKmnMWcbBHdnDUs9hFKUw4/xDU/1EnwufK5E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3034;7:snMhZ5XQxdBdEGCKxqbPLLb8P1gIaXrW2paJqFedlgSLu4iTJdtDnUu9q111lGsDlWiSKxQQxfQG9KgXWvl8QpdrS0AcYD+0ceqISMhgiSC9QzJfPAQi3f+lGwCJ9k7zafha/qPkFADJbpBmPx/gO9AYf2ZnWVrZ2I/MVIJiuTWjVpdvMyv0X/sSmRKMjovVkB2GhtJVjrJCbj6tyQDS/m0EXP5fOek8LSsJXaDtuEi6rcqbZIL6vWHFbZI+mk+u
X-MS-Office365-Filtering-Correlation-Id: 9e49902e-6ea6-4109-58bd-08d5b981ae4f
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 10:01:35.9148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e49902e-6ea6-4109-58bd-08d5b981ae4f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3034
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 01:49:35PM +0200, Daniel Vetter wrote:
Hi Daniel,
> On Wed, Apr 25, 2018 at 1:26 PM, Liviu Dudau <liviu.dudau@arm.com> wrote:
> > On Wed, Apr 25, 2018 at 09:17:22AM +0200, Daniel Vetter wrote:
> >> On Tue, Apr 24, 2018 at 07:12:47PM +0100, Ayan Kumar Halder wrote:
> >> > malidp_pm_suspend_late checks if the runtime status is not suspended
> >> > and if so, invokes malidp_runtime_pm_suspend which disables the
> >> > display engine/core interrupts and the clocks. It sets the runtime status
> >> > as suspended.
> >> >
> >> > The difference between suspend() and suspend_late() is as follows:-
> >> > 1. suspend() makes the device quiescent. In our case, we invoke the DRM
> >> > helper which disables the CRTC. This would have invoked runtime pm
> >> > suspend but the system suspend process disables runtime pm.
> >> > 2. suspend_late() It continues the suspend operations of the drm device
> >> > which was started by suspend(). In our case, it performs the same functionality
> >> > as runtime_suspend().
> >> >
> >> > The complimentary functions are resume() and resume_early(). In the case of
> >> > resume_early(), we invoke malidp_runtime_pm_resume() which enables the clocks
> >> > and the interrupts. It sets the runtime status as active. If the device was
> >> > in runtime suspend mode before system suspend was called, pm_runtime_work()
> >> > will put the device back in runtime suspended mode( after the complete system
> >> > has been resumed).
> >> >
> >> > Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
> >> >
> >>
> >> Afaiui we still haven't bottomed out on the discussion on v1. Did you get
> >> hold of Rafael?
> >
> > No, there was no reply from him. Lets try again:
> >
> > Rafael, we are debating on what the proper approach is for handling the
> > suspend/resume callbacks for a DRM driver that is likely to not be
> > runtime suspended when the power-down happens (because we are driving
> > the display output). We are using in this patch the LATE_SYSTEM_SLEEP_PM_OPS
> > in order to do the work that we also do during runtime suspend, which is
> > turning off the output and the clocks driving it. The reason for doing
> > that is because the PM core takes a runtime reference during system
> > suspend for all devices that are not already runtime suspended, so our
> > runtime_pm_suspend() hook is never called.
> >
> > Daniel's argument is that we should not be doing this from LATE hooks,
> > but from the normal suspend hooks, however kernel doc seems to suggest
> > otherwise.
> 
> For more context: I thought the reason behind the recommendation to
> stuff the rpm callbacks into the late/early hooks was to solve
> cross-device ordering issues. That way everyone shuts down the device
> functionality in the normal hooks, but only powers them off in the
> late hook (to allow other drivers to keep using the clock/i2c
> master/whatever). But we now have device_link to solve that since a
> while, so I'm not sure the recommendation to stuff the rpm hooks into
> late/early callbacks is still correct.
> -Daniel
> 
It has been more than two weeks and we have not got any response from
Rafael. Can you ping him personally or suggest any way by which ask
him to respond?
> >
> > Best regards,
> > Liviu
> >
> >
> >
> >> -Daniel
> >>
> >> > ---
> >> > Changes in v3:-
> >> > - Rebased on top of earlier v3 patches,
> >> >
> >> > Changes in v2:-
> >> > - Removed the change id and modified the commit message
> >> > ---
> >> >  drivers/gpu/drm/arm/malidp_drv.c | 17 +++++++++++++++++
> >> >  1 file changed, 17 insertions(+)
> >> >
> >> > diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> >> > index 82221ea..c53b46a 100644
> >> > --- a/drivers/gpu/drm/arm/malidp_drv.c
> >> > +++ b/drivers/gpu/drm/arm/malidp_drv.c
> >> > @@ -768,8 +768,25 @@ static int __maybe_unused malidp_pm_resume(struct device *dev)
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
> >
> > --
> > ====================
> > | I would like to |
> > | fix the world,  |
> > | but they're not |
> > | giving me the   |
> >  \ source code!  /
> >   ---------------
> >     ??\_(???)_/??
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
