Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090E9C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3A62081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="NhhMOUaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3A62081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeJaAzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:55:49 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:23674 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeJaAzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:55:49 -0400
X-Greylist: delayed 87859 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Oct 2018 20:55:48 EDT
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w9UG1Huf027973;
        Wed, 31 Oct 2018 01:01:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w9UG1Huf027973
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540915278;
        bh=gxsTxRVsNBaDN5WHw2NyXWcrNlZfCDNMLpXBasA15/A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NhhMOUaOo5jSXN+Dx3hWNwUa+/b1+Ai1x8vC2iBajdvC2DivyZBWTQEDeSWjYcQn2
         cbHz8c3PPwfsw9c9gMTs0aO1rU64SxhSiJA/oVKwdkT7Iw8AdWdSUpc2ykloRmJWtE
         W43D3PzrafC7LvuJhCELxN5dim8em6KO3zuKTir7MGUB4NEjAdgqo/cqakAKdW6pvv
         WwqQIrYz74nONUSUlJMmbUrl8ZdruCdeG1UDn50XmQ6Xn6D3PO8AejFgdEu41/Fnm3
         8jejzqEOmbeWTx9hRvELM46FI2nD+yY6/hTs7OzluKC5Syjbi+/CPg4QqFxkgWkJ7j
         6vtki0cPQoPBQ==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id l6so8000291vsj.13;
        Tue, 30 Oct 2018 09:01:18 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJ08UHMBGHLKlAdcIPdy1sWW9yaFubYw6fPAHM6QPYz9OEJSZMU
        UGpcouGNUp7Of1m4YB1mBweBhWNRwVkJgeTzHXs=
X-Google-Smtp-Source: AJdET5fKOdL6drdx7QJiZXd6DD8CtdSvyQlYnb9dSrtvyJkWTaWKqdTK+fytOQn4JnbnkuTFUopU4I0qERiqqGGrT+w=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr8080376vsm.181.1540915277097;
 Tue, 30 Oct 2018 09:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <1540827688-15999-1-git-send-email-yamada.masahiro@socionext.com> <1540827688-15999-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1540827688-15999-2-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 31 Oct 2018 01:00:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNARQ2fJS95NevLpeo4duvOr3zbMm_xSBwc3_uAPr1SKKXA@mail.gmail.com>
Message-ID: <CAK7LNARQ2fJS95NevLpeo4duvOr3zbMm_xSBwc3_uAPr1SKKXA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kconfig: remove silentoldconfig target
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 12:43 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> As commit 911a91c39cab ("kconfig: rename silentoldconfig to
> syncconfig") announced, it is time for the removal.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.



>  Documentation/networking/ice.rst | 2 +-
>  scripts/kconfig/Makefile         | 9 +--------
>  2 files changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/networking/ice.rst b/Documentation/networking/ice.rst
> index 1e4948c..4d118b8 100644
> --- a/Documentation/networking/ice.rst
> +++ b/Documentation/networking/ice.rst
> @@ -20,7 +20,7 @@ Enabling the driver
>  The driver is enabled via the standard kernel configuration system,
>  using the make command::
>
> -  make oldconfig/silentoldconfig/menuconfig/etc.
> +  make oldconfig/menuconfig/etc.
>
>  The driver is located in the menu structure at:
>
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index 5d37a60..63b6092 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -68,14 +68,7 @@ PHONY += $(simple-targets)
>  $(simple-targets): $(obj)/conf
>         $< $(silent) --$@ $(Kconfig)
>
> -PHONY += silentoldconfig savedefconfig defconfig
> -
> -# We do not expect manual invokcation of "silentoldcofig" (or "syncconfig").
> -silentoldconfig: syncconfig
> -       @echo "  WARNING: \"silentoldconfig\" has been renamed to \"syncconfig\""
> -       @echo "            and is now an internal implementation detail."
> -       @echo "            What you want is probably \"oldconfig\"."
> -       @echo "            \"silentoldconfig\" will be removed after Linux 4.19"
> +PHONY += savedefconfig defconfig
>
>  savedefconfig: $(obj)/conf
>         $< $(silent) --$@=defconfig $(Kconfig)
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
