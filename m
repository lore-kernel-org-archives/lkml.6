Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rTlADjcnHluyBQAAmS7hNA
	; Mon, 11 Jun 2018 07:39:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1BCE6606FA; Mon, 11 Jun 2018 07:39:35 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k8zLwNvY"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B9D57601D2;
	Mon, 11 Jun 2018 07:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B9D57601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932385AbeFKHjb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:39:31 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41397 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754140AbeFKHj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:39:28 -0400
Received: by mail-pg0-f66.google.com with SMTP id l65-v6so9328864pgl.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 00:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e9wiTJgkhYWodmql/X5ryM0JlrJvkdjAPkFig3X5rp4=;
        b=k8zLwNvYDWDC5JlNs6+/4Y0gR56GZG7g45DamM2GQ30bFhVLhjPi9zjZIbXiyoyZ44
         VtGL+C96V7TV+ajcHKow11NjmMQRgD42/q4SIjaTWKIffTii1cqj9UuG+DM9oiqzi76N
         M4wavJVMmZXOKqhZTzn4va0d5eI/oWpUTmNdIUEdx4SPWXbWte7JR2Q7aLAVXmXIBKJV
         F/5OoA7PA2DEm7Ho1T23bDrvsLl9W6x0BzU5W2b2ZRcL1t/Qbf26IQLaltPBwKW0qNLM
         eJYM52ZU0IgKv62khJt6LSBo4RBEHJ0kxt5iHI9j/M+ZbVvfvs9/iJBDwXTssTpI10bV
         j04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e9wiTJgkhYWodmql/X5ryM0JlrJvkdjAPkFig3X5rp4=;
        b=f92To7V1CKyFcFiEDFwVgyHZ974yJRaXV6TcVkaqSpj8lNgEvaKq12zD3+Thrj6+o4
         rFNMfJGDfe549E5v0BZXm7erDUGKYHhApWE+TEAYH22aqgSqckwbWDag0yM0nOBaUvw8
         TD4hHEQSgULACAwVy9U8sQdjIQl7CbhO+C98XPT7FNVbFNMZYlY66DQc5y8TNr1u5Q79
         wpBhogWbmm1xoYQ+irypmVtjoR2AS3QhH87K97XX6HKzuO0WKpOtfmegoL/kBtAQY06C
         ltpUMsgNb1yhx6Lb9k73r+e6Ewv8xCs4cDJfAOXFda4Jr9INBp87TDB4XwCZleSqP5k9
         C9vg==
X-Gm-Message-State: APt69E1oSohS9Mla6d1orDs/+FtbC6MGRMDZe9gul57Lio0MJcWPd/Fw
        Kaa7bVSO/VyMrfzd1T2dPYCf5XXoGgWXcJw5VGhxFw==
X-Google-Smtp-Source: ADUXVKJBopbC5lBQvK9fP5ISp4Jjz+/sJI1Dv5E2R3+w69X5fUHW3zGTBi3+D35NOYerOeTDM0fIklJkbOKyf0PgyJo=
X-Received: by 2002:a63:721c:: with SMTP id n28-v6mr13695177pgc.96.1528702767678;
 Mon, 11 Jun 2018 00:39:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac07:0:0:0:0 with HTTP; Mon, 11 Jun 2018 00:39:07
 -0700 (PDT)
In-Reply-To: <20180611073038.GK12217@hirez.programming.kicks-ass.net>
References: <000000000000283c37056b4a81a5@google.com> <ee29ad1e-8bd0-3eef-f49e-793bfadcbea7@I-love.SAKURA.ne.jp>
 <20180611073038.GK12217@hirez.programming.kicks-ass.net>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 11 Jun 2018 09:39:07 +0200
Message-ID: <CACT4Y+Zyf2e_K0oRJ5oRj3WYWpf-t=V=RKHYcdqujF3s9PJL_w@mail.gmail.com>
Subject: Re: INFO: task hung in __sb_start_write
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        syzbot <syzbot+7b2866454055e43c21e5@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 9:30 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Sun, Jun 10, 2018 at 11:47:56PM +0900, Tetsuo Handa wrote:
>
>> This looks quite strange that nobody is holding percpu_rw_semaphore for
>> write but everybody is stuck trying to hold it for read. (Since there
>> is no "X locks held by ..." line without followup "#0:" line, there is
>> no possibility that somebody is in TASK_RUNNING state while holding
>> percpu_rw_semaphore for write.)
>>
>> I feel that either API has a bug or API usage is wrong.
>> Any idea for debugging this?
>
> Look at percpu_rwsem_release() and usage. The whole fs freezer thing is
> magic.

Do you mean that we froze fs? We tried to never-ever issue
ioctl(FIFREEZE) during fuzzing. Are there other ways to do this?
