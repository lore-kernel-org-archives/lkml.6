Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D56C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038092133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDrvYVZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387781AbeLQPrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:47:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33380 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbeLQPrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:47:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so12803163wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mdJO9dRdcc14vQPI4d+nrweP3nkAcrM4cEjxwBUibnc=;
        b=eDrvYVZcaHZfvHG4Rkr95qlPNvV+SsRYQ+mXtCo5Ozsrm0FfXTY7MXHZ9fA5ubmRHG
         tE62cqbu7EWVferRgbu96b5LsjnNirIZwXiVy6Prmp72WIsQpGMlnL7AG8muDnx58FPO
         wHjJLjOViYdeMTFsuw5JLkNHCetxjqepvm4lkvpTrm5vCeQ3Wr7b5oBmXpSIdZsLSANp
         eifu6wRd/cc2kVSvgOFDSEm3PX+ZGATMru17qiYLCxhE06R8qFMldUc6sXzRdoOX6ThT
         9QuHHHjQrNXQmPCBQrFF0rHPfd8BgSvI0ji4NAZhik3ngTCCRU5mkDmKXw5TpCmdIXW+
         qVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mdJO9dRdcc14vQPI4d+nrweP3nkAcrM4cEjxwBUibnc=;
        b=FtKfw54jR+WqbUQm4gCcnf7EoGxyYtGVSwYPjCr86vE1CVBOINLftioha8gTq1XV2U
         vKhuGzGfOh6rDFT1JLaw8mcHQUzlr2BpQmOoub3VhZ4MIgxRfxDlM74uaNe1iTl+4kTR
         GOWRzXS+uYnyjTWm+AqvFZG2xVhgTvhROE5gL/VEzcnMhGsVLS8yH+q/AXPitH+u0oJ5
         DcDR57BJbG4TrOQ2rPHlnrBo5kDmpRNQc9HvHL5j6/U3G5EpMHOXqmPaJeeiwYvR9nTp
         wmekHbEA8RMQvr5vPXDtvULwE2KrWMSSRcmYS/mUMQBfe578K1vqlQn45qmbJNDpszIj
         SgEw==
X-Gm-Message-State: AA+aEWbq3yy+tRpiMyqwmdqnpFWOydMZvOIIbF6l7EWx8a5hd5Ano91X
        iRutArK8WB6xcEyR5KrG1Q==
X-Google-Smtp-Source: AFSGD/XvJeYgUOBAa8+3SJgvq3nopnu7FP1OHf3ZJ1oRRb3sIlXOquEaPWv+5lG7UV3vAx9+nAgJ8w==
X-Received: by 2002:a5d:528e:: with SMTP id c14mr10942910wrv.236.1545061635383;
        Mon, 17 Dec 2018 07:47:15 -0800 (PST)
Received: from localhost (host171-129-dynamic.1-87-r.retail.telecomitalia.it. [87.1.129.171])
        by smtp.gmail.com with ESMTPSA id y12sm10262661wmi.7.2018.12.17.07.47.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 07:47:14 -0800 (PST)
Date:   Mon, 17 Dec 2018 16:47:13 +0100
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Yonghong Song <yhs@fb.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] x86: kprobes: Show correct blaclkist in debugfs
Message-ID: <20181217154713.GA1308@Dell>
References: <154503482486.26176.6224515860220847638.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154503482486.26176.6224515860220847638.stgit@devbox>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 05:20:25PM +0900, Masami Hiramatsu wrote:
> This is v2 series for showing correct kprobe blacklist in
> debugfs.
> 
> v1 is here:
> 
>  https://lkml.org/lkml/2018/12/7/517
> 
> I splitted the RFC v1 patch into x86 and generic parts,
> also added a patch to remove unneeded arch-specific
> blacklist check function (because those have been added
> to the generic blacklist.)
> 
> If this style is good, I will make another series for the
> archs which have own arch_within_kprobe_blacklist(), and
> eventually replace that with arch_populate_kprobe_blacklist()
> so that user can get the correct kprobe blacklist in debugfs.
> 
> Thank you,

Looks good to me. Thanks!

Tested-by: Andrea Righi <righi.andrea@gmail.com>

Side question: there are certain symbols in arch/x86/xen that should be
blacklisted explicitly, because they're non-attachable.

More exactly, all functions defined in arch/x86/xen/spinlock.c,
arch/x86/xen/time.c and arch/x86/xen/irq.c.

The reason is that these files are compiled without -pg to allow the
usage of ftrace within a Xen domain apparently (from
arch/x86/xen/Makefile):

 ifdef CONFIG_FUNCTION_TRACER
 # Do not profile debug and lowlevel utilities
 CFLAGS_REMOVE_spinlock.o = -pg
 CFLAGS_REMOVE_time.o = -pg
 CFLAGS_REMOVE_irq.o = -pg
 endif

Do you see a nice and clean way to blacklist all these functions
(something like arch_populate_kprobe_blacklist()), or should we just
flag all of them explicitly with NOKPROBE_SYMBOL()?

Thanks,
-Andrea
