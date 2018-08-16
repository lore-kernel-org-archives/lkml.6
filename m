Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7F4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18D920C07
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WEg4SpK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18D920C07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbeHPUOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 16:14:12 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:39376 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbeHPUOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 16:14:11 -0400
Received: by mail-it0-f51.google.com with SMTP id g141-v6so7673626ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 10:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5dwXw+hhRiD45uiy3rgdLSh7m1zU/2aCRU+eFDHvcDE=;
        b=WEg4SpK61jWRr8DMI8r+Tn6MHdwY2ZEmhA0C7gQ+TggqgGvy+tBsl22jwF0V1WWT/1
         3DHF156Lqi3aiWlOQMeLXHPAp8KMk2sSotuYR8SVEE+hf+M+wCS+WEEZqin2miBDv+jx
         hHVZnHpDWFMC1FXzHXJIq0m7tlOlHt4V1hqfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5dwXw+hhRiD45uiy3rgdLSh7m1zU/2aCRU+eFDHvcDE=;
        b=qjuxoe++ukRCLP/KpwaU/cgjhWvz/Ti76KlnRvCCT0ITdCijcsQ9vhy3F0o86PRc71
         D0v20aQZQLvo7f1Bz6OI4G4fEhtu4TK+4wmzwZiaqSr/zLGWo0dsVX0vN0GBTEGgP8Hg
         +oqwhVY2iJEbh8O73DCt65TzQUGDynupODfHwrlIFaaBgRtbMz6rh3hf/PJeqqDAvhkF
         VGxHcamVRYe4nG/4wrDQm05p4SvwSUB36gvRqfConjz+TamUTX3iPvvWOwmYP0UKM6/s
         b8QyD7hj9OAnaUvW3RmlSTwrZn27907TClITMUUmDWCmnLXIel9rHPUd+GmhWG+SXsz5
         uI7g==
X-Gm-Message-State: AOUpUlEpSPSmxZbnte1BlEgdEqCNiLuosFo8kG73QWVM3pohWAGXiB7c
        FutWAjDS1ZdHaMXHlAIe0w5qLwCbSkqyrF4Voc0NDtVn
X-Google-Smtp-Source: AA+uWPyT/4pamyeuh4t1RACR+5ymLZOyeBUeu1ouUBV0gr7uh79sZ/UJAGzJiS6H9bcvYhvXgylm48rmu0n2jBuWxyQ=
X-Received: by 2002:a24:e0ca:: with SMTP id c193-v6mr1426204ith.22.1534439666845;
 Thu, 16 Aug 2018 10:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUW9Cg0G41ZSwjUBaJ+F9qCc23GGMp8aCgfNQejstKJmmQ@mail.gmail.com>
In-Reply-To: <CA+icZUW9Cg0G41ZSwjUBaJ+F9qCc23GGMp8aCgfNQejstKJmmQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Aug 2018 10:14:15 -0700
Message-ID: <CA+55aFwPw5bHRFReMCs9dtHjJDcgFMLgK8P1QNsV4NRgPYFkew@mail.gmail.com>
Subject: Re: Merge branch 'l1tf-final' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 12:37 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>
> I am here on Linux v4.18 and tried first to merge the l1tf-final Git-branch.
> Unfortunately, this is no more available in the tip Git-tree.

Right. That branch - for obvious reasons - was never really available
on a public site. I had it as a bundle over secure email, and just
faked it all.

> How can I get the history and subjects of all commits in your tree to
> cherry-pick the single commits?

Just do "git fetch" of my upstream.  Not merging it (so no pull), just
fetching everything I have.

You don't want just the l1tf branch anyway, since there's three or
four subsequent fixes there too..

                 Linus
