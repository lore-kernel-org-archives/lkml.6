Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61539C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C81217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NZRO0WBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeLRRBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:01:03 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44515 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeLRRBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:01:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id e11so7434734plt.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 09:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wKfBD+1TWHumVfsMrPC4aOQgIX8YOMlpHV8EfXJQskI=;
        b=NZRO0WBOmXYaCt2QaGafqiwF560MwTfn8c9bS3YlTlZ9ETPzDCXoiucWxPUTIC8Dqv
         e+71xa9Ms4uoxIEVBNjUHuQ/e68465/EKuWyRUhRTId9vOInTl7W2ql2HWQz6ZhaY+he
         qV/Ki/qcDHvcjfiPnPyOHetRCmwR5PXsBoAfXWAYSydqLCLiPIIakO3RFud65WQf3yau
         +vPcUOOO1jQ04NBo49CRRWPH9ARxYP0uMdnZ2XMS3I0f/uc0tZYRvAwe/zNNztM7HTjo
         UZKN1JNG5/9VGQu1cTTMrM/RkGqXQ7iJtNurEetzIPXjbdHQWemq+NiJibYhvcKbW7VH
         OYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wKfBD+1TWHumVfsMrPC4aOQgIX8YOMlpHV8EfXJQskI=;
        b=GTCvthriy+g+0CXq268Fa3PnubWdiLBDNwq+08TQorUP7LTl5BMR8U060AALr+Skvi
         c0T4BxxJruOF1doJVB9qUhFKzwRwG7IClzw4WZbvhEnymPuolr4+AjCHPJync10OOrfh
         pq3OX645zK6BD2SfFwlcQ43C8ojfR+ZoFKpGRpOM1QXYSs4pFyL8lpOGbNzJHCC7oVzH
         24ytdcVZsBH+QN8brLesLBOI3vg5uAmpH2fyvRp4EXPL9OSbKmvt5A11SldSNAaZnjmU
         KYxwxJDCSDdlDGOJD+HepDS1B2L79Gfek6QORxPq5EmORTXIIXkpoEixn/AeHZYJYIz+
         OK/w==
X-Gm-Message-State: AA+aEWYUODuNT2gYOaYtuLQGW9W3njfY9YWzeZn2+5nuM0uy9riBXEyG
        8X2T+R5GGJojKCZ0hIn9ItwPbw==
X-Google-Smtp-Source: AFSGD/XqMC2UHP1KF6Zf/WkHRSbloplmM1Cp2DZmNERG9zF6MIJ7GQERboy0iAnUrJW0TzPoq//Q5Q==
X-Received: by 2002:a17:902:3064:: with SMTP id u91mr16785746plb.325.1545152461384;
        Tue, 18 Dec 2018 09:01:01 -0800 (PST)
Received: from google.com ([2620:15c:17:4:f0b1:8ff5:16a0:5f15])
        by smtp.gmail.com with ESMTPSA id e16sm20838794pfn.46.2018.12.18.09.00.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 09:01:00 -0800 (PST)
Date:   Tue, 18 Dec 2018 09:00:55 -0800
From:   Tom Roeder <tmroeder@google.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts: add a tool to produce a compile_commands.json
 file
Message-ID: <20181218170055.GA7794@google.com>
References: <20181206222318.218157-1-tmroeder@google.com>
 <CAK7LNATZm6T9bjcAxB_WQw-um-Hjkhiew6qg8CRLayr8qYzLeQ@mail.gmail.com>
 <20181217214022.GA38778@google.com>
 <CAK7LNATG9y04UdJ-Z5AwLHXUcnbWo5Butee0pkL+MFzds04wCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATG9y04UdJ-Z5AwLHXUcnbWo5Butee0pkL+MFzds04wCA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 11:17:35AM +0900, Masahiro Yamada wrote:
