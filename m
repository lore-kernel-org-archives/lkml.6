Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F99AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D3020644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D3020644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeH3Ckj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:40:39 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46553 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbeH3Ckj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:40:39 -0400
Received: by mail-oi0-f67.google.com with SMTP id y207-v6so12039170oie.13;
        Wed, 29 Aug 2018 15:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iyVNvuKDkaqg4j1qAYltWZWdbEsfmd9Rl0jK98MRAwk=;
        b=ewzp3kT/FF/emWAiJRbycZc6C7Y6RF84Rtxju+7ZHb+uGrrjPyks1X+yk86YRRhJy9
         st/5rLRTbdznD4q9fmWJLF6nuMNGjLOem4SFwQZOiuabpbJYLPN786YAj8QGmeXPmxYQ
         h99Ylsb1BniqXZgGQAsPIxugrQkrbmM0pShBYEjY0MSEUM/tW1mXQQAcCD7kWMkhDzRy
         Hnxn935w9zQOm37dOvjVG1B6xhohHMVV6Fobgnk3zX42QYW32ov3jmFyIv+GO+SXpdWN
         GESCtxW/D4xJxMDBNpSMkILGhvsAeOirFY3Q4+1Ary6RYoT6O/t0SqKuONUuVodOvg7c
         7HPw==
X-Gm-Message-State: APzg51AGUr3QhiUkNd1tk4gck3Is9RS9WRSIJnLWDG4LuWhPC+utNF0S
        AJ0lN5C9+lNpYZ7gcvYIu+xnlLTKZcdMPQ==
X-Google-Smtp-Source: ANB0VdbGazKarvTeSLHefJcfRcGT9xiSRetYCPP6zccoY966I+8C63R2Fv44afzp9m6W5gxDhKChmQ==
X-Received: by 2002:aca:b885:: with SMTP id i127-v6mr125960oif.180.1535582494544;
        Wed, 29 Aug 2018 15:41:34 -0700 (PDT)
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 16-v6sm2686240oin.5.2018.08.29.15.41.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 15:41:33 -0700 (PDT)
Received: by mail-oi0-f49.google.com with SMTP id k12-v6so12080146oiw.8;
        Wed, 29 Aug 2018 15:41:33 -0700 (PDT)
X-Received: by 2002:aca:b2c4:: with SMTP id b187-v6mr121588oif.160.1535582493252;
 Wed, 29 Aug 2018 15:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180604115842.7c4vzge3igjbnblt@kili.mountain>
 <CA+7wUszWKm+qZQ7CQu3Kn7-aYeM-hSet03_PEh8EswNn141nyw@mail.gmail.com> <20180829093948.c7nbl27ju4uszrum@mwanda>
In-Reply-To: <20180829093948.c7nbl27ju4uszrum@mwanda>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Wed, 29 Aug 2018 17:41:21 -0500
X-Gmail-Original-Message-ID: <CADRPPNSO6bWwaEm9j9VpsTqujroSHVS-=bkCvWzAC2B2oTcctQ@mail.gmail.com>
Message-ID: <CADRPPNSO6bWwaEm9j9VpsTqujroSHVS-=bkCvWzAC2B2oTcctQ@mail.gmail.com>
Subject: Re: [PATCH] fsl/qe: ucc: copy and paste bug in ucc_get_tdm_sync_shift()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     malat@debian.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        kernel-janitors@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Zhao Qiang <qiang.zhao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 4:42 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Mon, Jun 04, 2018 at 02:06:45PM +0200, Mathieu Malaterre wrote:
> > Where did the original go ?
> >
> > https://patchwork.ozlabs.org/patch/868158/
> >
> >
>
> Btw, we still haven't pushed a patch for this bug.

I will combine Zhao Qiang's patch with your description which is
better, and push as fix for 4.19.

Regards,
Leo
