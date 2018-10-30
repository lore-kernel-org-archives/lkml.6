Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E885AC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5F82082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rnec/+NI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5F82082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeJ3X6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:58:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40783 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeJ3X6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:58:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id g21-v6so5978031pfi.7;
        Tue, 30 Oct 2018 08:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C0ambmftNVJ/c5veL29dtgLhtMxiGX+W3Kd6u+3IiG0=;
        b=Rnec/+NImldYhVV5Nb7/8EZDXZNpqPIM0/y1BSAtl/qIOwlWZQJYkXTGUqQF/Q8P1V
         JP6OfEiuoxq2f25M8ixtmkJ/Be513a7JE4MBrGvUWIqtIxx28vhhV9IS5grfl/DUvM+n
         aARUvMoFTRiNRS5EVod6RK/rKycKwOqHkzz82n4JtQSS0UudcpsKCB2Cle2kJNn2oeQM
         ab3oI1gLd1uzAUzxWJm4rR8Fkn1oE2BG/bLt+pK2Ht+VktLGLm2jiq9pLunInNEablFG
         CY5GT9ftJNU5JUK0cAa9kWX3Dn2AsmqjgTQuMKUq1Rg7gEZPNvKBRv4demWAW6lcCz7m
         1ZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C0ambmftNVJ/c5veL29dtgLhtMxiGX+W3Kd6u+3IiG0=;
        b=T4Ht/osIV0qdeLxzJysGzyiDJGDFbrfmyge+q4swhMQIwntOh52LmO1/T8HiaiivnM
         bffy7ZlbNFQCC4eLuiuLCKDIulzxAiIthnrMcTs/d2/9spmKraw3foN2qPILuyQZffro
         bYPhBT5gHUULE+Dceo/qT9d/YvJmxPTmY342GvafEIaUgUwpZJBv9GGLgwVzGUDglpk7
         2y7e9NAQ6FLoXvvQSBl10Hj/I19+fYy44qYJyKWy5RHnAjqsgp03uV9+CY+K4MIveLD+
         npzMXUg9phqMPNV3DEQNonVkfm7mSFH15KeBoYYNo6zwOdI1wQvtZSrEiv/U457maEv8
         C62w==
X-Gm-Message-State: AGRZ1gJBvXFPRFVKgaxPgYibZTqDhCmfo8lecrXXapIIbC3Tvi4py6Nx
        N4Xqr3d9KMUUc9iScLzk2v8=
X-Google-Smtp-Source: AJdET5eTQwJjStCwMLZrvzv8/Z74MLER1ED0vRtHRZldX4ZcpeZNQKnecPzfNRci2zIJS7TsTfUIfA==
X-Received: by 2002:a62:62c3:: with SMTP id w186-v6mr3338691pfb.5.1540911856337;
        Tue, 30 Oct 2018 08:04:16 -0700 (PDT)
Received: from mail.google.com ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id u62-v6sm44260327pfu.69.2018.10.30.08.04.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 08:04:15 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:04:13 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        changbin.du@gmail.com
Subject: Re: linux-next: manual merge of the compiler-attributes tree with
 the kbuild tree
Message-ID: <20181030150412.peayixjav2lvbp4s@mail.google.com>
References: <20181030104637.382c26d0@canb.auug.org.au>
 <20181030104941.4fef7dad@canb.auug.org.au>
 <CANiq72k2w2T0Cy0D--OEmE+sOPkjZtXpukBm+Mz1_xY6MCGg0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72k2w2T0Cy0D--OEmE+sOPkjZtXpukBm+Mz1_xY6MCGg0A@mail.gmail.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 12:21:52PM +0100, Miguel Ojeda wrote:
> On Tue, Oct 30, 2018 at 12:49 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > On Tue, 30 Oct 2018 10:46:37 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Today's linux-next merge of the compiler-attributes tree got a conflict
> > > in:
> > >
> > >   include/linux/compiler-gcc.h
> > >
> > > between commit:
> > >
> > >   94c7dfd01652 ("kernel hacking: support building kernel with -Og optimization level")
> > >
> > > from the kbuild tree and commits:
> > >
> > >   5c67a52f3da0 ("Compiler Attributes: always use the extra-underscores syntax")
> > >   989bd5000f36 ("Compiler Attributes: remove unneeded sparse (__CHECKER__) tests")
> > >
> > > from the compiler-attributes tree.
> > >
> > > I fixed it up (the latter just removed the __CHECKER__ check, so I did
> > > that) and can carry the fix as necessary. This is now fixed as far as
> >
> > On reflection, that may not have been the correct resolution ...
> 
> From a quick look, it seems we want:
> 
> #ifndef CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
> #define __compiletime_warning(message) __attribute__((__warning__(message)))
> #define __compiletime_error(message) __attribute__((__error__(message)))
> #endif
> 
> i.e. kbuild tree added the CONFIG_CC_OPTIMIZE_FOR_DEBUGGING guard,
> while the compiler-attributes tree removed the __CHECKER__ one, so we
> still need the former.
> 
> By the way, I think 94c7dfd01652 is wrong: it changes the guard also
> for __latent_entropy (and it does not change the corresponding comment
> at "#endif /* __CHECKER__ */").
> 
> Also, the commit message does not mention __compiletime_warning --
> should that one be guarded too by CONFIG_CC_OPTIMIZE_FOR_DEBUGGING?
> 
To avoid future possible warning, __compiletime_warning should also be
guarded. So I did the flow change so __latent_entropy is not affected.

--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -85,9 +85,11 @@
 
 #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
 
-#if !defined(__CHECKER__) && !defined(CONFIG_CC_OPTIMIZE_FOR_DEBUGGING)
+#if !defined(__CHECKER__)
+#if !defined(CONFIG_CC_OPTIMIZE_FOR_DEBUGGING)
 #define __compiletime_warning(message) __attribute__((warning(message)))
 #define __compiletime_error(message) __attribute__((error(message)))
+#endif
 
 #ifdef LATENT_ENTROPY_PLUGIN
 #define __latent_entropy __attribute__((latent_entropy))


> Cheers,
> Miguel

-- 
Thanks,
Changbin Du
