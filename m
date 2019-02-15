Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE60C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F0521925
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GLBl4o6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbfBORzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:55:53 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39459 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbfBORzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:55:53 -0500
Received: by mail-lj1-f196.google.com with SMTP id g80so9093839ljg.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 09:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zvIZ7gSrQe9nGlalSisXMMrnlq9A9OjDbPuH9/neOM8=;
        b=GLBl4o6uVqKKbN7PVX/9TpVRffkLB8HCNKtW81uT339JK8VXyX3VxqFdCcihrgZoTO
         IEAdfaFqN9UTG9mdL1E1T+QZDVJD5ZE6nZWHg5C1KIdquJGjYjf7+NnYZl8dppXJZW2X
         HWcLixNcqYo/FwsRHuHNtALKXcHlMeVwxYhmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zvIZ7gSrQe9nGlalSisXMMrnlq9A9OjDbPuH9/neOM8=;
        b=j7p0NXBcWJr/uMIldy3Biuw+2q54GyMY68lmN3cGLJN7HRRYgLhvz1e7IrzA7X6k19
         83Cjzw/Q/RC/Bjdr+q9QG7IYfVRDVldiFFdWKgwcOb+JoHMjecRfilSuk2OVS39ZvZG7
         IyHHOdI/9azKfWFCOGyPoW8+olunCLb8N+WobAySaHwBeQeVUbPlrMUUByvWYx2keT9d
         AA+A366eNRmW6JlvHeZu6iCsM1WcDY+0FWVep2gKjX+zNm0zjm7R8uh7AcyqRWPBm1mB
         G64zPAI4IFHV7as6xTIxmx35d89VNMCYEalhxIWEBsWoJJ0T91DXPNlf1Kr7o7VnW9g4
         2XbQ==
X-Gm-Message-State: AHQUAub7HZfixS8XgW0D/H4TN7zIlN1UcowQHh7WfIHnpD2VtzdthnHg
        zooIXkJQ7xePYXDkCQfK5A9gVssSEAc=
X-Google-Smtp-Source: AHgI3IbR4IR0OEFyDecinBdezIwZzgJzQVTdNdT1uJene58eUeSmoeeTIS1HxarwySsfIGTAcvvUnw==
X-Received: by 2002:a2e:4d7:: with SMTP id a84mr3929073ljf.86.1550253350526;
        Fri, 15 Feb 2019 09:55:50 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id q131sm1513163lfe.95.2019.02.15.09.55.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 09:55:49 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id u21so7842529lfu.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 09:55:49 -0800 (PST)
X-Received: by 2002:a19:d250:: with SMTP id j77mr6195107lfg.21.1550253349133;
 Fri, 15 Feb 2019 09:55:49 -0800 (PST)
MIME-Version: 1.0
References: <20190215174712.372898450@goodmis.org> <20190215174945.557218316@goodmis.org>
In-Reply-To: <20190215174945.557218316@goodmis.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Feb 2019 09:55:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjP4bEYCFaKZVG4kLWmYBctyfsW9jjhC91tiTk9WwB8Rg@mail.gmail.com>
Message-ID: <CAHk-=wjP4bEYCFaKZVG4kLWmYBctyfsW9jjhC91tiTk9WwB8Rg@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 9:49 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: Changbin Du <changbin.du@gmail.com>
>
> The userspace can ask kprobe to intercept strings at any memory address,
> including invalid kernel address.

Again, this is not about a "kernel address" at all.

It's neither a kernel address _nor_ a user address.  It's an invalid
address entirely, and there is nothing that makes it "kernel".

Please don't talk about "invalid kernel addresses" when it is no such thing.

                      Linus
