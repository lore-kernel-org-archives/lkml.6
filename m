Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268BFC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C136E20870
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="nna+pmmj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hjRf5C1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C136E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933001AbeGFXTG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 19:19:06 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:32902 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932478AbeGFXTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 19:19:05 -0400
Received: by mail-yb0-f193.google.com with SMTP id e84-v6so5188525ybb.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 16:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fjj4eATE9Shrv2CzUP2b6XSN9rgNrchz0+OZvqTUB/8=;
        b=nna+pmmjh0sfeaMRheNbAl53KsCSpAsI0ekMXH3NAwp35gWGXsY1uowh7fSdA1UELx
         GSWxgU3VgI5V4qXI+oDg1wiUPAu2/DXEH9Z5KFg1wHT6XkQ0eI01E6w56mFPl041LBMl
         ygxqiD/hcPvSH37zWMMZGchc/qqjhlBP+lNAxdSgtimBqX4DpQmX4i64ikzLJHBxA3tI
         FwH2WZdo0zVO2AzGm/DbVYZh3Jo7XFt54gtcXIBaZh74sJw7uFXQLS+2IPbo4Kr2zl3Q
         zZclwGuNNctKyzC4QL8CX2hOhoLK1eYxNEfUrleLQ8jlPngHFfwCHWoYe3jQmadhXoDY
         Y/Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fjj4eATE9Shrv2CzUP2b6XSN9rgNrchz0+OZvqTUB/8=;
        b=hjRf5C1bVSCedIQbaqh/YSJkfFCRf0lCsbPJ/0RQ6S/paMwVCxnZaWK5OZWC3QaNT3
         hAMhvvNzGqHi7rouB4aG1ZlnDJGO+RQUQDu2N9fGFiNM9Ateei415jDo4E4KK4+CUr15
         nDoZonOI+1n7p8mwvZABaSSj87ZHSpIoznv/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fjj4eATE9Shrv2CzUP2b6XSN9rgNrchz0+OZvqTUB/8=;
        b=MkbseIQR42FLZkYF/z33o//cVCZ1VrzZ+HzRQiV2Wepx1styyazHsiYMNIZz5XtLqp
         2t4EnXf9NN9TbA643QLkf9UP9W/R38W4wbUTSGcbJNrZKpJN67DshRaY3LxRdpcUz7SL
         2SJqMXDb+P8YAyg0MBoOuckAC7oZqNObRYAfDSDmlAeR4u/CAL170LS+J0ir1D9KA1qk
         eCQqoLNbJ0Ae31g9S/mkccZr+uIhbovY+ve3vg6jstrpdXCo6X7QVQ+NpwpcjRtzzt/l
         CjNZqELd11S0fnrWBT1SDOkbK4O5UWllp0pCMH1uJfXTce3ju9OjTTqg9PRbxOzM+gx5
         Afmg==
X-Gm-Message-State: APt69E0oOmieUysemdqI7fvcOmua/ZTD93NBoFJd+GptvY3J3YxGcO7u
        tZpDj6+YESieT2XcRYnr42Gsy4C0P39g148qdMQ8vcsV
X-Google-Smtp-Source: AAOMgpdRVkAWFMslgrcOVE4m5Uvu2s1iNR85H9BYOjAeGINbE/X2LsB5IpOJg+62w74dYrU9EeQPEi3pFVaR3m1G2PQ=
X-Received: by 2002:a25:afce:: with SMTP id d14-v6mr6125609ybj.343.1530919144252;
 Fri, 06 Jul 2018 16:19:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 16:19:03 -0700 (PDT)
In-Reply-To: <CA+55aFzK5z4VQEMQAOqVHXpm+o_gd_eg5Vecck07E=WmoO6BFA@mail.gmail.com>
References: <1530871650-3582-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CA+55aFzK5z4VQEMQAOqVHXpm+o_gd_eg5Vecck07E=WmoO6BFA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 6 Jul 2018 16:19:03 -0700
X-Google-Sender-Auth: 9Qye4MZrv4iq1JwyQqjFgFznDOM
Message-ID: <CAGXu5jKrM_3ymnmcJ+AE1A3uVPDJykRj0z5B8sDoxM6zUnX-Rg@mail.gmail.com>
Subject: Re: [PATCH] uts: Don't randomize "struct uts_namespace".
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 9:11 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Jul 6, 2018 at 3:07 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> I noticed that makedumpfile utility is failing to check kernel version, for
>> it depends on offset of "struct uts_namespace"->name being sizeof(int).
>
> For something like this, we fix makedumpfile instead. This is not a
> "user program" using system calls etc, this is something that delves
> into the kernel dump and tries to make sense of it.
>
> Where is the makedumpfile source code? What is it trying to do, and why?
>
> One option is to just say "hey, you can't make much sense of a
> randomized kernel dump anyway, so don't even try".

I would second this -- trying to deal with a randomized layout kernel
dump is going to be much worse than just looking at uts_namespace. :)

-Kees

-- 
Kees Cook
Pixel Security
