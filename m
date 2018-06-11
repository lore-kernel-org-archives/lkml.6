Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 379F6C5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E140320869
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UBvkGHAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E140320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934382AbeFKR2J (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:28:09 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36456 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932627AbeFKR2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:28:06 -0400
Received: by mail-io0-f195.google.com with SMTP id k3-v6so10775895iog.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 10:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8kvhdcFdV7ieWckqEpsLPUiGr2YqIhq2/gwvvUtorGw=;
        b=UBvkGHAIoGzvqzEt+qRIzDisske2+cuE6bd7CnxfhBN2TEWB8egznjIWVGKE7axwK8
         93fTx/MUxmzIcXJtB13tFWZFUnexZ7wnX4w1yq4bCYNSplhN6wMWYEku6B9IfqJrnsNA
         nQzQZZT3hoYucVNjZcNq59vdu9bZwq14RBpPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8kvhdcFdV7ieWckqEpsLPUiGr2YqIhq2/gwvvUtorGw=;
        b=ty/6HY/d+ronicqIqi+cHSaw/j9s6sJrNr04QtOBwy5XGvDNeK6G9pjmEBw7jSST5r
         QqqnVvObeTrXeOsacdvEQYWbjyMGBpZV6Du+MeNcap1U8grQmbol7CNHglkJEJmWR6XK
         QtEc6HA/mzUqNshsoPy3IPRjjgmZagUoro3giFXv15QADt+3aHQfWdAL0WkTg2ESflSW
         Tea5WjnXkUOTZFEhjY9fEiDliipTnG9/WdwgoBvETbqGzLXiM1UNWXr8Lc1Qg0BPYnTm
         voQrIptkn08NyL4veVjm5dXi4whTHubx1njuF6+fkpFZxOYSUgpPtDsXriRLwEbBSR8O
         +Ksg==
X-Gm-Message-State: APt69E0+EwDdLFBNA5U7cAHvi63L0yapnyR1wckNmLBIRq34XScr4q1A
        NwR+4BtZJ7ja3nTmnocEAruimCyiPeC3mTArYR0=
X-Google-Smtp-Source: ADUXVKJKkYEoQC5EAYQbs6GjKQsJIi9zVkMG1elwTOnSv6z3DF4Xiw+1ccOOPEDWp3SMqorA0fDppRV0AKZnuXfV210=
X-Received: by 2002:a6b:f90b:: with SMTP id j11-v6mr102827iog.238.1528738085753;
 Mon, 11 Jun 2018 10:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180611165212.GA6783@jaegeuk-macbookpro.roam.corp.google.com>
In-Reply-To: <20180611165212.GA6783@jaegeuk-macbookpro.roam.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Jun 2018 10:27:54 -0700
Message-ID: <CA+55aFznP4aEy7DkVfeQ_e6eXgLnswVnSJS3C51UHD_k8qYZCA@mail.gmail.com>
Subject: Re: [GIT PULL] f2fs update for 4.18-rc1
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>
Cc:     "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 9:52 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> In order to avoid old MM bug [1], we decided not to use __GFP_ZERO
> for the mapping for node and meta page caches.
>
> [1] https://lkml.org/lkml/2018/4/8/661

Hmm. The patch there looks correct, and anybody who relies on slab
constructors is crazy.

That email from April says it should go into stable, but it never even
went upstream..

Adding Willy to the cc, for comments, since he's been active there and
is probably the maintainer even if the MAINTAINERS file doesn't say
so..

Willy?

             Linus
