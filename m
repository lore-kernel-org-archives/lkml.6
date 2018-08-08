Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7373DC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D48216FD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cSyyRd/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D48216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbeHHDev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 23:34:51 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43878 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeHHDev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 23:34:51 -0400
Received: by mail-yw1-f68.google.com with SMTP id l189-v6so382160ywb.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 18:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tRM+KQcE2oihYVWtbzxPShdcyVGzk4/3ihMMVTZKsSI=;
        b=cSyyRd/X497nRxBY+wI093ozpXnYeG2SVYDcq+0d+Wnrza/WNrFTRKPn+0UHdc2zN1
         di7v3PnlBRVLsnMpN27qvgQ+eEEeItLPQPIC+a0M+2j54IeVZcXakX4z8uvHP3CWpeWc
         8MFph0B3isbzLLs4N3ZCn4Nm8rOstn/5z4fWFwbjUeWL2EKTLXo4ayFmr1gBA4oCpxgs
         zpJhvIKS9GE+/mjJ0dwFWe20GnFpPDZe6qVukZOPR7mY6h1Fp8oeve6DxadWSt17PC2d
         JW8IcNIK82aCto7MVmhCCYWfc1axM4Dd8P8u3TPhQtfN43VCVIb3zxomb1HOXq8BnxuV
         CZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tRM+KQcE2oihYVWtbzxPShdcyVGzk4/3ihMMVTZKsSI=;
        b=T2PfIq55Va62O9alcKfWqtkDxKbMI5CIgrd5pBPuvckEO84lJURqp75qASwJuKRveJ
         isQIPrbb9n/BOEd+pNrRkjGEZ48Fjpzp7YSbqpX9xqTmz70VWjNWdpWOwLH/UggrHjII
         e4L4yFE3GmUirOrKjgf9W1KeI1xZDjB10bFdu5w2fQTd0QbIFdwWj6KYSU6M8hPRiEts
         AcgmuOPN5BDmNkunVenVbjGk8kG67/Dbx0Xkc3UpVFDkhehQoP61jCYm1WKP1sX4gcIA
         p7QS3XEBeD1n3hHjEs60MJAeVBRa45quJYCF/CJtogzJ2KYi4Z0yIDOP/Rz7ZBYOEsZB
         DDWQ==
X-Gm-Message-State: AOUpUlFxk942utkjtgjlabHHc7i+KRvNe9x9cXWphfGvInultnXvI5it
        K9UJciZIeESAVKQNAmjkHEh5qe4z+JVAuCX1fPDCbQ==
X-Google-Smtp-Source: AA+uWPyJTo3Xv0WhgcR6tNJaFnrwtNtPPvvF7y/UseTV9vLp/LIQEHq8DsiwH+CPnsmsOnDC3cOht1pcBHtZ15EBqcE=
X-Received: by 2002:a25:14c5:: with SMTP id 188-v6mr434731ybu.24.1533691063868;
 Tue, 07 Aug 2018 18:17:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:bfce:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 18:17:42 -0700 (PDT)
In-Reply-To: <20180807204820.50b83c6d@vmware.local.home>
References: <20180730222423.196630-1-joel@joelfernandes.org>
 <20180730222423.196630-4-joel@joelfernandes.org> <20180806155058.5ee875f4@gandalf.local.home>
 <CAJWu+oqvpev_EZC38_mi+UNRCxS8GqNVagHyGM4dUjruzKgwgQ@mail.gmail.com>
 <20180806214300.13e63523@gandalf.local.home> <CAJWu+oqZi2W9OYAn2xu17fdrBitQs4Gti4LxWmtx5B-EYtNMmA@mail.gmail.com>
 <20180807094954.5137972d@gandalf.local.home> <446AE5F2-39E0-46B6-8E0B-207E003DBF20@google.com>
 <20180807103410.4fe203cb@gandalf.local.home> <C1CB990F-8232-4168-89A8-E8C13B660B0B@google.com>
 <20180807110906.3a1b0ac4@gandalf.local.home> <6B9E5DC9-0859-41B4-9B72-A7D85E9EA2AD@google.com>
 <20180807194515.4e549c1a@gandalf.local.home> <6D0A3FD6-2190-4CC0-A3C0-7B3759E73243@google.com>
 <20180807204820.50b83c6d@vmware.local.home>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 7 Aug 2018 18:17:42 -0700
Message-ID: <CAJWu+oqBOEJicepLaUG=JpmtDTgxjRdMyJAgOEUkdk4NzX0esw@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="0000000000000f48e20572e2475f"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000000f48e20572e2475f
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 7, 2018 at 5:48 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 07 Aug 2018 19:54:13 -0400
> Joel Fernandes <joelaf@google.com> wrote:
>
>
>> >OK, I hit this bug, but it's not because of the partial revert. This
>> >bug seems it needs to be another partial revert. I like you movement of
>> >the code, but I'm starting to doubt that we can use a trace event as a
>> >hook for critical areas yet. Well, not until we can use srcu in NMI.
>> >
>>
>> I sent a patch to use srcu for all tracepoints including nmi. That
>> patch also removes this warning and fixes the one other issue masami
>> reported (hot plug causing a warning).
>
> Is it one I can take, or does Paul have it? I'll need it to continue
> with this as is, because I can't pass my tests without triggering that
> warning (and that fails the test).

I think you could take it if you're Ok with it, its purely in the
tracing code and I tested it yesterday morning. Its attached to this
email. I tested that it fixes the mmio trace (hotplug related) issue..

>>
>> If Paul and Mathieu can confirm SRCU works on offline CPUs that would
>> be great.
>
> Yes please.
>

BTW I found this in Paul's docs RCU Requirements docs, "SRCU is insensitive
to whether or not a CPU is online" so I think it will work.

The paragraph was..
Also unlike other RCU flavors, SRCU's callbacks-wait function
srcu_barrier() may be invoked from CPU-hotplug notifiers,
though this is not necessarily a good idea.
The reason that this is possible is that SRCU is insensitive
to whether or not a CPU is online, which means that srcu_barrier()
need not exclude CPU-hotplug operations.

>>
>> It's just this one warning or anything else that makes you feel
>> tracepoints for critical paths isn't feasible?
>
> Currently I'm down to this, but I can't get past my first test in my
> ktest suite, because it fails here.

Ok hopefully this will get you past that. Sorry for the frustration.

--0000000000000f48e20572e2475f
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-tracepoint-Run-tracepoints-even-after-CPU-is-offline.patch"
Content-Disposition: attachment; 
	filename="0001-tracepoint-Run-tracepoints-even-after-CPU-is-offline.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jkkg0mjf0

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
--0000000000000f48e20572e2475f--
