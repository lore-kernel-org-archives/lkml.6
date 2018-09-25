Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B17CECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12AF214FE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpOVBuyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12AF214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbeIYWZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:25:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42299 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbeIYWZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:25:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so11908502pgp.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 09:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ac50KRWR4I/WgzK2QxQQiDUhLlXrxvUg/Jl7ee3s5T4=;
        b=dpOVBuytB1mjufgFExAal1EU87NGFPg1ncJLbusLJNWuIjavVFQxtGUg558nIpYHQi
         J/4wozF9nT67RvCkjk3s8fPd/cn/KaHwXRGzqCZ2p1Tg00lnxCrjj5XLdxg4p/OOVlc7
         vHqYdV5Qz4DlLEue98w/tyQHqrdhyGGlx56axK8Acq3cnNmkoOJBtegYaGXBzoSMUT2T
         T2ElQHEaAAPijTAODGUpSehO+fUmC/AUv4pNg5GngpqzqBbwkoYrRluJYeE0nt8qLR/Q
         lAYDkGcJzIM8Psx32eNIBRNvc94c265XZktyxofJUAFj5PzMU0bC9mtWBnrwLO/sSqHM
         Z4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ac50KRWR4I/WgzK2QxQQiDUhLlXrxvUg/Jl7ee3s5T4=;
        b=c1wefZ+OI4GbOGZSg6E70Lj2aTxCruBQzaIhIgIEbrqoEIIqJxUcngeW/TPG4wH0lR
         BXVo4WR8uHwUr7mNnbij5u/X0RmJSvyErr6O1hLkcPuypp5xIASoCDiZAghFC2ZxK4QX
         MCA5A1H5iT75kYlZnerJPiW+hl4KtbWomF2NrY2/kR9NBXsNyWRA3ulJkkc4RZ36wWyo
         zxKxt3gBuVdQ4MJo+4IPjpnTXjPPnHtW/mcA5d5FkkrbfM+r7dAy3eKHVmOoKRUKFZp1
         5yhqqkufEvTalGU8dTK7jl+KaTmA4GqVjlgupQuAkbMRJ3lwgC/HoV3rh5nzuKwLVLzJ
         q9ag==
X-Gm-Message-State: ABuFfojYpEkAUqxznyjoDUZup92Zx+nmG71yxiBC4iB3RRoMKjbvat9Y
        4dLNiME6gApuTHz09CLCD6KjSiyhl3v83g==
X-Google-Smtp-Source: ACcGV62C3+0iRgN7CBg4Bd9ON+Ds35+7TbktZNR2t7gdUeUxxy2CuSdT+cYFHPXPOT1WAccLse2Lkg==
X-Received: by 2002:a63:f344:: with SMTP id t4-v6mr1783914pgj.428.1537892254219;
        Tue, 25 Sep 2018 09:17:34 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id o21-v6sm4559522pfa.54.2018.09.25.09.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 09:17:33 -0700 (PDT)
Date:   Tue, 25 Sep 2018 21:47:25 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     NeilBrown <neil@brown.name>, devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] staging: mt7621-mmc: Fix single statement macros in
 sd.c
Message-ID: <20180925161723.GA23387@nishad>
References: <20180923093805.GA20870@nishad>
 <b0f415b5b9655571374ab30e37406b494d07bc45.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0f415b5b9655571374ab30e37406b494d07bc45.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 06:31:32AM -0700, Joe Perches wrote:
> On Sun, 2018-09-23 at 15:08 +0530, Nishad Kamdar wrote:
> > This patch fixes a few single statement macros in sd.c.
> > It converts two macros to inline functions. It removes
> > five other macros and replaces their usages with calls to
> > the function being called in the macro definition.
> > Issue found by checkpatch.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> > Changes in v2:
> >   - Convert msdc_gate_clk() and msdc_ungate_clk() to inline functions.
> >   - Delete msdc_irq_restore(), msdc_vcore_on(), msdc_vcore_off(),
> >     msdc_vdd_on() and msdc_vdd_off() and replace their usages directly
> >     with calls to the function being called by these macros.
> 
> Nishad, do please look again for uses of these functions
> you are changing.
> 
> Please try removing all the #if 0 blocks instead, and then
> see if there are also now unused functions from those removed
> blocks that could also be removed.
> 
> And Greg, if you look at this, look at the odd license of
> these files.
> 
> It's possible the license is incompatible with the GPL.
> 
Ok, I'll look into that.

thanks for the review.

regards,
nishad
