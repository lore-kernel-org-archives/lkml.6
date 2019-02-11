Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8845DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61044222A4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbfBKP7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:59:03 -0500
Received: from foss.arm.com ([217.140.101.70]:52852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730194AbfBKP7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:59:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5A8A80D;
        Mon, 11 Feb 2019 07:59:00 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B9F93F589;
        Mon, 11 Feb 2019 07:58:59 -0800 (PST)
Date:   Mon, 11 Feb 2019 15:58:50 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>, marc.zyngier@arm.com
Subject: Re: [PATCH v2 4/4] arm64: kprobes: Use
 arch_populate_kprobe_blacklist()
Message-ID: <20190211155836.GA2692@fuggles.cambridge.arm.com>
References: <154753341900.31541.8135985235882849464.stgit@devbox>
 <154753353370.31541.14485875717131836689.stgit@devbox>
 <7f840cc8-4e62-e1d7-9035-4361204fc134@arm.com>
 <20190121222558.1ef0abc89a704597d6c3de7f@kernel.org>
 <20190208091519.GB6972@fuggles.cambridge.arm.com>
 <20190211221023.0bb43554647f99afce8dd060@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211221023.0bb43554647f99afce8dd060@kernel.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Marc]

On Mon, Feb 11, 2019 at 10:10:23PM +0900, Masami Hiramatsu wrote:
> On Fri, 8 Feb 2019 09:15:19 +0000
> Will Deacon <will.deacon@arm.com> wrote:
> > Did you send a new version of this series? I can't seem to spot it in my
> > inbox.
> 
> Ah, OK. I just waited for James' patch series,
> 
> https://patchwork.kernel.org/cover/10779489/
> 
> Are those merged? I'd like to move this series on that.

Patches 2-4 are in mainline:

f7daa9c8fd19 arm64: hibernate: Clean the __hyp_text to PoC after resume
8fac5cbdfe0f arm64: hyp-stub: Forbid kprobing of the hyp-stub
f2b3d8566d81 arm64: kprobe: Always blacklist the KVM world-switch code

Patch 1 is queued via kvm-arm (also for 5.0) but it doesn't seem to have
landed yet.

Will
