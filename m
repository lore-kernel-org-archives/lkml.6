Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0ePmAqFWGVvZZAAAmS7hNA
	; Thu, 07 Jun 2018 16:01:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 11BB0608B8; Thu,  7 Jun 2018 16:01:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9399E601D2;
	Thu,  7 Jun 2018 16:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9399E601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934523AbeFGQBd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:01:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53926 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932903AbeFGQBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:01:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18FBE80D;
        Thu,  7 Jun 2018 09:01:31 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DF3003F59D;
        Thu,  7 Jun 2018 09:01:30 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 28B141AE53CF; Thu,  7 Jun 2018 17:02:03 +0100 (BST)
Date: Thu, 7 Jun 2018 17:02:03 +0100
From: Will Deacon <will.deacon@arm.com>
To: Hoan Tran <hoan.tran@amperecomputing.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Tai Nguyen <ttnguyen@amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Loc Ho <loc.ho@amperecomputing.com>
Subject: Re: [PATCH] perf: xgene: Fix IOB SLOW PMU parser error
Message-ID: <20180607160202.GA16435@arm.com>
References: <1528319214-19726-1-git-send-email-hoan.tran@amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528319214-19726-1-git-send-email-hoan.tran@amperecomputing.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 02:06:54PM -0700, Hoan Tran wrote:
> This patch fixes the below parser error of the IOB SLOW PMU.
> 
>         # perf stat -a -e iob-slow0/cycle-count/ sleep 1
>         evenf syntax error: 'iob-slow0/cycle-count/'
>                                  \___ parser error
> 
> It replaces the "-" character by "_" character inside the PMU name.
> 
> Signed-off-by: Hoan Tran <hoan.tran@amperecomputing.com>

Hmm, why did you only notice this now? :(

Anyway, whilst this could in theory break something, we did this for the CPU
PMUs in the past without issues so I'll pick this up.

Cheers,

Will
