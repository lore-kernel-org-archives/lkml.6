Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A6CC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1067206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gHfSTwhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1067206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391662AbeKVNNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:13:14 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54594 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730517AbeKVNNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 08:13:14 -0500
Received: by mail-it1-f195.google.com with SMTP id a205-v6so11998708itd.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 18:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Re72A4d9F7EwelA+k7i2yyiw0AFPpEACNdIgdoozDDc=;
        b=gHfSTwhCZ6j5wbLOPPmbHWXgP+RtpupBA7OQbHo4m0KePcp4PLVHdpfcXBSYkLd8aB
         lFnpYReuL1J/hPXm5uaCCbXUg2IKP3XlENN5DlOTCMMwSkTwRruduqsMZmwsQ3ODnvPG
         QDgmERinl90CpLloaVA2B0dfYkw6jJpY0J9EdR9nBKwfHVnGM11Gv9gDpNiSrIZFdiK2
         nvnRJQoIUgtpgW+3iZspQ3GS0vjdpCe/DrBkX2Gr50CaOfDl9Ba8jJiiW5u9Ndss95Og
         EVZ86Ov/3YhkGoZkD+TFHEXjCW8rWHhIHIEW9BbN+ttpz2bLkOgQfgyPD2iKHWrNxoRR
         mDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Re72A4d9F7EwelA+k7i2yyiw0AFPpEACNdIgdoozDDc=;
        b=qhvse7OFmKNyBtf5VxW4/u1djg0V7K5zY2XxvjjHMJ2MOh//swR/0thu/srQLjr23V
         WJa2wOjeZN+RhW2RDlRX4OjJ12j+6m6WuScl/ZR1T34JFJTUaCVLxegFkSEO9mZWHEWw
         m4QBRSxKsNXb82RVFcnWdKNAVA1musXy9UnM7ITh6t9/sjxuU2if6qno2jrnzLDeeSmu
         baPLlsdDpEzqnRwA5uv/MbVJQIiDcaS58s2xO3/O1GhUhH3jjzAPkAC9FcOlaVbzzOtG
         HtLyt8lLT2wiGspOu1exqklNW/nCLJQo32qBQaBb7uiUT1vdqKkjHQl9CP+nQG6Goz02
         galw==
X-Gm-Message-State: AA+aEWYcX17/XEaQqU/EZEhX7vRatRH2PSy24ChmuHxkgsmmxZ32qy5J
        oJnwxWIcBb7JefUT/l31FZaA0nqGQJtTbjZG61IApA==
X-Google-Smtp-Source: AJdET5cCdK3HyfyA/qaYkuUOeIlc93XqoemF12RjIpn+2ypoAOWnD1oNi6bqzrDwxdTagpkpBP+6/mhfXyrg9R+Q5nU=
X-Received: by 2002:a02:5c0e:: with SMTP id q14mr7950499jab.13.1542854161104;
 Wed, 21 Nov 2018 18:36:01 -0800 (PST)
MIME-Version: 1.0
References: <20181121201452.77173-1-dancol@google.com> <20181121205428.165205-1-dancol@google.com>
 <20181121141220.0e533c1dcb4792480efbf3ff@linux-foundation.org>
 <CAKOZuetW6WMNFdL5_2=UbrEf8mjxYTdz1+4BiRLSgdoKh8FsqQ@mail.gmail.com>
 <20181121145043.fa029f4f91afddc2a10bb81e@linux-foundation.org>
 <CAKOZuesF5zi9mpEE6No7oq0hDnM8KFhQFU=NM7qUF635s0r3-A@mail.gmail.com>
 <20181121162247.467fcab6c0aca0819a822286@linux-foundation.org>
 <CAKOZuet7ipw8zoXCDQUB5PKs3kdSye-zesBbEv7jVDSByhXgkw@mail.gmail.com>
 <20181121165741.ef089df784482632c4a66370@linux-foundation.org>
 <CAKOZuessQgmPuiReEO0caNqkss=r44o-XXnem12TOXSn=y6xkw@mail.gmail.com> <20181121172919.1b6585e17770d0be7dd8c4d9@linux-foundation.org>
