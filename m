Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3510C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20082082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IG1OwiFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20082082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeLAJ1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:27:18 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40655 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLAJ1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:27:18 -0500
Received: by mail-io1-f65.google.com with SMTP id n9so5796642ioh.7;
        Fri, 30 Nov 2018 14:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oVzBtN914q6EzXKNYNh6PRKkKte//m2rnZUeB3SW3XE=;
        b=IG1OwiFegeIL1RSasQsovnr6hcMm4zG/lbe1y+b2sbAUs81HQS26ND3piDkdJMXsLN
         NZKY6HmQT8iqJpfpNdDPASIQdq18GeCARl3L10NP8UW8kKYpqFFQ3VukX04suyrrPpVv
         ndiw44oFC/Qeuo7LAAhzgDMSNLuZBVTVvdAoVy4UlGwLwYSMu096W2hHNazWEezROp5E
         wpE1Hs5Zbig8eETZSI0iee/sc/aPuW36daiX6msVB8eyeYkOtEZA3+z4/oydp99rFgsC
         WhD3PPMm2runaLjmNrHPvr+P7poA8kNhdR/bPs4X2iwszP8w+CvAW+i6a/zK8oD8X0AW
         yffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oVzBtN914q6EzXKNYNh6PRKkKte//m2rnZUeB3SW3XE=;
        b=inrXNQS7XfbTIAgCPMciMpRKe4/XVVKVjcz+7v7H0MSdbmpqwIpBXceDjPgEI+VEit
         ZFSdVNhrS+KxwwVvyx0HxE2ZdpgmuWw0/vbLxAPrzDt0cvgG5P9fZ5YIZDkNNGlKX2gN
         vz5sUu2q3ckEauG793Pv1kTbqoERyb/K5f/WSMb1PBYONMbBGe5wry9BZ4Ei4X5S+edh
         4umh1IDV9zFDnFZ4xPSvTt6YwSfxwJ5mkN8nnK6/4lxSL9sLB0YeG98JFcGdnGJdasrJ
         tJmqZEmTKUC6UqVzwiUybPEqNzaGMrbl7LmAhqxbLql2WJVnU68wBx7c92q/KvV2WvVj
         maEg==
X-Gm-Message-State: AA+aEWa0ko3YNkUHrfmYHEyh3D7ywQLYcqZNfHxMTjfjEhU1bGv4HGlC
        XasbJgL6ZkKIvxLpWwaWDdvd/9P17yQTvzxvSTA=
X-Google-Smtp-Source: AFSGD/Xdf9uE6JHumtyCuaGVcKhwahsLFix38YmDxmkSGszDpYooLFylKlGxPXIv3Yuv1S8wYlD8qyw9RN702aRiyio=
X-Received: by 2002:a6b:3b4f:: with SMTP id i76mr6556132ioa.266.1543616192312;
 Fri, 30 Nov 2018 14:16:32 -0800 (PST)
MIME-Version: 1.0
References: <CAF=yD-JGh23sA_6eUtBq8=wSZ5g=nipmhdr1WwjP5th51qEtiQ@mail.gmail.com>
 <CABeXuvqgPE_Cft+T0fSw8zT09uCKWQGUB+bVNqQDk6fOinn8rA@mail.gmail.com>
 <CAF=yD-LjfVKSr=KhknZHhN-M2-ZdLE9g0XR8Ta4rokx24arkBg@mail.gmail.com> <20181125.101953.2072129230580561127.davem@davemloft.net>
In-Reply-To: <20181125.101953.2072129230580561127.davem@davemloft.net>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Fri, 30 Nov 2018 14:16:21 -0800
Message-ID: <CABeXuvp6tBvuHu94H3qHkhu48KXadRwZ_3aNZn0_fEjZyXsnvQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] socket: Disentangle SOCK_RCVTSTAMPNS from SOCK_RCVTSTAMP
To:     "David S. Miller" <davem@davemloft.net>
Cc:     willemdebruijn.kernel@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Network Devel Mailing List <netdev@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 10:19 AM David Miller <davem@davemloft.net> wrote:
>
> From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Date: Sun, 25 Nov 2018 09:18:55 -0500
>
> > The existing logic is as is for a reason. There is no need to change
> > it to satisfy the main purpose of your patchset?
> >
> > It is structured as one bit to test whether a timestamp is requested
> > and another to select among two variants usec/nsec. Just add another
> > layer of branching between new/old in cases where this distinction is
> > needed.
> >
> > Please avoid code churn unless needed.
>
> +1

This patch makes it easier to add logic for 2 new socket time options.
But, if you prefer for all of the options to depend on SOCK_RCVTSTAMP
then I will drop it.

-Deepa
