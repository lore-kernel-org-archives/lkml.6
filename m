Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B6DC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9917620834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TOfmrMEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9917620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeJZGgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:36:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43870 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeJZGgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:36:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id n10-v6so3925637pgv.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 15:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Qz3blf9kx56VXsxZmbsfPREzyctFc7Vdd+3BA0nHYY=;
        b=TOfmrMEvTdiQlIo/925WRtxDnV8D5JeN39VETCNffi0wJXhagrFUqkzMo2Wi1UbF6a
         5B7zniHfQZGW0sCXD635uLkVN7BiZjpiBAMvowUx1b+K/kJJ+tPNJUliWIxYKW5JyxSY
         8YkZcBeP3yBP9Tf1ZbhUN4X6UCrupQybfpFxy0Oh2TkNjwAMSU6/Xhpxk7OD04dUWBVW
         HnCigLkQjTSd4DotT+2G5Q/sht02eyEUA043gvJ+bT7+rJePoWvQNhoX49Mz1bRdxOW2
         FDrDixpCQHBejHD1KQEmqehfY5rpLMtweZ8Mplp2A2M+we0H9R/+Ft45wqVSOMb3KP71
         qsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Qz3blf9kx56VXsxZmbsfPREzyctFc7Vdd+3BA0nHYY=;
        b=RY68hVNxRjbnR6fRlgkv2FLbl/0VQd2fkfqPwcJuE0IgofFJVvn1aEpTgpBSyyKHgg
         b4U4Xg6b+lD1HDExFSinTFjOvVDnQCWbVe1crI31WdJhikNrCdOb0q0P4ikLXLVOEfsJ
         dq7RBlbRT90l9af8q30Ngb5HqIIbYVbz04EnTsdiYIlzmecMN7aNWi8IKzpQjoaAu/py
         70hk6Je+G06IBZLGpSKrgTar/fm4+VPTarsqSu1vFk76dhfRkmlYnmCznHkyf1MddFVU
         WHi8UzDmf+8HZPhxT95PeSllRAy3qTsIZbZe9zmZrSL08BRdEUEZL1Ig1J4wbtt7q3DE
         KQMA==
X-Gm-Message-State: AGRZ1gIEFZ5pMNq+mIRvjCwiJ698edbXk9I10pURokWGydPK+j194CJu
        RiJ9OQbtmT68Q0W6m02Lnjr88B9fDcyT8jJirJLZLA==
X-Google-Smtp-Source: AJdET5dK9Qqq/0aAG7V8DikmYxT1ph5x0WMg1BRwza/KinJxtLZB5x+k+IHYeZW83nOBHaeFk4EGDKKSsxK6Ywv7wyk=
X-Received: by 2002:a65:4683:: with SMTP id h3mr818846pgr.225.1540504945393;
 Thu, 25 Oct 2018 15:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180930205448.26205-1-natechancellor@gmail.com>
 <10b12992-3570-4646-374b-82cbd7276839@acm.org> <CAKwvOd=wgxB69dMxzMeH2edCn=TdQGPGkNVW1e=QHPTJtO9ZNw@mail.gmail.com>
 <1538503063.193396.6.camel@acm.org> <CAKwvOdmsNEexQL9R8rgcRcXTZButYM6YWwG8bhVWCoJ8bOqCrA@mail.gmail.com>
 <1538521591.193396.8.camel@acm.org> <20181025213144.GB24709@flashbox>
