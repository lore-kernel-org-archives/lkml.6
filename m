Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24153C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 10:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B4724E7F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 10:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ixb6/wkc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B4724E7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752093AbeFXKC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 06:02:56 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34301 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbeFXKCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 06:02:54 -0400
Received: by mail-wr0-f195.google.com with SMTP id a12-v6so10690016wro.1;
        Sun, 24 Jun 2018 03:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=STbLXZFkP8lvq39nh91MgIemr4Whwu32he1l/Wdipdo=;
        b=Ixb6/wkclVKxXDKUlohVBxxj3IjPN/OYhFd/HkdSZJlRTR64PKhGZyAdWGIXPiDQQY
         TQQGIl47k+d5WBJrcudMXYiw7w5+xXGAJx2/Rn7FE8TwYEMeBrkU+D+ZZMljnfqcybdS
         wFQtQ7xXAl/xzcM5FbuJC8DKSf57kCGP6eGMMDwM4gZkoiXFV/GcAZJ5UOpm7Cl82bpI
         6pJHtkMIX9rSOiiks1FQd9UN3CSO2CPpHSOVlL5Ogw9Zqyq5MIhBMo22C3Lb2fdi88mo
         p+TNo1MWnVOl16+Ttc/auTtSRxuHMhRMVDFVbzq/T4wRGzkdSWKTKbygu3JLztZ7qr4t
         PxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=STbLXZFkP8lvq39nh91MgIemr4Whwu32he1l/Wdipdo=;
        b=OOeAYmVU6xdD1x9MfnioTMLDbGq1E0pPT4vUnWA+9rE5gnvXho5MIDd4wcLghTa39g
         nPKxUV60p47LUGzfczeK1oGf6DPielhkZCMpSPZ8n3Pw5CyHhvDF8F3Esa2sxr6ykKvX
         AXmHPmcXgjT2qGodGA/ln2kLJN1QBLJWPO4CvQ9ZJojAdufCRApt5hf7AHUX8lBV5+BE
         6He8VfyZJNi3UmRyuxcZryz0GB/40G2u5ksia6kjmmIvo/s/wrLeXIeVxKQY+pyNTDng
         7CY97zBUW+iBxt7zHfTqhGJJyHK+mzhVrL/4HuG5ULTX26ekQjyXt4ZzQZEaqMP4rQN0
         cGQw==
X-Gm-Message-State: APt69E14P8zp3OBxB5htBtd1fT1J4BtRLCF7MHmirM/QVvCQP7F5u98G
        PyLxkpIVb3niANd9LcWfDUk=
X-Google-Smtp-Source: AAOMgpccyIAdg8fawzVL34ACtR9f8rexQmWHn4MXpq/tTiQamGKeheyv+y7T3XaMdygfUd/dFH2RBg==
X-Received: by 2002:adf:87f1:: with SMTP id c46-v6mr6619747wrc.246.1529834572919;
        Sun, 24 Jun 2018 03:02:52 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u15-v6sm9436329wma.37.2018.06.24.03.02.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Jun 2018 03:02:52 -0700 (PDT)
Date:   Sun, 24 Jun 2018 12:02:50 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     David Miller <davem@davemloft.net>
Cc:     tglx@linutronix.de,
        syzbot+a4eb8c7766952a1ca872@syzkaller.appspotmail.com,
        ast@kernel.org, daniel@iogearbox.net, hpa@zytor.com,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        mingo@redhat.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, x86@kernel.org,
        yoshfuji@linux-ipv6.org, peterz@infradead.org
Subject: Re: BUG: unable to handle kernel paging request in
 bpf_int_jit_compile
Message-ID: <20180624100249.GA9493@gmail.com>
References: <000000000000d48c8e056f5b6c67@google.com>
 <alpine.DEB.2.21.1806240849150.8650@nanos.tec.linutronix.de>
 <20180624.161411.1560796210597132716.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180624.161411.1560796210597132716.davem@davemloft.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* David Miller <davem@davemloft.net> wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Sun, 24 Jun 2018 09:09:09 +0200 (CEST)
> 
> > I'm really tempted to make the BPF config switch depend on BROKEN. 
> 
> This really isn't necessary Thomas.
> 
> Whoever wrote the code didn't understand that set ro can legitimately
> fail.

No, that's *NOT* the only thing that happened, according to the Git history.

The first use of set_memory_ro() in include/linux/filter.h was added by
this commit almost four years ago:

  # 2014/09
  60a3b2253c41 ("net: bpf: make eBPF interpreter images read-only")

... and yes, that commit didn't anticipate the (in hindsight) obvious property of 
a function that changes global kernel mappings that if it is used after bootup 
without locking it 'may fail'. So that commit slipping through is 'shit happens' 
and I don't think we ever complained about such things slipping through.

But what happened after that is not so good:

A bit over two years later a crash was found:

    Eric and Willem reported that they recently saw random crashes when
    JIT was in use and bisected this to 74451e66d516 ("bpf: make jited
    programs visible in traces"). Issue was that the consolidation part
    added bpf_jit_binary_unlock_ro() that would unlock previously made
    read-only memory back to read-write.

... but instead of fixing it for real, it was only tinkered with:

  # 2017//02
  9d876e79df6a ("bpf: fix unlocking of jited image when module ronx not set")

... but the problems persisted:

    Improve bpf_{prog,jit_binary}_{un,}lock_ro() by throwing a
    one-time warning in case of an error when the image couldn't
    be set read-only, and also mark struct bpf_prog as locked when
    bpf_prog_lock_ro() was called.

... so the warnings Thomas complained about here were then added a month later:

  # 2017/03
  65869a47f348 ("bpf: improve read-only handling")

It 'improved' nothing of the sort, and the warnings and 'debug code' shows that
the author was aware that these functions could actually fail. To quote the fine
code, introduced a year ago:

                WARN_ON_ONCE(set_memory_rw((unsigned long)fp, fp->pages));
                /* In case set_memory_rw() fails, we want to be the first
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                 * to crash here instead of some random place later on.
                 */
                fp->locked = 0;

... and then, this month, it was tweaked *YET ANOTHER TIME*:

    bpf: reject any prog that failed read-only lock

    We currently lock any JITed image as read-only via bpf_jit_binary_lock_ro()
    as well as the BPF image as read-only through bpf_prog_lock_ro(). In
    the case any of these would fail we throw a WARN_ON_ONCE() in order to
    yell loudly to the log. Perhaps, to some extend, this may be comparable
    to an allocation where __GFP_NOWARN is explicitly not set.

  # 2018/06
  9facc336876f ("bpf: reject any prog that failed read-only lock")

The tone of uncertainty of the changelog, combined with the unfixed typo in it, 
suggests that this commit too was just waved through to upstream without any real 
review and without much design thinking behind it.

And yes, this was still not the right fix, as the fuzzer crash reported in this 
thread outlines - we'll probably need a 5th commit?

> So let's correct that instead of flaming a feature.

So accusing Thomas of 'flaming a feature' is a really unfair attack in light of 
all the details above.

Thanks,

	Ingo
