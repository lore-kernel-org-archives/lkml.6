Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9679FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3277A20852
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m56sYwc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3277A20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbeH2GgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 02:36:20 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:39034 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbeH2GgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 02:36:20 -0400
Received: by mail-wm0-f43.google.com with SMTP id q8-v6so3874675wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 19:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1MOZKkp8sEvE3jKtZceTwz590aLTY3KwyDcWfq80qsQ=;
        b=m56sYwc00VGWoqoKtloM9Qblzc09q95OKqg7WWs8QmAiJZ+SWYL1qq88UKDcPwAWTN
         tg70TGCV8uJ3IAWY/4PU4OboQVw2ikD7JLWVjP9qI3HBO9l5k6qQlL/Ag/bMEgCi3LDO
         0nkGgIGmKoBa30FDIuC3aJJB5nONC9hAeK60hsqEuH98o0zVQMnW7EgbMcddP4eff0OW
         wJSFps3cbpO0067Vy4sIwNKQfLQWz6Fmh9vhkDVh9EL1vPdRI5pGYk3C4Xx0WBNSwrPr
         gv2SVenArVHYxbyd2zQfvCtLI39lwhKPkd0dwhJRdz3/6x3oVYKKA9qsagayMxDIRkfT
         FfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1MOZKkp8sEvE3jKtZceTwz590aLTY3KwyDcWfq80qsQ=;
        b=QXMGufHjGCQcsjhMIuIQjGcNNnFSXYa5+Lb4Vm+xVPXsxqMirVi11Y90bWmJUu5X8w
         WnfFMpdR89W3rPDstmJuEi+hdFTAQuVL4F1j6v+7+p4rDdmSTNFgq2SI4VH31leR6I7Y
         ZgzxCdAOL/Vs0TT6sNSBT8UTEikyzJPWhyuzv7OfSZDfi92HmjdpqWjdyA6Vhc5Li6sX
         gy+rkQFon0VOfqHsQJzlczk8ZSI77G/uYIXIpIpmukh43t6d7wyKXX5gwKJyVPlaXTrv
         bCC7dIKeMupDS/KgOy9ALGxLT5KAXxTc4jkBvDzG6psqIw8ohxaci/XCN8lKciEehFYU
         Hz9A==
X-Gm-Message-State: APzg51D5rKRkdcVUxA/iU3Yx52DP7rV7pw3LYXug5wGtdS/26ZXeRG2/
        LVAj1IlZcniaZB9yPhW6ftB0JSLnEWGQdYxMAwIlYeFVmZw=
X-Google-Smtp-Source: ANB0VdbxZZgAR1qa3UHZNp6B2Dgwwg9mMfZX0PyoW1sOPoEfGUxIVZqvRhCOdZQj7uTiZy5q6SXZwMRHnWfj1SkQrbU=
X-Received: by 2002:a1c:7e13:: with SMTP id z19-v6mr2690560wmc.156.1535510503531;
 Tue, 28 Aug 2018 19:41:43 -0700 (PDT)
MIME-Version: 1.0
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 28 Aug 2018 19:41:31 -0700
Message-ID: <CABPqkBTT-PSP+0sZc-EyrRtOLfLVPxOxwuDpxhGhGZLOe5L0CA@mail.gmail.com>
Subject: [RFC] perf script: callchain handling is not useful
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am doing the following simple collection with callchain and load profiling:

$ perf record -g -d -e cpu/event=0xd0,umask=0x81/pp  my_test_program

But when I type:
$ perf script -F ip,addr
ffff9d4821346878
        ffffffff9d58df25
        ffffffff9d58e054
        ffffffff9d5965bb
        ffffffff9d640650
        ffffffff9d697d06
        ffffffff9d63ec60
        ffffffff9d640322
        ffffffff9d64070c
        ffffffff9d455a60
                  7030c7

ffff9d4638ba84a0
        ffffffff9d5df447
        ffffffff9d5eaf4a
        ffffffff9d63e165
        ffffffff9d63e439
        ffffffff9d697d98
        ffffffff9d63ec60
        ffffffff9d640322
        ffffffff9d64070c
        ffffffff9d455a60
                  7030c7
I also see the callchain and it is not clear which is the IP. Further
more parsing becomes more difficult because of multiple lines per
sample. I understand that multiline is likely because of
symbolization. But if I don't want symbolization, it should be
possible to print all in one line.

The current output is not very useful. You expect perf script to give
you one line per sample and only what you want. Callchain != IP.

I think the following should happen:
  - do not print callchain when asked for the IP. Create a callchain filter.
  - print callchain on the same line, much like what is done for brstack

It is not clear to me why callchain and ip were lumped together.
Any opinion on my proposal?
Thanks.
