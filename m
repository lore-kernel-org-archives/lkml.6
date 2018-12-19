Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2C6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30341218E0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dh8HduUI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbeLSQSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:18:18 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:41607 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeLSQSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:18:17 -0500
Received: by mail-io1-f42.google.com with SMTP id s22so16022414ioc.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 08:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc;
        bh=KZYe3uP9znFA7r/rUMKbrGoNP0sDWMgxjKOs9jMUxKI=;
        b=dh8HduUIeEjx4+NL0x8vJfInto0JXJ68YnnE1p5Dq/csouv6G2wF6sKVFO4z3XJUND
         WM1Ok1COknx5hGc3ZvhaxqFBUN1MwhcN2Oq5uMs7mn3pq3UzLaPeaMQkIqkht8YB1OI1
         ZHFOezQbTFzncknHwHIGI1SBfkr8dTajry4pro/2AZmJCfJ/81ZrqLL2vsFf1TdRa+IG
         hcxDEJnCsjS1BM/f+j1VQToN8siGPPcfCbGnuyRmlwZsu0k32EvSWueyX1CWERlbvmSo
         wZ2GqFCn71nmY/w/IVijLPkN/GSiTgR0wyXPkkYMWfRTZdntzEelVYbFYfu6X87s+6az
         hM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc;
        bh=KZYe3uP9znFA7r/rUMKbrGoNP0sDWMgxjKOs9jMUxKI=;
        b=q3Mw9D/cYU9Rsgk9Lw8+Zl93wLiNIPEtlgGjP4PC8XiuAk44IL+xF6zgApWWwkGn7F
         2C3jmhwnVj9l4LArKigRxXI8r9gX2aEcKZJIm7fEzYgZevXT/qLoNVakRskf9x+pUVZI
         ecoiHJVSxXEOklxc5z52xwXuMObOIwLBPfyHzP5eTE/5EE5PcR4u9Ge8S0i3qfV7C8PC
         QRvtbiFl1wh3JhtPPSSBiz9O5HGBv5aIWhsfg3lLza43LJ0W3d78CEXNw6g5t9c+dCTA
         PUMNjw9WUb16Ux1C8/Jh8a78yG2EbrHOBxOhCyheDGaYRWKat/9ZBZuMeBsAycXIKAkJ
         +m2A==
X-Gm-Message-State: AA+aEWYz8tEDeGiONHxdTfhJw2HPpdsE2/F6Oypm4EsReqkXJpaKgdpz
        ySDtSIwNjH6ktlBER3I/ptIEP7xZ3PLn51Ixv1WyOAMA
X-Google-Smtp-Source: AFSGD/UwZ5TxnFmWlPrP0s77MHcV8+xJzz90twKFVBZGoVFJN6aqNpeKj5QUtyQA4/SFSMT+/44x9xz6WGTqzegezRQ=
X-Received: by 2002:a6b:1d8:: with SMTP id 207mr18920798iob.62.1545236295787;
 Wed, 19 Dec 2018 08:18:15 -0800 (PST)
MIME-Version: 1.0
References: <CABcWhv5QApdqti+fhGuH-3puhk89n2jgfziV2zG3H8Y59RE63A@mail.gmail.com>
 <20181219150604.GB25653@kroah.com> <CABcWhv4794moz7PZxmzJMySpJnjZR4ikGwHVcicp0-4PWOHmig@mail.gmail.com>
 <CAFSeFg9dyKEry_pbnn7395nFtOYixbgYuAunvoNa5roe9dVUTQ@mail.gmail.com>
In-Reply-To: <CAFSeFg9dyKEry_pbnn7395nFtOYixbgYuAunvoNa5roe9dVUTQ@mail.gmail.com>
X-Google-Sender-Delegation: praveenkumar1511@gmail.com
From:   Praveen Kumar <kpraveen.lkml@gmail.com>
Date:   Wed, 19 Dec 2018 21:47:46 +0530
X-Google-Sender-Auth: 8FKPN98DpVw1_rSyjeL3Mp67INg
Message-ID: <CABcWhv7og6-MqXgo9X=huachKo5gHV+S-GBLW6mhHUXmwkdW+A@mail.gmail.com>
Subject: Re: /proc/modules not showing any output
To:     Aruna Hewapathirane <aruna.hewapathirane@gmail.com>
Cc:     Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 9:28 PM Aruna Hewapathirane
<aruna.hewapathirane@gmail.com> wrote:
>
> <snip>
>>
>> I think, on my test machine, by default, there are many modules which
>> get added during boot up, which with vanilla kernel is not happening.
>> Thanks for your input.
>>
>> Regards,
>>
>> ~Praveen.
>>
>
> What does lsmod show you in the vanilla kernel ? If you want the same modules to load in the vanilla
> kernel folow steps given below:
>
> 1 -boot into the older 4.4.162-78-defaultkernel
> 2 - change into the vanilla kernel source 4.20.0-rc6 builddirectory
> 3 - $ lsmod > lsmod.txt
> 4 - $ make LSMOD="lsmod.txt" localmodconfig
>
> Boot into your newly compiled vanilla kernel and run lsmod and smile :-)
>
> Hope this helps - Aruna
>
Thanks Aruna. This helps.
