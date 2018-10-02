Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDE3C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FC22089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="FeHDbj3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2FC22089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeJBQb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:31:59 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34822 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJBQb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:31:59 -0400
Received: by mail-it1-f194.google.com with SMTP id p64-v6so2791077itp.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 02:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KzCEdtQlFOxMLkYc0IFV9fkYrkmzrLbOPzy1BSQ4fAc=;
        b=FeHDbj3M/I4sHs1Ocuk2pVmFTC85VMiJFkC9dnF+B3O9OONUOt5A8hOTGtOBsQrIzq
         +J84IR5ngGVL7trF+dJnS3AokkenRCrPCxI4VeAUxaOmmFqLmS5H3/lgWZFAqsQfkxFd
         E2DNF1dL3EuEe153MsSYoJDHPLQE4KrfVOm61usMuZWh8piGiZ4XXk8QRkOnkIzapMUN
         QjL1o3YrWUUTigyQ87DoqL14chaMOPJdGLjOLqhQ+8vb5zS2EyDxBffxrP6dm4FkGLWf
         jG6GedgruoZzUAEN6XIZFIIAOVo1ssgtIG8v8rXRK1ZbFNOGitapebqTnewLVPfFp1BP
         gvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KzCEdtQlFOxMLkYc0IFV9fkYrkmzrLbOPzy1BSQ4fAc=;
        b=MeIOukbY9FvI6YXKMFaClE7uew0ESvYjNQdfmP7/t5a9JBCp+wPVBr1hk44LFil98t
         vb+yOI8jfY3zRfVMyqgB/HCAyvDuB9uL+C/bWKgGkv6k3+IuL2Am3xAZSOjLrjMKkSk2
         6/buuq6WkJhgt5L46mQeWVYh0LXDXB5g/ZH2fSqgoHfjEX63mVn3EzCZLkCCHfZgujc8
         nPAXdGwgOX0ePJICJt3WqtgqZu2470TS4HLNjZWgn7dWmSN1L0+AMqcBWwXXS9PtYXqB
         y2mcRytTvi1uqr51pbYIlnB//SM6yWWubvCFT9eONBPQq25bRRJ45HdAX7uSIb2gE8TO
         zmhA==
X-Gm-Message-State: ABuFfohgpoYnLhMJDRxYoYyuNuDKgejmvS/Y/PZKbpm8i+oqNypyyNQN
        g0TlaQuwGwMZtfYjByY9cE08yHRzl53ranYlF2/UEg==
X-Google-Smtp-Source: ACcGV61unr9FIKFqZU5McG4qS2ULWTuPF/x7OYXZ8L4rHYVgrZ/iw+jHAQwWYC5/lQR5hDpZNNNFpKHyr6RX7C5jG5o=
X-Received: by 2002:a02:1e94:: with SMTP id 20-v6mr11578152jat.34.1538473774002;
 Tue, 02 Oct 2018 02:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181002191236.0aa50539@canb.auug.org.au>
In-Reply-To: <20181002191236.0aa50539@canb.auug.org.au>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 2 Oct 2018 11:49:23 +0200
Message-ID: <CAMRc=Mf64AMBiMwBTCYeG18txVqbdvkQA35ZyZuRtwOCe70RpA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the char-misc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-next@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 2 pa=C5=BA 2018 o 11:12 Stephen Rothwell <sfr@canb.auug.org.au> napisa=
=C5=82(a):
>
> Hi all,
>
> After merging the char-misc tree, today's linux-next build (i386
> defconfig) produced this warning:
>
> drivers/nvmem/core.c:496:1: warning: 'nvmem_find_cell_by_index' defined b=
ut not used [-Wunused-function]
>  nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
>  ^~~~~~~~~~~~~~~~~~~~~~~~
>
> Introduced by commit
>
>   e888d445ac33 ("nvmem: resolve cells from DT at registration time")
>
> --
> Cheers,
> Stephen Rothwell

Hi Stephen,

this looks like a false positive - this routine is used in
./drivers/nvmem/core.c at line 943 in this revision.

Best regards,
Bartosz Golaszewski
