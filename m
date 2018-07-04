Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D990DC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA06224E6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3fG3nd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA06224E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbeGDPQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:16:37 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43412 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753322AbeGDPQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:16:31 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so11328315oib.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 08:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k2YSF112OJ0y3vX2BHc4M5kCk2xUB3kaatEDQDMGPY0=;
        b=I3fG3nd2wN5J4oK11EVtcGSuivU7QCEy7bgO6TRxDG/BXu4eWbCdCwyR2gPJ0+K9im
         7H+7PZHhyNNYvX2MCpgY+ywv/5Nt344DLYwC0JaviKNvkIBJjXyBFZhRbJqOs8DDcKyK
         Wd48zabBYb1dgCkky8CYCknDq9MaXMj/wljQmWNRmmPFai1apbz2QmXN2fkTtdLpwhdy
         N1hGDPk2gyGuENFrfk9wVCsEQ55M6r8e4+XiLKhrpcd89bp28HR3EGc/WqmiQOAW+xJO
         O5GAxMqDn712KyFdL8y+77zuopiv4fFrHqxhG/d/rlhHyJdR5FCG48/y43lAvfC09GS+
         bAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k2YSF112OJ0y3vX2BHc4M5kCk2xUB3kaatEDQDMGPY0=;
        b=FTVWnqw73w483ZsBeD+2SLOWbJjdEynD/71owEKeDANPIK6UOxnXURjFMiSqh8qzek
         jnE6slqSDYip4Ust7008MonqFqBrNydhD+0F7gATnfK91G/HaVkWy3UscDjPQFMBMWNj
         MjlYRQzzAf+pUqjJfZsLsMENwALEGo/WqVOr0kaSgIp0fMNSTzJQwPJ2b7RwCGgDvF7g
         UVXsz5ZMvp9wgCW6AjKNQgRD0RgYo5eeIyx9J3/XbYBH+vy7zYWK7N7gpn2/s/xZnnp6
         Az9HOcrfTB3Hh4jBwCsq+5MO+otQ4bsjJI2mglRJyGkF77Bfstx7IzyldY9EmljKlul4
         ITnQ==
X-Gm-Message-State: APt69E2qYX+4YYGzNbabPKuoONXGdcgJPRwJcqYIAlOdRXbaS/7eYbAF
        udMHjQqDgf0eNELwTGEzPBU=
X-Google-Smtp-Source: AAOMgpcjEG20ArOyGC84dUL0fpDCLj5LO/5vzwHwwGvYvmkcvGYFMQPm0nP7AiXvSHYAWJaWGUsuDw==
X-Received: by 2002:aca:fc08:: with SMTP id a8-v6mr2481218oii.196.1530717389830;
        Wed, 04 Jul 2018 08:16:29 -0700 (PDT)
Received: from localhost ([12.130.117.108])
        by smtp.gmail.com with ESMTPSA id a1-v6sm1519469oti.70.2018.07.04.08.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 08:16:28 -0700 (PDT)
Date:   Wed, 4 Jul 2018 15:16:22 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH 1/2] Revert "mfd: cros_ec: Remove unused __remove
 function"
Message-ID: <20180704151622.sncbvlrlv3tuilrp@penguin>
References: <20180620213033.100455-1-dmitry.torokhov@gmail.com>
 <20180704064811.GD20176@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704064811.GD20176@dell>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On Wed, Jul 04, 2018 at 07:48:11AM +0100, Lee Jones wrote:
> On Wed, 20 Jun 2018, Dmitry Torokhov wrote:
> 
> > This reverts commit 556c242045f0c1613aac2e64dc5b2ff0e4bc89e1.
> > 
> > The patch that this change is purported to fix is broken and should be
> > reverted; thus we reverting this one as well.
> 
> You need to provide more information.
> 
> How does the original patch break the build/code execution?
> What is this patch doing to rectify the issue?
> Any other information you think is relevant.

We are reverting this patch because it is not needed: it tries to fix
another patch that is completely broken and needs to be reverted. The
justification for reverting the original broken patch is in the revert
of that patch, but just for reference:

We should not use devm_kzalloc() to allocate refcounted objects.

Thanks.

-- 
Dmitry
