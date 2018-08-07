Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16F8C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1EA21547
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nozPMFoQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1EA21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390325AbeHGT4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:56:20 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39484 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389369AbeHGT4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:56:19 -0400
Received: by mail-it0-f66.google.com with SMTP id g141-v6so24085895ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 10:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C5ix1M4mKBQ8VHaJNUvoJfCCiK/bVrmR0V3WRcCy/T8=;
        b=nozPMFoQmq0030pYMXhdfu2wVDGtlnd3a9Vlel+VqVfave8JRy1vPGrd7ZDI9EfPCO
         yVtgcFjhkr6rpVjDd3nNIPM5zbzOB2tt79ZuRvKMtE8AGFmQxpvtxpRbDinARPJtB3YS
         XXZF9k6gKyx7luvqkJ4HuU/YIWp53KTd/pmOL5EYUANbvGb5aHysvJLFErgPQ7/Ibv7Q
         kE3Xb1abhzdBDubyCFrP57OOKdEqWhUvFYSzXWt94vxCgeTrx17k5qByHxDixspIkRi9
         muiJAXape6bc+Y2FydMZLOXgs29nqvpzxXXbWLSpwJk143vR/ROAcymCZZ2bXVVhavEJ
         I5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C5ix1M4mKBQ8VHaJNUvoJfCCiK/bVrmR0V3WRcCy/T8=;
        b=QWY71U+1VpArSgjlAU2ZW1dmn9f/vzmmdLp5AeDzzz2aEGL5xd9lymFzqPBJdCNfy1
         pbaHykQu1z/qjKQKBwRs3daGe/gLHWsfUkZcGIBw2koypIVj1QYaCiOGZEJj8O2e6bve
         K2Q8hKCOuHF5N27ZjM4RX0pMAM3OAExhIK8RhRR+dbMdL18cf4SN3qwojhMA3GJjkF6q
         cSWru+ijv3uw/yeMxJEJFFUVwN6n9IP8QdW/LtWE8fbv6zXzSaZDw9LIGXG+PPynpygU
         mnh61z1kXsUM4Fvtr41B+kbNpuqx/R+GTgwltuMcUDPqa7+JEl0Vwd2kgsNqeF7VzwGy
         /3qQ==
X-Gm-Message-State: AOUpUlEyN258MDL5aMPbQ1aGIwob8uLfP9V6DcgHylZGphWvsisshcQG
        FqSYmjqvLwsi3BpjGA7oEJkQOr8nGL7pYFhta+1TLIiG
X-Google-Smtp-Source: AA+uWPxpi8PnOlqFGecK0QLG1MCYBpHnebzRWxllRM+nimK49MLQrR+01Yrs1JtfJzYv8B15ggZhQNDOnXK8/ka4U/o=
X-Received: by 2002:a24:6e0f:: with SMTP id w15-v6mr2776120itc.77.1533663654183;
 Tue, 07 Aug 2018 10:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <CA+njcd3z7-jqLvhsBjNWUO9bDrMr_zd13CD2cPdCS0+_kXdc4g@mail.gmail.com>
 <CAHRSSEwd0Ma+wn3WYCvfWMwg3E8vzYx9CDOOiY63EzH42FZQvg@mail.gmail.com>
In-Reply-To: <CAHRSSEwd0Ma+wn3WYCvfWMwg3E8vzYx9CDOOiY63EzH42FZQvg@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 7 Aug 2018 10:40:42 -0700
Message-ID: <CAHRSSEwdWhUurOkviS0WdcGKj3374r-nCXH3BkQfwFiObyq+4w@mail.gmail.com>
Subject: [RFC] vruntime updated incorrectly when rt_mutex boots prio?
To:     LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>
Cc:     John Dias <joaodias@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This issue was discovered on a 4.9-based android device, but the
relevant mainline code appears to be the same. The symptom is that
over time the some workloads become sluggish resulting in missed
frames or sluggishness. It appears to be the same issue described in
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-March/567836.html.

Here is the scenario: A task is deactivated while still in the fair
class. The task is then boosted to RT, so rt_mutex_setprio() is
called. This changes the task to RT and calls check_class_changed(),
which eventually calls detach_task_cfs_rq(), which is where
vruntime_normalized() sees that the task's state is TASK_WAKING, which
results in skipping the subtraction of the rq's min_vruntime from the
task's vruntime. Later, when the prio is deboosted and the task is
moved back to the fair class, the fair rq's min_vruntime is added to
the task's vruntime, resulting in vruntime inflation.

When investigating the problem, it was found that the change below
fixes the problem by forcing vruntime_normalized() to return false if
the sched_class is not CFS (though we're concerned that it might
introduce other issues):

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 91f7b3322a15..267056f2e2ca 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11125,7 +11125,7 @@ static inline bool vruntime_normalized(struct
task_struct *p)
         * - A task which has been woken up by try_to_wake_up() and
         *   waiting for actually being woken up by sched_ttwu_pending().
         */
-       if (!se->sum_exec_runtime || p->state == TASK_WAKING)
+       if (!se->sum_exec_runtime || (p->state == TASK_WAKING &&
p->sched_class == &fair_sched_class))
                return true;

        return false;

Do folks agree that this is incorrect behavior? Does this fix look
appropriate and safe? Other ideas?

-Todd
