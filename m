Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0B3C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 09:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F29B2082D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 09:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzY6Oh4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F29B2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeKCSrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 14:47:17 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:40798 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbeKCSrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 14:47:16 -0400
Received: by mail-it1-f193.google.com with SMTP id e11so3085028itl.5;
        Sat, 03 Nov 2018 02:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ogAe2GhMtjEg1J9fVQAzZyWI7MqfiIctq7Ep5cw54aM=;
        b=EzY6Oh4tGyYQjrnUUXzCLvKXN3Q37jtoR08FFSB4y2lgWx20ddLIxoiXww4vA/7s8L
         KJHeV+4n8EzB76YAs+AJAo9yaaMq7gmRz8rgkIdJoMY1uL2soYQ5egC1H1lPSBy6mDt6
         RWJk/2tsSwuQkWYiCbzqpbQBoKwnxneVsPKtI7b+G5DjvlQsRf8JFABFHhkh3yZf3mht
         RgUk5lGwneMmQUM0JwBqj7565XST2gY9xj8zqNwqdrBd3w1b4jiilJQLQBaWq2bZtrWu
         vYKaWneISXN/QXgMgFQ5vjoP+vhrQZWIvSyv5bZ9F3qehP3BjU/7GQlJPVC5r1O6w2dt
         kHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ogAe2GhMtjEg1J9fVQAzZyWI7MqfiIctq7Ep5cw54aM=;
        b=kBRKGKDDT0pZd+4VB9Z6kcQ06ZZSTdnV2XNbsUtjXQlG0K2zL9zvwE7/rbmemfQ1vI
         mI7hYaoM43AidHFT/TLUzZqq1Fh5zy42oxgH4e3ghMGyz6oajq7VnCj6gRunkSue8gz8
         X6ZkEvq0y22gHZb5o6jthaN6kE98ZDU5KtKyaNsu9wtcmdsT4JNZvMm65FyKf054NlgZ
         jcp4UFkBbK7asAqcQjV4ft771AIwBE9Uj0KBdO//u4QwKgXBvBYLJLwuIey85oRb7BGo
         TW//yqFgGNTm8tRX+Jz61icABgbecco4aw53avsNMBbxrtmXJn5mg2dVglFdUZb0smHM
         lm5A==
X-Gm-Message-State: AGRZ1gLLLsPXreDnfQftdil28rqbqtsp7lqmuS0R0w5jR8gfYvU/c7nx
        Re2fzuV7ea+Hxisw6sGk1c4ddsgSKQ1d3YULoNU=
X-Google-Smtp-Source: AJdET5eouYaAXV/AOIGnaYztZjlNtFjRAwlxOzUNnVDGD31orEs064gyP8Z8q/xdYYm+7eoFUsy0gGSVXfSpQn3frLQ=
X-Received: by 2002:a24:6c14:: with SMTP id w20-v6mr344088itb.103.1541237793265;
 Sat, 03 Nov 2018 02:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <CADvbK_dNN34=5V3qtk3_vBzKNts55ACR4c-erPafgNuAQ-eRuw@mail.gmail.com>
 <20181102102616.GC5458@krava>
In-Reply-To: <20181102102616.GC5458@krava>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Sat, 3 Nov 2018 18:36:21 +0900
Message-ID: <CADvbK_cr_vhtyaid=xbECdNs+xCr4Oi8pJJc83jZa+XJOWAjJw@mail.gmail.com>
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

On Fri, Nov 2, 2018 at 7:26 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Nov 02, 2018 at 03:36:13PM +0900, Xin Long wrote:
> > On upstream kernel(4.19) or RHEL-8 kernel(4.18.0):
> >
> > # perf record -e 'skb:consume_skb' -ag
> > ^C[ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.612 MB perf.data (634 samples) ]
> >
> > # perf script
> > swapper     0 [009] 274370.117711: skb:consume_skb: skbaddr=0xffff962c591d5b00
> >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> >
> > kworker/9:1-eve   926 [009] 274370.117729: skb:consume_skb:
> > skbaddr=0xffff962c591d5b00
> >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> >
> > kworker/9:1-eve   926 [009] 274370.117732: skb:consume_skb:
> > skbaddr=0xffff962c591d4900
> >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> >
> > swapper     0 [009] 274370.145528: skb:consume_skb: skbaddr=0xffff962c591d4900
> >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> >
> > kworker/9:1-eve   926 [009] 274370.145545: skb:consume_skb:
> > skbaddr=0xffff962c591d4900
> >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> >
> > kworker/9:1-eve   926 [009] 274370.145547: skb:consume_skb:
> > skbaddr=0xffff962c591d5b00
> >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> >
> > swapper     0 [009] 274370.173443: skb:consume_skb: skbaddr=0xffff962c591d5b00
> >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
>
> I can see that on upstream as well, probably something within
> tracepoint entry code, because I have it working nicely when
> from kprobe, like:
>
> [root@ibm-x3650m4-02 perf]# ./perf probe 'consume_skb'
> [root@ibm-x3650m4-02 perf]# ./perf record -g -e probe:consume_skb* -aR ^C
>
Thanks Jiri,

My debugging script is using tracepoint with some filters which I
don't think probe can support.
Any one have fixes for this tracepoint issue?
