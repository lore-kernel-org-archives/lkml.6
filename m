Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD035C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE5B21531
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PznkmGec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE5B21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbeI0SEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:04:44 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35575 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbeI0SEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:04:44 -0400
Received: by mail-oi1-f196.google.com with SMTP id m11-v6so1872025oic.2;
        Thu, 27 Sep 2018 04:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=4/3vC0ND/OLby61rkTlWSoC/z7vk6mhsAubsAE5YXxg=;
        b=PznkmGecjIkoLFfnvKLz8xOmFxDy0JJq0Jp1tlmwz8VzaPtT3kH0OtC4gs3UWdkWg7
         Js2se3BIb8Gg4cbq6Ntx58WhvsyE9u0xLL5tGB0/CyT0G6cireXJnqvh8mTpo33M0lCj
         x21cLlhqI/UUb1W1b9Ul4Chw8HlOLPB4wWlVUi/rrYt+YIDggW3EFCGk7sK/os5iFmhN
         jXDuuZIFm0iMmYMB/tEQ/nEYjPFYcvAAoJ5q/zDizDj1WAv784HOs9/PefK5d1rCTFs0
         e/DVvkz7Rj+/uS00tV8SSgxzyGXdjsvvHsVZMKolIS5bLVoVjxC9WG3WfOU1oJz0/k5N
         Djpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4/3vC0ND/OLby61rkTlWSoC/z7vk6mhsAubsAE5YXxg=;
        b=jC6TS6uBrDa4wN+NsoVaLae2A4CY0yJWDWgNwaC6A/G7YeMt+DAkP0jh1ms8ATMyuQ
         XHHWO+OZpRRi2HO7WMgM68mQUaat8EUIsGRbyKCYBZXkGv115oN0GIGKRF7GgbIHmbp8
         uNTUb2iAE1/jyTWYgQNlmXtHqFF2eDSkt0Y7j+co9MqreuzJJppG+1qoeMro/wvzNtBA
         zCt1usg4LUfOZYA+Egkq14SMz1nUJxgt8/nzYDrf6ZNyAr2fBtnI7mswUD6diyUJCFP9
         5Z72EVY+cpCp+Mls+RUFd35BpBQu8ETqbnJY3y5camA6ixc3chmFr+zeSXEOQOciQ4zm
         krAw==
X-Gm-Message-State: ABuFfoggk5yR1iZTz3iMlLNGBHQbg0zSvHlT2dexyPuemv6CfFyoXsWQ
        Sa8Kc7k98vgxsVv2fIlmVsgvG22eVclb6EqPn2Q=
X-Google-Smtp-Source: ACcGV63LlrZ4zG454ZYRHd4NVbz9QKqQJ5Cv1+afh9XibatNcXtgmonZsnewiKZL7h7hkHfoyRFP5IFCA4715sTTOFI=
X-Received: by 2002:aca:f4c2:: with SMTP id s185-v6mr204630oih.245.1538048809782;
 Thu, 27 Sep 2018 04:46:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:59c3:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 04:46:49
 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 27 Sep 2018 12:46:49 +0100
Message-ID: <CADVatmMTY0NHJFUOeScJGv=Jb=gCQwgrbeTmW6vkedw8rj1ELw@mail.gmail.com>
Subject: Re: [PATCH 4.14 31/64] spi: fix IDR collision on systems with both
 fixed and dynamic SPI bus numbers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Kirill Kapranov <kirill.kapranov@compulab.co.il>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Sep 27, 2018 at 10:03 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Kirill Kapranov <kirill.kapranov@compulab.co.il>
>
> commit 1a4327fbf4554d5b78d75b19a13d40d6de220159 upstream.
>
> On systems where some controllers get a dynamic ID assigned and some have
> a fixed number (e.g. from ACPI tables), the current implementation might
> run into an IDR collision: in case of a fixed bus number is gotten by a
> driver (but not marked busy in IDR tree) and a driver with dynamic bus
> number gets the same ID and predictably fails.
>
> Fix this by means of checking-in fixed IDsin IDR as far as dynamic ones
> at the moment of the controller registration.
>
> Fixes: 9b61e302210e (spi: Pick spi bus number from Linux idr or spi alias)
> Signed-off-by: Kirill Kapranov <kirill.kapranov@compulab.co.il>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

There is another later patch which fixes this patch.

04b2d03a7565 ("spi: Fix double IDR allocation with DT aliases") , can
you please add it to the release also..


--
Regards
Sudip
