Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF228C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513C520848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIcKoZ9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513C520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeJZHa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:30:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44613 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeJZHa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:30:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id q6-v6so10922376wrw.11;
        Thu, 25 Oct 2018 15:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HfvX3f3+e+LJpOOzD1n6AgdpwxK9IL41urjheTXTGCo=;
        b=jIcKoZ9cnwbaS/HPhipQF3effiPB9qsKrqljPvO18ikIzp0kizsmTcqBjyeaswLIUi
         E71MRwJHWXaZncWAV4cJ7rwdWg1gAdxUxA5Fe1ft/NE/C/jdOb9PWcSp1UuD6/8i+qXo
         eCWjGUEeRBYG3S9pujZplhpr7Y2H+1xMVXrs42Qr/KYTK6wZxe08l9B0GIlUhr6coB2p
         5LPUi6pW1+gl4xKWMyqECV1XP16SNHsB1tvtQdf4OZ4A+Tozo0RV5jHCX6aHYIYrRQg5
         MiyH2Pd7ZZHmCcP0xB2kLM9BClcVDNXKpwJh+y9z8hGOCXAeViObgaqCM4QbUeQY6GP0
         3Edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HfvX3f3+e+LJpOOzD1n6AgdpwxK9IL41urjheTXTGCo=;
        b=iaBbWXSFUyD8+4dFh9GuYDeTtM2xZbA2yFUM3F7FDeKByO53/pqtnn12lYiXya9mF6
         HcZqGMPZAKCiE+YDqcXQDPrYLY9PFh4ho3OjdDxuGAQDn7tmB4nls4pHHP46j8bBS8NM
         4KBv1ozD6ENePXgRnEpxz59jsehre3+cNLuW9fXfkBDYOtDOYoa194NgrvldnxVfv2Bh
         /4ktAuwAEj+EjOFM7e2sr9FsDn+TIkTiTEIAIdLwwNNUNc8UsC5nhTkJM57aPnre8BhU
         o/evvkzbnWS3tH2Jxd+oWxtSl5b4n0W/lTMqVBeQl6a8uCc5ihPY2dlyYoqJVlYy/Qt4
         14Hg==
X-Gm-Message-State: AGRZ1gKbcGbQf1Hdt0U2xy50w7fqFDWG40VuKVKVluxyX97Z/PtJVo3V
        unWJiFI5WJo1ysXaG56LWRs=
X-Google-Smtp-Source: AJdET5eonFVZCz1MALGkPnOceX7+vEtOahYgM+9PSYJhvlTYmsIr91L7+2PD/193DMGUId2h4HsNjg==
X-Received: by 2002:adf:d845:: with SMTP id k5-v6mr3753499wrl.7.1540508151681;
        Thu, 25 Oct 2018 15:55:51 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id y141-v6sm4253390wme.10.2018.10.25.15.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 15:55:50 -0700 (PDT)
Date:   Thu, 25 Oct 2018 15:55:48 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     bvanassche@acm.org, ooo@electrozaur.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
Message-ID: <20181025225548.GA10326@flashbox>
References: <20180930205448.26205-1-natechancellor@gmail.com>
 <10b12992-3570-4646-374b-82cbd7276839@acm.org>
 <CAKwvOd=wgxB69dMxzMeH2edCn=TdQGPGkNVW1e=QHPTJtO9ZNw@mail.gmail.com>
 <1538503063.193396.6.camel@acm.org>
 <CAKwvOdmsNEexQL9R8rgcRcXTZButYM6YWwG8bhVWCoJ8bOqCrA@mail.gmail.com>
 <1538521591.193396.8.camel@acm.org>
 <20181025213144.GB24709@flashbox>
 <CAKwvOdn=TvoGdFvgxX6TyXBXnhVLttriRrZEnzS6DjcjL64DPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdn=TvoGdFvgxX6TyXBXnhVLttriRrZEnzS6DjcjL64DPA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 03:02:13PM -0700, Nick Desaulniers wrote:
> On Thu, Oct 25, 2018 at 2:31 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Tue, Oct 02, 2018 at 04:06:31PM -0700, Bart Van Assche wrote:
> > > On Tue, 2018-10-02 at 15:33 -0700, Nick Desaulniers wrote:
> > > > On Tue, Oct 2, 2018 at 10:57 AM Bart Van Assche <bvanassche@acm.org> wrote:
> > > > > Explicitly initialized global and static variables end up in the .data
> > > > > section and need space in that section.
> > > >
> > > > Unless the initial value is zero.
> > > > https://godbolt.org/z/curRoO
> > > >
> > > > So you don't wind up with an increase in binary size simply by having
> > > > global variables initialized to zero, right?  Instead the kernel knows
> > > > to create a zero'd out mapping for bss.  You don't need a run of zeros
> > > > in the binary.
> > > >
> > > > So I disagree when you said earlier "zero initializers should be left
> > > > out to minimize the size of object files." I assert they don't affect
> > > > the size of the binary.
> > > >
> > > > If you had many global variables all initialized to zero, why would
> > > > you encode that many zeros in a binary, when you can just set a size
> > > > on the bss section and have the kernel create the appropriate sized
> > > > and zero'd mapping?
> > > >
> > > > > That is not the case if the
> > > > > initializer is left out and these variables end up in the .bss section.
> > > >
> > > > From my above link, gcc will put globals without initializers into "common."
> > >
> > > No matter what particular compiler versions do with explicit initialization
> > > to zero, the preferred kernel coding style is to leave out such explicit
> > > initialization.
> > >
> > > Bart.
> >
> > Hi Bart,
> >
> > I'm sorry if I didn't follow the conclusion of this conversation properly
> > but this is the below diff you were initially looking for, correct?
> >
> > If so, Boaz and Nick, do you have any objections if this is v2? I'd like
> > to get this patch accepted so the warning can be fixed for everyone.
> 
> Hi Nathan,
> Thanks for following up on this.  Bart's note about the one definition
> rule is important.  If you define the variable static in two different
> translation units, you've suddenly created two different copies
> accessible only to their respective translation units.  So it should
> be declared extern in one source file (but not defined/initialized),
> and defined (non-static) in another.  See below for example.
> 

