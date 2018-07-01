Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FC0C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 03:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A8725393
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 03:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VkHzUBTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A8725393
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752280AbeGAD5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 23:57:21 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39878 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752177AbeGAD5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 23:57:17 -0400
Received: by mail-it0-f65.google.com with SMTP id p185-v6so7934701itp.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 20:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xj8l7PzLqCaDhIFMzrpFP6804pHtRKg909chpRj5W1g=;
        b=VkHzUBTtm6lrEVWqyAVVs31rScYXUj4xu7cbmYOqr1GurV808abPwCByxWK2/Rcku8
         hW2rn0iB2PZO3xoeIXfhRhh0qmTXL8jjimnzAYaa3diSBi6WzRlT84kQ+mbpZSlX+2tF
         kqtS2o0KhPxGNGXiVqFgVZTGtax/B9TIdZBv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xj8l7PzLqCaDhIFMzrpFP6804pHtRKg909chpRj5W1g=;
        b=g6fQROqIHj7PQy+wA2Z/e4W4wOCnvqmWqX+cyPR9coOZ76eLJGmdogVJv9JYPgvwcP
         a0qcq270jz5hKKcrYcrgCTcoIovs1CgM3G0tRZIan57ERi1N8JIAnhlR+TpIdkCeFm2L
         1Al/iTE2VcOVq0elKhJYkgy3mQY6CBQXhMr5Nalld+lWtZL3J/vvRp7489MSpnGGgeFU
         cg4vQQM+Ii5NrzAd283leM/pT5qcFbhb4zbZ3kM+Egmtj0Rma3WJIeSphE2oKj+ljeOJ
         9SPi+cNXpmEPoaV+ohaEzu5trBoyP8APvonbbHWTRN0G8lg4xordhSEDDP/p4KdsXeZa
         zn+Q==
X-Gm-Message-State: APt69E0DaSD5dmp4/A+pa3DaCBH8MtJU5u0jFM/CLNG3OWqgDkcZuDZZ
        mLtjBaH3Tdmgz1EocN75XE5WRz1dimymeTRNsK4=
X-Google-Smtp-Source: AAOMgpd/boWjtk7DVhNxxyCOXGT2gJDvQbQNKyujgXaQFY9zd2133rawNt8Ybt3kQlNVwJcsDvh8MnGDnm2dP6kxAgM=
X-Received: by 2002:a24:3c09:: with SMTP id m9-v6mr2361049ita.113.1530417436763;
 Sat, 30 Jun 2018 20:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
 <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
 <edc7b03b9550ddcf1291ebf5a6dafd24f4455c23.camel@kernel.crashing.org>
 <CA+55aFxS7OVEN5XrxceC5ibz780mhn-qRa50w1gVFjsz2JjMbw@mail.gmail.com>
 <7eb06b499f2be366cf68c6b6588b16c603e6a567.camel@kernel.crashing.org>
 <CA+55aFyS1bdmETHUYEejecOcG5MAjGCAbkr-M5iphJYfrj2oLA@mail.gmail.com> <675c0752ea41c9dc52c2a4b69f09fb9746207de3.camel@kernel.crashing.org>
In-Reply-To: <675c0752ea41c9dc52c2a4b69f09fb9746207de3.camel@kernel.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Jun 2018 20:57:05 -0700
Message-ID: <CA+55aFxqUyACDPBL4trTfGyJudg8P7YGazVGUW7-UaNFJiwZRQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: core: Remove glue dirs from sysfs earlier
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 8:42 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> But what if something *else* still holds a reference to the kobject ?
> It could be anything really... t

But that's fine. Then the object will continue to exist, and the sysfs
file will continue to exist, and you won't get a new glue directory.

In fact, what you describe is a problem with *your* patch, exactly
because you introduce another counter that is *not* the reference
count, and now you have the problem with "old directory kobject is
still live, but I removed the sysfs part, and now I'm creating a new
object with the same name".

Hmm?

> It is and there's a WARN_ON about it inside kobject_get(). I don't
> think anybody argues against that, you are absolutely right.

No.  That the zero kobject_get() will not result in a warning. It just
does a kref_get(), no warnings anywhere.

Yes, there is a kobject_get() warning, but that's about an
_uninitialized_ kobject, not a already released one! You will get no
warning that I can see from the "oh, you just got a stale one".

           Linus
