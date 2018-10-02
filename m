Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A7EC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF71F2089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrZTI+gR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF71F2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbeJBNZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 09:25:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34675 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbeJBNZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 09:25:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id z4-v6so790377wrb.1;
        Mon, 01 Oct 2018 23:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YgC+jWZtT87HLnwjqo8n4iVhpVAQFMI9z8ZIq7XC9uE=;
        b=VrZTI+gRSNF+JiAg2SNnod+OBuXhTMR6IB3wW6VZ3RvtJUkFT5myXd9iNCrXoiZn8m
         haWt05kugtVSpTfiWiQGE2FgjDWIDhE9t7up24i+D3DVcd7KSmgzlxzTdIT+1WyGFAej
         GgiAXluodCZToSUSTbf8jh+sXsw0F+Y2193412fqmFrBbEG2ZOfQK5NmTBSG+nipQB9j
         t6i6Tn7RqV7ba77aqQ7L42n8TjVwY4I1Z3vvm8w9+hSuqmAODUX/hOpN7f7IX3/+QGrm
         p0uTBkN8EyOo9z6gnCtuFKS3VXWT+XKmmelpJi2fOnjQkMLlT1/cCZYrEss1ZBVDn+oK
         1ueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YgC+jWZtT87HLnwjqo8n4iVhpVAQFMI9z8ZIq7XC9uE=;
        b=PTsRBzgASkMZ4ex/X18XqOGFRpRn8747BThNFqwptN/ABRV5CbnoEuoy7e8ZTPCp/r
         9sRk/Mg1Gg1v3Kfy5PaZTWfj0mRg/wKI9CGdVKhPtGBNOI4NYhduYDTP9Yk4J2eGxeKF
         Z7C24Ya40wnFkmRNFLcWnUrzwViRs6PbtXDaXU8wUdNVZVSpQEAdVkn/yWTbaTz9J+nw
         djnx/C5tvE9QAmqts2qYQbmSFvcViLEcZ7cRgauSC7vj4Vq7l2lKy3/x6pc+9WVy3DMx
         wCjrf2E2WbedkeYjVFjpvlKOrdEqRJrExVAmG8wMR+Bx8TTxMtCjHfYYGJJKmeOfk8PU
         wtKg==
X-Gm-Message-State: ABuFfojRw7v2Bqa1i8iJYYwJ9nG2tDjxM7j2UDQmKWZRegcJmX/pHM3H
        KPUMxHj8CcAFfxJHI6QYO2OkBxRG3vgsewcp+YO7LQ==
X-Google-Smtp-Source: ACcGV6190fCql76pIvGxuBPM0z5GVJwDR0bPvBDpwccsVo181xKpI2L8cVQY2L7vkggz/U8hPV9g6+RPT94BxLjWyWw=
X-Received: by 2002:a5d:4292:: with SMTP id k18-v6mr9185490wrq.225.1538462617213;
 Mon, 01 Oct 2018 23:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAKv+Gu-ZMR7zEAKv6_2tyD3OqnjVugOzKHzBEXW3pQs5W-SvLw@mail.gmail.com>
 <20181002033908.324yhwqaohfsq65d@gondor.apana.org.au> <CAHmME9piX1kbUhOBcUKVdecr45EjxuruxYuMTepfXVvRrkVmyg@mail.gmail.com>
 <CAKv+Gu8fr_qADiTJH05nVWF7Yi3U722nfKJsMaRE9CP3YjNBbg@mail.gmail.com>
In-Reply-To: <CAKv+Gu8fr_qADiTJH05nVWF7Yi3U722nfKJsMaRE9CP3YjNBbg@mail.gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 2 Oct 2018 08:43:25 +0200
Message-ID: <CAFLxGvz3tR4Fy95Zu+-gRfk19HDd_N54QLftisdJJewPWbL3xA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/23] WireGuard: Secure Network Tunnel
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, ebiggers@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 8:04 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On 2 October 2018 at 05:45, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > Hi Herbert,
> >
> > On Tue, Oct 2, 2018 at 5:39 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> >> > I would also strongly prefer that all crypto work is taken through
> >> > Herbert's tree, so we have a coherent view of it before it goes
> >> > upstream.
> >>
> >> I agree.  I don't have any problems with the zinc code living in
> >> its own git tree.  But any upstream merges should definitely go
> >> through the crypto tree because the inherent ties between the two
> >> code-base.
> >
> > I can send you pull requests then if there are development cycles when
> > there are in fact relations between the two trees. I'll update the
> > commit message describing Zinc to include this.
> >
>
> Can you explain why you it is so important to you that your changes
> remain outside the crypto tree?
>
> Also, I still think the name Zinc (zinc is not crypto/) is needlessly
> divisive and condescending, and unsaying it (in v2 and up) doesn't
> really work on the Internet (especially since you are still repeating
> it in your conference talk.)

I've been following the drama^Wdiscussion on the zinc for a long time now
and I also think that "zinc" is a misleading name.
Jason, you seem to hate the existing crypto framework with passion,
and the name reflects that.
Since we all agree that the framework can do better and your patches actually
make it better, please just rename it to something that reflects what
it is, a base
framework. I think Ard already suggested "crypto/base/" or "crypto/core/".

-- 
Thanks,
//richard
