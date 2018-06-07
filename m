Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id OVN2IXmQGVtXMAAAmS7hNA
	; Thu, 07 Jun 2018 20:07:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E1452608C1; Thu,  7 Jun 2018 20:07:22 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4Otfbu6"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5E03C60290;
	Thu,  7 Jun 2018 20:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5E03C60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932365AbeFGUHU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:07:20 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45998 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeFGUHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:07:18 -0400
Received: by mail-lf0-f67.google.com with SMTP id n3-v6so16549478lfe.12;
        Thu, 07 Jun 2018 13:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3BIH7lPFp+6QroKGLk7eaxnK9eE4jn8FIROuu/RCTus=;
        b=Z4Otfbu6Oc/Qgo69/+BEhvZ61KYhsTlFY22DDf/s4cbk3I0zqIHYaXXrcXRjJJpKGr
         x/AXc5OeThBSYxAkhAnxMMcpyVc2Ld8Kpqo26UaW8+g8VRiNuUBLydB+YixyUa31c0y/
         X77wq20Q3KFqtpGLQlhfAViXv/3PDfDAxAZgHaCVUSUPJIIcLMJtTb3eemepfAjcujYJ
         Bhir32HLc6oEfhcEn0Nk3uLQBAyZ3VHSe+scG4Liw09DyFZJNd/DgQJO1aEHXQ48nxuJ
         LjKCHF+l+ZW48aEvnYHVlEcz2TrryBnjG9w4Y4agr0aloNlOVCRZPPbZ3LiU9okuRzGy
         nCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3BIH7lPFp+6QroKGLk7eaxnK9eE4jn8FIROuu/RCTus=;
        b=MRGV/cv6ezNb/XKSyYe1BgjgY7cZAyVIvSVSNImRleVvh/kz7wLxCHvQs9gmyN/Mfv
         2xMxQCvFj+zcL8n3RV1/BWXZIgHiBZ7fV3y4IJjI2OPUSUV8cmAdA5VfQKs2vafgpcFr
         fQP4KEQLALbUWDskgcnV2tAF4kehVeg44QW9LVLIkK10zohIrelBtpc/bG68oFLlg2y1
         ocRxfvzqrSRWnwBP9fDgbDLu4i7oCf5BgVUY2UM+nrvFBTTyknNDPlFv5jPSBmhvdVTy
         bSTwYRZYutGaQp9z6hNg8twMXGdiYpTX3dAqRz/h6A9kQNsFAzXL9RV7vCDfZcU8gYuI
         IM2Q==
X-Gm-Message-State: APt69E0O2WGN+F4qo/GV4LS4OS4UdfyXrfM5JX4dI7kfIj17ayRhfHI1
        hgnetzDCxHK4D/GacXyP85A=
X-Google-Smtp-Source: ADUXVKI5ztFP6OQmEZMsj7lcHFqwBawP2/T+IepydCZlxN3ZUGlUK8tJo7Fu8+spH3vdM/NbOMkb6w==
X-Received: by 2002:a2e:29cf:: with SMTP id p76-v6mr2628699ljp.12.1528402036423;
        Thu, 07 Jun 2018 13:07:16 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id y89-v6sm5799311lje.74.2018.06.07.13.07.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 13:07:15 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id E80DD460756; Thu,  7 Jun 2018 23:07:14 +0300 (MSK)
Date: Thu, 7 Jun 2018 23:07:14 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Subject: Re: [PATCH 03/10] x86/cet: Signal handling for shadow stack
Message-ID: <20180607200714.GA2525@uranus>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
 <20180607143807.3611-4-yu-cheng.yu@intel.com>
 <CALCETrWo77RS_wOzskw5OG-LdC1S-b_NY=uPWUmPbQEnNwANgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWo77RS_wOzskw5OG-LdC1S-b_NY=uPWUmPbQEnNwANgQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 11:30:34AM -0700, Andy Lutomirski wrote:
> On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> >
> > Set and restore shadow stack pointer for signals.
> 
> How does this interact with siglongjmp()?
> 
> This patch makes me extremely nervous due to the possibility of ABI
> issues and CRIU breakage.
> 
> > diff --git a/arch/x86/include/uapi/asm/sigcontext.h b/arch/x86/include/uapi/asm/sigcontext.h
> > index 844d60eb1882..6c8997a0156a 100644
> > --- a/arch/x86/include/uapi/asm/sigcontext.h
> > +++ b/arch/x86/include/uapi/asm/sigcontext.h
> > @@ -230,6 +230,7 @@ struct sigcontext_32 {
> >         __u32                           fpstate; /* Zero when no FPU/extended context */
> >         __u32                           oldmask;
> >         __u32                           cr2;
> > +       __u32                           ssp;
> >  };
> >
> >  /*
> > @@ -262,6 +263,7 @@ struct sigcontext_64 {
> >         __u64                           trapno;
> >         __u64                           oldmask;
> >         __u64                           cr2;
> > +       __u64                           ssp;
> >
> >         /*
> >          * fpstate is really (struct _fpstate *) or (struct _xstate *)
> > @@ -320,6 +322,7 @@ struct sigcontext {
> >         struct _fpstate __user          *fpstate;
> >         __u32                           oldmask;
> >         __u32                           cr2;
> > +       __u32                           ssp;
> 
> Is it actually okay to modify these structures like this?  They're
> part of the user ABI, and I don't know whether any user code relies on
> the size being constant.

For sure it might cause problems for CRIU since we have
similar definitions for this structure inside our code.
That said if kernel is about to modify the structures it
should keep backward compatibility at least if a user
passes previous version of a structure @ssp should be
set to something safe by the kernel itself.

I didn't read the whole series of patches in details
yet, hopefully will be able tomorrow. Thanks Andy for
CC'ing!
