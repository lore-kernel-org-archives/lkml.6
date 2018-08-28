Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A061AC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5959920896
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5959920896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeH1QBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:01:47 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39210 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH1QBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:01:47 -0400
Received: by mail-qt0-f196.google.com with SMTP id o15-v6so1319877qtk.6;
        Tue, 28 Aug 2018 05:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Tydf5hVzjmpMBhCQwEbjlOfsyqUnSDxisSTFZzzPOk=;
        b=dK20jSAU/9nebqxvWIBVgIlLAcziHUMn6apVkUwkjmcNdX0zI6t+7TihX2sWyZaql+
         weImFRD7zJYKNSuXJbVnI0lP2MjjSl3BzArNFAT0KmNC+btqWbyI09I0hQJ0TR5NKPiA
         9Z8/CUlp6O6GGd5b7zR8dyoYqmHC7Zbjt3rhh9UhmhTJ6S65j67Mkp5ftyeFi7bwjo7D
         1UlmAcrr7XPjs5Z7CGZG9QsJXhayWd9z7//RdduswhfRzpCqX3ZD57Al1CUfAwNIjYV3
         W/hPULzPIbAO7GeYj9SQJlQXrNIBNZ23yxNo30QECLT8nS2m5kEZ/lw6h6rHxSjzpjgx
         yx8Q==
X-Gm-Message-State: APzg51ApD35Gn3mnbFGG7mVeMpM18q3aXGVV7oKShntqgT9BzXvgvuOh
        EOis1Qe8T4Rh5lTk9FV4hxn1DPedjKYaSBFxonI=
X-Google-Smtp-Source: ANB0VdY/HLdbdU7N2gKqUgVJGTnvcKc4YL9z6nHjiiaZkAp32JGiUDQP8a3WQB7b2lr36dhxxywk2TvKIeeAGhPgEmY=
X-Received: by 2002:aed:2b47:: with SMTP id p65-v6mr1247632qtd.132.1535458224882;
 Tue, 28 Aug 2018 05:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com> <1535453838-12154-12-git-send-email-sunil.kovvuri@gmail.com>
In-Reply-To: <1535453838-12154-12-git-send-email-sunil.kovvuri@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Aug 2018 14:10:08 +0200
Message-ID: <CAK8P3a0q0P-FuG6cTgMNkeZbtXE4pMk1iJq36_x20WRddtwaDg@mail.gmail.com>
Subject: Re: [PATCH 11/15] soc: octeontx2: Add Marvell OcteonTX2 CGX driver
To:     Sunil Kovvuri <sunil.kovvuri@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, sgoutham@marvell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 12:58 PM <sunil.kovvuri@gmail.com> wrote:
>
> From: Sunil Goutham <sgoutham@marvell.com>
>
> This patch adds basic template for Marvell OcteonTX2's
> CGX ethernet interface driver. Just the probe.
> RVU AF driver will use APIs exported by this driver
> for various things like PF to physical interface mapping,
> loopback mode, interface stats etc.
>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> ---
>  drivers/soc/marvell/Kconfig            |  10 +++
>  drivers/soc/marvell/octeontx2/Makefile |   2 +
>  drivers/soc/marvell/octeontx2/cgx.c    | 117 +++++++++++++++++++++++++++++++++
>  drivers/soc/marvell/octeontx2/cgx.h    |  20 ++++++

If this is a regular PCI ethernet driver, why do you put it into driver/soc
rather than drivers/net/ethernet/ ?

      Arnd
