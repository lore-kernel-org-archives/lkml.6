Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BA1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1057F2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="DQkvEE1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731731AbfAKKVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:21:00 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46384 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbfAKKVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:21:00 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so12611889edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 02:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UcSsdNuw845dDAXRms6IlwCZsgcNTDldOAqAQh5XSXg=;
        b=DQkvEE1qqswes1yyA/HkEjQeUhk0gJUybXQOK1rBcMZnX0TZZTb2APN4XPrPUcLPn0
         YVJmV8JIdghs9EFGMROoKXy45RxmtGlTeN/pVpNd19/6aNpqeNiGA4ndL72CrePAG13u
         vgZ16AhIVTQbL6+7MmREksLKaUeD2Ela5GZtSYCiTeMycbHB58Av8X7oNEC4Pghntw4A
         LwHR8/kZhACVP7VW+awpsD4iXPlVGpx/uSWx6vtRnJnfchXUFbQs8Oo/z6C5Ugvi1Ttm
         swSH5nHWU7u1SnHpNVg8yQ2/MiMhcdXHawOdwNWvthL0mcS7a43XrJMJhWJlyqCW1N52
         0lUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UcSsdNuw845dDAXRms6IlwCZsgcNTDldOAqAQh5XSXg=;
        b=LGzWR1Po2eYhw7atL/J0dUMYR8UH0W2O8MM8xqUxjYagl1gxO9DWl22la0LjI6pzut
         7w6x1t4anaG3YW1JzTToFge9x+Pjbj/cETxG36mWGmKfMfoM2erVm/HlQ0jk9Y2oz8Hs
         PH4jt6Whk3b4wAWP+10QBu83hnjpHCsKQ44NUPNiYFyV5fMDV3eyP94PsyQJt8ctCamB
         c/0ss+FEo2jJX2EQhHVAOGgOoCZGc9sNZfFb+PUADHBEXJx/neqsjMmk31IHtOSAJBRe
         zUSZFUFq0Zr7Ti9J6ODtI1FM5tSC7S/WM/T9Enw3IpJHZvOBgT8SELksbvqt6c/dvL3h
         dlCw==
X-Gm-Message-State: AJcUuke4Ee3+OOg6y7ge0t2B4//UjOe24OIoiDXusV3bODn4PAZJBC4l
        MX5TqCw93NnwATRucVyWJqu8MtMnZuixgw==
X-Google-Smtp-Source: ALg8bN4KGPrZz3pVNClWfa2Ia3oP21xVJRjPTAplzrHBlIA7qb9ZbHTA423ryF+FuVr0UvdV0AWcrA==
X-Received: by 2002:a50:8e95:: with SMTP id w21mr12256700edw.198.1547202058043;
        Fri, 11 Jan 2019 02:20:58 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6c0:d6c:c571:88:8aee:976c])
        by smtp.gmail.com with ESMTPSA id s46sm2328273edd.9.2019.01.11.02.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 02:20:57 -0800 (PST)
Date:   Fri, 11 Jan 2019 11:20:56 +0100
From:   Christian Brauner <christian@brauner.io>
To:     gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     arve@android.com, maco@android.com, joel@joelfernandes.org,
        tkjos@google.com
Subject: Re: [RESEND PATCH] binderfs: reserve devices for initial mount
Message-ID: <20190111102055.fryctkdngibd56dq@brauner.io>
References: <20190111101940.24965-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190111101940.24965-1-christian@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 11:19:40AM +0100, Christian Brauner wrote:
> The binderfs instance in the initial ipc namespace will always have a
> reserve of 4 binder devices unless explicitly capped by specifying a lower
> value via the "max" mount option.
> This ensures when binder devices are removed (on accident or on purpose)
> they can always be recreated without risking that all minor numbers have
> already been used up.
> 
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Cherry-picked this commit on top of char-misc-linus and it applied
cleanly. I hope I took the right branch?

Thanks!
Christian
