Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C640C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2181F2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1ncxeiFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2181F2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeH2MIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:08:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbeH2MIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:08:37 -0400
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3394720898
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 08:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535530376;
        bh=1bmp4stWztNfmlEfurUGZenrc4zSLou32o9B7y5FrQI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1ncxeiFPVUByGi6+zWhTFqhpP/ss9SKXiDl6rID9GAQ3uN58/NYVgApY12/S1oSkR
         GBikCWpbgAe1HBsqne6IPIQbKPJchBrkRTbAe5VdT2+zboP8MBCWMZqCiPjbmHyPae
         Xt08ZXJr0SzFFe3+xmnxqT6anRujHSDMoomkI5vk=
Received: by mail-wm0-f46.google.com with SMTP id i134-v6so3821442wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 01:12:56 -0700 (PDT)
X-Gm-Message-State: APzg51B0176hYbUc/FFlUaFz22j2lhErDKOk+dnO9hy9wC5ifscWgr0i
        AkARGcLXfuP3JFST2ch6VbiH2+m8IiqnQNR98O0=
X-Google-Smtp-Source: ANB0VdaxKutpzexBZwBAxCD0jJqiQkHw8vg1flQg8Ve1FVAiOIc5vRWbtfzBpMAPm7i+BgxCSp1BO47Gp/CP2idAe6A=
X-Received: by 2002:a1c:3e8e:: with SMTP id l136-v6mr3528941wma.72.1535530374712;
 Wed, 29 Aug 2018 01:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <1535527943-32566-1-git-send-email-krzk@kernel.org>
 <CAJKOXPe-fY5T8DMTgjQfrJN=b_9JcytYeeqkX9rQw6EbQ_GiXA@mail.gmail.com> <CA+7wUsxE5gUXuUzkZ5bjz_d5WXab8RQxF3bre_DAMpUW=QpKTg@mail.gmail.com>
In-Reply-To: <CA+7wUsxE5gUXuUzkZ5bjz_d5WXab8RQxF3bre_DAMpUW=QpKTg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 29 Aug 2018 10:12:43 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfFds9di8d+CHACTYLS8a1ZKc1KGAkL3z=ZyF-HEr-e+Q@mail.gmail.com>
Message-ID: <CAJKOXPfFds9di8d+CHACTYLS8a1ZKc1KGAkL3z=ZyF-HEr-e+Q@mail.gmail.com>
Subject: Re: [RFT] powerpc/boot: Fix missing crc32poly.h when building with KERNEL_XZ
To:     malat@debian.org
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        mkubecek@suse.cz, mroos@linux.ee
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 at 10:06, Mathieu Malaterre <malat@debian.org> wrote:
>
> On Wed, Aug 29, 2018 at 9:59 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Wed, 29 Aug 2018 at 09:32, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > After commit faa16bc404d7 ("lib: Use existing define with
> > > polynomial") the lib/xz/xz_crc32.c includes a header from include/linux
> > > directory thus any other user of this code should define proper include
> > > path.
> > >
> > > This fixes the build error on powerpc with CONFIG_KERNEL_XZ:
> > >
> > >     In file included from ../arch/powerpc/boot/../../../lib/decompress_unxz.c:233:0,
> > >                      from ../arch/powerpc/boot/decompress.c:42:
> > >     ../arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:29: fatal error: linux/crc32poly.h: No such file or directory
> > >
> > > Reported-by: Michal Kubecek <mkubecek@suse.cz>
> >
> > Reported earlier by Kbuild:
> > https://lkml.org/lkml/2018/8/23/47
> >
> > for the credits:
> > Reported-by: kbuild test robot <lkp@intel.com>
>
> Technically Meelis reported it earlier:
>
> https://lkml.org/lkml/2018/8/22/365
>
> ;)

Oh, right... so for the full credits:
Reported-by: Meelis Roos <mroos@linux.ee>

Best regards,
Krzysztof
