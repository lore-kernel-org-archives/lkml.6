Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5E3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD41222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ea3pCxb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbfBORMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:12:23 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37853 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbfBORMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:12:17 -0500
Received: by mail-lj1-f196.google.com with SMTP id r10-v6so8996831ljj.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 09:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nn2E7FTFiXRo/vIwDiEoZVSIB/DlXWRJscA/D+04tO0=;
        b=ea3pCxb8vsm2xJwAndWIGff/q7/pOkdMdIqCBL9KGvtDcZkS3K5QJChwJ6hvYxSBqc
         cyIo8Af0nzmYZMEvB8N0sDPp7xvRQ457/9n8YYTatsmyLYuRjWJeFFqQhPBUuw/+vpPp
         Y5G/kxlKhq/NhY+0auSQXsMv0MvsUlKVGYPG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nn2E7FTFiXRo/vIwDiEoZVSIB/DlXWRJscA/D+04tO0=;
        b=dqBcZG47ie4GRWWqaK6vz6Zu4nrWumrUc1uJXMnidhlggnkaA6tCYaB/ZOvIspQA8t
         hjDbLvkL0RE7E3d2K6lepGxF/3gYXcsjRAKbYIRqfmRzTyXQurLZmjX16+yhANJHAyJi
         5hw0MrbtvOB5OpQpXa5q9JmbtDgSEj/rPJndGJZC43qKyx2pr7Mj5SadgPABf4Y32pt7
         EoWa7UwiZK/8+rFbDSViTK8+a+qtFJqm9egga8ryamBkfmoAUXO29hOebkUtLogN8SAj
         g0sV6TPAMVtuwF5Cg/3Wgh8oeF5A4DFOagkFdze/kWO9/8Oc26Zh7bqbs48Msn9Bh7el
         LMdQ==
X-Gm-Message-State: AHQUAuY1L06vVRYXF1nSD1I2z1LUYG3iPTl0s620vYjDf4jD/awHakQk
        L2WXKTNG2Pm2onWbB+qNWS8neINjjDs=
X-Google-Smtp-Source: AHgI3IZtMshxiGMo958DIS0xVpkzJGGmEo5WF5ix2/SKG0JRcFcesBhCVdKGze31wZhAKDvuASOiEQ==
X-Received: by 2002:a2e:7803:: with SMTP id t3-v6mr6659186ljc.115.1550250734369;
        Fri, 15 Feb 2019 09:12:14 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id j12sm1485011lfg.47.2019.02.15.09.12.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 09:12:13 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id e27so7724664lfj.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 09:12:13 -0800 (PST)
X-Received: by 2002:a19:ab09:: with SMTP id u9mr6079702lfe.149.1550250732703;
 Fri, 15 Feb 2019 09:12:12 -0800 (PST)
MIME-Version: 1.0
References: <20190215031758.GA18776@beast> <CAHk-=wg7DRUqWvbCS2dm=mpdSNJry92Fo0OHDVi67bi8BMqt4A@mail.gmail.com>
 <CAGXu5jLi+zcOoi+Ti=OyR3MfF8s_S35EEmT_DoCzYPepOcn+Ow@mail.gmail.com>
 <CAGXu5jJXFP-1rEeYtMfqrSUz2oz8TWcjr89zL6-MPsNS7rwywg@mail.gmail.com>
 <20190215161851.GA8804@redhat.com> <CAHk-=wjk29MeO9PuyirONZMr75-H6LtfNe6WghOXT7n+f5-RTA@mail.gmail.com>
 <CAGXu5jKGyZhPMdMCrPY00-XXW0MhRoPuGFJbouFBfi7VoURdSQ@mail.gmail.com>
In-Reply-To: <CAGXu5jKGyZhPMdMCrPY00-XXW0MhRoPuGFJbouFBfi7VoURdSQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Feb 2019 09:11:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg_aYT+Yti5nY4_a7FgUa0k3Uip3MXezR=8HKaRMFAV4Q@mail.gmail.com>
Message-ID: <CAHk-=wg_aYT+Yti5nY4_a7FgUa0k3Uip3MXezR=8HKaRMFAV4Q@mail.gmail.com>
Subject: Re: [PATCH v3] exec: load_script: Do not exec truncated interpreter path
To:     Kees Cook <keescook@chromium.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Fri, Feb 15, 2019 at 9:01 AM Kees Cook <keescook@chromium.org> wrote:
>
> The !*first will never hit here (since it's been checked to be either
> ' ' or '\t', and if first == last it's whitespace all the way, so we
> could just return true here to bail out early (there's no interpreter
> at all, so we want to -ENOEXEC still).

Correct.

You do need the !*first test, but it needs to be after the loop
(because the next loop skips over the first non-space thing we found).

               Linus
