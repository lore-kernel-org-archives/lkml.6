Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734F3C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2551B204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoS3DJTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2551B204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbeKEPib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 10:38:31 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33636 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbeKEPib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 10:38:31 -0500
Received: by mail-io1-f65.google.com with SMTP id f12-v6so5704903iog.0;
        Sun, 04 Nov 2018 22:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P/jDjy0UtpWSwAWtdxk+XrP8OplZWXU+810I+ZGWzig=;
        b=LoS3DJTE1N/kJswtLRQXNLIPDu+rNZxNRoG1YrxIYk8xzxCIZgeHubKrlDoxuHAE4g
         WqJD/6n8BhNbKqIBXTAADV5ZcY9qpfCIerMvoHpaHVDtdwhQ9rcbHGHAOWjMohn3pcjj
         x0jvo82fhXxTOaw3tRX5iLiFGj6D6LoaFvNjSI/eBruEXIrqU3Kn5uOkhfqMGKGjU60w
         r/STRyAbeS9fABejCEFSfJwXmRxbJmjAL9BiZ2bsPPYj5DYZAn0RpahgaXmDDjrs9TaV
         hLWzxQXSjJ/vy0dPAEaLH/mbzlWt2I9nqe8wMRBB5KsHRpcEsK4tEaZlQ2Axwnd9SH2K
         Sujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/jDjy0UtpWSwAWtdxk+XrP8OplZWXU+810I+ZGWzig=;
        b=YrF4d/Dep9Z0IYJ+am/skDcrVUh3gxfj7LPzk+IFpZLgoT2TIeQ7v0ijj/xBOvSRfX
         qFSf9W6FXKWIQCGb08qTuASZXmU3sDNYEnX2GganqaMUkDRCBhlWeuCX0p1lQggym25h
         61YiugRb0unRUFXxSyW63sOzlDLuISXUw/J/Qi9wzIeBnLKLK+N2Qu3I8R8a0Xy7Y928
         yku5Z4DSvPq+59kVmLY3yznzEhBFCWtJRx7diejBqnwt4ddWasMW8mt0BrTlOGE+/L4N
         R0PDD/luv/Y5Xf3IkIRUEKcqpy5aaNk1pPURzSdQ+XgmujcTCy+U62bOj1nwXHevQ+PV
         a/oQ==
X-Gm-Message-State: AGRZ1gKxCRHpjm5iZMf0e8TzNN6GmBQ39OdvSoTu+27jhK/nILlIdYy3
        RXaKNf+F1B0d58x9V46VOnuT9CFVli4b/XEher0=
X-Google-Smtp-Source: AJdET5fhuVvW/r5Uphx4Ig9aQjxcOOUbhhPFDoiosZi5ebh7uA4eErAC5U2Luy6Rves4E8wWXzLMNfikiwcxN3l/aEI=
X-Received: by 2002:a6b:3a46:: with SMTP id h67-v6mr13322145ioa.161.1541398827354;
 Sun, 04 Nov 2018 22:20:27 -0800 (PST)
MIME-Version: 1.0
References: <CADvbK_dNN34=5V3qtk3_vBzKNts55ACR4c-erPafgNuAQ-eRuw@mail.gmail.com>
 <20181102102616.GC5458@krava> <CADvbK_cr_vhtyaid=xbECdNs+xCr4Oi8pJJc83jZa+XJOWAjJw@mail.gmail.com>
 <20181104191754.GB18517@krava>
