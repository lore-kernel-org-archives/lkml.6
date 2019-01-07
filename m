Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77EEC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F992089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0gLYYOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfAGQdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:33:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42739 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfAGQdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:33:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so1052555wrx.9;
        Mon, 07 Jan 2019 08:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F6PwismgQUx3Nb1dfsjM6hGkSYv/Ilqj/e7nnGtXZK8=;
        b=o0gLYYOugSmsxql0yEUrY0t66kZPhgfzKR9VIobqIEwUX8734+CONlrLPsLtth3THA
         vTHAe2TiKlc8gu9mqilqN6jEqlboijw5Sr9MD/p6JtgGn0K2sFA2SQScHeVutjXiDSae
         m0cnfKY4ojfIClFwNbpST30ZyITZPgalk9s+9GUQ4dahruzDFXaLdchs1Tyrcvnnblwy
         JaL4iaA3xNInOaUv2d1eW8WSW+IMGzWkY2HkK/9dXkoJNu5hLcPWiKArIl/JcQLEqGIp
         YgquLz1gZxdoUlBdPyXTufjtwz3yZcOrQPmC9VNV5Gd5gGE+r/XZIkujUy74dR5PSuez
         MEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F6PwismgQUx3Nb1dfsjM6hGkSYv/Ilqj/e7nnGtXZK8=;
        b=gxHEKe17vVR9gY+s+8saD6IavywgnDruknkgJZFx2HdXU8BWf0UVJ9IKYkzZ8SWMZc
         tyN7UJQdejC4UUtdSb66di7QDj06RhrrxJc75avq1ORhEgPAJ26c5VyN/xS3pe0Yee4L
         as8zW6dhNxf15dtFup7VKAzBabs1+pvk3Pn+69NToxTd5OaUYNbhZLEhMYlkpsjDgaK0
         fre8mPkkTlr2HIBP88S6b0ZbWs1esnKFKzsrPVjUYGBM07m3oQ9NJ6Q5erNC2X509pKE
         0lM/FUiPuN1eu8/kQq0u+U0JmQxvpW4Yr2dPgkLejLVTfgqpqa//MDeZ3IZP8IAxV6aF
         qr+g==
X-Gm-Message-State: AJcUukfJMDxNDhCW1oYygC0KHbAJsZnZowJ5xk6jJggIlcONyC/AFGgj
        VH2L4FH9AoYs3XT6kXI0HA==
X-Google-Smtp-Source: ALg8bN6XiEOJZWUCl6cLXLKhX916vT0pL6xemdGCULDz21Opl5eojgxtJ7uYEqYkn1FLEapQ8Gyp1A==
X-Received: by 2002:adf:fa05:: with SMTP id m5mr39417885wrr.155.1546878784778;
        Mon, 07 Jan 2019 08:33:04 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id g16sm53449368wru.41.2019.01.07.08.33.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 08:33:04 -0800 (PST)
Date:   Mon, 7 Jan 2019 19:33:01 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 2/2] /proc/stat: Add sysctl parameter to control irq
 counts latency
Message-ID: <20190107163301.GA14354@avx2>
References: <1546873978-27797-1-git-send-email-longman@redhat.com>
 <1546873978-27797-3-git-send-email-longman@redhat.com>
 <20190107155840.GY6310@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190107155840.GY6310@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 07:58:40AM -0800, Matthew Wilcox wrote:
> On Mon, Jan 07, 2019 at 10:12:58AM -0500, Waiman Long wrote:

> > A new "fs/proc-stat-irqs-latency-ms" sysctl parameter is now added to
> 
> No.  No, no, no, no, no.  No.
> 
> Stop adding new sysctls for this kind of thing.  It's just a way to shift
> blame from us (who allegedly know what we're doing) to the sysadmin
> (who probably has better things to be doing than keeping up with the
> intricacies of development of every single piece of software running on
> their system).
> 
> Let's figure out what this _should_ be.

Yeah, let's start interrogating about which values specifically this
super sekret applications wants.

I assume CPU stats, so system call which returns CPU statistics in binary form.

> Why are you caching the _output_ of calling sprintf(), rather than caching the
> values of each interrupt?

For output caching string is better, but I'm not defending the patch.
