Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF60C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53AC2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53AC2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbeHaUO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:14:29 -0400
Received: from foss.arm.com ([217.140.101.70]:32836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbeHaUO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:14:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E1A518A;
        Fri, 31 Aug 2018 09:06:18 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4E2B23F5BD;
        Fri, 31 Aug 2018 09:06:18 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id F3A531AE30C7; Fri, 31 Aug 2018 17:06:30 +0100 (BST)
Date:   Fri, 31 Aug 2018 17:06:30 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH RFC LKMM 7/7] EXP tools/memory-model: Add .cfg and .cat
 files for s390
Message-ID: <20180831160630.GF30626@arm.com>
References: <20180829211018.GA19646@linux.vnet.ibm.com>
 <20180829211053.20531-7-paulmck@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829211053.20531-7-paulmck@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Wed, Aug 29, 2018 at 02:10:53PM -0700, Paul E. McKenney wrote:
> This commit adds s390.cat and s390.cfg files to allow users to check
> litmus tests for s390-specific code.  Note that this change only enables
> herd7 checking of C-language litmus tests.  Larger changes are required
> to enable the litmus7 and klitmus7 tools to check litmus tests on real
> hardare.
> 
> Suggested-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Suggested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> [ paulmck: Add fixes suggested by Alan Stern. ]
> ---
>  tools/memory-model/s390.cat | 18 ++++++++++++++++++
>  tools/memory-model/s390.cfg | 21 +++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 tools/memory-model/s390.cat
>  create mode 100644 tools/memory-model/s390.cfg

As I said before, I'd *much* prefer this to be part of the upstream
herdtools7 repository. It's not really anything to do with the Linux
kernel, so I don't think it belongs in the source tree.

Cheers,

Will
