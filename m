Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C63BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2963220838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ao7IWi+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2963220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeH3WDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:03:18 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45475 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbeH3WDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:03:18 -0400
Received: by mail-oi0-f66.google.com with SMTP id t68-v6so16976927oie.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 10:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AhFK2aFvWPveEyK+LlBfYW09h2A3k7IjDUBtR3SoN2g=;
        b=ao7IWi+PXEG69rKSDk02ftHLPTMga2Vc+XT3LXRfWiVePaNLFrsj1FXPx0s10r7h3X
         UpLhIpVnO15PqNtFAF40nR4dJCS/CtAqlwntUMHt5SKOw31NTLRVvgpkOldbKtkmKi1h
         LZDlmt4H+jChfE7tPPgaRM2WWogOBy8VCF4uSlRXcsI8QuH1i0XnX53ShpPNZX3X46Pu
         0OLtiQUqOVrkslPZSbbPwv0gkwIaGcZucPyQeTu21uqoy17Zobrzk4gb0bSJNI/pOGCo
         5LCy9dTDnLV7jOojJYLkAVfEwoxHrgHGYO1I8bBw3DwIJ8z+JfSGt1JWAfTOyPIsoj1Q
         1M1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AhFK2aFvWPveEyK+LlBfYW09h2A3k7IjDUBtR3SoN2g=;
        b=oDv1lxNqunLCQX6aq3E8XqebQGmwbsVcy4cTxxJZUGEXBK/2O8zNFdPincsx24OXj0
         txIhKSUXfNlZffa5iDyYJo5HfVd2L0//BsLKOTqe8+kxtPfgVmKojmSwkUVvzEtf5Q6J
         +7GVP+bO4NAv/MOzPWboV8J2AApc9dZzxwIszAZsz5wgBXXWFCOBA6oCu2NYr43fpM/Z
         S4av4s8UYfjDbs5Q23TmFUS3K98mJxBy06C8h6dG0DVkTzdnyKD8JULwi4Sj33Zjzt3w
         0Nd/BEYVbKY9ZPOMpTPlvNKaPG3koxea7l3jegdYH04G1+t+vnn9L6KP4VheTiFZgB3j
         xJkw==
X-Gm-Message-State: APzg51D8NKyo3Gbbrc1p8M+vKnKnqOm28EbyzSlN48I+QL12CWmy4C27
        wQRCbVTENg2NGAv4GiuM3l4si5s+8TKXnV50CVxmqQ==
X-Google-Smtp-Source: ANB0VdauerD2wyrOZxhWfskp0HKKdOE+1QXxPjRftG0xBuYfx8D4lGSd3ijm3jHVUuMIpYuvUe+s2iUJaaTrhCuskZ8=
X-Received: by 2002:aca:b40a:: with SMTP id d10-v6mr3866636oif.190.1535651999272;
 Thu, 30 Aug 2018 10:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180830143904.3168-1-yu-cheng.yu@intel.com> <20180830143904.3168-13-yu-cheng.yu@intel.com>
 <CAG48ez0Rca0XsdXJZ07c+iGPyep0Gpxw+sxQuACP5gyPaBgDKA@mail.gmail.com>
 <079a55f2-4654-4adf-a6ef-6e480b594a2f@linux.intel.com> <CAG48ez2gHOD9hH4+0wek5vUOv9upj79XWoug2SXjdwfXWoQqxw@mail.gmail.com>
 <ce051b5b-feef-376f-e085-11f65a5f2215@linux.intel.com> <1535649960.26689.15.camel@intel.com>
 <33d45a12-513c-eba2-a2de-3d6b630e928e@linux.intel.com> <1535651666.27823.6.camel@intel.com>
In-Reply-To: <1535651666.27823.6.camel@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 30 Aug 2018 19:59:32 +0200
Message-ID: <CAG48ez3ixWROuQc6WZze6qPL6q0e_gCnMU4XF11JUWziePsBJg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 12/24] x86/mm: Modify ptep_set_wrprotect and
 pmdp_set_wrprotect for _PAGE_DIRTY_SW
To:     yu-cheng.yu@intel.com
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Florian Weimer <fweimer@redhat.com>, hjl.tools@gmail.com,
        Jonathan Corbet <corbet@lwn.net>, keescook@chromiun.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        ravi.v.shankar@intel.com, vedvyas.shanbhogue@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 7:58 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> On Thu, 2018-08-30 at 10:33 -0700, Dave Hansen wrote:
> > On 08/30/2018 10:26 AM, Yu-cheng Yu wrote:
> > >
> > > We don't have the guard page now, but there is a shadow stack
> > > token
> > > there, which cannot be used as a return address.
> > The overall concern is that we could overflow into a page that we
> > did
> > not intend.  Either another actual shadow stack or something that a
> > page
> > that the attacker constructed, like the transient scenario Jann
> > described.
> >
>
> A task could go beyond the bottom of its shadow stack by doing either
> 'ret' or 'incssp'.  If it is the 'ret' case, the token prevents it.
>  If it is the 'incssp' case, a guard page cannot prevent it entirely,
> right?

I mean the other direction, on "call".
