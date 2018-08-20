Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A41AC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 06:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0DB20BED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 06:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5QMpptK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0DB20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbeHTJSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 05:18:37 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:43135 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeHTJSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 05:18:37 -0400
Received: by mail-vk0-f54.google.com with SMTP id s17-v6so5943461vke.10;
        Sun, 19 Aug 2018 23:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/2O5FM9aVCXtcJKq3syyRUT/XQdA3VN/YLeLc1UB+Q4=;
        b=U5QMpptK8s0Dlt1cT4WbwPoFGSsEw9jexaDa9kzI836ieRN8WMtP6oRXNQFvXncQIs
         Xe3zuqIKgY63LOeArhhXzxNymbEMmYKaXvjXyjv25tBkzZm23gFnbZGVTSZ1C6/7/1wC
         Bl6Muad5Hm0FV70IVeYGzsZ4SdnYJOvlGs2ZcX0W3AIYTrY7SC/d3zAJfzTZcJ0pVixb
         a1IJKGhVLo4WiwxPG5H/RRQ+d8yLqYqI+rog+L3qWTubVmjlfmVz+JQQvQ/TaHmaFZvK
         8Ls6sSmh9zrA5qH2tvXcks3JpE7+rmYAzgtRQeAQrzhqjd3M4qysGrrP4KvGXMW/vMni
         pSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=/2O5FM9aVCXtcJKq3syyRUT/XQdA3VN/YLeLc1UB+Q4=;
        b=lPs5zVhjX8iJ39Kdd2b3Egs4Lm4HOtzAXeO5yV9wqZj59ZYSIAohXcX9XVddzV1AiA
         pRtfpikixfgUfV50sxQRkYSMyRkLwWSdjghWH8xbtji2kGhOzgM3xIEQcSZpyYOOQljf
         ZJV71Qz3mzGgAJJcxJh+bomrWyv99lmn5Q5TZ+AmxWzalUBJgrx29NE9dYfiwVBEItSf
         CthaHJa3x/qicLiTF/T83A3klopYcg115Orasubbi8bj2rm5WUuvTPC4RL1swvA2spC8
         T15pUQhCIAvWjMAbft9D8uPOwPr1DuWHXj2Oz8a7+7sOz0AR/mTK1NwrryTrXSKM3BOc
         tvLQ==
X-Gm-Message-State: AOUpUlGLDsJtsHCAlODyq4uH8vKy1NApvYhi8Nu9vCu39QDvet18hsEJ
        1IGmLozT7hyBdZ6sYEVUFd2v1T5l7mj++1WMPQ==
X-Google-Smtp-Source: AA+uWPyb3H+SUJ4V5PkqJGMYPhK6julyIbR00fHNCxj+O3UnXoz1l6qXDLnhM6Qf7w7HRJxYcInES3xxQ10iJdpD3S8=
X-Received: by 2002:a1f:844e:: with SMTP id g75-v6mr29468062vkd.16.1534745059676;
 Sun, 19 Aug 2018 23:04:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:e915:0:0:0:0:0 with HTTP; Sun, 19 Aug 2018 23:03:59
 -0700 (PDT)
Reply-To: whiteheadm@acm.org
In-Reply-To: <CAADnVQJjqLY3iFy2y5mb+oMR=VHS8HS_KXa0wm1HO3v0ayvrkw@mail.gmail.com>
References: <CAP8WD_YEyxKOimMrGk+5Db8DpNfqQL84-2xLXbe53jiY_FoPrQ@mail.gmail.com>
 <CAADnVQJjqLY3iFy2y5mb+oMR=VHS8HS_KXa0wm1HO3v0ayvrkw@mail.gmail.com>
From:   tedheadster <tedheadster@gmail.com>
Date:   Mon, 20 Aug 2018 02:03:59 -0400
Message-ID: <CAP8WD_ba1k6uxSFQ00QtW0L23jzjSFw93YpEq+010zKE5sT27g@mail.gmail.com>
Subject: Re: Allocation failure with subsequent kernel crash
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 1:22 AM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> I don't remember vzalloc issues that was fixed in this area.
> 4.14 kernel is quite old. Since then syzbot found few mem
> related bugs that were fixed.
> please try to reproduce on the latest tree.

Alexei,
  I get this panic with two very recent kernels: 4.18.0 and 4.17.14. I
do not think this has been fixed. I am still trying to bisect it, but
sometimes it takes 5 hours for the panic to occur.

- Matthew Whitehead
