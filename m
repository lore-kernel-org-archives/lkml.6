Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D545C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A61E2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fh9hQCT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A61E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbeLKKDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:03:50 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43589 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeLKKDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:03:50 -0500
Received: by mail-lj1-f196.google.com with SMTP id 83-v6so12388032ljf.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 02:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cnglv3oPpALaNChL5TQnA6EVkRuophpVwqGL9bHv7qw=;
        b=fh9hQCT1OS7hDtwA5DqNsC7k0JCS/r45ySmAYL+Fp3sXASEXDPYAuXkG3DnT5YCGi5
         Op9pq3LNnO8eIedRytbhXNvwnoud14j+lijVZejlvgSd93crICsGU6eXj3w7BhWa989Y
         dDIKXFwMOxcWAl7eNAujuwHKRE0tSrn688lSm9711nuUfJxoOLdrP2+8rMuO4LTfycG7
         tGGWexDFOsONyynxDtkEKcEj4pr+wMV26lFXIYUZkMiRl3C7EJZs/A+45O87E6Odo1MX
         m/9cWEHndpJFy6DRNkvVykBJGQS8yqrxDpkWRXkkSSXYehoN+71q2dnCSzbo/ahjdetm
         oYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cnglv3oPpALaNChL5TQnA6EVkRuophpVwqGL9bHv7qw=;
        b=WbHpah+m9iIYcWauN2xGHnujykvdXSvIHNiVt1PARrpXHGyxkMaFsxdlhE9Gq4YChD
         +G8SLVREPt+pRGgci2HQCXb2XpOEVbkw2QbEssG06+qKZJkJ89g/eqsnJPfLrPW5pSrG
         xbQ2vaMm74gJLCSzYXpLEA3Pwp5lKo12Y9+h94FyqIlf7sc99YNRzqu7uFzbcdcyRCMC
         Sj+7JwvKN+1h53X5Hp7S5JazsrZpEVMKlaPajxO0GbMd1w45FMbqIgHMDQHSPijIioYo
         im9hKdpUzkYwtgQpbVLk7d7WM+TKCsnbZSSZsjMBKOA5bo3ByPneWPcWGVEGnyUckYDA
         ZEMA==
X-Gm-Message-State: AA+aEWa3Gpi4ZqeObxj7iEf/e59uXnhUCPC1PmGaVISyHox5bO5JNoRP
        ASyuqncS81LVbuwbVvsn1XY=
X-Google-Smtp-Source: AFSGD/VuAPVC183HBq92PVP8CD5zj4d8p2feJa8BFpNw9PqlQSNPwFmPF01kF92uUn0kxZd6/8oEBA==
X-Received: by 2002:a2e:9a56:: with SMTP id k22-v6mr9234094ljj.17.1544522628151;
        Tue, 11 Dec 2018 02:03:48 -0800 (PST)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id j138sm2576622lfg.64.2018.12.11.02.03.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 02:03:47 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 073A9460AA3; Tue, 11 Dec 2018 13:03:47 +0300 (MSK)
Date:   Tue, 11 Dec 2018 13:03:46 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gorcunov@virtuozzo.com
Subject: Re: [PATCH] ksm: React on changing "sleep_millisecs" parameter faster
Message-ID: <20181211100346.GE2342@uranus.lan>
References: <154445792450.3178.16241744401215933502.stgit@localhost.localdomain>
 <20181210201036.GC2342@uranus.lan>
 <db19c148-b375-b6f2-dbf5-9e78f5e46c04@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db19c148-b375-b6f2-dbf5-9e78f5e46c04@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 12:23:11PM +0300, Kirill Tkhai wrote:
...
> > Kirill, can we rather reuse @ksm_thread variable from ksm_init
> > (by moving it to static file level variable).
> 
> I've considered using it, but this is not looks good for me.
> The problem is ksm thread may be parked, or it even may fail
> to start. But at the same time, parallel writes to "sleep_millisecs"
> are possible. There is a place for races, so to use the local
> variable in ksm_init() (like we have at the moment) looks better
> for me. At the patch the mutex protects against any races.
> 
> > Also wakening up
> > unconditionally on write looks somehow suspicious to me
> > though I don't have a precise argument against.
> 
> The conditional wait requires one more wait_queue. This is
> the thing I tried to avoid. But. I also had doubts about
> this, so you are already the second person, who worries :)
> It looks like we really need to change this.
> 
> How are you about something like the below?

I see. The code below looks a way better for me, thanks!
