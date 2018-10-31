Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB85BECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9822084A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ae2nWRaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9822084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbeKAIY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:24:28 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42080 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729429AbeKAIY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:24:27 -0400
Received: by mail-qt1-f193.google.com with SMTP id z20-v6so19177919qti.9;
        Wed, 31 Oct 2018 16:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jstt/NuaoXs95PZH7TPaxy0ZuXgof9oFVKJ51mpMNC4=;
        b=Ae2nWRaWGWjD2RV3tBi6ThvDV+dSFtjEN9plfOVZjQy7c3RHO63QRaVvUQbbn9QhEa
         OlK+CmXYg/lC+Sp7XTuuUEO0iz8/Z+kLCEh/wsNTtWkB51xqoQtSOH/zZ+LfBpXL+BP4
         Sttkc6d88AFZv8Pv79lWYWEJq0tuJOih8o8BLLNWry/Bcx8AYqmjZMY3G5LoIVAAflod
         DS0awKMhTNxpk7QiFVAa73XVv9KtxXt+juj9Nvhact7VzOOhsnqDhO4DZ++XXt5gyMlp
         +XYjGLwK6P0CBObdzugnSFhqJU//D0qXxv8BnZn7Jzyco6WrONWLVht/VZuqz36fEi27
         76xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=jstt/NuaoXs95PZH7TPaxy0ZuXgof9oFVKJ51mpMNC4=;
        b=RzwH9SdIZniN0EDIi08fcSKXuRGab1sx88sXEsY4hobz4yZxWa0C2vYUHl763nbWi4
         P5QjLvk/Q5gnc9jfb+ptLRo3NX3Sl7RppHTPiDBTaO5Ep1/cCkSxJuGAnr2fZ6Vyr6gt
         s+QV1cMIEqPREbfyi8Oo9lg3yWMmJJC4CUKJY6L6bBlx7cizH3nSsSCg7GrYczvN2Fkw
         5Y2nClX+7OvahOkTk/PG9TvyfX6LHX7mLqXTUh53tcWOO3w6jtqZKvzAoHUrMA0pB2cv
         uHrs+cU88T35Cbll73LCM9Vhk61QwHnFsIrWRtiETa2r/eamv+iida5UktOvgvKohanV
         VENg==
X-Gm-Message-State: AGRZ1gK13IrP6tkkAEx2tQDkU9D6gHCNGLNtuj0pZerVlDXfcbmOuWei
        WCaVJzc5trwHs9Samitcvhc=
X-Google-Smtp-Source: AJdET5cKDIoDb+38c26rewjmEMqRN+Uig6yIvHBLYNvWHyGigez01SMP1I3htKy4yZ/vLa/rgTHe7Q==
X-Received: by 2002:ac8:50b:: with SMTP id u11-v6mr4628570qtg.366.1541028251002;
        Wed, 31 Oct 2018 16:24:11 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id 88-v6sm2972381qte.6.2018.10.31.16.24.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 16:24:06 -0700 (PDT)
Message-ID: <16b6518d7b36787e1813d62336b661bf603d54b2.camel@gmail.com>
Subject: Re: [PATCH v3 4/5] modpost: Changes parameter name to avoid
 shadowing.
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     lkcamp@lists.libreplanetbr.org, Borislav Petkov <bp@alien8.de>,
        David.Laight@aculab.com, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, helen@koikeco.de,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 31 Oct 2018 20:24:01 -0300
In-Reply-To: <CAK7LNAQzgdFPpwHEtfDazLd2jAhNy8=f_4mvOQMWfOWCb07E1Q@mail.gmail.com>
References: <20181024040354.24879-1-leobras.c@gmail.com>
         <20181024040354.24879-5-leobras.c@gmail.com>
         <CAK7LNAQzgdFPpwHEtfDazLd2jAhNy8=f_4mvOQMWfOWCb07E1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em seg, 2018-10-29 às 01:42 +0900, Masahiro Yamada escreveu:
> On Wed, Oct 24, 2018 at 1:05 PM Leonardo Bras <leobras.c@gmail.com>
> wrote:
> > Changes the parameter name to avoid shadowing a variable.
> > 
> > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> 
> For this one, I'd rather like to see code refactoring
> than renaming the variable.
> 
> I will take a closer look.


What do you suggest to refactor?
I volunteer for this work.

Leonardo Bras

