Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6031C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D45020835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D45020835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeHaCgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:36:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:38395 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbeHaCgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:36:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 15:32:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,309,1531810800"; 
   d="scan'208";a="229027978"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga004.jf.intel.com with ESMTP; 30 Aug 2018 15:32:06 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 21F9D301BFA; Thu, 30 Aug 2018 15:32:06 -0700 (PDT)
From:   Andi Kleen <ak@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus <torvalds@linux-foundation.org>,
        Linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: disabling -Wstringop-truncation
References: <20180831080714.4f94fba9@canb.auug.org.au>
Date:   Thu, 30 Aug 2018 15:32:06 -0700
In-Reply-To: <20180831080714.4f94fba9@canb.auug.org.au> (Stephen Rothwell's
        message of "Fri, 31 Aug 2018 08:07:14 +1000")
Message-ID: <87in3r32qh.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi Linus,
>
> I am now mainly using gcc v8.2 for my builds and -Wstringop-truncation
> causes so many warnings that I am sure to miss others, so I have
> applied the below to my fixes tree until the noise reduces.

I have the same problem.

However It's not clear if they're all false positives (I suspect not)

It would be better to move the warning to W=2 or so, and also needs
someone actually looking at them.

-Andi
