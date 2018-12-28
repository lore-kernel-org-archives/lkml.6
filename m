Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0581C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C196F20879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgRdj4qj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387536AbeL1RWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 12:22:46 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:44797 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbeL1RWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 12:22:46 -0500
Received: by mail-wr1-f46.google.com with SMTP id z5so21468614wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 09:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+rvCtPeRPDqyQ6ai24Una5bw4CbIuQwxHLxifH7vXUM=;
        b=YgRdj4qjy7dC5heZGNN+hy6yB6NZLablko+HP88d3MbLls0NLdYA90kcyNW/W/Rqcr
         AQ4RJ4m/Y4w8jqUpk88JeXHJTwjvphU7HqjgrU6oh8Uy4jn5ZhCX6PhD/umjt55JSqLW
         uK53GYTa3zO9JcBTFKaW6YQzYxAo+rHPD6LEuTWwbzLbO6FS7eA9lHzCBscv5tQosMZI
         3B2IRHJLAK/bdh4DIPQjFdS/uaK/UqGXmnq58zcjXH71vQoUnHNvW/U6dnJrExOJzJmA
         1kfWI1ooK23qmf4GdhMVU+OsPGe2A8s9qZMpxsAzZ1OWiMBLCpp/1pIMaf26Nr1Ju+83
         fhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+rvCtPeRPDqyQ6ai24Una5bw4CbIuQwxHLxifH7vXUM=;
        b=R9lTKaxhkMqueUW7S9BTtrvbwcokan14O+wfofKT9uqUQA9y348j8i5aBM4PbJmPok
         fSEFFMDo6U+s8MhhnehWcLzdZY5M8FejPeLwZte+G4OPeb86f3mXPjS9eeUNBlWxjQeQ
         +2t/POXP+QCUoYL+pONhZmMQ7iHXX6sooMPiBxSH5VWRaiYGv5OmcTzM087YHO1sq22C
         hVtYi9nD9YVkvjqTJjj9PpBLBve0tU/DSD37NgamKIf/0e7g+jeSJl/TS7OZJJCUylgr
         DdrpbpgaiafK6VI3XnNvMzcq1VSdngbmD/bFGazA7NcONYEtQ1SHHWg6R8PYzyHRjQe0
         rnVA==
X-Gm-Message-State: AJcUukdpACUD19OID+uiVuqT8dr3es7arYSOWoNRjTZt5b0JJ/yRmQuD
        5XeeePaQw9/rxGYclNKjg9PNt6GZZ2+Mbc3XxLU=
X-Google-Smtp-Source: ALg8bN41GnVQZGELwmBwZbNZmIxNkmLQLRa9/7+X4rA53wFZiwyfOueedLwsEXtvSNXzYJq2E1uwl3/ltBtxmVXAy0A=
X-Received: by 2002:adf:e149:: with SMTP id f9mr28162316wri.42.1546017764072;
 Fri, 28 Dec 2018 09:22:44 -0800 (PST)
MIME-Version: 1.0
References: <238e9be2bb4751406260ebdc7686ef54@redchan.it> <CAD2jOU9SV3nuQbv+Nnp6XSqo-EA90AWvn5_kagr63eAsA=MaYw@mail.gmail.com>
 <673b3e733204be78710280893ccc350d@memeware.net>
In-Reply-To: <673b3e733204be78710280893ccc350d@memeware.net>
From:   Raul Miller <rauldmiller@gmail.com>
Date:   Fri, 28 Dec 2018 12:22:18 -0500
Message-ID: <CAD2jOU8DRBW_DgUjvO=tLkwzGcfHrRfH6qYEUTp84GBFmLwwFg@mail.gmail.com>
Subject: Re: Yes: The linux devs can rescind their license grant. GPLv2 is a
 bare license and is revocable by the grantor.
To:     vsnsdualce@memeware.net
Cc:     visionsofalice@redchan.it, freebsd-women@freebsd.org,
        freebsd-chat@freebsd.org,
        OpenBSD general usage list <misc@openbsd.org>,
        owner-misc@openbsd.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 3:12 PM <vsnsdualce@memeware.net> wrote:
> ... pompous programmer asshole*.

I think you are projecting your own personality in your perception of
others (which is a natural thing to do - everyone does that to some
degree).

That said, I am going to filter your messages to my spam bucket from now on.

Have fun,

-- 
Raul
