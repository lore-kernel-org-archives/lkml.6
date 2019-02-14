Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E13C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF752070C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M01mOV+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfBNAyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:54:23 -0500
Received: from mail-vk1-f174.google.com ([209.85.221.174]:39221 "EHLO
        mail-vk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfBNAyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 19:54:22 -0500
Received: by mail-vk1-f174.google.com with SMTP id f206so1006122vke.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 16:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VoGR9rvyxwHAEuiy3x1RluPkzMYcDCg5El68lL55cq8=;
        b=M01mOV+eQOecC575S9IvyCfnXCcAXQKOfTUdVtjoiH5X35UmuaHS45mlv08iM87DuB
         8O0SlU2tSvSX5gnmV+e8rKcYgyM8pkH/3OI6K6KsHVSq413js1XQVKGRRGwJ34tnMhFr
         LcXcq79waKbi1zdneAx/RhwR2byu60tP6ncjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VoGR9rvyxwHAEuiy3x1RluPkzMYcDCg5El68lL55cq8=;
        b=luTP+yrsEspYNw3PbuhQyT/JOTgFwAuA+HSCTIthQvrCCGUQXzSOoKVmcvmIMPWXeB
         f3U+IEpZgnE2l7KIGUKw/BSDCb9i7oFzsSeKNjTXPvaiNyKZtVqKS1hJwh8OhtLQ++lM
         xjqHvM1h61sBKF30+V+pZsYUiznvoYazEsbHiW6pX7X124UZtg3zMXuxPK6fHMR9nWLz
         JjtOfcWG//jCiSfCcyw33dexmoS0lQwbGD1gSTkdCZGykxAHdiEgg1iXNXPfObuscnoL
         sc5d/CWWMeRWZE06SXy7fz/KcwPBHwc/q0qJTfvozxHb3U8HpOy3pFVyDt8sSb6U2PoW
         qf3A==
X-Gm-Message-State: AHQUAuZs8QU17wFdjyxo7muZSAhlyUaRftiHTYKzKH8RSUBFxcLKJ8m3
        q6d2nc89ggjSE1eIIxdbDQPy6xea9c8=
X-Google-Smtp-Source: AHgI3IZMlDwTnLbeFWPQ6jTOC2MaAL21U+a3eiuTnNjZx5Gtrf2Z/UTRAA0Zs/oYqEsevDyq2UsAbw==
X-Received: by 2002:a1f:2912:: with SMTP id p18mr567023vkp.38.1550105661364;
        Wed, 13 Feb 2019 16:54:21 -0800 (PST)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id s8sm222419vse.28.2019.02.13.16.54.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 16:54:19 -0800 (PST)
Received: by mail-vk1-f180.google.com with SMTP id f206so1006109vke.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 16:54:18 -0800 (PST)
X-Received: by 2002:a1f:d005:: with SMTP id h5mr568853vkg.4.1550105658410;
 Wed, 13 Feb 2019 16:54:18 -0800 (PST)
MIME-Version: 1.0
References: <CAN1fySViLgrLAHHfTHMef-Bkh73kUHKP-ava6TbgALeSE4LfFw@mail.gmail.com>
 <CAFLxGvwpuxKF4UWdsULwQWo7kgVLMNHC=77dN+w-A0a6avrAXA@mail.gmail.com> <CAN1fySXjLUYFw2JGQQ5xxqjX+6kygzqgUc6Oj-sbtq=ZjgfLTA@mail.gmail.com>
In-Reply-To: <CAN1fySXjLUYFw2JGQQ5xxqjX+6kygzqgUc6Oj-sbtq=ZjgfLTA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 13 Feb 2019 16:54:07 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJoqnX54JnHZDVxO4NRCsT6sLH4+-TPk8GqCSVp0mFNLw@mail.gmail.com>
Message-ID: <CAGXu5jJoqnX54JnHZDVxO4NRCsT6sLH4+-TPk8GqCSVp0mFNLw@mail.gmail.com>
Subject: Re: Userspace regression in LTS and stable kernels
To:     Samuel Dionne-Riel <samuel@dionne-riel.com>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Graham Christensen <graham@grahamc.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 4:41 PM Samuel Dionne-Riel
<samuel@dionne-riel.com> wrote:
> Before, the interpreter was still used (assuming it wasn't cut by the
> length), and the interpreter was free to re-read the shebang if
> desired.

Oh awesome. Yeah, so, nevermind about the WARN_ONCE().

So, to address the "wrong binary" problem, how about we ENOEXEC only
if no newline or spaces are found in the string?

-- 
Kees Cook