> On Tue, Dec 18, 2018 at 8:21 AM Tom Roeder <tmroeder@google.com> wrote:
> >
> > On Sat, Dec 15, 2018 at 06:37:49PM +0900, Masahiro Yamada wrote:
> > > On Fri, Dec 7, 2018 at 7:24 AM Tom Roeder <tmroeder@google.com> wrote:
> > > >
> > > > The LLVM/Clang project provides many tools for analyzing C source code.
> > > > Many of these tools are based on LibTooling
> > > > (https://clang.llvm.org/docs/LibTooling.html), which depends on a
> > > > database of compiler flags. The standard container for this database is
> > > > compile_commands.json, which consists of a list of JSON objects, each
> > > > with "directory", "file", and "command" fields.
> > > >
> > > > Some build systems, like cmake or bazel, produce this compilation
> > > > information directly. Naturally, Makefiles don't. However, the kernel
> > > > makefiles already create .<target>.o.cmd files that contain all the
> > > > information needed to build a compile_commands.json file.
> > > >
> > > > So, this commit adds scripts/gen_compile_commands.py, which recursively
> > > > searches through a directory for .<target>.o.cmd files and extracts
> > > > appropriate compile commands from them. It writes a
> > > > compile_commands.json file that LibTooling-based tools can use.
> > > >
> > > > By default, gen_compile_commands.py starts its search in its working
> > > > directory and (over)writes compile_commands.json in the working
> > > > directory. However, it also supports --output and --directory flags for
> > > > out-of-tree use.
> > > >
> > > > Note that while gen_compile_commands.py enables the use of clang-based
> > > > tools, it does not require the kernel to be compiled with clang. E.g.,
> > > > the following sequence of commands produces a compile_commands.json file
> > > > that works correctly with LibTooling.
> > > >
> > > > make defconfig
> > > > make
> > > > scripts/gen_compile_commands.py
> > > >
> > > > Also note that this script is written to work correctly in both Python 2
> > > > and Python 3, so it does not specify the Python version in its first
> > > > line.
> > > >
> > > > For an example of the utility of this script: after running
> > > > gen_compile_commands.json on the latest kernel version, I was able to
> > > > use Vim + the YouCompleteMe pluging + clangd to automatically jump to
> > > > definitions and declarations. Obviously, cscope and ctags provide some
> > > > of this functionality; the advantage of supporting LibTooling is that it
> > > > opens the door to many other clang-based tools that understand the code
> > > > directly and do not rely on regular expressions and heuristics.
> > > >
> > > > Tested: Built several recent kernel versions and ran the script against
> > > > them, testing tools like clangd (for editor/LSP support) and clang-check
> > > > (for static analysis). Also extracted some test .cmd files from a kernel
> > > > build and wrote a test script to check that the script behaved correctly
> > > > with all permutations of the --output and --directory flags.
> > > >
> > > > Signed-off-by: Tom Roeder <tmroeder@google.com>
> > >
> > >
> > > I am fine with this,
> > > but I have one question.
> > >
> > > The generated compile_commands.json
> > > contains $(pound)
> >
> > To make sure we're talking about the same thing: the instances that I've
> > seen of "#" occur in macro definitions in the "command" field in some of
> > the JSON objects. For example, I see things like
> > -D\"KBUILD_STR(s)=\\#s\".
> 
> 
> 
> When I ran this tool against the latest kernel
> (specifically, since commit 9564a8cf)
> I saw the following in "command" field.
> 
> -D\"BUILD_STR(s)=$(pound)s\"
> 
> 
> I am not sure whether it is a problem or not.

Thanks! I can reproduce this; I see this happening in, e.g., objtool's
.cmd files. I guess I failed to test recent enough versions of the
kernel or didn't notice this case. It looks like that commit changes the
handling of the pound sign in .cmd files, so it's highly relevant.

> 
> I do not care about this tool much.
> I will queue up this patch shortly if it is OK with you.

I'd like this tool to work properly on those files, so please don't
queue up the patch yet. I'll get it to handle the "$(pound)" case and
send a revised patch.

> 
> 
> Thanks.
> 
> 
> > >
> > > How is it handled?
> >
> > The Python json module takes care of escaping the output to make a valid
> > JSON string for the "command" field. The gen_compile_commands.py script
> > doesn't take any special action for that or any other character in its
> > output.
> >
> > > Should it be replaced with '\#' ?
> >
> > I don't think it needs to be changed, given my experience with this
> > script and its testing so far: the output seems to work for me. However,
> > are you running into problems due to the presence of this character or
> > inadequate escaping? Please let me know, and I'd be happy to look into
> > it.
> >
> > Tom
> 
> 
> 
> --
> Best Regards
> Masahiro Yamada
