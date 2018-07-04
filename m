Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F007DC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FE324108
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zo6G/wLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FE324108
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752888AbeGDVCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:02:15 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36004 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752653AbeGDVCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:02:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id u7-v6so2510717lji.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 14:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=JQ+vK3gb9doFim7cCNUiCVpg3JI8ozceUn+hYPi/8Jc=;
        b=Zo6G/wLCHtzt4oHFzA9rWRkvIrny/sZaOvk4j/XrHX2oRSVLo39FyBfmLUz7wol26C
         NkNA0XvRC15iResFteW4+YCicJwEC24nCAyc9wnjhX+35VRpV2K0wwt5w49tihQDBoLi
         1+1RSXemWOMcjrqcTGD31+73xMsqxQ/x2b+faW3iKjieHpOADh5QlTbOQg0Kc0keXyrn
         g8m7bb7yRIpEUUqWv4JISCTo+gnYkaUXuggtkd33/DFNMX549Eie56646cak/eXJNupC
         TNDWo2mHsPFwlavNiMEg+44tSMhbmUbvq8WMyDR7jENY34YgmVMGSq3Qs4uEyO4gVzkb
         KS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=JQ+vK3gb9doFim7cCNUiCVpg3JI8ozceUn+hYPi/8Jc=;
        b=Ma/n1OYUMyYLD0BtO8842srWOFeTNoJCcQmpf6PbAQlXEhfvsG2dTFRKJ8LKwQxIzn
         eCn8Tm8yqpe4e/WHbROZRHfYJEA3J6AQUilfFxn3pBfhIRYbitEx1czQGQfPbyRrWHjU
         gRphPO2GpDt+2VZ7ZaJAQSuyYbt5tJRm5inD4Bs1aHsL4hWj/k9zF7df+2xblfecN7sZ
         GGQYntsUqRzxZ1s8bf3u4hXKb63iN4XTj0IcfD1BqIJQsB+TfCm3xMnF3bLVm4dmZD8Z
         o+TIiEO4//RQUmsvm0OPtjq57LtLBwBPJWaeJyplM5uVmMKBj0GVpXwk9HrEcbjzbVVa
         gItw==
X-Gm-Message-State: APt69E2Sj6qQomL6nkDSD2iGYbGwnPCnJjO/LpEmexRohi8f/VXPW+Xq
        BkbNI0oE/s9dFqwraEi8vOXnDAj6nvq1MDnyGzUkYTfu
X-Google-Smtp-Source: AAOMgpdNaeN4lh3d2gwSqIXhS4KIot61Mu9wEXEmteUxbFu1XXGxpMMbivL5sXq/KLHcFc7/OsVJIfapD6xOYxPoY90=
X-Received: by 2002:a2e:5bc8:: with SMTP id m69-v6mr2451376lje.115.1530738132996;
 Wed, 04 Jul 2018 14:02:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 14:02:12 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.21.1807041414080.3671@math.ut.ee>
References: <alpine.LRH.2.21.1807041414080.3671@math.ut.ee>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 4 Jul 2018 23:02:12 +0200
X-Google-Sender-Auth: viC71WsK8P74STNrisd-SYEHa0A
Message-ID: <CAK8P3a1RkNc_kShHBJ6QENrQheQi=C93DmnknC1S_uJDcTDqww@mail.gmail.com>
Subject: Re: 4.18-rc* regression: x86-32 troubles (with timers?)
To:     Meelis Roos <mroos@linux.ee>
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 1:41 PM, Meelis Roos <mroos@linux.ee> wrote:
> I tried 4.18.0-rc1-00023-g9ffc59d57228 and now
> 4.18.0-rc3-00113-gfc36def997cf on a 32-bit server and then some other
> 32-bit machines, and got half-failed bootup - kernel and userspace come
> up but some services fail to start, including network and
> systemd-journald:
>
> systemd-journald[85]: Assertion 'clock_gettime(map_clock_id(clock_id), &ts) == 0' failed at ../src/basic/time-util.c:53, function now(). Aborting.
>
> I then tried multiple other machines. All x86-64 machines seem
> unaffected, some x86-32 machines are affected (Athlon with AMD750
> chipset, Fujitsu RX100-S2 with P4-3.4, and P4 with Intel 865 chipset),
> some very similar x86-32 machines are unaffected. I have different
> customized kernel configuration on them, so far I have not pinpointed
> any configuration option to be at fault.
>
> All machines run Debian unstable.
>
> 4.17.0 was working fine.
>
> Will continue with bisecting between 4.17.0 and
> 4.18.0-rc1-00023-g9ffc59d57228.

That does sound like it is related to my patches indeed. If you are not
yet done bisecting, please checkout commit e27c49291a7f ("x86: Convert
x86_platform_ops to timespec64") before you try anything else, that
one is the top of the branch with my changes. If that fails, the bisection
will be much quicker. Unfortunately I don't see anything right away,
and haven't come across that bug in my own testing using Debian Stretch
in an x86-32 qemu.

      Arnd
