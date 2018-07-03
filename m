Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86B7C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9417923CEB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9417923CEB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752791AbeGCLnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:43:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43344 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752251AbeGCLnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:43:40 -0400
Received: from localhost (mobile-166-137-176-030.mycingular.net [166.137.176.30])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 60378DB6;
        Tue,  3 Jul 2018 11:42:50 +0000 (UTC)
Date:   Tue, 3 Jul 2018 13:42:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        akpm@linux-foundation.org, dave.hansen@intel.com,
        linux-mm@kvack.org, linuxram@us.ibm.com, mpe@ellerman.id.au,
        shakeelb@google.com, shuah@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.16 234/279] x86/pkeys/selftests: Adjust the self-test
 to fresh distros that export the pkeys ABI
Message-ID: <20180703114241.GA19730@kroah.com>
References: <20180618080608.851973560@linuxfoundation.org>
 <20180618080618.495174114@linuxfoundation.org>
 <fa4b973b-6037-eaef-3a63-09e8ca638527@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa4b973b-6037-eaef-3a63-09e8ca638527@suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 01:36:43PM +0200, Vlastimil Babka wrote:
> On 06/18/2018 10:13 AM, Greg Kroah-Hartman wrote:
> > 4.16-stable review patch.  If anyone has any objections, please let me know.
> 
> So I was wondering, why backport such a considerable number of
> *selftests* to stable, given the stable policy? Surely selftests don't
> affect the kernel itself breaking for users?

These came in as part of Sasha's "backport fixes" tool.  It can't hurt
to add selftest fixes/updates to stable kernels, as for some people,
they only run the selftests for the specific kernel they are building.
While others run selftests for the latest kernel on older kernels, both
of which are valid ways of testing.

thanks,

greg k-h
