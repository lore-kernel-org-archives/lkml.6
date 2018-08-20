Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA4CC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268F52170E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268F52170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbeHTS7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 14:59:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:37379 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbeHTS7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 14:59:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2018 08:42:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,265,1531810800"; 
   d="scan'208";a="256443708"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga006.fm.intel.com with ESMTP; 20 Aug 2018 08:42:54 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id CF9A8300B48; Mon, 20 Aug 2018 08:42:54 -0700 (PDT)
Date:   Mon, 20 Aug 2018 08:42:54 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>, stable@vger.kernel.org,
        Adrian Schroeter <adrian@suse.de>,
        Dominique Leuenberger <dimstar@suse.de>
Subject: Re: [PATCH] x86/speculation/l1tf: fix overflow on l1tf_pfn_limit()
 on 32bit
Message-ID: <20180820154254.GM12066@tassilo.jf.intel.com>
References: <20180820095835.5298-1-vbabka@suse.cz>
 <20180820142027.GL12066@tassilo.jf.intel.com>
 <20180820142636.GM29735@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820142636.GM29735@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > BTW our much worse problems right now are crash reports on several 
> > stable kernels, especially with large pages 
> 
> Do you have any reference?


https://lkml.org/lkml/2018/8/17/546
https://bugzilla.redhat.com/show_bug.cgi?id=1618792       (this is 4.17, not 4.18)

(might be different problems. I wasn't able to reproduce the 4.17 one
so far)


-Andi
