Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F50ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42E121527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AY9/dJ2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42E121527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeJQWiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:38:51 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:37482 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbeJQWiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:38:51 -0400
Received: by mail-vk1-f195.google.com with SMTP id y128-v6so6400184vky.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cJrE2Qzh3OxtNj3/H5AjSiQA8j0vne5WLIRPK7sC7qg=;
        b=AY9/dJ2B+w+rc9wAkXl/Wxtz3OkPxxsU1AuMPa5jHxl1duW94bzQ1Ntwsqdy2InXF/
         e6VhhDewvsY/gFTB3YVkxYT18nEuGrQ82b6skzXRDVrHDNGNSX/Dwaj200bcWyPrx6xB
         vj7XeKOUZkWDIXEq3DbW7k2zv38H6gecE7YlBQknrdDgoY8KEmM21T+CbpdaDr+JuTqm
         0ajRsSxO4tAqvLxH/Uao2ZuVOupy1O3dTCAQZSEh+PLNYu0vsWw3WJ2Jy1yCMnJNnYup
         8AYLudSYwAZQ2t/BL4p+3far3Ls98Mbd6STnBWfLSZFI2Q57yaNzuwXz0duBNgVm7MSP
         aDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cJrE2Qzh3OxtNj3/H5AjSiQA8j0vne5WLIRPK7sC7qg=;
        b=o3bMYITnKwj0qaX02ir8NzcUv/9z3hriiaVY6nEn+LHL6PpHEx0IaDGbUdlpaTU2B0
         nKrjOdDfHRe3ffgcJnqNDDd8rSyzGtQYxvlPQ2nXAa5IupcAYLpoiN8sAGLh5eaUChFN
         5NO1pQWwxPj+vmcxTqIjB3Ow19WViOza5qEKOi+PT29yWbQN1YqAkpjp3Q+jVFA17+xz
         GtohwfYMuwxqzwASubVbkyw7LoLq3ojQYrt5lFs5Y7vhpjAhrkShK+qmW/3TzyiZRG+F
         x3ogv8A5qoz7U+a4V6S28j8kn+B3om5GRM1nwIiCCu3fgnNdKvesbRyzmqeyw5NYoQPc
         QCYw==
X-Gm-Message-State: ABuFfojPCpyMpwGXahw74XYWkClkOywn9DJeHmDXvCgnP6Y+UtpSnnfQ
        yf4i5hv9d8owwp827OQc5T4t103Ve8UOHpa6TBw=
X-Google-Smtp-Source: ACcGV61/63Xp4eYXOprtB85lqwSLCPfuUB+tSzGdD4ofmCRXgvZ9EsDHKMXwokh9tzyU3NR53BmDOMPhhpqSoYf8nBM=
X-Received: by 2002:a1f:c146:: with SMTP id r67mr10660186vkf.90.1539787369665;
 Wed, 17 Oct 2018 07:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539781832.git.zongbox@gmail.com>
In-Reply-To: <cover.1539781832.git.zongbox@gmail.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 17 Oct 2018 22:42:13 +0800
Message-ID: <CAEbi=3dRLbC34uVuft5WsP7hrXnBHVFMxUyi8ZTexeAczRT3rA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Remove the no longer used mechanism
To:     Zong Li <zongbox@gmail.com>
Cc:     Vincent Chen <deanbo422@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greentime <greentime@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zong Li <zongbox@gmail.com> =E6=96=BC 2018=E5=B9=B410=E6=9C=8817=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:17=E5=AF=AB=E9=81=93=EF=BC=9A
>
> This patchset remove the no longer used mechanism as follows:
> 1. Reserve the TLB space for UART mapping during booting.
> 2. Assign a value for UART display when an error ocurred during booting.
>
> Zong Li (2):
>   nds32: Remove the redundant assignment
>   nds32: Fill all TLB entries with kernel image mapping
>
>  arch/nds32/kernel/head.S | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
Zong, Thank you.
Acked-by: Greentime Hu <greentime@andestech.com>
