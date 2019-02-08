Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE90FC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B609820863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pndu+8wn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfBHSlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:41:24 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:36776 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfBHSlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:41:24 -0500
Received: by mail-vk1-f196.google.com with SMTP id m13so1057165vkk.3;
        Fri, 08 Feb 2019 10:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Le/DZACXPOlmol6khm3F06DRG7ay1idhlfXwfW1ZEMk=;
        b=pndu+8wnUAdXPKkfLXDiLr/cAPsYrak1QxEtgTgs0dR4+udw2Nc9B4T85/KCdrw74P
         F8cITFN22VvYVFe/GkLIjwGX4N0ntpGnUEMPWLDdC/r3ai+4514fIlQqmdkr/YjC4nNM
         UY2rlgMOOslUdx4xdywZisgzWzFYEunky85ePWPNHyBbTqFB+WyiV0fur/8c54nY602N
         MJ+AgE9ps9nKGAgQ+XgZbV7YwD8dAmzrIQVRhXmDoSNBFjF2h7suC0rMfJ2uhZ9fZCjB
         mLbUBmqCqdwOLg6rjt5P4hGyAh7EdmJd6XKpb3b2AIn/j28+fSM2feEqje5kYf9Htump
         3U4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Le/DZACXPOlmol6khm3F06DRG7ay1idhlfXwfW1ZEMk=;
        b=p+YZmkmjtPXa+YHOw7dJUote3lCIEEY3TJUZae8ULcoBeoC2xkbFgc2HoKMZUgDjWJ
         e+NfS1M66ImyB5H9A2CtH4Kqb0/oulNY4AjaTMTk5iwfCGm8GCPaEeFMKLe+4rzASK6s
         2YjHtIInsLBAQZuZdWeQs88Sa2kpdheEgKbks62ccXNO+DEz+g6IoOL4d1PEXnm8F4j4
         I+NT6ObqozaDh/7gVrKOOAfIhXir9dba/pp68VNUeGFqFpme7ZVEFVZ4QTHDoYhbR/Pz
         uFEaX/YtwIi1YRO0gfLcXR/QTLAFWic4FANCi/kjXHlCRwShYCE5xObvAIbS+fnyEl9K
         ZLEg==
X-Gm-Message-State: AHQUAuaWvIwfUzvT3gbu3Tx8W10zn2UpmbttrhjmDyRoUCbIqAGqcPUQ
        ZfTc6PhE0eHy69wH0D131wZJ8C+gv+myI22PHr0=
X-Google-Smtp-Source: AHgI3IYHGr+o0NUKePxeZsehtN/DTNzTxzJ+0D2pG6DtNeEfaZdwhtuqzEjd+Lm/EzvgInoClq3oSe5CKFxCSXqXyT4=
X-Received: by 2002:a1f:d1c3:: with SMTP id i186mr9345380vkg.51.1549651282971;
 Fri, 08 Feb 2019 10:41:22 -0800 (PST)
MIME-Version: 1.0
References: <20190114191724.29960-1-alamy.liu@gmail.com> <ee3dc963-53f0-e362-caa5-069ce0e6eae7@intel.com>
 <CAJ3kudsgJsZ1KFXdD9Vnfx0GypnEf+ba-D8t+Wy1e8GdLF=U0w@mail.gmail.com>
 <362c073b-d795-4431-f1dd-c203cc606a6f@codeaurora.org> <dcf57693-3daf-8277-53e9-1c4b094f2449@codeaurora.org>
In-Reply-To: <dcf57693-3daf-8277-53e9-1c4b094f2449@codeaurora.org>
From:   Alamy Liu <alamy.liu@gmail.com>
Date:   Fri, 8 Feb 2019 10:41:11 -0800
Message-ID: <CAJ3kuds-XgrhjiyS8j-5twOHde3NHsGaH5hFqeOm8HLXHi59aA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: cqhci: replace NUM_SLOTS with cq_host->num_slots
To:     "Asutosh Das (asd)" <asutoshd@codeaurora.org>,
        Ritesh Harjani <riteshh@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IP I'm using has fixed 32 slots for CQ once CQE is enabled in RTL.
There is no other RO register to say the slot number & which slot that
DCMD would use.

