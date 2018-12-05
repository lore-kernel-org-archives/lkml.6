Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75464C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEA12082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jjmKejcF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FEA12082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeLEGs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:48:27 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46088 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeLEGs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:48:27 -0500
Received: by mail-oi1-f195.google.com with SMTP id x202so16589721oif.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 22:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k+aJ9ULJsUuCBLbE1FFaQoiO9mg4/BkUiE2mBCKV9Mw=;
        b=jjmKejcF6VMM8VRilW5S/PSLMnoABN+i0CCjx4dI+SkN60yOprYkcUC6Ae6IbPJ259
         kT7iGHXsfF0xyRn3tpPO7uDduh0AEeuiwjg22CqRjCxGpnqLPZpWOm3B56pirDIJOjtd
         qiP3kZC8MCtP7J2vApCR3UtW58GzKnVgSJaP3V/xxTshCsziSLRCRZKQD79/NGZHI1xm
         QOL1gfK2Cmcb3y660AnjXe5ZgST+p8SgI5c3pulpr7fn3HgSZS/hng9SHFRoj5kW6Zl3
         0jShKSq5o/DIt5IlcLIETKehxV1eU24WvzqmWoumcfXYKZplRJBd1vo+9jB5v5W5JADK
         MjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+aJ9ULJsUuCBLbE1FFaQoiO9mg4/BkUiE2mBCKV9Mw=;
        b=Q1aXGHbVMikJcuLCfI/IQDLq5J18vmVjvbeF/cjQgrnjPhIYPC7movrM4vgnAplFuB
         ztdvBXPxflTsqsYMqBKXsbenrOY8zefhjwz87bqNJDptlWxPNXmQSspzArJbYlaPnFx0
         Gk+Ft/atMjFntmVKoRVJRmRfYbhkeLM6dHM/toCDXgCQB04W97WSVyWXTQ+ISpJanVr4
         qs5qjL3Q3Wbx0K6kDAgORpW1Tusy6mQsUqO+3pP1ivUp4G0Tkzed7vSDVUpSqDklWJUG
         +vS8lJH1SMLkfUatU+vF6YJs1JU9oGK6hwSeXyINPkiUlF89hkPRM+SJP6eq0fw3nGTe
         7cVQ==
X-Gm-Message-State: AA+aEWaWmnj68q+jw0JBpp5Ryc3uZ3EwLUOcAXcn2ep+C0ksPPMzxLko
        Bzaqmk4hmhTGPxFFZUHTecifhqQLoI8sCKwXr4N/Pg==
X-Google-Smtp-Source: AFSGD/V4LO2SRmocBeosF0NVfV8nyvMr8Gkhx2gsLPgtP5RcRxJ8ZvsOKp7+K6b8DO5ldw1oLLI4g1Ag9gioMPmPg98=
X-Received: by 2002:aca:e003:: with SMTP id x3mr14944256oig.39.1543992505577;
 Tue, 04 Dec 2018 22:48:25 -0800 (PST)
MIME-Version: 1.0
References: <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
 <7741efa7-a3f8-62a1-ba52-613883164643@cisco.com> <84460a77-a111-404e-4bad-88104a6e246e@cisco.com>
 <20181026082812.GA10581@redhat.com> <21f678a8-4001-df36-c26e-e96cf203b1b1@cisco.com>
 <20181029111804.GA24820@redhat.com> <0c197608-3b7e-ffd1-8943-801a60beb917@cisco.com>
 <80e96710-f424-9b39-72ee-9cc7cbe7a5f7@cisco.com> <20181128151911.GN3505@e103592.cambridge.arm.com>
 <ad461da7-f0a6-7912-3201-e440dc372f89@cisco.com> <20181129115520.GO3505@e103592.cambridge.arm.com>
