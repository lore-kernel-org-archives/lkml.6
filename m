Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F140C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97882075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEsX2hfH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97882075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=welchs.me.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeIGNND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:13:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44763 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbeIGNNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:13:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id v16-v6so14038736wro.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 01:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zQxrkgCzYHSL+l76yzAd+wSLg7FaP2gnD0zA79Idmhc=;
        b=aEsX2hfHJ5V6oCRBbzvezoULWU8qiOC0ZtAgpeWY6iCLpWT9+UWyRRDKSchPsyFfXh
         nEPM9+TG+A1g8Vbpk0UJ6hEl7gjLnUdN4IFdhiYDwArMJgWtZlXO6RRJGhevoKkArwKk
         xOtdsgJ96gMUNHV1NnghqVXvcO+MN7Rib8/H0KVyTrxfc4KHD827RgspG6f45MC9L5Ir
         zzeouqlRK0meTRi5Tg/LXpavUf1LUhFauaGZrZk9Az3c/v2rRjDd/dp5MhWFH7cDJI+o
         YpalsVEbgzsiKXa+UssMCEFTWLEBi+AsL3Ndqvhjp3kL8fO/CaFFhknFXP0VmizUjUkM
         iUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:message-id:subject:from:to:cc:date
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zQxrkgCzYHSL+l76yzAd+wSLg7FaP2gnD0zA79Idmhc=;
        b=dvoCxxMHU67HqUFNrL+1SdVbAuXQ9ZoyQdU2tzlaDl4i7mvnKqYhhAjM1RDSfMyDNf
         GvFTAbwwppzTt1sZf+xtNJT/sDkEebhVedvwtv0fnpzAbNfLAN0HqeqLTzZFfYDz1kus
         VRYRPCqQrprpf3vKhOApaIeNKphv2nJzaJ7k1vY18hMdUi0WkcILFGbTbTuYVPYNuecr
         JxpkBkNCdt2Bm2PLVltW3JkIgJbVdg8Csspe6h85lqWCQLOnBqDHkI8ajD3i4PytOt+C
         39vBzhrARhzXf0D73hNBW1zuqhiy4/ZO/xl2sVxe+zGGJbSYFC1sA9NT94NDkDWrCY6p
         oUrg==
X-Gm-Message-State: APzg51BOMeRDFWHCbzJoFw+qFr7zhgTCJLwAxM73i5QHCMzhMZ4Lq9w9
        nAimU3UYH36jUuvHYCKRK6Y=
X-Google-Smtp-Source: ANB0VdYwca6rBYw3rS6X7GCdqbKZGUJwFKK0z2J/sxBzhfESj38MuyPUM/Hjg6EUlykaWEO/5K2Vzg==
X-Received: by 2002:adf:bacf:: with SMTP id w15-v6mr5575829wrg.203.1536309189960;
        Fri, 07 Sep 2018 01:33:09 -0700 (PDT)
Received: from broadband.bt.com ([2a00:23c5:58d:db00:68bb:47d:d5ca:9abd])
        by smtp.gmail.com with ESMTPSA id x24-v6sm11381090wrd.13.2018.09.07.01.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 01:33:09 -0700 (PDT)
Message-ID: <1536309188.8050.9.camel@welchs.me.uk>
Subject: Re: [PATCH] vme: remove unneeded kfree
From:   Martyn Welch <martyn@welchs.me.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        dingxiang@cmss.chinamobile.com
Cc:     manohar.vanga@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Staging subsystem List <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 07 Sep 2018 09:33:08 +0100
In-Reply-To: <CA+55aFxuha1tQXcn+WtbOKzwwmtA8AORb04tMM=hk6jT3ntt3w@mail.gmail.com>
References: <1536223870-6324-1-git-send-email-dingxiang@cmss.chinamobile.com>
         <CA+55aFxuha1tQXcn+WtbOKzwwmtA8AORb04tMM=hk6jT3ntt3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-09-06 at 22:04 -0700, Linus Torvalds wrote:
> On Thu, Sep 6, 2018 at 1:51 AM Ding Xiang
> <dingxiang@cmss.chinamobile.com> wrote:
> > 
> > put_device will call vme_dev_release to free vdev, kfree is
> > unnecessary here.
> 
> That does seem to be the case.  I think "unnecessary" is overly kind,
> it does seem to be a double free.
> 
> Looks like the issue was introduced back in 2013 by commit
> def1820d25fa ("vme: add missing put_device() after device_register()
> fails").
> 
> It seems you should *either* kfree() the vdev, _or_ do put_device(),
> but doing both seems wrong.
> 
> I presume the device_register() has never failed, and this being
> vme-only I'm guessing there isn't a vibrant testing community.
> 

I think that is also overly kind :-)

I currently lack access to suitable hardware to test fully myself and I
need to find some time to (re)implement some automated testing, after I
lost access to the bits I had when I left a previous employer. That and
see if I can get access to some hardware again...

Manohar, do you still have access/interest in the VME stuff? You've
been very quiet for a long time now.

Martyn
