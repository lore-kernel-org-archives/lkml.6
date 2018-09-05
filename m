Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A88C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237042073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KK0Tb6Ia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237042073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeIFBYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 21:24:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43774 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbeIFBYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 21:24:09 -0400
Received: by mail-lf1-f66.google.com with SMTP id h64-v6so7178656lfi.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 13:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aicMK5C5D2SvUUEKHEW1kmfcWOpCYDrAlSXyHY0cfgw=;
        b=KK0Tb6IaIoJr9spg3wVI4hej2wOuPO62csrN+YXvRu/nHrYyS+dkVe7wra6bxQn8Rn
         FTcgwcZ7G/N/QHxH2v9n5H/5OMiJjWkn79va0JQsGLvlGeVxnm9/SiWAJPkuYSpDv6US
         OvY+yPLx/uwR7mh4q7vuPxJOQiYzcOdRMLEAtf7pgrvSaUbWYbg4AHA4lPw1dt524JBx
         uax5zwltWdQPNfy5W88Tiy3UxyHIEh6bpPLEVBupCBTn6Ny8ShIgK6dnzHhVZvXGEdSw
         9vk83s5SQ3WbL6+1E+dhcXO8bEeZNJhzVlombXoCY1eLLUEjQjvkVUbeYXPJGU85txNO
         UzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aicMK5C5D2SvUUEKHEW1kmfcWOpCYDrAlSXyHY0cfgw=;
        b=dUBRJrzrcFuL39uKvgkN9jpW54+Dz6n4EntRlJo25ui9SUOq/m7LoaBpYHnqXwGSBY
         NSLCu5p9cpCGAgIMyohulVcyuSrPAgR3Je4Yo1nJ8kfHY9H/XAhnbjrcYAqFSi1GistY
         vkDd2tFZZ5+4Iwd/hBzMiGXra0w6DWsrHEOPwwxMEefl31mPd0D6dcXu8OPIzRjbaUWq
         2UCQjFcOYj16aGLqgIV0Lur4QeuwhThLptZMbg0OICu71wpGK1Lp8a8bzUbn5a7DL04j
         D11hRm6ey9vDGl3e2tZskm1/KqR8onBx1ZMN3jUALiCAb2jcX/9bb6KoHY8y/+22HkLV
         Wx+Q==
X-Gm-Message-State: APzg51BdEBAiqAKgl7yy8RaUu8GWRFLbXlywzF/6DgQ5k/lUj86itCwk
        wxG1HOMRNjbQ5aO2QB711LvAujIWTSk=
X-Google-Smtp-Source: ANB0VdYf8ePGLUyiaCBQ2Dbg4LeYHUOTawdnVoY1LBOlA9BHwWxAhWQESZd54hc979UFbjyvmKIT2w==
X-Received: by 2002:a19:8f10:: with SMTP id r16-v6mr25973982lfd.1.1536180733200;
        Wed, 05 Sep 2018 13:52:13 -0700 (PDT)
Received: from z50.localnet (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id z5-v6sm467137lfg.75.2018.09.05.13.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 13:52:12 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] mtd: rawnand: ams-delta: Cleanups and optimizations
Date:   Wed, 05 Sep 2018 22:53:27 +0200
Message-ID: <1855340.fVHtouTg44@z50>
In-Reply-To: <20180905084757.432e7c19@xps13>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com> <20180820213904.13475-1-jmkrzyszt@gmail.com> <20180905084757.432e7c19@xps13>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel, Tony,

On Wednesday, September 5, 2018 8:47:57 AM CEST Miquel Raynal wrote:
> Hi Janusz,
> 
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote on Mon, 20 Aug 2018
> 23:39:01 +0200:
> 
> > This series consist of possibly ready to apply patches extracted from
> > a former one titled "mtd: rawnand:  ams-delta: Use GPIO API for data I/O".
> > Remaining patches implementing conversion of data I/O to GPIO have been
> > postponed until gpiolib is optimized to ensure sufficient performance.
> > 
> > 
> > Janusz Krzysztofik (3):
> >       mtd: rawnand: ams-delta: show parent device in sysfs
> >       mtd: rawnand: ams-delta: Use private structure
> >       mtd: rawnand: ams-delta: Set port direction when needed
> 
> Patch 2/3 does not apply on nand/next. Indeed the driver does not look
> the same as in the diff.

That's because I built it on top of my former series from the mid of July, 
containing "[PATCH v2 2/3 v4] mtd: rawnand: ams-delta: use GPIO lookup table". 
It was acked by you, Miquel, and supposed to be merged via linux-omap tree.

> I don't see any changes on my side that could
> explain this so perhaps you could rebase on top of 4.19-rc2 (or
> nand/next, as you wish) and resend the series?

As far as I can see, Tony hasn't applied that series yet, so maybe I can still 
move that patch out of there and insert it into this series in front of the 
other 3 patches and resend. That would however make patch 3/3 of that old 
series depend on this one.

Tony, what do you think?

Thanks,
Janusz



