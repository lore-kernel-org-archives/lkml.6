Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F76C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D403C2174A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D403C2174A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbeHIJ4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:56:43 -0400
Received: from exmail.andestech.com ([59.124.169.137]:48406 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbeHIJ4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:56:43 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w797W4CE096864;
        Thu, 9 Aug 2018 15:32:04 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 9 Aug 2018
 15:32:59 +0800
Date:   Thu, 9 Aug 2018 15:33:00 +0800
From:   Alan Kao <alankao@andestech.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     <vincentc@andestech.com>, Andrew Waterman <andrew@sifive.com>,
        "Arnd Bergmann" <arnd@arndb.de>, <greentime@andestech.com>,
        <zong@andestech.com>, Darius Rad <darius@bluespec.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        <linux-kernel@vger.kernel.org>, Albert Ou <albert@sifive.com>,
        <linux-riscv@lists.infradead.org>, <nickhu@andestech.com>
Subject: Re: [PATCH v5 5/5] Auto-detect whether a FPU exists
Message-ID: <20180809073300.GB18746@andestech.com>
References: <1533796003-680-1-git-send-email-alankao@andestech.com>
 <1533796003-680-6-git-send-email-alankao@andestech.com>
 <20180809063124.GA26062@infradead.org>
 <20180809064336.GA18746@andestech.com>
 <20180809070258.GA11082@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180809070258.GA11082@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w797W4CE096864
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 12:02:58AM -0700, Christoph Hellwig wrote:
> On Thu, Aug 09, 2018 at 02:43:36PM +0800, Alan Kao wrote:
> > It does look a little bit weird.  Should I send a v6 for this?
> 
> Yes, please resend the series or just this patch.
> 
> I think the hswap.h definition should go away and we should just
> keep the switch_to.h one, even if that means including the header
> in another C file.
> 

It turns out that only cpufeature.c and switch_to.h are affected
by hwcap.h.  As switch_to.h already had extern has_fpu declaration,
the one in hwcap.h is redundant and can be removed safely.

I will resend just this patch, and mark it as v6.
