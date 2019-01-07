Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832B0C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B642089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kLaTCgfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfAGVLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:11:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33763 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfAGVLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:11:20 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so783713pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 13:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=g1cuTEn48wG1qTeVSnSEcCQJkrtfUkiQk/2rY6jqY4g=;
        b=kLaTCgfgNWKWzI2Ua887rfwu12qxeNMMKjJe5PFKD6fAFhsew7jd84eA0fxIGkySOI
         9BMTor2n8sBiaoo4Dlk9CeuMGa3TwYhJ25WgJvT28Zbj0vY7S8vEQ9Zs4pGKuwiaNqLo
         Su8FaeXyNc2ejjrpoU7vf6uoJ5rxVR4mNrOADOTqZZqhFmfCAmCOGeoxAybJXLAeyzwW
         ocxaLEL2SklbWPUWocLV1DkG82K4SH8FHlaWX/JT1678kLAWHb52ALqaDh592GLPSIk6
         jUk7NsAWpSxd6Qb/49r01kLnNzDo6OEmQRee+aW5dPwPtQOhVbop+BPqnbXb8N2DJogP
         tACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=g1cuTEn48wG1qTeVSnSEcCQJkrtfUkiQk/2rY6jqY4g=;
        b=RfikflrEo5Ong7lsTfGxu8kiqPxwL2RgolGCJ5PRi+Fv5RtQqZ3Ji816veoJ22nlgU
         S4P8WOwpFqJtXOc6VDBjHTmg/rtoctVWnku40Dzondgs92/BCuUpaoprAwcls+X10JJO
         OB23r45eo93D009EGw9edTGvGTW+/Qn8HRS2EKqM4kRFf3yg7vQ5Ap2n8dPohiEUO+Vh
         i+aQ/Hmmz2ztL450s+tbfLng1SjLR2XFafD4649b1BpToTN5zt5OQsz6GLXZUDFU1l8M
         CQv+675xaGmDpJLz+juvpEe6bthIgsDQUCmCNHuewW2gGRUjCvdoq75sySBxi+1kdI5t
         v4fw==
X-Gm-Message-State: AJcUukcIOLFHuxalFZsRQlfQsX4H+NkwYPk4ZvPEaIZwDV1QPKxXHWzy
        cDYUgqFo0SwiS4KMjNe+ISnghA==
X-Google-Smtp-Source: ALg8bN4jF9adta4mUeLs+sQ6ZBaiiJgt2be+BSMlmtucMMzo3SwB9D0y5/eMn4ERcaP5C9w1sHKXtA==
X-Received: by 2002:a63:4e41:: with SMTP id o1mr12513869pgl.282.1546895479183;
        Mon, 07 Jan 2019 13:11:19 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id x26sm100360160pfn.50.2019.01.07.13.11.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 13:11:18 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ggcB3-0006IT-7g; Mon, 07 Jan 2019 14:11:17 -0700
Date:   Mon, 7 Jan 2019 14:11:17 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Joe Perches <joe@perches.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Tariq Toukan <tariqt@mellanox.com>, xavier.huwei@huawei.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Stephen Warren <swarren@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v3] coding-style: Clarify the expectations around bool
Message-ID: <20190107211117.GA24142@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There has been some confusion since checkpatch started warning about bool
use in structures, and people have been avoiding using it.

Many people feel there is still a legitimate place for bool in structures,
so provide some guidance on bool usage derived from the entire thread that
spawned the checkpatch warning.

Link: https://lkml.kernel.org/r/CA+55aFwVZk1OfB9T2v014PTAKFhtVan_Zj2dOjnCy3x6E4UJfA@mail.gmail.com
Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 Documentation/process/coding-style.rst | 38 +++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 4 deletions(-)

There hasn't been any negative feedback on the first thread that
spawned this discussion, so here is a cleanuped up patch, ready to be
applied. Acks?

v2:
 - Revise Joe's original suggestion with background and more details
v3:
 - s/C11/C99/ [Al Viro]
 - Add some remarks on the use of bool in function arguments [GalP]

I'm not sure what tree this should go through - Jonathan would you
pick it up?

Thanks,
Jason

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index b78dd680c03809..cbe6b01b05fa66 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -921,7 +921,37 @@ result.  Typical examples would be functions that return pointers; they use
 NULL or the ERR_PTR mechanism to report failure.
 
 
-17) Don't re-invent the kernel macros
+17) Using bool
+--------------
+
+The Linux kernel uses the C99 standard for the bool type. bool values can only
+evaluate to 0 or 1, and implicit or explicit conversion to bool automatically
+converts the value to true or false. When using bool types the !! construction
+is not needed, which eliminates a class of bugs.
+
+When working with bool values the true and false labels should be used instead
+of 0 and 1.
+
+bool function return types and stack variables are always fine to use whenever
+appropriate. Use of bool is encouraged to improve readability and is often a
+better option than 'int' for storing boolean values.
+
+Do not use bool if cache line layout or size of the value matters, its size
+and alignment varies based on the compiled architecture. Structures that are
+optimized for alignment and size should not use bool.
+
+If a structure has many true/false values, consider consolidating them into a
+bitfield with 1 bit members, or using an appropriate fixed width type, such as
+u8.
+
+Similarly for function arguments, many true/false values can be consolidated
+into a single bitwise 'flags' argument and 'flags' can often a more readable
+alternative if the call-sites have naked true/false constants.
+
+Otherwise limited use of bool in structures and arguments can improve
+readability.
+
+18) Don't re-invent the kernel macros
 -------------------------------------
 
 The header file include/linux/kernel.h contains a number of macros that
@@ -944,7 +974,7 @@ need them.  Feel free to peruse that header file to see what else is already
 defined that you shouldn't reproduce in your code.
 
 
-18) Editor modelines and other cruft
+19) Editor modelines and other cruft
 ------------------------------------
 
 Some editors can interpret configuration information embedded in source files,
@@ -978,7 +1008,7 @@ own custom mode, or may have some other magic method for making indentation
 work correctly.
 
 
-19) Inline assembly
+20) Inline assembly
 -------------------
 
 In architecture-specific code, you may need to use inline assembly to interface
@@ -1010,7 +1040,7 @@ the next instruction in the assembly output:
 	     : /* outputs */ : /* inputs */ : /* clobbers */);
 
 
-20) Conditional Compilation
+21) Conditional Compilation
 ---------------------------
 
 Wherever possible, don't use preprocessor conditionals (#if, #ifdef) in .c
-- 
2.20.1

