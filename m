Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655BAC282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 02:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9E420863
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 02:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549075568;
	bh=+bauYQgGt9y/bO3rfz8EiSo6T2dSClroFuD/VUPk+GQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0ZFK9r0mT/QzG2VaCL16m+z/GeImZZve3ecDm91fVgCI867gki1gZrVPt5/2upPpj
	 2CaT/oQ0mDl/1T4S3DbxmM/qdzrJTodvN1OZNYNFlylNcEE0nhYBjryNK9waWjCvNW
	 3gAp5Gc9GRnE1TkX8mxzxWYNBhdXqAin33B+ToN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfBBCp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 21:45:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:54166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfBBCp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 21:45:58 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B247C21479
        for <linux-kernel@vger.kernel.org>; Sat,  2 Feb 2019 02:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549075558;
        bh=+bauYQgGt9y/bO3rfz8EiSo6T2dSClroFuD/VUPk+GQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TZRGwIBDKu+zlRJlEkdKwGhbTxkT2+6Cng5GPe2wLPrakAegOTrwg9bCHA+IwyjNL
         K7QdK9O8axhnH3kFBUdYOx428hm9B9hdp7YW7m5FN4wU/tts7oNJoVUep/KYmUZHLe
         9akBXf1jVq0YNXKZ5rsrRRT/CxYFIHge3xzFp0c0=
Received: by mail-wr1-f45.google.com with SMTP id t6so8995790wrr.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 18:45:57 -0800 (PST)
X-Gm-Message-State: AHQUAuYcfbx3MIHH5zACRXd1GosAiMHTh7kz1f43gZzKSZMdlNUuUC0S
        yK7dDvO/tp0u0hgA4sqNG+qm01ybAdUJiI4pde22Ug==
X-Google-Smtp-Source: AHgI3IYR2d4/pyE6JV9aOhmKz2yP8nolbhcaICGbWSv2x3V23pMNGL7WWFkgSfEAnBzOEgiezauWKMfR9ncfwQr3o+0=
X-Received: by 2002:adf:eb4c:: with SMTP id u12mr151588wrn.199.1549075556154;
 Fri, 01 Feb 2019 18:45:56 -0800 (PST)
MIME-Version: 1.0
References: <20190201205319.15995-1-chang.seok.bae@intel.com> <20190201205319.15995-4-chang.seok.bae@intel.com>
In-Reply-To: <20190201205319.15995-4-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 1 Feb 2019 18:45:44 -0800
X-Gmail-Original-Message-ID: <CALCETrVcY4VhOX5DG7dwoy6RgiQ3iZCZ_h_dXP_5RuuRuoChfQ@mail.gmail.com>
Message-ID: <CALCETrVcY4VhOX5DG7dwoy6RgiQ3iZCZ_h_dXP_5RuuRuoChfQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/13] kbuild: Raise the minimum required binutils
 version to 2.21
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 12:54 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> It helps to use some new instructions directly in inline assembly.

akpm, can you ack this patch?  AFAIK you are the only, or at least
most vocal, user of ancient userspace to build new kernels.  Are you
okay with this?

>
> Suggested-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Linux Torvalds <torvalds@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: H. Peter Anvin <hpa@zytor.com>
> ---
>  Documentation/process/changes.rst | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> index 18735dc460a0..0a18075c485e 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -31,7 +31,7 @@ you probably needn't concern yourself with isdn4k-utils.
>  ====================== ===============  ========================================
>  GNU C                  4.6              gcc --version
>  GNU make               3.81             make --version
> -binutils               2.20             ld -v
> +binutils               2.21             ld -v
>  flex                   2.5.35           flex --version
>  bison                  2.0              bison --version
>  util-linux             2.10o            fdformat --version
> @@ -77,9 +77,7 @@ You will need GNU make 3.81 or later to build the kernel.
>  Binutils
>  --------
>
> -The build system has, as of 4.13, switched to using thin archives (`ar T`)
> -rather than incremental linking (`ld -r`) for built-in.a intermediate steps.
> -This requires binutils 2.20 or newer.
> +Binutils 2.21 or newer is needed to build the kernel.
>
>  pkg-config
>  ----------
> --
> 2.19.1
>