In-Reply-To: <20181121172919.1b6585e17770d0be7dd8c4d9@linux-foundation.org>
From:   Tim Murray <timmurray@google.com>
Date:   Wed, 21 Nov 2018 18:35:48 -0800
Message-ID: <CAEe=SxmNVHR_1ge6hM5636CNi4BZhLvyxoKW_28L9-XDV7x6aQ@mail.gmail.com>
Subject: Re: [PATCH v2] Add /proc/pid_gen
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Daniel Colascione <dancol@google.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Primiano Tucci <primiano@google.com>,
        Joel Fernandes <joelaf@google.com>, corbet@lwn.net,
        rppt@linux.vnet.ibm.com, vbabka@suse.cz, guro@fb.com,
        pdhamdhe@redhat.com, dennisszhou@gmail.com, ebiederm@xmission.com,
        rostedt@goodmis.org, tglx@linutronix.de, mingo@kernel.org,
        linux@dominikbrodowski.net, jpoimboe@redhat.com,
        ard.biesheuvel@linaro.org, mhocko@suse.com, sfr@canb.auug.org.au,
        ktsanaktsidis@zendesk.com, dhowells@redhat.com,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 5:29 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 21 Nov 2018 17:08:08 -0800 Daniel Colascione <dancol@google.com> wrote:
>
> > Have you done much
> > retrospective long trace analysis?
>
> No.  Have you?
>
> Of course you have, which is why I and others are dependent upon you to
> explain why this change is worth adding to Linux.  If this thing solves
> a problem which we expect will not occur for anyone between now and the
> heat death of the universe then this impacts our decisions.

I use ftrace the most on Android, so let me take a shot.

In addition to the normal "debug a slow thing" use cases for ftrace,
Android has started exploring two other ways of using ftrace:

1. "Flight recorder" mode: trigger ftrace for some amount of time when
a particular anomaly is detected to make debugging those cases easier.

2. Long traces: let a trace stream to disk for hours or days, then
postprocess it to get some deeper insights about system behavior.
We've used this very successfully to debug and optimize power
consumption.

Knowing the initial state of the system is a pain for both of these
cases. For example, one of the things I'd like to know in some of my
current use cases for long traces is the current oom_score_adj of
every process in the system, but similar to PID reuse, that can change
very quickly due to userspace behavior. There's also a race between
reading that value in userspace and writing it to trace_marker:

1. Userspace daemon X reads oom_score_adj for a process Y.
2. Process Y gets a new oom_score_adj value, triggering the
oom/oom_score_adj_update tracepoint.
3. Daemon X writes the old oom_score_adj value to trace_marker.

As I was writing this, though, I realized that the race doesn't matter
so long as our tools follow the same basic practice (for PID reuse,
oom_score_adj, or anything else we need):

1. Daemon enables all requested tracepoints and resets the trace clock.
2. Daemon enables tracing.
3. Daemon dumps initial state for any tracepoint we care about.
4. When postprocessing, a tool must consider the initial state of a
value (eg, oom_score_adj of pid X) to be either the initial state as
reported by the daemon or the first ftrace event reporting that value.
If there is an ftrace event in the trace before the report from the
daemon, the report from the daemon should be ignored.

The key here is that initial state as reported by userspace needs to
provable from ftrace events. For example, if we stream ps -AT to
trace_marker from userspace, we should be able to prove that pid 5000
in that ps -AT is actually the same process that shows up as pid 5000
later on in the trace and that it has not been replaced by some other
pid 5000. That requires that any event that could break that
assumption be available from the trace itself. Accordingly, I think a
PID reuse tracepoint would work better than an atomic dump of all PIDs
because I'd rather have tracepoints for anything where the initial
state of the system matters than relying on different atomic dumps to
be sure of the initial state. (in this case, we'd have to combine a
PID reuse tracepoint with sched_process_fork and task_rename or
something like that to know what's actually running, but that's a
tractable problem)

The PID reuse tracepoint requires more intelligence in postprocessing
and it still has a race where the state of these values can be
indeterminate at the beginning of a trace if those values change
quickly, but I don't think we can get to a point where we can generate
a full snapshot of every tracepoint we care about in the system at the
start of a trace. For Android's use cases, that short race at the
beginning of a trace isn't a big deal (or at least I can't think of a
case where it would be).
