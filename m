Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0114BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03AA2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="utMvaqrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03AA2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390583AbeKVKML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 05:12:11 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36433 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390570AbeKVKMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 05:12:10 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so11422740itj.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 15:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ME3JoGnF0ebBesUXVbv50QCdEO6481wqP2V+fFyLxy8=;
        b=utMvaqrEKxGQr47JztWY1rpltG4YnsHkFXlAWm99rOjlCSHbjfx5xgXdDP7iLdPKAr
         EQGDlB6zziyrnxYCQUY90+lES2Zhn6sixehb8FXJNLKLXAYvxkuFYKMGNVGHJs4Rt/xD
         HoIv82fVIyo/NKG/ypuSCsABYFWbAWg14Zz2QcWhqK0UQ85X0Ndzy/NruwuoEV+Jx3l6
         rTl/y5NHheNkiYXwUc1IWA67bsZIMTpQ8ngpI5tvp6WJ97C4tXXGqyuLutyEK162fdYW
         u6WeBtYqLw/Aa08gmzfSOpI33CYFrLYY7T7TaUjdr1PDGAzfURw4i1ow0inGKPe2IlyW
         pDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ME3JoGnF0ebBesUXVbv50QCdEO6481wqP2V+fFyLxy8=;
        b=IfC8n14uiPs+UyWZdSNkyRHeAk8LWEY57q2tZ3reafVi/25Jk4XhVAeFu/jy0luaaN
         DEuYRSXXaVN65C8OqfmfUTmMNJ3ZM8Art2TmIAueT90I+cBtCwCSRdjzMnUTlHMvxFjQ
         fWLp/Ix2y4wwZityjJ5a6aTzb1xWaOl4gQMLjbDdxtmlmM6reKAr1tLPC7UUBZDZr6pW
         LPx6eytqsi/KyxN6ZYDwj00GNMP0NRNLrkzL4izH+jZpNeU0FAlaEOzK0zp+Ta58HVWj
         Xw85G7WU4TeN/01RBEkVReSfts3iMs4tHXp3L/sF/K02qsQap8ZsnxFQEhxoj1zVZx1z
         +0/Q==
X-Gm-Message-State: AGRZ1gI1FfYx1sNZ98dUIGNfnDjk1QR6IS3RUTeRTpXMcx56xAO2Nbob
        GtHMSADeZJLy0OPHvyMRx6WNrg==
X-Google-Smtp-Source: AJdET5c/Mzgzr9dK38qfOaTOlyFpz+CYThusL2T1TCsuzmNi3/VwLXrWrSLVpO6uKx4hQbYRh/ROUQ==
X-Received: by 2002:a24:d203:: with SMTP id z3mr6904234itf.156.1542843336726;
        Wed, 21 Nov 2018 15:35:36 -0800 (PST)
Received: from ?IPv6:2600:100e:b043:60c1:3558:a760:b985:a795? ([2600:100e:b043:60c1:3558:a760:b985:a795])
        by smtp.gmail.com with ESMTPSA id f7-v6sm14758857iog.30.2018.11.21.15.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 15:35:35 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] Add /proc/pid_gen
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <CAKOZuesF5zi9mpEE6No7oq0hDnM8KFhQFU=NM7qUF635s0r3-A@mail.gmail.com>
Date:   Wed, 21 Nov 2018 16:35:34 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Primiano Tucci <primiano@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>, rostedt@goodmis.org,
        tglx@linutronix.de, mingo@kernel.org, linux@dominikbrodowski.net,
        jpoimboe@redhat.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        ktsanaktsidis@zendesk.com, David Howells <dhowells@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <37255927-1A93-4B8B-A916-B5A3983D56B6@amacapital.net>
References: <20181121201452.77173-1-dancol@google.com> <20181121205428.165205-1-dancol@google.com> <20181121141220.0e533c1dcb4792480efbf3ff@linux-foundation.org> <CAKOZuetW6WMNFdL5_2=UbrEf8mjxYTdz1+4BiRLSgdoKh8FsqQ@mail.gmail.com> <20181121145043.fa029f4f91afddc2a10bb81e@linux-foundation.org> <CAKOZuesF5zi9mpEE6No7oq0hDnM8KFhQFU=NM7qUF635s0r3-A@mail.gmail.com>
To:     Daniel Colascione <dancol@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 21, 2018, at 4:21 PM, Daniel Colascione <dancol@google.com> wrote:
>=20
>> On Wed, Nov 21, 2018 at 2:50 PM Andrew Morton <akpm@linux-foundation.org>=
 wrote:
>>=20
>>> On Wed, 21 Nov 2018 14:40:28 -0800 Daniel Colascione <dancol@google.com>=
 wrote:
