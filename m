Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD061C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC0521A52
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fRQSzlCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC0521A52
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732858AbeHFRd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:33:58 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43147 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729552AbeHFRd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:33:57 -0400
Received: by mail-yw1-f67.google.com with SMTP id l189-v6so3734412ywb.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rK0Nubv+d7Yhvm5crNOjXnGBZsKpZkFteDL+SkwZCBk=;
        b=fRQSzlChcguLc4jxLl2auTXRrzM9npPbF9BhDNqre3YBgkgYOWEDaRgMZ7ZpH72+QD
         mokEgUxl308PSC3r4JIREZt6ivv12FZHBgYHI5GhgjmofMv2ccZehkRIKUp2tswXAqiP
         yuCynk8r5JOpwc+TOCWr8cnwTGnci1jJXhJ4OGq3Yk8sTjm3QKHlbVg+kahIEXtgKVC5
         vYL9mNqGgIKMiBwt7Cp/+mdCyXNhUCWCsp/L8njUvTTwt9hmx95J/00O8GZpeZgUr8LQ
         CNsXzL4+GBSmElovGZcl2MI8j6+datnqviCAr9rbLTewDOJBz2z/IfGgY3IPyNbzkNkM
         mZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rK0Nubv+d7Yhvm5crNOjXnGBZsKpZkFteDL+SkwZCBk=;
        b=Oq3dBi9HOJ8o0K3WLZgWONzrM+klUAJQJsYLRqx5UVOwiKxO/kxGRSHqSBuNKEwdEC
         gLBu95DhDiSPWY4yJTTfoomdTJoyeCZ3u0SVxzUWvz1Tkoo7xlPIc0ly4qKlTzRGVePV
         yzNALpIN2BujwJHnrMN9Q7z1vwwB3E2DEE99ye4btMoWYWFhWn6yS2aZGwN48w5qSkzl
         VdqGhh8wh6rvlf8GeKkwiaKa0+MDxDcyig73dHL8gzFYidLuo/q4gidBqpuHuEO/X91y
         IWnysvMmAyRt/QET0vlnU0WR07zgqtEB9vBUYOM21G88AkVfKtNW0cU+vZSgrWVEd+VF
         jp7w==
X-Gm-Message-State: AOUpUlErJ8JBlkwx+I/00Cc2I0l9E8ygJMU2CO7AhUjK2R8evi9l5Ajk
        1436nyb+JZjNxgrO+QaJhc04u9P0/APi4COl36aCMg==
X-Google-Smtp-Source: AAOMgpePwA8i4zoV5FGqI+ArH1ugm4aTOZnvAuEr/JNlFhjQ9uovmkb5QY/oxo2jO2O++laq+rmQpBZPGnwzhms5EKE=
X-Received: by 2002:a0d:c143:: with SMTP id c64-v6mr8197764ywd.408.1533569060317;
 Mon, 06 Aug 2018 08:24:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:bfce:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 08:24:19 -0700 (PDT)
In-Reply-To: <20180806110729.fc79c61d5208cf642e223e90@kernel.org>
References: <20180730222423.196630-1-joel@joelfernandes.org>
 <20180802235527.ddb0d1837154e3f98571b3b0@kernel.org> <CAJWu+opoT6Ky-pwAwBbjDkyt0Y_UF1QUnDshu-_vLTU5K87_HQ@mail.gmail.com>
 <20180803162340.32b4b3fde55a4f5a5c28b425@kernel.org> <CAJWu+opO9-bb5RWorbQ54vq0rU1U6NFSnH9BDwGTvXhSaPmPTg@mail.gmail.com>
 <CAJWu+oq3HD3VhYzvRJA-8HQksdrX5zYr4kz7EUpDYvCNQRUGXw@mail.gmail.com> <20180806110729.fc79c61d5208cf642e223e90@kernel.org>
From:   Joel Fernandes <joelaf@google.com>
Date:   Mon, 6 Aug 2018 08:24:19 -0700
Message-ID: <CAJWu+or50v6KYVESP3EZDa3i0NRVo7wXxvwqSGjoRxaGR3ZhgQ@mail.gmail.com>
Subject: Re: [PATCH v12 0/3] tracing: Centralize preemptirq tracepoints and
 unify their usage
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Content-Type: multipart/mixed; boundary="00000000000014e7bc0572c5dfec"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000014e7bc0572c5dfec
Content-Type: text/plain; charset="UTF-8"

