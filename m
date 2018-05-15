Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752953AbeEOQaM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:30:12 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37831 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbeEOQaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:30:10 -0400
X-Google-Smtp-Source: AB8JxZqjN9dv0PhIpwndexd/P5oSfaAqN5tpa8owkNjEHesWYZVI/Q/IXDfU3L8W8dhX3Fc0Uagt5A==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2]: perf/x86: store user space frame-pointer value on a sample
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15E302)
In-Reply-To: <eb83a97a-2e62-9c18-b738-a92b2f4dee23@linux.intel.com>
Date: Tue, 15 May 2018 09:30:05 -0700
Cc: Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Message-Id: <F6BF3B97-F955-4644-A033-4D20CA7F1922@amacapital.net>
References: <31205dc8-b756-e12b-0249-2ed06c2db9c9@linux.intel.com> <20180509145436.GV12217@hirez.programming.kicks-ass.net> <eb83a97a-2e62-9c18-b738-a92b2f4dee23@linux.intel.com>
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4FGUJSL000746


> On May 15, 2018, at 1:08 AM, Alexey Budankov <alexey.budankov@linux.intel.com> wrote:
> 
> 
> Hi Andy,
> 
>> On 09.05.2018 17:54, Peter Zijlstra wrote:
>>> On Tue, May 08, 2018 at 06:21:36PM +0300, Alexey Budankov wrote:
>>> 
>>> Store user space frame-pointer value (BP register) into Perf trace 
>>> on a sample for a process so the value becomes available when 
>>> unwinding call stacks for functions gaining event samples.
>>> 
>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>>> ---
>>> arch/x86/kernel/perf_regs.c | 8 +++++++-
>>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
>>> index e47b2dbbdef3..8d68658eff7f 100644
>>> --- a/arch/x86/kernel/perf_regs.c
>>> +++ b/arch/x86/kernel/perf_regs.c
>>> @@ -156,7 +156,13 @@ void perf_get_regs_user(struct perf_regs *regs_user,
>> 
>> 
>>>     * Most system calls don't save these registers, don't report them.
>> 
>> ^^^ that worries me and is the reason for the '-1's below. However I
>> think with all the PTI rework this might no longer be true.
>> 
>> The Changelog needs to state that user_regs->bp is in fact valid and
>> ideally point to the commits that makes it so. Also this patch should
>> update that comment.
>> 
>> Cc Andy who keeps better track of all that than me.
> 
> Are there any thoughts so far? Feedback on the matter above is highly appreciated.

Sorry, I missed this. Can you forward the original patch?  I don’t have it.
These days, system calls should save all registers, but I’m not entirely sure I want to promise that they’ll continue to do so forever.
