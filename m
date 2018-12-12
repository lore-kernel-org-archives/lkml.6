Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF1CC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8042086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8042086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeLLKS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:18:27 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37372 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbeLLKS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:18:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CD2AA78;
        Wed, 12 Dec 2018 02:18:26 -0800 (PST)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B321E3F575;
        Wed, 12 Dec 2018 02:18:24 -0800 (PST)
Date:   Wed, 12 Dec 2018 10:18:19 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     mingo@kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, anders.roxell@linaro.org,
        boqun.feng@gmail.com, naresh.kamboju@linaro.org,
        peterz@infradead.org, will.deacon@arm.com
Subject: Re: [PATCH 0/2] locking/atomics: fix and improvement
Message-ID: <20181212101818.hwcumpeq575sxffu@salmiak>
References: <20181210175035.45096-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210175035.45096-1-mark.rutland@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 05:50:33PM +0000, Mark Rutland wrote:
> Hi Ingo,
> 
> I hope that these atomic scripting patches address your concerns with
> the atomics scripting infrastructure. These are based on the tip
> locking/core branch, leaving the headers checked-in.
> 
> The primary improvement is using a hash to detect when the headers have
> been erroneously modified, meaning check-atomics.sh takes ~0.15s, which
> I believe should be palatable.

As a heads-up, it looks like my prior attempt [1] is in today's linux-next
(next-20181212), via Andrew's tree.

Ingo, could you please let us know what you'd prefer? Are you happy to take
this version, and should Andrew drop that patch?

Thanks,
Mark.

[1] https://lkml.kernel.org/r/20181128085455.1164-1-mark.rutland@arm.com
