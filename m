Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DBBC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9125A20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b0UJBW3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9125A20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbeJWRdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:33:38 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:33021 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbeJWRdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:33:37 -0400
Received: by mail-lf1-f45.google.com with SMTP id o21-v6so547506lfe.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 02:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GwbqpjyTTF9zZXsAQUHLIQWnBnPGSxCpK5StWhkCngQ=;
        b=b0UJBW3CSXUvXnvmFcRyp1b/swtFjfGE8lVxnWgUJj026qSORyefj7lzmJmzOFO0C7
         KTBXDXxRZSGSrYmPjEMdJLr5TVPoKTR9nEKB4B8leHTa76919I6MFF//JV3DVoGgtxs6
         +W6eIzKX2DcK4TRDI7el1OjPjBmZLivaTEjA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GwbqpjyTTF9zZXsAQUHLIQWnBnPGSxCpK5StWhkCngQ=;
        b=iubcFvIIGcIlepCl7elk9mG8ilJ9EIlLFYOOk2Qmef4bu9UtUnWafOFvf+uM7UAqzZ
         0esluUPsYxFByFVl51luFxzHfHAqHrKgSzV/IxlDpcm56Vm6wbAHxLdXIoFsNEJzNvX+
         OSnwdpeL5Bn9ELXysIqvx6E4HMiRk8as5Bgh7MQSij2teaF1PKOndL+Fv97mgASK8n3n
         hduKRhDynKSfaf7YFT2Etb770rYJRgg3g9WH63YDbaobclcM/zuEGPnFesg9a3efHfWO
         HHzP57m9fYjci3H7uVgFQMaqikcz1x77V2K/y+YTf1Pz+O0HOJfDpG1rFupLzpFZAPl+
         CFGQ==
X-Gm-Message-State: ABuFfohOgH4CNvmYRxvDlTnA9prsYUfWIrqJEqjiSpenzEOd7Clu5mDp
        Nr5LeE9aHFRRSG+lCPTBocqlcGm/tz43N68/
X-Google-Smtp-Source: ACcGV63PnukolN9KBjbuT7Sd1NykxT8vMtJ+QBDgBP5XNDPIo6sfbdl8w9S3Mi763M59kLn84xOsQw==
X-Received: by 2002:a19:c18d:: with SMTP id r135mr7134300lff.59.1540285865699;
        Tue, 23 Oct 2018 02:11:05 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id b25sm118283lfa.96.2018.10.23.02.11.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 02:11:04 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id d7-v6so542368lfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 02:11:04 -0700 (PDT)
X-Received: by 2002:ac2:41d8:: with SMTP id d24-v6mr11275898lfi.138.1540285864090;
 Tue, 23 Oct 2018 02:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
 <CACRpkdbi2gqqc271eMgHjD68bqf2mzw8zw+iAhYv2LFajfo-eQ@mail.gmail.com>
In-Reply-To: <CACRpkdbi2gqqc271eMgHjD68bqf2mzw8zw+iAhYv2LFajfo-eQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Oct 2018 10:10:47 +0100
X-Gmail-Original-Message-ID: <CAHk-=wiiC65aZFrDp69vdcSALLDZNPkTL1diadxNL54tBPeAzQ@mail.gmail.com>
Message-ID: <CAHk-=wiiC65aZFrDp69vdcSALLDZNPkTL1diadxNL54tBPeAzQ@mail.gmail.com>
Subject: Re: Git pull ack emails..
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 9:53 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Can't you just tool something that mails automatically after-the-fact?

So a certain amount of simple/stupid automation would be possible.
That's how the participants list in this email was generated, but the
script I used was actually a pretty much garbage one-liner that just
happens to work for most cases.

It just did my usual "mergelog" (which is a bit like "git shortlog",
it's a script to just get the summary of my merges instead of the
general git logs) and then it used the result of that lookup to look
up the email address by just matching committers.

But it's broken to the point of almost being useless for a couple of reasons:

 - my mergelog names don't necessarily match any name in the git history.

   For example, Greg goes by "Greg KH" when I merge from him, because
I'm lazy and feel like I  don't want to mis-type his name, which I've
done too many times. But in the actual git history, he goes by the
full "Greg Kroah-Hartman", so my stupid script would have messed him
up.

   At the other end of the spectrum, people with complex characters
have their names copied-and-pasted from their email or the signature
from their tag, and sometimes those then don't match either.

 - some people use one email for "official" purposes (ie company email
etc) in the git history, but actually tend to *use* another email
(because sometimes the company email is slow and/or broken).

 - it wouldn't get the usual mailing list cc's etc, and those might be
the most important ones. It is how I saw Greg's replies, after all.

So I feel that he automation model is just not good. The reply should
go to the actual pull request, not to the git history. People who want
just _that_ could already automate the git history thing without me
even doing anything at all, either scripting it themselves or by using
some filtering on the kernel commit mailing list..

So I happened to use the automation model for this email thread, but I
think it's actually the worst of all worlds.

                    Linus