In-Reply-To: <20181129115520.GO3505@e103592.cambridge.arm.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 4 Dec 2018 22:47:57 -0800
Message-ID: <CAG48ez1CMTMAZKQ_Vqjju8RaoNtUu_1rttw9PxHJFypCTEkYGA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] kernel/signal: Signal-based pre-coredump notification
To:     Dave.Martin@arm.com
Cc:     enkechen@cisco.com, Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Kate Stewart <kstewart@linuxfoundation.org>, deller@gmx.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian@brauner.io, Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>, mchehab+samsung@kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        guro@fb.com, Marcos Souza <marcos.souza.org@gmail.com>,
        linux@dominikbrodowski.net, Cyrill Gorcunov <gorcunov@openvz.org>,
        yang.shi@linux.alibaba.com, Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Victor Kamensky <kamensky@cisco.com>,
        xe-linux-external@cisco.com, sstrogin@cisco.com,
        Andy Lutomirski <luto@amacapital.net>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 3:55 AM Dave Martin <Dave.Martin@arm.com> wrote:
> On Thu, Nov 29, 2018 at 12:15:35AM +0000, Enke Chen wrote:
> > Hi, Dave:
> >
> > Thanks for your comments. You have indeed missed some of the prior reviews
> > and discussions. But that is OK.
> >
> > Please see my replies inline.
> >
> > On 11/28/18 7:19 AM, Dave Martin wrote:
> > > On Tue, Nov 27, 2018 at 10:54:41PM +0000, Enke Chen wrote:
> > >> diff --git a/kernel/sys.c b/kernel/sys.c
> > >> index 123bd73..39aa3b8 100644
> > >> --- a/kernel/sys.c
> > >> +++ b/kernel/sys.c
> > >> @@ -2476,6 +2476,19 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
> > >>                    return -EINVAL;
> > >>            error = arch_prctl_spec_ctrl_set(me, arg2, arg3);
> > >>            break;
> > >> +  case PR_SET_PREDUMP_SIG:
> > >> +          if (arg3 || arg4 || arg5)
> > >
> > > glibc has
> > >
> > >     int prctl(int option, ...);
> > >
> > > Some prctls() police extra arguments for zeros, but this means that
> > > the userspace caller also has to supply pointless 0 arguments.
> > >
> > > It's debatable which is the preferred approach.  Did you have any
> > > particular rationale for your choice here?
> > >
> >
> > The initial version did not check the values of these unused arguments.
> > But Jann Horn pointed out the new convention is to enforce the 0 values
> > so I followed ...
>
> Hmmm, I wasn't aware of this convention when I added PR_SVE_SET_VL etc.,
> and there is no clear pattern in sys.c, and nobody commented at the
> time.
>
> Of course, it works either way.

Looking at the last couple prctls that have been added:

PR_GET_SPECULATION_CTRL/PR_GET_SPECULATION_CTRL: checks unused args
(commit b617cfc858161140d69cc0b5cc211996b557a1c7, by tglx)
PR_SVE_GET_VL/PR_SVE_SET_VL: doesn't check unused args (commit
2d2123bc7c7f843aa9db87720de159a049839862, by Dave Martin)
PR_CAP_AMBIENT: checks unused args (by Andy Lutomirski)
PR_SET_FP_MODE/PR_GET_FP_MODE: doesn't check unused args
PR_MPX_ENABLE_MANAGEMENT/PR_MPX_DISABLE_MANAGEMENT: checks unused
args; this one actually specifically added such checks in commit
e9d1b4f3c60997fe197bf0243cb4a41a44387a88 ("x86, mpx: Strictly enforce
empty prctl() args") and specifically says "should be done for all new
prctl()s":

    Description from Michael Kerrisk.  He suggested an identical patch
    to one I had already coded up and tested.

    commit fe3d197f8431 "x86, mpx: On-demand kernel allocation of bounds
    tables" added two new prctl() operations, PR_MPX_ENABLE_MANAGEMENT and
    PR_MPX_DISABLE_MANAGEMENT.  However, no checks were included to ensure
    that unused arguments are zero, as is done in many existing prctl()s
    and as should be done for all new prctl()s. This patch adds the
    required checks.

    Suggested-by: Andy Lutomirski <luto@amacapital.net>
    Suggested-by: Michael Kerrisk <mtk.manpages@gmail.com>
    Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
    Cc: Dave Hansen <dave@sr71.net>
    Link: http://lkml.kernel.org/r/20150108223022.7F56FD13@viggo.jf.intel.com
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
