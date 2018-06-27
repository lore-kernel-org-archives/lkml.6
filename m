Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5B3C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0AF025A88
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1YNS790"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0AF025A88
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934835AbeF0UWx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 16:22:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35331 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934541AbeF0UWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 16:22:52 -0400
Received: by mail-wm0-f67.google.com with SMTP id z137-v6so6791736wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 13:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L6UrT5HN0GRATU3/F2heC4FHORi4kFzVh0FHHT2ibVc=;
        b=i1YNS790S+zF5g2ybnS50rEVRCSTLV+eugpYuRAAN2HT/LX7FuGjnwjAAx1yQvn6xz
         0YYoWJw3hOWF3FUw2pyDL4vEfdwNopiUewF4RM8Z1siUXY2hapKpVogmjq9sr3n8hz+c
         vHlJa8Rx0oeyNfGF5GSF2hvYvqDridl8ZpKijUOq7qPpr4zfwnFwPBBkF9P4pWHp55pt
         Rr83/3ZWc7J/FJfFrECtVdnybcadV4QvP/77rm+XxHoivQlc7KaXnnoM+bflLco+qH+1
         0D7wb5+XbMcgoAWn64Meauj/zEcP+yrlIuKFqo6boCivNiYSQOksX4VTXMx08l28taTw
         vd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L6UrT5HN0GRATU3/F2heC4FHORi4kFzVh0FHHT2ibVc=;
        b=Xpqt5PaIpZ2UFOlNLkMGXRgcZ6WOf657bTPzO4DcG9E5blAPHcxmVN2hoQLgCIWt46
         hqWTY01IP7O5tcOshw8BXP8XFZPlbdf1YNwnjzRXU9r6BPb8+7k90zJNdQSSM5cZS5Sp
         8+RV1oktOjJEGwmG6eB/12a4nJy/yWnzkNX+ydGCoYC+Sg4YEaUyQI3RGK2YQb6+dW/q
         g2DUhU07u7Gct/Z+XLvhGwCd5ME0iG8+aqyQhhCVqNKt6OgdLJDm/Y84f9aqa2ua3tR8
         Gmz5TUD1e/1a5fXSMywrKJaMzhwa1GuKn657KoXfPryTgujTRpREl+gARjdsEI6/hMzT
         /bEg==
X-Gm-Message-State: APt69E0NHbThigWmLrPYxE2+Xuiz1LRFDhZEZZnKBAXkCaQSvWjak6YW
        6vZU0BTFDA5DNYsxBcLUD/4th6YP
X-Google-Smtp-Source: AAOMgpcbd5qM0bPHptReaicty3zxzPHYsZ+7Hkn9ffmBp1rbxMIEJS+bOErhYpykP7vlUgO8Gz3iYQ==
X-Received: by 2002:a1c:328a:: with SMTP id y132-v6mr5960918wmy.70.1530130971381;
        Wed, 27 Jun 2018 13:22:51 -0700 (PDT)
Received: from xux707-tw (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id j131-v6sm5316486wmb.35.2018.06.27.13.22.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 13:22:50 -0700 (PDT)
Date:   Wed, 27 Jun 2018 21:22:50 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH v3 5/8] staging: rtl8192u: Use %s and __func__ instead of
 hardcoded string - Style
Message-ID: <20180627202248.mvohkxjhwsv5hcn6@xux707-tw>
References: <20180624153454.27356-1-johnfwhitmore@gmail.com>
 <20180624153454.27356-6-johnfwhitmore@gmail.com>
 <20180626035624.GA26173@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626035624.GA26173@kroah.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 11:56:24AM +0800, Greg KH wrote:
> On Sun, Jun 24, 2018 at 04:34:51PM +0100, John Whitmore wrote:
> > Changed a number of hard coded function names to use %s and __func__
> > 
> > Mailing list response suggest that there is a better method for debugging
> > using netdev_dbg(). I can't argue with that, but for the moment this change
> > will clear the checkpatch.pl Warning.
> > 
> > Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> > ---
> >  drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Did not apply :(

No worries, can I just ask is that because it should be changed to use
netdev_dbg as was suggested? And should that be across the whole file?
