Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6603C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 05:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EC72196F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 05:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYgP44qN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfBQFiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 00:38:03 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36726 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfBQFiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 00:38:03 -0500
Received: by mail-ot1-f67.google.com with SMTP id v62so14382493otb.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Feb 2019 21:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=AyqNSV6FfcoFGn1KiU9xXyk/9fGmoAvbYOSPbp6Niho=;
        b=MYgP44qN1ZNofkSHVv7CBSFIcwodHer3+/hM6CFikeN5lMzMsn+ygCcT/WuObLgFm9
         X5huP1nXy9dGzoXqboI5fpPCdBZor8xeXxLcOYvEYgSMSRCL9BR8AzHFIIIySS8nZNuG
         WWuNkutj8Jwju4ja3mQAC/0qL/VeIvb8dXDbsHCeFl2bLg6Xwg6+9HCrQzSAEhZ97fLd
         BzIUsA3kzmUQ1vNSBm5naV0+tK4xpkV9djsEoUnkwEMFh2dKyZ+7/Y36EwBQjwtppUkY
         dsPqiq3B+38Ookd+yqghY8K9Cr4hd55f/6m6v4qF07MqqeB8eMf5YzkHCyfrBo3Bl2dl
         pG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=AyqNSV6FfcoFGn1KiU9xXyk/9fGmoAvbYOSPbp6Niho=;
        b=FmFS0kmrDhRg2aUffciLLF6Ec/03QeV3NpirJQLgA8DGe8+VjshknRbuHeBfUFZCzq
         c/rjieDB+9R5QUFwDM7YYiQRsxTilT9KOO3klCHSWEcBeuAtezZUhlfeGY6Xn0xrfI2h
         hGtYj2qmnPRINTDzvYHsd6muLLAEwXxqfPyXVVH9qlMlTFXHv217hkUhDwnMohTNDWC0
         Wg4dK8aF6mNv0V/DM4rTMmqhNRrkGGEm/q2s1tdox0FTq6DiV6w/X6Q94yiIAu753/cP
         KbixNWpFMdR0514A7UOgFaQxaooO+0oF6fn5PqAi3c8FrlCsuTYMUCz8YS4rEi0CAY6s
         U7wA==
X-Gm-Message-State: AHQUAuagsitrPZgYluhYbnX3w9c6xDBikuGS7MY4pCVStrJ3KHt5bT5g
        aZJ6GEZooKp6Y2MLjQpgqwco36c83o7geKBoe1JSCEBz1AQ=
X-Google-Smtp-Source: AHgI3IZTnoU/EUZqXZQ6hT5W22Lpx5yRJtHsmzHYj+i/DFEgKEGlvzdEv/MAvJtB6fbVn8Hq6qV5Q28LHkDsXDlyiEg=
X-Received: by 2002:aca:6cc9:: with SMTP id h192mr11096183oic.161.1550381882741;
 Sat, 16 Feb 2019 21:38:02 -0800 (PST)
MIME-Version: 1.0
References: <CAM5Ud7NzkM72EaZ_ow4m6wtie=UHYqfhvM3L1dtNX6AidBWEzg@mail.gmail.com>
 <CAM5Ud7NDojyOnNmOpgx7ZsT1g=vMB9xxKOkmVj27FirNp+DPng@mail.gmail.com> <CAM5Ud7P64zfxXwTd_TwnP623B0tEonhTAx0DMu_otn+rf64UnA@mail.gmail.com>
In-Reply-To: <CAM5Ud7P64zfxXwTd_TwnP623B0tEonhTAx0DMu_otn+rf64UnA@mail.gmail.com>
From:   Alec Ari <neotheuser@gmail.com>
Date:   Sat, 16 Feb 2019 23:39:26 -0600
Message-ID: <CAM5Ud7NEFndty7NZ5fY1nHn376WseLKx34yTcTX0-uoiT9RRNQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/sign-file.c: Use CMS if LibreSSL >= 2.6.0 is present
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scratch that patch, error is still there on module installation. Sorry
about that! I thought that should have fixed it, I must be missing
something here.

Alec
