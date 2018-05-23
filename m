Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932305AbeEWJmj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:42:39 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38151 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932186AbeEWJmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:42:36 -0400
X-Google-Smtp-Source: AB8JxZoZoLVFOJ3L2Az26H/l+89xsn4dprQqpVobE2B5ExAZMBWMBtXAjNR1vt0cILux4SC8bea74g==
Date: Wed, 23 May 2018 02:42:32 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20180523090101.6xifikvjpirqafox@vireshk-i7>
References: <20180518185501.173552-1-joel@joelfernandes.org> <20180522103415.cuutobi5kbhj4gcw@vireshk-i7> <20180522220953.GB40506@joelaf.mtv.corp.google.com> <20180523090101.6xifikvjpirqafox@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH v2] schedutil: Allow cpufreq requests to be made even when kthread kicked
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: "Joel Fernandes (Google.)" <joelaf@google.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>, Todd Kjos <tkjos@google.com>,
        claudio@evidence.eu.com, kernel-team@android.com,
        linux-pm@vger.kernel.org
From: Joel Fernandes <joel@joelfernandes.org>
Message-ID: <6A76301E-E383-439D-AD1E-6DC2B2CAC3CE@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4N9ggLF014996



On May 23, 2018 2:01:01 AM PDT, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>On 22-05-18, 15:09, Joel Fernandes wrote:
>> I agree with the race you describe for single policy slow-switch.
>Good find :)
>> 
>> The mainline sugov_work could also do such reordering in sugov_work,
>I think. Even
>> with the mutex_unlock in mainline's sugov_work, that work_in_progress
>write could
>> be reordered by the CPU to happen before the read of next_freq. AIUI,
>> mutex_unlock is expected to be only a release-barrier.
>> 
>> Although to be safe, I could just put an smp_mb() there. I believe
>with that,
>> no locking would be needed for such case.
>> 
>> I'll send out a v3 with Acks for the original patch, and the send out
>the
>> smp_mb() as a separate patch if that's Ok.
>
>Maybe it would be better to get the fix (with smp_mb) first and then
>this optimization patch on the top? That would mean that the fix can
>get applied to stable kernels easily.

Probably. But then Rafael is changing single policy to use the lock so then barrier wouldn't be needed at all. In that case, both mine and Rafael new patch can go into stable which handles your race ( optimization == fix in this case :P )

thanks,

- Joel

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
