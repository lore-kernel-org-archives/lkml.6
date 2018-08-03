Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A80C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED990216FB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gdFw/bm1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED990216FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbeHCEvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 00:51:17 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:51827 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeHCEvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 00:51:17 -0400
Received: by mail-it0-f53.google.com with SMTP id e14-v6so6552576itf.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 19:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yDWajfb0lHTf7F49NZeMnAmU4nBj/P2vU4qk8brw0cs=;
        b=gdFw/bm12xWR44OqgkDalC5udm0+aaseiqww91VkHcW2lSDQgSUqKwbhEcfjQzxUy1
         dglfVJFkKD+SmB8y5jFfOGTp14qq5lF6eH8s0Gp4kdNDTDHnvgwROp1Tmq9bzGMSDkMx
         f1Vrgq4AnAvgYpkqGv38z2ADnjozEVTn8QMs1/yna0OBTmDtTw+xAYMo64lfgchkMeCi
         nTCiqcyxIyz4BDSLwfTKRfOdzuUh0iN1co64wUWifdhXlOFYQXZN/0KJs0fZhD60MbiK
         vjm3wgB61yBfueq+H+sxIZHUiivY2ndCBNQvlAPmWTIH/bInw201yab8aQxsQRfa1xX5
         dTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yDWajfb0lHTf7F49NZeMnAmU4nBj/P2vU4qk8brw0cs=;
        b=WSj7zqsyvf+XirKbbY8xaungSZ7hxAjUzcvbeHkvzubu7tsbzl0DBvSbpNTbRzwOuX
         wRMqIdsd3coyHQIbi47/ZsyHYuioVGH2GjAXJtxUHA/p0sA7X9aBfcLPNTxjn0YLvbRx
         /zCM9SGJ8jpQdz3wm6AS7GMK5vrCq2bgzOx72KeeU0p/12QrPZLySuIzXubH2vbminvT
         TF4JXWjT6qdBfeK/zsNNFX2jQqJVMeTVlfHihG81Hv9/dBvUNMV11WjGZvMxHEvVwQXi
         f2WWf8ABIjp4y3IcCyaV8S2JeRfi6UjWUjxovxsWcPV7HVebVooQ3XgxPebFDuKt2MQQ
         nqrA==
X-Gm-Message-State: AOUpUlGqVKEc7yUVfJ1JbqpsjnvQDHvfYp/WkhNTZaRku0ZJJz790CLv
        GHNWp34Q85I89MJfyoQ14eLMniEFiY7jrVUhZQ/nbk81
X-Google-Smtp-Source: AAOMgpf1KphmcQ128q/YFuPIt8FqZU+uJh0GOWBXc3v9EivJiJ7dvaz6MeBCfagXiP623E1zIy3Ttg7BaGE0q1T+glQ=
X-Received: by 2002:a02:a60e:: with SMTP id c14-v6mr1809977jam.69.1533265030688;
 Thu, 02 Aug 2018 19:57:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:c906:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 19:57:09 -0700 (PDT)
In-Reply-To: <20180802235527.ddb0d1837154e3f98571b3b0@kernel.org>
References: <20180730222423.196630-1-joel@joelfernandes.org> <20180802235527.ddb0d1837154e3f98571b3b0@kernel.org>
From:   Joel Fernandes <joelaf@google.com>
Date:   Thu, 2 Aug 2018 19:57:09 -0700
Message-ID: <CAJWu+opoT6Ky-pwAwBbjDkyt0Y_UF1QUnDshu-_vLTU5K87_HQ@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="00000000000081001205727f1580"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000081001205727f1580
Content-Type: text/plain; charset="UTF-8"

Hi Masami,

On Thu, Aug 2, 2018 at 7:55 AM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> Hi Joel,
>
> I found this caused several issues when testing ftrace.
>
> #1) ftrace boottest (FTRACE_STARTUP_TEST) fails

This sadly appears to be a real issue. The startup test for
"preemptirqsoff" tracer fails, however it passes for only preemptoff
or only irqsoff. I tested only the last 2 tracers, not the first one,
that's why I didn't catch it. I need to debug this more.

> #2) mmiotrace reports "IRQs not enabled as expected" error
> #3) lock subsystem event boottest causes "IRQs not disabled as expected" error (sometimes)

Could you try the below patch and let me know if you still see the
issue? In the v11 I removed the lockdep_recursing() check since it
seemed unnecessary. But I'd like to rule out that there's still some
issue lurking there. Thanks and I appreciate your help, diff is
attached to this email.

> #4) ftracetest test.d/event/toplevel-enable.tc causes "suspicious RCU usage" warning

