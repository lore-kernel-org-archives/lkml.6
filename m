Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9687DC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6027F2080F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uO1/ctVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfBGLrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:47:07 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39453 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfBGLrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:47:06 -0500
Received: by mail-it1-f193.google.com with SMTP id a6so13994623itl.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 03:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iGIpsAOp2ZkP8f1uYr7gzKe7RmqNpD38V7qhwyf7+EM=;
        b=uO1/ctVP1eNoxZJ4CKZNBNRYYnxQd8QOEgXVV5WKaoRS7yKzUPdaK4kUtejxjsiifL
         i3rRHsTYcidSpK5Pxw6zXyMfer7HOl3FqKdM7mp9+WZVbdDfeUflBi1lJTxWk4ApN8pt
         aFymCHwWXJQQ4jtjM0EywmHY9PsP1FKWAD9fW+a2yits7XmB+3bcFRQenCWT2S/GWaG/
         eru2r4WEbySd0Y63rNjONbH81o1mpXtyEvcyv8azANnMiX0r/juiVWqk8I5JGhv/GFvo
         XLHg/0YTExU7Lb+t55Q4oI+sAh1+oxRdasscOdCJ+mVBLYUM8JsXGmg08OcdfbKTWt1/
         rSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iGIpsAOp2ZkP8f1uYr7gzKe7RmqNpD38V7qhwyf7+EM=;
        b=f71Y3/T4iQSVnTLdmA4DY/yJnHerN9yLRAGmNKs36DwvSKfL/GrOtLzt4EikHxNsaO
         iwHwJpvTHlKetH7GtCfWUDLH7BhH/fCBzpz3+kN9OT86LQ+rKSzH5GFHse7F3zunu7aI
         1cvgNKIh8xiQkVekinSYn1KhZLg5V60460PvhuZ9/cPVQx+yiX0eB30H9/f6OWJl3pVw
         yXBGU3fEyrKtQuPF5voOaZ2wHz3vVWZXMIA67lf+56nv+zlajR788NKGxJnTbdZSs3Ns
         uLBEgZ/nFL6GzGJLYercBP7SAreYV8cOb1TaCAZEWb7ai3DZOg23dEGwYlF5A+1crX+7
         d2Gg==
X-Gm-Message-State: AHQUAuaS5BbVC+5ZKE40YLESSK9Aw+td7BPk540A7zWlanxvFGaQmLrs
        avgqsgUeZyEhwwlbnTVlMe6MqvXkfcoWsOqJqiCn7Q==
X-Google-Smtp-Source: AHgI3IbLyiFj4uqkBPuVle1FEYE1/GMvSLqkv6r8/Q03/OKj8TJC2rl3mjElVvj0cTqd0quIwowynU/gdKn4lNKAZmg=
X-Received: by 2002:a24:7351:: with SMTP id y78mr4428546itb.12.1549540025572;
 Thu, 07 Feb 2019 03:47:05 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+bFh_S3=U+JF7GCzZjZ9R8b_Xqzi-1AyruKxqNqGrFVrQ@mail.gmail.com>
 <CACT4Y+YdVewFEmw2wFrnaHOc78b4bMZ4Nfu0uEzLk08UtvwOMA@mail.gmail.com>
 <alpine.DEB.2.21.1902041025050.8200@nanos.tec.linutronix.de>
 <CACT4Y+agDBRQ8f0kvqU7dJ9nmNZcNyLk1vc4fcGeH3WR-iAFqw@mail.gmail.com>
 <alpine.DEB.2.21.1902041736240.3006@nanos.tec.linutronix.de>
 <8736p37xcn.fsf@xmission.com> <878syu7tcm.fsf@xmission.com>
 <87tvhi4vl7.fsf@xmission.com> <87o97q1cky.fsf_-_@xmission.com>
 <20190206180754.GA23476@redhat.com> <87imxwv9jp.fsf@xmission.com> <875ztwt7yy.fsf_-_@xmission.com>
In-Reply-To: <875ztwt7yy.fsf_-_@xmission.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 7 Feb 2019 12:46:52 +0100
Message-ID: <CACT4Y+ZuJ5N03FsGn1cj9KUy6b_VZcNWfU3kFJFZugcyyi13zg@mail.gmail.com>
Subject: Re: [PATCH 0/2]: Fixing unkillable processes caused by SIGHUP timers
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        jolsa@redhat.com, Namhyung Kim <namhyung@kernel.org>,
        luca abeni <luca.abeni@santannapisa.it>,
        syzkaller <syzkaller@googlegroups.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 7:43 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>
> Dmitry,
>
> Can you please verify the follow two patches.  The first one is a
> simplification of the one you have already tested and makes the
> processes killable.  The second patch improves our heuristic for
> detecting synchronous like SIGSEGV when the stack overflows allowing us
> to process them before SIGHUP.
>
> Eric W. Biederman (2):
>       signal: Always notice exiting tasks
>       signal: Better detection of synchronous signals

With these 2 patches applied the test program immediately exits with
"Segmentation fault".
Tested-by: Dmitry Vyukov <dvyukov@google.com>
