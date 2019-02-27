Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2719BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F1C213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbfB0PRe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 10:17:34 -0500
Received: from 1.mo69.mail-out.ovh.net ([178.33.251.173]:37969 "EHLO
        1.mo69.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbfB0PRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 10:17:34 -0500
X-Greylist: delayed 4691 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Feb 2019 10:17:33 EST
Received: from player168.ha.ovh.net (unknown [10.109.146.5])
        by mo69.mail-out.ovh.net (Postfix) with ESMTP id 1A7D545757
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 14:59:21 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player168.ha.ovh.net (Postfix) with ESMTPSA id 6D27030E2BBE;
        Wed, 27 Feb 2019 13:59:12 +0000 (UTC)
Date:   Wed, 27 Feb 2019 14:59:11 +0100
From:   Greg Kurz <groug@kaod.org>
To:     Frederic Barrat <fbarrat@linux.ibm.com>
Cc:     Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        "Alastair D'Silva" <alastair@d-silva.org>,
        "'Alastair D'Silva'" <alastair@au1.ibm.com>,
        "'Arnd Bergmann'" <arnd@arndb.de>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] ocxl: Rename struct link to ocxl_link
Message-ID: <20190227145911.60859bbb@bahia.lan>
In-Reply-To: <13209edc-d027-4d2f-668b-ad969a25eb06@linux.ibm.com>
References: <20190227045741.21412-1-alastair@au1.ibm.com>
        <20190227045741.21412-2-alastair@au1.ibm.com>
        <8c0300fc-4319-bd66-a47e-4ffda6ac795c@au1.ibm.com>
        <156e01d4ce6e$ee42d9f0$cac88dd0$@d-silva.org>
        <a36b088b-b8d7-8725-50db-6aad58672784@au1.ibm.com>
        <158101d4ce73$11ff4550$35fdcff0$@d-silva.org>
        <97ad5218-4876-956e-e6ef-fb3449eca68e@au1.ibm.com>
        <13209edc-d027-4d2f-668b-ad969a25eb06@linux.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Ovh-Tracer-Id: 10932488099000326501
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrvddugdehlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019 14:45:44 +0100
Frederic Barrat <fbarrat@linux.ibm.com> wrote:

> Le 27/02/2019 à 09:18, Andrew Donnellan a écrit :
> > On 27/2/19 7:04 pm, Alastair D'Silva wrote:  
> >>> -----Original Message-----
> >>> From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> >>> Sent: Wednesday, 27 February 2019 6:55 PM
> >>> To: Alastair D'Silva <alastair@d-silva.org>; 'Alastair D'Silva'
> >>> <alastair@au1.ibm.com>
> >>> Cc: 'Greg Kurz' <groug@kaod.org>; 'Frederic Barrat'
> >>> <fbarrat@linux.ibm.com>; 'Arnd Bergmann' <arnd@arndb.de>; 'Greg Kroah-
> >>> Hartman' <gregkh@linuxfoundation.org>; linuxppc-dev@lists.ozlabs.org;
> >>> linux-kernel@vger.kernel.org
> >>> Subject: Re: [PATCH 1/5] ocxl: Rename struct link to ocxl_link
> >>>
> >>> On 27/2/19 6:34 pm, Alastair D'Silva wrote:>>> diff --git
> >>> a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c index  
> >>>>>> e6a607488f8a..16eb8a60d5c7 100644
> >>>>>> --- a/drivers/misc/ocxl/file.c
> >>>>>> +++ b/drivers/misc/ocxl/file.c
> >>>>>> @@ -152,7 +152,7 @@ static long afu_ioctl_enable_p9_wait(struct
> >>>>>> ocxl_context *ctx,
> >>>>>>
> >>>>>>             if (status == ATTACHED) {
> >>>>>>                 int rc;
> >>>>>> -            struct link *link = ctx->afu->fn->link;
> >>>>>> +            void *link = ctx->afu->fn->link;  
> >>>>>
> >>>>> This doesn't look like a rename...  
> >>>>
> >>>> That corrects the type to what the member (and prototype for  
> >>> ocxl_link_update_pe) declare it as.  
> >>>>
> >>>> The struct link there is bogus, it shouldn't even compile (since the 
> >>>> intended  
> >>> struct link is defined in a different compilation unit), but instead 
> >>> picks up a
> >>> different definition of 'struct link' from elsewhere.  
> >>>>  
> >>>
> >>> Given there's only a handful of struct links defined across the 
> >>> entire kernel,
> >>> I'm going to guess that the definition it's picking up is in fact the 
> >>> ocxl one.
> >>>  
> >>
> >> Unlikely, since that's never in a header. It wasn't caught since it 
> >> was assigned to/from a void*.  
> > 
> > Ah, yeah that'd explain it... and it's a pointer so it never needs to 
> > know its size. I'm clearly not very good at C.
> >   
> >>  
> >>> I think the better solution here is to move struct ocxl_link into
> >>> ocxl_internal.h, change ocxl_fn::link to be struct ocxl_link * rather 
> >>> than void
> >>> *, and update the function signature for ocxl_link_update_pe() as well.  
> >> Not move it, but we could have an opaque declaration there.
> >>  
> > 
> > Putting it there would fit with all the other ocxl_* structs, but either 
> > way, we definitely need a declaration in there and get rid of the void*, t  
> 
> 
> Mmm, it might turn out to be more invasive that planned...
> The point was only to have it as an opaque to the outside world, for 
> APIs we'd like to deprecate at some point, so I wouldn't sweat too much 
> over it.
> 

I concur. And even if an API change turns out to be beneficial, it
clearly belongs to some other patch/series. Hence my proposal to
simply drop that controversial and unneeded link variable in
afu_ioctl_enable_p9_wait().

>    Fred
> 

