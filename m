Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9227FC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E370A206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E370A206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeIEMwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:52:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52042 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbeIEMwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:52:18 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iEuxfcFKRXc6; Wed,  5 Sep 2018 10:22:55 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCBB900329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:b900:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4332E1EC0181;
        Wed,  5 Sep 2018 10:22:55 +0200 (CEST)
Date:   Wed, 5 Sep 2018 10:22:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     x86-ml <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, joel@joelfernandes.org
Subject: Re: 4.19-rc1: ./include/linux/rcupdate.h:631 rcu_read_lock() used
 illegally while idle!
Message-ID: <20180905082254.GA2237@zn.tnic>
References: <20180901173559.GC26871@zn.tnic>
 <20180901175442.GO4225@linux.vnet.ibm.com>
 <20180901184531.72ffb792@vmware.local.home>
 <20180902041639.GQ4225@linux.vnet.ibm.com>
 <20180904162611.6a120068@gandalf.local.home>
 <20180904205321.GQ4225@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180904205321.GQ4225@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 01:53:21PM -0700, Paul E. McKenney wrote:
> I must defer to Borislav on this one.  Assuming it has the desired
> effect, I am good with it.

It did survive a bunch of reboots (the WARN would fire after boot
finishes, normally) so I guess we can run with it and see how it works
out in the next couple of weeks.

Thanks guys!

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
