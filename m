Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B327CC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 15:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3F72081D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 15:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxh/CCk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3F72081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbeKDBLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 21:11:04 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33635 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbeKDBLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 21:11:04 -0400
Received: by mail-qk1-f196.google.com with SMTP id o89so8044522qko.0;
        Sat, 03 Nov 2018 08:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i3t/kVJZs9wE5k/7u3YIlKV520CtDAoBfksKFEz0pEU=;
        b=lxh/CCk8ZUEiVcuh9tLOES3d85vON74pE2K76Jqw0ATjziAzsPCFRQV861lvJmRjK8
         AB/jMbUPXxFAyCBOL/5se8N+ZNdMARLcCXBSfGjED+soq56DOqguTs6mJ9e1Pw7hduEK
         30P3UHfDEQtQcV+dl9KudibukIX1KoCvcQzcsLXTbjyQz4Uo8Zka2NYSYscN+GuR80Xe
         i5U1O0BM7l9PL+CFwJbIi8qOdGRQ9Wf78AXYKEbvU3LfROrEk3hD2xLsiaHhAKkKPSyi
         Fqdltr6RRJgMGtj0PT1NB3Z90gCyYxrB7uwoYIBBUfl1CPfFTkWiRvgqN5sHr8GTRJ9e
         CsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i3t/kVJZs9wE5k/7u3YIlKV520CtDAoBfksKFEz0pEU=;
        b=pD6DbcsEgCVVlfUj68WfG3BQK5XxWAkLS5t5W+0WmIsgaqU9Sl+7Rst/7+OJxbm2hm
         XWZ91nfFjsxjVDkOTJTWjlVrD7CQtvwNGXt12BZOuD3PGuHRHVMsnJYvm2DLjUwGfIM2
         puVBKxlDwxFj41RPxmdDzimx+L/mQz1Taqkryx1628uo/AHRgB5rPblaoFOdcF3M5y0w
         rBfXzn7ga6RAKQMQ4jriCfVaM6mgJuaD2FEp0r3hrKQ+E8kTjTOyHLtdawcwUjq5C/ZD
         bunQn5EGjKptZq8LQc9Ckorb9jppqpmxBYkzO4lnKELsknUx3okad/TzCeeu+yae5iNN
         GBfQ==
X-Gm-Message-State: AGRZ1gJSu1ry7qTiGF2ImSgb8Tnl2Tm3UZyEpnbTMFd4+RlgDA1bcI2J
        5cN3IT0jzaMI+oUFYhw9iRQ=
X-Google-Smtp-Source: AJdET5daY5DxW69MxgCS6oFFTyFGbQycoTI+CSc61+PZZhtCFntsVHcZi9fzW9mFIOmNJCKv6W3WUw==
X-Received: by 2002:a0c:80e7:: with SMTP id 94mr13597416qvb.97.1541260762119;
        Sat, 03 Nov 2018 08:59:22 -0700 (PDT)
Received: from renatolg ([186.220.24.65])
        by smtp.gmail.com with ESMTPSA id j32-v6sm23005198qtc.59.2018.11.03.08.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 08:59:21 -0700 (PDT)
From:   Renato Lui Geh <renatogeh@gmail.com>
X-Google-Original-From: Renato Lui Geh <renatogeh@renatolg>
Date:   Sat, 3 Nov 2018 12:59:16 -0300
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: [PATCH v3 1/3] staging: iio: ad7780: fix offset read value
Message-ID: <20181103155915.32wgi6ybkvhr5qzb@renatolg>
References: <cover.1541082656.git.renatogeh@gmail.com>
 <2191be4d531651db39682178ec0660eeb5697439.1541082656.git.renatogeh@gmail.com>
 <17254fcab5fb927e31ba6eac2194b0aeb9456cf0.camel@analog.com>
 <20181103130721.53a806a5@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20181103130721.53a806a5@archlinux>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>On Thu, 1 Nov 2018 15:02:32 +0000
>"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
>
>> Good catch.

That was actually Jonathan's catch. :)

>> Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

I read up on Acked-by on the kernel docs, as I didn't know exactly what
it meant, but I'm not so sure on how to proceed once the patch has been
acked.  For future patches, do I add this Acked-by line on the patch's
message body? Or is this just an informal way of approval?

>On the basis this has been broken for a long time, and you are clearly
>doing other nearby not fix work, I'm going to take this through the togreg
>tree rather than via the quicker fix path.  It makes my life
>easier :)
>
>Applied to the togreg branch of iio.git and pushed out as testing for
>the autobuilders to play with it.

So this means I should skip this patch on v4, right?

Thanks,
Renato

