Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D3BC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA932089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="HlwdzP8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA932089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeJCOG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:06:26 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34751 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJCOG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:06:26 -0400
Received: by mail-io1-f65.google.com with SMTP id k19-v6so4224607iom.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 00:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dk+5GMIbCAeOVq2ic0sJhFpiIFoj4BpxUB2q5E1Rfo4=;
        b=HlwdzP8IysocVtiQi3swLgQ8VCqLjSNMVdWxE4FqhoSTR5CNnANecTM7wqzh1REIc4
         AO1YRW6HX+3R5to1n1anlAUGUFAwlqgR9DHsKDnV0H2cfdkuMC1aKZt6EQvcTg+RjZCT
         UuC+mdyFzJqHTyeSK8WRx9X9w8gs7bXMEI0mxlYwBcU0jmIegwVCxh5D6i3RU7YCTAGQ
         qegk5vohDl+4OHaqLVdkY6PSK/G3GgPV1cr2i/JfP7TG7rDZb/7eEgsR/Y6ksClOcJFk
         ZJiHezLKj1wByT8f/E5Yse1yXmAUMcQecneiYnWtA7UIY36fi0nK9uIb5eU0+hDLu6zk
         K3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dk+5GMIbCAeOVq2ic0sJhFpiIFoj4BpxUB2q5E1Rfo4=;
        b=XCeASxAUcxVIQrj4aONc0M8pr+n7bqIBK3N4URBNiClH00pcCl23cShd44+3vaMSmT
         TKg32AW7KY3YBMsNiZPlUS5ca8gZbaOj14kZdiQcga44J5TULMenrFvMVfLkBNePq4j9
         rcUosuqTAV8P9q7StDXIFjIfwzuEnaQuoRXdxVWmkuLUzjWpEns3hx8wbp7U2oygFA2J
         PgciCJehK8M9bdhkxe468Y2wOdhUTbdGWFR3MEZtHZuqQTX6IQAl6G9nC145w4s1QuGe
         LycTKq3tb0IrC/97tHfhQ29Hv6U0aD6tkhyHUSoprk6nt3MDYQx23rw4ZhsTp5EG+UGU
         wKaA==
X-Gm-Message-State: ABuFfog5ojOeKGyvwURXtnXRrRRFiXltVsacaYdltrC7/N3O16lTa4zQ
        G6051H/7nwgBDlUvjZMYuNaAMSYMy7fxJp6ujzhbrg==
X-Google-Smtp-Source: ACcGV630J2HxRFURGxwRnzO5yQ7NfXHJBxUB1iZPlEZN59Qb1yDEuYsz9tw6E5oMd1UxhWuLPmwP7uQp92916NfuUC8=
X-Received: by 2002:a5e:9e4c:: with SMTP id j12-v6mr100495ioq.111.1538551159065;
 Wed, 03 Oct 2018 00:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20181002110246.3175-1-brgl@bgdev.pl> <20181002222642.GA19204@kroah.com>
In-Reply-To: <20181002222642.GA19204@kroah.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 3 Oct 2018 09:19:08 +0200
Message-ID: <CAMRc=McWEbQ6H2TYmEkOkV+y5o-L1MmQT0yHw-HCS6=X-__SxQ@mail.gmail.com>
Subject: Re: [PATCH] nvmem: only build nvmem_find_cell_by_index() if OF is enabled
To:     Greg KH <greg@kroah.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 3 pa=C5=BA 2018 o 00:26 Greg KH <greg@kroah.com> napisa=C5=82(a):
>
> On Tue, Oct 02, 2018 at 01:02:46PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > The following warning is produced when building nvmem core if
> > CONFIG_OF is disabled:
> >
> > drivers/nvmem/core.c:496:1: warning: 'nvmem_find_cell_by_index' defined=
 but not used [-Wunused-function]
> >  nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
> >  ^~~~~~~~~~~~~~~~~~~~~~~~
> >
> > This is caused by the fact that the only caller of this routine is
> > under an ifdef depending on this option. Fix it by adding a relevant
> > ifdef to the function in question as well.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> No "reported-by:" lines on this and the other patch?
>
> Not nice :(

Sorry, I normally remeber about it. Anyway Arnd sent a better
alternative for this one.

Bart
