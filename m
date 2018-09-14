Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CFDFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0953D20881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RdCWHZnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0953D20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeINSD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:03:58 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43581 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbeINSD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:03:58 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so12665629oib.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 05:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7A6O2BcKYRPioMxQvvtW9I/pCVYvSd2RJi2MmjtB5vM=;
        b=RdCWHZnVYERbLHURQUmft1nogrUjQaUmRUrCMWuHZpnXYMNmqgxeQyCBTxrWYA1h2J
         90ODzHOk8CHDNTNJEPKdP6gNhoZOJX4PTgG6ca/tJfOHe2M/FmABhm3N3BP7FeBgel+b
         sZ92yHbNQxtntnF5T+EDih8V2T6rOzwJw9gyJDcLfDK2mveDE4lpecPdtXJmx/KAyhd6
         Q98kIv8h7UoUTqAXchXlthZJm3NAsaGoUP5PqZTVmOl/xMbXr6TsATSJJTBqc35XbIS2
         y7yJin1C4jly8v8o5LseI8rku4FRUyleqL7Z6pPVbing3E6gEemUN4+jPb99Tnq+ww7t
         KzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7A6O2BcKYRPioMxQvvtW9I/pCVYvSd2RJi2MmjtB5vM=;
        b=Z6qK/URGziWUzpIGHOBqlcSMIGrIi2JerrTTHuDomjqHy/iEyxZ5b6w2vpPSxz1onl
         XK1B7nzrAij3yeYN6I8e+8iNAmlXTzRuAYm/tz3dW72YBe0QHKObSDyRx4jrQt9/x5kx
         NVLesHPy66Z44hOa6z2lB+x4QfP3+sztn6llt8ITXVA0OrkDBwqs6GagE4Y25uBYOV18
         /fVNcoD5jfL95Jcfh6Nkaag5i6eBXfC3Qvo2F6fcbau7NroPTasNXCJSwYlAGUWPGl1L
         Wpwbp8tubJmvTRYeEPYZb46qpMWX0HnyVdbSAnDATobG7NgLQ6ayQIujKXrRz38R0A1O
         br9Q==
X-Gm-Message-State: APzg51BcB3HrdNkt1h0tfoSf4Gd4XNqYC4qMcct+ztSLTA2O6C9C1OlW
        nPrQqv4NQiID7DcFM06GyFdFT/V66ZFQt13hQYiA5g==
X-Google-Smtp-Source: ANB0VdYYuOnBYcIIIXY7sC7vyP/BCS0JP3n1jclEBtaqGKFyyh7H3zHa50uQ6B0WTAFoHAlMS/ktBhSMd8CZ5UgnaPE=
X-Received: by 2002:aca:a94c:: with SMTP id s73-v6mr9191098oie.68.1536929376773;
 Fri, 14 Sep 2018 05:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <2ce01d91-5fba-b1b7-2956-c8cc1853536d@intel.com>
 <33f96879-351f-674a-ca23-43f233f4eb1d@linux.vnet.ibm.com> <82d2b35c-272a-ad02-692f-2c109aacdfb6@oracle.com>
 <8569dabb-4930-aa20-6249-72457e2df51e@intel.com> <51145ccb-fc0d-0281-9757-fb8a5112ec24@oracle.com>
 <c72fea44-59f3-b106-8311-b5eae2d254e7@intel.com> <addeaadc-5ab2-f0c9-2194-dd100ae90f3a@oracle.com>
 <aaca3180-7510-c008-3e12-8bbe92344ef4@intel.com> <94ee0b6c-4663-0705-d4a8-c50342f6b483@oracle.com>
 <CAG48ez1YhHKTDHZoH2tEFaLk4LcCSw5G60=+KpGRaMQxvw1qLw@mail.gmail.com> <20180914062132.GI20287@dhcp22.suse.cz>
In-Reply-To: <20180914062132.GI20287@dhcp22.suse.cz>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 14 Sep 2018 14:49:10 +0200
Message-ID: <CAG48ez2RSn-EQkf-ahs41tOKpzt23JMGYZxUtWMRPe8c5jAq-A@mail.gmail.com>
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node information
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Prakash Sangappa <prakash.sangappa@oracle.com>,
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

On Fri, Sep 14, 2018 at 8:21 AM Michal Hocko <mhocko@kernel.org> wrote:
> On Fri 14-09-18 03:33:28, Jann Horn wrote:
> > On Wed, Sep 12, 2018 at 10:43 PM prakash.sangappa
> > <prakash.sangappa@oracle.com> wrote:
> > > On 05/09/2018 04:31 PM, Dave Hansen wrote:
> > > > On 05/07/2018 06:16 PM, prakash.sangappa wrote:
> > > >> It will be /proc/<pid>/numa_vamaps. Yes, the behavior will be
> > > >> different with respect to seeking. Output will still be text and
> > > >> the format will be same.
> > > >>
> > > >> I want to get feedback on this approach.
> > > > I think it would be really great if you can write down a list of the
> > > > things you actually want to accomplish.  Dare I say: you need a
> > > > requirements list.
> > > >
> > > > The numa_vamaps approach continues down the path of an ever-growing list
> > > > of highly-specialized /proc/<pid> files.  I don't think that is
> > > > sustainable, even if it has been our trajectory for many years.
> > > >
> > > > Pagemap wasn't exactly a shining example of us getting new ABIs right,
> > > > but it sounds like something along those is what we need.
> > >
> > > Just sent out a V2 patch.  This patch simplifies the file content. It
> > > only provides VA range to numa node id information.
> > >
> > > The requirement is basically observability for performance analysis.
> > >
> > > - Need to be able to determine VA range to numa node id information.
> > >    Which also gives an idea of which range has memory allocated.
> > >
> > > - The proc file /proc/<pid>/numa_vamaps is in text so it is easy to
> > >    directly view.
> > >
> > > The V2 patch supports seeking to a particular process VA from where
> > > the application could read the VA to  numa node id information.
> > >
> > > Also added the 'PTRACE_MODE_READ_REALCREDS' check when opening the
> > > file /proc file as was indicated by Michal Hacko
> >
> > procfs files should use PTRACE_MODE_*_FSCREDS, not PTRACE_MODE_*_REALCREDS.
>
> Out of my curiosity, what is the semantic difference? At least
> kernel_move_pages uses PTRACE_MODE_READ_REALCREDS. Is this a bug?

No, that's fine. REALCREDS basically means "look at the caller's real
UID for the access check", while FSCREDS means "look at the caller's
filesystem UID". The ptrace access check has historically been using
the real UID, which is sorta weird, but normally works fine. Given
that this is documented, I didn't see any reason to change it for most
things that do ptrace access checks, even if the EUID would IMO be
more appropriate. But things that capture caller credentials at points
like open() really shouldn't look at the real UID; instead, they
should use the filesystem UID (which in practice is basically the same
as the EUID).

So in short, it depends on the interface you're coming through: Direct
syscalls use REALCREDS, things that go through the VFS layer use
FSCREDS.
