Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42875C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CECA2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcyuQXbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfBVTfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:35:03 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43389 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfBVTfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:35:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id m10so1514093plt.10;
        Fri, 22 Feb 2019 11:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gH7xotXdQAwAgaSglUrReQ/sVHSX+EVbzBTwLX0BHOA=;
        b=LcyuQXbrtLQQ7icLYjdeo/eNu8cn3IPr9IMu9O8ly4Ulg13HueqXzrH/jABYt3N2/t
         7lPUVzmBON768/FQWvf2CGNQzkM46XmnnBsI5NmMW3YZNSK4v6dbdIzHJ86RS+F4LVzs
         F2gqbR4GlmEsU7MndBYojmd1Ew0L8e+PjYcN2gdOyvr2FgCcR/BRuyaKz+VqiZFJa2jU
         +z8wS3ZDlU3kLO6lQuVowtriUvvZqqbYilCoqZ0B14QxduFwKC0zZt31HUjKnDjvLByz
         NlHkxrW5y7UnaaUG2XagxJy7xu0fK69uJKYrwm9Ez2Xe1vlYQOC0FqgIXFqo70LVvuzq
         krLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gH7xotXdQAwAgaSglUrReQ/sVHSX+EVbzBTwLX0BHOA=;
        b=nw9+DtZLkT2ttJ+oveZADAXDu9Ap28YpaEXXZhulzRPyCnfF1jOJ5eU+f4ym0fg/wM
         8tJ4KOtlcgR2pmIto2JRMXKVl9t5HTVsCLmcAhelzcoDROEUC0hBZ0a2Wl1RoY+bJFGj
         9Tza4pZOI+1I48Feew7AMmfaqbcqqKBuceW0MLrzyhK1jO9p1DM3vHIrwXhi15m79FoL
         FyonDwQ7AsWCZVD87nz23UwF6AlYQa1lDIpHbS/qrTAfGW0S3NrQCGAInf5F2vEoW4Fq
         92Ei5IEAnSQrwjAaGnngh49bGt4jgvxszuzaeVLWR1Gq3FS54Q9hW/qdBJeQHCzviKJU
         Fylg==
X-Gm-Message-State: AHQUAuYMdkvNEsdmIH7oDJaT8MeJnAd6wd0HJ/rDaDSy9CIAJKo2ZLNP
        ysljkx2EKRbQ/st/KIhWOu/84eIg
X-Google-Smtp-Source: AHgI3IaQpW+QYkdUJ84Y4HD5WqnJuC9KdpufcZAENqwZH7X8MK8eESUgpXzc86Q9+6Qx6wyhS8ARWQ==
X-Received: by 2002:a17:902:1:: with SMTP id 1mr5492441pla.276.1550864101584;
        Fri, 22 Feb 2019 11:35:01 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::4:1d52])
        by smtp.gmail.com with ESMTPSA id u24sm3114817pfm.140.2019.02.22.11.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 11:35:00 -0800 (PST)
Date:   Fri, 22 Feb 2019 11:34:58 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-ID: <20190222193456.5vqppubzrcx5wsul@ast-mbp.dhcp.thefacebook.com>
References: <20190219111802.1d6dbaa3@gandalf.local.home>
 <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com>
 <20190219140330.5dd9e876@gandalf.local.home>
 <20190220171019.5e81a4946b56982f324f7c45@kernel.org>
 <20190220094926.0ab575b3@gandalf.local.home>
 <20190222172745.2c7205d62003c0a858e33278@kernel.org>
 <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org>
 <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
 <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
 <20190222143026.17d6f0f6@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222143026.17d6f0f6@gandalf.local.home>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 02:30:26PM -0500, Steven Rostedt wrote:
> On Fri, 22 Feb 2019 11:27:05 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > On Fri, Feb 22, 2019 at 09:43:14AM -0800, Linus Torvalds wrote:
> > > 
> > > Then we should still probably fix up "__probe_kernel_read()" to not
> > > allow user accesses. The easiest way to do that is actually likely to
> > > use the "unsafe_get_user()" functions *without* doing a
> > > uaccess_begin(), which will mean that modern CPU's will simply fault
> > > on a kernel access to user space.  
> > 
> > On bpf side the bpf_probe_read() helper just calls probe_kernel_read()
> > and users pass both user and kernel addresses into it and expect
> > that the helper will actually try to read from that address.
> > 
> > If __probe_kernel_read will suddenly start failing on all user addresses
> > it will break the expectations.
> > How do we solve it in bpf_probe_read?
> > Call probe_kernel_read and if that fails call unsafe_get_user byte-by-byte
> > in the loop?
> > That's doable, but people already complain that bpf_probe_read() is slow
> > and shows up in their perf report.
> 
> We're changing kprobes to add a specific flag to say that we want to
> differentiate between kernel or user reads. Can this be done with
> bpf_probe_read()? If it's showing up in perf report, I doubt a single

so you're saying you will break existing kprobe scripts?
I don't think it's a good idea.
It's not acceptable to break bpf_probe_read uapi.

