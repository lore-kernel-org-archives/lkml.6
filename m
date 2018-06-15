Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4FBB9C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDED208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDED208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965828AbeFONXA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:23:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:42075 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933771AbeFONW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:22:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6BC0CAB08;
        Fri, 15 Jun 2018 13:22:58 +0000 (UTC)
Date:   Fri, 15 Jun 2018 15:22:56 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Thierry Escande <thierry.escande@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] lib/test_printf.c: accept "ptrval" as valid result
 for plain 'p' tests
Message-ID: <20180615132256.p4q6rbnkj7ngf2fu@pathway.suse.cz>
References: <20180613171840.29827-1-thierry.escande@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613171840.29827-1-thierry.escande@linaro.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-06-13 19:18:40, Thierry Escande wrote:
> If the test_printf module is loaded before the crng is initialized, the
> plain 'p' tests will fail because the printed address will not be hashed
> and the buffer will contain "(____ptrval____)" or "(ptrval)" instead
> (64-bit vs 32-bit).
> Since we cannot wait for the crng to be initialized for an undefined
> time, both plain 'p' tests now accept the strings "(____ptrval____)" or
> "(ptrval)" as a valid result and print a warning message.
> 
> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>

Revieved-by: Petr Mladek <pmladek@suse.com>

I have pushed this into printk.git, branch for-4.19

Best Regards,
Petr

PS: The split into plain_hash() and plain_format() is weird and even
confusing. They both just checks different halfs of the same output.

It would make sense to merge them. It would also remove the duplicated
code and warning. Anyone interested into sending a followup patch? ;-)
