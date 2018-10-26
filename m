Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78326ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266182085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wxddaoza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266182085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbeJ0Gqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 02:46:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34480 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbeJ0Gqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 02:46:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id f78-v6so1190898pfe.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 15:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PL/iMNOuaAoLj2j7N9O3YEJAutdwZwjrJLQ1IJVm4Dw=;
        b=Wxddaoza/LhCpSdo87szfmV6TDYkPxlxiK1rxLEKne6FiS+73bE1LUH+1mc+PuRWMn
         neUleb+V48o8qcN6WWjo3FvoG9dAVdWnm/ImYnuDvEvemGp3UKdgNeVmC/4stLTHhSog
         T6lYPldl/uw7/zoeyTMvK/HPAW1r+PO4DsmlvWx16y4NkT6JIc8cCTftN7saOFRZ63hL
         NImY8l0i9XyKTKazq6QR8yRwerYwjV24bXoAW8cAsxCoZs6XEu5XiuW2QSX6d8pHTRte
         RObZAF8HxgIoY7gmkiz+qx6MM/zp6Rw2wBmytNurx8/lo+wa40Qz6GqeYOfNQldPQlMD
         6U0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PL/iMNOuaAoLj2j7N9O3YEJAutdwZwjrJLQ1IJVm4Dw=;
        b=PEDn5tnNr3wds/l+qDwH0mEM0rp+ke3Hpao7DzKcE1IoDI0ORSwr9az6eTDqPp9HI6
         N3Or9EEB8XICSnWjv8WMZGjThuy8DSH0+azHCdC7CkUVd/q8Z2W7EZWXmjkbqHG1ubhD
         AEh4dDw3rCRxRflcAgpQWbeEYodh6J9Qvd++CUdlFy+TvapLRjbsmHO3nnzmus+bmhqA
         WzD5vRi71yYKWTt7qtC2ruoNE7oBIaJFyaLXndrpr/OCO/ndhVEpFtvt6KOVhb09shzk
         INv8hKb7MCxhaik3EBkxpK44LAIg0jtOqvhfNcuXf29SXiD49Xj5ohuNvyBbb0eMIerv
         CX3Q==
X-Gm-Message-State: AGRZ1gLO6ChH1mCjWynVmaDSrN982TVEMC93GuOtrHt/3AOQXU6FbPuQ
        rh38n6aDd2u9o7H9WjPAyPN/DFxpdXQVMwkJpjqNQg==
X-Google-Smtp-Source: AJdET5eA4kb9369Ob3AClZWazhdKGWiiAAJ9N9ejhkfWy7uusqi1MQeTerGsD1Ljts8Mz9fmsewMUaExXzMfAiiJic0=
X-Received: by 2002:a62:4b09:: with SMTP id y9-v6mr5505283pfa.93.1540591670211;
 Fri, 26 Oct 2018 15:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180930205448.26205-1-natechancellor@gmail.com>
 <10b12992-3570-4646-374b-82cbd7276839@acm.org> <CAKwvOd=wgxB69dMxzMeH2edCn=TdQGPGkNVW1e=QHPTJtO9ZNw@mail.gmail.com>
 <1538503063.193396.6.camel@acm.org> <CAKwvOdmsNEexQL9R8rgcRcXTZButYM6YWwG8bhVWCoJ8bOqCrA@mail.gmail.com>
 <1538521591.193396.8.camel@acm.org> <20181025213144.GB24709@flashbox>
 <CAKwvOdn=TvoGdFvgxX6TyXBXnhVLttriRrZEnzS6DjcjL64DPA@mail.gmail.com>
 <20181025225548.GA10326@flashbox> <CAKwvOdnwmf47_m_0K5OCLmXbrkLNnekpNOPCCMeJqkuqKUbQ-A@mail.gmail.com>
 <1540576908.66186.103.camel@acm.org> <CAKwvOdnYx60JkJHJkD7CYA9yx5Oa7Tn9q4aZ3-tcZGx++yoduQ@mail.gmail.com>
 <1540589437.66186.124.camel@acm.org> <CAKwvOdm-xYRqCBXhLC1ceC44_rEmggW4qiSgGpRkpL+p-NadVg@mail.gmail.com>
 <1540591147.66186.127.camel@acm.org>
In-Reply-To: <1540591147.66186.127.camel@acm.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 26 Oct 2018 15:07:39 -0700
Message-ID: <CAKwvOdmUhtK10cbYFoEJJp4O8LA_F-+f68A_NcL_fm_FH6QodA@mail.gmail.com>
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
To:     bvanassche@acm.org, Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ooo@electrozaur.com, Nathan Chancellor <natechancellor@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 2:59 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Fri, 2018-10-26 at 14:36 -0700, Nick Desaulniers wrote:
> > On Fri, Oct 26, 2018 at 2:30 PM Bart Van Assche <bvanassche@acm.org> wrote:
> > >
> > > On Fri, 2018-10-26 at 14:00 -0700, Nick Desaulniers wrote:
> > > > On Fri, Oct 26, 2018 at 11:01 AM Bart Van Assche <bvanassche@acm.org> wrote:
> > > > >
> > > > > On Fri, 2018-10-26 at 10:54 -0700, Nick Desaulniers wrote:
> > > > > > If creating one instance of this variable is a functional change, I
> > > > > > can't help but suspect the original code was wrong.  But maybe Bart,
> > > > > > Boaz, or Christoph can clarify or have more thoughts on this?  Looks
> > > > > > like Boaz added this header in commit de258bf5e638 ("[SCSI] libosd:
> > > > > > OSDv1 Headers").
> > > > >
> > > > > Hi Nick and Nathan,
> > > > >
> > > > > Had you noticed the following e-mail from early October:
> > > > > https://marc.info/?l=linux-kernel&m=153849955503249?
> > > >
> > > > From this subthread with Linus, removal of the exofs fs and scsi osd
> > > > code would be a user visible change and is not an option. See:
> > > > https://lkml.org/lkml/2018/10/27/3
> > > > https://lkml.org/lkml/2018/10/27/44
> > >
> > > Hi Nick,
> > >
> > > Linus wrote that removing a filesystem is considered a userspace breakage
> > > if a user notices. The key part is "if a user notices". Who are the exofs
> > > users?
> >
> > See my thoughts on this in https://lkml.org/lkml/2018/10/27/27.
> > Particularly the part about the IMO catch 22.
> >
> > Neither you nor I can claim "there are none."
>
> That's not completely correct. The standard approach to check whether or not
> a driver is still being used is to check its git history. If the number of
> contributors is low and it was several years ago that a new feature was added
> or a bug has been fixed it is likely that nobody is using that driver anymore.
>
> Bart.
>

Bart,
I don't disagree with you, I just don't see how what you state can be
reconciled with Linus' response in
https://lkml.org/lkml/2018/10/27/44.  Those two viewpoints seem
incompatible to me, but maybe there's a nuance I'm missing?

Nathan and I are just pointing out a small fix to eliminate a small
warning, deleting all this code does kind of feels like "throwing out
the baby with the bath water." A nuclear option for what would be a
small change otherwise.  Maybe it's good to discuss the EOL for
exofs/osd, but can we please decouple that conversation from the small
change Nathan and I are proposing?
-- 
Thanks,
~Nick Desaulniers
