Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D47C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2756C26D17
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2756C26D17
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbeFZPVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:21:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751683AbeFZPVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:21:14 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6370126D14;
        Tue, 26 Jun 2018 15:21:12 +0000 (UTC)
Date:   Tue, 26 Jun 2018 11:21:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Garnier <thgarnie@google.com>
Cc:     kernel-hardening@lists.openwall.com,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        James Hogan <jhogan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        nixiaoming <nixiaoming@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 21/27] x86/ftrace: Adapt function tracing for PIE
 support
Message-ID: <20180626112110.647ff8db@gandalf.local.home>
In-Reply-To: <20180625224014.134829-22-thgarnie@google.com>
References: <20180625224014.134829-1-thgarnie@google.com>
        <20180625224014.134829-22-thgarnie@google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018 15:39:09 -0700
Thomas Garnier <thgarnie@google.com> wrote:

> When using PIE with function tracing, the compiler generates a
> call through the GOT (call *__fentry__@GOTPCREL). This instruction
> takes 6-bytes instead of 5-bytes with a relative call.
> 
> If PIE is enabled, replace the 6th byte of the GOT call by a 1-byte nop
> so ftrace can handle the previous 5-bytes as before.
> 
> Position Independent Executable (PIE) support will allow to extend the
> KASLR randomization range 0xffffffff80000000.
> 
> Signed-off-by: Thomas Garnier <thgarnie@google.com>

Thanks for doing it this way.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