Hi Nick,

I just want to make sure I understand what is going on here.

Doesn't the first part already happen because osd_root_object is
declared static in osd_types.h? I tried this little simple example of
adding a 'static const' variable to a header file and using it in two
separate files/functions. When compiled together, they point to two
different locations in memory.

==============================================

$ clang -std=gnu89 main.c test1.c test2.c
$ ./a.out
test in test1(): 0x55b4df3a001c
test in test2(): 0x55b4df3a003c

==============================================

main.c:

#include "test.h"

int main(void) {
        test1();
        test2();
}

==============================================

test1.c:

#include <stdio.h>
#include "test.h"

void test1() {
    printf("test in test1(): %p\n", &test);
}

==============================================

test2.c:

#include <stdio.h>
#include "test.h"

void test2() {
    printf("test in test2(): %p\n", &test);
}

==============================================

test.h:

struct test_struct {
    int a;
    int b;
};

static const struct test_struct test = {0, 0};
void test1();
void test2();

==============================================

If that is the case, could your suggested change result in a functional
change given that the code would now refer to the same osd_root_object?
This isn't necessarily a problem, especially since it sounds like not
referring to the same object could be a bug, but I want to make sure
that's what is intended by these changes, which I'll be happy to spin up
in a v2.

If I am thinking about this incorrectly or my example is wrong in any
way, please let me know. I'm trying to soak up all of this knowledge
so I can be a better contributor.

Thanks for the reply and explanation!
Nathan

> >
> > Thanks,
> > Nathan
> >
> > ================================================================================
> >
> > diff --git a/drivers/scsi/osd/osd_initiator.c b/drivers/scsi/osd/osd_initiator.c
> > index e19fa883376f..4250f739beb3 100644
> > --- a/drivers/scsi/osd/osd_initiator.c
> > +++ b/drivers/scsi/osd/osd_initiator.c
> > @@ -58,6 +58,8 @@
> >
> >  enum { OSD_REQ_RETRIES = 1 };
> >
> > +static const struct osd_obj_id osd_root_object;
> 
> extern const struct osd_obj_id osd_root_object;
> 
> > +
> >  MODULE_AUTHOR("Boaz Harrosh <ooo@electrozaur.com>");
> >  MODULE_DESCRIPTION("open-osd initiator library libosd.ko");
> >  MODULE_LICENSE("GPL");
> > diff --git a/drivers/scsi/osd/osd_uld.c b/drivers/scsi/osd/osd_uld.c
> > index eaf36ccf58db..770c758baaa9 100644
> > --- a/drivers/scsi/osd/osd_uld.c
> > +++ b/drivers/scsi/osd/osd_uld.c
> > @@ -73,6 +73,7 @@
> >
> >  static const char osd_name[] = "osd";
> >  static const char *osd_version_string = "open-osd 0.2.1";
> > +static const struct osd_obj_id osd_root_object;
> 
> const struct osd_obj_id osd_root_object;
> 
> >
> >  MODULE_AUTHOR("Boaz Harrosh <ooo@electrozaur.com>");
> >  MODULE_DESCRIPTION("open-osd Upper-Layer-Driver osd.ko");
> > diff --git a/include/scsi/osd_types.h b/include/scsi/osd_types.h
> > index 48e8a165e136..eb31357ec8b3 100644
> > --- a/include/scsi/osd_types.h
> > +++ b/include/scsi/osd_types.h
> > @@ -28,8 +28,6 @@ struct osd_obj_id {
> >         osd_id id;
> >  };
> >
> > -static const struct __weak osd_obj_id osd_root_object = {0, 0};
> > -
> 
> LGTM
> 
> >  struct osd_attr {
> >         u32 attr_page;
> >         u32 attr_id;
> 
> That way the linker knows there's only one instance of this struct in
> memory, and that the two different translation units are referring to
> the same instance.  The other maintainers may have a preference which
> translation you define osd_root_object in (I arbitrarily chose
> drivers/scsi/osd/osd_uld.c), but if they don't have additional
> feedback after some amount of time, I'd assume they're ok with the
> above suggestion.  What do you think?
> 
> -- 
> Thanks,
> ~Nick Desaulniers
