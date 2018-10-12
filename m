Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34565C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E731020645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="fkPKl/4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E731020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeJMBqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:46:33 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36556 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeJMBqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:46:32 -0400
Received: by mail-lj1-f196.google.com with SMTP id p89-v6so12162682ljb.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 11:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QtCJdtsTB+SBmeyJofRJGy9yQO7kcyIY1ZkmG0Wj414=;
        b=fkPKl/4k5Rc0dds5yAhQPEQd9rdAeaJqYkeju1f8VJnAVS008YGu5GJs9HNyLM01zY
         zFoSYKzLmWie+Y5Xu76zYaeI/EppfqNQiFKuJdzSUVvh3//jxRXRtKtWjJBMZ3cW+0aT
         RBdpKu7ECg7qIaYiav/RLUiv25BJS0EgzORgyQ4ftvLjixgtXXEHJZgrF94O2udJQxz2
         fCbREGk/R+RyS5Rp3hDMO7syazHGkDHeCYDpdw4OAAPWHvKQPWoAWRr8LwnReCuG1XFD
         Vc7KFIV3xXRYInHD+std90fGOOnO0D7Ox9eBDj1f3tcxPwkRdakmhBJgeDI/hLNlHkvx
         115Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QtCJdtsTB+SBmeyJofRJGy9yQO7kcyIY1ZkmG0Wj414=;
        b=Uzwg9LIgFCP9qsoxhA3A/fUqPsVN9KQVni5z+y0wy2+QAwY4ZaA3Ae+/FC8q+6pn61
         ZWr8brvR6A3ES1erYl5CnPpnjZ4iGpw9/BaRW6ZsNIOAc2FlDlq/KMQu+UXt9oiinAPD
         DOlXLxBWf5bkc9buSTe2uOBBNd4YkNXQ2ddjc0LYAjoXuZUTmbOWHUAxwj7Vhpu4puRb
         KzvY9hh4MUeZXrptgkqCk46D6uaC2DDLce79rq9eYNb/4vV7IW00fIn4XZP3k48uEDdB
         pxD111+1ttDX/grQa9Q/JOeV9jUadgMjmcxVAGZvKBMCgoyy8RLee8zveXvkxFtF4zJD
         /bnA==
X-Gm-Message-State: ABuFfog5aaLwN4bJWTO/x22dXPUkjEyy/X8HCg+sqpcbcTe3h8X4KeuF
        0pPVRkdtCcD/r8/KhdQOSklRFq9J27V24nipVw6oIg==
X-Google-Smtp-Source: ACcGV63UtCpjpjvC61BsNtZ6/l5PRNQ+JhgtiWJvFm2bw0xiKmbou5CcoSOYAglSQJUcMoLfKN1b3MycVO0IstFhoOo=
X-Received: by 2002:a2e:914e:: with SMTP id q14-v6mr4739510ljg.23.1539367966930;
 Fri, 12 Oct 2018 11:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20181010182558.7034-1-krzk@kernel.org> <20181010182558.7034-4-krzk@kernel.org>
 <CAK8P3a2+wyge4=eCxJps0Ar3bYFrqjvdMakiYHBPmn3p63+GDg@mail.gmail.com>
In-Reply-To: <CAK8P3a2+wyge4=eCxJps0Ar3bYFrqjvdMakiYHBPmn3p63+GDg@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 12 Oct 2018 11:12:34 -0700
Message-ID: <CAOesGMj2m9pOsDhY92Q-ycbCQXViHatrk-SvqO+TqdzDw7DJZA@mail.gmail.com>
Subject: Re: [GIT PULL 3/4] ARM: exynos: soc/mach for v4.20, second round
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 7:02 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On 10/10/18, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > Hi,
> >
> > On top of previous pull request.
> >
> > ----------------------------------------------------------------
> > Samsung mach/soc changes for v4.20, second round
> >
> > 1. Disable SAMSUNG_PM_CHECK Kconfig feature incompatible with Exynos.
> >
>
> I suspect Olof made a small mistake when he pulled the previous branch
> into next/dt instead of next/soc, so I ended up pulling the new branch
> with all commits into next/soc again.
>
> Nothing harmful happened and you did everything right, I was just
> a bit confused by this.

Indeed, thanks for catching that.


-Olof
