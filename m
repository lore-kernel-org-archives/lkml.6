Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F2AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D138D20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ED2Ngty/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfAQSaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 13:30:16 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46682 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbfAQSaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 13:30:15 -0500
Received: by mail-lf1-f67.google.com with SMTP id y14so8538573lfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 10:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7HUXZlBPsg+0+4IjfutuC9AjuTmBRTez9FBBH0W2l9I=;
        b=ED2Ngty/ZMnYKEcbBOer4Xbc6ajO91GAYBGwBqKztPds1x05LDS5VExRn217Bq3BvF
         WZ0NmE1rlQCeBHDk1BcNkre2456UGDxo9r6ZjJL3p5PBQmXAiC+gAPhyaUd7PWfY2v6X
         vxCCNO+2NJDl6h40n/epL8ADsyezoTuOmbhGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7HUXZlBPsg+0+4IjfutuC9AjuTmBRTez9FBBH0W2l9I=;
        b=EOaWPUTSPU/hW27zt8uVcRrZqy0inJH8PsrGZATQxIcWaYZsgzfNNYXydO/v2m3xzQ
         hoLRvbqD0lPo4sIRjJECYRsG+EsEtxnRHcEcI65dr/VLqe4c245kEKFwcAoPMdPxEpqG
         X2iKpkR22sQAEApwkluCvf+VXW1tw6RoEsRSnwbtypRmW5+ZFIQKZPhvht7ZqYYJD6ZW
         80sue1Wj+U1WSGrsHWyrV6gtqjLIeHCXagydXFku03ybeYtkiUmrR5INRtFifxYUoaHG
         otqQKF+k17b8DV2PQn+fgh+neqY6KfLQ+i0ZmpEUC2kei0Y++SfJWExnldp6LnOQoMVU
         qMAQ==
X-Gm-Message-State: AJcUukcyk75VsxvTSqqsW19Xg85Z0thSya8Cs60I5UexlpWD87LpRh7i
        5u6EkyO8yxTRGoJAYaMszFx5uPHMBvA=
X-Google-Smtp-Source: ALg8bN7SD4iYXgGB+YxbtyEvBoeOz4avDszbG8nm03w7F3wHvYsByWak50tYkhJSzzsMg06mV3RbhA==
X-Received: by 2002:a19:d90c:: with SMTP id q12mr10517206lfg.24.1547749813201;
        Thu, 17 Jan 2019 10:30:13 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id r29-v6sm356341ljd.44.2019.01.17.10.30.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 10:30:12 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id c19-v6so9440298lja.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 10:30:12 -0800 (PST)
X-Received: by 2002:a2e:3e04:: with SMTP id l4-v6mr10009109lja.148.1547749811684;
 Thu, 17 Jan 2019 10:30:11 -0800 (PST)
MIME-Version: 1.0
References: <154773884927.24105.2730570814701376379.stgit@warthog.procyon.org.uk>
In-Reply-To: <154773884927.24105.2730570814701376379.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Jan 2019 06:29:55 +1200
X-Gmail-Original-Message-ID: <CAHk-=wgM+h9K-MdyOAjonMchJViy-7stCKHqn0vMgitKDmpVbQ@mail.gmail.com>
Message-ID: <CAHk-=wgM+h9K-MdyOAjonMchJViy-7stCKHqn0vMgitKDmpVbQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] AFS fixes
To:     David Howells <dhowells@redhat.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 3:27 AM David Howells <dhowells@redhat.com> wrote:
>
> Here's a set of fixes for AFS:

Can you please use the proper pull request format?

Not only didn't this show in my usual "git pull" search, but this:

>         http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git
>         tag afs-fixes-20190117

is not  valid pull address.. Yes, I can fix up the thing (and have
done so), but a normal git pull-request wouldn't have had that issue.

              Linus
