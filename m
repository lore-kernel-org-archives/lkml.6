Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7195DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBFE2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBFE2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbeKHB1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:27:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:59274 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727970AbeKHB1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:27:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7E9D3B151;
        Wed,  7 Nov 2018 15:56:47 +0000 (UTC)
Date:   Wed, 7 Nov 2018 16:56:44 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     gregkh <gregkh@linuxfoundation.org>,
        David Miller <davem@davemloft.net>
Cc:     mkubecek@suse.cz, Networking <netdev@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        rweikusat@mobileactivedefense.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>,
        junchi.chen@intel.com, Dmitry Vyukov <dvyukov@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: RFC: changed error code when binding unix socket twice
Message-ID: <20181107155644.GA29531@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20170630073448.GA9546@unicorn.suse.cz>
 <20180831111436.GA23780@dell5510>
 <CAK8P3a2yfZKMtE16DNCjZBOQ1R5=uXD16k43eJ=najJBh7H85Q@mail.gmail.com>
 <20181029163331.GA31059@dell5510>
 <CAK8P3a1q32spcF445Zhw-KMXG2VwFZuMw5C1sYFk3qLXz3HB5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1q32spcF445Zhw-KMXG2VwFZuMw5C1sYFk3qLXz3HB5w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> I forgot that 4.1 has ended a while ago. Greg also sometimes still takes patches
> for 3.18, so that might be a candidate aside from 3.18

Gregkh, David, does it make sense to you to merge commit 0fb44559ffd6 ("af_unix:
move unix_mknod() out of bindlock") to 3.18? If yes, please do so.


> > I guess we need to adjust LTP test to accept either return code as EOL longterm
> > branches probably will not take this patch.

> I'd argue that if we decide that EADDRINUSE is the intended return value,
> it would be appropriate for LTP to warn about kernels that never got the
> backport.

> The alternative would be to not backport the patch further, and then change LTP
> to no longer warn. Note that the bug that got fixed by the 0fb44559ffd6 patch
> is probably more important than the return code, so I would say
> we want the patch backported to anything that people still run anyway,
> especially if they are running LTP to make sure it works correctly.

>         Arnd

Kind regards,
Petr
