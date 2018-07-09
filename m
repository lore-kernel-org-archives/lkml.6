Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C35C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B6F20875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B6F20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933573AbeGIQw2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:52:28 -0400
Received: from foss.arm.com ([217.140.101.70]:35154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933164AbeGIQw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:52:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D6667A9;
        Mon,  9 Jul 2018 09:52:27 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E31113F589;
        Mon,  9 Jul 2018 09:52:26 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 691B71AE3B14; Mon,  9 Jul 2018 17:53:08 +0100 (BST)
Date:   Mon, 9 Jul 2018 17:53:08 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        peter maydell <peter.maydell@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Support rseq on arm64
Message-ID: <20180709165307.GB4689@arm.com>
References: <1531145985-3747-1-git-send-email-will.deacon@arm.com>
 <1957291037.1983.1531152382750.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1957291037.1983.1531152382750.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 12:06:22PM -0400, Mathieu Desnoyers wrote:
> ----- On Jul 9, 2018, at 10:19 AM, Will Deacon will.deacon@arm.com wrote:
> 
> > Hello,
> > 
> > This is version two of the patches previously posted here:
> > 
> > http://lkml.kernel.org/r/1529949285-11013-1-git-send-email-will.deacon@arm.com
> > 
> > Changes since v1 include:
> > 
> >  * Move abort handler in-line to avoid possibility of it being
> >    out-of-range for conditional branch instructions
> > 
> > I've tested both native and compat (little-endian only) with the selftests
> > and they pass successfully on my Seattle box.
> 
> For the whole series:
> 
> Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks, Mathieu! Are you ok with me taking this via the arm64 tree for
4.19 once I have an Ack for the asm-generic change, or would you rather
this went via somewhere else?

Cheers,

Will
