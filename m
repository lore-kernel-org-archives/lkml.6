Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F43C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 23:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C0A2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 23:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbfASX5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 18:57:01 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46680 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729803AbfASX5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 18:57:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01F38A78;
        Sat, 19 Jan 2019 15:57:00 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D89B93F6A8;
        Sat, 19 Jan 2019 15:56:55 -0800 (PST)
Date:   Sat, 19 Jan 2019 23:56:52 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH 0/3] arm64: system call table generation for asm-generic
Message-ID: <20190119235650.GC26876@brain-police>
References: <1546530025-26014-1-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546530025-26014-1-git-send-email-firoz.khan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 09:10:22PM +0530, Firoz Khan wrote:
> This will be an automated scripts to provide easy support
> for add/modify/delete the system call entry by add in 
> respective *.tbl file.
> 
> System call table generation support for asm-generic is
> provide for arm64 architecture which will use the common
> scripts resides in scripts directory and use syscall.tbl
> syscall_arm32.tbl files as inputs. This implementation 
> will replace asm-generic/unistd.h.
> 
> This patch depends on:
>  https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/
>  https://lore.kernel.org/lkml/1546520681-24453-1-git-send-email-firoz.khan@linaro.org/

I'm having a hard time understanding what the benefit of this series is,
given that we only support EABI compat tasks. When adding a new compat
system call, you can't just blindly hook it up without checking whether it
needs a wrapper to deal with any type conversion etc, so really we're just
replacing one table with another as far as I can tell. What am I missing?

I also really don't think we should be generating the 32-bit UAPI headers
from the 64-bit compat system call support (if that's what you're trying to
do -- make headers_check fails with your patches applied). arch/arm/ is the
canonical place for the 32-bit UAPI, and we're just implementing that.

Will
