Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8B1C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733C920866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="uEwNHbbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733C920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbeILCMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:12:43 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:59133 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbeILCMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:12:42 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 60a5231d;
        Tue, 11 Sep 2018 20:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=qHOLDFRAeen0AZR1zbyO/RUBorw=; b=uEwNHb
        bz79Udr4B8B7v0bH4bh/30vxyt7cgOQFYzUP9SAUhDwm5FdqK2VcuI7fVtY2JsVo
        VZEZxB/8VbRno2iOVtTXvRS1f1ySrcslGWFkQf2HMaUabvaUye4s2hB6A5+FtwUs
        dqqTgiATiReF1oPPHKRtvuDjFrqLrJ5+d3lKC2jonZtAy55vUkd9rMYTiuANrD93
        jZVJpAJ+yZSQRP10QofZMDIs+iNTo0KRLEIlLCqMWEPZhFNl+Dvj3400zzftx3x3
        3PWdyZYLFLmL6HWQDUtxfqfAhH4eGj0zkD4zFQzO4CNCPHIzWcIYL5mymVqgzKiH
        nq59IRVFfWHOq0aQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 50f1473f (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 11 Sep 2018 20:54:47 +0000 (UTC)
Received: by mail-oi0-f43.google.com with SMTP id k12-v6so50042954oiw.8;
        Tue, 11 Sep 2018 14:11:30 -0700 (PDT)
X-Gm-Message-State: APzg51BpYZu01CKL70MF0i2MTULddKSS2VR/phaRcRmKvYjTExSQAPei
        ReMcXGQqXF7dhEIGnxVdu0ExSPTLmMsMAtgx4jc=
X-Google-Smtp-Source: ANB0VdZewUi7+0D1Qn9b8XuBxUYxX0JtrxjCmudN0avtduB2KO726K6XdbBUFUWl7BYJwNGdc35XftZhJM4IB8udDvk=
X-Received: by 2002:aca:e6d4:: with SMTP id d203-v6mr29288967oih.311.1536700289627;
 Tue, 11 Sep 2018 14:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180911010838.8818-19-Jason@zx2c4.com> <201809112140.Y6V2OTor%fengguang.wu@intel.com>
In-Reply-To: <201809112140.Y6V2OTor%fengguang.wu@intel.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 11 Sep 2018 15:05:35 -0600
X-Gmail-Original-Message-ID: <CAHmME9pn=NYvPiwTf71W-GK9dj2hH7C3=CfZX0tSiceEqmrrbw@mail.gmail.com>
Message-ID: <CAHmME9pn=NYvPiwTf71W-GK9dj2hH7C3=CfZX0tSiceEqmrrbw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 17/17] net: WireGuard secure network tunnel
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again Mr. Ro Bot,

On Tue, Sep 11, 2018 at 7:17 AM kbuild test robot <lkp@intel.com> wrote:
> I love your patch! Yet something to improve:
> All errors (new ones prefixed by >>):
>    arch/arm/vfp/vfphw.S: Assembler messages:
> >> arch/arm/vfp/vfphw.S:299: Error: selected processor does not support `mrrc p11,3,r0,r1,c0' in ARM mode
> >> arch/arm/vfp/vfphw.S:299: Error: selected processor does not support `mrrc p11,3,r0,r1,c1' in ARM mode
> :::::: The code at line 299 was first introduced by commit
> :::::: 25ebee020bd34d1f4c5678538204f0b10bf9f6d5 [ARM] 4583/1: ARMv7: Add VFPv3 support

I've also fixed this for v4 of the submission. Sorry about that.

Jason
