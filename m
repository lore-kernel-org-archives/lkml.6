Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F52C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3712218D3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T73RErE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfADSEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:04:02 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39554 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfADSEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:04:02 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so33125126ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 10:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0UduleAP57pMbNlXZO2z5b9C1uqCtR1HJ+u6omsbdd8=;
        b=T73RErE7zFieWGP9vuw89/1oKdGsofODda1SH4tfkcDMYx+5jLejJLe2pCmuKjR7hh
         240hcD85ODOd2cm2W6JKW+tFFDPRHjltNB7E7iSfvfzWpW04FgfoxQhZXU5MtkFyRM2f
         MjQXhmwruLOTD22i8wqPuLZxNFADTKgTbEflI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0UduleAP57pMbNlXZO2z5b9C1uqCtR1HJ+u6omsbdd8=;
        b=kCqAkdEoPLn6HbPMtiZfOOXocQngRVG/pyYSiRmblUWlOOTO4oxsDG8YezsWD37nhD
         6jyl8+3xX2KQPPsgosM3r09hNVyC67HMIQ4ZF1MAkCgaCLG093/yV7CawvQ/TrASrO7M
         kdRVliqmy6QG/4BhLv/aNOXp3pjQ/7fNppC6TVcwL+iuSZ/VsgjH9qGA2QxdKRCWD9d3
         86jsGHhmtpgBAC19fiiTBjja17Zfu7GrXGZt36qhoYmll2QouV7YTFZUMtNEdpX3i/hF
         Nv9HQK4mHwfrw9gYsYO3CpKX5T8KBPIzr6UugN0ktt7x8S6W6WEAGHaTnA69Q807gaiW
         6r6g==
X-Gm-Message-State: AJcUukcm4sjNUcJwFHs02RX5FBxWXpsxe+jXqAgZ762FSHSQ1ZFP47Zk
        0h8XIe85MJ+OpJJD+GHcaAkNZCjMI7g=
X-Google-Smtp-Source: ALg8bN4f5jxOnySUf4DPv3I/BZz4YQtBpvWcR1CWqImwops3UHeujqXTI2znWiIB5RSBXjWtRYIwOA==
X-Received: by 2002:a2e:5418:: with SMTP id i24-v6mr29361639ljb.51.1546625039617;
        Fri, 04 Jan 2019 10:03:59 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id b25sm11198282lfa.96.2019.01.04.10.03.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 10:03:58 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id u89-v6so33187130lje.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 10:03:58 -0800 (PST)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr12711071lji.133.1546625038345;
 Fri, 04 Jan 2019 10:03:58 -0800 (PST)
MIME-Version: 1.0
References: <20190104174242.GA9173@roeck-us.net>
In-Reply-To: <20190104174242.GA9173@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Jan 2019 10:03:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=whBbxN6+h0gOEX6tAQDqM1kMfTJfoOWF+OpBD4r6swsdA@mail.gmail.com>
Message-ID: <CAHk-=whBbxN6+h0gOEX6tAQDqM1kMfTJfoOWF+OpBD4r6swsdA@mail.gmail.com>
Subject: Re: [PATCH] Remove 'type' argument from access_ok() function
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 9:42 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> ... and this is just the very first build I happened to try this morning.

It will fail for all sparc32 builds. And unlike the powerpc case, I
hadn't even noticed this one.

Trivial fix for powerpc/sparc32 pushed out. Hopefully that was all of it.

               Linus
