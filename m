Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76E9C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C2C2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SFDUI+61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C2C2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeJ3AxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:53:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33072 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbeJ3AxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:53:02 -0400
Received: by mail-lf1-f67.google.com with SMTP id i26so2143690lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dzn1/tlMeICKGrvbErMdzCLCGp8vxT7YrRmHfg+595Y=;
        b=SFDUI+61XXp74hcKM9pDDvRqp/tKQtv2dD9W4DsPIQRp1VKeb9XsP2YOOBre1heMJL
         H9Jk1Wo8CBUP+KtNf95Ua2T7+iFDefqwFRp+7AwPTgfRGhJrGmnybSeoSTIgsDrGVIXq
         MRJEjYIPJLBQwC61TY1zQ1avrNVLmQwvKuM+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dzn1/tlMeICKGrvbErMdzCLCGp8vxT7YrRmHfg+595Y=;
        b=OgD5nk5Au+KCmp287At13lkbeyzAUQYbMZOy/ga6CXO3V5s/byOs2urOEgjexuSeYD
         zGakZ6bzXzmd6fomZz0PFBB4hKl2Rrmvmt9jVEnlOSQVbrk0bgQug8fIfzxbvAKtmePI
         EuQGYb8/OU6d8rPB85fYNinwaQbg6sZ5Wwqp/VSpx3e0mbP06K/himA7efjkX+/UFDDi
         NFleZWtqo4zcV3iWUdRDa4R79xaGbY3/OjMu4ZcArBh4K2GsRCGLGbXF/mP24stT+g6Y
         8d1P0zL1BZ2QQd5dZ8S/xgBwd6pWICYgP16+kk1rMPU8pgUfbLzg5lhH37mu6YnYQHaF
         jdbQ==
X-Gm-Message-State: AGRZ1gLH4gv6ZYO1h/G3XUoP9ToXdWbbCvH7MngFLbUW72PGz0iWE907
        tdNO8fO39FZ4jsc2SCvsEl0sPbb6WweNmQ==
X-Google-Smtp-Source: AJdET5et86eMln6EURRgLLPHmGdDQldTk0YIXtos2sxJMs+yphwW2vdg2HFFgbK9I4/sibWGyomy5A==
X-Received: by 2002:a19:d98f:: with SMTP id s15mr5375145lfi.58.1540829025877;
        Mon, 29 Oct 2018 09:03:45 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id i2-v6sm1816527ljc.94.2018.10.29.09.03.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 09:03:44 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id t22-v6so8332933lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:03:44 -0700 (PDT)
X-Received: by 2002:a2e:7801:: with SMTP id t1-v6mr4451072ljc.120.1540829023746;
 Mon, 29 Oct 2018 09:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <1540613318-23877-1-git-send-email-ren_guo@c-sky.com>
In-Reply-To: <1540613318-23877-1-git-send-email-ren_guo@c-sky.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Oct 2018 09:03:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=whq5ebFd2CKE0bybLOY7ttMPxGiXF3WkzFXtkYhAbJqSg@mail.gmail.com>
Message-ID: <CAHk-=whq5ebFd2CKE0bybLOY7ttMPxGiXF3WkzFXtkYhAbJqSg@mail.gmail.com>
Subject: Re: [GIT PULL] C-SKY(csky) Port for Linux 4.20
To:     ren_guo@c-sky.com
Cc:     Arnd Bergmann <arnd@arndb.de>, marc.zyngier@arm.com,
        Peter Zijlstra <peterz@infradead.org>, robh@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com,
        guoren1983@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 9:08 PM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This tag contains the Linux port for C-SKY(csky) based on linux-4.19
> Release, which has been through 10 rounds of review on mailing list.
>
> We almost got the Acked-by/Reviewed-by of all patches except "Process
> management and Signal", but all've been tested.

Pulled,

                    Linus
