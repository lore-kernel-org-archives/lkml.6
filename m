Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00752C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744682080D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HMR5bTEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeLRCS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 21:18:29 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:40861 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeLRCS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 21:18:28 -0500
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id wBI2IBtk004163;
        Tue, 18 Dec 2018 11:18:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wBI2IBtk004163
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545099492;
        bh=VzYyZlBs9l9a4wKUe+GOU2F9FqBEVqzHNMXtuwDeOwM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HMR5bTEUqaGe3jwKM9p4RShBtgirwR8HAGNfBHzi4ac2ANfX7V0T69/jk9Fa+R9T4
         IoMBdNt18co1hUyT6imHxO1JH/OWU08AK6GOoRT5dsHhxlu18VJeuEAZf8dFMhGiAo
         rLn4TGXE2/qqcWvmr6F2ydqyzD09oEEwLieIKzttz8Zpe4QAux8MrWFEGjCCGoEZ0X
         973PkJ0MJnFO0BiwxFG8OrcDcuSXZrPjL/UBJZuzqRCkI9Qqn5kI7jl4Ku7DJF6SP/
         d83vF2g3TSZnYI/KoWAaB8C1k1ERq3FzdTJyhx4IGvkifcRHSY5tBp0RaGr1ydvv0e
         uF3jpRTXTdtlA==
X-Nifty-SrcIP: [209.85.221.172]
Received: by mail-vk1-f172.google.com with SMTP id 185so1658788vkc.3;
        Mon, 17 Dec 2018 18:18:12 -0800 (PST)
X-Gm-Message-State: AA+aEWZdCWI4g5gg2RnmdNUVPyWo7XHLPRg7fNWQg0wHneQ4jZYYdKuP
        fZRwDc9RB1swQfyMNTp8BFsY/0KJTK3nrtWjGe4=
X-Google-Smtp-Source: AFSGD/V/rM2GgwQXgK74GxSia7e42Zhxk+WqDbfO+L9odRM0J7yX3uL6RV+QiD7z5+G9e7VPe6bqKOgMspQrQeXEKfs=
X-Received: by 2002:a1f:4d47:: with SMTP id a68mr6764028vkb.34.1545099491241;
 Mon, 17 Dec 2018 18:18:11 -0800 (PST)
MIME-Version: 1.0
References: <20181206222318.218157-1-tmroeder@google.com> <CAK7LNATZm6T9bjcAxB_WQw-um-Hjkhiew6qg8CRLayr8qYzLeQ@mail.gmail.com>
 <20181217214022.GA38778@google.com>
In-Reply-To: <20181217214022.GA38778@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 18 Dec 2018 11:17:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNATG9y04UdJ-Z5AwLHXUcnbWo5Butee0pkL+MFzds04wCA@mail.gmail.com>
Message-ID: <CAK7LNATG9y04UdJ-Z5AwLHXUcnbWo5Butee0pkL+MFzds04wCA@mail.gmail.com>
Subject: Re: [PATCH] scripts: add a tool to produce a compile_commands.json file
To:     Tom Roeder <tmroeder@google.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 8:21 AM Tom Roeder <tmroeder@google.com> wrote:
>
> On Sat, Dec 15, 2018 at 06:37:49PM +0900, Masahiro Yamada wrote:
> > On Fri, Dec 7, 2018 at 7:24 AM Tom Roeder <tmroeder@google.com> wrote:
> > >
> > > The LLVM/Clang project provides many tools for analyzing C source code.
> > > Many of these tools are based on LibTooling
> > > (https://clang.llvm.org/docs/LibTooling.html), which depends on a
> > > database of compiler flags. The standard container for this database is
> > > compile_commands.json, which consists of a list of JSON objects, each
> > > with "directory", "file", and "command" fields.
> > >
> > > Some build systems, like cmake or bazel, produce this compilation
> > > information directly. Naturally, Makefiles don't. However, the kernel
> > > makefiles already create .<target>.o.cmd files that contain all the
> > > information needed to build a compile_commands.json file.
> > >
> > > So, this commit adds scripts/gen_compile_commands.py, which recursively
> > > searches through a directory for .<target>.o.cmd files and extracts
> > > appropriate compile commands from them. It writes a
> > > compile_commands.json file that LibTooling-based tools can use.
> > >
> > > By default, gen_compile_commands.py starts its search in its working
> > > directory and (over)writes compile_commands.json in the working
> > > directory. However, it also supports --output and --directory flags for
> > > out-of-tree use.
> > >
> > > Note that while gen_compile_commands.py enables the use of clang-based
> > > tools, it does not require the kernel to be compiled with clang. E.g.,
> > > the following sequence of commands produces a compile_commands.json file
> > > that works correctly with LibTooling.
> > >
> > > make defconfig
> > > make
> > > scripts/gen_compile_commands.py
> > >
> > > Also note that this script is written to work correctly in both Python 2
> > > and Python 3, so it does not specify the Python version in its first
> > > line.
> > >
> > > For an example of the utility of this script: after running
> > > gen_compile_commands.json on the latest kernel version, I was able to
> > > use Vim + the YouCompleteMe pluging + clangd to automatically jump to
> > > definitions and declarations. Obviously, cscope and ctags provide some
> > > of this functionality; the advantage of supporting LibTooling is that it
> > > opens the door to many other clang-based tools that understand the code
> > > directly and do not rely on regular expressions and heuristics.
> > >
> > > Tested: Built several recent kernel versions and ran the script against
> > > them, testing tools like clangd (for editor/LSP support) and clang-check
> > > (for static analysis). Also extracted some test .cmd files from a kernel
> > > build and wrote a test script to check that the script behaved correctly
> > > with all permutations of the --output and --directory flags.
> > >
> > > Signed-off-by: Tom Roeder <tmroeder@google.com>
> >
> >
> > I am fine with this,
> > but I have one question.
> >
> > The generated compile_commands.json
> > contains $(pound)
>
> To make sure we're talking about the same thing: the instances that I've
> seen of "#" occur in macro definitions in the "command" field in some of
> the JSON objects. For example, I see things like
> -D\"KBUILD_STR(s)=\\#s\".



When I ran this tool against the latest kernel
(specifically, since commit 9564a8cf)
I saw the following in "command" field.

-D\"BUILD_STR(s)=$(pound)s\"


I am not sure whether it is a problem or not.

I do not care about this tool much.
I will queue up this patch shortly if it is OK with you.


Thanks.


> >
> > How is it handled?
>
> The Python json module takes care of escaping the output to make a valid
> JSON string for the "command" field. The gen_compile_commands.py script
> doesn't take any special action for that or any other character in its
> output.
>
> > Should it be replaced with '\#' ?
>
> I don't think it needs to be changed, given my experience with this
> script and its testing so far: the output seems to work for me. However,
> are you running into problems due to the presence of this character or
> inadequate escaping? Please let me know, and I'd be happy to look into
> it.
>
> Tom



--
Best Regards
Masahiro Yamada
