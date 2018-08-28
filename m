Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAE0C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715DE2087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="E2pM7z1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715DE2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbeH2DE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 23:04:29 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51015 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeH2DE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 23:04:29 -0400
Received: by mail-it0-f65.google.com with SMTP id j81-v6so5115735ite.0;
        Tue, 28 Aug 2018 16:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Gsh7+eKDb8jbcSjKNujBLc/+vJzu9XwrX6LuNtlNAQ=;
        b=E2pM7z1EhhMcRYKUNbVq3O94ZW6koRlaLZOSo5wCw983nV80RoAx39FwNtWWJH552Q
         dfcA8m8rZq6s3pGwHzr7M2dgN1fGmJcLdoeHRe2rteydjIaeda4klGJg2A04xaYcAvVG
         CeiebKFmliBZjE3PKj6RISdMxqfiepXLd0UgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Gsh7+eKDb8jbcSjKNujBLc/+vJzu9XwrX6LuNtlNAQ=;
        b=nvfpIrEHkXiJJb21sqM8TpLq5lkWU9Wrx1qzejYa7XriqPOzFhO8Pry2uKXXf1ne27
         TiPaGIRsJXytEZbmTkNMgw944v6N17dWmIJGaY+pKnZB1zcJE20U1qxkWtTxOkZE9goi
         9CxUDLK0mC9ewKhkd24q9+E7SXKxstdA/TiSOyDd3X+3G//BBq8mL5ZlVbYdUXOF+8Z8
         agoo9pHeKuKSmfdVt0s40qic2UPTdJMnp+psdhiCb36yocUsodmnK+VfIWvkz9Vc0HQS
         cYQs2QSIrJbEhB9STyBHuJrFh4UI2uv+rPz9iPG3/HvlY1EejNDRFqJCJj99WVRZ7cX5
         gp4Q==
X-Gm-Message-State: APzg51CDqphK7Z3ZZwLj7Xl/5F4xsfbF+e6qTqzqUysiVfaf7B34Kn6L
        6nM623GbPrz5qtaAWXeq7IpwPj/VzIuTBPpgXoQ=
X-Google-Smtp-Source: ANB0VdYWqV0gGpaCuAZmXMTHIUX7a+qgmGQwviq8erYBjSjR34b16AWt17CaPcs07IDiaNqHakZNLN3ObprkMYYYgdA=
X-Received: by 2002:a02:702:: with SMTP id f2-v6mr3430146jaf.70.1535497835163;
 Tue, 28 Aug 2018 16:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <1535476780-5773-1-git-send-email-longman@redhat.com>
 <1535476780-5773-3-git-send-email-longman@redhat.com> <20180828221352.GC11400@bombadil.infradead.org>
 <6873378b-3202-e738-2366-5fb818b4a013@redhat.com>
In-Reply-To: <6873378b-3202-e738-2366-5fb818b4a013@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Aug 2018 16:10:24 -0700
Message-ID: <CA+55aFxy1vH2CamZ_pdFohKgSJgi1i2MkeaY1qX8NdFK8Xu8Ww@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs/dcache: Make negative dentries easier to be reclaimed
To:     Waiman Long <longman@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, Jan Kara <jack@suse.cz>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Wangkai (Kevin,C)" <wangkai86@huawei.com>,
        Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 3:29 PM Waiman Long <longman@redhat.com> wrote:
>
> Yes, I can rewrite it. What is the problem with the abbreviated form?

Either gcc rewrites it for you, or you end up _actually_ using a
function pointer and calling through it.

The latter would be absolutely horribly bad for something like
"list_add()", which should expand to just a couple of instructions.

And the former would be ok, except for the "you wrote code the garbage
way, and then depended on the compiler fixing it up". Which we
generally try to avoid in the kernel.

(Don't get me wrong - we definitely depend on the compiler doing a
good job at CSE and dead code elimination etc, but generally we try to
avoid the whole "compiler has to rewrite code to be good" model).

                 Linus
