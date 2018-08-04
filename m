Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370E1C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BF92174D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8BF92174D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbeHDXfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 19:35:42 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:38796 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728883AbeHDXfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 19:35:42 -0400
Received: from sf (trofi-1-pt.tunnel.tserv1.lon2.ipv6.he.net [IPv6:2001:470:1f1c:a0f::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: slyfox)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 80E47335CC8;
        Sat,  4 Aug 2018 21:33:39 +0000 (UTC)
Date:   Sat, 4 Aug 2018 22:33:36 +0100
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2, simpler] ia64: fix ptrace(PTRACE_GETREGS) (unbreaks
 strace, gdb)
Message-ID: <20180804223336.5f29778e@sf>
In-Reply-To: <20180309231555.16925-1-slyfox@gentoo.org>
References: <20180211185134.76ccfd45@sf>
        <20180309231555.16925-1-slyfox@gentoo.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Mar 2018 23:15:55 +0000
Sergei Trofimovich <slyfox@gentoo.org> wrote:

I tried to explain in more detail breakage mechanics
of unwinder and gcc code generation quirks at:
    https://trofi.github.io/posts/210-ptrace-and-accidental-boot-fix-on-ia64.html
Hopefully it gives better intuition of code change
caused by both proposed patches.

I personally think v1 patch is slightly more robust.

-- 

  Sergei
