Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FB5C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C3F20671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="VW9NvCLY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C3F20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389357AbeG0VGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:06:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40853 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389064AbeG0VGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:06:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id h15-v6so6115692wrs.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 12:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=foY0doffXS+VaUfOoEdPxUHl0qvdYURznMrjNNyWLgA=;
        b=VW9NvCLYjBvenr1WoGXH3fupRj57Vp1Rg+p6vNcvJWWS49UGSCnHYjQ6s96LT0PSbL
         mfu3C9yi+muX4WjHsn9mBn9acVpT8m2nKhyHofZtFRBO4wPeqQUk0mwTmEpCn69bK59O
         9uMAtpjP/R44vHGECmB8ovMNNwpyXSgshGQy8aCeRaEaQEcR/ts4J9Y7CCCIanzfKoEQ
         o/Aqng+wfLytz9LbR/7wtTp5l+Xw6po9wb3UncuXP7N9qh6FEKjAn8UX7xuYhXotT020
         648l9V0CtDZJ3Si13wr4rMeGgLbD6p9H1sTs5XZvkAPg6I1u/Fh67ZiJfn5ZBTxZsNyy
         9+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=foY0doffXS+VaUfOoEdPxUHl0qvdYURznMrjNNyWLgA=;
        b=tVtbdFaFVRwWpAxohKATmWbobZ5k5LdP5P8SxHYlC4JdPJFUfiKyTBMCh9HYTlZ5Ax
         ScH61kkdksgN6TI7h2nAi8H9zNLSXuKfrYnsK/bJ50F5PtE3fly8O0IeUBbg3B63A68i
         +Gm0B6uUz954De133RUpOm5V6BTt1rWChf0BRTp8oFh7tDDkgTkA2PM77MuFIZXnF2j3
         DquibvEtfCzO5iR1Yz7Tvjb3bJJs3MOnReE9TJl6jC33glScIgKGzKsLGvjiT6tFnD4J
         ZiW/BHduRUrD1R+ihswY5BQYssFudEms0uP2LWbJZw5B2EmjY1kOz4okzCPaul8+nNmg
         Y4Wg==
X-Gm-Message-State: AOUpUlHoUasicHpVAyrlKGdbS0GQG4EKM/eAbEwVDWQUoSLpqiJm5yOt
        K0vib5BFC3gIqAN+CCmFW8BtOVEi+4TDGVFZoE2f4g==
X-Google-Smtp-Source: AAOMgpecpOWq8GopN4KqGEEuZ3Dq4xdetHINWOjiifgyigEfNxEe3TbrjDCUt3xzqzaSSLfFxEGAVXd6+/KbB3SZewo=
X-Received: by 2002:adf:81c3:: with SMTP id 61-v6mr6161257wra.120.1532720561321;
 Fri, 27 Jul 2018 12:42:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 12:42:20 -0700 (PDT)
In-Reply-To: <153271287586.9458.6001928723332685410.stgit@warthog.procyon.org.uk>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
 <153271287586.9458.6001928723332685410.stgit@warthog.procyon.org.uk>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 27 Jul 2018 12:42:20 -0700
Message-ID: <CALCETrUXsOexKcj+K_v_bsW6DkGFgyNOaEs_qVOAcdNGBbEb2w@mail.gmail.com>
Subject: Re: [PATCH 29/38] vfs: syscall: Add fsconfig() for configuring and
 managing a context [ver #10]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 10:34 AM, David Howells <dhowells@redhat.com> wrote:
>  (*) fsconfig_set_path: A non-empty path is specified.  The parameter must
>      be expecting a path object.  value points to a NUL-terminated string
>      that is the path and aux is a file descriptor at which to start a
>      relative lookup or AT_FDCWD.
>
>  (*) fsconfig_set_path_empty: As fsconfig_set_path, but with AT_EMPTY_PATH
>      implied.
>
>  (*) fsconfig_set_fd: An open file descriptor is specified.  value must
>      be NULL and aux indicates the file descriptor.

Unless I'm rather confused, you have two or possibly three ways to
pass in an open fd.  Can you clarify what the difference is and/or
remove all but one of them?
