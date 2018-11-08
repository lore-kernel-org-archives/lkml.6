Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F74AC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E487F20892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E487F20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbeKIH63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:58:29 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52966 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeKIH62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:58:28 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1C8A486C;
        Thu,  8 Nov 2018 22:20:53 +0000 (UTC)
Date:   Thu, 8 Nov 2018 14:20:52 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     bugzilla-daemon@bugzilla.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>, boyarsh@altlinux.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Bug 201637] New: hangup sinse  'x86/mm: Expand static page
 table for fixmap space' with CONFIG_RANDOMIZE_BASE enabled
Message-Id: <20181108142052.b8218ee02560864ef9e640b7@linux-foundation.org>
In-Reply-To: <bug-201637-27@https.bugzilla.kernel.org/>
References: <bug-201637-27@https.bugzilla.kernel.org/>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Thu, 08 Nov 2018 13:48:25 +0000 bugzilla-daemon@bugzilla.kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=201637
> 
>             Bug ID: 201637
>            Summary: hangup sinse  'x86/mm: Expand static page table for
>                     fixmap space' with CONFIG_RANDOMIZE_BASE enabled
>            Product: Memory Management
>            Version: 2.5
>     Kernel Version: 4.9.133
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: high
>           Priority: P1
>          Component: Other
>           Assignee: akpm@linux-foundation.org
>           Reporter: boyarsh@altlinux.org
>         Regression: No
> 
> I have early kernel hungup on x86_64 since 4.9.133 and i've finaly bisected it.
> 
> This commit is incompatible with CONFIG_RANDOMIZE_BASE enabled and cause
> immediate silent hangup during boot. 
> 
> commit 3a8304b7ad2e291777e8499e39390145d932a2fd
> Author: Feng Tang <feng.tang@intel.com>
> Date:   Thu Sep 20 10:58:28 2018 +0800
> 
>     x86/mm: Expand static page table for fixmap space
> 
>     commit 05ab1d8a4b36ee912b7087c6da127439ed0a903e upstream.
> 
>     We met a kernel panic when enabling earlycon, which is due to the fixmap
>     address of earlycon is not statically setup.
> 
> -- 
> You are receiving this mail because:
> You are the assignee for the bug.
