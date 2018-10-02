Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEB5C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93292064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="McwvHDAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93292064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeJBPQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:16:59 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53651 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbeJBPQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:16:59 -0400
Received: by mail-it1-f195.google.com with SMTP id q70-v6so2371334itb.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 01:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d5rdZAktQuzU8uR4KpGHMHjX40ZqbOf/wvqjZLY4Mig=;
        b=McwvHDAUNy6CbGjCJzeKeMcAxM1XfqXKIyY7+bT78RmiKnHMcMloOEuKwu68OB3qls
         6D81U5mXmVvoGeKzmbFnCwh6x3cQeukXXdNekewSsHIcUz2dQPAPtV3OBbnCjz+AhIcC
         /NatYgYJEupL/+bIdnMmev1SOzuVn081kkvEQ1i8KFCObIQpw8hop+oMv8gwIB6KIcuz
         su+Yyt1BpHtFLMMkmmVx84IeevJ6UkifbnnKtVC6RIEgdGP+tb+yYEYZEHAMC7+Rw1Bz
         obD77hzMQrhB5T+naoy77C1VIR5KfGrMJqgOcdJXx8V3sBfpWuPuPgDoxuzYoZT26fUm
         37ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d5rdZAktQuzU8uR4KpGHMHjX40ZqbOf/wvqjZLY4Mig=;
        b=N1hXCgopOnoOXXntSzBbc3ZSDyPig2LvLo3+JZtNgTJDimhKtfqCSGXA26gN7ToAxs
         1uKE/lj2ADgtMeebkGj2DgLW6qQjwQwniSmB+tHC7qPKZleW87S50ozxsyokKt6waNnG
         awBg7Fx3cqvsYEHG6rDqS57inXtiWCxR1ekY/OSngEge7+bhFfmshhfYUXIkpwVYyeTa
         b3wCukD5Nec6aNaR+6NgQ4DB1RqVi7kHNGRHEc5KzK9P/v+MNS8tSxGkbsWTq0D4xKiC
         4iQ00pV06FkORWSLhYE51tiQcDwQyc0HOtD7kQqTpb7RxOyxEKVtOokM/I8htuSazRRL
         96Nw==
X-Gm-Message-State: ABuFfoghv2bRpUhkR17aYWZV+tp2bAu1vs7F03f9zgqWW7JOCP2Q+s7d
        ehYSkLvJa2d4u2QzQCNdfQ6xVgOP9WHybaOBbwsEiA==
X-Google-Smtp-Source: ACcGV624Ht2ARvMTE1l4kw961mBgwjZSRUqtIqHM5zwYAiB8WrOqCBrT4EBZsJfvfTqjBm5BKQT2gAOcNrslv3Dj/T8=
X-Received: by 2002:a24:6f05:: with SMTP id x5-v6mr1203044itb.111.1538469292337;
 Tue, 02 Oct 2018 01:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181002153149.2a312771@canb.auug.org.au>
In-Reply-To: <20181002153149.2a312771@canb.auug.org.au>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 2 Oct 2018 10:34:41 +0200
Message-ID: <CAMRc=MfGZ2txjBNJAePwabGoCCVY0U1X9vvYivQb_LusDnsvgg@mail.gmail.com>
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

wt., 2 pa=C5=BA 2018 o 07:31 Stephen Rothwell <sfr@canb.auug.org.au> napisa=
=C5=82(a):
>
> Hi all,
>
> After merging the char-misc tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
>
> drivers/nvmem/lpc18xx_eeprom.c: In function 'lpc18xx_eeprom_remove':
> drivers/nvmem/lpc18xx_eeprom.c:258:6: warning: unused variable 'ret' [-Wu=
nused-variable]
>   int ret;
>       ^~~
>
> Introduced by commit
>
>   226014d13fa5 ("nvmem: lpc18xx_eeprom: use devm_nvmem_register()")
>
> --
> Cheers,
> Stephen Rothwell

Hi Stephen,

I'll send a follow-up to fix this.

Thanks,
Bartosz
