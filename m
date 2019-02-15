Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D59C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 06:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4497A214DA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 06:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RSGrlphS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbfBOGPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 01:15:14 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:35242 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfBOGPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 01:15:13 -0500
Received: by mail-vk1-f194.google.com with SMTP id l136so1994173vke.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 22:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h4SdvpqGw3iuobgUcx19rFrv3lHuJOBe9urWJjGRD/4=;
        b=RSGrlphSJVERzE5SaFXHjSZlHl28z24mIi9QmfRNgw+c0D7KozclgvntR+Cs4DYOCW
         cXufXpaWe2QlTyZolAE/iNHSCiETASoDxGu8339g60sGkUOEB7/hpg9lWJxBZy9kXjfl
         1t/5ijjkYI4XXbRzpmLhBRn7ZuKmOUraAxeCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4SdvpqGw3iuobgUcx19rFrv3lHuJOBe9urWJjGRD/4=;
        b=UouD+nZRIQ8jsageij4nMEKXyaCTD9eFHhi3mcWXKvqlzGz5V3AVnaYD5xyQGfuDf2
         3AxcUqzbW8QdYASOmzJYacxNHkNGVDies3jZQzU4elL/w+me6Buv9cC5Su1Ie8H0Hagr
         h4tkH06qB14BBzvrkYYthNwsE/1yB2cRUJgBhyGBCK0vTuOiEH3wV39GODM6IdOX35fi
         J1JNl/uLJ5Y2hulaV3Jp77KTDydfEgLOGZ7gZ9UsdkpTj1Jl7VtQGF5gh9rVFhku10/j
         Wu2xLJdJ6PFFIE8qEBog6IIc9K76JSxdiP/yk6Pvck0IWzYJSlYxsCR9HeHcrB7k5I+X
         thvQ==
X-Gm-Message-State: AHQUAubknHREIQzOSBSNuY93CLy6veg8Unnpt1FV1fbR/dK9/cLyH7GW
        RyXP2eA6p8F46iaFcOHSpNsK2YUbeGU=
X-Google-Smtp-Source: AHgI3IalroLFpC5s77gx/8v7EZLiMWPPn+Mi1GlyyFVj2Tq63EgGk6hBF7zuGDRipfdpQBKn/jiChw==
X-Received: by 2002:a1f:dd45:: with SMTP id u66mr4128802vkg.10.1550211311875;
        Thu, 14 Feb 2019 22:15:11 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id o6sm735066vkb.15.2019.02.14.22.15.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 22:15:10 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id b6so888108vkf.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 22:15:10 -0800 (PST)
X-Received: by 2002:a1f:8e49:: with SMTP id q70mr4246226vkd.40.1550211309930;
 Thu, 14 Feb 2019 22:15:09 -0800 (PST)
MIME-Version: 1.0
References: <20190215031758.GA18776@beast> <CAHk-=wg7DRUqWvbCS2dm=mpdSNJry92Fo0OHDVi67bi8BMqt4A@mail.gmail.com>
In-Reply-To: <CAHk-=wg7DRUqWvbCS2dm=mpdSNJry92Fo0OHDVi67bi8BMqt4A@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 14 Feb 2019 22:14:56 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLi+zcOoi+Ti=OyR3MfF8s_S35EEmT_DoCzYPepOcn+Ow@mail.gmail.com>
Message-ID: <CAGXu5jLi+zcOoi+Ti=OyR3MfF8s_S35EEmT_DoCzYPepOcn+Ow@mail.gmail.com>
Subject: Re: [PATCH v3] exec: load_script: Do not exec truncated interpreter path
To:     Linus Torvalds <torvalds@linux-foundation.org>
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

On Thu, Feb 14, 2019 at 8:49 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
>
> On Thu, Feb 14, 2019, 19:18 Kees Cook <keescook@chromium.org wrote:
>>
>>
>>  fs/binfmt_script.c | 97 +++++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 82 insertions(+), 15 deletions(-)
>
> No, why?

In my defense, 56 of those 82 lines are comments. ;)

>> -       if ((cp = strchr(bprm->buf, '\n')) == NULL)
>> -               cp = bprm->buf+BINPRM_BUF_SIZE-1;
>
>
> This statement when we've not seen a newline should simply get a "is there at least a whitespace in there somewhere" test. Nothing more than that, afaik.

Unfortunately I don't think this is true for two reasons. First, the
leading spaces don't indicate that we won't later truncate the
interpreter path.

i.e. this is valid:
"#!    /usr/bin/perl"
but this could get truncated, even though we see whitespace:
"#!    /some/insane/nfs/or/hexified/path/longer/than/127/bytes"

The only way we know the interpreter wasn't truncated in the
no-newline case is if we see whitespace after first skipping any
leading whitespace, and it seemed really ugly to add a special scan
there. This is what I had for that, minus comments:

diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
index 7cde3f46ad26..6d7ef98bc949 100644
--- a/fs/binfmt_script.c
+++ b/fs/binfmt_script.c
@@ -43,8 +43,18 @@ static int load_script(struct linux_binprm *bprm)
        bprm->file = NULL;

        bprm->buf[BINPRM_BUF_SIZE - 1] = '\0';
-       if ((cp = strchr(bprm->buf, '\n')) == NULL)
-               cp = bprm->buf+BINPRM_BUF_SIZE-1;
+       if ((cp = strchr(bprm->buf, '\n')) == NULL) {
+               bool whitespace = false;
+
+               for (cp = bprm->buf+2; cp < bprm->buf+BINPRM_BUF_SIZE-1 &&
+                                      ((*cp == ' ') || (*cp == '\t')); cp++);
+               for (; cp < bprm->buf+BINPRM_BUF_SIZE-1; cp++) {
+                       if ((*cp == ' ') || (*cp == '\t'))
+                               whitespace = true;
+               }
+               if (!whitespace)
+                       return -ENOEXEC; /* Interpreter truncated */
+       }
        *cp = '\0';
        while (cp > bprm->buf) {
                cp--;

But, as it turns out, the above is actually wrong too (yay for my test
cases): the NUL termination before the loop (line 45) may blow away
the newline at byte 127. So we need to actually manually scan for the
newline while doing the out-of-bounds checking. (This was part of
Oleg's original "don't blindly truncate" rationale in the reverted
patch.)

I had also tried building some state machine to walk the bytes and do
everything in a single pass, but it was horrible. In another attempt I
tried converting as much to using "standard" C string routines
(isspace(), strchr(), strsep(), etc), but that was even more terrible.

So I opted to keep most of the existing logic but add the places where
tests were needed (along with comments describing wtf is happening
along the way). Anyway, I'm open to suggestions, obviously. :)

-- 
Kees Cook
