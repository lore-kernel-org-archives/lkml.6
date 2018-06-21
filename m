Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708ADC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2720120837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lrmq7+od"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2720120837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933467AbeFUM2T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:28:19 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52499 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933349AbeFUM2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:28:16 -0400
Received: by mail-wm0-f66.google.com with SMTP id p126-v6so4880468wmb.2;
        Thu, 21 Jun 2018 05:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xMlnrzbCe82VnPokZB7XR4l3OBvM3PxP2PrBkF6mHic=;
        b=Lrmq7+odJO5M3DHyqnIMjRYNQJhuuiSqUd2gZC1J2e+h9EcAlEShi3y4OGbk7LS7+U
         GnvdSEW+GYMIpWemL7mLBOLZXglX3cRurBNTV1LfLMP09T2VesWjrEdDO36bEDSCL9XR
         Z+Ik5MzK+rwh3/W11gRNwLN1Yrq89UjN42ZS0gWWhYveDmjZyXfuQYOl86FmJ83BHoDT
         JZD8LHg4w75NPSp6oYXU7DoSig1SR3+HZxX7WE4cTMckjYERcvkbbBVz77SNoN1QI7MS
         fTAMG0dkJsHuySPZwIqYkRwXlfzxQYsaCWgKjcYtOETqmIerylrNY5jxtQzcTyjyqA1A
         I8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xMlnrzbCe82VnPokZB7XR4l3OBvM3PxP2PrBkF6mHic=;
        b=rfvLdIjxRAVpttOvhUnLyhJhmP6+IwRGdkSLgFtzPVUkpGrmgDYZjTkoAcu+Oy+5++
         KuRcp5bhCNQ63KwO08OvUC4NsFviGsUEtdrSd/Tz/p43kJjBDucPyMqeVwKceQc/kXcP
         CInrS/JRKWbWtHEo7nml67HQgMfor5tvmoetK7QIBXw1eymWBIr29beKLQFIMpCAmiAA
         6bcQ2912wgDu+ZKDK4uAo4QhempNFHxQVHTtleRqr9gBTM27xO00dWAOZEztjSvSF7pF
         mOtVuO7NojTeUthKo2eQ/N/URwFd0x6cphST4UgJfYTvF0Fcm7pRaSG+n2m3xaQ2HNCy
         PGDQ==
X-Gm-Message-State: APt69E2DYKiKuOzrLTdSPhEcVecxlNOyg6l7QsgoZrYEJkpWUOEm1lAj
        jL1wqeMmYIotWb3L5Hin13E=
X-Google-Smtp-Source: ADUXVKK5ENdH4VWve5QwmYwc3PYq1pG+7ALqk1tE1/0Gna0icOQabaOVx1vBmhvb0XcanXNbLykKQA==
X-Received: by 2002:a1c:d509:: with SMTP id m9-v6mr5230884wmg.69.1529584095228;
        Thu, 21 Jun 2018 05:28:15 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id n17-v6sm6670127wmd.14.2018.06.21.05.28.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 05:28:14 -0700 (PDT)
Date:   Thu, 21 Jun 2018 14:28:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     hpa@zytor.com, mingo@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, Kees Cook <keescook@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        geert@linux-m68k.org, Will Deacon <will.deacon@arm.com>,
        mawilcox@microsoft.com, Arnd Bergmann <arnd@arndb.de>,
        David Rientjes <rientjes@google.com>, acme@redhat.com,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        boris.ostrovsky@oracle.com, "J. Kiszka" <jan.kiszka@siemens.com>,
        rostedt@goodmis.org, kirill.shutemov@linux.intel.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        akataria@vmware.com, brijesh.singh@amd.com,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        jarkko.sakkinen@linux.intel.com, jgross@suse.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Matthias Kaehlcke <mka@chromium.org>, thomas.lendacky@amd.com,
        Thiebaud Weksteen <tweek@google.com>, mjg59@google.com,
        joe@perches.com, andrea.parri@amarulasolutions.com,
        "H. Peter Anvin" <hpa@linux.intel.com>
Subject: Re: [PATCH v5 2/3] x86/asm: add _ASM_ARG* constants for argument
 registers to <asm/asm.h>
Message-ID: <20180621122811.GA25066@gmail.com>
References: <20180613210518.113983-1-ndesaulniers@google.com>
 <20180613210518.113983-3-ndesaulniers@google.com>
 <b027a324-ffae-fd5e-d8a3-03934be91a2d@zytor.com>
 <CAKwvOdngs8k_T=nDKh8JYdAwwFoJRcCU0bZu0tJHQ+keZ5+RFQ@mail.gmail.com>
 <deb5a074-b057-9388-4ab7-42295b5bb46c@zytor.com>
 <CAKwvOdmE-EHJY7tgzkhyQqNT3m3oWtd6iE3sWBTz19Rijzx4Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmE-EHJY7tgzkhyQqNT3m3oWtd6iE3sWBTz19Rijzx4Ew@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Thu, Jun 14, 2018 at 5:17 PM H. Peter Anvin <hpa@zytor.com> wrote:
> >
> > On 06/14/18 13:59, Nick Desaulniers wrote:
> > > On Thu, Jun 14, 2018 at 1:48 PM H. Peter Anvin <hpa@zytor.com> wrote:
> > >>
> > >> On 06/13/18 14:05, Nick Desaulniers wrote:
> > >>> From: "H. Peter Anvin" <hpa@linux.intel.com>
> > >>>
> > >>> i386 and x86-64 uses different registers for arguments; make them
> > >>> available so we don't have to #ifdef in the actual code.
> > >>>
> > >>> Native size and specified size (q, l, w, b) versions are provided.
> > >>>
> > >>> Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > >>> Signed-off-by: H. Peter Anvin <hpa@linux.intel.com>
> > >>> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > >>
> > >> I still object to Suggested-by: here.  Sedat did a correction, which is
> > >> a Reviewed-by:, but unless I'm completely out to sea, there was no
> > >> suggestion on Sedat's part of this; and I had certainly not seen it when
> > >> I wrote the code.
> > >
> > > I'm fine with changing it from a Suggested-by to a Reviewed-by.  Can
> > > you do that when you apply the set, or should I send a v6?
> > >
> >
> > I'm not handling patch mechanics for x86 at the moment.
> 
> Hi Ingo and Thomas,
> Have you had a chance to review this patch series for application?
> 
> Note that Juergen (the paravirt maintainer) acked the series:
> https://bugs.llvm.org/show_bug.cgi?id=37880
> The only issue being swapping a Suggested-by for a Reviewed-by tag for
> one commit, as above.

Could you please update the series with all suggestions and tags and send a new 
series?

Thanks,

	Ingo
