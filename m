Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD73C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D7920684
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WfoxFxJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D7920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbeI1W3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:29:19 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:43361 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728920AbeI1W3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:29:19 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 6937446a
        for <linux-kernel@vger.kernel.org>;
        Fri, 28 Sep 2018 15:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=x1/sLvH/+c5tgi4shPbvR79dEK8=; b=WfoxFx
        J4qpmkHDP6QsEOIbhoR0mpo/VWm17ngdpvUzJyfa23PgyTWxqrItVwMl3w1k1BsW
        hrpwIWcMFQRaG+N5/6cdo5P25Iot3UzlPJ2UnXpBrf/uJDqcbot3Mv3WyRB1X1YA
        Q1ACBFuum0N0mu6W+1+9EiaORxK151U9uE9SeLdyHeXxTDxW4ww06F6Qx7khuWMC
        84h3Xh3Ep16b55xCRET6Woyz+aFwjwMMIT65YVTDcJlX27MZPz+XrceF3MVHAMO7
        g/J43r2p0P3km98q66QC3evYuiXwvObcH6FD9NIur6qqWlgh1cyHM7S1CLi6cQ5Z
        3SXT7dMigBevUMhQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d7e892a1 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 28 Sep 2018 15:46:04 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id c12-v6so6523922otl.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 09:04:52 -0700 (PDT)
X-Gm-Message-State: ABuFfojdW4+qJmppmq1dWGkg5kGFHCTUlEeVJMzRAZcfBYPy9qT6QwSs
        h/8oQyE+on8t73p/XQqsk/S8BN/sOtApr0U1HnI=
X-Google-Smtp-Source: ACcGV6339vc4SegjzR+FwjYJtWIzX+nIiCAceESvHFUB/gF6XQJ5hfgR5xU3vxAwow3VgaM9WRCnU/pQ1oxdAs62e6g=
X-Received: by 2002:a9d:42c3:: with SMTP id c3-v6mr9830766otj.54.1538150692066;
 Fri, 28 Sep 2018 09:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180926135110.13061-1-Jason@zx2c4.com> <CAK8P3a0+s6DM=QUqS_KrNp+95aDj2QTsWb+w73piwLsQFvq+pg@mail.gmail.com>
In-Reply-To: <CAK8P3a0+s6DM=QUqS_KrNp+95aDj2QTsWb+w73piwLsQFvq+pg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 28 Sep 2018 18:04:39 +0200
X-Gmail-Original-Message-ID: <CAHmME9o_6o_wB00kASJdqJyWt2wFH2FqdzXOm8RLA5VeCibDJg@mail.gmail.com>
Message-ID: <CAHmME9o_6o_wB00kASJdqJyWt2wFH2FqdzXOm8RLA5VeCibDJg@mail.gmail.com>
Subject: Re: [PATCH] arm: support big-endian for the virt architecture
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, Sep 28, 2018 at 5:59 PM Arnd Bergmann <arnd@arndb.de> wrote:
> Applied for 4.20 with subject line changed s/arm/ARM/, thanks!

Thanks.

> I think most people just build a 'defconfig' kernel, which includes
> multiple platforms that use ARCH_SUPPORTS_BIG_ENDIAN.

Right, that's what it looked like. In my case, I'm doing CI on some
homebrewed infra, where I'm building lots of kernels for lots of
architectures and testing them in qemu with various tests _for each
and every commit_. Not having a server farm as impressive as Intel's
0-day infra, getting compilation times down is rather important.

> Your patch is certainly fine for 4.20, but since we haven't decided
> what the proper fix should be, I didn't want to push this for 4.19.

Shucks. It's not like this patch makes the situation worse; it makes
it better. But I understand and will wait for 4.20/5.0.

Jason
