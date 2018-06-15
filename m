Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 06B0BC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 05:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93FF208DA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 05:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93FF208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755858AbeFOFJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 01:09:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53562 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755823AbeFOFJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 01:09:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 98CC3B4DF;
        Fri, 15 Jun 2018 05:09:44 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-61.ams2.redhat.com [10.36.116.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D0A12024CA1;
        Fri, 15 Jun 2018 05:09:42 +0000 (UTC)
Subject: Re: Restartable Sequences system call merged into Linux
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     carlos <carlos@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>
References: <1084280721.10859.1528746558696.JavaMail.zimbra@efficios.com>
 <31fc101a-295b-067b-1a82-7e9e509fc92f@redhat.com>
 <305409897.10888.1528747473727.JavaMail.zimbra@efficios.com>
 <091061df-3482-8762-30e4-feaf3417be11@redhat.com>
 <417742741.11550.1528821084084.JavaMail.zimbra@efficios.com>
 <20180614122759.GB8798@amd>
 <894222691.12973.1528981314012.JavaMail.zimbra@efficios.com>
From:   Florian Weimer <fweimer@redhat.com>
Message-ID: <b5c0a91b-b428-7807-0f16-97f15e632bdb@redhat.com>
Date:   Fri, 15 Jun 2018 07:09:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <894222691.12973.1528981314012.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 15 Jun 2018 05:09:44 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 15 Jun 2018 05:09:44 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'fweimer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/14/2018 03:01 PM, Mathieu Desnoyers wrote:
> Another alternative would be to somehow let glibc handle the registration,
> perhaps only doing it for applications expressing their interest for rseq.

That's not really possible.  We can't rely on the visibility of symbol 
bindings due to lazy binding and hidden visibility.  Registration of 
intent by other means will not work because if it is done from user 
code, some other library may have already launched a thread at this point.

(It's also a moot point if we want to use restartable sequences in glibc 
itself.)

Thanks,
Florian
