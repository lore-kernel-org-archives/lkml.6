Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC731C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65E7206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfANS5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:57:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbfANS5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:57:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A786F653C2;
        Mon, 14 Jan 2019 18:57:11 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-20.ams2.redhat.com [10.36.116.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D0C15D9CA;
        Mon, 14 Jan 2019 18:57:05 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     carlos <carlos@redhat.com>, Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH glibc 1/4] glibc: Perform rseq(2) registration at nptl init and thread creation (v4)
References: <20181204192141.4684-1-mathieu.desnoyers@efficios.com>
        <87h8fkz6qx.fsf@oldenburg2.str.redhat.com>
        <1681283664.1380.1547152315426.JavaMail.zimbra@efficios.com>
        <1488546469.1564.1547169116539.JavaMail.zimbra@efficios.com>
Date:   Mon, 14 Jan 2019 19:57:03 +0100
In-Reply-To: <1488546469.1564.1547169116539.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Thu, 10 Jan 2019 20:11:56 -0500
        (EST)")
Message-ID: <87bm4j9if4.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 14 Jan 2019 18:57:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> Now that I think about it, it's important to move the rseq registration
> done at nptl init (in my current code) to some lower-level csu initialiation,
> so applications that happen _not_ to link against libpthread also get
> registered rseq for the main thread.

Yes.  In general, we want to avoid to force libraries which do not
create threads to link against libpthread, and try to provide interfaces
which are required for synchronization within libc.

Thanks,
Florian