In-Reply-To: <20181104191754.GB18517@krava>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Mon, 5 Nov 2018 15:20:15 +0900
Message-ID: <CADvbK_cgp7S-8Q-6GArwViCDBhCoB9LcZvJaGM6QFAg9qNOeHw@mail.gmail.com>
Subject: Re: perf script doesn't dump a normal call trace
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 4:18 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Sat, Nov 03, 2018 at 06:36:21PM +0900, Xin Long wrote:
> > On Fri, Nov 2, 2018 at 7:26 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Fri, Nov 02, 2018 at 03:36:13PM +0900, Xin Long wrote:
> > > > On upstream kernel(4.19) or RHEL-8 kernel(4.18.0):
> > > >
> > > > # perf record -e 'skb:consume_skb' -ag
> > > > ^C[ perf record: Woken up 1 times to write data ]
> > > > [ perf record: Captured and wrote 0.612 MB perf.data (634 samples) ]
> > > >
> > > > # perf script
> > > > swapper     0 [009] 274370.117711: skb:consume_skb: skbaddr=0xffff962c591d5b00
> > > >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> > > >
> > > > kworker/9:1-eve   926 [009] 274370.117729: skb:consume_skb:
> > > > skbaddr=0xffff962c591d5b00
> > > >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> > > >
> > > > kworker/9:1-eve   926 [009] 274370.117732: skb:consume_skb:
> > > > skbaddr=0xffff962c591d4900
> > > >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> > > >
> > > > swapper     0 [009] 274370.145528: skb:consume_skb: skbaddr=0xffff962c591d4900
> > > >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> > > >
> > > > kworker/9:1-eve   926 [009] 274370.145545: skb:consume_skb:
> > > > skbaddr=0xffff962c591d4900
> > > >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> > > >
> > > > kworker/9:1-eve   926 [009] 274370.145547: skb:consume_skb:
> > > > skbaddr=0xffff962c591d5b00
> > > >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> > > >
> > > > swapper     0 [009] 274370.173443: skb:consume_skb: skbaddr=0xffff962c591d5b00
> > > >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> > >
> > > I can see that on upstream as well, probably something within
> > > tracepoint entry code, because I have it working nicely when
> > > from kprobe, like:
> > >
> > > [root@ibm-x3650m4-02 perf]# ./perf probe 'consume_skb'
> > > [root@ibm-x3650m4-02 perf]# ./perf record -g -e probe:consume_skb* -aR ^C
> > >
> > Thanks Jiri,
> >
> > My debugging script is using tracepoint with some filters which I
> > don't think probe can support.
> > Any one have fixes for this tracepoint issue?
>
> trying to bisect that.. looks like orc code issue,
> it works for me when you switch to fp unwind:
>   CONFIG_UNWINDER_FRAME_POINTER
>

That's a good workaround, thanks.

Another problem is when I'm using perf built manually from upstream kernel tree,
I couldn't see the function's names.
# perf --version
perf version 4.19.g26f1de

# perf report -T
# To display the perf.data header info, please use
--header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 97  of event 'probe:consume_skb'
# Event count (approx.): 97
#
# Children      Self  Trace output
# ........  ........  ..................
#
   100.00%   100.00%  (ffffffff86f090f0)
            |
            |--93.81%--0xffffffff868000e6
            |          0xffffffff8684ed7f
            |          0xffffffff868e97ad
            |          0xffffffff868e953a
            |          0xffffffff87087623
            |          0xffffffff8682a06f
            |          0xffffffff870872ad
            |          |
            |          |--89.69%--0xffffffff8720098f
            |          |          0xffffffff87201b69
            |          |          0xffffffff868b9c2e


The below is with rhel7's perf
# perf --version
perf version 3.10.0-957.el7.x86_64.debug
# perf report -T
# To display the perf.data header info, please use
--header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 97  of event 'probe:consume_skb'
# Event count (approx.): 97
#
# Children      Self  Trace output
# ........  ........  ..................
#
   100.00%   100.00%  (ffffffff86f090f0)
            |
            |--93.81%--0x2000e6
            |          start_secondary
            |          cpu_startup_entry
            |          do_idle
            |          default_idle_call
            |          arch_cpu_idle
            |          default_idle
            |          |
            |          |--89.69%--ret_from_intr
            |          |          do_IRQ
            |          |          irq_exit
