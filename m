Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0240C3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 01:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3498024020
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 01:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="2U50+7VO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3498024020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753022AbeGEBuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 21:50:07 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:25982 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752899AbeGEBuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 21:50:06 -0400
Received: from mail-ua0-f175.google.com (mail-ua0-f175.google.com [209.85.217.175]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w651nwPY032613;
        Thu, 5 Jul 2018 10:49:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w651nwPY032613
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530755399;
        bh=dPw5icCY1OHC0A02yeu8P///ETQlEjvkdJYEkGoUytU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=2U50+7VOM1t1iCdeXNnAhIqwhr+xZl0+3VpK6CcolEyYobnyp9yVju6/tE1B4jxei
         aHhu3eoZxmyarSHKyA1YNNwrMuUv7rdFDg5F9vjo/Sv28f/78uu3CiRhGlA6XV+q4n
         kN/F33Ll+a7grTBnBxamiYopLXWgI0lhvRdNCNYEVzMyJdmy1psUKMQKLBruSA9OWJ
         ykR3U/ifQYMzxVF5fPIkdgpA/xjMwb9F1Pppo9OBItFVMjdAFnUTVO04kQwL25Jtx2
         yl2ZnglCfSP7ZqUisTN/viV20mm7KMH09QvDXVBeK1Ktb0KPfjKla9D1DE3GKBO3d4
         depkA2YH4VpdA==
X-Nifty-SrcIP: [209.85.217.175]
Received: by mail-ua0-f175.google.com with SMTP id q12-v6so4448589ual.2;
        Wed, 04 Jul 2018 18:49:59 -0700 (PDT)
X-Gm-Message-State: APt69E3V3aSXmWCAeR5ZVUmy1zXslmTSzIf8gIOwnfdKypRgHLutnSzc
        E5hRP3xQFIuzvw7z8IF7omj04Gy0CLDYNZQzMWo=
X-Google-Smtp-Source: AAOMgpfIea9b2FEBmlqkC0fu5wS6BFweBWPQxNXDnnOFF3XjCCZnaCt2i0o8Kn02K8Ja3afVX2u3xK+K8GM59rKDG2U=
X-Received: by 2002:ab0:e3:: with SMTP id 90-v6mr2283127uaj.52.1530755398458;
 Wed, 04 Jul 2018 18:49:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 18:49:17 -0700 (PDT)
In-Reply-To: <6477e1be-6686-582b-35b5-72e9f677619f@infradead.org>
References: <6477e1be-6686-582b-35b5-72e9f677619f@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 5 Jul 2018 10:49:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNATj1ibX=GMJ92fpX45Ba2WJKKb=h7_ZR9DeZcyBGcMHbQ@mail.gmail.com>
Message-ID: <CAK7LNATj1ibX=GMJ92fpX45Ba2WJKKb=h7_ZR9DeZcyBGcMHbQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: delete INSTALL_FW_PATH from kbuild documentation
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-05 4:59 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Removed Kbuild documentation for INSTALL_FW_PATH.
>
> The kbuild symbol INSTALL_FW_PATH was removed from Kbuild tools in
> September 2014 (for 4.14) but the symbol was not deleted from

I think 'September 2017'
although I can fix up the log locally.




> the kbuild documentation, so do that now.
>
> Fixes: 5620a0d1aac ("firmware: delete in-kernel firmware")
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: stable@vger.kernel.org # 4.14 and later
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  Documentation/kbuild/kbuild.txt |    9 ---------
>  1 file changed, 9 deletions(-)
>
> --- linux-next-20180704.orig/Documentation/kbuild/kbuild.txt
> +++ linux-next-20180704/Documentation/kbuild/kbuild.txt
> @@ -149,15 +149,6 @@ stripped after they are installed.  If I
>  the default option --strip-debug will be used.  Otherwise,
>  INSTALL_MOD_STRIP value will be used as the options to the strip command.
>
> -INSTALL_FW_PATH
> ---------------------------------------------------
> -INSTALL_FW_PATH specifies where to install the firmware blobs.
> -The default value is:
> -
> -    $(INSTALL_MOD_PATH)/lib/firmware
> -
> -The value can be overridden in which case the default value is ignored.
> -
>  INSTALL_HDR_PATH
>  --------------------------------------------------
>  INSTALL_HDR_PATH specifies where to install user space headers when
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
