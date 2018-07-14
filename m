Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3262ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 15:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7622D20896
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 15:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bP6bcfsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7622D20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbeGNQNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 12:13:48 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:50400 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbeGNQNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 12:13:48 -0400
Received: by mail-it0-f66.google.com with SMTP id w16-v6so15301154ita.0;
        Sat, 14 Jul 2018 08:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e9U8adnCeSFtEBM2A3rTJ2qcAZ4dIE7H8hV9JxTQbHE=;
        b=bP6bcfsS6aFqKGZ7H1EypTPe3TtBTHGCpy904pp3db0F0Y04mphvzHnpIg7DV6p1eg
         5aYl7gfDofnOiDmS1Yg7dcauGo/wXt1z6qgfUFNm91+s5vNWYrWjwiHyzfPL5jP+5T8o
         DLqBld1jLAwxRWdTlaL9HfVyu+2kgi7A7oXpIFczzQSaKU+MtGGlySHItbcZfF53Sd0P
         SJ3JTgcoE0oXXrAh2kLMuRtaDx5AQR7NJ3uLvHkai4N0xxkCm1XclFzHIi2uwv+8sEic
         2hVqXnU8FeoJwB1dtIgdmiZS76Us/44XwQRtKZgvdA23KYfubGrBSg1NwcGOi4M71T0U
         hlmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e9U8adnCeSFtEBM2A3rTJ2qcAZ4dIE7H8hV9JxTQbHE=;
        b=WZmLoCXR/1Bo/kOAxy9jtY5ENLomN5yG/orAPZm2ITx7KVqzMzrqmcp4O81LPYT9Ot
         RQH7AQArBU3i/VdkjiZOaQViiPcPdz7+X+miDmH4FIzUIHjA+SVmbLjJrlT4FvtOfrSP
         Yi6vO+QYq1rpkKkytN69kBH+WaBrJT3dDiD9uSMQLOeLqhnn7auwPGerkWidrZwUrhnB
         1nwytKdTxPKZaKWeqokugccGZkj/GRUvRWPelfHjmGBijGyOse3EfStJV8VbR+KVGMvT
         pgkQFHXOmgw1TAVsGY366dMUsBF/vXsPbXf40LXE/0cSUWaPLubsF7gkUL9WTeonT9gZ
         s4/A==
X-Gm-Message-State: AOUpUlHIzvJrT9CpsB0R/6qt07FNlp89M3+9ZzE0LhKuhWHtN5dWIF9P
        uffALQfsM2XhkxiRszcl17w75A/2b5Xgp8YojvU=
X-Google-Smtp-Source: AAOMgpdb+aGAY2J9jJzKATb1CVjlh5+M+ZSRRHv+3zJ3TmuI8sc5Log8frqCBRLK3HqL1Ktm9uGC44fYZnh9iL/y/VQ=
X-Received: by 2002:a02:a1d9:: with SMTP id o25-v6mr9071883jah.86.1531583658607;
 Sat, 14 Jul 2018 08:54:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6801:0:0:0:0:0 with HTTP; Sat, 14 Jul 2018 08:54:17
 -0700 (PDT)
In-Reply-To: <20180713133204.3123939-1-arnd@arndb.de>
References: <20180713133204.3123939-1-arnd@arndb.de>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sat, 14 Jul 2018 08:54:17 -0700
Message-ID: <CABeXuvphoYM+KOGPgtsuxzS1_XDSOO0Ta5hr3sA7gYtt-78wtQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] y2038: globally rename compat_time to old_time32
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, geert@linux-m68k.org,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now we only have compat syscalls and native syscalls.
Until we transition all the architectures to use the new syscalls,
wouldn't it be the same sort of confusion as exists today?
These structures today are still used by compat entry points.
I'm trying to understand why such a cleanup would make sense today
rather than at the end of the transition.

-Deepa
