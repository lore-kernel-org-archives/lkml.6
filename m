Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 75345C004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 20:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29FA20839
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 20:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="O1C2p8oi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29FA20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933604AbeFKUEi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 16:04:38 -0400
Received: from mail.efficios.com ([167.114.142.138]:49166 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932139AbeFKUEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 16:04:35 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 84B3D1BCA1E;
        Mon, 11 Jun 2018 16:04:34 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id bj48XmxqSzyl; Mon, 11 Jun 2018 16:04:34 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 07DF11BCA1B;
        Mon, 11 Jun 2018 16:04:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 07DF11BCA1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1528747474;
        bh=ILK2XKVdRd6EjsYTUwT5pnIka5COcALqHFTsCN1LG6s=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=O1C2p8oiGDHzOkfczH2ELHLr4BoJHQM18czFhKNiyK7K2zuCZZqWxjjmJGFpo4EFd
         sHwgnM/IeHir0QHUHaSznzx15BWJGqogsxilyEpRBFiqxVa/UoTXMuAWFMUjYIHhBu
         n4VS5WE4WV0vzhXLlkvhE7ENk3yDqKlBKLKia4pAy0Kg7Cnvp/wKbz08+kQqPfnnIc
         wUq40fxzWIfnzRRfQArkwn82KI6t0ZQw6p1frmy9AqPgh4nlChsTRXKezihovE6Wg4
         IJks0Np3MoYIXHwRtzOmS/Z8rjMSV84ShT09pDimc3lQKI33YUQ+fG3rG5o+eNGM3b
         SCTjl3uTupu2w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id DuMJsdJj0jce; Mon, 11 Jun 2018 16:04:33 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id E47C31BCA12;
        Mon, 11 Jun 2018 16:04:33 -0400 (EDT)
Date:   Mon, 11 Jun 2018 16:04:33 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Carlos O'Donell <carlos@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>
Message-ID: <305409897.10888.1528747473727.JavaMail.zimbra@efficios.com>
In-Reply-To: <31fc101a-295b-067b-1a82-7e9e509fc92f@redhat.com>
References: <1084280721.10859.1528746558696.JavaMail.zimbra@efficios.com> <31fc101a-295b-067b-1a82-7e9e509fc92f@redhat.com>
Subject: Re: Restartable Sequences system call merged into Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: Restartable Sequences system call merged into Linux
Thread-Index: zhJcsiSjFFTw3hSbC6qfc+ihAyNZFQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 11, 2018, at 3:55 PM, Florian Weimer fweimer@redhat.com wrote:

> On 06/11/2018 09:49 PM, Mathieu Desnoyers wrote:
>> It should be noted that there can be only one rseq TLS area registered per
>> thread,
>> which can then be used by many libraries and by the executable, so this is a
>> process-wide (per-thread) resource that we need to manage carefully.
> 
> Is it possible to resize the area after thread creation, perhaps even
> from other threads?

I'm not sure why we would want to resize it. The per-thread area is fixed-size.
Its layout is here: include/uapi/linux/rseq.h: struct rseq

The ABI is designed so that all users (program and libraries) can interact
through this per-thread TLS area.

> 
> If there is only one contiguous area, this generally means there needs
> to be linker support, similar to what we have for initial-exec TLS today.

Not entirely sure what you imply by "one contiguous area". All we need is
a single fixed-size TLS area for each thread.

Thanks,

Mathieu

> 
> Thanks,
> Florian

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
