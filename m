Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C8EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2982075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZfvtov4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB2982075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbeIFURw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:17:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38610 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730165AbeIFURv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:17:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id u11-v6so5167584plq.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 08:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mq2/Q08BfYxEmyzdz70H03a7yfwSX+vcxMSNmCF1cqU=;
        b=VZfvtov4yyShkfU8y/kbWzqedWQN0Vxa0vvj5DtXLi18jB1mzqb8kW//kOydncWN5j
         wFAzravWWUvxSJ3TWxhqwUn0DZA7wQpdQCgnTaWvT4Py32dVoot6mlfe/KrWG9EQ0VGo
         U5KMpZocanThwkRlwlu/8nDkhbaMoXhQF6WBg/T7mdU1Otp+ZeKHY3MmbksDikykDL52
         5vvYKUGKOtmyNLfL9tP/Pn8xctYVteSt2IYHmJgoq1hOipeLAlZBmz9eQO9nNdmNcZ1o
         g58p7DXvb1nl8HiZ73PvTTHtH0gWZ1gJW2Lu/Cyt/TGTh701M1wGB2wkGmYGtf/f2Q4z
         9h8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mq2/Q08BfYxEmyzdz70H03a7yfwSX+vcxMSNmCF1cqU=;
        b=AFab5l2WMEMtfDMHchstw8PYHNguAUxZ7/6OlM8lie1ScLF+GfqR8qGyJeDqtepcmg
         Mvq+ef/I1EIFLR5pkuX9+TgHYsS7a2FSUlxcjQH3oz001qzS8l2gsHePyawdSktckof9
         QYk1St+SYAJGY5i4Fyo3kKlxRYG30fzrdLSoOCp2h+yguqpC9GMEK4pvabbzzLCFV3jX
         1pdXfDuUUETRNQiZn6bffESb2ER1XLg5SDVP634Jc3Vd4lTPcY8kTjIb3dFSwaQDQ3uj
         4h2Yu23Za1lgZnJiN5lUq2/A3/PzB3qTYUxDFxdj3pTJNn74plXjOzcPF/wIF3WTvGx2
         wl1w==
X-Gm-Message-State: APzg51BzqCAK/CeghZQe1hY/HDpTFV8W8aScVpS7AkdlNXmqbUPP5Agt
        fsFXteuoQq7iMi8Gr/v723rdcOi9
X-Google-Smtp-Source: ANB0VdZvkQC3Vc0MZIehNgeq8YQki60w72aNa/Za54XeG4cCsmMDv9pSytb+VfH0vhUjT3u+diALvA==
X-Received: by 2002:a17:902:6b47:: with SMTP id g7-v6mr3352638plt.128.1536248506875;
        Thu, 06 Sep 2018 08:41:46 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id b126-v6sm6933209pga.49.2018.09.06.08.41.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 08:41:45 -0700 (PDT)
Date:   Thu, 6 Sep 2018 08:41:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Widespread crashes in next-20180906
Message-ID: <20180906154144.GA13745@roeck-us.net>
References: <2e8e31f5-4db5-4907-2d09-f6444bc78ede@roeck-us.net>
 <20180906140413.GA5098@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906140413.GA5098@thunk.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 10:04:13AM -0400, Theodore Y. Ts'o wrote:
> On Thu, Sep 06, 2018 at 06:45:15AM -0700, Guenter Roeck wrote:
> > Build results:
> > 	total: 134 pass: 133 fail: 1
> > Failed builds:
> > 	sparc32:allmodconfig
> > Qemu test results:
> > 	total: 311 pass: 76 fail: 235
> > Failed builds:
> > 	<pretty much everything trying to boot from disk>
> > 
> > Error message is always something like
> > 
> > Filesystem requires source device
> > VFS: Cannot open root device "hda" or unknown-block(3,0): error -2
> > 
> > The only variance is the boot device. Logs in full glory are available
> > at https://kerneltests.org/builders/, in the "next" column.
> > 
> > I did not run bisect, but the recent filesystem changes are a definite suspect.
> 
> Yes, this is the vm_fault_t changes.  See the other thread on LKML.
> The guilty commit was: 83c0adddcc6e: fs: convert return type int to
> vm_fault_t
> 
That thing is just asking for trouble. Why not leave return type
and value alone and add vm_fault_t * (assuming it really adds value)
as another parameter ? Is it really a good idea to deviate from "return
well defined error as integer" as used everywhere else in the kernel ?
Do we really need "my_favored_error_return_t" in every subsystem going
forward ? Oh well, I guess (hope) that is all discussed in the other
thread.

> This is the *second* time vm_fault_t patches have broken things.  The
> first time it went through the ext4 tree, and I NACK'ed it after
> running a 60 second smoke test showed it was broken.  The seocnd time
> the problem was supposedly fixed, but it went through the mm tree, and
> so I didn't have a chance regression test or stop it...
> 
Looking at the patch, NACK seems like the proper response to me, maybe
augmented with "please refrain from shooting yourself (and everyone else)
in the foot".

Guenter
