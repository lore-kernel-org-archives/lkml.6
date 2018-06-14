Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 961A7C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC16208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="KoL9/zLY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC16208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755313AbeFNNqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:46:50 -0400
Received: from mail.efficios.com ([167.114.142.138]:43130 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755258AbeFNNqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:46:48 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 62FCD22AE2C;
        Thu, 14 Jun 2018 09:46:47 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id BUQ_iGJI0Nk4; Thu, 14 Jun 2018 09:46:47 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id E5CB122AE25;
        Thu, 14 Jun 2018 09:46:46 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E5CB122AE25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1528984006;
        bh=4aoWfqEkSbFXdxxZZHOWEeAoIqu7xB3INTlRghiUKcw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=KoL9/zLYFeuE+k5Q20fiH7bWx31dPbl3ilgA7TE6kJlv7NuySdqFDbdw1eZZymxl6
         wLgSkneDoNCmsqkHBKklb7A0Rgjk/GhgP4oSgZakSmJxg+hzQW8Bhg2MOXCrBEdqQ2
         qZYjKGxj+ovZdabbNFbrvahpd4aWs9BJJgp48C9C74uEhwT3oomc8iJ00UJSlkSfVZ
         N9UR1CxcwSlBRSzw4UvkasOI6ezuLSF51XNj7a9ySugjWRSeDC8zwGw1NaAoGfc3/T
         Pd+h2jI0FYmhlcncwCs2t56wbwYvWbTzjxn9uEpbR/K9X7bBg3CZZD0KlNKXBtRlHR
         bq0raZDwyjbnQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id t33k4YoCORCO; Thu, 14 Jun 2018 09:46:46 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id CE8E422AE1B;
        Thu, 14 Jun 2018 09:46:46 -0400 (EDT)
Date:   Thu, 14 Jun 2018 09:46:46 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Pavel Machek <pavel@ucw.cz>, carlos <carlos@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>
Message-ID: <1399480624.13011.1528984006717.JavaMail.zimbra@efficios.com>
In-Reply-To: <1110f198-88c2-544d-6836-f901b8e90f98@redhat.com>
References: <1084280721.10859.1528746558696.JavaMail.zimbra@efficios.com> <305409897.10888.1528747473727.JavaMail.zimbra@efficios.com> <091061df-3482-8762-30e4-feaf3417be11@redhat.com> <417742741.11550.1528821084084.JavaMail.zimbra@efficios.com> <20180614122759.GB8798@amd> <894222691.12973.1528981314012.JavaMail.zimbra@efficios.com> <20180614132557.GA15201@amd> <1110f198-88c2-544d-6836-f901b8e90f98@redhat.com>
Subject: Re: Restartable Sequences system call merged into Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: Restartable Sequences system call merged into Linux
Thread-Index: nXCKTzw5HShYkUfF6imqBIpjKO491A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 14, 2018, at 9:32 AM, Florian Weimer fweimer@redhat.com wrote:

> On 06/14/2018 03:25 PM, Pavel Machek wrote:
> 
>> But the proposal wanted to add a syscall to thread creation, right?
>> And I believe that may be noticeable.
> 
> We already call set_robust_list, so we could just pass a larger area to
> that and the kernel could use it.  Then no additional system call would
> be needed in the common case (new kernel which recognizes the new area
> size).
> 
> But then we cannot use an initial-exec thread local variable for it
> (although the offset from the thread pointer will still be constant, of
> course).

I'm wondering whether we could turn the problem around: expose a new
system call allowing to register an array of pointers to per-thread data,
which would be used rather than set_robust_list when available. This way,
we could register both the robust list and rseq with a single system call,
e.g.:

enum linux_tls_area_type {
    LINUX_TLS_ROBUST_LIST,
    LINUX_TLS_RSEQ,
};

struct linux_tls_area_item {
    enum linux_tls_area_type type;
    void *p;
};

long sys_register_tls_areas(struct linux_tls_area_item *array, size_t nb)

This would allow registering various TLS data structures with a single
system call without hindering flexibility on the user-space side. For
instance, we could still use initial-exec and the __rseq_abi symbol for
rseq with this approach.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
