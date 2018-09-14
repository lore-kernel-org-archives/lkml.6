Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D213CECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7384920833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IGaGhTGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7384920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeINXaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:30:10 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35304 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeINXaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:30:10 -0400
Received: by mail-ot1-f65.google.com with SMTP id j9-v6so5453612otl.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 11:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7/+uzcKU7N9eQQP3SFjSAD1qGow0LsUcOH+d4fY3c3w=;
        b=IGaGhTGIkx7hGHOTkmo2YYp3Tjot6ux/bY5dHq6CuFsTLPxeymT+sx8LPD43GztVym
         mRGJcV2n19S5HfU7UH9k251tIWWhYOh4+xg1tnEzRtIqbclGrL4bk0bDbW5I+ZRpvXxZ
         UQy9vK3cLb+z4pN8ixt2yC/OrHzDgWuw7E5G5SLVxaE0vnmASi2jEqBLjM8pV2DCa+UB
         3DQGi9dmfiwxGPkpEaw2wqyqszlIT+E0JAoCjB++iz370g2NvwkVXYVC61KAVMZa7M6o
         wNnvQdTy4CjYVRud/jjvt/xwm+4C5+QHQT3JQbFI7S3mD9gwUx77DH8Q4clwYOdpMQ9Y
         a9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/+uzcKU7N9eQQP3SFjSAD1qGow0LsUcOH+d4fY3c3w=;
        b=n5pjurgycZei+7c/7CGlVZXPjahGyXM26WbjYQyCG+ZgesJ8rvSwjQUtXpuFJRjMxw
         gJOPsShsLGBt6EPRc4+2TJRKM7ZHic6x1du/DqaClf+oqI1jpaVady9+nvGxJqfeALO1
         w/16TcNJH5QAiIMpJT3kJ4oxOrFKKicV8Ji7PuGeLCZbmr3rNcUeAcXXFGQgv4kFbS3s
         nPmtHJNw32AxYDABMHCEvOnaXQ7fbG9OY1mNGlaZy/euwq3+QlB9cYBuoMpem86/igCz
         7vM8NcIrl1G2HxOkHg5KHBn3IbuOl1KzgGaZ4tcgbPkQjecquFPCpo0khjJC4lIE5paQ
         s4Dw==
X-Gm-Message-State: APzg51CWUoUZDyAa79vS7A5gr+WtuoCFQxn8ZWiiIOhhlQIyxMiYQZea
        T1k43gemQHujfvW9mWEFdIqNK7/Tb2ewyLU6t5uz/Q==
X-Google-Smtp-Source: ANB0VdbgTqYTqa4kpQSPmXtdzjRnkn9ArZNSOXLClSPuNl5azuQFlVJyPxZcjiqFzF24RslAt8qttiOYMigW7C3IvJ0=
X-Received: by 2002:a9d:654a:: with SMTP id q10-v6mr4920228otl.256.1536948871100;
 Fri, 14 Sep 2018 11:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <2ce01d91-5fba-b1b7-2956-c8cc1853536d@intel.com>
 <33f96879-351f-674a-ca23-43f233f4eb1d@linux.vnet.ibm.com> <82d2b35c-272a-ad02-692f-2c109aacdfb6@oracle.com>
 <8569dabb-4930-aa20-6249-72457e2df51e@intel.com> <51145ccb-fc0d-0281-9757-fb8a5112ec24@oracle.com>
 <c72fea44-59f3-b106-8311-b5eae2d254e7@intel.com> <addeaadc-5ab2-f0c9-2194-dd100ae90f3a@oracle.com>
 <aaca3180-7510-c008-3e12-8bbe92344ef4@intel.com> <94ee0b6c-4663-0705-d4a8-c50342f6b483@oracle.com>
 <CAG48ez1YhHKTDHZoH2tEFaLk4LcCSw5G60=+KpGRaMQxvw1qLw@mail.gmail.com>
 <20180914062132.GI20287@dhcp22.suse.cz> <CAG48ez2RSn-EQkf-ahs41tOKpzt23JMGYZxUtWMRPe8c5jAq-A@mail.gmail.com>
 <a1834be4-0f8e-9d07-1013-7477d3a5e6be@oracle.com>
