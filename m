Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77228C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45EB721927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UUpyYJDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403843AbfBOQGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:06:16 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32991 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfBOQGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:06:16 -0500
Received: by mail-ed1-f67.google.com with SMTP id a2so8408721edi.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 08:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xSdydxVlNjXq7tphuB8fhx8/OJtkpDnZ8SaCxmC6T1o=;
        b=UUpyYJDwJQ17JTPFQoPa1BHNsStxj9mwDG4FMQmAaJgPRXjvgaycMDYRF9zDXfqlni
         I8ZxURaJDWwAcZ69u2npv+8hv+Djk1Vp+DV7oa0POfU6ssIshQaY8ELwe6zJz1r1tqJg
         1JurdLwd4qtBPVe91m1JoTAcs5KEeqdWALYHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xSdydxVlNjXq7tphuB8fhx8/OJtkpDnZ8SaCxmC6T1o=;
        b=ShjEpUr2pBb74s7QI1k1aSmPnbgKwtcJlL409VOfWlLaFEYoHO2Nzi0/Z6sizhxwfd
         RqDJK9cgfZ3V7qeAOr1yqKosnWFin8vYJPAal7Q6D9xp61LIQCpf4oyXK7T+5m/agP+w
         QSVLDYl1FDT/mPrtj43/hk1JIsB8ddjlCiPrmfQMBCbMNoL+Vxx9O07nn4lTJmHvVkWL
         djO6PBUyEHaAMnCY7HQXkNkzLmYymcIXP/31Wm55gQJsi97HNfzdQWkH8bl+6Ze9wxGf
         H76u81FixFh/bkVu++epRmjEb85uxdzQIwm055yFbC12GD5ljA0R6DRcc9TsvRexOD+/
         pZfQ==
X-Gm-Message-State: AHQUAuaHayI2lgF5KhLJRFkDqmiEeY98hze5nZIJ5WMUBh3vJO31JOZf
        Db85hQ2GRnisXw4Z5o1ja7Jzfe0F7CU=
X-Google-Smtp-Source: AHgI3IYs7wXI87oJupLPm6vXrJqVWPND7HxUryZlmu+a3UbEiWHBRYtkoESY1oyEmwIShyfzfSjHKA==
X-Received: by 2002:a50:cf41:: with SMTP id d1mr8266710edk.242.1550246774287;
        Fri, 15 Feb 2019 08:06:14 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id q5sm1284479ejj.60.2019.02.15.08.06.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 08:06:13 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id x10so10872907wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 08:06:13 -0800 (PST)
X-Received: by 2002:adf:ee45:: with SMTP id w5mr5188558wro.204.1550246772647;
 Fri, 15 Feb 2019 08:06:12 -0800 (PST)
MIME-Version: 1.0
References: <20190215031758.GA18776@beast> <CAHk-=wg7DRUqWvbCS2dm=mpdSNJry92Fo0OHDVi67bi8BMqt4A@mail.gmail.com>
 <CAGXu5jLi+zcOoi+Ti=OyR3MfF8s_S35EEmT_DoCzYPepOcn+Ow@mail.gmail.com> <CAHk-=whBnu7TQTOoOiqSmDGpH0oxrFo9sDzJTZRFhFCv69BMrg@mail.gmail.com>
In-Reply-To: <CAHk-=whBnu7TQTOoOiqSmDGpH0oxrFo9sDzJTZRFhFCv69BMrg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Feb 2019 08:05:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=whiDx=2=U=0-uSaVVb4kC_Wz7y=cbFi+Ub+1hQEb7WyuQ@mail.gmail.com>
Message-ID: <CAHk-=whiDx=2=U=0-uSaVVb4kC_Wz7y=cbFi+Ub+1hQEb7WyuQ@mail.gmail.com>
Subject: Re: [PATCH v3] exec: load_script: Do not exec truncated interpreter path
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Graham Christensen <graham@grahamc.com>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 7:54 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> What's wrong with this simple and fairly self-describing patch?

Simple but with two bugs.

First off, the trivial one: I transposed the arguments to memchr(). It
would need to be

        cp = memchr(bprm->buf, '\n', BINPRM_BUF_SIZE);

because I never use memchr().

And even that doesn't really fix it, because what it really wants is
"strnchr()" (to stop at a NUL too). Which doesn't exist.

So skip that patch, it's wrong.

                Linus
