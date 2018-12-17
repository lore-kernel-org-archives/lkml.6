Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C549C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D8320874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jX2P+Zu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732058AbeLQVk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:40:28 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37563 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbeLQVk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:40:28 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so7014024pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 13:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tRqDX3mvbAKAnKDtvep2dsCs/MxLTiDqqvg91a+H7gw=;
        b=jX2P+Zu1EKzHOg06kJmhb2Ih+p+ePF5hoi7VPhnoGFKyPMMMvwpDALriktE6bq2Y9e
         786y9XQQ7UYYqYgOwzKioPG1/UTjvqYCSkuFzcSVmcz2jb1EUCrDc4L75r0GWpEJd+P8
         u3wWoBypPdPyiXOZ0VeI8zKmeW1vF7KgdRF/t6cxuAsz1uVSWLo9vn629w572nu93CZ3
         NOU3dI5LzFOAcM++iJhbZ6VGepBnJAbYPNc12PNJR0INLEVKTrBBORHqYxQKyNc8N+YN
         +ZMxcMqUpPRazwzS9BvXJwHsAopR3dQz4mvlKgARCw8P7DLkoARDhOdT/58YRPg1/BB2
         qEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tRqDX3mvbAKAnKDtvep2dsCs/MxLTiDqqvg91a+H7gw=;
        b=eM3sF2YPm/Q2747x3ds0Zjod8v5yMal7cUENaAP2PgB7+/i2svL+UqlFu9r0YujOqc
         Qi1xChFi6RqIIXF+bJsO82+n7X2fmouGUPRQbmq87600C/SnLJGzc8DHIiioKLwxprjG
         z2OxXzPufd5Ujax6vxxQ+AnHVZgPowuxLm4S0MtY7Z1uiL6ftkGspZR6bW/khL4iVnTr
         LnMf4RPqQRDV9kxSZrfoRUCMN9ZlFGvnsR9jqer10mEHTXWlH0ytsYbduR19UdOMczEc
         bFSlTNLcvaH0csu4fdwokE95aM3jlGHtU8bPvNLmtx14ZcmyDr243hSNUqoDwyEMKuD/
         OdYQ==
X-Gm-Message-State: AA+aEWYmoMb6k+EeLy671qC7fEzljqPtIgLsbzUg6eyiHzeYSckuz8Lt
        vhz2EWOv5PWIzgwIAV6gwzIktP4xc38R5Q==
X-Google-Smtp-Source: AFSGD/Xy9fEYONQd+4SQVofmVK5VLhj4Ju8rmGOJjtGoqYsL1htQmydtKv7EueapA+M1StCCkoVEDA==
X-Received: by 2002:a62:c101:: with SMTP id i1mr14269517pfg.80.1545082826824;
        Mon, 17 Dec 2018 13:40:26 -0800 (PST)
Received: from google.com ([2620:15c:17:4:f0b1:8ff5:16a0:5f15])
        by smtp.gmail.com with ESMTPSA id k14sm19189290pgs.52.2018.12.17.13.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 13:40:25 -0800 (PST)
Date:   Mon, 17 Dec 2018 13:40:22 -0800
From:   Tom Roeder <tmroeder@google.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts: add a tool to produce a compile_commands.json
 file
Message-ID: <20181217214022.GA38778@google.com>
References: <20181206222318.218157-1-tmroeder@google.com>
 <CAK7LNATZm6T9bjcAxB_WQw-um-Hjkhiew6qg8CRLayr8qYzLeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATZm6T9bjcAxB_WQw-um-Hjkhiew6qg8CRLayr8qYzLeQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 06:37:49PM +0900, Masahiro Yamada wrote:
> On Fri, Dec 7, 2018 at 7:24 AM Tom Roeder <tmroeder@google.com> wrote:
> >
> > The LLVM/Clang project provides many tools for analyzing C source code.
> > Many of these tools are based on LibTooling
> > (https://clang.llvm.org/docs/LibTooling.html), which depends on a
> > database of compiler flags. The standard container for this database is
> > compile_commands.json, which consists of a list of JSON objects, each
> > with "directory", "file", and "command" fields.
> >
> > Some build systems, like cmake or bazel, produce this compilation
> > information directly. Naturally, Makefiles don't. However, the kernel
> > makefiles already create .<target>.o.cmd files that contain all the
> > information needed to build a compile_commands.json file.
> >
> > So, this commit adds scripts/gen_compile_commands.py, which recursively
> > searches through a directory for .<target>.o.cmd files and extracts
> > appropriate compile commands from them. It writes a
> > compile_commands.json file that LibTooling-based tools can use.
> >
> > By default, gen_compile_commands.py starts its search in its working
> > directory and (over)writes compile_commands.json in the working
> > directory. However, it also supports --output and --directory flags for
> > out-of-tree use.
> >
> > Note that while gen_compile_commands.py enables the use of clang-based
> > tools, it does not require the kernel to be compiled with clang. E.g.,
> > the following sequence of commands produces a compile_commands.json file
> > that works correctly with LibTooling.
> >
> > make defconfig
> > make
> > scripts/gen_compile_commands.py
> >
> > Also note that this script is written to work correctly in both Python 2
> > and Python 3, so it does not specify the Python version in its first
> > line.
> >
> > For an example of the utility of this script: after running
> > gen_compile_commands.json on the latest kernel version, I was able to
> > use Vim + the YouCompleteMe pluging + clangd to automatically jump to
> > definitions and declarations. Obviously, cscope and ctags provide some
> > of this functionality; the advantage of supporting LibTooling is that it
> > opens the door to many other clang-based tools that understand the code
> > directly and do not rely on regular expressions and heuristics.
> >
> > Tested: Built several recent kernel versions and ran the script against
> > them, testing tools like clangd (for editor/LSP support) and clang-check
> > (for static analysis). Also extracted some test .cmd files from a kernel
> > build and wrote a test script to check that the script behaved correctly
> > with all permutations of the --output and --directory flags.
> >
> > Signed-off-by: Tom Roeder <tmroeder@google.com>
> 
> 
> I am fine with this,
> but I have one question.
> 
> The generated compile_commands.json
> contains $(pound)

To make sure we're talking about the same thing: the instances that I've
seen of "#" occur in macro definitions in the "command" field in some of
the JSON objects. For example, I see things like
-D\"KBUILD_STR(s)=\\#s\".

> 
> How is it handled?

The Python json module takes care of escaping the output to make a valid
JSON string for the "command" field. The gen_compile_commands.py script
doesn't take any special action for that or any other character in its
output.

> Should it be replaced with '\#' ?

I don't think it needs to be changed, given my experience with this
script and its testing so far: the output seems to work for me. However,
are you running into problems due to the presence of this character or
inadequate escaping? Please let me know, and I'd be happy to look into
it.

Tom
