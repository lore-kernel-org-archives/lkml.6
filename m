Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34885C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBC520843
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Z64DtJgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDBC520843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389921AbeGKQv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:51:57 -0400
Received: from mail.efficios.com ([167.114.142.138]:52992 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733026AbeGKQv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:51:56 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 9524B22F788;
        Wed, 11 Jul 2018 12:46:45 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id V_EMeT7Bvk-8; Wed, 11 Jul 2018 12:46:45 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id E407522F785;
        Wed, 11 Jul 2018 12:46:44 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E407522F785
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1531327604;
        bh=nCwPnnAcAhfClvqmpDXcn/VKXNULZpqWVY8Yjrc3FGg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Z64DtJgRYUcyK8JwdyaKuMxZttIbPxgVa5NpqPMK4rPCGHs6qLOn6XryJwYYOognj
         JXCh92NgZgPLeIQEDK+3+6WR5Vbwbqmb+HsFz3NrEiWiJQPIk0kc8zfmlqg2CVxywv
         CWO0hwdc12fJo3O1SaJDNfnVi7F1GsPs5aQ343DYAUBmzeXM00AAQdQKM++xJFv5aX
         YF2a/E97C3p60vX8LJPBH+2Abfh+PtAdbcjuEQrrrCO3N1VyJ/VeZZhejbzolu8wF2
         zSzDTUjadfACONKkzG/BKRyloJLuEkTQAuxwx/XByACF8DDtD0ILTeUuxF0dF/ZrxG
         B3YnY2clJ9ziA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id mSzE3BOeyYPk; Wed, 11 Jul 2018 12:46:44 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id CD16B22F777;
        Wed, 11 Jul 2018 12:46:44 -0400 (EDT)
Date:   Wed, 11 Jul 2018 12:46:44 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Message-ID: <395785739.4156.1531327604723.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180711112659.366ec453@gandalf.local.home>
References: <20180628182149.226164-1-joel@joelfernandes.org> <20180628182149.226164-5-joel@joelfernandes.org> <20180711125647.GG2476@hirez.programming.kicks-ass.net> <20180711090649.68af40f9@gandalf.local.home> <20180711151751.GI2476@hirez.programming.kicks-ass.net> <20180711112659.366ec453@gandalf.local.home>
Subject: Re: [PATCH v9 4/7] tracepoint: Make rcuidle tracepoint callers use
 SRCU
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: tracepoint: Make rcuidle tracepoint callers use SRCU
Thread-Index: Pn16iE/TK2xmg6UpWnWUBWMppkV3EA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 11, 2018, at 11:26 AM, rostedt rostedt@goodmis.org wrote:

> On Wed, 11 Jul 2018 17:17:51 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> I just read the comment that goes with that function; the order doesn't
>> matter. All we want to ensure is that the unregistration is visible to
>> either sched or srcu tracepoint users.
> 
> Yeah, but I think it is still good to change the order. It doesn't
> hurt, and in my opinion makes the code a bit more robust.

I don't mind. It makes the code more regular. It does not change
anything wrt robustness here though.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