In-Reply-To: <20181025213144.GB24709@flashbox>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 25 Oct 2018 15:02:13 -0700
Message-ID: <CAKwvOdn=TvoGdFvgxX6TyXBXnhVLttriRrZEnzS6DjcjL64DPA@mail.gmail.com>
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     bvanassche@acm.org, ooo@electrozaur.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 2:31 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Tue, Oct 02, 2018 at 04:06:31PM -0700, Bart Van Assche wrote:
> > On Tue, 2018-10-02 at 15:33 -0700, Nick Desaulniers wrote:
> > > On Tue, Oct 2, 2018 at 10:57 AM Bart Van Assche <bvanassche@acm.org> wrote:
> > > > Explicitly initialized global and static variables end up in the .data
> > > > section and need space in that section.
> > >
> > > Unless the initial value is zero.
> > > https://godbolt.org/z/curRoO
> > >
> > > So you don't wind up with an increase in binary size simply by having
> > > global variables initialized to zero, right?  Instead the kernel knows
> > > to create a zero'd out mapping for bss.  You don't need a run of zeros
> > > in the binary.
> > >
> > > So I disagree when you said earlier "zero initializers should be left
> > > out to minimize the size of object files." I assert they don't affect
> > > the size of the binary.
> > >
> > > If you had many global variables all initialized to zero, why would
> > > you encode that many zeros in a binary, when you can just set a size
> > > on the bss section and have the kernel create the appropriate sized
> > > and zero'd mapping?
> > >
> > > > That is not the case if the
> > > > initializer is left out and these variables end up in the .bss section.
> > >
> > > From my above link, gcc will put globals without initializers into "common."
> >
> > No matter what particular compiler versions do with explicit initialization
> > to zero, the preferred kernel coding style is to leave out such explicit
> > initialization.
> >
> > Bart.
>
> Hi Bart,
>
> I'm sorry if I didn't follow the conclusion of this conversation properly
> but this is the below diff you were initially looking for, correct?
>
> If so, Boaz and Nick, do you have any objections if this is v2? I'd like
> to get this patch accepted so the warning can be fixed for everyone.

Hi Nathan,
Thanks for following up on this.  Bart's note about the one definition
rule is important.  If you define the variable static in two different
translation units, you've suddenly created two different copies
accessible only to their respective translation units.  So it should
be declared extern in one source file (but not defined/initialized),
and defined (non-static) in another.  See below for example.

>
> Thanks,
> Nathan
>
> ================================================================================
>
> diff --git a/drivers/scsi/osd/osd_initiator.c b/drivers/scsi/osd/osd_initiator.c
> index e19fa883376f..4250f739beb3 100644
> --- a/drivers/scsi/osd/osd_initiator.c
> +++ b/drivers/scsi/osd/osd_initiator.c
> @@ -58,6 +58,8 @@
>
>  enum { OSD_REQ_RETRIES = 1 };
>
> +static const struct osd_obj_id osd_root_object;

extern const struct osd_obj_id osd_root_object;

> +
>  MODULE_AUTHOR("Boaz Harrosh <ooo@electrozaur.com>");
>  MODULE_DESCRIPTION("open-osd initiator library libosd.ko");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/scsi/osd/osd_uld.c b/drivers/scsi/osd/osd_uld.c
> index eaf36ccf58db..770c758baaa9 100644
> --- a/drivers/scsi/osd/osd_uld.c
> +++ b/drivers/scsi/osd/osd_uld.c
> @@ -73,6 +73,7 @@
>
>  static const char osd_name[] = "osd";
>  static const char *osd_version_string = "open-osd 0.2.1";
> +static const struct osd_obj_id osd_root_object;

const struct osd_obj_id osd_root_object;

>
>  MODULE_AUTHOR("Boaz Harrosh <ooo@electrozaur.com>");
>  MODULE_DESCRIPTION("open-osd Upper-Layer-Driver osd.ko");
> diff --git a/include/scsi/osd_types.h b/include/scsi/osd_types.h
> index 48e8a165e136..eb31357ec8b3 100644
> --- a/include/scsi/osd_types.h
> +++ b/include/scsi/osd_types.h
> @@ -28,8 +28,6 @@ struct osd_obj_id {
>         osd_id id;
>  };
>
> -static const struct __weak osd_obj_id osd_root_object = {0, 0};
> -

LGTM

>  struct osd_attr {
>         u32 attr_page;
>         u32 attr_id;

That way the linker knows there's only one instance of this struct in
memory, and that the two different translation units are referring to
the same instance.  The other maintainers may have a preference which
translation you define osd_root_object in (I arbitrarily chose
drivers/scsi/osd/osd_uld.c), but if they don't have additional
feedback after some amount of time, I'd assume they're ok with the
above suggestion.  What do you think?

-- 
Thanks,
~Nick Desaulniers