On Sun, Aug 5, 2018 at 7:07 PM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> On Sun, 5 Aug 2018 09:46:56 -0700
> Joel Fernandes <joelaf@google.com> wrote:
>
>> Hi Masami,
>>
>> On Fri, Aug 3, 2018 at 9:51 PM, Joel Fernandes <joelaf@google.com> wrote:
>> [...]
>> >> On Thu, 2 Aug 2018 19:57:09 -0700
>> >> Joel Fernandes <joelaf@google.com> wrote:
>> >>
>> >>> Hi Masami,
>> >>>
>> >>> On Thu, Aug 2, 2018 at 7:55 AM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>> >>> > Hi Joel,
>> >>> >
>> >>> > I found this caused several issues when testing ftrace.
>> >>> >
>> >>> > #1) ftrace boottest (FTRACE_STARTUP_TEST) fails
>> >>>
>> >>> This sadly appears to be a real issue. The startup test for
>> >>> "preemptirqsoff" tracer fails, however it passes for only preemptoff
>> >>> or only irqsoff. I tested only the last 2 tracers, not the first one,
>> >>> that's why I didn't catch it. I need to debug this more.
>>
>> I figured out this one too. Its because I need to account for
>> preempt_count() in tracer_hardirqs_off since the tracer probe is now
>> called with an additional level of preempt disabled from the
>> tracepoint code. Without that accounting, stop_critical_timings may
>> not be called causing an empty trace buffer. That should be easy to
>> fix, I'm on vacation though and back on 13th so can most likely look
>> at it only then (the week after the next).
>
> Nice! Thank you for identifying the root cause!

No problem :) Thanks a lot for your help!

>> >>> > #2) mmiotrace reports "IRQs not enabled as expected" error

I fixed #2 too now, the attached patch based on ftrace/core should fix
it (Sorry couldn't post the patch inline because I'm not at a sane
email client right now).

The patch is still in RFC shape, but I verified it fixes the issue.

Basically, I do this in the patch:
- switch to using SRCU for all tracepoints, use a separate SRCU node
for NMI context (Paul, Mathieu would love to get your thoughts here).
This is to remove dependence on sched-RCU.
- use tracepoints even after CPUs are offline

>> >>> > #3) lock subsystem event boottest causes "IRQs not disabled as expected" error (sometimes)
>> The only thing left to figure out is #3 ("lock subsystem event
>> boottest"). Could you let me know how to run this test?
>
> The #3 is not always reproducible, I just enabled these 2 configs
>
> CONFIG_FTRACE_STARTUP_TEST=y and CONFIG_EVENT_TRACE_TEST_SYSCALLS=y

Thanks, I am also able to see this now some of the times. I have
certain builds where this is much faster to reproduce so I'll use
those.

- Joel

--00000000000014e7bc0572c5dfec
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-tracepoint-Run-tracepoints-even-after-CPU-is-offline.patch"
Content-Disposition: attachment; 
	filename="0001-tracepoint-Run-tracepoints-even-after-CPU-is-offline.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jkifbj130

