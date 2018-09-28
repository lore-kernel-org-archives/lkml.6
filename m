Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6876BC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEF4206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJJTohMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CEF4206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeI2DrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:47:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42460 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeI2DrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:47:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id y71-v6so7090653lje.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 14:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JbnZv4Z8tg0KEsXjedKwb1ELc2a3loHC0sRIJiwz3kU=;
        b=fJJTohMklTkGQrOjStzEW9kIutazihnayphdO6euGRjgSbMmJSdl9SdHG4Eo+KcOhJ
         i3i6gKRJR8fmHLTvOLG5fjAVJ1H1wONOxbLlavfKw88iowXUZ/puhqYFbbt+I889l+UO
         Lqor3dudAP0OyGzebVxMsIYWh034g9PYTvoPOD4la9Jgc/P/8Vijfl7DWSqvcqeU60K0
         Mskvd3ALf4oP9pE9aK4Q84KWWzi7XRsCRZkWejZDYhGIo7p6DmrfjcBIFl9oC3t2UPMe
         SPyHUUlqsgwJzgLA1jVzx5qGzJts3nvzBDmrlO1n+JAqyiRjAdFexltC3EQWv2bk+sTC
         vGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JbnZv4Z8tg0KEsXjedKwb1ELc2a3loHC0sRIJiwz3kU=;
        b=uay2b8i64B1x841jFXvJMFwrAr5QkgBlLUl6qy7XVFlR066ZVxII73MKTVkrdHLr22
         zbvNJ5CHvGbdTiSR6G708qYEsB2iVvPpcfofbDMIxU3jsEUmcxYdzhCZuMFQiKWg9uEg
         kfFdWAm+5c7ud7TRaodnt5L67VUUqFo7nlSp0wpvLoZooo0lR157I9G06joDUlW6sI0p
         pGvolej4clIKnZ6ezOpMA7elPvO8s+FZM9nV+yaUwKd6nMoWzmNNsZuHNNJUhLq0CCd4
         c/LWR1yLar3Yp7Ukiyzy/vDxtkAOYes5Qowww2iW+HJM/ifGOC0PBaesSNeHlB/2Gm7Y
         3Y+Q==
X-Gm-Message-State: ABuFfog+MYLQKKNlvsbaWVYBzz0OSb6mPKJlnrVmbW49s8Z7Wsks+S8r
        mbFn5E/1L2NKEXfIHaq7b50=
X-Google-Smtp-Source: ACcGV60uAXp0DouMRZ/cyAro+RG+zQMkoVV3d69LHJdoI3Twi1gTsW6ioe8LaVTsqL8Y/eVvkOUXvQ==
X-Received: by 2002:a2e:92c4:: with SMTP id k4-v6mr265821ljh.18.1538169700477;
        Fri, 28 Sep 2018 14:21:40 -0700 (PDT)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id b6-v6sm1213104ljb.53.2018.09.28.14.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 14:21:39 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 89AFE460650; Sat, 29 Sep 2018 00:21:38 +0300 (MSK)
Date:   Sat, 29 Sep 2018 00:21:38 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, mhocko@suse.com,
        aryabinin@virtuozzo.com, hannes@cmpxchg.org,
        penguin-kernel@i-love.sakura.ne.jp, shakeelb@google.com,
        jbacik@fb.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Fix int overflow in callers of do_shrink_slab()
Message-ID: <20180928212138.GS15710@uranus>
References: <153813407177.17544.14888305435570723973.stgit@localhost.localdomain>
 <20180928141509.fd8f8ac8c0ea61f0cb79d494@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928141509.fd8f8ac8c0ea61f0cb79d494@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 02:15:09PM -0700, Andrew Morton wrote:
> What did he report?  Was it code inspection?  Did the kernel explode? 
> etcetera.  I'm thinking that the fix should be backported but to
> determine that, we need to understand the end-user runtime effects, as
> always.  Please.

I've been investigating unrelated but and occasionally found this nit.
Look, there should be over 4G of objects scanned to have it triggered,
so I don't expect it happen in real life but better be on a safe side
and fix it.
