Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7710DC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 09:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A33E21477
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 09:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wZ4bWC2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A33E21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbeHSMNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 08:13:21 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:56841 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeHSMNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 08:13:21 -0400
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w7J92QfO009764
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 18:02:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w7J92QfO009764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534669346;
        bh=ud2jxUGNb7B0eTnsCbjJQn9qJEuHNoTFrDsmx8Z05x4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=wZ4bWC2JsV27eIZ1auO+kaZgAmOvfxM50V7ANp/RNRNb8yz1fpcZdStnL/1Hgj5dF
         P4SuDg6ZCWQNhB8AuTDlgIeA5Oke6zaUpR9qowGF8FHtIfaNl/UJlCp9JRcJAK0of+
         2ZgCKb//KibaRjXl5lqg6Z+XTQmhFs1hyZg0eYU2w9pieD9yaU6Bw8XSZnBiqgNUGJ
         EMrGlC81AO4Zu42py//FmeWu8u2I4ajGiEppi5TPCP8jZ2p8xHtE28CPgNT76w1a7r
         bvFho+n4G5w79M5dHD5eXFFW9JCOyX4U9+4nMZvPTq6z/xjFpb7XutPejfZVRWSSI3
         QWo4nmx1xSbyg==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id u11-v6so8076832uan.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 02:02:26 -0700 (PDT)
X-Gm-Message-State: AOUpUlE8ynbYteBUR5aD8khE3JSK2Nuqo7Lws5e8HTuiyVIvS3+tH62y
        h+IuMERyp7hip6jhaG8qiA044HNLTdiFYc56B9E=
X-Google-Smtp-Source: AA+uWPwXIQVDpOq/KOBDc+KZvz+BT5JrUBIPF8lDdQIer06FUzKSz3OJbtbh6N7JaYIA8hDpVnk9DV/LqD1Jg9RRxEE=
X-Received: by 2002:ab0:1163:: with SMTP id g35-v6mr26832471uac.135.1534669345317;
 Sun, 19 Aug 2018 02:02:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Sun, 19 Aug 2018 02:01:44
 -0700 (PDT)
In-Reply-To: <1534600272-7685-1-git-send-email-zhongjiang@huawei.com>
References: <1534600272-7685-1-git-send-email-zhongjiang@huawei.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 19 Aug 2018 18:01:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR0CEBH78QgEyba69x2h72FSfSgctM_FCVHz65kfPnr=Q@mail.gmail.com>
Message-ID: <CAK7LNAR0CEBH78QgEyba69x2h72FSfSgctM_FCVHz65kfPnr=Q@mail.gmail.com>
Subject: Re: [PATCHv2] Coccinelle: remove pci_alloc_consistent semantic to
 detect in zalloc-simple.cocci
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-18 22:51 GMT+09:00 zhong jiang <zhongjiang@huawei.com>:
> Because pci_alloc_consistent has been deprecated. We prefer to use
> dma_alloc_coherent directly. Therefore, we should remove pci_alloc_consistent
> to increase the confidence.
>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> Acked-by: Himanshu Jha <himanshujha199640@gmail.com>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
> v1->v2:
>  - fix some spelling mistakes.


Applied to linux-kbuild. Thanks!


>  scripts/coccinelle/api/alloc/zalloc-simple.cocci | 41 +-----------------------
>  1 file changed, 1 insertion(+), 40 deletions(-)
>
> diff --git a/scripts/coccinelle/api/alloc/zalloc-simple.cocci b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> index 92b2091..d819275 100644
> --- a/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> +++ b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> @@ -35,8 +35,7 @@ statement S;
>
>  * x = (T)\(kmalloc(E1, ...)\|vmalloc(E1)\|dma_alloc_coherent(...,E1,...)\|
>    kmalloc_node(E1, ...)\|kmem_cache_alloc(...)\|kmem_alloc(E1, ...)\|
> -  devm_kmalloc(...,E1,...)\|kvmalloc(E1, ...)\|pci_alloc_consistent(...,E1,...)\|
> -  kvmalloc_node(E1,...)\);
> +  devm_kmalloc(...,E1,...)\|kvmalloc(E1, ...)\|kvmalloc_node(E1,...)\);
>    if ((x==NULL) || ...) S
>  * memset((T2)x,0,E1);
>
> @@ -124,15 +123,6 @@ statement S;
>  - x = (T)kvmalloc(E1,E2);
>  + x = (T)kvzalloc(E1,E2);
>  |
> -- x = pci_alloc_consistent(E2,E1,E3);
> -+ x = pci_zalloc_consistent(E2,E1,E3);
> -|
> -- x = (T *)pci_alloc_consistent(E2,E1,E3);
> -+ x = pci_zalloc_consistent(E2,E1,E3);
> -|
> -- x = (T)pci_alloc_consistent(E2,E1,E3);
> -+ x = (T)pci_zalloc_consistent(E2,E1,E3);
> -|
>  - x = kvmalloc_node(E1,E2,E3);
>  + x = kvzalloc_node(E1,E2,E3);
>  |
> @@ -389,35 +379,6 @@ msg="WARNING: kvzalloc should be used for %s, instead of kvmalloc/memset" % (x)
>  coccilib.report.print_report(p[0], msg)
>
>  //-----------------------------------------------------------------
> -@r8 depends on org || report@
> -type T, T2;
> -expression x;
> -expression E1,E2,E3;
> -statement S;
> -position p;
> -@@
> -
> - x = (T)pci_alloc_consistent@p(E2,E1,E3);
> - if ((x==NULL) || ...) S
> - memset((T2)x,0,E1);
> -
> -@script:python depends on org@
> -p << r8.p;
> -x << r8.x;
> -@@
> -
> -msg="%s" % (x)
> -msg_safe=msg.replace("[","@(").replace("]",")")
> -coccilib.org.print_todo(p[0], msg_safe)
> -
> -@script:python depends on report@
> -p << r8.p;
> -x << r8.x;
> -@@
> -
> -msg="WARNING: pci_zalloc_consistent should be used for %s, instead of pci_alloc_consistent/memset" % (x)
> -coccilib.report.print_report(p[0], msg)
> -//-----------------------------------------------------------------
>  @r9 depends on org || report@
>  type T, T2;
>  expression x;
> --
> 1.7.12.4
>



-- 
Best Regards
Masahiro Yamada
