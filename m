Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8058CC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2564A20842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V5JletaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2564A20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389453AbeG0V1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:27:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54350 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389337AbeG0V1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gV03/3xm4T1M798xbuOH9h23mihuXLL/rUO3VfNp68U=; b=V5JletaWPNnEb/yU2k0b5n9YE3
        56TgE3M90ZMPftFY6XOp2qqrS+RX2CcZ5tTLTrmyB9E/M8J6Kh3MCfTU7tfzEbuySqUl4v+/PZG/U
        q6HZsnyWgw0k3StUuYHc/ml3SfZ3SMx++GwyhrPpy/kXJ2t21Ln499euX6HzirJubgND1CBXzASgv
        fe6y6fWNQCiwim7K/lgVEn2e+8OFR63NudQgIK+zqHdsdCZg+R/TQ39Mwf1ffq6iPiyvUOP9C8HJ1
        beNcM8gHH6+8XlcdC72kAEx/bpieUboIh612v1kdRJFU0r/Pp3dH7PUf8aXShrTSsDkVqo3PTA9eR
        rbb+eMRQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fj8yG-0005EH-70; Fri, 27 Jul 2018 20:04:16 +0000
Subject: Re: [PATCH 25/38] Make anon_inodes unconditional [ver #10]
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
 <153271285037.9458.9583418913241630415.stgit@warthog.procyon.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9aabbf78-5502-a087-4900-43c915148635@infradead.org>
Date:   Fri, 27 Jul 2018 13:04:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153271285037.9458.9583418913241630415.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/27/2018 10:34 AM, David Howells wrote:
> Make the anon_inodes facility unconditional so that it can be used by core
> VFS code.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/Makefile  |    2 +-
>  init/Kconfig |   10 ----------
>  2 files changed, 1 insertion(+), 11 deletions(-)

Hi David,

Please also drop "select ANON_INODES" from other places that select it:

./drivers/vfio/Kconfig:25:	select ANON_INODES
./drivers/infiniband/Kconfig:28:	select ANON_INODES
./drivers/base/Kconfig:177:	select ANON_INODES
./drivers/iio/Kconfig:7:	select ANON_INODES
./drivers/dma-buf/Kconfig:6:	select ANON_INODES
./drivers/gpio/Kconfig:15:	select ANON_INODES
./drivers/char/tpm/Kconfig:160:	select ANON_INODES
./arch/arm64/kvm/Kconfig:26:	select ANON_INODES
./arch/mips/kvm/Kconfig:23:	select ANON_INODES
./arch/powerpc/kvm/Kconfig:23:	select ANON_INODES
./arch/arm/kvm/Kconfig:25:	select ANON_INODES
./arch/s390/kvm/Kconfig:24:	select ANON_INODES
./arch/x86/kvm/Kconfig:30:	select ANON_INODES
./arch/x86/Kconfig:49:	select ANON_INODES
./fs/notify/inotify/Kconfig:3:	select ANON_INODES
./fs/notify/fanotify/Kconfig:4:	select ANON_INODES



> diff --git a/fs/Makefile b/fs/Makefile
> index 9a0b8003f069..ae681523b4b1 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -25,7 +25,7 @@ obj-$(CONFIG_PROC_FS) += proc_namespace.o
>  
>  obj-y				+= notify/
>  obj-$(CONFIG_EPOLL)		+= eventpoll.o
> -obj-$(CONFIG_ANON_INODES)	+= anon_inodes.o
> +obj-y				+= anon_inodes.o
>  obj-$(CONFIG_SIGNALFD)		+= signalfd.o
>  obj-$(CONFIG_TIMERFD)		+= timerfd.o
>  obj-$(CONFIG_EVENTFD)		+= eventfd.o
> diff --git a/init/Kconfig b/init/Kconfig
> index 5a52f07259a2..d8303f4af5d2 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1066,9 +1066,6 @@ config LD_DEAD_CODE_DATA_ELIMINATION
>  config SYSCTL
>  	bool
>  
> -config ANON_INODES
> -	bool
> -
>  config HAVE_UID16
>  	bool
>  
> @@ -1273,14 +1270,12 @@ config HAVE_FUTEX_CMPXCHG
>  config EPOLL
>  	bool "Enable eventpoll support" if EXPERT
>  	default y
> -	select ANON_INODES
>  	help
>  	  Disabling this option will cause the kernel to be built without
>  	  support for epoll family of system calls.
>  
>  config SIGNALFD
>  	bool "Enable signalfd() system call" if EXPERT
> -	select ANON_INODES
>  	default y
>  	help
>  	  Enable the signalfd() system call that allows to receive signals
> @@ -1290,7 +1285,6 @@ config SIGNALFD
>  
>  config TIMERFD
>  	bool "Enable timerfd() system call" if EXPERT
> -	select ANON_INODES
>  	default y
>  	help
>  	  Enable the timerfd() system call that allows to receive timer
> @@ -1300,7 +1294,6 @@ config TIMERFD
>  
>  config EVENTFD
>  	bool "Enable eventfd() system call" if EXPERT
> -	select ANON_INODES
>  	default y
>  	help
>  	  Enable the eventfd() system call that allows to receive both
> @@ -1414,7 +1407,6 @@ config KALLSYMS_BASE_RELATIVE
>  # syscall, maps, verifier
>  config BPF_SYSCALL
>  	bool "Enable bpf() system call"
> -	select ANON_INODES
>  	select BPF
>  	select IRQ_WORK
>  	default n
> @@ -1431,7 +1423,6 @@ config BPF_JIT_ALWAYS_ON
>  
>  config USERFAULTFD
>  	bool "Enable userfaultfd() system call"
> -	select ANON_INODES
>  	depends on MMU
>  	help
>  	  Enable the userfaultfd() system call that allows to intercept and
> @@ -1498,7 +1489,6 @@ config PERF_EVENTS
>  	bool "Kernel performance events and counters"
>  	default y if PROFILING
>  	depends on HAVE_PERF_EVENTS
> -	select ANON_INODES
>  	select IRQ_WORK
>  	select SRCU
>  	help
> 


-- 
~Randy
