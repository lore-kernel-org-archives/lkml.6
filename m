Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9327EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8C82184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="A5l1I0Nt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeLSJ31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:29:27 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38368 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbeLSJ30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:29:26 -0500
Received: by mail-ed1-f66.google.com with SMTP id h50so16362706ede.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 01:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ao1ZlpnCcQuCiz3PvkV/rVl6U2b00EtLd/YWNHLp0hQ=;
        b=A5l1I0Nt9jWVWMcK7Kiy/J50aSbSfcDRRsUReomsnnTBp50D2jjG7daLK5xe085+m6
         JoqGB9oiv+6ge6/hxDzTIrSWtVcQq7iZA5pidryCdeL7bo4ZgfW0VL6uZfJw2nOlw0Rg
         8Bc/8jO8ZzjU8LfDrlC17hvgfULC3W0/mZtZGxC/ooNH9sXQwBKqjsYlLq0kEcQaimFI
         tRQVtF82IQMmc6RKWmyJ7nuEg1PXZSFw5npVtUZFE8FWb2cSG4OzX4+JbRxFlkQBuzqp
         KoCL+ggiaUB1CrAsGS7acB1GkmUQ6JL5Vj12AooUXuEw2tG3Urev9p8h2FX7WEvkGqm/
         hUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ao1ZlpnCcQuCiz3PvkV/rVl6U2b00EtLd/YWNHLp0hQ=;
        b=kKm0Sm59Tkg0vZEhpf8iFIVqw1BFCFTx+iii+KwPvxmH+XIsqyFV78hkKcpF/QUouA
         5RLzveFTfp38GNk21On2kI7YcIyj19wPnEno8TneKsm/0cIOGuLz93lXtDw4d42CvXlT
         3gnOxVFq0Smh4KR7O/J7NYXYAFC7Pw4T0kDgRMcIQ7CgcGD8xMf8XyI7+tZ0AJYBqDM3
         KoblMtBmPVbW/q3fVR4z1MV4byX5T10ZzKVkE0BO/GHS9u2ArZY3Xg5QAVZorcCrGt8P
         n4HH4dnwRKAHty/ZG0AhJRFdnbSnSOsg4Gg9t6yJtbSCCu81unMFq54qCsZkMJTiBolY
         D3wQ==
X-Gm-Message-State: AA+aEWauMFDesS0KDekCbAvlSsFR4nDvjczN1mDznRENFPQRxwrZOnd6
        1QBSy6J+dmmJoAucSG6KGvXhvQ==
X-Google-Smtp-Source: AFSGD/X0Rk6rNCkZ4+56IUV/oUcT1AVOqh0DoHTcnWNuddzypyONdKZ9/4ElYJiVka25kcjIz/Eg9w==
X-Received: by 2002:a50:a55c:: with SMTP id z28mr19392887edb.124.1545211764027;
        Wed, 19 Dec 2018 01:29:24 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6c0:6c14:58a0:c7b2:d756:db85])
        by smtp.gmail.com with ESMTPSA id v11sm5200082edy.49.2018.12.19.01.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 01:29:23 -0800 (PST)
Date:   Wed, 19 Dec 2018 10:29:21 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kilobyte@angband.pl, darrick.wong@oracle.com,
        chouryzhou@tencent.com, david@fromorbit.com, arve@android.com,
        joel@joelfernandes.org, Martijn Coenen <maco@android.com>,
        dan.carpenter@oracle.com, tkjos@google.com
Subject: Re: [PATCH v3] binder: implement binderfs
Message-ID: <20181219092920.6mhd5i63cm2pyi4n@brauner.io>
References: <20181214121114.8785-1-christian@brauner.io>
 <20181219084756.GA26777@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181219084756.GA26777@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 09:47:56AM +0100, Greg KH wrote:
> On Fri, Dec 14, 2018 at 01:11:14PM +0100, Christian Brauner wrote:
> > As discussed at Linux Plumbers Conference 2018 in Vancouver [1] this is the
> > implementation of binderfs.
> 
> <snip>
> 
> Looks good to me, thanks so much for doing this, now queued up!

Thanks for trusting me with this idea and work!
Christian
