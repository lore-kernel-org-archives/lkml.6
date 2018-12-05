Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C849C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489292084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpO7Idjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489292084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeLEHae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:30:34 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43055 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbeLEHad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:30:33 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so9626837plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 23:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jZSiCAyYacb8iga9QlJKLkQGsvF0qxZVrAS+7ZuzY2I=;
        b=EpO7IdjdtRy/v6tVEsimEYxWh+BsWhYkze68XrWzp5I/yySb3kl7gODCK/g1e2dUlJ
         r44riK33q47FOiRX6sucF+x5q3bf8y6Qrdm0AxQN+tmVDlRCl3zj73uNGrHq0Dfc4FCy
         3ExBlKnR8Ut1HwXf2metM9ioMDEslQfMJ8wKQyGpL8ZNWq+VLtefsxnZ2TZcrF5IOKDJ
         qWf/b4dXmD5QxMoMMfuTHkduof2FwHLqfeX22UqeNZgAgP7hlQ9pWwmU4iOKOGky8m2C
         Fe4fYe4DF2YWWhOZunyYyvZlYALhFKs9rCy+zr723X8sbvg1AfWwQQJ8xbzopk9UsUNj
         yt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jZSiCAyYacb8iga9QlJKLkQGsvF0qxZVrAS+7ZuzY2I=;
        b=dswNH5xEJ5GhAXZW0n3eRvJQI8y+GJyjRlYEA7wMXxsEStj7HIVRK2BBbt04QHuUdR
         gKPs+rXaORafAMLjwLRoz62GTKIYFJRoeu1WbXJbC0aCNRXJ9FDABQagRQE+/sDVymex
         PE9X9kHUHhRJcBtoImHU5M17BJKWq2DMiIZRigeVwD7l76QHfzf7Vhe+nFa3bALTowlK
         7NNjtlNohvwv3ptTnYniWSwFFv08ZTfrnkEdgKiattR19oe7wWj/BXBH6o6gma6Q0VVp
         FwjcCg9ntnIfAVVeVHgAHKXL5vvOw41caKpOi9GJpFVs00gUeID+zG5EPpH2s51M3zeI
         cNMg==
X-Gm-Message-State: AA+aEWa8VPpKX4HOcf2MnhPgSNk7YdgIhhxoIsxmyMGmDMmOwDvPNPUD
        qYiqd1Bdwh2PPrDXCJ8RMZM=
X-Google-Smtp-Source: AFSGD/X3tQxbP8VzPCj99UDC4JSQuBzhWdF3n5F5NEqw9/VvuyNlPRwTUJ9MBJ1MTc202G9aJ2M5Ww==
X-Received: by 2002:a17:902:4503:: with SMTP id m3mr23478494pld.23.1543995032976;
        Tue, 04 Dec 2018 23:30:32 -0800 (PST)
Received: from localhost ([110.70.47.191])
        by smtp.gmail.com with ESMTPSA id n66sm41156447pfk.19.2018.12.04.23.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 23:30:32 -0800 (PST)
Date:   Wed, 5 Dec 2018 16:30:29 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dave Rodgman <dave.rodgman@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        nd <nd@arm.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Subject: Re: [PATCH v4 0/7] lib/lzo: performance improvements
Message-ID: <20181205073029.GA30820@jagdpanzerIV>
References: <20181130142600.13782-1-dave.rodgman@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181130142600.13782-1-dave.rodgman@arm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/30/18 14:26), Dave Rodgman wrote:
> 
> This patch series introduces performance improvements for lzo.
> 
> The previous version of this patchset is here:
> https://lkml.org/lkml/2018/11/30/807
> 
> This version of the patchset fixes a maybe-used-uninitialized warning
> (although the previous version was still safe).

Hi Dave,

Notices this warning today:

lib/lzo/lzo1x_compress.c: In function ‘lzo1x_1_do_compress’:
lib/lzo/lzo1x_compress.c:239:14: warning: ‘m_pos’ may be used uninitialized in this function [-Wmaybe-uninitialized]
239 |   m_off = ip - m_pos;

Care to take a look? (could be false positive)

	-ss
