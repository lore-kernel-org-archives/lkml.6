Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988B1C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7AD21547
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7AD21547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbeI0BCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:02:06 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:42037 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeI0BCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:02:06 -0400
Received: by mail-qt1-f173.google.com with SMTP id z8-v6so18403625qto.9;
        Wed, 26 Sep 2018 11:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/BCxpbg9rkojz2pblTJvGNuN1y2/HelgYogjp1SFgtY=;
        b=ZnMhUUkGX07O/XS6kaPH4SdjIhgsWxHHepD5yTI2x/c+CzQNKJrHtrUJp4DP8fC6td
         lhi76QfhO2y9GYuzQRTmkTM8aIiA7eb2IS2ulzKdR46Wg3pXEsETWjaxolyZTEj7g5M3
         9U7qJRSABX+T7d1hyhE1FUAoUYCkT+b2AGkrL7VkWOQ41QocKm/gG/txWGYsd8zYaS6r
         QaQLuEk8Siz4Ejbjlk2JcAqurELnz6Z9IpwQSe5dETQxjoDlqwi3BofUHMt/UogZkgLQ
         VrlZM/hqiw+zFWeADiF+JJOdGv3LLqdFnEBuiHkw+AaDYPn9MOjvS50oUQipqCnvSFb4
         0QOA==
X-Gm-Message-State: ABuFfoiC5noHcmE45Si3TXT0DHO78YsqqbU/+Qxc1PwVkAJsxPb2EqCf
        W2PFArYfnSeB6rl23faMSdHTg6rDAAy+15DXcVKnhQ==
X-Google-Smtp-Source: ACcGV63biRXn1bn+fcZlYnKSwBiANk0DUZbnqHSBN4TORyAkS+Ywt5ImZ868CqyKG0WDAT+af4TyaGjRpepoUA1BG/E=
X-Received: by 2002:a0c:8834:: with SMTP id 49-v6mr5318375qvl.40.1537987667499;
 Wed, 26 Sep 2018 11:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180926124808.1867468-1-arnd@arndb.de> <20180926160328.GA1927@archbook>
In-Reply-To: <20180926160328.GA1927@archbook>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 26 Sep 2018 20:47:31 +0200
Message-ID: <CAK8P3a0oFdEkt7NqWzs6_9rMiHaQ+Sn7v+HDV777rO_SUTbREw@mail.gmail.com>
Subject: Re: [PATCH] net: nixge: fix warnings on 32-bit platforms
To:     mdf@kernel.org
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 6:03 PM Moritz Fischer <mdf@kernel.org> wrote:
>
> Hi Arnd,
>
> On Wed, Sep 26, 2018 at 02:47:24PM +0200, Arnd Bergmann wrote:
> > Making it work on 64-bit caused 32-bit builds to regress:

> >
>
> I had submitted a similar patch https://lkml.org/lkml/2018/9/24/1719
> here. I should probably add the Fixes tag yours has but other than that
> they look largely equivalent. Comments?

Yes, I'm sure your version is fine as well, sorry for missing that.

Adding a fixes tag is generally a good idea, but no need to resend it.
We just need one of the two to get picked up into net-next.

[note: we both forgot to tag the patch as "[PATCH net-next]"]

       Arnd
