Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9BCC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 23:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61EF32080D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 23:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ol1JVsTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfAAXQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 18:16:16 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33322 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfAAXQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 18:16:16 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so13881486pgu.0;
        Tue, 01 Jan 2019 15:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ibc6NEwZn0iuZhQYem70KiVYf+1asaj43Ebh9VS4Ksk=;
        b=ol1JVsTni2X397r3+UTaCwZDYp4hs8QMD0YGH0BhsaU8AjTBBE9BMsaF1KizXABcwT
         OZKlpMGD4nT87T9gOw9wGQZWuGPeejzRPLOhYUg0g5BcBamnVpg0pfhPY1wrJbfjda13
         SR6xp6y5xX7+254nF73ADZIKpxy6Q/pxxE2GR1Y8dBXpyA+lXEDGgWNHWVItm9udBVq5
         kYdym9mbPKeAa92XatyJwbdrRMZQG17N/NIR4Ujc8jtwliFzw5fVLC0H+BQfeTkCL/OG
         YLf9Ws8LN8X5J1rtmP17wweHxC4+uBny8Pgc8qrf1hXpQIH58hvbFNBckvibP00OBR/D
         BeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ibc6NEwZn0iuZhQYem70KiVYf+1asaj43Ebh9VS4Ksk=;
        b=dLmWIUL+7PF7mdL0AlrYftrCQtmQ45m9A09Y4bD0ZNVWKuoH5plUdHGT4KNDX2NAKA
         YJSd8QWMynxrEfO3V+BiktIaPaGbU7tIKg0EhqkOQk46IK0cBsl/dLaFqxrq6khiYI24
         hOsBw5faK+rh3qVtdTWoDxd736sKqLGDbEdRpYz+3a2g7EMoAUk8ZX603yUyYRTlvfuG
         YsEs8rz7q0pMByPW5xfmnVe8T7fG58w11VvY8lXxbWPinVWj+ffBTd79o89fhtM2Cv9k
         XVaXJX9zdXQl7XIERptVDN9rddUoJ+NCXdSqppF+09+JZ7ysu5jYHxFgFoLGKwdLV/6G
         5InA==
X-Gm-Message-State: AJcUukdLr++c/oEDOJKeVwrv0oYD0cIHYRGsfGZgS2eSL497OxTsj6Gn
        P/WCN07gqCIejr2X17iaCBA=
X-Google-Smtp-Source: ALg8bN5KPFtR7vbHiJl1IfRV08/pKKnS+Ihr3JoEaz9ZvB0LW2ilMBI+tEXpENhjNGDCiarNUxLvPQ==
X-Received: by 2002:a65:434d:: with SMTP id k13mr11847509pgq.269.1546384575393;
        Tue, 01 Jan 2019 15:16:15 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id t67sm95160686pfd.90.2019.01.01.15.16.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 15:16:14 -0800 (PST)
Date:   Tue, 1 Jan 2019 15:15:31 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Thermal-SoC management updates for v4.21-rc1
Message-ID: <20190101231526.GA7944@localhost.localdomain>
References: <20190101160503.GA3306@localhost.localdomain>
 <CAHk-=whXWWXSMMPpm3eGV=PL12=K5LFM3didLBuGy1Y7vUbXVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whXWWXSMMPpm3eGV=PL12=K5LFM3didLBuGy1Y7vUbXVg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01, 2019 at 01:35:36PM -0800, Linus Torvalds wrote:
> On Tue, Jan 1, 2019 at 8:05 AM Eduardo Valentin <edubezval@gmail.com> wrote:
> >
> > Please consider pulling from
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus
> 
> No.
> 
> I pulled and immediately unpulled again.
> 

hmm... ok I am double checking.

> It doesn't even build cleanly.
> 

Do you still have have a copy of the build error? 

The local tests I did were not enough to see this error,
neither were the kernel CI builds. Only failed build was
on something completely unrelated (ARC) to these
changes:
Full Build Summary:
https://kernelci.org/build/evalenti/branch/for-kernelci/kernel/v4.20-rc5-42-g055ddb633a35/



>                 Linus
