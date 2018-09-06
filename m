Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDD6C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480FC2077C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFIHTS7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480FC2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbeIFRCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:02:01 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43059 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbeIFRCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:02:01 -0400
Received: by mail-lf1-f66.google.com with SMTP id h64-v6so8887455lfi.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 05:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uKsWPAIK76OStsMN9gFC0NnvH4oc1u1j1aLl/Kc7scc=;
        b=LFIHTS7ifdLYaBrL76kXAOZwVoxb+BOsg02G9Jey3ljPDGQvIveHUx0BpvNXj+N3JG
         TXGgvULWzwt4xbPaRqHRRojEmpxeJsZG28IKyiIKua0Kzsgkt8r71gicrwh1QVBJ0g9b
         baGjO+wLjx7mFzDzW4CKOafq22TkIgKz6tIQzPE20etMC1iLOn1H0Q7CkdSZOmlMcq9R
         dv/kbdWklBNy2/3YFALDFgGwyemx2ArDPDivpO1oi4W7dSI0DqG2BtOVRUAr1kctX7y6
         2Nx6ZoEPq4Vl6LHoFBYWKRISwTQL/f+xV3QcYyrrcXx06AjKWjzPTA+ZsK77g03QqsyP
         k6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKsWPAIK76OStsMN9gFC0NnvH4oc1u1j1aLl/Kc7scc=;
        b=Ow3YlbMgpgt8Ub/T9sphlk02ZOHURNH+Kzbs7WOCleGPc3hn1nNwj7DQIn9OdCx7Ue
         Acon3SUkUVUNaw+3Rk/3hh2pDSnKcjtwn7m4oQ8VUPnRUydiFQiAklF1w24apDMeV0/t
         GZK2SEsgZvfbqryZVfECanK/mQ6GUG/I6ps2KQ0GyX+u5LYppmrhUnRZHD8qZJC6LEM/
         NWNl+vXOeJgNs8GXiB7NEGLDKl7OZ03LpbnXK4RgbluCyLMMSU1tseVYPoeMlt1qetM2
         RNsdZZYWRvwxvIpC19jt+2QXRiJIAIgkkKKNG0IPWLvIo4liCxW+G8XZyIR+b+r/AVEE
         WvzA==
X-Gm-Message-State: APzg51CWZ2TrGoDrPmax8+va8FZdSDXIHIz2Ef83I9MLbvRTRl318Y41
        +ZrP6fiBOVrEi6fY5FYbJomHbhGXoD61O1YVwl0=
X-Google-Smtp-Source: ANB0VdbGEansRMxpzwRLnN2IRtauhOodBuqZcXIemefmrpXV+PDKGKftULjjcEs5ZPdHOpw/rBpP3DqXpVyWzHwFS4c=
X-Received: by 2002:a19:cc08:: with SMTP id c8-v6mr1887990lfg.145.1536236804363;
 Thu, 06 Sep 2018 05:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004f6b5805751a8189@google.com> <20180905085545.GD24902@quack2.suse.cz>
 <CAFqt6zZtjPFdfAGxp43oqN3=z9+vAGzdOvDcgFaU+05ffCGu7A@mail.gmail.com>
 <20180905133459.GF23909@thunk.org> <CAFqt6za5OvHgONOgpmhxS+YsYZyiXUhzpmOgZYyHWPHEO34QwQ@mail.gmail.com>
 <20180906083800.GC19319@quack2.suse.cz>
In-Reply-To: <20180906083800.GC19319@quack2.suse.cz>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 6 Sep 2018 17:56:31 +0530
Message-ID: <CAFqt6zZ=uaArS0hrbgZGLe38HgSPhZBHzsGEJOZiQGm4Y2N0yw@mail.gmail.com>
Subject: Re: linux-next test error
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        syzbot+87a05ae4accd500f5242@syzkaller.appspotmail.com,
        ak@linux.intel.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        mgorman@techsingularity.net, syzkaller-bugs@googlegroups.com,
        tim.c.chen@linux.intel.com, zwisler@kernel.org,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 2:08 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 06-09-18 00:54:50, Souptick Joarder wrote:
> > On Wed, Sep 5, 2018 at 7:05 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> > >
> > > On Wed, Sep 05, 2018 at 03:20:16PM +0530, Souptick Joarder wrote:
> > > >
> > > > "fs: convert return type int to vm_fault_t" is still under
> > > > review/discusson and not yet merge
> > > > into linux-next. I am not seeing it into linux-next tree.Can you
> > > > please share the commit id ?
> > >
> > > It's at: 83c0adddcc6ed128168e7b87eaed0c21eac908e4 in the Linux Next
> > > branch.
> > >
> > > Dmitry, can you try reverting this commit and see if it makes the
> > > problem go away?
> > >
> > > Souptick, can we just NACK this patch and completely drop it from all
> > > trees?
> >
> > Ok, I will correct it and post v3.
> >
> > >
> > > I think we need to be a *lot* more careful about this vm_fault_t patch
> > > thing.  If you can't be bothered to run xfstests, we need to introduce
> > > a new function which replaces block_page_mkwrite() --- and then let
> > > each file system try to convert over to it at their own pace, after
> > > they've done regression testing.
> > >
> > >                                                 - Ted
> >
> > Chris has his opinion,
> >
> > block_page_mkwrite is only called by ext4 and nilfs2 anyway, so
> > converting both callers over should not be a problem, as long as
> > it actually is done properly.
> >
> > Matthew's opinion in other mail thread -
> >
> > > +vm_fault_t block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
> > > +                      get_block_t get_block, int *err)
> >
> > I don't like returning both the errno and the vm_fault_t.  To me that's a
> > sign we need to rethink this interface.
> >
> > I have two suggestions.  First, we could allocate a new VM_FAULT_NOSPC
> > bit.  Second, we could repurpose one of the existing bits, such as
> > VM_FAULT_RETRY for this purpose.
> >
> > > -int ext4_page_mkwrite(struct vm_fault *vmf)
> > > +vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
> >
> > I also think perhaps we could start by _not_ converting block_page_mkwrite().
> > Just convert ext4_page_mkwrite(), and save converting block_page_mkwrite()
> > for later.
>

> Yes, I'd start with converting ext4_page_mkwrite() - that should be pretty
> straightforward - and we can leave block_page_mkwrite() as is for now. I
> don't think allocating other VM_FAULT_ codes is going to cut it as
> generally the filesystem may need to communicate different error codes back
> and you don't know in advance which are interesting.

Then I need to take care of ext4_page_mkwrite() and ext4_filemap_fault()
to migrate to use vm_fault_t return type. Everything else can be removed
from this patch and it will go as a separate patch.

As block_page_mkwrite() is getting called from 2 places in ext4 and nilfs and
both places fault handler code convert errno to VM_FAULT_CODE using
block_page_mkwrite_return(), is it required to migrate block_page_mkwrite()
to use vm_fault_t return type and further complicate the API or better to
leave this API in current state ??

>
> One solution for passing error codes we could use with vm_fault_t is a
> scheme similar to ERR_PTR. So we can store full error code in vm_fault_t
> and still have a plenty of space for the special VM_FAULT_ return codes...
> With that scheme converting block_page_mkwrite() would be trivial.
>
I didn't get this part. Any reference code will be helpful ?
