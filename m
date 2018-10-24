Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF47BC46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BD82082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eh3TDTHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62BD82082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbeJXLUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:20:19 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46440 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeJXLUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:20:19 -0400
Received: by mail-oi1-f195.google.com with SMTP id k64-v6so2848348oia.13;
        Tue, 23 Oct 2018 19:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tnJTr6pRflEMEfp6xo/701AUEi8OZJzcxHw2leh1SWg=;
        b=Eh3TDTHFl5dJZ0DV5Kv8nQmBcTWii4ZnHo4hF7ojtlJOY/4s0qunJVZiQlLqs3+qtj
         HHWNyGR1ZFshhxN0y2MtObvN4MdZKwxS5cUSrCuKCuY4VHpoN/5GznSPw9F8P5M416bA
         Lz7akRfQ9nsGxmiWVOV27TAQdLP5SZGiQ0E3hC7oQRsl1W9RyCceW+2sXbojXNJcsv6J
         1YtySurbUnmExMXJMNZnaWEmdfxa8gnLv/Dr+AKmVO1uhIJrAh2GfDp/ItWvfpIIPBJt
         SlLGbD9u7vS8xteneZ9JqhK+vYD0qggZzvuS97TMlldfLnCdjriMU4PenrNqyV9Jrtgi
         xwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tnJTr6pRflEMEfp6xo/701AUEi8OZJzcxHw2leh1SWg=;
        b=YfVLgWmT2aeb5DdME9ZF657juTbb6Gyn/xWahKHWs1Mhl9U2w0mGfbcbv2xGft/7Yx
         2YGJW5GbKisflvQxFC1vZdKNjVkZNGvJIVA2WG6PJM46Q3PeQ1jVxQbdaBSpHGxcwTm+
         7G/lLi1BGrI8HCxkXKMh34N1GYhWMxp/95X9KLpiqTj93yIJOEQketIKp5EVqdclqwcq
         zYrU1voi8bG91I3oyhHjNoLOrRfeD+W+pwxhIFFufT1ye+LededoP3xG+sthPoDNKHHc
         HsdIYZ7wvVB8B0bmHn+ONQZQVaU8S3hoHkcAJVkpxxnj7G4iztRj6ZU8jJ/Cln2StVFL
         /BmA==
X-Gm-Message-State: AGRZ1gIzmNhI9d+MXlZ1/X5nmPF+hCSIswOruN8yjvrFj00mD1ZkSOur
        lijOyJCv+FP0MPd2NsFyLsiCTCMdzZM8f+tSex1O+mBF
X-Google-Smtp-Source: AJdET5cYqfOIbc6JnVuwb9Hw7I2JnPYn7daInPZrDYYpZ/hpj+TqbfBVZjhCmKe//DKQnXS1QGBkGby8/i5+ydXD4dA=
X-Received: by 2002:aca:538b:: with SMTP id h133-v6mr350009oib.355.1540345726141;
 Tue, 23 Oct 2018 18:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20181023011042.GA6582@WindFlash> <fe54aafc-1dbc-d4a1-96b5-37455595956e@koikeco.de>
In-Reply-To: <fe54aafc-1dbc-d4a1-96b5-37455595956e@koikeco.de>
From:   Leonardo Bras <leobras.c@gmail.com>
Date:   Tue, 23 Oct 2018 22:48:34 -0300
Message-ID: <CADvQ+rE0THV2ZYwGi2jxU3sNSQhPxurfTSqpf022s5OP7ftiGw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] Creates macro to avoid variable shadowing
To:     helen@koikeco.de
Cc:     lkcamp@lists.libreplanetbr.org, Borislav Petkov <bp@alien8.de>,
        David.Laight@aculab.com, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Helen,
On Tue, Oct 23, 2018 at 6:35 PM Helen Koike <helen@koikeco.de> wrote:
> Like this you are not changing the logic in this file, you are just
> renaming the variable which is more then enough to solve the -Wshadow
> warning.
> I don't it is worthy changing the logic.

You are right, that was what the patch was supposed to do. For some
crazy reason I must have submitted the wrong commit as a patch.

I will fix it and send you all a v3 ASAP.

Sorry for the inconvenience.
Thanks!

Leonardo Br=C3=A1s
