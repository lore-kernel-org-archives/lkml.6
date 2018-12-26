Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2FAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34BC21720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fpP6v3CO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeLZNuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:50:10 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35175 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbeLZNuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:50:10 -0500
Received: by mail-it1-f193.google.com with SMTP id p197so20302175itp.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 05:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rpefWYxTp7K5+y32hWQHW+Yxgg8596jDt8IjeQS2Lqk=;
        b=fpP6v3COoYlw/6EUG8iSCrroLZuU0AFy683JPU7y+/A1Ebn10N4PMSziJfoZZly10k
         AZLDiBQ+2rb9bvHtooT/QrniD7nxa9w7F2RMZMnSDWstXLmRY8lc7vpXa3+HkhDHjW83
         WVm15pMZu7MkpEXzIXBqg52DVswYBTQQ6cPFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rpefWYxTp7K5+y32hWQHW+Yxgg8596jDt8IjeQS2Lqk=;
        b=HoCM5XPizXaN/h73LCNiva8XU6Sd3wOdUF3tOmo+PUy2UEV+1SMp1k+D7aBP5mWCqM
         wnodADtqsJaIW52nGW0yMaXFcBZNjpsGpxmH7gtv3UdVQ3LZP+FUrOch2K3wz/BtPiM0
         O/eaehvy7upcUBdPyoqLyaR7U3EXevsNScpIP38bke1PUtgRkRB/1HNUuSo7UoOx6sbq
         iNQGl3KRE0KkzVM/RxNqYL7FXb65KL1qvvhZVH1ebB7CB2yyHlXbo3yTg8tG1t8RpT8P
         vOLgLXUqZibKU5GoJCUCnjmSFoyVzBtTjsMTtyGRl6itA3MWEdOE4flTB8NQ9+nB/YGP
         pgVA==
X-Gm-Message-State: AA+aEWakePlgmcGZGBFnGPR/1JHu691MFOZi/eTVd7veiE1Ab549nJQH
        OFdTsQ3WWIR1Sk5yTO1k6AB1vKKKF48PtMEsrosx1w==
X-Google-Smtp-Source: AFSGD/V4qfZKQ3Fs601aUjLgQTZhbuWkbOlnZFz50z6f0mwRym+rcYpQfo+XD6WZnxI2SxfdoPoXr3oGnr8fsqYWLP8=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr14064037ith.158.1545832209400;
 Wed, 26 Dec 2018 05:50:09 -0800 (PST)
MIME-Version: 1.0
References: <BLUPR13MB0289A32373545C7FBE3400CBDFBB0@BLUPR13MB0289.namprd13.prod.outlook.com>
 <CAKv+Gu_m353cv=Pf2cEUDLn8=5YTLjLDDO23n=P14nWXydQWDQ@mail.gmail.com> <BLUPR13MB02892B82F5EB663B2FECF20EDFB40@BLUPR13MB0289.namprd13.prod.outlook.com>
In-Reply-To: <BLUPR13MB02892B82F5EB663B2FECF20EDFB40@BLUPR13MB0289.namprd13.prod.outlook.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 26 Dec 2018 14:49:58 +0100
Message-ID: <CAKv+Gu-YTdQmhU_br4amNZYn12=6Amr7w=wP57DyNn7_axptCg@mail.gmail.com>
Subject: Re: [PATCH] arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in
 linear region
To:     Yueyi Li <liyueyi@live.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Dec 2018 at 03:30, Yueyi Li <liyueyi@live.com> wrote:
>
> Hi Ard,
>
>
> On 2018/12/24 17:45, Ard Biesheuvel wrote:
> > Does the following change fix your issue as well?
> >
> > index 9b432d9fcada..9dcf0ff75a11 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -447,7 +447,7 @@ void __init arm64_memblock_init(void)
> >                   * memory spans, randomize the linear region as well.
> >                   */
> >                  if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
> > -                       range = range / ARM64_MEMSTART_ALIGN + 1;
> > +                       range /= ARM64_MEMSTART_ALIGN;
> >                          memstart_addr -= ARM64_MEMSTART_ALIGN *
> >                                           ((range * memstart_offset_seed) >> 16);
> >                  }
>
> Yes, it can fix this also. I just think modify the first *range*
> calculation would be easier to grasp, what do you think?
>

I don't think there is a difference, to be honest, but I will leave it
up to the maintainers to decide which approach they prefer.
