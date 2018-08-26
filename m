Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E8DC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 08:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A072098B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 08:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqrJ4EEr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A072098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeHZLwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 07:52:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbeHZLwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 07:52:49 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45B332098B;
        Sun, 26 Aug 2018 08:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535271061;
        bh=bGOcOgy5SaIoQYq0A3YTWYxFDV1ahYnE7Ny/2JzwLlQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DqrJ4EEr3l72yeHMZaCxWeSbNm2xlWkf/k/sKihDN1zLCG4jULMvf1D+4O5Z6EdAf
         307mr+Bzrx2p5tPQovdSWf4NXqkGRaVANfmi/0tu9j7qRM8W7/CvlXE4nmPbeIbBHR
         VO25gGpYf1QhiK98rrS4AJj7uf/s2NuLJ0EPVIiU=
Date:   Sun, 26 Aug 2018 17:10:58 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warnings from the build of Linus' tree
Message-Id: <20180826171058.e07f99e6e03f7497e5a46ed3@kernel.org>
In-Reply-To: <20180824224211.2934d7c0@canb.auug.org.au>
References: <20180824133206.4218c2e5@canb.auug.org.au>
        <20180824172053.20fa197294f51496dcec5605@kernel.org>
        <20180824204756.e787765461975cd1e27502dc@kernel.org>
        <20180824224211.2934d7c0@canb.auug.org.au>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Fri, 24 Aug 2018 22:42:11 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Masami,
> 
> On Fri, 24 Aug 2018 20:47:56 +0900 Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > gcc-7.3.0 cross build ld shows below warnings.
> > 
> >   MODPOST vmlinux.o
> > /opt/gcc-7.3.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'.
> >   KSYM    .tmp_kallsyms1.o
> > /opt/gcc-7.3.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'.
> >   KSYM    .tmp_kallsyms2.o
> > /opt/gcc-7.3.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'.
> >   KSYM    .tmp_kallsyms3.o
> >   LD      vmlinux
> > /opt/gcc-7.3.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'.
> 
> I reported those a while ago when I started using the native Debian gcc
> on my Powerpc build box.
> 
> > But it seems another warning, and I couldn't see your warnings. Could you tell me your gcc version?
> 
> Currently, it is the Debian gcc 8.2.0, ld 2.31.1.

Hmm, unfortunately, I couldn't reproduce the ".data..LPBX1" error with
my gcc-8.1.0 + ld-2.30 distributed at https://cdn.kernel.org/pub/tools/crosstool/.
Could you also try to enable CONFIG_GCOV_PROFILE_ALL=y and build the kernel?
If it causes similar error, it should be caused by gcov support.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
