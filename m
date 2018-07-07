Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D395C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 22:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3E920863
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 22:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBCdxods"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3E920863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754383AbeGGWtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 18:49:41 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40444 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754246AbeGGWtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 18:49:39 -0400
Received: by mail-pf0-f193.google.com with SMTP id z24-v6so11067936pfe.7;
        Sat, 07 Jul 2018 15:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=I8khLog6qmSQ1GBBNsX361OxzoiQrzLLq+bg0U8Iyh8=;
        b=mBCdxodsb7qbGpsuEUYPtWeIEhW/2KqMpuz6AI9gg0kXSINJK5AMC0wfmlVokq/N38
         tMY8k8jU0ItFOuaWrgCfxwfv7cHw0TVhGwvn8WOUQWrXXW/hnQt+d0bAH7dBmKVTmIRu
         lrZYE4Un7Uub9P6sQF1bYTNaZg/QSS4a0eW9V1l0aSsAA3i1YBR1y9Gauau5y9iEHFS5
         LuzYT6vsMtAVLthVIxWmw1rR9TxhAWEhWamDL8ybQN300zcO3AgWOXYd8KcwWEZfS3DC
         0tnzZACKNXO1kT/Jpxl0JRCZpKy5zCs7iKL4G4kKK+MDAlgcGBRUSBcX3k22ubbuZWlv
         B3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=I8khLog6qmSQ1GBBNsX361OxzoiQrzLLq+bg0U8Iyh8=;
        b=stqu6maSlU7f243u5ydfhgoA1IFq7ajRQTC9UxV9PDh5y+mjeD3Xt0ZwkDif3fHJws
         22wIlU/JXcRgs1Rh4REL2s3vjcDPKk6TKJCEIsxnvliGVIvPRtYwVfrbrv3nghiAjsBq
         vHc8SojPVbE2KsOWKOMv5XgMfF6q87c0F7s5IUDJIreplgJL8l9HvfjSQ2bRBefTIo+u
         sVtL+sMiONDmeNCgHUBX1wdUYK5XJ97bScLF9fjSq++YbVhYEO5iEcxz55EJ5r3PdC8S
         FPD60tY8pY/XKxNG/5fPXpAJgWQxtYZ4bkkCOqZaVccphOkjubFVthYFYtwRtc9ScDKD
         xWWw==
X-Gm-Message-State: APt69E3BYYJjHladD6zN7DQNgKjiVWbbByllVKNWDUd7LHUtOcEKwoOq
        Mm4tI5qZwOdEzcBihxW+RfM=
X-Google-Smtp-Source: AAOMgpfCyRGn/PDlZ9fWYtWnvxDq9VKKldpWoXYCl0nGnEreOweAo6MAUVdunaZZRAHbpTMuoqdDtA==
X-Received: by 2002:a63:6243:: with SMTP id w64-v6mr9259863pgb.179.1531003778964;
        Sat, 07 Jul 2018 15:49:38 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:fbf2])
        by smtp.gmail.com with ESMTPSA id j27-v6sm33686447pfe.48.2018.07.07.15.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 15:49:38 -0700 (PDT)
Date:   Sat, 7 Jul 2018 15:49:36 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Constantine Shulyupin <const@MakeLinux.com>
Cc:     jakub.kicinski@netronome.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <netdev@vger.kernel.org>
Subject: Re: [PATCH v1] bpf: fix compilation of samples/bpf/
Message-ID: <20180707224934.bvhaepbgt7gww5p6@ast-mbp.dhcp.thefacebook.com>
References: <20180707145240.23544-1-const@MakeLinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180707145240.23544-1-const@MakeLinux.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 05:52:03PM +0300, Constantine Shulyupin wrote:
> Example of errors:
> 
> samples/bpf/test_lru_dist.c:39:8: error: redefinition of ‘struct list_head’
>  struct list_head {
>         ^~~~~~~~~
> In file included from samples/bpf/test_lru_dist.c:9:0:
> ./tools/include/linux/types.h:69:8: note: originally defined here
> 
> In file included from samples/bpf/sock_example.c:27:0:
> /usr/include/linux/ip.h:102:2: error: unknown type name ‘__sum16’
> 
> samples/bpf/bpf_load.c: In function ‘load_and_attach’:
> samples/bpf/bpf_load.c:90:15: error: ‘BPF_PROG_TYPE_RAW_TRACEPOINT’ undeclared (first use in this function); did you mean ‘BPF_PROG_TYPE_TRACEPOINT’?
> 
> samples/bpf/xdpsock_user.c:10:10: fatal error: linux/if_xdp.h: No such file or directory
> 
> samples/bpf/task_fd_query_user.c: In function ‘test_debug_fs_uprobe’:
> samples/bpf/task_fd_query_user.c:270:31: error: ‘BPF_FD_TYPE_URETPROBE’ undeclared (first use in this function); did you mean ‘BPF_PROG_TYPE_KPROBE’?
> 
> samples/bpf/parse_varlen.c:111:8: error: redefinition of 'vlan_hdr'
> struct vlan_hdr {
>        ^
> ./include/linux/if_vlan.h:38:8: note: previous definition is here
> 
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
> ---
>  Makefile                           | 1 +
>  samples/bpf/Makefile               | 5 +++--
>  samples/bpf/xdp_sample_pkts_user.c | 3 +++
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index d15ac32afbaf..824006258319 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -441,6 +441,7 @@ export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
>  export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_LDFLAGS_MODULE
>  export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
>  export KBUILD_ARFLAGS
> +export USERINCLUDE
>  
>  # When compiling out-of-tree modules, put MODVERDIR in the module
>  # tree rather than in the kernel tree. The kernel tree might
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 9ea2f7b64869..991273c81459 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -167,11 +167,12 @@ always += xdp_fwd_kern.o
>  always += task_fd_query_kern.o
>  always += xdp_sample_pkts_kern.o
>  
> -HOSTCFLAGS += -I$(objtree)/usr/include
> +HOSTCFLAGS += -D__EXPORTED_HEADERS__ $(USERINCLUDE)

the goal of the patch is to avoid doing 'make headers_install' to build samples/bpf/ ?
The idea of the patch is interesting, but it breaks the build for me:
/w/net-next make samples/bpf/
make[1]: Entering directory `/data/users/ast/net-next/bld_x64'
  Using .. as source for kernel
  GEN     ./Makefile
  CALL    ../scripts/checksyscalls.sh
  DESCEND  objtool
  HOSTCC  samples/bpf/test_lru_dist
In file included from ../include/uapi/linux/posix_types.h:5:0,
                 from ../include/uapi/linux/types.h:14,
                 from ../samples/bpf/test_lru_dist.c:9:
../include/uapi/linux/stddef.h:2:34: fatal error: linux/compiler_types.h: No such file or directory
 #include <linux/compiler_types.h>
                                  ^
compilation terminated.

while I don't see any build issues without this patch in bpf tree.
Strangely current bpf-next tree fails with:
parse_varlen.c:111:8: error: redefinition of 'vlan_hdr'
but none of the other errors you mentioned.

