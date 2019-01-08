Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F6FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160E82084D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbfAHXrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 18:47:40 -0500
Received: from ms.lwn.net ([45.79.88.28]:60714 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbfAHXrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 18:47:39 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AEF74286;
        Tue,  8 Jan 2019 23:47:38 +0000 (UTC)
Date:   Tue, 8 Jan 2019 16:47:37 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 0/2] Revamp admin-guide/tainted-kernels.rst to make
 it more comprehensible
Message-ID: <20190108164737.0c2539a6@lwn.net>
In-Reply-To: <20190108194007.29439-1-linux@leemhuis.info>
References: <20190108194007.29439-1-linux@leemhuis.info>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  8 Jan 2019 20:40:05 +0100
Thorsten Leemhuis <linux@leemhuis.info> wrote:

> Hi! This is the second version of my patch to make
> admin-guide/tainted-kernels.rst more comprehensible. It got triggered while
> working on an update for reporting-bugs.rst, as improving the documentation
> around reporting bugs and regressions was one of the main things that a lot of
> people wanted to see while regression tracking was discussed in the kernel and
> maintainer summit 2017 in Prague.
> 
> This is the second version of the patch, which became a patch set, as it now
> contains a script Randy (thx) provided during the discussion of the first
> version. 
> 
> Please review and consider applying.

OK, so we're so close...  I think the patches are good; they are a welcome
improvement to the documentation and the script looks great.  Thanks for
doing this!  Patches applied.

Now for the "I love your patch, something to improve part" :)

 - Patch 1 didn't apply to docs-next; probably you got caught by the
   fast-forward to 5.0-rc1.  I've applied it to 4.20 then merged to
   resolve the conflict in tools/Makefile.

 - I was tempted to ask you to redo the changelogs, but ended up just
   tweaking them myself.  Changelogs should focus on what the patch does
   and why; they aren't usually the place for the history of how the patch
   came to exist in its current form.  I'll append what actually got
   committed.  (Filling to 72 columns or so is also a nice touch for
   changelogs).

Thanks for doing this work - looking forward to more.

jon

The reworked changelogs are:

    tools: add a kernel-chktaint to tools/debugging
    
    Add a script to the tools/ directory that shows if or why the running
    kernel was tainted. The script was mostly written by Randy Dunlap; I
    enhanced the script a bit.  There does not appear to be a good home for
    this script. so create tools/debugging for tools of this nature.
    
    Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
    Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
    [ jc: rewrote changelog ]
    Signed-off-by: Jonathan Corbet <corbet@lwn.net>

-----

    docs: Revamp tainted-kernels.rst to make it more comprehensible
    
    Add a section about decoding /proc/sys/kernel/tainted, create a more
    understandable intro and a hopefully explain better the tainted flags in
    bugs, oops or panics messages. Only thing missing then is a table that
    quickly describes the various bits and taint flags before going into more
    detail, so add that as well.
    
    That table is partly based on a section from Documentation/sysctl/kernel.txt
,
    but a bit more compact. To avoid confusion I added the shortened version to
    kernel.txt; the same table is used in three different places now:
    ./tools/debugging/kernel-chktaint,
    Documentation/admin-guide/tainted-kernels.rst and
    Documentation/sysctl/kernel.txt
    
    During review of v1 (see above) a number of existing issues with the text
    were raised, like outdated usages as well as incomplete or missing
    descriptions.  Address most of those as well.
    
    Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
    [jc: tightened up changelog]
    Signed-off-by: Jonathan Corbet <corbet@lwn.net>


-- 
Jonathan Corbet / LWN.net / corbet@lwn.net
