Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F291C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD6020836
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YAoz9FSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387918AbfAKQR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:17:28 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:36359 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbfAKQR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:17:27 -0500
Received: by mail-qt1-f181.google.com with SMTP id t13so19405203qtn.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 08:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DlEf30Qq9zqQFycAA0J47QQU3YPd+PhaYuqwcAU8g1s=;
        b=YAoz9FSZf6sUo8E6Wf3PqvIiElR7Na0MgoKjC+NbBsvR/V17L8ksd4a66fXWbgKwVN
         xBNJ7Lf3ZhQE4A8fyvNxheKLnm7FNqbYYtbhMW2oOCqdnBCuNLxL3xOmwSVMD+hY8ucy
         3gzGbvU1JdmfZUeMUm8IxlUgdFU/YfW5WCiuR8tP6UVBzlQKs5X0CwlHxLgJ+91yZ+i/
         QY9Tq3XdsfPYIwuxVVS1JUx47VvMxJCmv491r2661AnRfUq3+AklU/qii1yC4B/60ZfR
         ba9bz6MtcNOgSyoSBRQtG9vbR6xtt8DssbcE7+ChbY9GqMXUv+53u9kxD+htZiCMMJ7H
         tAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DlEf30Qq9zqQFycAA0J47QQU3YPd+PhaYuqwcAU8g1s=;
        b=kK5JVUSjjNiEo0WbYs1YxMHVb05O3Um7RbvEl0xnrVp/GTu3u+RPa6LBdz0OadLBZB
         qG8aThV5OzGLXsXA1cVNlayjyZqjtf79NwN2/WvMem1LcRJzyOks/NfHk5L1gC+F9iV/
         EXiTKa+FfP/BzJtt517ASjRjUk1UJ6N6RoQ9LLgI9sQFrGxu6vgWzPeWA08y4QdBQHGu
         JiOwIq7z7TN/GH3U5Uq1eBPvAo9P9awmUTzVXGbeW0sQrwyY8jfyqLGBXTTYzAxUARtx
         gtvg7pswj5OMCYKcao27lGkPwTuMgJQ9uPcNhdnnOJbcp392hRWaJnBJ+smoboqjxBOV
         ofbA==
X-Gm-Message-State: AJcUukdl3lpOmJQyLEo8BUF4leATwfMlzgaBuwIiqrMSWtutFkjXALU2
        dbSeU/UNnbg0bHo5u3IlkPfzEw==
X-Google-Smtp-Source: ALg8bN7+UckbyW5z2VANgw9fL/hFV343Q+qIEOxcT7KiVBy9Z80dNfdcZnqskZXq2GbNBwOVGou99g==
X-Received: by 2002:ac8:2e22:: with SMTP id r31mr14321745qta.333.1547223445663;
        Fri, 11 Jan 2019 08:17:25 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b20sm48939352qkb.17.2019.01.11.08.17.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 08:17:25 -0800 (PST)
Message-ID: <1547223444.6911.19.camel@lca.pw>
Subject: Re: kernel BUG at kernel/sched/core.c:3490!
From:   Qian Cai <cai@lca.pw>
To:     "Kohli, Gaurav" <gkohli@codeaurora.org>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 11 Jan 2019 11:17:24 -0500
In-Reply-To: <3a6d8f4c-d7ed-e888-601b-a379efec306a@codeaurora.org>
References: <ba9c5ad8-d78c-904d-0430-a67d8e3ea729@lca.pw>
         <20190107135215.GG14122@hirez.programming.kicks-ass.net>
         <46089f1c-ad72-c96c-2f35-c2f60e726462@lca.pw>
         <20190107175644.GB7636@redhat.com>
         <3a6d8f4c-d7ed-e888-601b-a379efec306a@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-11 at 16:07 +0530, Kohli, Gaurav wrote:
> 
> On 1/7/2019 11:26 PM, Oleg Nesterov wrote:
> > pr_crit("XXX: %ld %d\n", current->state, current->on_rq);
> 
> Can we also add flags, this may help to know the path of problem:
> 
>   pr_crit("XXX: %ld %d 0x%x\n", current->state, current->on_rq, 	 
> current->flags);
> 

XXX: 0 1 0x40844c
