Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58071ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08813205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G709n9FX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08813205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbeGRHXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:23:15 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33984 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbeGRHXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:23:15 -0400
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so6802183ois.1;
        Tue, 17 Jul 2018 23:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=cKrnTRyqDITN96Q4axqnM9Ey7VXVa9+aMfph0iy5Vmk=;
        b=G709n9FXgwbiW2odRbgw8seYVHp0eMl9UbbHBTmI8NPz7I1xLuhoG316OcXM4C5JDO
         W1n9bp/3wZd18BfSam6DyRYidjwYN6XxKhgeo285/g8dwMbXrXmqxToBUWNSZONhEkpD
         3Qnwr8WMDoiKK+2A9Cnqhbsw/kD7sKc1PslBD4eL3MLlLi/mcaMKvhOc6yXx7kZqtowV
         BOmArjBTE32D82vGagsT/9k8ryLa/4uOZ1dfHGwKRfxPUcXSf5HZUUrluX2zTXiFzgVJ
         RWTRMXmdrU/b6aVPrBzcyYva56P3NcZ2cVjUrZL9LeUD9EXk7bDyghw55bxdwuLah/FD
         I9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=cKrnTRyqDITN96Q4axqnM9Ey7VXVa9+aMfph0iy5Vmk=;
        b=OZ2Lu9Hdpyk3nv4R4vd9IderK0FesmzcU0NTaVBvjrHX1T/qqCC9QUUh2aM+oSJfKy
         u91n/91BuWf5llOWQ1o3u8k1D1t3udoMEKHRiJn55UR1p5A7M2pmePliBa5EBxbzJnCF
         8UhZnmrSzs1hNI/oYAM4hJQKtr6ZnU/3RZFKQExiY5J44hJNz6lKE7UEHNVr4W3Y2R6B
         8nCfY3qHlqam0WCgjJgMlUrmWpo9RRou4ahljUuQMcEsGDUwrPAk1QOL/lnBslb6I9Yd
         Vi8otgxOKMyQQhFjlx8+bSIzA3OSz2w2S2tqLLFHrKSFL1tzlR4wX8eT5t4yBgboYzJ2
         1DZA==
X-Gm-Message-State: AOUpUlG8E2huDOf/EYOgVnVfT/3nSXaiM3g7Cpg/1L5uyF3oLG2sv/PL
        g0FDlJIohQ4/5+45MZ+AfkSgb2kwrKYrdfMRo/8=
X-Google-Smtp-Source: AAOMgpfHyI14OKmbnnvUxD8q02tGgw2ryK2FcMBpg4b/fIyB1UMmKPRJKnOU1mRoCinyhiTHVpdmUSxe25EMBbv803c=
X-Received: by 2002:aca:4808:: with SMTP id v8-v6mr4841938oia.259.1531896415981;
 Tue, 17 Jul 2018 23:46:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:c689:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 23:46:55
 -0700 (PDT)
Reply-To: noloader@gmail.com
In-Reply-To: <20180718014344.1309-1-tytso@mit.edu>
References: <20180718014344.1309-1-tytso@mit.edu>
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Wed, 18 Jul 2018 02:46:55 -0400
Message-ID: <CAH8yC8mG8PCd6zLK=oMWdvcAryvY42g1TprUrNg7ZGVyBenKjw@mail.gmail.com>
Subject: Re: [PATCH] random: add a config option to trust the CPU's hwrng
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 9:43 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> This gives the user building their own kernel (or a Linux
> distribution) the option of deciding whether or not to trust the CPU's
> hardware random number generator (e.g., RDRAND for x86 CPU's) as being
> correctly implemented and not having a back door introduced (perhaps
> courtesy of a Nation State's law enforcement or intelligence
> agencies).

+1.

Allowing the user to set local policy is a good idea. Thanks for that.