I agree that most host controller would have 32 slots for CQ, and use
the last one for DCMD if enabled (easier design & save gates
count/size). (15th for DCMD if there were 16 slots in CQ, ...etc). It
also doesn't make sense to use a slot in the middle of slots for DCMD,
Both the code (both S.W. & H.W.) would become more complicated.
Although I don't see it is defined somewhere, I believe that every
designer would follow.
(H.W.: increasing gate count -> increasing die size -> increase $;
complicated design -> higher chance to have bug/error).
(H.W.: SDHC cq_depth: longer cq_depth -> more memory -> more $. The
decision would be the trade off between $ & performance. Also, the
SDHC is not necessary to be used in Cortex-A/Linux. Thus, 16/8
cq_depth is possible, although I don't know if there is one existed
out there)

Another thinking: If all cq_depth is fixed to 32, the mmc driver core
doesn't even have to detect the cq_depth and eventually choose the
small one between HC & eMMC (queue.c::mmc_init_queue)

Best Regards


On Fri, Feb 8, 2019 at 2:34 AM Asutosh Das (asd)
<asutoshd@codeaurora.org> wrote:
>
> On 2/8/2019 8:07 AM, Ritesh Harjani wrote:
> > Hi Alamy,
> >
> > On 2/8/2019 1:00 AM, Alamy Liu wrote:
> >> It says in B.2.1 in the JESD84-B51.pdf (I don't have JESD84-B51A.pdf):
> >>
> >>     /The TDL is located in a memory location known to the CQE, and is
> >>     comprised of up to 32 fixed-size slots. Each slot is comprised of
> >>     one Task Descriptor and one Transfer Descriptor./
> >>
> >>
> >> So if the IP has 16 slots, it should still meet the specification.
> >> Then the configuration could be moved to DTS, maybe:
> >>
> >>     cqhci-slotnum = <16>;
> >>
> >>     cqhci-dcmd-slotno = <15>;
> >>
> > Does your IP defines this as 16 slots & DCMD slot to be 15?
> > Because if there is a deviation then IP may also define num_slots by
> > using some reserved registers.
> > Also in JESD84-B51.pdf, specific slot no. is used extensively for
> > defining policies(like in case of DCMD & CQCFG), so in that case
> > defining via DT may not be that helpful.
> > Unless there is no other way in your IP to determine the num_slots
> > except going via DT?
> >
> > Let others also provide an opinion here.
> >
> > Regards
> > Ritesh
> >
> >
> >>
> >> Please comment.
> >>
> >> Regards,
> >> Alamy
> >>
> >>
> >>
> >> On Thu, Jan 31, 2019 at 1:34 AM Adrian Hunter <adrian.hunter@intel.com
> >> <mailto:adrian.hunter@intel.com>> wrote:
> >>
> >>     On 14/01/19 9:17 PM, Alamy Liu wrote:
> >>     > Prevent to use fixed value (NUM_SLOTS) after it had been determined
> >>     > and saved in a variable (cq_host->num_slots).
> >>
> >>     num_slots is always 32 (i.e. NUM_SLOTS) so why not go the other
> >>     way and get
> >>     rid of num_slots and just use NUM_SLOTS?
> >>
> >>     >
> >>     > Signed-off-by: Alamy Liu <alamy.liu@gmail.com
> >>     <mailto:alamy.liu@gmail.com>>
> >>     > ---
> >>     >  drivers/mmc/host/cqhci.c | 2 +-
> >>     >  1 file changed, 1 insertion(+), 1 deletion(-)
> >>     >
> >>     > diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> >>     > index 159270e947..26d63594b7 100644
> >>     > --- a/drivers/mmc/host/cqhci.c
> >>     > +++ b/drivers/mmc/host/cqhci.c
> >>     > @@ -699,7 +699,7 @@ static void cqhci_error_irq(struct mmc_host
> >>     *mmc, u32 status, int cmd_error,
> >>     >                * The only way to guarantee forward progress is
> >>     to mark at
> >>     >                * least one task in error, so if none is
> >>     indicated, pick one.
> >>     >                */
> >>     > -             for (tag = 0; tag < NUM_SLOTS; tag++) {
> >>     > +             for (tag = 0; tag < cq_host->num_slots; tag++) {
> >>     >                       slot = &cq_host->slot[tag];
> >>     >                       if (!slot->mrq)
> >>     >                               continue;
> >>     >
> >>
> Is it worth exploring to tie up the TDL memory allocations with the
> queue-depth? Because the queue-depth may vary with vendor; in most host
> controllers the slot size is 32. And since memory allocations are done
> on the basis of host slot size there's unused slots in the case of card
> advertising less than 32 queue-depth.
> The tricky part would be the DCMD handling though.
>
> In the IP in question, what slot is assigned to DCMD?
>
>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
> Linux Foundation Collaborative Project