>>>=20
>>>> On Wed, Nov 21, 2018 at 2:12 PM Andrew Morton <akpm@linux-foundation.or=
g> wrote:
>>>>=20
>>>>> On Wed, 21 Nov 2018 12:54:20 -0800 Daniel Colascione <dancol@google.co=
m> wrote:
>>>>>=20
>>>>> Trace analysis code needs a coherent picture of the set of processes
>>>>> and threads running on a system. While it's possible to enumerate all
>>>>> tasks via /proc, this enumeration is not atomic. If PID numbering
>>>>> rolls over during snapshot collection, the resulting snapshot of the
>>>>> process and thread state of the system may be incoherent, confusing
>>>>> trace analysis tools. The fundamental problem is that if a PID is
>>>>> reused during a userspace scan of /proc, it's impossible to tell, in
>>>>> post-processing, whether a fact that the userspace /proc scanner
>>>>> reports regarding a given PID refers to the old or new task named by
>>>>> that PID, as the scan of that PID may or may not have occurred before
>>>>> the PID reuse, and there's no way to "stamp" a fact read from the
>>>>> kernel with a trace timestamp.
>>>>>=20
>>>>> This change adds a per-pid-namespace 64-bit generation number,
>>>>> incremented on PID rollover, and exposes it via a new proc file
>>>>> /proc/pid_gen. By examining this file before and after /proc
>>>>> enumeration, user code can detect the potential reuse of a PID and
>>>>> restart the task enumeration process, repeating until it gets a
>>>>> coherent snapshot.
>>>>>=20
>>>>> PID rollover ought to be rare, so in practice, scan repetitions will
>>>>> be rare.
>>>>=20
>>>> In general, tracing is a rather specialized thing.  Why is this very
>>>> occasional confusion a sufficiently serious problem to warrant addition=

>>>> of this code?
>>>=20
>>> I wouldn't call tracing a specialized thing: it's important enough to
>>> justify its own summit and a whole ecosystem of trace collection and
>>> analysis tools. We use it in every day in Android. It's tremendously
>>> helpful for understanding system behavior, especially in cases where
>>> multiple components interact in ways that we can't readily predict or
>>> replicate. Reliability and precision in this area are essential:
>>> retrospective analysis of difficult-to-reproduce problems involves
>>> puzzling over trace files and testing hypothesis, and when the trace
>>> system itself is occasionally unreliable, the set of hypothesis to
>>> consider grows. I've tried to keep the amount of kernel infrastructure
>>> needed to support this precision and reliability to a minimum, pushing
>>> most of the complexity to userspace. But we do need, from the kernel,
>>> reliable process disambiguation.
>>>=20
>>> Besides: things like checkpoint and restart are also non-core
>>> features, but the kernel has plenty of infrastructure to support them.
>>> We're talking about a very lightweight feature in this thread.
>>=20
>> I'm still not understanding the seriousness of the problem.  Presumably
>> you've hit problems in real-life which were serious and frequent enough
>> to justify getting down and writing the code.  Please share some sob stor=
ies
>> with us!
>=20
> The problem here is the possibility of confusion, even if it's rare.
> Does the naive approach of just walking /proc and ignoring the
> possibility of PID reuse races work most of the time? Sure. But "most
> of the time" isn't good enough. It's not that there are tons of sob
> stories: it's that without completely robust reporting, we can't rule
> out of the possibility that weirdness we observe in a given trace is
> actually just an artifact from a kinda-sort-working best-effort trace
> collection system instead of a real anomaly in behavior. Tracing,
> essentially, gives us deltas for system state, and without an accurate
> baseline, collected via some kind of scan on trace startup, it's
> impossible to use these deltas to robustly reconstruct total system
> state at a given time. And this matters, because errors in
> reconstruction (e.g., assigning a thread to the wrong process because
> the IDs happen to be reused) can affect processing of the whole trace.
> If it's 3am and I'm analyzing the lone trace from a dogfooder
> demonstrating a particularly nasty problem, I don't want to find out
> that the trace I'm analyzing ended up being useless because the
> kernel's trace system is merely best effort. It's very cheap to be
> 100% reliable here, so let's be reliable and rule out sources of
> error.
>=20
>>>> Which userspace tools will be using pid_gen?  Are the developers of
>>>> those tools signed up to use pid_gen?
>>>=20
>>> I'll be changing Android tracing tools to capture process snapshots
>>> using pid_gen, using the algorithm in the commit message.
>>=20
>> Which other tools could use this and what was the feedback from their
>> developers?
>=20
> I'm going to have Android's systrace and Perfetto use this approach.
> Exactly how many tools signed up to use this feature do you need?
>=20
>> Those people are the intended audience and the
>> best-positioned reviewers so let's hear from them?
>=20
> I'm writing plenty of trace analysis tools myself, so I'm part of this
> intended audience. Other tracing tool authors have told me about
> out-of-tree hacks for process atomic snapshots via ftrace events. This
> approach avoids the necessity of these more-invasive hacks.

Would a tracepoint for pid reuse solve your problem?=
