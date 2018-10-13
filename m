Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D25C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1F220659
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GR44ZSt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1F220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeJNABt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 20:01:49 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:45265 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbeJNABt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 20:01:49 -0400
Received: by mail-io1-f53.google.com with SMTP id e12-v6so11349992iok.12
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 09:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l/TacTj6uF8UhIINFeU1msPOQMn4LKN87lkL9ibztlc=;
        b=GR44ZSt5GY8QRv15WTdaP2jURUblkVaarVTyCnS1DHJrVb+CXBNx9qQvF7vNMYwLpa
         IJvRnQDJV2sXE8plpeVWiwuk4rM+licXFMiGuAmZ2pTFLRkOnk1m/BEAJEJ/Bz80uDQi
         nL8LW8d+BX5mmsuEpd12jk9OZm4tSwtIITgWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l/TacTj6uF8UhIINFeU1msPOQMn4LKN87lkL9ibztlc=;
        b=gsqWTOvnoPv0g86VoYuL+mlcLVW9YfEIKQtLEg9XddMR+fSPV88Il7wQwsyUPmxgHB
         mGNpClVpr6kVDs1EOZVINqFlKOwE+ZKl+seVEnTke47m7A9QM81x7raoMGX0H+zW9lkc
         Ym0QQEFkITplTi9JcxdeVflHMnfm68yR1jUoUU0EuqgWbrWsaFiZ7dGldy/dSvx0nrjz
         /mJkjB0YKgJEQEsOZoTf95rhicez21xkA8eiBY0SwAisb/KNkAwnVbegqxJ5VqEImkRl
         +pWfajn1THou5NivN04E1Pn2WtskuvXYI7ztyIBUkAQTJ1q4PfItUPqsbTZQgrGB/peY
         Pv6g==
X-Gm-Message-State: ABuFfohIXEP2G9cwFR8Iz2WcgMbsVmxaYNlE0HnVt0bxvxotHQayNvSJ
        aVCpizofl4zqjKGZBd0GLHDBouhIjSgRD7rPPeu7ig==
X-Google-Smtp-Source: ACcGV61NVcm8jDeuCuP5AHH04vTGjQdLtungTTSoju/UdW+FPE5vigxdjGCfnf0wSzBtUtTvbnfzAm9Uu0yCH9SPQgI=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr7351876iof.304.1539447842456;
 Sat, 13 Oct 2018 09:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <90dbf770-5262-5128-e585-c44d086568f9@ise.pw.edu.pl>
 <CACRpkdYQBxvHh-AfODddzc5G+BMBhUBSRXUdLVO8_99yniUYPQ@mail.gmail.com>
 <5d33d03a-5d62-c8c8-c9cc-2ccbe1b464f2@xilinx.com> <efcb67bf-bdf3-e3a8-5139-0f778ea00f1d@elektron.elka.pw.edu.pl>
In-Reply-To: <efcb67bf-bdf3-e3a8-5139-0f778ea00f1d@elektron.elka.pw.edu.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 13 Oct 2018 18:23:50 +0200
Message-ID: <CACRpkdaeBMc-wqZxh0vVXRiRMvTHDFXxOk0aaxN=swcnLBhG5w@mail.gmail.com>
Subject: Re: Bug introduced in the of_get_named_gpiod_flags function.
To:     wzabolot@elektron.elka.pw.edu.pl
Cc:     Michal Simek <michal.simek@xilinx.com>, wzab@ise.pw.edu.pl,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 5:53 PM wzabolot@elektron.elka.pw.edu.pl
<wzabolot@elektron.elka.pw.edu.pl> wrote:

> The question is, if there may be any other in-tree GPIO controller
> driver that does not initialize those flags?

So as I said, I looked over them and they all initialize
their flags.

> Anyway the current situation is somehow dangerous.

Not very dangerous compared to much other kernel code.

> Maybe the best solution would be to initialize the automatic variable in
> the of_find_gpio?

Patches welcom, make sure they are tested with mainline
code and drivers.

Yours.
Linus Walleij
