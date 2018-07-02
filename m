Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A57C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7FF2555B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="At1Eau7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7FF2555B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932357AbeGBBYa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 21:24:30 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:30285 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752972AbeGBBY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 21:24:27 -0400
Received: from mail-ua0-f182.google.com (mail-ua0-f182.google.com [209.85.217.182]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w621OCLH027151;
        Mon, 2 Jul 2018 10:24:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w621OCLH027151
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530494653;
        bh=kkXSgbwywCWqHPfSqYBOpHe/7IRkYKuujUtPuk9FFXo=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=At1Eau7VOPX6xTv352NWsBLp720R4dD3c8peFf9M5SIRLg2TxVfJYXzvcL7Ma5Sf/
         VdjomtsjJ+MqcFCZIsBHP6p3DzRBSas7WwBof5H5MynQFBEYgbr7AgBgdhAp2f9P9Y
         t42T4U+6bbFhW0C9QxnVKYSJq1zDBmYpqXvn5HD7y/t3rLkxA36gDCmeIaNp34TUok
         VIW/ogsfytTRD6ldCvVEMqs3hxhmz1WpC2hdWbSW+RUooZqINpyodQUsw2naHsjGQ9
         nQ2rGeKW5ovoPimTnrlD4fpU6PmQxhKNyS/ZYgHFJ6aPvvsbdpuuEuNLB3xUeQpyvy
         kc2tXnY5grJRQ==
X-Nifty-SrcIP: [209.85.217.182]
Received: by mail-ua0-f182.google.com with SMTP id g6-v6so9070709uam.2;
        Sun, 01 Jul 2018 18:24:12 -0700 (PDT)
X-Gm-Message-State: APt69E01eKG66jiYrD95GMysHSSgWFNOmI1CbpQ3SGT70ABfa0RQBqg2
        SXUwwVLcL/k+OGX155GV/pdfB29j48HlJrQ9AqU=
X-Google-Smtp-Source: AAOMgpe3CTIMnMPt2FEoY6sZVMRNhlCC0KjP5QbzVBnCWKcfPho6hSzB6n7/haqX+n7XqWRLw6xoCSbxXP1vo8o7jiY=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr2044684uaf.199.1530494651935;
 Sun, 01 Jul 2018 18:24:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Sun, 1 Jul 2018 18:23:31 -0700 (PDT)
In-Reply-To: <1df7f847-484c-a368-9dc2-50d191f8be9b@infradead.org>
References: <1df7f847-484c-a368-9dc2-50d191f8be9b@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 2 Jul 2018 10:23:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQh9jgxTYTUue7j9QjkFmUV-cdLGvMpGhrjivU1km7cWw@mail.gmail.com>
Message-ID: <CAK7LNAQh9jgxTYTUue7j9QjkFmUV-cdLGvMpGhrjivU1km7cWw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: check for /sbin/depmod installed
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Michal Marek <michal.lkml@markovi.net>,
        Chih-Wei Huang <cwhuang@linux.org.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-02 2:12 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Verify that 'depmod' ($DEPMOD) is installed.
> This is a partial revert of 620c231c7a7f (from 2012):
>   ("kbuild: do not check for ancient modutils tools")
>
> Fixes kernel bugzilla #198965:
> https://bugzilla.kernel.org/show_bug.cgi?id=198965
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Chih-Wei Huang <cwhuang@linux.org.tw>
> Cc: stable@vger.kernel.org # any kernel since 2012
> ---
>  scripts/depmod.sh |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> --- lnx-418-rc2.orig/scripts/depmod.sh
> +++ lnx-418-rc2/scripts/depmod.sh
> @@ -10,10 +10,16 @@ fi
>  DEPMOD=$1
>  KERNELRELEASE=$2
>
> -if ! test -r System.map -a -x "$DEPMOD"; then
> +if ! test -r System.map ; then
>         exit 0
>  fi
>
> +if [ -z $(command -v $DEPMOD) ]; then
> +       echo "'make *install' requires $DEPMOD. Please install it." >&2



I think depmod is required by 'make modules_install'

Is there any reason to make this ambiguous like 'make *install' ?




> +       echo "This is probably in the module-init-tools package." >&2
> +       exit 1
> +fi
> +
>  # older versions of depmod require the version string to start with three
>  # numbers, so we cheat with a symlink here
>  depmod_hack_needed=true
>
>



-- 
Best Regards
Masahiro Yamada
