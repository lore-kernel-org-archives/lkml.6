Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1DAC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 23:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05712208DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 23:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05712208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeHWC7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 22:59:06 -0400
Received: from smtprelay0154.hostedemail.com ([216.40.44.154]:35591 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727007AbeHWC7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 22:59:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 82857180AC48D;
        Wed, 22 Aug 2018 23:32:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bath34_6a5f0b3b45303
X-Filterd-Recvd-Size: 2907
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 Aug 2018 23:32:10 +0000 (UTC)
Message-ID: <f51e6c2dcd83aae2af8d9e1d0b40e76e6c680446.camel@perches.com>
Subject: Re: [PATCH] compiler-gcc: get back Clang build
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     asmadeus@codewreck.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, dwmw@amazon.co.uk,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        daniel@iogearbox.net, hpa@zytor.com
Date:   Wed, 22 Aug 2018 16:32:09 -0700
In-Reply-To: <CAKwvOdmZuzhyaOzh_ruNQUp96zed8+BAz3DCw1hrZrseVNg9tA@mail.gmail.com>
References: <1534834088-15835-1-git-send-email-yamada.masahiro@socionext.com>
         <20180821123832.GA19034@nautica>
         <CAKwvOdmLQen+TWF_F3e5-66vtF3FEnoxjEgZbjmOZ9cv6YrEpA@mail.gmail.com>
         <acb93bae0086447c7cbe0eec05907335ebae7788.camel@perches.com>
         <CAKwvOdkLGhdQxx3oV=R2kv290NOv_w8qQ_yHWCVpvmofp7+ivQ@mail.gmail.com>
         <20180822041646.GA21716@nautica>
         <78396ba82562326f4b3a395a63e3e8dc38d608b2.camel@perches.com>
         <20180822043230.GA26654@nautica>
         <CAKwvOdm+BwvDxAw-A_1v5xO2EjDff1axAttHVz5QnBSxSbKo=g@mail.gmail.com>
         <39b6242771fd80fe19104c8a057bcc6afc0e41e5.camel@perches.com>
         <CAKwvOdmZuzhyaOzh_ruNQUp96zed8+BAz3DCw1hrZrseVNg9tA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-22 at 16:05 -0700, Nick Desaulniers wrote:

Hey Nick.

> On Wed, Aug 22, 2018 at 1:50 PM Joe Perches <joe@perches.com> wrote:
> > A mild suggestion about the patch would be to break it up into
> > 2 patches to improve how people read and review them.
> > 
> > 1 include/linux/compiler-*
> > 2 everything else
> > 
> > Yes, some kernel configs might not build properly between 1 and 2
> > but that likely doesn't matter as those configs probably don't
> > build before 1 either.
> 
> If we ordered the patches so that the "everything else" went in first,
> it would not be a problem.  The first patch would just be the checks
> that GCC_VERSION is defined.
> 
> In general, I'm happy to split patches, but in this suggested case, it
> only shaves off 26 lines from the main body of work.

No worries, I rarely care _that_ much about code, but
seeing the subject with compiler-gcc and the first
part of the patch about arch/ was a bit off-putting.

You're the one doing the work here.
Do what you think best.

