Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB832C4321E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7761820843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="amuAuaW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7761820843
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeIDHI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:08:56 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35712 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeIDHIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:08:55 -0400
Received: by mail-wm0-f46.google.com with SMTP id o18-v6so2683323wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 19:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=N8VDB7K4hkxRghIHD8ZOYGsPd8NVOeDWeh07tObt0T4=;
        b=amuAuaW6EF5Z9QbBN24E/7X7sd+pnrWSr7nUcZ3SMO2iQsL++lWngIgwIgbWtt9nS+
         vVXWoAlYiEgzeQ0ZCvfT5UTrn9tla+qEL/ee3t8O+O1jCceXAL3AzfWh6Yi1yxVP3J9+
         CGMPoGvZKqjgGFs/MAtp9kaeIpd1aflU9/5VqiheHBzbM3Fjh/mgzQ27qsu2F5dvueUk
         DPZkVDLsJ/rBc6IdN7F/H4ZL65Et6TI+DE5WWDbOTjBQd2QzGV4lAOIwx3mhW2pWYn5x
         uSx0AwXV5j5Avif7BcyWuAepGHf6HLRPtcltiyrzrTpPhv+/mgJ2SL+nuliY+8AqimXV
         h6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=N8VDB7K4hkxRghIHD8ZOYGsPd8NVOeDWeh07tObt0T4=;
        b=tMFfNlwtp924E3W63S0VtzveIv8/nKgkBh8ptr08t2qRwG0LVZ+imIvjvzfd4b9Jir
         N7qfkgYJdkix6+/aK9lBe4ADbuplTTx3tJ9hqfJy8/dsEkFcf/O+RyexLxV0hCAPKImL
         9T3PybN636HHfhLdSSOym7OF7H7SH4ng1KlvL8FqHLdQKHPAzLnI4qWarfQtGHxQKvAa
         /DuOBVs3NkNOnKg3mTae1DN9OD7hvfd7bvIepVqVPwP1ixOeKjJqqKNA69ZOJ/bwBYWU
         UT9VOWWj8YW5H3dZIPJNm9hFpLG4ehwq+wQcT9k538YjfFsiQq0kmYh2oqG3WLnQ/FcG
         T1iA==
X-Gm-Message-State: APzg51BzwJXuXMXYLPFJSq/ajAheUXUcpMGlMFg0QbCIJ3NcKZ8uxc/F
        fzTYWDkVqSe1tgp4OSQchzH1DHSz8g5QijAZESY9Qg==
X-Google-Smtp-Source: ANB0VdZuDdefaQ1GQTrdufEPjvtdGCw5rUEi/eDfYidum30VDdbqurC4soVEpH+HYgcCLYOntTk6TrUNC9qPbvn+reM=
X-Received: by 2002:a1c:e141:: with SMTP id y62-v6mr6752719wmg.138.1536029159821;
 Mon, 03 Sep 2018 19:45:59 -0700 (PDT)
MIME-Version: 1.0
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 3 Sep 2018 19:45:48 -0700
Message-ID: <CABPqkBT0kEMOnTw1-E1kezCvtWNSws7dp2qzCWKVmjGPOEga8Q@mail.gmail.com>
Subject: [RFC] perf tool improvement requests
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo, Jiri,

A few weeks ago, you had asked if I had more requests for the perf tool.
I have put together the following list to improve the usability of the
perf tool, at
least for our usage. Nothing is very big just small improvements here and t=
here.

1/ perf stat interval printing

    Today, the timestamp printed via perf stat -I is relative to the
start of the measurements. It would be beneficial to also support a
mode where it is using a source which can be synchronized with other
traces  or profiles. For instance, using gettimeofday() or
clocktime(MONOTONIC).

 2/ perf report event grouping

  if you do:
  $ perf record -e '{ cycles, instructions, branches }' ....
  $ perf report
  It will show the 3 profiles together which is VERY useful. However
the output is confusing because it is hard to tell which % corresponds
to which event. I know it is cmdline order. But it would be good to
have a header in the columns to point to the events, instead of
guessing. A few times, I had to revert to perf report --header-only to
figure out the event order. I discovered the 'i' key on the function
profile. But it is still hard to find the events, especially if you
passed many of them.

  3/ annotate output of loops

Percent=E2=94=82401f00:   xor    %eax,%eax
            =E2=94=82401f02:   test   %edi,%edi
            =E2=94=82401f04: =E2=86=93 jle    401f2b <triad+0x2b>
            =E2=94=82401f06:   nopw   %cs:0x0(%rax,%rax,1)
  34.20 =E2=94=82401f1=E2=94=8C=E2=94=80=E2=86=92  movsd  (%rcx,%rax,8),%xm=
m1
  14.60 =E2=94=82401f1=E2=94=82:   mulsd  %xmm0,%xmm1
  33.24 =E2=94=82401f1=E2=94=82:   addsd  (%rdx,%rax,8),%xmm1
    9.98 =E2=94=82401f1=E2=94=82:   movsd  %xmm1,(%rsi,%rax,8)
    0.10 =E2=94=82401f2=E2=94=82:   add    $0x1,%rax
    0.03 =E2=94=82401f2=E2=94=9C=E2=94=80=E2=94=80  cmp    %eax,%edi
    7.84 =E2=94=82401f2=E2=94=94=E2=94=80=E2=94=80=E2=86=91 jg     401f10 <=
triad+0x10>
            =E2=94=82401f2b:   mov    $0x18,%eax
            =E2=94=82401f30: =E2=86=90 retq

    The loop arrows cut through the code addresses. That is annoying!

   4/ sorting and event groups

       If I do:
       $  perf record -e '{cycles,instructions}'
       $ perf report
       It will sort the samples based on the first (leader) of the
group. Yet here all events are sampling events. You could as well sort
with the second event. But I don't think perf report support sort
order on multiple events. Both are from the same category: syms (or
ip).

        Right now, I would have to collect another profile:
       $  perf record -e '{instructions,cycles}'
       $ perf report

   5) cgroups

    Today, to measure multiple group events in the same cgroup, you need to=
 do:
     $ perf stat -e cycles,branch,instructions -G foo,foo,foo .....

     You need to specify the cgroup N-times for N-events. It would be
good to support a mode where you'd have to specify the cgroup once:

      $ perf stat -e cycles,branches,instructions --cgroup-all foo,bar

      Would measure cycles,branches,instructions for both cgroup foo and ba=
r.


   6) perf script ip vs. callchain

     I already submitted this request separately. It is about
providing a way to generate the callchain separately from the ip in
perf script. Right now, they are lumped together which is not always
useful. Also right now, the callchain is a multi-line output which is
not useful. perf script should stick with one line per sample, at
least when symbolization is off. We have examples of that with
brstack.

I may have more requests but I wanted to start with these for now.
Thanks for your efforts.
