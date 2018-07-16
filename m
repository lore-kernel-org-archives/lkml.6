Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDB2ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B1F208FA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="ULQiRHPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B1F208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbeGPQZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:25:53 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:36080 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeGPQZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:25:53 -0400
Received: by mail-ua0-f193.google.com with SMTP id y8-v6so25149275uan.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 08:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=GGcyW91RbtN4Ej1f/5DA+XtZqAGeGthSBLhmWj9C1eM=;
        b=ULQiRHPsi2TLrxWooV71ltsbjlxbEMwGAsPY5j1VS96Bz/0RmwGasClpVNT0385ZQl
         F9oY8Ts6bWqnKQKhhuelTDBDuRE3DTzpHtkk99uYr9hHlSU0gQkd3McPBpID3gsrHTXy
         F1UrxVPaWK2VjwPGZtGs6sw9Tel+XT9owauzxi7AljvSLnJ8pV5ArC+gnniMR4sxXYqD
         2P0/8nloX0O+fkuLXMLEXEl7KKQnx3fU+FitXUMv6qh5UusUqVPnRcu47CXkV7rcLdLt
         kMqzTeVjIrmGV72Cv02GcFZgEQuapTUK6vcybpcW/uHX0ej4IrJwEzZwAPA/nGGM1hdw
         KFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=GGcyW91RbtN4Ej1f/5DA+XtZqAGeGthSBLhmWj9C1eM=;
        b=cOQ+p6XcCZDCJT8gIdmRuPeB0dP6/9J5LNT4Lrs6m0ae+iSnKSA4LJNsBPcS+V3x7K
         IvWjfOl6/6lUjQqPeq+u/X2ipKY3y7Lk4PA3EjJwsHv7xzOs0Rha7vCaNtQe9dPTo31k
         qed56C4btDlurC7yKwC9d3ULyMcm3d2oVs/GERoPA19niteh0Z6GYPG0sI991sxxCGvc
         j9Hs6jMdab571E1Q+dtiu51GeisynfuCIuZFkFwAnCOXFStDMOH8pk9xzRZffrCRwmCC
         qpcF6vS9WXWZ2Xi+x7De1r0ZTHBwR5VgZ8NyMRdV1Ntf5AHOLpEf9MdlHZWN0v9jQ82U
         PYQA==
X-Gm-Message-State: AOUpUlFfuumfKCuhCaqk1FS4dZOn9c34Qh88+bZlr3mMIq7mippjsSYe
        DTkmmOkf4mPuRau8ENoNEp1pSQ==
X-Google-Smtp-Source: AAOMgpfSUU5KvzWVmSrz+ycKRQHRiBobZEJ8WKGWfxxHEi1Dfve7y3SuAz935AvzFNxd0aBkT+2MBA==
X-Received: by 2002:ab0:4902:: with SMTP id z2-v6mr11683437uac.14.1531756670183;
        Mon, 16 Jul 2018 08:57:50 -0700 (PDT)
Received: from limbo.local ([181.197.188.71])
        by smtp.gmail.com with ESMTPSA id d71-v6sm5878307vka.47.2018.07.16.08.57.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 08:57:49 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
To:     hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux@endlessm.com,
        linux-block@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Mike Galbraith <efault@gmx.de>,
        Oliver Yang <yangoliver@me.com>,
        Shakeel Butt <shakeelb@google.com>,
        xxx xxx <x.qendo@gmail.com>,
        Taras Kondratiuk <takondra@cisco.com>,
        Daniel Walker <danielwa@cisco.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Ruslan Ruslichenko <rruslich@cisco.com>, kernel-team@fb.com
Subject: Re: [PATCH 0/10] psi: pressure stall information for CPU, memory, and IO v2
Date:   Mon, 16 Jul 2018 10:57:45 -0500
Message-Id: <20180716155745.10368-1-drake@endlessm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180712172942.10094-1-hannes@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

Thanks for your work on psi! 

We have also been investigating the "thrashing problem" on our Endless
desktop OS. We have seen that systems can easily get into a state where the
UI becomes unresponsive to input, and the mouse cursor becomes extremely
slow or stuck when the system is running out of memory. We are working with
a full GNOME desktop environment on systems with only 2GB RAM, and
sometimes no real swap (although zram-swap helps mitigate the problem to
some extent).

My analysis so far indicates that when the system is low on memory and hits
this condition, the system is spending much of the time under
__alloc_pages_direct_reclaim. "perf trace -F" shows many many page faults
in executable code while this is going on. I believe the kernel is
swapping out executable code in order to satisfy memory allocation
requests, but then that swapped-out code is needed a moment later so it
gets swapped in again via the page fault handler, and all this activity
severely starves the system from being able to respond to user input.

I appreciate the kernel's attempt to keep processes alive, but in the
desktop case we see that the system rarely recovers from this situation,
so you have to hard shutdown. In this case we view it as desirable that
the OOM killer would step in (it is not doing so because direct reclaim
is not actually failing).

I had recently touched upon the cpuset mempressure counter, which
looked promising, but in practice I found that it was not a useful enough
representation of thrashing. It measures the rate at which
__perform_reclaim() is called, but I have observed that as the system gets
deeper and deeper into thrashing, __perform_reclaim() is actually called
at an increasingly slower rate, because each invocation ends up taking
more and more time (after 2 minutes of thrashing it can take close to 1s).

Instead of rate of function call it seems necessary to measure the amount
of work done by that codepath, and that's what you are doing with psi.

I tried psi on a 2GB RAM system with no swap (also no zram-swap) and
was pleased with the results combined with this sample userspace code:

https://gist.github.com/dsd/a8988bf0b81a6163475988120fe8d9cd

It invokes the OOM killer when memory full_avg10 is >=10%, i.e. it kills
if all tasks were blocked on memory management for at least 1s in a 10s
period.

Upon initial tests it is working very well. The system recovers quickly
from thrashing after the daemon steps in and kills a process. I have yet
to see any kills being made prematurely. It would be great to see this
upstream soon.

I also support your ideas to have the kernel offer mechanisms to handle
this directly in future; it would be nice not to have the requirement of
delegating this task to userspace, plus there may be a possibility that
userspace is starved so much that it cannot step in to handle this.

The only question I have is about the format of the data in /proc. The
memory file returns two lines and several values on each line. This
requires a bit more parsing than what I have become accustomed to in recent
years of the "one value per file" approach that seems prevalent in sysfs.
Would it make sense to instead have a single value read from (say)
/proc/pressure/memory/full_avg10 ?

Thanks
Daniel

