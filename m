Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 89713C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40AD9208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J46V+CFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AD9208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754698AbeFNG06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:26:58 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:44213 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752719AbeFNG04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:26:56 -0400
Received: by mail-io0-f193.google.com with SMTP id g7-v6so6007731ioh.11;
        Wed, 13 Jun 2018 23:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5qWc182unNEGXdW9oL4AVBDgm7+snm8VpBsohLpWa6M=;
        b=J46V+CFNihIVZZ4wwSxUlfD++4L9FBtBcqIBt+Up/OQHF3iK43OUf6Mh7dFinwI9lL
         RSuXDnwfTUDhzTPKPsGEQoL5BpNrZcwtwxSuKmfOCbk1s3pvN4057CDELx1pr043sE8r
         gAr1mFpAtNDWUQ3tSNemmpePX+2gU8ISwP6F0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qWc182unNEGXdW9oL4AVBDgm7+snm8VpBsohLpWa6M=;
        b=lMyR3Es7HWwuFF0zC1iwBVNT35PLCBZhr6zOHa+TMSfcjy2pAKNaI06FRvfIBALPBS
         /f5Uqy2DK3Zz47RlhUsR6/KoClEVPubw0cNGjVqQ9AeK0apnVfpOOT4fI12ddlG0wASf
         e67sLtuIec26tSC1M1kgF36wa/ZNqQMcaU9s3e/WOv8t12QZl67kc0Qnu8gXYzFzQhR0
         Hqq9iORU4UzYj0x0t8xl/YQBSqTHKleTnDQRofNXm+wOHvS/dgjlISpHdKDUfwhKypKL
         qv23bz5zk7Nh+rwslVP0FCSExB6ZW91zXErwKu50Cc7IVATLSoUGnGHiKtkP5cm8D5VY
         rPRw==
X-Gm-Message-State: APt69E05vkhz8Yxyd7oGhj8PS81kIzBTpAwVEIMqmWTCzt2+0X3923xI
        SypnUejwoywiPahPcvjTqGc8qC/F093E+KGcZYA=
X-Google-Smtp-Source: ADUXVKImmcekn0meENlQ+mbl2OAJIEkoC+RxFngT0IfUY47dD/0ZqicOP6Z54c5+xyYCSvwwq8OsYlZa7hsqnrjzF3c=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr1179283iov.203.1528957616109;
 Wed, 13 Jun 2018 23:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNARDLbEhbJGrKY6HGwfxL8ebAMBDa_2A+s2QkzQGEKyFHQ@mail.gmail.com>
 <CA+55aFyxY9f9_eGv3CvA0zwzo8K5WeNbNPDFuyhtCrzRyic85A@mail.gmail.com>
 <CA+55aFy2KEzTiF=0nG8_RFoPpycaqc=n-hf-mQSbKotMzYJG-w@mail.gmail.com>
 <CAK7LNASd7Mc8eU76L24ZC0OFdUf566adNGVvX9Ou987cT3CCWw@mail.gmail.com>
 <CA+55aFz7KGMcvABxJfYs719ySyt2JouDX9t0SAV4Qu9yY9tfPA@mail.gmail.com> <CAK7LNAT4m8JgOttC5D16ALKqvMtt-6Vi4nFUdVaTMQSQPwYN-w@mail.gmail.com>
In-Reply-To: <CAK7LNAT4m8JgOttC5D16ALKqvMtt-6Vi4nFUdVaTMQSQPwYN-w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Jun 2018 15:26:45 +0900
Message-ID: <CA+55aFyHcEojRqf+pvGuZF1nExY_SFWX7QZ7ifBZPtJfB_BWDg@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild updates for 4.18 (2nd round)
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 3:16 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Could you run sed directly in your tree?

Sure, I did that on the  plane. Now on the ground, pushed out.
Somebody should double- and triple-check it.

            Linus
