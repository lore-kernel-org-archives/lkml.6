Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E701DC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 03:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946302170F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 03:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j1JJdkbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946302170F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbeHHGLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 02:11:32 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38951 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbeHHGLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 02:11:32 -0400
Received: by mail-yw1-f67.google.com with SMTP id r184-v6so595243ywg.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 20:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BS6WlbTaECIGx5LnbrbJairhkbQOawkR8Q2uTo/eDCI=;
        b=j1JJdkbEt4jshYkl8kyIScpzw+0GwguhfZ3jvx8UFKop6Y22ulKSvzaSL/hiVvU1Vt
         0RvwSkBm76/XjTVPizkLKK1RLW/6a9T1KONMXC4Qqgyqs17yBOrlYtUUgC47FQeHaB2+
         NOwNd8HXyHyzDmQ5HkyXCnJ21XSRecBVvQy23st4QXDSmNiDqpkGJwjG+xCdgyttcbgz
         DvOObTlEkp+CGd3TjCQA1uwXfa3m5h1X+2ziKy8IgPdARVGOh1cXPOV64jCsOeLSDKK6
         oINKcdfP0kL/QshKYwj+JDnzwG4wL9yfzfqDHJs8iK5a6qT9nNBgZHBin4GL8qmaka01
         70ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BS6WlbTaECIGx5LnbrbJairhkbQOawkR8Q2uTo/eDCI=;
        b=Brx3wvyoX+9SWZk+rKzjCPy+5WAExkjDyjef8xg2mHq5WiqaAF1PRGHSmlPlb/ZahC
         ha/fL6QmI+3vPLG+AKrjC09Hpi7sDD0uuDc6KnRDuir3bGe/2qJsDGkxVG6zsz7sBkM2
         gkqfGgoS+HSeRVg67CNKwSDmFEBXQVoDHXF6IL06n9/5lUbPvEY6cS1mvSi2235CuX7f
         MX1BnubOkLfL/e8i66nJzHGYd4tDr5Tq2ypXgBjwGVXSlnt8Z8mElhijnmbyKyRluBGV
         9F1LSw5W+qYntcXg3V+Rel+lLZkt4KEgsvO9jSvPuKWsr099tvqSMziPjfgY6gYzI/Qh
         GjOQ==
X-Gm-Message-State: AOUpUlHVkdfuFwlAtkFv7aOqxJu8dbs7DAkssKHVt466jFD6/egRzG6v
        U+ABDnSAQC8fPGSoNSQKOVhXZ1DxSq1WoONgtZu7pWI6Ylw=
X-Google-Smtp-Source: AA+uWPwN5eMwcXzKgsR8Kck22+eTGY6oZBWQnkb/jrx+gyVseAnBpNw4ebRHyliDXIpKnxrIn2cWjS3Hq2tG/YCsqK0=
X-Received: by 2002:a0d:c143:: with SMTP id c64-v6mr609028ywd.408.1533700435415;
 Tue, 07 Aug 2018 20:53:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:bfce:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 20:53:54 -0700 (PDT)
In-Reply-To: <CAJWu+oqcM_-rtuUe7hhMHyZ2UKZ5J4rBZO7UoHxxd2DAs=aHdA@mail.gmail.com>
References: <20180730222423.196630-1-joel@joelfernandes.org>
 <20180730222423.196630-4-joel@joelfernandes.org> <20180806155058.5ee875f4@gandalf.local.home>
 <CAJWu+oqvpev_EZC38_mi+UNRCxS8GqNVagHyGM4dUjruzKgwgQ@mail.gmail.com>
 <20180806214300.13e63523@gandalf.local.home> <CAJWu+oqZi2W9OYAn2xu17fdrBitQs4Gti4LxWmtx5B-EYtNMmA@mail.gmail.com>
 <20180807094954.5137972d@gandalf.local.home> <446AE5F2-39E0-46B6-8E0B-207E003DBF20@google.com>
 <20180807103410.4fe203cb@gandalf.local.home> <C1CB990F-8232-4168-89A8-E8C13B660B0B@google.com>
 <20180807110906.3a1b0ac4@gandalf.local.home> <6B9E5DC9-0859-41B4-9B72-A7D85E9EA2AD@google.com>
 <20180807194515.4e549c1a@gandalf.local.home> <6D0A3FD6-2190-4CC0-A3C0-7B3759E73243@google.com>
 <20180807204820.50b83c6d@vmware.local.home> <CAJWu+oqBOEJicepLaUG=JpmtDTgxjRdMyJAgOEUkdk4NzX0esw@mail.gmail.com>
 <20180807215522.04114097@vmware.local.home> <CAJWu+opjqKgZj30PYpyvip=EtP8CuqaEy65++nuvj37QMT6GCw@mail.gmail.com>
 <20180807222856.3ede96e7@vmware.local.home> <CAJWu+oqcM_-rtuUe7hhMHyZ2UKZ5J4rBZO7UoHxxd2DAs=aHdA@mail.gmail.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 7 Aug 2018 20:53:54 -0700
Message-ID: <CAJWu+oqPUuF4rFOQ8=G3+ZxXJxiiNRBYE8C=zZ93A8qA+muHEg@mail.gmail.com>
Subject: Re: [PATCH v12 3/3] tracing: Centralize preemptirq tracepoints and
 unify their usage
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 8:44 PM, Joel Fernandes <joelaf@google.com> wrote:
> Hi Steve,
>
> On Tue, Aug 7, 2018 at 7:28 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
[...]
>>> @@ -171,8 +174,7 @@ extern void syscall_unregfunc(void);
>>>                       } while ((++it_func_ptr)->func);                \
>>>               }                                                       \
>>>                                                                       \
>>> -             if (rcuidle)                                            \
>>> -                     srcu_read_unlock_notrace(&tracepoint_srcu, idx);\
>>> +             srcu_read_unlock_notrace(ss, idx);                      \
>>
>> Hmm, why do we have the two different srcu handles?
>
> Because if the memory operations happening on the normal SRCU handle
> (during srcu_read_lock) is interrupted by NMI, then the other handle
> (devoted to NMI) could be used instead and not bother the interrupted
> handle. Does that makes sense?
>
> When I talked to Paul few months ago about SRCU from NMI context, he
> mentioned the per-cpu memory operations during srcu_read_lock can be
> NMI interrupted, that's why we added that warning.

So I looked more closely, __srcu_read_lock on 2 different handles may
still be doing a this_cpu_inc on the same location..
(sp->sda->srcu_lock_count). :-(

Paul any ideas on how to solve this?

It does start to seem like a show stopper :-(
