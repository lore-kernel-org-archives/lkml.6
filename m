Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A8FC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEED21987
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lz2Z6qa/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AEED21987
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeHHAKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 20:10:43 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35609 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeHHAKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 20:10:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id p10-v6so142696ljg.2;
        Tue, 07 Aug 2018 14:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jUecAHI8bo2ypf+i9KmY87E06pX+AsuIO9Ljicjvewk=;
        b=Lz2Z6qa/yJPwrsFIRwAtjuJ09TPfqVB7JtursJXIHylF5S9rEX5s1nfgzk8/hIT6bk
         fbM1kG5oM1QWv5ngaMp4VAMYtpXzcM0uDTGSQTKeXsoEireq48YF0JxbJjgp86z+MqDl
         EpTVnW2iuM/U4uXnGcd5ABF2OL8Gp34UbR2v9a7Hkd4KqOuJvZWxrmwa9ifW0fDR7xm2
         ROSKNzP6Q2qYle37Uq5KOHBqMPdu7XxQm0RyPzstbwMME91YIlJLKsrhx9qnZuTDeh6s
         1guTbZJIWn6ws2m6+ZKGupAZ8HwkG+Da/RTWFKEpH2nq09lMzKoqJCldnRhVZbAyC/ug
         9AIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jUecAHI8bo2ypf+i9KmY87E06pX+AsuIO9Ljicjvewk=;
        b=iE/eIYMp+kVSnd1bJ2FYD8mk4T3AEyNIk5dhhLVUIM0i4qceP2OrriyFUNLUF/9Xok
         hyz5XJ0K2ZUNB8eMk6ca5zWqVnXqvzjXqRKuf6iSPG3xonnn7z8pS3HwtJB2C96c2obh
         PU5Cbum/361f9huUnvydQL6sk5WjvTmPdLPVebwxBBsq7RosR6hWXbauKcLlulnrgPBZ
         jwXfpmGGKt5zjU3EBTgopxDKhW3IuDVrGctsAUBnDj/48NcLPKqAQZoJfaVyAYLQq6hG
         rtT7ViJh3/5fETu209pQFz7dYZhaCRdhlKdmHBdfsnRqeH8XKY9J2aqj/KzFCamouz5S
         yneQ==
X-Gm-Message-State: AOUpUlG79ljVbnUK2/XiyP64uiT7zlOVJvCN0gNhTIZoHGF2XQ74GrVP
        Q3ZU7zhib97u1PMuzrrywyQ=
X-Google-Smtp-Source: AA+uWPx5G7cmTjf3v8NPjccgJMeOAaD6t96TrVB6ow8SY+qUb/s4zpNn0xVYagB4pH38wTX5ksnP9A==
X-Received: by 2002:a2e:4103:: with SMTP id o3-v6mr106471lja.3.1533678855247;
        Tue, 07 Aug 2018 14:54:15 -0700 (PDT)
Received: from z50.localnet (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id t8-v6sm467863lfd.2.2018.08.07.14.54.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 14:54:14 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [RFC PATCH v2 01/12] mtd: rawnand: ams-delta: Assign mtd->dev.parent, not mtd->owner
Date:   Tue, 07 Aug 2018 23:55:14 +0200
Message-ID: <5203112.3RHHgWL3HE@z50>
In-Reply-To: <604ff0fb-07d5-9068-2f69-41198f3d9854@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180806222918.12644-2-jmkrzyszt@gmail.com> <604ff0fb-07d5-9068-2f69-41198f3d9854@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Tuesday, August 7, 2018 1:54:10 AM CEST Marek Vasut wrote:
> On 08/07/2018 12:29 AM, Janusz Krzysztofik wrote:
> > Fix missing mtd->dev.parent assignment and drop useless mtd->owner.
> 
> You fail to explain why this fix is required.

OK, I'll have a look at similar patches from the past and add an explanation.

Thanks,
Janusz


