Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAFDC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB41208A3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TGyV1Z2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB41208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbeG3TzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:55:19 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38674 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbeG3TzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:55:18 -0400
Received: by mail-it0-f66.google.com with SMTP id v71-v6so556508itb.3;
        Mon, 30 Jul 2018 11:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pevNO25vI9FJo1HqskuRH0PK2wD9/891f5ZSN0pjc8A=;
        b=TGyV1Z2eHX/lC+L232Ez+10VvR+CaiQnZzJ4oE3w1O1WyUj08qGL0zxWja1Pj0ra89
         QI0rQjUfA+EYSYJ9BELKffBkq+VjDeaHlPVmhbXC+egMHvvy/LGTh//t+BrpDFmVryt5
         CmpgzAr2HnoE3tad77eZffHH2tGTV89M/JIfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pevNO25vI9FJo1HqskuRH0PK2wD9/891f5ZSN0pjc8A=;
        b=K5TrZvoVwtnZ6czN/uhnHVRsRkQBamAqdKU1VRP/3CrOL8268Bn/UkahaCdp+nPnxb
         WOKBWWkL3R/72pziZJrn9QlYIIbM7pXnElCTUSS+V2aAEVf4O9/KRYi7p7y7bipqoGjT
         lUOP97iBSdl/8BICm7Y+AFJyS6SRiaGoarptfB2+FXLU3bG49lLnyCW6iA1id7uZm+XI
         /y2RjX01waSPsvMVAORKovDIKWNCmZuZ53oEIExzBRixVHqs7f4H6WL58tcXtgsYfXaN
         s6bJka2Po6RTmKymjVv5AILTmYUAhssrwslT/TuF9oew0I1Psav8RRxHfAFPwomk6+ZT
         gcHg==
X-Gm-Message-State: AOUpUlHe/eQFcQYgGJydt9ELRHmddl5Xf3/AU9l+YFY9a6BlPPoE8hhQ
        i6CDxnf47VGx1wi2Mm3aJF9RJfqeJBBmyDp+Juw=
X-Google-Smtp-Source: AAOMgpd61V6NjRrkiSnTpadxr7jTENqPCpIOc7Y1QqKhxez1ZRs7bVlUrtJHum+9wi9IpzaPZpe90Hq7I6z84fnQPMI=
X-Received: by 2002:a02:702:: with SMTP id f2-v6mr17775408jaf.70.1532974744921;
 Mon, 30 Jul 2018 11:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180729113749.GA7333@amd> <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
 <153271292330.9458.14583488053811372222.stgit@warthog.procyon.org.uk>
 <25489.1532953411@warthog.procyon.org.uk> <20180730143104.GB24051@amd> <20180730180842.GA5544@bombadil.infradead.org>
In-Reply-To: <20180730180842.GA5544@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Jul 2018 11:18:53 -0700
Message-ID: <CA+55aFwY1nQ0LG8CeC8chugWO40kOGKpovBOadpGOOMBinNhbg@mail.gmail.com>
Subject: Re: [PATCH 36/38] vfs: Add a sample program for the new mount API
 [ver #10]
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Pavel Machek <pavel@ucw.cz>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 11:08 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> Have you looked at how gettext() works?  It uses the english text as
> a search string and replaces it with the localised string.  This is
> a very common design!

I absolutely refuse to have anything to do with gettext in the kernel.

gettext() needs help that I'm not willing to give, and that I
absolutely refuse to consider as part of any kernel interfaces.

Mount options are already English text. Don't try to make it anything else.

Just do a

        git grep '{.*Opt_.*".*".*}'

on the kernel, and realize that if you are messing with mount options
and things like that, you'd better be able to google the
incomprehensible words.

Most of them will be incomprehensible even if you're a native speaker.
There is not a way in hell that we will ever have gettext() support
for any of these things.

                  Linus
