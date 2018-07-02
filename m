Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13C2C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B0D2552D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B0D2552D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754476AbeGBJ5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:57:51 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:36398 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753155AbeGBJ5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:57:48 -0400
Received: by mail-ua0-f193.google.com with SMTP id y8-v6so9699802uan.3;
        Mon, 02 Jul 2018 02:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nkqZySkkwFGFBs/6o0nEhafrtDGdc5kHW9C0LRVHpPQ=;
        b=db2U8GIEeAffhIv/6InIGVSZdMnMtzZsgVC9H3PyoPpsyS9RkSAgnzEAy3+wgjSQUd
         079903yDbitmr5f2Qo4nXrXWQpKaZrKeHbmMDglEXA/whj4ZZLhrj4+Dcf8UKCdLy4wx
         JZGvzB1dIi2Q7qOmN1TEnM4x0kU2BP9TKJvTLkkT9OeGczlq96k1uN9LVyaPoihCYEuW
         Y3UeFaWuNOWt2TdFPRDbXrABBf22UGpQTLAYH35bqbCFfYxECmESGlJxQa1EjO0VtISm
         lSqq649JLoQS1aIDkFHhVDpVyQ4cD6ft35YgK6hybv3G5U0+W4RrMU3hdy6GA70BZvEA
         IxCQ==
X-Gm-Message-State: APt69E2kzRPQROqzM8vdxAwkqD7N/jRaIUteaB96g3x8OQZj992z1hGF
        o/NdGx5fMuBsLra2LYDdmkpY1nY8d3KN9ZJL9TXRzA==
X-Google-Smtp-Source: AAOMgpfmgyft5wip0G+KE3EX4ZTtJPURNOoUB1sCmt4hb5uCI/FUbDy02Qa0KgB9VEEvpw1ZtUMLSU/JathYbTTzZAk=
X-Received: by 2002:ab0:1b6c:: with SMTP id n44-v6mr9777640uai.4.1530525468062;
 Mon, 02 Jul 2018 02:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180701160757.138608453@linuxfoundation.org>
In-Reply-To: <20180701160757.138608453@linuxfoundation.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Jul 2018 11:57:36 +0200
Message-ID: <CAMuHMdVcSkXAmuD2qsc0mk9pDx_Fd0Q_peBmZY6Mpfkq6gMQZg@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/101] 4.9.111-stable review
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Sun, Jul 1, 2018 at 6:26 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.9.111 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Thank you for your hard work on -stable!

> Pseudo-Shortlog of commits:

Given you do publish a git tree with these changes, is there any specific reason
you're not using a real shortlog? Sorting and grouping would make it
easier to see
which patches of mine you have backported.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
