Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DB1C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0342081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="W7xb3Kmz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A0342081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbeKAFtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 01:49:43 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36047 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729837AbeKAFtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 01:49:42 -0400
Received: by mail-io1-f65.google.com with SMTP id o19-v6so10735818iod.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 13:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gdqkYyQspsp1WFaLbhTlBRvMbAA1AboKVVjEVgVlLig=;
        b=W7xb3KmzQ3Cjid5eWduqpmNvkFD/f006k3FWCcEcbCTyNCIIizFJfGNe9BdXw+BuDM
         jMErr804r5QuM3PK2+iHwrmDMNQD/LylWrqaPQ/1WQKr4X+QRdSDmXMrI0D3tgHjiVQ/
         Jegd9rk50dOzmpcEtZE3WmNLFjYLwNtiDlMas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gdqkYyQspsp1WFaLbhTlBRvMbAA1AboKVVjEVgVlLig=;
        b=WqSQIJKPWXMEr0wbd7Wu/LevktW7CgohTmnjRJXfoBtFfLqAggFdiw31cItn4sFNg9
         gJN+nnCOJ3cL1KxLeYdcX5LedItgfGdTET9EeWYs2zZYZDqEmRm2AJdbG8wqSlCvMEeu
         bgXxuG2iPXVfChTH6V7x1gv05W02JKA72wNSb4090nGxVzyCQ7uy7JWqyfYiMHlMd9ke
         FbNX+rOrU3qh45jU9Ozmgen3wJu3mvXsRdmVIeu0qqvdZG7CpCinymri8XV7vuZJRHVg
         Ve1KLHmVmSHB2i1LpNvp3D2oiTiGfumyCS3O/XiHqmy4lwR2BbuBTfxppW6yn1Dgau9j
         kNyA==
X-Gm-Message-State: AGRZ1gIU/b0h0s9qkxauodHplbYifNkwEP+fHCGLOKBnJhRAIAQBjvQI
        4DPWQ9Ddroj8V6Uru5S8UKxY+rsg1Ey7kxCD8gV9/g==
X-Google-Smtp-Source: AJdET5fBetzoYDrLt3lBbcnEMbv987eCuUGi4Ro/GTezCwbUJ0XuM1D4fX2qOxCGldtqCKHDiPFtDj8rLp2zVbNGqSk=
X-Received: by 2002:a5e:8b42:: with SMTP id z2-v6mr2711054iom.144.1541019000450;
 Wed, 31 Oct 2018 13:50:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac42:0:0:0:0:0 with HTTP; Wed, 31 Oct 2018 13:49:59
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <7505.1541011140@warthog.procyon.org.uk>
References: <20181031053355.GQ32577@ZenIV.linux.org.uk> <87a7mut9cm.fsf@xmission.com>
 <7505.1541011140@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 31 Oct 2018 21:49:59 +0100
Message-ID: <CAJfpegtJwkrFECtLBzm8WrYhhDjbQSAuB4ZsoDzbKh6T7UZJUA@mail.gmail.com>
Subject: Re: [git pull] mount API series
To:     David Howells <dhowells@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 7:39 PM, David Howells <dhowells@redhat.com> wrote:
>> My objections fundamentally is that I can find real problems when I look
>> at the code.

I think the big risk with such a change is not that there are bugs,
but that we get the API wrong, and have to keep supporting a broken
API forever.

Were any of your objections of that type?

There's the argument about sharing of super blocks doing weird things,
but we can't get rid of that one due to having to support the old
mount(2) API forever anyway.  That's not a new burden, and the new API
allows fixing this incrementally by adding better models later.

Thanks,
Miklos
