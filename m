Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F171CC7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C462D20855
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfAUMJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:09:02 -0500
Received: from foss.arm.com ([217.140.101.70]:60706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727971AbfAUMJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:09:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4ECEC80D;
        Mon, 21 Jan 2019 04:09:02 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B0D53F5C1;
        Mon, 21 Jan 2019 04:09:00 -0800 (PST)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH v2 3/4] arm64: kprobes: Move exception_text check in
 blacklist
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <154753341900.31541.8135985235882849464.stgit@devbox>
 <154753350520.31541.11995657762766497151.stgit@devbox>
Message-ID: <47b290e9-0dcc-d9cd-3a7d-f6a4c4c3ca60@arm.com>
Date:   Mon, 21 Jan 2019 12:08:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <154753350520.31541.11995657762766497151.stgit@devbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/01/2019 06:25, Masami Hiramatsu wrote:
> Move exception/irqentry text address check in blacklist,
> since those are symbol based rejection.
> 
> If we prohibit probing on the symbols in exception_text,
> those should be blacklisted.

We need to blacklist this as its where do_debug_exception() lives, which kprobes
depends on for single-stepping.

Reviewed-by: James Morse <james.morse@arm.com>


Thanks!

James
