Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C207C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A79B205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfuUNUR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A79B205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeKBHAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 03:00:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45697 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeKBHAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 03:00:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id n5-v6so21507392wrw.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 14:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gk0V0ymG+8OtXqs+0leQ5UmRvL35/lixyxJousAOs8M=;
        b=jfuUNUR2xCSu6WfD9zBWRhKfUqZyOHZ6bRluR6A++rTd/xpuTyMyb2BJMkoYoJes4o
         6HCfPbgTegXejrU5vJgyW/XaHPvai7wUk2yfAZOHF1QXNRKWfhT4U1RjKaXz9hc38TOd
         0l3G+dv7RYyHWfwJh8DfYr1sk5box9F8F5rLLU7hbhXrfqt9xJzGkOhBpXBRdRhRUp6X
         OBsAxgqtz2GctEinD/7J5Ms2lwkExy3BIW6++SRyuBgemXM2sSN7EQMCTYXic2eyqJ6P
         oxLODlJAui1WdMhYbbpKUljjxdRv4Na++LvzLwXDBAiDQcq5Pakq2d+Qlr0alo84vx4Q
         mreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gk0V0ymG+8OtXqs+0leQ5UmRvL35/lixyxJousAOs8M=;
        b=GaXpOln6Uz8In2NYv4P1912AjijreXI/u+HNAGG3plO9NOzJHGHiFFKiTc57N9UzqA
         V2YP+xAn8dEc7Pe2PU2/UFqgJV2A9Zj5Sb7xiShfHoUVTIPnbH4OX2YIngl582xswrQL
         xv+zovQo/ZX4JgPaCwefV0YqcON6xyICMeShKMEuzV3OSHxcggazTS6Lgpy/tawTacjK
         9ne67/Fjs2WEtXKzwAYfKTJMg3t9gTSjk012Pj4iyhFAhVeL+3Ni/rNzJN/Owngl0iXj
         lCM+7E2Sr2c9rBUUzTgoyGoKeO/6R7t+DTnrurNmsWKNDq9tO3pemhCrxxPt1aLpWdCk
         ZYcQ==
X-Gm-Message-State: AGRZ1gKqcHLzi35qtd1MOy8HOiP3ECqcCD+WBJd786ys/e53usxJS514
        Hp33gmgBIIBck98z9QVImi1ZP9z7MAYzsGVvD9s=
X-Google-Smtp-Source: AJdET5e9nZ/czWjtbbzWiQPaDpnJtte7TIzB2wGPxRNA3iaS8XvjqDGrtf0wBEn6mC++MwfCZGNDaM71l/FBURxNQGk=
X-Received: by 2002:adf:de0b:: with SMTP id b11-v6mr3773918wrm.119.1541109314112;
 Thu, 01 Nov 2018 14:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <2346471.iD2boZGiFq@blindfold>
In-Reply-To: <2346471.iD2boZGiFq@blindfold>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Thu, 1 Nov 2018 22:55:01 +0100
Message-ID: <CAFLxGvzR5XCyBiR2tyFw5ouB+aekPrL1KD6zwiaL3VqCnznTaQ@mail.gmail.com>
Subject: Re: [GIT PULL] UBIFS updates for 4.20-rc1
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds@linuxfoundation.org,
        "linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

On Wed, Oct 31, 2018 at 10:22 PM Richard Weinberger <richard@nod.at> wrote:
> The following changes since commit 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d:
>
>   Linux 4.19 (2018-10-22 07:37:37 +0100)
>
> are available in the Git repository at:
>
>   git://git.infradead.org/linux-ubifs.git tags/tags/upstream-4.20-rc1

Just a kind ping to make sure that this pull request didn't get lost
in your spam folder.
Since you pulled the UML stuff,but this not, I'm a little worried.

-- 
Thanks,
//richard
