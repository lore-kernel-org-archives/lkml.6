Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B668C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381C52173C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rivUP56/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732755AbfBSBdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 20:33:00 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46357 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730247AbfBSBdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 20:33:00 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so9266558pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 17:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yFhGS+sKtZ9ud3/RQ5BnKO9UzV0PFfBpxHzEnlky7So=;
        b=rivUP56/SNGg0dTaELvh1obOGfw6y4aF8iYCzyArftD+vGfqmIYiS1T6drHNiPtJW2
         1tUKBtydY6E3oSH+oGcuN7lQP7fgqp2YpQ21f05s1S2gdQEGri1v/2DeJNaHS3bs2dYq
         MkOmj4XotaqhPRN59eb3WeUfGW8MK+pi/UKKIdnLnjzfo+RkDNfluIq4ZUq1u3kYxHND
         rpALitA0Zzd19IycBEMsBqAQM1mncjnP0yT+d3WtUKWmkbo7LFfpSjENlW3e+ayyjDJJ
         fTu/iF9jvc7YeOMxtjwnxcXIfi1TSJrLaRBJRcj+IpZ8iLF1TsS46g1evmGWJTx6FXIJ
         ZL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yFhGS+sKtZ9ud3/RQ5BnKO9UzV0PFfBpxHzEnlky7So=;
        b=MROXAELhybx6ODnb3fDTjxiHa+nPBDVhudQQbi7Q/XUnNKwgjmLsyFB8MlBV0/KMcm
         e5qEom1l0Nur4tz371zp2TG0cc2knvnLLS2g4RSAGkorDlYVBBS59BYgsDLHl/w1pCN4
         tVvBVZ+FMmoxeB2FPPa2aZlnXsImSWC+O2tvUPWgph7ocB3/IpKBN7jJyfNU3hRKEZJG
         yLMiqdP087rxOITypXGKJARTfQWqLXzYgJ3wGAb6EZR1hdMnWW1L3yQNUsrETeaWRrti
         alHBvv/Dd9nbne4KQrz4H5TIdvMi/xLfkg+n1+qJl/yrdtnGg5TZWHbeM69GC6IENX/t
         59NQ==
X-Gm-Message-State: AHQUAuY+E9Qlm/ROfGCrMmninIllOj+BtEV1bxFVlfRmb/+vUbghBNyM
        3hc7LzyQPq1Oi9mWJVYqGjU=
X-Google-Smtp-Source: AHgI3IbgccufJHT2a7yNOoLVqxG+39AJCRGFN/6OtdLna+ISRUMxdiSgQArhsekxi5yzVNsGxhQ2Cg==
X-Received: by 2002:a62:2f87:: with SMTP id v129mr13443137pfv.220.1550539979134;
        Mon, 18 Feb 2019 17:32:59 -0800 (PST)
Received: from localhost ([175.223.35.193])
        by smtp.gmail.com with ESMTPSA id z15sm6779941pgc.25.2019.02.18.17.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 17:32:58 -0800 (PST)
Date:   Tue, 19 Feb 2019 10:32:54 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Yao HongBo <yaohongbo@huawei.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: possible deadlock in console_unlock
Message-ID: <20190219013254.GA20023@jagdpanzerIV>
References: <ebc01f4f-5b1d-4f8a-1d0d-463d5218ee45@huawei.com>
 <20190216072127.GA1945@tigerII.localdomain>
 <20190216073856.GA9979@tigerII.localdomain>
 <71b097a7-03c5-8a65-76fa-24312b452b51@huawei.com>
 <20190218054649.GA26686@jagdpanzerIV>
 <3fece106-baed-92f6-1389-62b8f2c4578b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fece106-baed-92f6-1389-62b8f2c4578b@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/18/19 22:07), Yao HongBo wrote:
> >> I have tried GFP_NOWARN, but the problem still exists.
> >> Only print_safe contexts for tty locks can solve the problem.
> >> My test scenario is falt-injection.
> > 
> > Oh, I see. Yes, fault-injection is special.
> > 
> > I suspect that this patch series can be helpful then
> > https://lore.kernel.org/lkml/20181016050428.17966-1-sergey.senozhatsky@gmail.com/T/#u
> 
> hi, sergey.

Hello,

> I merged this patch series on linux-4.19.18, but it didn't work for the fault-injection cases.

Thanks!

> The failure seems to be the same as before.

OK... So tty_port lock must switch to printk_safe, after all...
I had it in one of the previous versions of the patchset which you
have tested, but people were strictly against new locking rules
in TTY, so I dropped that part. Need to think what we can do here.

BTW,
we are now looking at a completely new printk implementation; which
would not use printk_safe at all:
https://lore.kernel.org/lkml/20190212143003.48446-1-john.ogness@linutronix.de/T/#u

	-ss
