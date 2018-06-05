Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751869AbeFEJSs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:18:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:47667 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751822AbeFEJSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:18:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,478,1520924400";
   d="scan'208";a="60474742"
From: "Dziegielewski, Marcin" <marcin.dziegielewski@intel.com>
To: Javier Gonzalez <javier@cnexlabs.com>
CC: Matias Bjorling <mb@lightnvm.io>, Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
Subject: RE: [GIT PULL 18/20] lightnvm: pblk: handle case when mw_cunits
 equals to 0
Thread-Topic: [GIT PULL 18/20] lightnvm: pblk: handle case when mw_cunits
 equals to 0
Thread-Index: AQHT9mJJ9Oeppdx29kSrRWdMkH84gaRE6UWAgArugQCAAAZRAIAAExfA///8EwCAAGqKcIAA48AAgAAilnA=
Date: Tue, 5 Jun 2018 09:18:41 +0000
Message-ID: <9FC4315EA6BEAA449828D92CF173A10D3E3848A8@IRSMSX109.ger.corp.intel.com>
References: <20180528085841.26684-1-mb@lightnvm.io>
 <20180528085841.26684-19-mb@lightnvm.io>
 <54B2CCDB-B869-4087-8AE2-2AC73381B1FF@cnexlabs.com>
 <9FC4315EA6BEAA449828D92CF173A10D3E382351@IRSMSX109.ger.corp.intel.com>
 <3B216FC2-D5EB-4A36-8946-27307DA3D1B1@cnexlabs.com>
 <9FC4315EA6BEAA449828D92CF173A10D3E3833ED@IRSMSX109.ger.corp.intel.com>
 <3A87DF02-6471-4B92-9DDC-4E0FD98249A4@cnexlabs.com>
 <9FC4315EA6BEAA449828D92CF173A10D3E38365C@IRSMSX109.ger.corp.intel.com>
 <B1C611B8-2753-48CF-BF7E-74FD3A2D4CFD@cnexlabs.com>
In-Reply-To: <B1C611B8-2753-48CF-BF7E-74FD3A2D4CFD@cnexlabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGEyODhjNDEtYTU3NC00OTdmLTgwZGUtZDE4ZDA5MGM5YjA4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVzNhaFBHVm45Q05FbHJCSWNMMlRxeTJYa2pFT0NsZkduZ3oyVmI5a3dhZ2ZvWnlWTTNtRTc1clgxeWVzQXpRZSJ9
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w559Iskh028863

