Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9F167C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5855220839
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5855220839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934749AbeFKTzm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 15:55:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59744 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934474AbeFKTzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 15:55:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 810E2FFB57;
        Mon, 11 Jun 2018 19:55:40 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-118.ams2.redhat.com [10.36.116.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 386F42022DF5;
        Mon, 11 Jun 2018 19:55:39 +0000 (UTC)
Subject: Re: Restartable Sequences system call merged into Linux
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Carlos O'Donell <carlos@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>
References: <1084280721.10859.1528746558696.JavaMail.zimbra@efficios.com>
From:   Florian Weimer <fweimer@redhat.com>
Message-ID: <31fc101a-295b-067b-1a82-7e9e509fc92f@redhat.com>
Date:   Mon, 11 Jun 2018 21:55:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1084280721.10859.1528746558696.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 11 Jun 2018 19:55:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 11 Jun 2018 19:55:40 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'fweimer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2018 09:49 PM, Mathieu Desnoyers wrote:
> It should be noted that there can be only one rseq TLS area registered per thread,
> which can then be used by many libraries and by the executable, so this is a
> process-wide (per-thread) resource that we need to manage carefully.

Is it possible to resize the area after thread creation, perhaps even 
from other threads?

If there is only one contiguous area, this generally means there needs 
to be linker support, similar to what we have for initial-exec TLS today.

Thanks,
Florian
