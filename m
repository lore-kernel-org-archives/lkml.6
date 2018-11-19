Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3226DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FAFD20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="sLd4Hzz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FAFD20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbeKSU7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:59:25 -0500
Received: from mail-40135.protonmail.ch ([185.70.40.135]:48667 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbeKSU7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:59:25 -0500
Date:   Mon, 19 Nov 2018 10:35:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1542623763;
        bh=qAWwY7HzNS9LzsgTOIdkeVPcyo6UYU4FRQaA6J5QH68=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=sLd4Hzz57knAAGkS5w0d9mJdLPWeXy5IbHCZpbmRR4KRNkGrpk+WgnvlsfXMCE7sk
         aQGMEIwOioDuwdwaHlK1XUq7vNOiaugRifN99fgCWJWyScP/KeGx1nR7RdFjcEbz4l
         pqzEztIsWGhxO7qxXsNyy/gqNadSouA4fpz/5v4g=
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
From:   Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jonatan Corbet <corbet@lwn.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: [PATCH v1 2/2]: Documentation/admin-guide: introduce perf-security.rst file
Message-ID: <aDN4nC6p93nK7ILVP3EH-Y4RcKK4KH0ppQKFkIgxTVxkfbOHWjAYJXdTeuq39nbPkySKItZ_8VHN2PfQS_T08GBzeooD5cvc2Xd8oZxSp9s=@protonmail.ch>
In-Reply-To: <a44df303-d962-c1a4-4fe0-6bad887ebcdc@linux.intel.com>
References: <0ac97cd0-4773-fff6-7d4e-74c4a1f076c4@linux.intel.com>
 <a44df303-d962-c1a4-4fe0-6bad887ebcdc@linux.intel.com>
Feedback-ID: QEdvdaLhFJaqnofhWA-dldGwsuoeDdDw7vz0UPs8r8sanA3bIt8zJdf4aDqYKSy4gJuZ0WvFYJtvq21y6ge_uQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, November 19, 2018 6:42 AM, Alexey Budankov <alexey.budankov@linu=
x.intel.com> wrote:

> Implement initial version of perf-security.rst documentation file
> initially covering security concerns related to PCL/Perf performance
> monitoring in multiuser environments.
>
> Suggested-by: Thomas Gleixner tglx@linutronix.de
> Signed-off-by: Alexey Budankov alexey.budankov@linux.intel.com
>
> Documentation/admin-guide/perf-security.rst | 83 ++++++++++++++++++++++++=
+++++
> 1 file changed, 83 insertions(+)
>
> diff --git a/Documentation/admin-guide/perf-security.rst b/Documentation/=
admin-guide/perf-security.rst
> new file mode 100644
> index 000000000000..b9564066e686
> --- /dev/null
> +++ b/Documentation/admin-guide/perf-security.rst
> @@ -0,0 +1,83 @@
> +.. perf_security:
> +
> +PCL/Perf security
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Overview
> +--------
> +
> +Usage of Performance Counters for Linux (PCL) [1] , [2]_ , [3]_ can impo=
se a+considerable risk of leaking sensitive data accessed by monitored proc=
esses.
> +The data leakage is possible both in scenarios of direct usage of PCL sy=
stem
> +call API [2]_ and over data files generated by Perf tool user mode utili=
ty
> +(Perf) [3]_ , [4]_ . The risk depends on the nature of data that PCL per=
formance
> +monitoring units (PMU) [2]_ collect and expose for performance analysis.
> +Having that said PCL/Perf performance monitoring is the subject for secu=
rity
> +access control management [5]_ .
> +
> +PCL/Perf access control
> +-----------------------
> +
> +For the purpose of performing security checks Linux implementation split=
s
> +processes into two categories [6]_ : a) privileged processes (whose effe=
ctive
> +user ID is 0, referred to as superuser or root), and b) unprivileged pro=
cesses
> +(whose effective UID is nonzero). Privileged processes bypass all kernel
> +security permission checks so PCL performance monitoring is fully availa=
ble to
> +privileged processes without access, scope and resource restrictions.
> +Unprivileged processes are subject to full security permission check bas=
ed
> +on the process's credentials [5]_ (usually: effective UID, effective GID=
,
> +and supplementary group list).
> +
> +PCL/Perf unprivileged users
> +---------------------------
> +
> +PCL/Perf scope and access control for unprivileged processes is governed=
 by
> +perf_event_paranoid [2]_ setting:
> +
> +-1:
>
> -       Impose no *scope* and *access* restrictions on using PCL performa=
nce
>
>
> -       monitoring. Per-user per-cpu perf_event_mlock_kb [2]_ locking lim=
it is
>
>
> -       ignored when allocating memory buffers for storing performance da=
ta.
>
>
> -       This is the least secure mode since allowed monitored *scope* is
>
>
> -       maximized and no PCL specific limits are imposed on *resources*
>
>
> -       allocated for performance monitoring.
>
>
> -
>
> +>=3D0:
>
> -       *scope* includes per-process and system wide performance monitori=
ng
>
>
> -       but excludes raw tracepoints and ftrace function tracepoints moni=
toring.
>
>
> -       CPU and system events happened when executing either in user or
>
>
> -       in kernel space can be monitored and captured for later analysis.
>
>
> -       Per-user per-cpu perf_event_mlock_kb locking limit is imposed but
>
>
> -       ignored for unprivileged processes with CAP_IPC_LOCK [6]_ capabil=
ity.
>
>
> -
>
> +>=3D1:
>
> -       *scope* includes per-process performance monitoring only and excl=
udes
>
>
> -       system wide performance monitoring. CPU and system events happene=
d when
>
>
> -       executing either in user or in kernel space can be monitored and
>
>
> -       captured for later analysis. Per-user per-cpu perf_event_mlock_kb
>
>
> -       locking limit is imposed but ignored for unprivileged processes w=
ith
>
>
> -       CAP_IPC_LOCK capability.
>
>
> -
>
> +>=3D2:
>
> -       *scope* includes per-process performance monitoring only. CPU and=
 system
>
>
> -       events happened when executing in user space only can be monitore=
d and
>
>
> -       captured for later analysis. Per-user per-cpu perf_event_mlock_kb
>
>
> -       locking limit is imposed but ignored for unprivileged processes w=
ith
>
>
> -       CAP_IPC_LOCK capability.
>
>
> -
>
> +>=3D3:
>
> -       Restrict *access* to PCL performance monitoring for unprivileged =
processes.
>
>
> -       This is the default on Debian and Android [7]_ , [8]_ .

AFAIK there is no support for '+>=3D3' in mainline kernel[1].
Debian and Android use out-of-tree patch for that[2].
Maybe someone should upstream it?

Jordan

[1] https://github.com/torvalds/linux/blob/master/kernel/events/core.c#L395
[2] https://salsa.debian.org/kernel-team/linux/blob/master/debian/patches/f=
eatures/all/security-perf-allow-further-restriction-of-perf_event_open.patc=
h
