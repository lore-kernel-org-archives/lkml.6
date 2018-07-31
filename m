Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B30DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD6420844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QVtu5cwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD6420844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732126AbeGaUkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 16:40:09 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43680 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729772AbeGaUkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 16:40:09 -0400
Received: by mail-lf1-f68.google.com with SMTP id f135-v6so11504574lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 11:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fRgwtGzP4BGq/IE1NVc5YHcQza/GfYwCd3ep7yjYZwI=;
        b=QVtu5cwW5Ca6Dnj1/ouOYv6yFsb9+nMjGdlCmdptKZEqtLMRBHcp/FkdDHz4i/2IDL
         awZCr3PemvZnHaESNge1AbE2jWSm6EgpIJ7RWUDeqf7G0TlQyQgUUDdHt4re6r+ENmRg
         gqAlVY6RcTw2SE1Cnvcn10xcjfj9dYT/U2Dzth0aKmvCN59cEO7onht24bCkcBvlyCUm
         cHuFCkJOrypXkSRqvoOJXWL+aY7gEIyNGPoYIR/x7PrsWFBw1vXFps22zI7xGYWepUHy
         sxuM4lgSuiBrP9P4gMUMYt+ZhQw3VDgohyBv7lPQ2Ho4cZv2k+u7s4g44WkcoRDkA3Ag
         QD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fRgwtGzP4BGq/IE1NVc5YHcQza/GfYwCd3ep7yjYZwI=;
        b=QoD/xs368+mHeoBI2NjXNrXz/jJ4SkdHpf+nJz2TqevgeRC7L1T+xw7i4llib3FIi3
         ajx+CdgBcx3Z36sFv30XKkBcDOA91vwBozrX6pI9IbA/o3umYXpl96ya1io1iMO2O99H
         UidadED7Tzl43x9y4rj/9CypVXXileg8pmKEoVluB97dEU/1tVe+qG+wFyHCY+xFTkwL
         ChUK+puSy1UBG7brTVrhcy8N65qZ1cejuhhm2JoPYeDCodCIrUN28fnqlqcqH3ZojkOD
         nkh6PQNSXoytHXYRFTz3m+Mgss6ROHvPVJJ4EODgMuu7LYXyxQkABM3ZbAYUpytYqQye
         uS2A==
X-Gm-Message-State: AOUpUlGG73kr+s6T7Iuh8ej4omhmFlO7cdffdc94qf/7Vf8NO+e/eeul
        mnV4li8T8x46tHmqZiOPSQnnFCUnfvbtVZ8NSki0Ig==
X-Google-Smtp-Source: AAOMgpelE3JeMvfM0TkV6EKC5gykjD2LbkhTncncB8/DlVrJJ+BJNFEfTzxilfCaLVmy6nqUlWvd6doVlcvXIg6cV1c=
X-Received: by 2002:a19:1888:: with SMTP id 8-v6mr13244748lfy.121.1533063507536;
 Tue, 31 Jul 2018 11:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180723224727.120952-1-rkir@google.com>
In-Reply-To: <20180723224727.120952-1-rkir@google.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Tue, 31 Jul 2018 11:58:15 -0700
Message-ID: <CAOGAQera-YQTvyPtwOmot=hbwWG_g6Y2dyTZDYepeLH3Pw+Hzw@mail.gmail.com>
Subject: Re: [PATCH 1/2] goldfish: Add missing includes to goldfish.h
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

could you please confirm you received my patch?

Regards,
Roman.
On Mon, Jul 23, 2018 at 3:47 PM <rkir@google.com> wrote:
>
> From: Roman Kiryanov <rkir@google.com>
>
> goldfish.h refers to external symbols such as
> dma_addr_t and writel. This causes compilation errors
> if this file is included before other header files.
>
> The mentioned symbols are defined in types.h (dma_addr_t)
> and io.h (writel).
>
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
>  include/linux/goldfish.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/goldfish.h b/include/linux/goldfish.h
> index 2835c150c3ff..159b4191f15d 100644
> --- a/include/linux/goldfish.h
> +++ b/include/linux/goldfish.h
> @@ -2,6 +2,9 @@
>  #ifndef __LINUX_GOLDFISH_H
>  #define __LINUX_GOLDFISH_H
>
> +#include <linux/types.h>
> +#include <linux/io.h>
> +
>  /* Helpers for Goldfish virtual platform */
>
>  static inline void gf_write_ptr(const void *ptr, void __iomem *portl,
> --
> 2.18.0.233.g985f88cf7e-goog
>