RnJvbSA2OTg2YWY5NDZjZWIwNGZjOWRkYzZkNWI0NWZjNTU5YjY4MDdlNDY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiSm9lbCBGZXJuYW5kZXMgKEdvb2dsZSkiIDxqb2VsQGpvZWxm
ZXJuYW5kZXMub3JnPgpEYXRlOiBTdW4sIDUgQXVnIDIwMTggMjA6MTc6NDEgLTA3MDAKU3ViamVj
dDogW1BBVENIXSB0cmFjZXBvaW50OiBSdW4gdHJhY2Vwb2ludHMgZXZlbiBhZnRlciBDUFUgaXMg
b2ZmbGluZQoKQ29tbWl0IGYzNzc1NTQ5MGZlOSAoInRyYWNlcG9pbnRzOiBEbyBub3QgdHJhY2Ug
d2hlbiBjcHUgaXMgb2ZmbGluZSIpCmNhdXNlcyBhIHByb2JsZW0gZm9yIGxvY2tkZXAgdXNpbmcg
dHJhY2Vwb2ludCBjb2RlLiBPbmNlIGEgQ1BVIGlzCm9mZmxpbmUsIHRyYWNlcG9pbnRzIGRvbm90
IGdldCBjYWxsZWQsIGhvd2V2ZXIgdGhpcyBjYXVzZXMgYSBiaWcgcHJvYmxlbQpmb3IgbG9ja2Rl
cCBwcm9iZXMgdGhhdCBuZWVkIHRvIHJ1biBzbyB0aGF0IElSUSBhbm5vdGF0aW9ucyBhcmUgbWFy
a2VkCmNvcnJlY3RseS4KCkEgcmFjZSBpcyBwb3NzaWJsZSB3aGVyZSB3aGlsZSB0aGUgQ1BVIGlz
IGdvaW5nIG9mZmxpbmUsIGFuIGludGVycnVwdApjYW4gY29tZSBpbiBhbmQgdGhlbiBhIGxvY2tk
ZXAgYXNzZXJ0IGNhdXNlcyBhbiBhbm5vdGF0aW9uIHdhcm5pbmc6CgpbICAxMDYuNTUxMzU0XSBJ
UlFzIG5vdCBlbmFibGVkIGFzIGV4cGVjdGVkClsgIDEwNi41NTE3ODVdIFdBUk5JTkc6IENQVTog
MSBQSUQ6IDAgYXQga2VybmVsL3RpbWUvdGljay1zY2hlZC5jOjk4MgogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHRpY2tfbm9oel9pZGxlX2VudGVyKzB4OTkvMHhiMApb
ICAxMDYuNTUyOTY0XSBNb2R1bGVzIGxpbmtlZCBpbjoKWyAgMTA2LjU1MzI5OV0gQ1BVOiAxIFBJ
RDogMCBDb21tOiBzd2FwcGVyLzEgVGFpbnRlZDogRyAgICAgICAgVwoKV2UgbmVlZCB0cmFjZXBv
aW50cyB0byBydW4gYXMgbGF0ZSBhcyBwb3NzaWJsZS4gVGhpcyBjb21taXQgZml4ZXMgdGhlCmlz
c3VlIGJ5IHJlbW92aW5nIHRoZSBjcHVfb25saW5lIGNoZWNrIGluIHRyYWNlcG9pbnQgY29kZSB0
aGF0IHdhcwppbnRyb2R1Y2VkIGluIHRoZSBtZW50aW9uZWQgY29tbWl0LCBob3dldmVyIHdlIG5v
dyBzd2l0Y2ggdG8gdXNpbmcgU1JDVQpmb3IgYWxsIHRyYWNlcG9pbnRzIGFuZCBzcGVjaWFsIGhh
bmRsZSBjYWxsaW5nIHRyYWNlcG9pbnRzIGZyb20gTk1JIHNvCnRoYXQgd2UgZG9uJ3QgcnVuIGlu
dG8gaXNzdWVzIHRoYXQgcmVzdWx0IGZyb20gdXNpbmcgc2NoZWQtUkNVIHdoZW4gdGhlCkNQVXMg
YXJlIG1hcmtlZCB0byBiZSBvZmZsaW5lLgoKRml4ZXM6IGMzYmM4ZmQ2MzdhOSAoInRyYWNpbmc6
IENlbnRyYWxpemUgcHJlZW1wdGlycSB0cmFjZXBvaW50cyBhbmQKICAgICAgICAgICAgICAgICAg
ICAgIHVuaWZ5IHRoZWlyIHVzYWdlIikKUmVwb3J0ZWQtYnk6IE1hc2FtaSBIaXJhbWF0c3UgPG1o
aXJhbWF0QGtlcm5lbC5vcmc+ClNpZ25lZC1vZmYtYnk6IEpvZWwgRmVybmFuZGVzIChHb29nbGUp
IDxqb2VsQGpvZWxmZXJuYW5kZXMub3JnPgotLS0KIGluY2x1ZGUvbGludXgvdHJhY2Vwb2ludC5o
IHwgMjcgKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tCiBrZXJuZWwvdHJhY2Vwb2ludC5jICAg
ICAgICB8IDEwICsrKysrKy0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwg
MjAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC90cmFjZXBvaW50Lmgg
Yi9pbmNsdWRlL2xpbnV4L3RyYWNlcG9pbnQuaAppbmRleCBkOWEwODRjNzI1NDEuLjU3MzM1MDJi
YjNjZSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC90cmFjZXBvaW50LmgKKysrIGIvaW5jbHVk
ZS9saW51eC90cmFjZXBvaW50LmgKQEAgLTM1LDYgKzM1LDcgQEAgc3RydWN0IHRyYWNlX2V2YWxf
bWFwIHsKICNkZWZpbmUgVFJBQ0VQT0lOVF9ERUZBVUxUX1BSSU8JMTAKIAogZXh0ZXJuIHN0cnVj
dCBzcmN1X3N0cnVjdCB0cmFjZXBvaW50X3NyY3U7CitleHRlcm4gc3RydWN0IHNyY3Vfc3RydWN0
IHRyYWNlcG9pbnRfc3JjdV9ubWk7CiAKIGV4dGVybiBpbnQKIHRyYWNlcG9pbnRfcHJvYmVfcmVn
aXN0ZXIoc3RydWN0IHRyYWNlcG9pbnQgKnRwLCB2b2lkICpwcm9iZSwgdm9pZCAqZGF0YSk7CkBA
IC0xNDQsMTMgKzE0NSwxMSBAQCBleHRlcm4gdm9pZCBzeXNjYWxsX3VucmVnZnVuYyh2b2lkKTsK
IAkJdm9pZCAqaXRfZnVuYzsJCQkJCQlcCiAJCXZvaWQgKl9fZGF0YTsJCQkJCQlcCiAJCWludCBf
X21heWJlX3VudXNlZCBpZHggPSAwOwkJCQlcCisJCXN0cnVjdCBzcmN1X3N0cnVjdCAqc3M7CQkJ
CQlcCiAJCQkJCQkJCQlcCiAJCWlmICghKGNvbmQpKQkJCQkJCVwKIAkJCXJldHVybjsJCQkJCQlc
CiAJCQkJCQkJCQlcCi0JCS8qIHNyY3UgY2FuJ3QgYmUgdXNlZCBmcm9tIE5NSSAqLwkJCVwKLQkJ
V0FSTl9PTl9PTkNFKHJjdWlkbGUgJiYgaW5fbm1pKCkpOwkJCVwKLQkJCQkJCQkJCVwKIAkJLyog
a2VlcCBzcmN1IGFuZCBzY2hlZC1yY3UgdXNhZ2UgY29uc2lzdGVudCAqLwkJXAogCQlwcmVlbXB0
X2Rpc2FibGVfbm90cmFjZSgpOwkJCQlcCiAJCQkJCQkJCQlcCkBAIC0xNTksNyArMTU4LDExIEBA
IGV4dGVybiB2b2lkIHN5c2NhbGxfdW5yZWdmdW5jKHZvaWQpOwogCQkgKiBkb2Vzbid0IHdvcmsg
ZnJvbSB0aGUgaWRsZSBwYXRoLgkJCVwKIAkJICovCQkJCQkJCVwKIAkJaWYgKHJjdWlkbGUpCQkJ
CQkJXAotCQkJaWR4ID0gc3JjdV9yZWFkX2xvY2tfbm90cmFjZSgmdHJhY2Vwb2ludF9zcmN1KTsJ
XAorCQkJc3MgPSAmdHJhY2Vwb2ludF9zcmN1X25taTsJCQlcCisJCWVsc2UJCQkJCQkJXAorCQkJ
c3MgPSAmdHJhY2Vwb2ludF9zcmN1OwkJCQlcCisJCQkJCQkJCQlcCisJCWlkeCA9IHNyY3VfcmVh
ZF9sb2NrX25vdHJhY2Uoc3MpOwkJCVwKIAkJCQkJCQkJCVwKIAkJaXRfZnVuY19wdHIgPSByY3Vf
ZGVyZWZlcmVuY2VfcmF3KCh0cCktPmZ1bmNzKTsJCVwKIAkJCQkJCQkJCVwKQEAgLTE3MSw4ICsx
NzQsNyBAQCBleHRlcm4gdm9pZCBzeXNjYWxsX3VucmVnZnVuYyh2b2lkKTsKIAkJCX0gd2hpbGUg
KCgrK2l0X2Z1bmNfcHRyKS0+ZnVuYyk7CQlcCiAJCX0JCQkJCQkJXAogCQkJCQkJCQkJXAotCQlp
ZiAocmN1aWRsZSkJCQkJCQlcCi0JCQlzcmN1X3JlYWRfdW5sb2NrX25vdHJhY2UoJnRyYWNlcG9p
bnRfc3JjdSwgaWR4KTtcCisJCXNyY3VfcmVhZF91bmxvY2tfbm90cmFjZShzcywgaWR4KTsJCQlc
CiAJCQkJCQkJCQlcCiAJCXByZWVtcHRfZW5hYmxlX25vdHJhY2UoKTsJCQkJXAogCX0gd2hpbGUg
KDApCkBAIC0yMTIsMTEgKzIxNCw2IEBAIGV4dGVybiB2b2lkIHN5c2NhbGxfdW5yZWdmdW5jKHZv
aWQpOwogCQkJCVRQX1BST1RPKGRhdGFfcHJvdG8pLAkJCVwKIAkJCQlUUF9BUkdTKGRhdGFfYXJn
cyksCQkJXAogCQkJCVRQX0NPTkRJVElPTihjb25kKSwgMCk7CQkJXAotCQlpZiAoSVNfRU5BQkxF
RChDT05GSUdfTE9DS0RFUCkgJiYgKGNvbmQpKSB7CQlcCi0JCQlyY3VfcmVhZF9sb2NrX3NjaGVk
X25vdHJhY2UoKTsJCQlcCi0JCQlyY3VfZGVyZWZlcmVuY2Vfc2NoZWQoX190cmFjZXBvaW50XyMj
bmFtZS5mdW5jcyk7XAotCQkJcmN1X3JlYWRfdW5sb2NrX3NjaGVkX25vdHJhY2UoKTsJCVwKLQkJ
fQkJCQkJCQlcCiAJfQkJCQkJCQkJXAogCV9fREVDTEFSRV9UUkFDRV9SQ1UobmFtZSwgUEFSQU1T
KHByb3RvKSwgUEFSQU1TKGFyZ3MpLAkJXAogCQlQQVJBTVMoY29uZCksIFBBUkFNUyhkYXRhX3By
b3RvKSwgUEFSQU1TKGRhdGFfYXJncykpCVwKQEAgLTM2NSwxOSArMzYyLDE3IEBAIGV4dGVybiB2
b2lkIHN5c2NhbGxfdW5yZWdmdW5jKHZvaWQpOwogICogInZvaWQgKl9fZGF0YSwgcHJvdG8iIGFz
IHRoZSBjYWxsYmFjayBwcm90b3R5cGUuCiAgKi8KICNkZWZpbmUgREVDTEFSRV9UUkFDRV9OT0FS
R1MobmFtZSkJCQkJCVwKLQlfX0RFQ0xBUkVfVFJBQ0UobmFtZSwgdm9pZCwgLAkJCQkJXAotCQkJ
Y3B1X29ubGluZShyYXdfc21wX3Byb2Nlc3Nvcl9pZCgpKSwJCVwKKwlfX0RFQ0xBUkVfVFJBQ0Uo
bmFtZSwgdm9pZCwgLCAxLAkJCQlcCiAJCQl2b2lkICpfX2RhdGEsIF9fZGF0YSkKIAogI2RlZmlu
ZSBERUNMQVJFX1RSQUNFKG5hbWUsIHByb3RvLCBhcmdzKQkJCQlcCi0JX19ERUNMQVJFX1RSQUNF
KG5hbWUsIFBBUkFNUyhwcm90byksIFBBUkFNUyhhcmdzKSwJCVwKLQkJCWNwdV9vbmxpbmUocmF3
X3NtcF9wcm9jZXNzb3JfaWQoKSksCQlcCisJX19ERUNMQVJFX1RSQUNFKG5hbWUsIFBBUkFNUyhw
cm90byksIFBBUkFNUyhhcmdzKSwgMSwJCVwKIAkJCVBBUkFNUyh2b2lkICpfX2RhdGEsIHByb3Rv
KSwJCQlcCiAJCQlQQVJBTVMoX19kYXRhLCBhcmdzKSkKIAogI2RlZmluZSBERUNMQVJFX1RSQUNF
X0NPTkRJVElPTihuYW1lLCBwcm90bywgYXJncywgY29uZCkJCVwKIAlfX0RFQ0xBUkVfVFJBQ0Uo
bmFtZSwgUEFSQU1TKHByb3RvKSwgUEFSQU1TKGFyZ3MpLAkJXAotCQkJY3B1X29ubGluZShyYXdf
c21wX3Byb2Nlc3Nvcl9pZCgpKSAmJiAoUEFSQU1TKGNvbmQpKSwgXAorCQkJUEFSQU1TKGNvbmQp
LAkJCQkJXAogCQkJUEFSQU1TKHZvaWQgKl9fZGF0YSwgcHJvdG8pLAkJCVwKIAkJCVBBUkFNUyhf
X2RhdGEsIGFyZ3MpKQogCmRpZmYgLS1naXQgYS9rZXJuZWwvdHJhY2Vwb2ludC5jIGIva2VybmVs
L3RyYWNlcG9pbnQuYwppbmRleCA5NTUxNDhkOTFiNzQuLjc2OWQ3NGIyZjkwZSAxMDA2NDQKLS0t
IGEva2VybmVsL3RyYWNlcG9pbnQuYworKysgYi9rZXJuZWwvdHJhY2Vwb2ludC5jCkBAIC0zMiw3
ICszMiw5IEBAIGV4dGVybiBzdHJ1Y3QgdHJhY2Vwb2ludCAqIGNvbnN0IF9fc3RhcnRfX190cmFj
ZXBvaW50c19wdHJzW107CiBleHRlcm4gc3RydWN0IHRyYWNlcG9pbnQgKiBjb25zdCBfX3N0b3Bf
X190cmFjZXBvaW50c19wdHJzW107CiAKIERFRklORV9TUkNVKHRyYWNlcG9pbnRfc3JjdSk7CitE
RUZJTkVfU1JDVSh0cmFjZXBvaW50X3NyY3Vfbm1pKTsKIEVYUE9SVF9TWU1CT0xfR1BMKHRyYWNl
cG9pbnRfc3JjdSk7CitFWFBPUlRfU1lNQk9MX0dQTCh0cmFjZXBvaW50X3NyY3Vfbm1pKTsKIAog
LyogU2V0IHRvIDEgdG8gZW5hYmxlIHRyYWNlcG9pbnQgZGVidWcgb3V0cHV0ICovCiBzdGF0aWMg
Y29uc3QgaW50IHRyYWNlcG9pbnRfZGVidWc7CkBAIC03MCwxNCArNzIsMTQgQEAgc3RhdGljIGlu
bGluZSB2b2lkICphbGxvY2F0ZV9wcm9iZXMoaW50IGNvdW50KQogCXJldHVybiBwID09IE5VTEwg
PyBOVUxMIDogcC0+cHJvYmVzOwogfQogCi1zdGF0aWMgdm9pZCBzcmN1X2ZyZWVfb2xkX3Byb2Jl
cyhzdHJ1Y3QgcmN1X2hlYWQgKmhlYWQpCitzdGF0aWMgdm9pZCBzcmN1X2ZyZWVfb2xkX3Byb2Jl
c19ubWkoc3RydWN0IHJjdV9oZWFkICpoZWFkKQogewogCWtmcmVlKGNvbnRhaW5lcl9vZihoZWFk
LCBzdHJ1Y3QgdHBfcHJvYmVzLCByY3UpKTsKIH0KIAotc3RhdGljIHZvaWQgcmN1X2ZyZWVfb2xk
X3Byb2JlcyhzdHJ1Y3QgcmN1X2hlYWQgKmhlYWQpCitzdGF0aWMgdm9pZCBzcmN1X2ZyZWVfb2xk
X3Byb2JlcyhzdHJ1Y3QgcmN1X2hlYWQgKmhlYWQpCiB7Ci0JY2FsbF9zcmN1KCZ0cmFjZXBvaW50
X3NyY3UsIGhlYWQsIHNyY3VfZnJlZV9vbGRfcHJvYmVzKTsKKwljYWxsX3NyY3UoJnRyYWNlcG9p
bnRfc3JjdV9ubWksIGhlYWQsIHNyY3VfZnJlZV9vbGRfcHJvYmVzX25taSk7CiB9CiAKIHN0YXRp
YyBpbmxpbmUgdm9pZCByZWxlYXNlX3Byb2JlcyhzdHJ1Y3QgdHJhY2Vwb2ludF9mdW5jICpvbGQp
CkBAIC05MSw3ICs5Myw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCByZWxlYXNlX3Byb2JlcyhzdHJ1
Y3QgdHJhY2Vwb2ludF9mdW5jICpvbGQpCiAJCSAqIGNvdmVyIGJvdGggY2FzZXMuIFNvIGxldCB1
cyBjaGFpbiB0aGUgU1JDVSBhbmQgc2NoZWQgUkNVCiAJCSAqIGNhbGxiYWNrcyB0byB3YWl0IGZv
ciBib3RoIGdyYWNlIHBlcmlvZHMuCiAJCSAqLwotCQljYWxsX3JjdV9zY2hlZCgmdHBfcHJvYmVz
LT5yY3UsIHJjdV9mcmVlX29sZF9wcm9iZXMpOworCQljYWxsX3NyY3UoJnRyYWNlcG9pbnRfc3Jj
dSwgJnRwX3Byb2Jlcy0+cmN1LCBzcmN1X2ZyZWVfb2xkX3Byb2Jlcyk7CiAJfQogfQogCi0tIAoy
LjE4LjAuNTk3LmdhNzE3MTZmMWFkLWdvb2cKCg==
--00000000000014e7bc0572c5dfec--