In-Reply-To: <a1834be4-0f8e-9d07-1013-7477d3a5e6be@oracle.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 14 Sep 2018 20:14:04 +0200
Message-ID: <CAG48ez2tDrz9VBx-9mpwVTqckPj-YTw6foF-Ecr8FKWXL9Zing@mail.gmail.com>
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node information
To:     Prakash Sangappa <prakash.sangappa@oracle.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        n-horiguchi@ah.jp.nec.com, Ulrich Drepper <drepper@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Horiguchi Naoya <nao.horiguchi@gmail.com>,
        steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 8:08 PM Prakash Sangappa
<prakash.sangappa@oracle.com> wrote:
> On 9/14/18 5:49 AM, Jann Horn wrote:
> > On Fri, Sep 14, 2018 at 8:21 AM Michal Hocko <mhocko@kernel.org> wrote:
> >> On Fri 14-09-18 03:33:28, Jann Horn wrote:
> >>> On Wed, Sep 12, 2018 at 10:43 PM prakash.sangappa
> >>> <prakash.sangappa@oracle.com> wrote:
> >>>> On 05/09/2018 04:31 PM, Dave Hansen wrote:
> >>>>> On 05/07/2018 06:16 PM, prakash.sangappa wrote:
> >>>>>> It will be /proc/<pid>/numa_vamaps. Yes, the behavior will be
> >>>>>> different with respect to seeking. Output will still be text and
> >>>>>> the format will be same.
> >>>>>>
> >>>>>> I want to get feedback on this approach.
> >>>>> I think it would be really great if you can write down a list of the
> >>>>> things you actually want to accomplish.  Dare I say: you need a
> >>>>> requirements list.
> >>>>>
> >>>>> The numa_vamaps approach continues down the path of an ever-growing list
> >>>>> of highly-specialized /proc/<pid> files.  I don't think that is
> >>>>> sustainable, even if it has been our trajectory for many years.
> >>>>>
> >>>>> Pagemap wasn't exactly a shining example of us getting new ABIs right,
> >>>>> but it sounds like something along those is what we need.
> >>>> Just sent out a V2 patch.  This patch simplifies the file content. It
> >>>> only provides VA range to numa node id information.
> >>>>
> >>>> The requirement is basically observability for performance analysis.
> >>>>
> >>>> - Need to be able to determine VA range to numa node id information.
> >>>>     Which also gives an idea of which range has memory allocated.
> >>>>
> >>>> - The proc file /proc/<pid>/numa_vamaps is in text so it is easy to
> >>>>     directly view.
> >>>>
> >>>> The V2 patch supports seeking to a particular process VA from where
> >>>> the application could read the VA to  numa node id information.
> >>>>
> >>>> Also added the 'PTRACE_MODE_READ_REALCREDS' check when opening the
> >>>> file /proc file as was indicated by Michal Hacko
> >>> procfs files should use PTRACE_MODE_*_FSCREDS, not PTRACE_MODE_*_REALCREDS.
> >> Out of my curiosity, what is the semantic difference? At least
> >> kernel_move_pages uses PTRACE_MODE_READ_REALCREDS. Is this a bug?
> > No, that's fine. REALCREDS basically means "look at the caller's real
> > UID for the access check", while FSCREDS means "look at the caller's
> > filesystem UID". The ptrace access check has historically been using
> > the real UID, which is sorta weird, but normally works fine. Given
> > that this is documented, I didn't see any reason to change it for most
> > things that do ptrace access checks, even if the EUID would IMO be
> > more appropriate. But things that capture caller credentials at points
> > like open() really shouldn't look at the real UID; instead, they
> > should use the filesystem UID (which in practice is basically the same
> > as the EUID).
> >
> > So in short, it depends on the interface you're coming through: Direct
> > syscalls use REALCREDS, things that go through the VFS layer use
> > FSCREDS.
>
> So in this case can the REALCREDS check be done in the read() system call
> when reading the /proc file instead of the open call?

No, REALCREDS shouldn't be used in open() and shouldn't be used in read().
FSCREDS can be used in open(); in theory, using ptrace_may_access() in
any way in read() is currently unsafe, but in practice, it's used that
way anyway. I have plans to clean that up eventually...
