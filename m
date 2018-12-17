Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F541C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5068D2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EfRHe5vU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732769AbeLQTob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:44:31 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44011 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbeLQToa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 14:44:30 -0500
Received: by mail-lf1-f66.google.com with SMTP id u18so10377574lff.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 11:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1FfC7IuS1OaUBS/umSG/oOBAF4rXMrEKQvY3C4my1so=;
        b=EfRHe5vUzkJDtFWT7OqNel24Lb7X0e3IoT24frs0qG07mxPszF+0LH13+VzAOyeUhV
         NkLz6v20Ukg38Y0m9XBQ8nbjfmPaHxVr2yZUS2KX0oGMSzoAYw9cg+DyXj7A9rLbkux1
         KNONxNKm0O75FihvtvjJIKGhvVpRhWtB5OYqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1FfC7IuS1OaUBS/umSG/oOBAF4rXMrEKQvY3C4my1so=;
        b=cwnw+conqB+mzONJQ+5Dt7Hm/q4G5PEaQZBSgAliSyBpq3Obdi+D/1F5oIWrB+ui9Q
         ygMXEoPtEQSWaZQX6Sie8aSVoCVF54woQojplqkNQqUzieI4LCHrUpCUIshv0Wnl85SP
         ia7EKIbR7tAXwveO0d/MZZMIVmpiz5u+2A2T/+gdkPIYxTSZrABhTKvqNB9+fOSHZB36
         Po1fiTmGc4+rOTPt7bvd0BWuhmE/IFwkk43OSvVGiH3R+mQTYitt5jWTJpdwOGNWDnB9
         r/x6VK5qwZOl2LS1FDW4rhvWPr9OESszf9RN6V4wKu2c6FWK5PH80JsvSAaxyu+CohT2
         rnGw==
X-Gm-Message-State: AA+aEWbp3QKxWAyEmTLhH2Y/wpBqzybhiLl2KQyDGVm0Y92vxX70VT+5
        FjAiLEnXg7G8ARPVuYBU+4HRxVA6bMI=
X-Google-Smtp-Source: AFSGD/Xe+nfjW3EtY0A4BYww4+ocDfCWyM93ogxSGiQ5nZ2WrbptAlw2qLKMiHu82JRIAw9qBk/Ekw==
X-Received: by 2002:a19:3809:: with SMTP id f9mr7807779lfa.148.1545075867365;
        Mon, 17 Dec 2018 11:44:27 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id e94sm2869718lfi.23.2018.12.17.11.44.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 11:44:26 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id v1-v6so12125584ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 11:44:25 -0800 (PST)
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr524006ljj.120.1545075865555;
 Mon, 17 Dec 2018 11:44:25 -0800 (PST)
MIME-Version: 1.0
References: <1544738377-3848-1-git-send-email-longman@redhat.com> <20181217181712.GA5114@gmail.com>
In-Reply-To: <20181217181712.GA5114@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Dec 2018 11:44:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjhqBYmzOyg7LPjvZhoXr3Tr+k9+caG2ScdCtZeO6oJcQ@mail.gmail.com>
Message-ID: <CAHk-=wjhqBYmzOyg7LPjvZhoXr3Tr+k9+caG2ScdCtZeO6oJcQ@mail.gmail.com>
Subject: Re: [PATCH v2] debugobjects: Move printk out of db lock critical sections
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        yang.shi@linux.alibaba.com, Arnd Bergmann <arnd@arndb.de>,
        sergey.senozhatsky.work@gmail.com, dima@arista.com, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 10:17 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> We should rename printk() to syslog() or so, and rename early_printk() to
> printk(), and be done with this.

No.

As already pointed out, the syslog part isn't the issue. The printing
part is the issue.

So thinking that early_printk is any better is just puting your head
in the sand.

              Linus
