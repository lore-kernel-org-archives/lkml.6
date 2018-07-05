Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461D8C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0385523FED
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0385523FED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754005AbeGESe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:34:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54936 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753838AbeGESe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:34:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5E4C7A9;
        Thu,  5 Jul 2018 11:34:56 -0700 (PDT)
Received: from armageddon.cambridge.arm.com (armageddon.cambridge.arm.com [10.1.206.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C81723F2EA;
        Thu,  5 Jul 2018 11:34:55 -0700 (PDT)
Date:   Thu, 5 Jul 2018 19:34:53 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Nikunj Kela (nkela)" <nkela@cisco.com>
Cc:     "xe-kernel@external.cisco.com" <xe-kernel@external.cisco.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] arm64: add support for 43bit physical address
Message-ID: <20180705183452.vaaxjsrus6lnqyzt@armageddon.cambridge.arm.com>
References: <20180702210451.16057-2-nkela@cisco.com>
 <20180703145626.g6pb4bgnrle2p2qf@armageddon.cambridge.arm.com>
 <1530642932209.57184@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530642932209.57184@cisco.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 06:35:32PM +0000, Nikunj Kela (nkela) wrote:
> We are trying to reduce the memory allocation needed for kdump kernel.
> We want to reserve less than 32M for kdump kernel if possible. We are
> able to get ~14M saving by the proposed change.

Have you tried disabling SPARSEMEM and using FLATMEM for this case? With
32M you wouldn't need more than a section anyway. It needs some tweaking
of the arm64 Kconfig and probably fail to build.

-- 
Catalin
