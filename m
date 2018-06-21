Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5F1C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD09920837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fN0oeWFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD09920837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932829AbeFUIpS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:45:18 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44885 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753938AbeFUIpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:45:14 -0400
Received: by mail-wr0-f193.google.com with SMTP id p12-v6so632453wrn.11;
        Thu, 21 Jun 2018 01:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/KYnj0Xvj4hKFzqgPo3oY0bRWzEz3G3JjDnJDI1eieA=;
        b=fN0oeWFALztpopNgQxtt5/yAJwtAoPJxtEsw5apoExI8hRA89Djou7n9UScOyJBXcb
         uS0syUeFMVN9zyX7h35OetVFPlRQFoE4iFjr7rZ916mQWg51Na390ydRw8pdLBwPIXzZ
         doZW5T+8omg9s+XUezafNxVQf1uOu1mdh7Ms02Zeic23o/o6aiy5xP2IKEyzvHaLxS5M
         I7kn5qoroVJztMGtlTiTRIY5+1Vc76uRMBPIbCQahL8raTJNGOccOhGFUGhinEtlNijl
         w95oyzftxKOZTXkQjUYjsZ2xH2uRJnPmcnarngMqGqBflgg0/Gtx+QhxYhXvHtERa8Iz
         IYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/KYnj0Xvj4hKFzqgPo3oY0bRWzEz3G3JjDnJDI1eieA=;
        b=ccSIwWuTksVhICL6/AghNq4+hLpfnSwgWDFqFBomyUoktSffyxC0eeubBnoL+WFH+O
         iJbfh8pkpEmtkHLCnGKpc3tV7RnnZn4QIjq4wykksBdZW2Ab2F7DYpxzT0EyvtNyEGAp
         uB+qc5KyqxD0d/2TwH1LdESY8etWBOCaBN9PmE9GlVpKhlcP4hWzWGqKP+jegybn/3Nx
         GUOKh56O8poURWvln6zDyDqJxuzoUMEr1TZpPIiovi1yPws8Fqh7SySdLGC0R/RIr83u
         7e3BKZ0Bm55h26601tSbxjgMhWzJfTxGMD7LUMqWs3KtFJn2r0XDNewh9MzS3s1931C1
         kWyQ==
X-Gm-Message-State: APt69E0gtvVIeLLBru2sdcIP2wrNLEejqhmPrp/Jrx7ertb0PqaVMb8d
        SzDKwh2MydGn1qNrUYvEkn84GQ==
X-Google-Smtp-Source: ADUXVKLRps1I2OkOPbglRtr38BfGLBCI4FiyqlNcAbRRf3EFTcIRrsv53K64syVKbxZ4K1H9CmOH/A==
X-Received: by 2002:adf:f246:: with SMTP id b6-v6mr20206132wrp.235.1529570713189;
        Thu, 21 Jun 2018 01:45:13 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q1-v6sm990183wrm.96.2018.06.21.01.45.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 01:45:12 -0700 (PDT)
Date:   Thu, 21 Jun 2018 10:45:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     David Miller <davem@davemloft.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT] Networking
Message-ID: <20180621084510.GA22870@gmail.com>
References: <20180620.213540.214945910722071226.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620.213540.214945910722071226.davem@davemloft.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* David Miller <davem@davemloft.net> wrote:

> 1) Fix crash on bpf_prog_load() errors, from Daniel Borkmann.

> Daniel Borkmann (4):
>       Merge branch 'bpf-misc-fixes'
>       bpf: fix panic in prog load calls cleanup
>       bpf: reject any prog that failed read-only lock
>       bpf, xdp, i40e: fix i40e_build_skb skb reserve and truesize

JFYI, I'm still seeing this BPF build error upstream, on a 32-bit allyesconfig I'm 
getting:

  LD      vmlinux.o
  ld: i386:x86-64 architecture of input file `net/bpfilter/bpfilter_umh.o' is incompatible with i386 output
  Makefile:1010: recipe for target 'vmlinux' failed
  make: *** [vmlinux] Error 1

A similar looking build bug was reported by sfr three weeks ago:

> Subject: linux-next: build failure after merge of the net-next tree
>
> ...
>
> x86_64-linux-ld: unknown architecture of input file `net/bpfilter/bpfilter_umh.o' 
> is incompatible with i386:x86-64 output
>
> Caused by commit
>
>  d2ba09c17a06 ("net: add skeleton of bpfilter kernel module")
>
> In my builds, the host is PowerPC 64 LE ...
>
> I have reverted that commit along with
>
>  61a552eb487f ("bpfilter: fix build dependency")
>  13405468f49d ("bpfilter: don't pass O_CREAT when opening console for debug")
>
> for today.

Is there a fix I could try?

Thanks,

	Ingo
