Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7275C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 06:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860E821857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 06:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860E821857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeHQJox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 05:44:53 -0400
Received: from verein.lst.de ([213.95.11.211]:33891 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbeHQJow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 05:44:52 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 530CE70573; Fri, 17 Aug 2018 08:43:44 +0200 (CEST)
Date:   Fri, 17 Aug 2018 08:43:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jiri Kosina <jikos@kernel.org>, x86@kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86: apm: mark proc_apm_show as __maybe_unused
Message-ID: <20180817064344.GC10811@lst.de>
References: <20180814091904.2186262-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814091904.2186262-1-arnd@arndb.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 11:18:45AM +0200, Arnd Bergmann wrote:
> A new build error appeared with CONFIG_PROC_FS disabled:
> 
> arch/x86/kernel/apm_32.c:1643:12: error: 'proc_apm_show' defined but not used [-Werror=unused-function]
> 
> This marks the function as __maybe_unused to let the compiler drop
> it silently.
> 
> Fixes: 3f3942aca6da ("proc: introduce proc_create_single{,_data}")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I have to admit I actually prefer ifdefs over magic __maybe_unused
annotations.  But otherwise this looks correct to me, same for the
other patch.