I sent a patch fixing this with you on CC. I tested that it fixes the
issue you're reporting.

--00000000000081001205727f1580
Content-Type: text/x-patch; charset="US-ASCII"; name="fixup-for-patch-3-3.diff"
Content-Disposition: attachment; filename="fixup-for-patch-3-3.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jkdecswx5

ZGlmZiAtLWdpdCBhL2tlcm5lbC90cmFjZS90cmFjZV9wcmVlbXB0aXJxLmMgYi9rZXJuZWwvdHJh
Y2UvdHJhY2VfcHJlZW1wdGlycS5jCmluZGV4IGU3NmI3OGJmMjU4ZS4uMTNlMmM2ZTk5NDY1IDEw
MDY0NAotLS0gYS9rZXJuZWwvdHJhY2UvdHJhY2VfcHJlZW1wdGlycS5jCisrKyBiL2tlcm5lbC90
cmFjZS90cmFjZV9wcmVlbXB0aXJxLmMKQEAgLTE5LDcgKzE5LDcgQEAgc3RhdGljIERFRklORV9Q
RVJfQ1BVKGludCwgdHJhY2luZ19pcnFfY3B1KTsKIAogdm9pZCB0cmFjZV9oYXJkaXJxc19vbih2
b2lkKQogewotCWlmICghdGhpc19jcHVfcmVhZCh0cmFjaW5nX2lycV9jcHUpKQorCWlmIChsb2Nr
ZGVwX3JlY3Vyc2luZyhjdXJyZW50KSB8fCAhdGhpc19jcHVfcmVhZCh0cmFjaW5nX2lycV9jcHUp
KQogCQlyZXR1cm47CiAKIAl0cmFjZV9pcnFfZW5hYmxlX3JjdWlkbGUoQ0FMTEVSX0FERFIwLCBD
QUxMRVJfQUREUjEpOwpAQCAtMjksNyArMjksNyBAQCBFWFBPUlRfU1lNQk9MKHRyYWNlX2hhcmRp
cnFzX29uKTsKIAogdm9pZCB0cmFjZV9oYXJkaXJxc19vZmYodm9pZCkKIHsKLQlpZiAodGhpc19j
cHVfcmVhZCh0cmFjaW5nX2lycV9jcHUpKQorCWlmIChsb2NrZGVwX3JlY3Vyc2luZyhjdXJyZW50
KSB8fCB0aGlzX2NwdV9yZWFkKHRyYWNpbmdfaXJxX2NwdSkpCiAJCXJldHVybjsKIAogCXRoaXNf
Y3B1X3dyaXRlKHRyYWNpbmdfaXJxX2NwdSwgMSk7CkBAIC0zOSw3ICszOSw3IEBAIEVYUE9SVF9T
WU1CT0wodHJhY2VfaGFyZGlycXNfb2ZmKTsKIAogX192aXNpYmxlIHZvaWQgdHJhY2VfaGFyZGly
cXNfb25fY2FsbGVyKHVuc2lnbmVkIGxvbmcgY2FsbGVyX2FkZHIpCiB7Ci0JaWYgKCF0aGlzX2Nw
dV9yZWFkKHRyYWNpbmdfaXJxX2NwdSkpCisJaWYgKGxvY2tkZXBfcmVjdXJzaW5nKGN1cnJlbnQp
IHx8ICF0aGlzX2NwdV9yZWFkKHRyYWNpbmdfaXJxX2NwdSkpCiAJCXJldHVybjsKIAogCXRyYWNl
X2lycV9lbmFibGVfcmN1aWRsZShDQUxMRVJfQUREUjAsIGNhbGxlcl9hZGRyKTsKQEAgLTQ5LDcg
KzQ5LDcgQEAgRVhQT1JUX1NZTUJPTCh0cmFjZV9oYXJkaXJxc19vbl9jYWxsZXIpOwogCiBfX3Zp
c2libGUgdm9pZCB0cmFjZV9oYXJkaXJxc19vZmZfY2FsbGVyKHVuc2lnbmVkIGxvbmcgY2FsbGVy
X2FkZHIpCiB7Ci0JaWYgKHRoaXNfY3B1X3JlYWQodHJhY2luZ19pcnFfY3B1KSkKKwlpZiAobG9j
a2RlcF9yZWN1cnNpbmcoY3VycmVudCkgfHwgdGhpc19jcHVfcmVhZCh0cmFjaW5nX2lycV9jcHUp
KQogCQlyZXR1cm47CiAKIAl0aGlzX2NwdV93cml0ZSh0cmFjaW5nX2lycV9jcHUsIDEpOwo=
--00000000000081001205727f1580--
