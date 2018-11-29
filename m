Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1896CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE05D20989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE05D20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbeK3Dir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:38:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49971 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729216AbeK3Dii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:38:38 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 51694356F6;
        Thu, 29 Nov 2018 16:32:42 +0000 (UTC)
Received: from jlaw-desktop.bos.csb (wlan-196-240.bos.redhat.com [10.16.196.240])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3AF4E601B9;
        Thu, 29 Nov 2018 16:32:40 +0000 (UTC)
Subject: Re: [for-next][PATCH 00/18] function_graph: Add separate depth
 counter to prevent trace corruption
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20181122002801.501220343@goodmis.org>
 <20181128203931.ym2rkya7a6agzzy3@redhat.com>
 <20181128160021.09acd1af@gandalf.local.home>
 <20181128222936.74da7f54@vmware.local.home>
 <20181128232430.425f8b12@vmware.local.home>
 <044db9c0-a937-252f-b9e6-e4060bca3b0d@redhat.com>
 <20181129111708.766f35d6@gandalf.local.home>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <11879829-4827-8eda-7cb8-ddcfdc404120@redhat.com>
Date:   Thu, 29 Nov 2018 11:32:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181129111708.766f35d6@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 29 Nov 2018 16:32:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/2018 11:17 AM, Steven Rostedt wrote:
> On Thu, 29 Nov 2018 10:08:55 -0500
> Joe Lawrence <joe.lawrence@redhat.com> wrote:
> 
>> With the "take 2" patch, I only see smp_irq_work_interrupt() graph when
>> the graph_function is in progress..  for example:
> 
> In other words it works :-)
> 
> Can I get a Tested-by from you?
> 

Yup, thanks for fixing!

Tested-by: Joe Lawrence <joe.lawrence@redhat.com>

-- Joe
