Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8F0C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 00:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8E7208F7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 00:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdvKP40r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8E7208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbeHXEIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 00:08:46 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:40175 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeHXEIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 00:08:46 -0400
Received: by mail-pg1-f177.google.com with SMTP id z25-v6so3456358pgu.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 17:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EuyN/1wrwP95RZVm64VRQdPDE30i+DKZoMUUMnzDxgY=;
        b=MdvKP40ra9oNbFV9Ump4bBD5oJeFRf0MjUoDUFtgrfPtiNSTAUuKWjSBSMZyZdyJyA
         T3Thbn9ZHRZQyfrh8LAgR2sA8b2sxX1Xx/lzNj0S6Cyr5KF4YAdTrft4ePyd5ohQA+lw
         HX6yRTBJD4CMPLky4jAprcvREsbCbFSR0C31TktEsAZeGL5b+yN1f4SbhrCFDRq7nL7k
         kIupuOp83/X/iYCz+3ay/AnWwB/vhgGCSb9V17Nla3/2t0Sl2Dgk0u/xXQ3EFd8Lkuod
         LVxGymElRoj3WNNc2mzIUqEp6pFGMWn8HxjN0rPPupjaTFx9dU0C7Z398Z0R0qFl18gA
         Ac6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EuyN/1wrwP95RZVm64VRQdPDE30i+DKZoMUUMnzDxgY=;
        b=tXhyWBI1S7oHwBL2AzL6WUCq9/Oj6fA2Kr5eLEmnx01egk8/1gWO96XGgZvgR0DlaK
         awD4wRwfXuPj/POzFThMFEH+Kq5po26R8uQv9iIH3t7cqWfBR+dDYvorc0Y5SFsZ6sgP
         uqWhw6lKsOWbIMJAfKwyaIJUT4bSShHW0Uq+JZa2nIyZAi14MlF10YKh15baamnN6l+T
         6yNTcsYJfWoNiduPva9pyFTp8VkPBwFDozDHEp2BJOg0704esVh+rW8rsz7sXk+GoECB
         44fOXZ/5M2QKPD3iBFUMAj8edvY/yHcMrOmv/2hkdpJh4e9FROAMJNsigu4Vj0QWBMlo
         ldhA==
X-Gm-Message-State: APzg51B/NvnvnFrRiFifeX493n0UHajtmlPIUnALOwtonk0lmnYT4Wjc
        bx9/c7X97zA2lMCWmMB0MsI=
X-Google-Smtp-Source: ANB0Vdbcr0k/425s0yq9RxMn1cIAHXSDxLSyesqzGKr144pgocXCSpK6hdk60MKctvnW6eukj/SJ8Q==
X-Received: by 2002:a62:5d03:: with SMTP id r3-v6mr4254701pfb.150.1535070997224;
        Thu, 23 Aug 2018 17:36:37 -0700 (PDT)
Received: from rodete-laptop-imager.corp.google.com ([122.38.223.241])
        by smtp.gmail.com with ESMTPSA id c88-v6sm7929299pfe.132.2018.08.23.17.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 17:36:35 -0700 (PDT)
Date:   Fri, 24 Aug 2018 09:36:30 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     "Dae R. Jeong" <threeearcat@gmail.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: KASAN: null-ptr-deref Write in binder_update_page_range
Message-ID: <20180824003630.GB15746@rodete-laptop-imager.corp.google.com>
References: <20180822060704.GA12007@dragonet>
 <20180823052956.GA28628@rodete-desktop-imager.corp.google.com>
 <20180823100334.GA17523@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823100334.GA17523@dragonet>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 07:03:34PM +0900, Dae R. Jeong wrote:
> > Could you test this patch? I found that bug a month ago but didn't submit
> > yet.
> 
> I don't have a reproducer now. I manually analzed a root cause of the
> crash using a fuzzer's log. The log reported a race on 'alloc->vma'.
> Because I don't have a reproducer, I can't test the patch. I'm sorry.

Ah, Okay. Anyway, one of author for the patch is already binder maintainer.
If other maintainers don't object it, let's fix the race in this chance.

Thanks.
