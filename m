Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FC8C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E511021BC9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E511021BC9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeHIJHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:07:06 -0400
Received: from exmail.andestech.com ([59.124.169.137]:60595 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbeHIJHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:07:06 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w796gcAc089772;
        Thu, 9 Aug 2018 14:42:38 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 9 Aug 2018
 14:43:35 +0800
Date:   Thu, 9 Aug 2018 14:43:36 +0800
From:   Alan Kao <alankao@andestech.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     <vincentc@andestech.com>, Andrew Waterman <andrew@sifive.com>,
        "Arnd Bergmann" <arnd@arndb.de>, <greentime@andestech.com>,
        <zong@andestech.com>, Darius Rad <darius@bluespec.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        <linux-kernel@vger.kernel.org>, Albert Ou <albert@sifive.com>,
        <linux-riscv@lists.infradead.org>, <nickhu@andestech.com>
Subject: Re: [PATCH v5 5/5] Auto-detect whether a FPU exists
Message-ID: <20180809064336.GA18746@andestech.com>
References: <1533796003-680-1-git-send-email-alankao@andestech.com>
 <1533796003-680-6-git-send-email-alankao@andestech.com>
 <20180809063124.GA26062@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180809063124.GA26062@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w796gcAc089772
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 11:31:24PM -0700, Christoph Hellwig wrote:
> >  extern unsigned long elf_hwcap;
> > +extern bool has_fpu;
> >  #endif
> 
> Doesn't this conflict with the !CONFIG_CPU stub in switch_to.h?

switch_to.h did include asm/hwcap.h, but the !CONFIG_FPU stub

+#define has_fpu false

always shows later than

+extern bool has fpu

so actually no warning during compilation.
> 
> It seems like we should only have this definition in one place to start
> with.

It does look a little bit weird.  Should I send a v6 for this?
> 
> Otherwise this looks fine to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

Thanks for all the feedback.

Alan
