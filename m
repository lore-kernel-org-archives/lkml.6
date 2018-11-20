Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C6BC46463
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D77208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D77208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbeKUEiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:38:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:12802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbeKUEiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:38:09 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 176E958E22;
        Tue, 20 Nov 2018 18:07:45 +0000 (UTC)
Received: from treble (ovpn-122-214.rdu2.redhat.com [10.10.122.214])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FE451062220;
        Tue, 20 Nov 2018 18:07:43 +0000 (UTC)
Date:   Tue, 20 Nov 2018 12:07:41 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Florian Weimer <fweimer@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Daniel Colascione <dancol@google.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>
Subject: Re: Cleaning up numbering for new x86 syscalls?
Message-ID: <20181120180741.iu6bcjprjxeqllem@treble>
References: <CALCETrVPcgKarpTOsdTfODkNA76W04WvW+tNWoOx6+Em0KS04A@mail.gmail.com>
 <87efbggly5.fsf@oldenburg.str.redhat.com>
 <CALCETrVJO-GSbQCGNJS_F1ZswG15aWOdX7onWFYgTVhh97WbWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrVJO-GSbQCGNJS_F1ZswG15aWOdX7onWFYgTVhh97WbWg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 20 Nov 2018 18:07:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 07:23:09AM -0800, Andy Lutomirski wrote:
> On Tue, Nov 20, 2018 at 1:03 AM Florian Weimer <fweimer@redhat.com> wrote:
> >
> > * Andy Lutomirski:
> >
> > > 5. Adjust the scripts so that we only have to wire up new syscalls
> > > once.  They'll have a nr above 1024, and they'll have the same nr on
> > > all x86 variants.
> >
> > Is there a sufficiently sized gap on all other architectures as well?
> > The restriction to the x86 variants seems arbitrary to me.
> >
> 
> Fair point.  We have this shiny "generic" syscall list.  Maybe we can
> get x86 synced up with it for new syscalls.

I heard this discussed at Plumbers.  There was a proposal to use the
same syscall numbers across architectures.  Also, when adding new
generic syscalls, they want all arches to be wired up at the same time.

  https://linuxplumbersconf.org/event/2/contributions/149/attachments/129/161/Ideas_to_improve_glibc_and_Kernel_interaction.pdf

Adding Adhemerval to CC.

-- 
Josh