> From: Javier Gonzalez [mailto:javier@cnexlabs.com]
> Sent: Tuesday, June 5, 2018 9:12 AM
> To: Dziegielewski, Marcin <marcin.dziegielewski@intel.com>
> Cc: Matias Bjørling <mb@lightnvm.io>; Jens Axboe <axboe@fb.com>; linux-
> block@vger.kernel.org; linux-kernel@vger.kernel.org; Konopko, Igor J
> <igor.j.konopko@intel.com>
> Subject: Re: [GIT PULL 18/20] lightnvm: pblk: handle case when mw_cunits
> equals to 0
> 
> > On 4 Jun 2018, at 19.17, Dziegielewski, Marcin
> <marcin.dziegielewski@intel.com> wrote:
> >
> >> From: Javier Gonzalez [mailto:javier@cnexlabs.com]
> >> Sent: Monday, June 4, 2018 1:16 PM
> >> To: Dziegielewski, Marcin <marcin.dziegielewski@intel.com>
> >> Cc: Matias Bjørling <mb@lightnvm.io>; Jens Axboe <axboe@fb.com>;
> >> linux- block@vger.kernel.org; linux-kernel@vger.kernel.org; Konopko,
> >> Igor J <igor.j.konopko@intel.com>
> >> Subject: Re: [GIT PULL 18/20] lightnvm: pblk: handle case when
> >> mw_cunits equals to 0
> >>
> >>
> >>> On 4 Jun 2018, at 13.11, Dziegielewski, Marcin
> >> <marcin.dziegielewski@intel.com> wrote:
> >>>> -----Original Message-----
> >>>> From: Javier Gonzalez [mailto:javier@cnexlabs.com]
> >>>> Sent: Monday, June 4, 2018 12:22 PM
> >>>> To: Dziegielewski, Marcin <marcin.dziegielewski@intel.com>
> >>>> Cc: Matias Bjørling <mb@lightnvm.io>; Jens Axboe <axboe@fb.com>;
> >>>> linux- block@vger.kernel.org; linux-kernel@vger.kernel.org;
> >>>> Konopko, Igor J <igor.j.konopko@intel.com>
> >>>> Subject: Re: [GIT PULL 18/20] lightnvm: pblk: handle case when
> >>>> mw_cunits equals to 0
> >>>>
> >>>>> On 4 Jun 2018, at 12.09, Dziegielewski, Marcin
> >>>> <marcin.dziegielewski@intel.com> wrote:
> >>>>> Frist of all I want to say sorry for late response - I was on holiday.
> >>>>>
> >>>>>> From: Javier Gonzalez [mailto:javier@cnexlabs.com]
> >>>>>> Sent: Monday, May 28, 2018 1:03 PM
> >>>>>> To: Matias Bjørling <mb@lightnvm.io>
> >>>>>> Cc: Jens Axboe <axboe@fb.com>; linux-block@vger.kernel.org;
> >>>>>> linux- kernel@vger.kernel.org; Dziegielewski, Marcin
> >>>>>> <marcin.dziegielewski@intel.com>; Konopko, Igor J
> >>>>>> <igor.j.konopko@intel.com>
> >>>>>> Subject: Re: [GIT PULL 18/20] lightnvm: pblk: handle case when
> >>>>>> mw_cunits equals to 0
> >>>>>>
> >>>>>>> On 28 May 2018, at 10.58, Matias Bjørling <mb@lightnvm.io> wrote:
> >>>>>>>
> >>>>>>> From: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
> >>>>>>>
> >>>>>>> Some devices can expose mw_cunits equal to 0, it can cause
> >>>>>>> creation of too small write buffer and cause performance to drop
> >>>>>>> on write workloads.
> >>>>>>>
> >>>>>>> To handle that, we use the default value for MLC and beacause it
> >>>>>>> covers both 1.2 and 2.0 OC specification, setting up mw_cunits
> >>>>>>> in
> >>>>>>> nvme_nvm_setup_12 function isn't longer necessary.
> >>>>>>>
> >>>>>>> Signed-off-by: Marcin Dziegielewski
> >>>>>>> <marcin.dziegielewski@intel.com>
> >>>>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> >>>>>>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
> >>>>>>> ---
> >>>>>>> drivers/lightnvm/pblk-init.c | 10 +++++++++-
> >>>>>>> drivers/nvme/host/lightnvm.c |  1 -
> >>>>>>> 2 files changed, 9 insertions(+), 2 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/drivers/lightnvm/pblk-init.c
> >>>>>>> b/drivers/lightnvm/pblk-init.c index d65d2f972ccf..0f277744266b
> >>>>>>> 100644
> >>>>>>> --- a/drivers/lightnvm/pblk-init.c
> >>>>>>> +++ b/drivers/lightnvm/pblk-init.c
> >>>>>>> @@ -356,7 +356,15 @@ static int pblk_core_init(struct pblk *pblk)
> >>>>>>> 	atomic64_set(&pblk->nr_flush, 0);
> >>>>>>> 	pblk->nr_flush_rst = 0;
> >>>>>>>
> >>>>>>> -	pblk->pgs_in_buffer = geo->mw_cunits * geo->all_luns;
> >>>>>>> +	if (geo->mw_cunits) {
> >>>>>>> +		pblk->pgs_in_buffer = geo->mw_cunits * geo-
> >>> all_luns;
> >>>>>>> +	} else {
> >>>>>>> +		pblk->pgs_in_buffer = (geo->ws_opt << 3) * geo-
> >>> all_luns;
> >>>>>>> +		/*
> >>>>>>> +		 * Some devices can expose mw_cunits equal to 0, so
> >> let's
> >>>>>> use
> >>>>>>> +		 * here default safe value for MLC.
> >>>>>>> +		 */
> >>>>>>> +	}
> >>>>>>>
> >>>>>>> 	pblk->min_write_pgs = geo->ws_opt * (geo->csecs /
> PAGE_SIZE);
> >>>>>>> 	max_write_ppas = pblk->min_write_pgs * geo->all_luns; diff
> >>>>>>> --git a/drivers/nvme/host/lightnvm.c
> >>>>>>> b/drivers/nvme/host/lightnvm.c index
> >>>>>>> 41279da799ed..c747792da915 100644
> >>>>>>> --- a/drivers/nvme/host/lightnvm.c
> >>>>>>> +++ b/drivers/nvme/host/lightnvm.c
> >>>>>>> @@ -338,7 +338,6 @@ static int nvme_nvm_setup_12(struct
> >>>>>> nvme_nvm_id12
> >>>>>>> *id,
> >>>>>>>
> >>>>>>> 	geo->ws_min = sec_per_pg;
> >>>>>>> 	geo->ws_opt = sec_per_pg;
> >>>>>>> -	geo->mw_cunits = geo->ws_opt << 3;	/* default to MLC
> >> safe values
> >>>>>> */
> >>>>>>> /* Do not impose values for maximum number of open blocks as it
> is
> >>>>>>> 	 * unspecified in 1.2. Users of 1.2 must be aware of this and
> >>>>>>> eventually
> >>>>>>> --
> >>>>>>> 2.11.0
> >>>>>>
> >>>>>> By doing this, 1.2 future users (beyond pblk), will fail to have
> >>>>>> a valid mw_cunits value. It's ok to deal with the 0 case in pblk,
> >>>>>> but I believe that we should have the default value for 1.2 either
> way.
> >>>>>
> >>>>> I'm not sure. From my understanding, setting of default value was
> >>>>> workaround for pblk case, am I right ?.
> >>>>
> >>>> The default value covers the MLC case directly at the lightnvm
> >>>> layer, as opposed to doing it directly in pblk. Since pblk is the
> >>>> only user now, you can argue that all changes in the lightnvm layer
> >>>> are to solve pblk issues, but the idea is that the geometry should be
> generic.
> >>>>
> >>>>> In my opinion any user of 1.2
> >>>>> spec should be aware that there is not mw_cunit value. From my
> >>>>> point of view, leaving here 0 (and decision what do with it to
> >>>>> lightnvm
> >>>>> user) is more safer way, but maybe I'm wrong. I believe that it is
> >>>>> topic to wider discussion with maintainers.
> >>>>
> >>>> 1.2 and 2.0 have different geometries, but when we designed the
> >>>> common nvm_geo structure, the idea was to abstract both specs and
> >>>> allow the upper layers to use the geometry transparently.
> >>>>
> >>>> Specifically in pblk, I would prefer to keep it in such a way that
> >>>> we don't need to media specific policies (e.g., set default values
> >>>> for MLC memories), as a general design principle. We already do
> >>>> some geometry version checks to avoid dereferencing unnecessary
> >>>> pointers on the fast path, which I would eventually like to remove.
> >>>
> >>> Ok, now I understand your point of view and agree with that, I will
> >>> prepare second version of this patch without this change.
> >>
> >> Sounds good.
> >>
> >>> Thanks for
> >>> the clarification.
> >>
> >> Sure :)
> >>
> >>>>>> A more generic way of doing this would be to have a default value
> >>>>>> for
> >>>>>> 2.0 too, in case mw_cunits is reported as 0.
> >>>>>
> >>>>> Since 0 is correct value and users can make different decisions
> >>>>> based on it, I think we shouldn't overwrite it by default value.
> >>>>> Is it make sense?
> >>>>
> >>>> Here I meant at a pblk level - I should have specified it. At the
> >>>> geometry level, we should not change it.
> >>>>
> >>>> The case I am thinking is if mw_cuints repoints 0, but ws_min > 0.
> >>>> In this case, we still need a host side buffer to serve < ws_min
> >>>> I/Os, even though the device does not require the buffer to guarantee
> reads.
> >>>
> >>> Oh, ok now we are on the same page. In this patch I was trying to
> >>> address such case. Do you have other idea how to do it or here are
> >>> you thinking only on value of default variable?
> >>
> >> If doing this, I guess that something in the line of what you did
> >> with increasing the size of the write buffer via a module parameter.
> >> For example, checking if the size of the write buffer based on
> >> mw_cuints is enough to cover ws_min, which normally would only be an
> >> issue when mw_cuints == 0 or when the number of PUs used for the pblk
> >> instance is very small and mw_cuints < nr_luns * ws_min.
> >
> >
> > I see here two cases:
> > - when mw_cunits > 0 buffer size should have number of entries at
> > least max(mw_cunits, ws_min) * nr_luns and here we are taking care of
> > both cases mw_cunits > ws_min and mw_cunits < ws_min.
> > - when mw_cunit == 0 buffer size should have number of entries at
> > least ws_min * nr _luns and we can use the same puseudocode as above.
> >
> 
> Agree.
> 
> > Do you see any other case? Could you clarify second case mentioned by
> > you or maybe did you mean opposite case? If yes, I believe that above
> > pseudo code will handle such case too.
> >
> 
> Yes, it is the same case.
> 
> One thing to consider is whether the buffer should at least be ws_opt *
> nr_luns for performance reasons. Since the write thread will always try to
> send ws_opt, in the case that ws_opt > ws_min, then a buffer size of
> ws_min * nr_luns will not make use of the whole parallelism exposed by the
> device.
> 

Agree. After I had sent last email I also thought  that should be ws_opt instead of ws_min.

> Therefore, I would probably go for ws_opt * nr_luns as the default value
> when mw_cuints * nr_luns < ws_opt * nr_luns (which covers mw_cuints ==
> 0), and then keep ws_min * nr_luns as the minimum requirement when
> setting the buffer size manually.

Sounds good.
> 
> Does this cover your use case?
> 

Yes, I think that cover all cases related to this topic. I will prepare patch in the afternoon.

Many thanks for perfect cooperation!
Marcin
> >>>>>> Javier
> >>>>>
> >>>>> Thanks,
> >>>>> Marcin
> >>>>
> >>>> Javier
> >>> Thanks,
> >>> Marcin
> > Thanks!,
> > Marcin
