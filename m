Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0539BECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B279F2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLhGnrGQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B279F2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbeGMTGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 15:06:30 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39201 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbeGMTGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 15:06:30 -0400
Received: by mail-lf0-f68.google.com with SMTP id a134-v6so27964127lfe.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 11:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kWO4ljyC/EJMbuhdilf4LrLkdeTxvsBXKYbxYcf4Uno=;
        b=XLhGnrGQ1PKFu9JO6cFqGWB7psdBaVCFQRbo7pMV5Z5gHvvzL6uP7j/pKC4IKFgxZU
         k6tjkKCaR1vCAGOOdr4Q/PrrssFQWsJH18eV8nYdtFnUP2tgoAnkFDgKxGgrnSA7ADoF
         2G4GBwWBZ4sBWcfkcis/4EYjkOv9L9g/+DkEMDDYhXqyOyW/piquBtYTQ92vwDsKl3Jf
         7PBDlImqSY+Z43cgGofnd7ioCq++kttM/wmYvLdrKcNxy4MN4qplmMm9inp6f7nVYuuF
         vdOM3j0QXjAK9M8RH6rXlaiRqJ2uPjM4KwZlg7xSt0DpNL1Bbxibc8VUL9lsO6OCe5e1
         jCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=kWO4ljyC/EJMbuhdilf4LrLkdeTxvsBXKYbxYcf4Uno=;
        b=o5hiHHU+r4U3STt6FsCzePlBny92k8oorsi3zmBTmSzWObJ27zRBijpzHiR8V1e75C
         dIUUxHPVZn3HDc7Anl/xR3AGKoRi5qBeOA3CnQK2i2OTcxUV2lzqZ6FsXzPA/yDKn8g4
         7ANoXMJTeOcYF7V+uNB1MvpStI9yilqIk9AFs67+//a8ek3btbTQQxab8KAx+xAMKnDC
         UimxeqjeEcP0jAM0AgCVP4T6v+4vmBoKWncbuaJYjCDk0qxm6ap8z7H2gdQridtFQGPC
         LWaIdRsOgNSTFGrG8t5KaT8R86srFoh7mykTst/teN/jZ8g3qSLPgQNKS0l0eRdYiSjD
         QG9w==
X-Gm-Message-State: AOUpUlGTGqTa7ZdAkblXPpt5+cNVFT3/H8cw7WedoOpU9snfPmFpv1cp
        1EeXEAnMaiFS761ypHFxoOmHRbcPJw3cEyY/HD0=
X-Google-Smtp-Source: AAOMgpehc8qCUFtmB/lkp7ZQ6NhR0aBWLzJNbG+Ra4RCppp5qoM7S9bnpPmc+vhIFKxCvpNByBddbkDSoNvmSN6Pqhw=
X-Received: by 2002:a19:b24e:: with SMTP id b75-v6mr5489776lff.11.1531507837578;
 Fri, 13 Jul 2018 11:50:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 11:50:36
 -0700 (PDT)
In-Reply-To: <20180713161006.GA40688@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180713143800.3146610-1-arnd@arndb.de> <20180713161006.GA40688@jaegeuk-macbookpro.roam.corp.google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 13 Jul 2018 20:50:36 +0200
X-Google-Sender-Auth: FjZydIT2e2DpOGd1os8DocdtY40
Message-ID: <CAK8P3a2St2AG5Vm2iwHHuaMuM-fkwjz2i-_oL6WR26FdGuEYkQ@mail.gmail.com>
Subject: Re: [PATCH] [RESEND] f2fs: use timespec64 for inode timestamps
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Sheng Yong <shengyong1@huawei.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@google.com>,
        Yunlei He <heyunlei@huawei.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Yunlong Song <yunlong.song@huawei.com>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 6:10 PM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> Hi Arnd,
>
> I queued in the testing branch, since I'm trying to fix another issue in -next.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=2cdbbf025aac9f3dd54b9dec0a6603839a3171d3
>
> Allow me to merge it in -next sooner or later.

Ok, thanks for the confirmation that it's merged. I didn't mean to rush you,
just wanted to make sure it's not lost.

       Arnd
