Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3821752-1518263242-2-10297835070085182298
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FSL_HELO_FAKE 3.2, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518263241; b=cYkhcFwJo0roAL/qqA4LHLuPwTwXROeZPwpQvJEKQQCA1ai
    X0NRTSJXKyLbstvi4sMLDQ4YLpxOHo6K/hSoNJrQQgUuqWIfykQ9x9jL3iqNtu4w
    108xSTXlkfAe+pCJTszLEch55cxNbj0ozWYvvTJZtX+4fmxjF+IizqsnbSYxIW8U
    vaD0KSuHtcRUU65fy4TY32cbLsHmDOp3zAG7AmLEuqkF7IRNJ/SkQEgaEIwkfiD9
    YrzRa+ddyovS4PDIxLbf+ASrGHM0AIwkaeCpInFW0vjX09X/4MiRz1e93ohZq6WW
    eAG8L+nCfT5slWqZTNXb89w2goTJMQPcVJ8tnVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518263241; bh=ZhT2+sOBLbMPhCuEhrWkEDlY6c
    s5LrD0PzQ8b8n7gRs=; b=lw13o53hcG+QGVB1rcRCW9u+LPumUTLXMJ+b4kr0fU
    aWbu4DwtGea3sGynqsC3dkPDI502/svqgdY2X1cmYLfgvsMyFUE/Wv7qVq1JpxZj
    n6wS+0kYGuTeR7KBFNeOEDaOspzNQXskmXAfS48/Sf11RLHdP21kYzi/i5+fWO0t
    mJCvDSBS1m/B/6CNXHW2v3JuKxi4EdtpUlZ9wSXqy1wWjHm2MV8omO9vgOocfOdD
    QMlhXThSmL35ztBRX1kIVhysRNCXYaly7c6rEtenvb04gl8F3DkkjO9HyxEsBSTU
    9N6SNUTOALFZauKuu9os1o2qQW9l6YLjPI8Bj7WvfQHw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cKTa5ulm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ppSxc3iB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cKTa5ulm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ppSxc3iB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750942AbeBJLrG (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 06:47:06 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37077 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeBJLrF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 10 Feb 2018 06:47:05 -0500
X-Google-Smtp-Source: AH8x225Jm15xVFXduiehEyB6QMBT/90OIub/hBC0RFgjtoS1p8fQB8qxHSHlMLfWV4bqoKuBSWEsOQ==
Date: Sat, 10 Feb 2018 12:47:00 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrew Hunter <ahh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Avi Kivity <avi@scylladb.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, David Sehr <sehr@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Maged Michael <maged.michael@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH for 4.16] membarrier-sync-core: Document architecture
 support
Message-ID: <20180210114700.mq2rg4lbjtzyx5pn@gmail.com>
References: <1518208256-22034-1-git-send-email-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518208256-22034-1-git-send-email-mathieu.desnoyers@efficios.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Ensure we gather architecture requirements about each architecture
> supporting the "sync_core" membarrier command in a single file under
> Documentation/features.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Andrea Parri <parri.andrea@gmail.com>
> Cc: Andrew Hunter <ahh@google.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Avi Kivity <avi@scylladb.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Dave Watson <davejwatson@fb.com>
> Cc: David Sehr <sehr@google.com>
> Cc: Greg Hackmann <ghackmann@google.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Maged Michael <maged.michael@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-api@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> ---
>  .../sched/membarrier-sync-core/arch-support.txt    | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/features/sched/membarrier-sync-core/arch-support.txt
> 
> diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> new file mode 100644
> index 0000000..2c815a7
> --- /dev/null
> +++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> @@ -0,0 +1,62 @@
> +#
> +# Feature name:          membarrier-sync-core
> +#         Kconfig:       ARCH_HAS_MEMBARRIER_SYNC_CORE
> +#         description:   arch supports core serializing membarrier

This breaks the output of the Documentation/features/list-arch.sh script.

Thanks,

	Ingo
