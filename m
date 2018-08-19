Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADAAC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 17:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA932064E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 17:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Btig/yxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA932064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbeHSUWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 16:22:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32916 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbeHSUWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 16:22:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id r64-v6so4472330pgr.0;
        Sun, 19 Aug 2018 10:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VmrvWYiUFkMCzOJi7nQ/FQo6K9zp5CZ5wTSajE51i74=;
        b=Btig/yxz1BPVHpDVoo9TK/dsJhHv49523olzNc6gBnipobpTvb1rbYtYRPsRsRXUfY
         4ypUmr7++DeUMGJdGiz6b5x+3uz36NoCRO/BY+x/WKS4i2C21gAugW7Vl5f/cP2NRfSm
         PFsGdbK/ORvaL52xsJ/f5N0ayefsGvP5rZ33ysL7zrOvx7ANG/9/5GvbkyPe0WLzJ57n
         2H4qBXe8JEhrqmwOLc7sI7yagxTo0oqEBCf/XOSpf/e9aTUt9UsPuixniWY2jzvLsu9k
         gqkHKMhIZ9gwPZEnkEF0arQ1JauzjXXWGnxPHd2P1g8wQzUCowUfnsxzrQY+bMPW1Bie
         9g2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VmrvWYiUFkMCzOJi7nQ/FQo6K9zp5CZ5wTSajE51i74=;
        b=DQU1OEB0T0G6z0Z+Tjp7QNOt9v0OTrqZy9Gu29YUhhiLpuuop/6oE85fVmn30IlTcK
         6FlAWgYscWz+uMk2bGhxXE1+1h5p3B47oiVijbG6vfRj/UuYoiVBBaL7+WUKI5uyNyFz
         uS9fBv1yi64Wp9v0jPyS+hQ/Khnk7F41+MW/ZW673l79N3SGPypXs0u4ch2NO2lfppPk
         5zrMIQX+NOjcYh4Ga+Epwjyqvz8lTkTfWh+E0Bcd+u2oeEPyGo/kdSMfd95N/FqEcfaI
         bFdifnUxkEwZLxVZnj3fhyNlY4rNV2ROqqN7IKauuEOOFdV3vBl2b4UNAap+FxQvSfze
         9tZQ==
X-Gm-Message-State: AOUpUlHNDz3MZqMP/K4DC3fYkvFU0ms8rg5fK3iaIDxitdWqXEiyzQO2
        THrIlHdH2pX/VJblfnLhH+NCOIBFAl8=
X-Google-Smtp-Source: AA+uWPxxb+HgiN6uyIyJV0sqqfLQolRyuH75TTa69jH9xxwbTlL6NkxKj7z7ABlflHDgMCUpgxkSaA==
X-Received: by 2002:a62:c218:: with SMTP id l24-v6mr44973303pfg.185.1534698622018;
        Sun, 19 Aug 2018 10:10:22 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id l84-v6sm13361705pfg.3.2018.08.19.10.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Aug 2018 10:10:21 -0700 (PDT)
Date:   Sun, 19 Aug 2018 22:40:14 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     dpfrey@gmail.com, daniel.baluta@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: bme680: Add check for val2 in the
 write_raw function
Message-ID: <20180819171014.GA13175@himanshu-Vostro-3559>
References: <20180811102636.6171-1-himanshujha199640@gmail.com>
 <20180819172514.370d34fb@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180819172514.370d34fb@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2018 at 05:25:14PM +0100, Jonathan Cameron wrote:
> On Sat, 11 Aug 2018 15:56:36 +0530
> Himanshu Jha <himanshujha199640@gmail.com> wrote:
> 
> > val2 is responsible for the floating part of the number to be
> > written to the device. We don't need the floating part
> > while writing the oversampling ratio for BME680 since the
> > available oversampling ratios are pure natural numbers.
> > 
> > So, add a sanity check to make sure val2 is 0.
> > 
> > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> 
> As discussed in David's patch series v3, I think this is still relevant
> but now needs an update to cover the new code.

I already had informed David to reabse his series on top of my patch
and he rebased this patch series.

So, it should apply cleanly without any further effort.

If it doesn't, then ping me.

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
