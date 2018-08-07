Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3F9C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA16221757
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="NT4l34oU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA16221757
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389411AbeHGQZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:25:33 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44732 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388929AbeHGQZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:25:33 -0400
Received: by mail-qt0-f196.google.com with SMTP id b15-v6so17911370qtp.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 07:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=Qf40DkpB7FbUi7eRbbKtJHTJxTSetq+Mq2Khb+wGZDg=;
        b=NT4l34oUJiJ1tpW5scNRk6dl6uhkg4q34iu6Q+kqOBTDxlZrrKZa+C8tAunfm2N/lH
         0+kyStvkVB8CNWeqDpzVSrUM1lgG/+zoze5StvqZFPrRSbLqA81yi/+t3ScT1KLV5pm2
         1GlyauUEN/m9wnh2Fna//tScJBuW51Aazd09qs6qlBvfrIjc/df+vpTR79gc/Ezh/Zpv
         4ryoV25nxzR6e0FKrd1T21AS84qLryygOOKdme2nCnmkNptPeFwx9Cqu2Z8VuyFO4GhV
         J4gIr5W+UEIOayLsM3dG/HEgmcXsZ3dh8AlKq3VaXbUGwtuYZEzz/5KateFjcXc3vglA
         5piw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=Qf40DkpB7FbUi7eRbbKtJHTJxTSetq+Mq2Khb+wGZDg=;
        b=VAM0SLeJdHK2P4ZmOJdtpnzM4Oi/5GsC1Wzx1RC44miFioV9iw51nUhB7y3bmd90y6
         UNDj1/Wjb1WF1VVxF5bc5rL0iDsAMmb+5nFDk/oGmSHgzqZ7Weckngb3Vb7KsGNimqbd
         enbfN5JRxq1jEMt1JZjRuJpW0HNTMaKdo8sGFb8WnQ+rAfnJQ8G6zk5U75oBAnaAfzdp
         Q9BpblINdPqn0K1nVQP2QuAjIkGiAGl/X7ixmUolStx/S+6CYAvYFIQGuHEX845++oK+
         J8e4F7g5gI1+E7vqCMq27N9C2hP/8aSc0ykvkIFWXZ2OK472DL/S/SW1H3ALC2VQ77mi
         an5Q==
X-Gm-Message-State: AOUpUlGeZ+FgjM6GcKRJFIk40ZoJgPjKSLQf4/B8bdeAid/xeC7F82iQ
        8uu/ZRYACbuhKRYolg449v4jN8iLWZYciQ==
X-Google-Smtp-Source: AAOMgpeEtBI411JHi/zoE9ANuuCCqTDLJhNQvrsDJF5hzctG91qYwhzB2LYmbmJRxN2dlNKNPIAFWg==
X-Received: by 2002:a0c:f3d1:: with SMTP id f17-v6mr16977222qvm.66.1533651062112;
        Tue, 07 Aug 2018 07:11:02 -0700 (PDT)
Received: from ?IPv6:2600:1003:b00f:774f:3cea:1449:c619:1a8? ([2600:1003:b00f:774f:3cea:1449:c619:1a8])
        by smtp.gmail.com with ESMTPSA id l10-v6sm680135qkk.49.2018.08.07.07.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 07:11:01 -0700 (PDT)
Date:   Tue, 07 Aug 2018 10:10:59 -0400
User-Agent: K-9 Mail for Android
In-Reply-To: <20180807094954.5137972d@gandalf.local.home>
References: <20180730222423.196630-1-joel@joelfernandes.org> <20180730222423.196630-4-joel@joelfernandes.org> <20180806155058.5ee875f4@gandalf.local.home> <CAJWu+oqvpev_EZC38_mi+UNRCxS8GqNVagHyGM4dUjruzKgwgQ@mail.gmail.com> <20180806214300.13e63523@gandalf.local.home> <CAJWu+oqZi2W9OYAn2xu17fdrBitQs4Gti4LxWmtx5B-EYtNMmA@mail.gmail.com> <20180807094954.5137972d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v12 3/3] tracing: Centralize preemptirq tracepoints and unify their usage
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Joel Fernandes <joel@joelfernandes.org>,
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
From:   Joel Fernandes <joelaf@google.com>
Message-ID: <446AE5F2-39E0-46B6-8E0B-207E003DBF20@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On August 7, 2018 9:49:54 AM EDT, Steven Rostedt <rostedt@goodmis=2Eorg> w=
rote:
>On Tue, 7 Aug 2018 06:33:35 -0700
>Joel Fernandes <joelaf@google=2Ecom> wrote:
>
>> Thanks, also one more thing I noticed in your patch,
>> lockdep_hardirqs_off needs to be called before all other probes but
>> you're calling it after=2E This is why I registered it with INT_MAX:
>>=20
>> register_trace_prio_irq_disable(lockdep_hardirqs_off, NULL, INT_MAX);
>>=20
>> Without it you may get annotation warnings=2E Thanks,
>
>Interesting=2E I was following the old way where we called the tracing
>code before calling the lockdep code (all hard coded and not from
>trace events)=2E Is this have something to do with calling the code from
>a tracepoint?
>
>Do you have an example that could trigger the warning?
>

I remember the warnings but can't remember now how I triggered them=2E I t=
hink I saw them with the irqsoff tracer or irq trace events running, with l=
ockdep turned on=2E

Also an irq disable probe that does a lockdep assert that irqs are disable=
d could trigger it?

thanks,

- Joel


>-- Steve

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
