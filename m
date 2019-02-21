Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FBFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FED52147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LJKvQb21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfBUBF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:05:26 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33319 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfBUBF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:05:26 -0500
Received: by mail-ua1-f68.google.com with SMTP id q17so8946549uam.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 17:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uAzRSgRwu/UoKJWaRh8bNoLluQOQAINg0liyRZiLCf0=;
        b=LJKvQb21GuQji76mHjygeTZV5xycZpEIted0T+J808L1KkArGE1NgdGCKdnf5tAYGl
         6Br+OGoFgymgw+S+eIKWuqX3Vw0tHq17TykGmHR35j5lzggg3HvKKiDy84fB7HFiJHl1
         roQ3XjZu9ErRuXlv8KuMb8UAD00e9c3v2vNtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uAzRSgRwu/UoKJWaRh8bNoLluQOQAINg0liyRZiLCf0=;
        b=BWTP+kTfVesJXT5YYmwo8C0E/swhIvy44F/BrXZbrlhEU/CmujXTApdA2tBdwxm4vz
         WZ6Dq9ugW0VP0kuz9NuU96a2nNrEoUFjRxRWSSlOJ2vdNSqshhSeWhGd2AUpAczcj/I4
         myGsJib+9qm6WpEXSL14CRrq34I/8/PosPflUVnE8UUVdUqIPBx3eSdN6kqLA39+yQtH
         Nsv7FHOJ42RS3ywf1mZlOmdb4SW9SJTosT0wmsw0+4J+E+YXoK6bkms/7FeDy8+JDkz9
         I4PdGk521i9d57mjCSEnF9n9+jYZXoikA6wtZj36wwh0Yxk0kytJopBSxLwuFeAFG5cC
         YXFg==
X-Gm-Message-State: AHQUAuYXuKizFG3quI/3uRpTH5+Qv8Z9Mat8z20cuwcADEDmlLKxXIWG
        /O131OV3v8TEfBxI2boW6r7zmKch6G4=
X-Google-Smtp-Source: AHgI3IaXyqqc5d+BIM7018/q/+OyMiJ5R/3oEIVAVYLiOBOSdHIGy32lhN2WZElnNYK+boM35mTqUQ==
X-Received: by 2002:ab0:3407:: with SMTP id z7mr19951784uap.115.1550711124498;
        Wed, 20 Feb 2019 17:05:24 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id g195sm8784268vka.5.2019.02.20.17.05.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 17:05:22 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id t13so15200674vsk.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 17:05:22 -0800 (PST)
X-Received: by 2002:a67:fa45:: with SMTP id j5mr3535858vsq.48.1550711121846;
 Wed, 20 Feb 2019 17:05:21 -0800 (PST)
MIME-Version: 1.0
References: <20190218232308.11241-1-tobin@kernel.org> <20190218232308.11241-6-tobin@kernel.org>
 <CAG48ez0utQJjoJW69OwGiuH1EQtcD939-5u71ruD_1nr0eJK0g@mail.gmail.com>
In-Reply-To: <CAG48ez0utQJjoJW69OwGiuH1EQtcD939-5u71ruD_1nr0eJK0g@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Feb 2019 17:05:10 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKeS3bkTSXEw2nsjrWoqhbkDZD4C=PdYTHMtM0GNk6tSg@mail.gmail.com>
Message-ID: <CAGXu5jKeS3bkTSXEw2nsjrWoqhbkDZD4C=PdYTHMtM0GNk6tSg@mail.gmail.com>
Subject: Re: [PATCH 5/6] lib: Fix function documentation for strncpy_from_user
To:     Jann Horn <jannh@google.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 4:52 PM Jann Horn <jannh@google.com> wrote:
> AFAICS the byte_at_a_time loop exits when max==0 is reached, and then
> if `res >= count` (in other words, if we've copied as many bytes as
> requested, haven't encountered a null byte so far, and haven't reached
> the end of the address space), we return `res`, which is the same as
> `count`. Are you sure?

Oh, whew, there is only 1 arch-specific implementation of this. I
thought you meant there was multiple implementations.

So, generally speaking, I'd love to split all strncpy* uses into
strscpy_zero() (when expecting to do str->str copies), and some new
function, named like mempadstr() or str2mem() that copies a str to a
__nonstring char array, with trailing padding, if there is space. Then
there is no more mixing the two cases and botching things.

-- 
Kees Cook
