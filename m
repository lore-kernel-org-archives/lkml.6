Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7C2C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B0720839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="U4q2uuyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B0720839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeILBaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:30:52 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46541 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbeILBaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:30:52 -0400
Received: by mail-ed1-f67.google.com with SMTP id k14-v6so20258033edr.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 13:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LPhGsIHjf7EgVEmAOdZo0zwEu84/eXjx7dDE3FxUxvk=;
        b=U4q2uuyClpFU9iFcqpu9Yb6m+RwawpuSkNwOXrht2WbP1IjUeHflKiJlfSoNtZ3JSd
         K4QM+9qqH1GvHcEV0Q9SK0bkRXWAhOJWgikR7sml432dizjARQnP519WgDKO0mFturQN
         /7WjhY5QvG6FKx37DEgdVAsTzyDraPqb+x0KPyxQ+Y0+9IY0G1mPhloNx2/avDCv1vS3
         1F+oC+QdRwo03CharcMEKX40hGBA4Bng/jP1gPVARveFK6GbbhUmnLRcjOYULmpml25v
         skNtXnzodr2dFATtPGZEdxfn3eyqhdhs7zZfmr/sV1bZdUXzYVuVy/FI4LG9viM8r6tT
         siRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LPhGsIHjf7EgVEmAOdZo0zwEu84/eXjx7dDE3FxUxvk=;
        b=rRQSITD87X7Z1us7FfrYlwwIbIHaoOM8oyH9bBl0+2PgovN/Darvr7XrJfNzSl9LvE
         lFLHg8UCKMDaKWP2H09EdMngV7EhXi0QSN5GzS4TRhfZeAlCloJLmTZ1MeONyTr6SrqC
         LANiQsBA7QkCrWA8ma1nxkfPhenZgrnIM8PzPAiNT0KklYKLAgPT3ibIc5oCqdTFo5pq
         G6a/oh1UrAL1ELyXOW7grbhqyKE20Ner6ua8FU1jSg3bHHJg2sfV8x2yzM656A+cKkir
         05qcMbK1iCKMM3/+xQliK/ZTRStHyI3yFfPmJlhdrkT/spBSlPFJW+QWS3LC5BXpAbYC
         g9lg==
X-Gm-Message-State: APzg51DNmp2pIZfeaTH8/FqEQ7cKaHQgh5YT6rVWj8F18SvVjTbeLJlL
        qvCqcaRd3Nr5fAoQ+P7TCFcVNQ==
X-Google-Smtp-Source: ANB0VdZbnZoQF2R780sVdO7WSBMcdDocPbAzyOiqakl0ssvdxEzl0dUrpbDqMuqsXGsGlVOAe6e1Mg==
X-Received: by 2002:aa7:c40a:: with SMTP id j10-v6mr30191152edq.134.1536697793039;
        Tue, 11 Sep 2018 13:29:53 -0700 (PDT)
Received: from cisco.cisco.com (85-220-54-220.dsl.dynamic.simnet.is. [85.220.54.220])
        by smtp.gmail.com with ESMTPSA id l48-v6sm10826055eda.94.2018.09.11.13.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 13:29:52 -0700 (PDT)
Date:   Tue, 11 Sep 2018 14:29:49 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>, suda.akihiro@lab.ntt.co.jp
Subject: Re: [PATCH v6 4/5] seccomp: add support for passing fds via
 USER_NOTIF
Message-ID: <20180911202949.GG3444@cisco.cisco.com>
References: <20180906152859.7810-1-tycho@tycho.ws>
 <20180906152859.7810-5-tycho@tycho.ws>
 <CAG48ez2oQnAb=OMGOUz0GfSWMsjqydPe8dmp6L=QswSQpSpVXA@mail.gmail.com>
 <20180906162246.GB3326@cisco.cisco.com>
 <20180906183018.GC3326@cisco.cisco.com>
 <CAG48ez0Dx+35fGcrBzzNRSOsmFhuiQBN+-S5+b3_9m9eWbLeQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0Dx+35fGcrBzzNRSOsmFhuiQBN+-S5+b3_9m9eWbLeQQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 07:00:43PM +0200, Jann Horn wrote:
> On Thu, Sep 6, 2018 at 8:30 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > On Thu, Sep 06, 2018 at 10:22:46AM -0600, Tycho Andersen wrote:
> > > On Thu, Sep 06, 2018 at 06:15:18PM +0200, Jann Horn wrote:
> > > > On Thu, Sep 6, 2018 at 5:29 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > > > > The idea here is that the userspace handler should be able to pass an fd
> > > > > back to the trapped task, for example so it can be returned from socket().
> > > > [...]
> > > > > diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
> > > > > index d1498885c1c7..1c0aab306426 100644
> > > > > --- a/Documentation/userspace-api/seccomp_filter.rst
> > > > > +++ b/Documentation/userspace-api/seccomp_filter.rst
> > > > > @@ -235,6 +235,9 @@ The interface for a seccomp notification fd consists of two structures:
> > > > >          __u64 id;
> > > > >          __s32 error;
> > > > >          __s64 val;
> > > > > +        __u8 return_fd;
> > > > > +        __u32 fd;
> > > > > +        __u32 fd_flags;
> > > >
> > > > Normally,  syscalls that take an optional file descriptor accept a
> > > > signed 32-bit number, with -1 standing for "no file descriptor". Is
> > > > there a reason why this uses a separate variable to signal whether an
> > > > fd was provided?
> > >
> > > No real reason other than I looked at the bpf code and they were using
> > > __u32 for bpf (but I think in their case the fd args are not
> > > optional). I'll switch it to __s32/-1 for the next version.
> >
> > Oh, I think there is a reason actually: since this is an API addition,
> > the "0" value needs to be the previously default behavior if userspace
> > doesn't specify it. Since the previously default behavior was not to
> > return an fd, and we want to allow fd == 0, we need the extra flag to
> > make this work.
> >
> > This is really only a problem because we're introducing this stuff in
> > a second patch (mostly to illustrate how extending the response
> > structure would work). I could fold this into the first patch if we
> > want, or we could keep the return_fd bits if the illustration is
> > useful.
> 
> I feel like adding extra struct fields just so that it is possible to
> write programs against the intermediate new API between two kernel
> commits is taking things a bit far.

Yep, I tend to agree with you. I'll fold the whole thing into the
first patch for the next version.

Tycho
