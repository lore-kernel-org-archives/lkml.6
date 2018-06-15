Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DC197C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875C520896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaGcBbzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875C520896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755908AbeFOHo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 03:44:57 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33774 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755385AbeFOHoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 03:44:55 -0400
Received: by mail-lf0-f65.google.com with SMTP id y20-v6so13285178lfy.0;
        Fri, 15 Jun 2018 00:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pef7SoFVSbN3FjBzHDn0ftfsWwWvv2P3AV71UObMx0c=;
        b=PaGcBbzXMuonDY4hEOdln2/3qXAkiZp+NPOE7Ps0ydfl/pCKDT571IBRi8M01QrBUu
         XATtS21HcNTHh5uDUCc0bwTERqTicj+UG6+vdNS9VfFauHv2/lrhb19yUDzcfNHEdUrL
         bNyoSqbXUYzHwoEEUdjv9THJ3Vp4PQBhl0LHB0+hdElz+0KisnR4Dvz3EW0pJzS3U2ZB
         izu5CWrGveSKMxFuNumipPlrgj5IvChmYSj8+7Y4uJlm9U/4GMxUoConv2sv5gzXCXCX
         6FRE8b9ipl2HFbU4g5qhAvoNufqutMVV6PMAYj84xUhIdefYU5jSqnSa5XT0CdbCxRuc
         jL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=pef7SoFVSbN3FjBzHDn0ftfsWwWvv2P3AV71UObMx0c=;
        b=euTU0A6vac8i62ZTLqvnb2j+KSJZB0ie4utTA/3BRodB/48W6cIopqloJHQ269xbXa
         STUleD1BIY0Yso7tvsf1NrQa6Rj0CbvBQyv2NDUKV37jpO5Zu6Wpo5/aFaU7zZApfpte
         kght3xAOowrGsUBjjucqR3Cpt2is2X2Kpx9E7ES2e27IRYgbPS/D53DcdLtdOh62XIUu
         24FwPutXV1oY6VL8DrKGPhDQzW5oTh+z/Fe2z1vcXMjXVvQQaAUl1ZWz9VIYgDGm0s7y
         FeHMRC9x86CX2FeQZuwfk98F7tMCtKcRKH+TFON3WlI1T3DoF6ptPmx2PU/v6GwppnKt
         etvw==
X-Gm-Message-State: APt69E3dFeQ/Din9mklQ/K3kPQlwBDrM+5v0y3jZGeJ4CA813eJU0aEd
        beosBIvavF9R36LhbbYp7Ajrx0PPYgd8k1betSw=
X-Google-Smtp-Source: ADUXVKKlOaiXqJVnUm+UVt+4PVh8sCIad+FRIrTTZcWb7DM+L5a1Maf7XO4GGImn3Yayjf/MdTxjsnFQNQRHVm7uqp8=
X-Received: by 2002:a2e:40d9:: with SMTP id r86-v6mr508402lje.19.1529048694190;
 Fri, 15 Jun 2018 00:44:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 00:44:53
 -0700 (PDT)
In-Reply-To: <20180615124106.316e7401@canb.auug.org.au>
References: <20180615104324.76f86eae@canb.auug.org.au> <20180615124106.316e7401@canb.auug.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 15 Jun 2018 09:44:53 +0200
X-Google-Sender-Auth: SCGK-Z0XgvV90EmJA2yJnZ-0-BE
Message-ID: <CAK8P3a0QydiHLKr_0+k-nOVNZxAuh1AGbGK1xU6er8XgmNrGPQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the y2038 tree with the overlayfs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 4:41 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> This is now a conflict between the overlayfs tree and Linus' tree.  (I
> restarted my merging after I noticed that Linus merged more stuff.)

Right, I had mentioned this in my pull request message to Linus. Until
yesterday, I had the conflict resolution against the overlayfs and NFS
trees in my y2038 tree and was waiting for both to get merged first
so I could send the pull request. NFS got merged earlier this week,
and when I looked at the mail thread about overlayfs, I concluded that
it wouldn't make it: the changes in the overlayfs tree in linux-next
are the version that got Nak'ed earlier, and the discussion about
trying to fix it ended without a positive conclusion.

This should be addressed as soon as Miklos rebases his changes on
top of 4.18-rc1 for the following merge window.

     Arnd
