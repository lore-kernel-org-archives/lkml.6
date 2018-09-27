Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BEFC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819682170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1V7rbE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819682170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeI1GK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 02:10:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39637 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeI1GK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 02:10:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id q8-v6so441435wmq.4;
        Thu, 27 Sep 2018 16:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5FBXJ5YUh6/SVvvWE2dXMYrWOffDUlUcvUqi6w4pILY=;
        b=T1V7rbE7BX7antOyx3NbhpAct2b7vYH4Dq8fnAEAQPK7GC1HmPowtfjhxHBbrwGz3/
         SbRBm4pUC+45GERBncTLnBT0X9hVAkbotQY8mLfPER0u1YdpXL8Zm++06Dz4iD4NeKVv
         fA14UtyxcIz97fg2DYBju9Z4L8V+1YxRdy7WKbz+UEdJYbfTiysfSXqmON5f78hnxrcV
         DFXDzraXa8YzH5LwAWbWfjSGAEItqeu0x8j5Z7nAl8Ussuytu6s073ib8McYSEJEV373
         wj7aH3dq6ympCGvzwjwmYCXIiPwcC8E5mtNUePivbjvGcrVNjgfx8DiSkWSNAzxVmvyK
         PB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5FBXJ5YUh6/SVvvWE2dXMYrWOffDUlUcvUqi6w4pILY=;
        b=UAQQZkya5PXGiaC1hf9c0mX4TKqq/MOtfqoag8HztGo1NqvWq+9cK0NmeUORYxU4Nh
         LFh6VprVO+1xzqWVgPsh09QEg6G1SOYNcoeSwVpUlVNaepqUnEzCCoRUnt2QZcK67adt
         cGbJokYTrOZrbWU0jBxQ3Efk2HHXQv50aElp5LPEfUdhA+WxWhH6MyoPTdM6QecRxhLk
         GoJ0ElSIRBQ3go4GacCo1Zmxu6tb3hv+Y3ue7xgCX+dL+1OQFkKDxVba3Ns4wEWeRMR6
         p231+OR3ny+/qELF5mDmIOb/NGfcih3/AjvfJ8ZikrApjs2FwSxCIZ66MCGjbvL2bzgJ
         EuPQ==
X-Gm-Message-State: ABuFfojyqn84AYUElu7EweR1Uk+4DsII2YBJ5UIfJ9Qw8xIATvsdUymt
        O0o5AG56NBvCX5cYSwca4MtTmuf8rMPxpA==
X-Google-Smtp-Source: ACcGV62o4VUWlmO2He9zKyOcyLJTq2QV9A/4Gkaby9J8H65GMdw5JoLp9ebsP+Fz5rG29axE2//zFQ==
X-Received: by 2002:a1c:ac82:: with SMTP id v124-v6mr509843wme.10.1538092176021;
        Thu, 27 Sep 2018 16:49:36 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id n4-v6sm3701643wrr.21.2018.09.27.16.49.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 16:49:35 -0700 (PDT)
Date:   Thu, 27 Sep 2018 16:49:33 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     anil.gurumurthy@qlogic.com, sudarsana.kalluru@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: bfa: Avoid implicit enum conversion in
 bfad_im_post_vendor_event
Message-ID: <20180927234933.GA15651@flashbox>
References: <20180926045435.9213-1-natechancellor@gmail.com>
 <CAKwvOdmc+LE60tYFGzoWV5OA9kTLVqq9O9SAvXKmFZmRWD7BRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmc+LE60tYFGzoWV5OA9kTLVqq9O9SAvXKmFZmRWD7BRQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 04:35:37PM -0700, Nick Desaulniers wrote:
> On Tue, Sep 25, 2018 at 9:58 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns when one enumerated type is implicitly converted to another.
> >
> > drivers/scsi/bfa/bfa_fcs_lport.c:379:26: warning: implicit conversion
> > from enumeration type 'enum bfa_lport_aen_event' to different
> > enumeration type 'enum bfa_ioc_aen_event' [-Wenum-conversion]
> >                                   BFA_AEN_CAT_LPORT, event);
> >                                                      ^~~~~
> >
> > The root cause of these warnings is the bfad_im_post_vendor_event
> > function, which expects a value from enum bfa_ioc_aen_event but there
> > are multiple instances of values from enums bfa_port_aen_event,
> > bfa_audit_aen_event, and bfa_lport_aen_event being used in this
> > function.
> 
> Indeed, it seems that bfad_im_post_vendor_event() assigns this parameter to
> 161         entry->aen_type = evt;
> 
> which is defined as:
> 
> 1456         u32                     aen_type;
> 
> so already we know that aen_type is meant to be a grab bag of enum
> values.  bfad_im_post_vendor_event() is already passed many different
> types of enums, as you mention.  Does changing aen_type to an `int`
> produce further warnings, because it would be nice to have that change
> in this one, too.  AFAICT, it's only ever saved away in a containing
> struct.
> 

No, it doesn't introduce any new warnings. I can send that as a v2 here shortly.

Nathan

> >
> > Given that this doesn't appear to be a problem since cat helps with
> > differentiating the events, just change evt's type to int so that no
> > conversion needs to happen and Clang won't warn.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/147
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >
> > The alternate way of fixing these warnings is to explicitly cast the
> > conversion when calling the function but since there are about 8-10 of
> > these warnings, it seems logical to just change the function definiton
> > which is cleaner in my opinion.
> >
> > See commits 3eb95feac113 ("mm/zsmalloc.c: change stat type parameter to
> > int") and 04fecbf51b3c ("mm: memcontrol: use int for event/state
> > parameter in several functions") for similar fixes.
> >
> >  drivers/scsi/bfa/bfad_im.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/scsi/bfa/bfad_im.h b/drivers/scsi/bfa/bfad_im.h
> > index e61ed8dad0b4..bd4ac187fd8e 100644
> > --- a/drivers/scsi/bfa/bfad_im.h
> > +++ b/drivers/scsi/bfa/bfad_im.h
> > @@ -143,7 +143,7 @@ struct bfad_im_s {
> >  static inline void bfad_im_post_vendor_event(struct bfa_aen_entry_s *entry,
> >                                              struct bfad_s *drv, int cnt,
> >                                              enum bfa_aen_category cat,
> > -                                            enum bfa_ioc_aen_event evt)
> > +                                            int evt)
> >  {
> >         struct timespec64 ts;
> >
> > --
> > 2.19.0
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
