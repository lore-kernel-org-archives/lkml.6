Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134C5C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D442920657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="sv1ZzzcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390129AbfAOVE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:04:27 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45324 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390117AbfAOVE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:04:26 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so3840630ota.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 13:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xijxS8EHRhgCanpuwK5Kp8a1HlZ+kiUlEUQymt3Bgco=;
        b=sv1ZzzcJ9gwO0AJXdD+fNqYBypNMlknjn1VyEM80rP2pPz1+DrjtlYyLEQXfn/itGb
         qXkd7ySY+BqXpLJK0BznV5/pO5emzY/4jRacS3SMdp6x5oYiD5DaB+HduBhnGTPAf00c
         GTebvuancJt3rjS6XJBpiMQzg6rlHqcDCcyIlWgW36wmUyXOedOI/KMyCeCyVXb4AzZY
         8igSfc+qdeBduia5+xgUolF2SylEIMDC1C8ewN5UygJGW9BhmVXAVlwdBVcPbBPXebA4
         FNdgnNIqfRjVIMOQLGdIzUeWqbxDbf+pCjiVRKQ4evu19RFIt+ydSEgNYjC5EhZrKAte
         QjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xijxS8EHRhgCanpuwK5Kp8a1HlZ+kiUlEUQymt3Bgco=;
        b=aW7q683idxq0p8cOJ3/9APtFy3be/htHa8PuU81D9EM9D4KmWE5XFcGq3E6Uoe0ODR
         s3Kd8sBUnKlDLYCj2CTKI8J+XJzzcnMYepYtnOuSHSHyD2bo6851GTawYKQuCXspeoCk
         bFBCUCrqph9PyP3j4x1+1YppQAKhWmvZrdKeayxBu0Vis83xD3wTvAEQE5HHfVSof+Ot
         eGFkLfznTisICHqQOt5x1/nqi1fFW4omGPIoTG8EakFpZ5qOrDr02hSJtFflvOPfwds8
         u8MmJo6MEC41xQquzhx6jhXAV/LcZSL9s1KGXmWU/XP3E2rfLkjetKi4bEZpmESvU5gF
         pHog==
X-Gm-Message-State: AJcUukfJMICxft+AKb5TcX3TIA7DwrbIXkyktY+9pXbFf3lK42hNjkFR
        bN4DYDtiNvN6Zr56Oc1C6dSqZpRb8IvvJ0SapgHWZA==
X-Google-Smtp-Source: ALg8bN6L0sVDzCGS8xKp7L/CRrjwVajvxGGpZq0aZZmJhIv0tX+f4x7BUtTN2b3bTK/6XorHaqC81KYgkmTwnURUe1o=
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr3462550oti.367.1547586265511;
 Tue, 15 Jan 2019 13:04:25 -0800 (PST)
MIME-Version: 1.0
References: <154751742416.1617064.8252289468130584022.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49tvia80r0.fsf@segfault.boston.devel.redhat.com> <CAPcyv4htfew=7D_B1QDGTwSkMTx7BK2BZ+Gq+9UL1NTtqtL9FQ@mail.gmail.com>
 <x49k1j57j0u.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49k1j57j0u.fsf@segfault.boston.devel.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Jan 2019 13:04:13 -0800
Message-ID: <CAPcyv4hxApv62QiLVvtwRY3cgdYhqewCux6odybKA=TR8yDZsQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] acpi/nfit: Fix command-supported detection
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        stable <stable@vger.kernel.org>,
        stuart hayes <stuart.w.hayes@gmail.com>,
        Sujith Pandel <sujith_pandel@dell.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 12:39 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > On Tue, Jan 15, 2019 at 6:16 AM Jeff Moyer <jmoyer@redhat.com> wrote:
> >>
> >> Dan Williams <dan.j.williams@intel.com> writes:
> >>
> >> > Changes since v1 [1]:
> >> > * Include another patch make sure that function-number zero can be
> >> >   safely used as an invalid function number (Jeff)
> >> > * Add a comment clarifying why zero is an invalid function number (Jeff)
> >> > * Pass nfit_mem to cmd_to_func() (Jeff)
> >> > * Collect a Tested-by from Sujith
> >> > [1]: https://lists.01.org/pipermail/linux-nvdimm/2019-January/019435.html
> >>
> >> For the series:
> >>
> >> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
> >>
> >> Thanks, Dan!
> >
> > Thanks, although I just realized one more change. The ND_CMD_CALL case
> > should zero out command after the function translation, otherwise
> > userspace can call functions that the kernel is blocking in the
> > dsm_mask.
> >
> > Holler if this invalidates your "Reviewed-by".
>
> AAAAAAAHHHHHHHHHH!!!!
>
> :)
>
> > diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> > index 87e02f281e51..d7747aceb7ab 100644
> > --- a/drivers/acpi/nfit/core.c
> > +++ b/drivers/acpi/nfit/core.c
> > @@ -463,6 +463,12 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor
> > *nd_desc, struct nvdimm *nvdimm,
> >                 func = cmd_to_func(nfit_mem, cmd, buf);
> >                 if (func < 0)
> >                         return func;
> > +               /*
> > +                * In the ND_CMD_CALL case we're now dependent on 'func'
> > +                * being validated by the dimm's dsm_mask
> > +                */
> > +               if (cmd == ND_CMD_CALL)
> > +                       cmd = 0;
> >                 dimm_name = nvdimm_name(nvdimm);
> >                 cmd_name = nvdimm_cmd_name(cmd);
> >                 cmd_mask = nvdimm_cmd_mask(nvdimm);
>                 dsm_mask = nfit_mem->dsm_mask;
>                 desc = nd_cmd_dimm_desc(cmd);
>
> That sure doesn't look right.  Now cmd_name and desc will be wrong.

Ah, whoops, yes good catch. Guess this shows there is not good
ND_CMD_CALL coverage in the unit tests...

>
> > @@ -477,8 +483,10 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor
> > *nd_desc, struct nvdimm *nvdimm,
> >                 cmd_name = nvdimm_bus_cmd_name(cmd);
> >                 cmd_mask = nd_desc->cmd_mask;
> >                 dsm_mask = cmd_mask;
> > -               if (cmd == ND_CMD_CALL)
> > +               if (cmd == ND_CMD_CALL) {
> >                         dsm_mask = nd_desc->bus_dsm_mask;
> > +                       cmd = 0;
> > +               }
> >                 desc = nd_cmd_bus_desc(cmd);
>
> And again here.
>
> We could reorder the zeroing, or you could modify the check for a valid
> comand/function.  Something like this?
>
>         /*
>          * Check for a valid command.  For ND_CMD_CALL, we also
>          * have to make sure that the DSM function is supported.
>          */
>         if (cmd == ND_CMD_CALL && !test_bit(func, &dsm_mask))
>                 return -ENOTTY;
>         else if (!test_bit(cmd, &cmd_mask))
>                 return -ENOTTY;
>
> Which way do you think is cleaner?

Modifying the check looks cleaner. Thanks for hollering!
