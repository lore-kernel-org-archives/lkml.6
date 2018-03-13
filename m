Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751488AbeCMBG5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 21:06:57 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:41608 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbeCMBGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 21:06:55 -0400
X-Google-Smtp-Source: AG47ELs5NlwqUY1fNNTcWN6RtaQQc4eGTSE/+XNSMtgUJTeH2eCMCw69mxqHsHQF9VXc/bOMJc+tzzIjLbBulxhXf7Q=
MIME-Version: 1.0
From: Stephane Eranian <eranian@google.com>
Date: Mon, 12 Mar 2018 18:06:54 -0700
Message-ID: <CABPqkBSfsmvJ3P0zfkFmC17nJPrzmP+pO83TKoTByEZNJ+FH+Q@mail.gmail.com>
Subject: [BUG] perf record: GROUP_DESC not supported in pipe mode
To: LKML <linux-kernel@vger.kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        mingo@elte.hu, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I ran into a problem trying to group events in perf record while in pipe mode.
If I do:


$ perf record --group -e '{cycles, instructions}' -o - | perf report
-i - --group

I do not get the profiles grouped together. Instead I get two profiles.

Looking at the code in util/header.c I see that a bunch of features and not
supported in pipe mode (synthesized method). It is not clear to me why.
Clearly grouping should be supported. This is a very commonly used mode.

Am I missing something?
Thanks.
