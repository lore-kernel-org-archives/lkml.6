Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF67C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6883A2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="beiXHDgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfBYTKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:10:15 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45179 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfBYTKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:10:15 -0500
Received: by mail-lf1-f66.google.com with SMTP id h10so7700449lfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 11:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ikE0djuKb5O1O8IxqIBmEdXTPgGWcmPHlG1klbk8Jew=;
        b=beiXHDgH0cIc9KFjjlIGqFER3xU0LAZlrHo3zFIuvZEbw9povoyElJqJ4YcZpiF2u4
         uc+jyGNtLRQV/WFrac2vF/bJ27pYkJj8SRnxOCkgHY5XpkfPNIK7h6ge2r6kwiW2xwHO
         NEH8nJXBTp3Bo7D5iIoGZUT3umHtGND3eeoTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ikE0djuKb5O1O8IxqIBmEdXTPgGWcmPHlG1klbk8Jew=;
        b=NZ+3zy23pgyhloNSir+sTs86bvWbCfycoHs2pPAHhi3jF2TamT4NuaE7NTOuktBKHx
         x8+Dri8YQQUgt4NekB5gnWEbPrIUbNPzJzTG0UalgvgbGNWz+dHyETQn3K5rjgJQZWQH
         PfCezswfc4r+qzeI9dnfwyXFSSt/UJtgjIg0G1PUTzD83YUgZvzB2auSvKYRvI5KmT4e
         5QZsTk0LDU/bm0je6HHeyZSp6n34I6tWoJBV4QT0JGHEPHBXeruRHhrTNeELgmTiUKMe
         vx9aIGfMpyYqIo7CtIeYV8N+K3333SHLHZEfGLkEfzTz3oSEwfBmH6Q4ICTItqTwSFcO
         74oQ==
X-Gm-Message-State: AHQUAubLrATnPFsuPWVbqYbu9wtx7E0viSXD2vkEhRrNtma8W9pl93WJ
        8zl0USpmLzzl5p3QWe6G6uAjrdsRZHk=
X-Google-Smtp-Source: AHgI3IbUy9zupwuirwErl92YnugHe49UQ8IeYlbu84/TGg8wcn+BjikIdSbmB9edZqm+IhP8WGf7Ng==
X-Received: by 2002:a19:9a8d:: with SMTP id c135mr10758241lfe.100.1551121812688;
        Mon, 25 Feb 2019 11:10:12 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id a23sm814612ljd.20.2019.02.25.11.10.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 11:10:11 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id h10so7700311lfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 11:10:09 -0800 (PST)
X-Received: by 2002:ac2:415a:: with SMTP id c26mr11849482lfi.62.1551121809297;
 Mon, 25 Feb 2019 11:10:09 -0800 (PST)
MIME-Version: 1.0
References: <20190225124330.613028745@infradead.org> <20190225125231.845656645@infradead.org>
 <CALCETrWQpG2aOxxeoNXUPD-A7h3j4NSTqoN+vN9Nr2E_Fo19zg@mail.gmail.com>
In-Reply-To: <CALCETrWQpG2aOxxeoNXUPD-A7h3j4NSTqoN+vN9Nr2E_Fo19zg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Feb 2019 11:09:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiNTe91hQEspL-1+49uH6bOWrS=n+iwVQtmY54cqYB5Ag@mail.gmail.com>
Message-ID: <CAHk-=wiNTe91hQEspL-1+49uH6bOWrS=n+iwVQtmY54cqYB5Ag@mail.gmail.com>
Subject: Re: [PATCH 1/6] x86/uaccess: Dont evaluate argument inside AC region
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 7:44 AM Andy Lutomirski <luto@amacapital.net> wrote:
>
> I put a slightly fancier version here last night so that the 0day bot
> could chew on it:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/fixes&id=b294da548d92320f194172272dda1f734e51013d

Ack. Even if it does seem to get the whitespace wrong and not align things ;)

             Linus
