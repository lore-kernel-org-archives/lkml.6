Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E40EC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D59208D6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FTKxQ3Rp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D59208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389240AbeHGPr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:47:59 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45547 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbeHGPr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:47:58 -0400
Received: by mail-yw1-f65.google.com with SMTP id 139-v6so4910458ywg.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 06:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=49QhjOptnE6FYh7HZTnbm5T+qlL2Z7m8kanSDJHZEyg=;
        b=FTKxQ3RpA33wrjc2PfzkQyQyQhSZKST12UqIT7RBJ5WGvKBbFX6A9tp5b9PoMc/IXX
         Sp4j+2rM3KLu1Hw7zDh+msWsnrUYVugPEVlLsn9CtqrUCv65rgMDgze1+OPUdgXGIr4P
         jQhlWA8jj1Kw4KsCcvgUYeXBTs6WGbtp3rJlPpuClpqL0xEC+IHoTPJFK43O8kwLTCBu
         /o8F2dN5KM6b1cKGhJnwRuVzlN7cp2w/RRoqGQGwWaWScvH5lV3nGTSo0bky0cTU7r8+
         e709x8EGc/1k6KT5w+LMRJiRQFzw933AkOODiJHpgsmZauZevcOOmKE/WA0yevJ5fazQ
         0fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=49QhjOptnE6FYh7HZTnbm5T+qlL2Z7m8kanSDJHZEyg=;
        b=niLVXfe/Szt7tD0cH4/aDTwgERvptMSvtwcTtk4voX4Vhr6v2csyZHnBX6Ya3jtAf1
         2WFUm1gkGkdHoBPXyaYGdXrJuhhhBec4Lm4kNYPwWowUpxL8WSY1vJmR/UNkvwOv8wzw
         VxrtCEf7kNKIllZMx78SZVn+NsRbmJjYoabM3G7KxLtDLJ+3vM48ngsx82voITZbQOwY
         Ia1+Fzn7KqqTH1tVn4sTe5Cs8iXiIalum5GZDC98KCUNGe4PI4zTmBgpc2cY0MUqiDEU
         NSyYsyKTBUykdwGDS/nlaYEGrvkRZ5pS6AvYpl3CwGIuMEaavnBG9wE9hOHJpDs+40BQ
         30PQ==
X-Gm-Message-State: AOUpUlEhk/ZsIlXBa3Qq53HEC0JKLyLOg9Tt5gwVFkVxkANPjkmbIElW
        OXjhMlh0KoJfM6hcnJe5pPCGW3isfxgm1e+cc6aCwlSQUFM=
X-Google-Smtp-Source: AAOMgpcBTY9MA+oTVBAsVy6I+FKcnoBsnCPgeAzViTJ6ZyXsLKgdNQnFzlex2nMAp8hSWgmNaRiFAKxint5IhiByvCs=
X-Received: by 2002:a81:1d7:: with SMTP id 206-v6mr10118946ywb.223.1533648816142;
 Tue, 07 Aug 2018 06:33:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:bfce:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 06:33:35 -0700 (PDT)
In-Reply-To: <20180806214300.13e63523@gandalf.local.home>
References: <20180730222423.196630-1-joel@joelfernandes.org>
 <20180730222423.196630-4-joel@joelfernandes.org> <20180806155058.5ee875f4@gandalf.local.home>
 <CAJWu+oqvpev_EZC38_mi+UNRCxS8GqNVagHyGM4dUjruzKgwgQ@mail.gmail.com> <20180806214300.13e63523@gandalf.local.home>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 7 Aug 2018 06:33:35 -0700
Message-ID: <CAJWu+oqZi2W9OYAn2xu17fdrBitQs4Gti4LxWmtx5B-EYtNMmA@mail.gmail.com>
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

On Mon, Aug 6, 2018 at 6:43 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 6 Aug 2018 17:43:19 -0700
> Joel Fernandes <joelaf@google.com> wrote:
>
>> On Mon, Aug 6, 2018 at 12:50 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>> >
>> > With this patch applied, I'm constantly getting lockdep errors. Instead
>> > of doing a full revert of the patch, I did this, which makes all those
>> > errors go away. I may apply this for now, and we can revisit having
>> > lockdep use the tracepoint code. But since it's currently always
>> > enabled, I'm thinking of just leaving this as is. The macros are still
>> > clean from Joel's patch.
>> >
>> > Thoughts?
>>
>> I like your patch. Thanks a lot for doing this.. It keeps most of the
>> benefits of my patch while avoiding the issues with lockdep. I agree
>> we can look at the remaining lockdep issue after. There were several
>> lockdep issues with this patch that I fixed over the the months, but
>> there's still the one that Masami reported that I believe you're also
>> seeing. Once I'm back I'll work on figuring that one out.
>>
>> Could you pull in the fixes to the other issues I posted though? With
>> that we should be good.
>> https://lore.kernel.org/patchwork/patch/971104/
>> https://lore.kernel.org/patchwork/patch/971829/
>>
>
> I already had these applied when I created this patch ;-)
>
> Thanks, I'll add it.

Thanks, also one more thing I noticed in your patch,
lockdep_hardirqs_off needs to be called before all other probes but
you're calling it after. This is why I registered it with INT_MAX:

register_trace_prio_irq_disable(lockdep_hardirqs_off, NULL, INT_MAX);

Without it you may get annotation warnings. Thanks,

- Joel
