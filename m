Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C80C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 15:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029952146E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 15:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrBbmg/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029952146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeHSSW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 14:22:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40849 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbeHSSW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 14:22:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id e13-v6so5531173pff.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 08:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=08qGV1/BlMNDb+Scw5MdTnEpWqAu5NX+gDCuZsNYOyU=;
        b=KrBbmg/ggzM9Fk49GWMcshgAnig2kiCKCoRq33lkhjjLjWCHwzF94zzcuKYtZ+JXFK
         h3lNZvNholT2o6SIT/WBugaLqXc0fzR0URZATD7sZRuVgqdf8jn8EovdvRbW5PUurgwj
         6fTZEm9W9hpCRv0hACf71dIRJToEODrD2nSgR0MvCoOV/KiyOmegEMUP6WG2SV0Uvx+p
         rbPVwdXbKrwXc1AsPJ9fVftcf5k1lk57w+B2gHv5nBerFF9PLqwoyMVsS0OZXztR/EaA
         pLJQHe0TwNiZ+nxitDOV6MTVgujHC2LnhM/78Rh98Tul+SulBBpLa0muRE09iP4o935g
         PKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=08qGV1/BlMNDb+Scw5MdTnEpWqAu5NX+gDCuZsNYOyU=;
        b=Ide6bce6mTyQSy2eaE488+7WZdwOyTPeoELgLV88cIDGIeCPLApwQ3V60rzhm3dxV2
         IyWQKHJ3d03TITgY/WoLfPXz8QGR5FFBlJx+tM/3agbRjgrt6qSpBxlEy8yYPqKJS8fU
         /a311KIvqGCxYW7JeVeQOsqwt+87HK8SiQ1E5ezFGm5x1PhTtjX/gQtEwct1mYa4zQJs
         AFvlMRGs9hvHH8HpYVLW0AdFhHdieCOeJAfFfi0hMNLSNW/tPkZfFZO6xRUvRRBK3fC0
         MbOpaXrkFrUthVX5fBFZ1GPL0Z318E4AMO17e9MMCah+m5CVApbpqKJOb9onP/2sSFWd
         w+wQ==
X-Gm-Message-State: AOUpUlGSLrKTYqCkyfQG5Lsq2+I+BHO6gsiudipAi5C9CRHLwV7x8dGD
        i03/hZVSVKNnLu4MMeyOZtYrujWG
X-Google-Smtp-Source: AA+uWPzvnQIQSdxJRao4j591zxQJX1ET6Uep9pDymReGOoWNxFuPc6zddmry8ixaegBL+DxwFZFmeA==
X-Received: by 2002:a63:b00f:: with SMTP id h15-v6mr40375587pgf.442.1534691440426;
        Sun, 19 Aug 2018 08:10:40 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id o34-v6sm2222584pgm.44.2018.08.19.08.10.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Aug 2018 08:10:39 -0700 (PDT)
Subject: Re: [GIT PULL] RISC-V Updates for the 4.19 Merge Window
To:     Karsten Merker <merker@debian.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <mhng-4afb9897-29ed-4eb4-88d7-6cfb09a0a65c@palmer-si-x1c4>
 <20180818133759.GA20049@roeck-us.net>
 <20180819072614.etl7izdicabsffn3@excalibur.cnev.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <2f5d45c1-9f18-9002-d655-90aad655b416@roeck-us.net>
Date:   Sun, 19 Aug 2018 08:10:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180819072614.etl7izdicabsffn3@excalibur.cnev.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/19/2018 12:26 AM, Karsten Merker wrote:
[ ... ]
>> However, the she system boots fine with the same qemu command line if I use qemu
>> built from https://github.com/riscv/riscv-qemu.git, branch qemu-for-upstream.
> 
> Hello,
> 
> AFAICS the qemu patch that adds support for handling separate bbl
> and kernel images, i.e.
> 
>    https://github.com/riscv/riscv-qemu/commit/6338416ecf4717197c635b5abf9c17465d2d0da0
> 
> hasn't yet made it into upstream qemu, so using the "-bios"
> option for bbl generally doesn't work with (upstream) qemu 3.0.
> 

You are correct. With qemu 3.0+commit b79cd8dec5 ("RISC-V: Support separate firmware
and kernel payload") and this pull request plus "riscv: Drop setup_initrd" on top
of mainline, my test passes:

Build reference: riscv-for-linus-4.19-mw0-8897-gd028021652dd

Building virt:defconfig:initrd ... running .... passed
Building virt:defconfig:virtio-blk:rootfs ... running .... passed

... giving this an official

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
