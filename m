Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB81C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C31B2173D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVNesVS3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C31B2173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbeHNI6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 04:58:35 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:42106 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbeHNI6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 04:58:34 -0400
Received: by mail-io0-f195.google.com with SMTP id n18-v6so17159320ioa.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 23:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=spANRlcvrDGDenb2tH7Y/zieCxeDK4pPQltAWBq3Yg8=;
        b=AVNesVS3tCKLz159svMILzOM8p2IPIzbc2pqnE5m2c64yHhV+1/phGjPNxL8t+2b0d
         0GUPNUorr6Eg2qaOeL0jaYuddVCgBKfg3NlWSgSpo/QVh03KOnE5LMKerJPXb0VAQtqa
         xkqY7fU0HKn4D1rSf9M+MtFk+L0PBne2KXogt+LAA8g6ptEvNM9D4EULuMcp+6dDBcUA
         +Z+LbRRhOI+9svWl3CcoYcuf8li3ivIc8uMmljG6YJ/F1/f6vFDezruGPuvL0xLCoRmv
         xeqbbOF+GrIyq5Exioc4c/JQheFBvHasha7mZ6j07duNLhEGIVlcj+acDc1Lb7UMm24J
         3IgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=spANRlcvrDGDenb2tH7Y/zieCxeDK4pPQltAWBq3Yg8=;
        b=NBVOyovP5OHaK1WBbDieltP8CsEuRnl3YKYjA/vR7BSJauLRWdEKLpwX0yNS2DVUg/
         1uh0bt54FE776bxJzIy7+UGdpHcZ7cNKwJ6bU67cfhOedTt0BAYRh0MbdV6J4hQvw6Jd
         W3Ea5F+10jopuucXwnHzRTvCMQ+NYkpTtg3PQyFdx6x6rNadMR47Xd6sOEBDqDxTKNUl
         sXGeOKwKgJingiDqORdFYaG4CHdEwZwhJbrplCHXVdg7ByUaq16fRVVzB3DQnT4cbNsy
         4eR80z227y0b1QkAeLSIPTBoUavU88VFPbcG1qtGrV1fF8r/sMnk0sfqmrLsjTZK0m/B
         sEvQ==
X-Gm-Message-State: AOUpUlHTo2XcLy/X+nk0ZyBnGL5RpwLlc6/eRWXqoHWL0sMEkOwWOrTR
        /vNQJDcSVqEV4znsENxDpwQly6UnU7ZK/ZCyt80=
X-Google-Smtp-Source: AA+uWPzHf6/EEdkW6HbbsBM4Q3ZinyclAGz1mCv3o1qiyJMaKYaVpjzRMw3D7JD1TroLLGuy0x+sdmUAb0GZHaLHpCU=
X-Received: by 2002:a6b:9f0e:: with SMTP id i14-v6mr18132206ioe.0.1534227173549;
 Mon, 13 Aug 2018 23:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180723070145.GB7523@krava> <20180811083915.17471-1-alexander.kapshuk@gmail.com>
 <20180813111631.GA718@krava> <CAJ1xhMUfQ9GDEXgL-+R_vs1aoidbwj5LRsyb9K32MMUnR23whQ@mail.gmail.com>
 <20180813185850.GC4499@kernel.org>
In-Reply-To: <20180813185850.GC4499@kernel.org>
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date:   Tue, 14 Aug 2018 09:12:17 +0300
Message-ID: <CAJ1xhMUp0gO=0LV8485FsxVk+P6LyDDPJKXg8+ENEAG04z_w_g@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Fix check-headers.sh AND list path of execution
To:     arnaldo.melo@gmail.com
Cc:     Jiri Olsa <jolsa@redhat.com>, jolsa@kernel.org, mingo@kernel.org,
        namhyung@kernel.org, David Ahern <dsahern@gmail.com>,
        alexander.shishkin@linux.intel.com, a.p.zijlstra@chello.nl,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 9:58 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
> Thanks, applied the three patches to acme/perf/core.
>
> - Arnaldo

Thanks.
