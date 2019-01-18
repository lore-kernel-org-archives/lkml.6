Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6293EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F99F20652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547820333;
	bh=15A6WFFABatdOW/hKtz53DKsxRhQMpC14f7mQw/eYck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ke/ss+DWI9eo3X9wGrhB5h38QJzYyWjGVp8Hycf8TJLrqwuWvobWyVJZqu7I/xwb3
	 OygaEkDtetGMt84ur+brUKdz8+QswxGkatJ1Mc7b6A6wmD96nOtCr+Pbly52Odem1G
	 Syg0qTCywC+HkJtyyN2hLJByZvv+2ZsOb59IiL2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfAROFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:05:31 -0500
Received: from mail-yb1-f181.google.com ([209.85.219.181]:43436 "EHLO
        mail-yb1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfAROFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:05:31 -0500
Received: by mail-yb1-f181.google.com with SMTP id t16so4357500ybk.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 06:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EVodwfdmivaXBlQW88UGOM7GWceRW1cuMpytLEsbEWY=;
        b=HMfjSyfQyY/mc0+do0AfXFWHSYkQ7vUf/R2NuZMkhzryHN6hKjWx/ucJTBaruyiwND
         DSKetDsyLFnFh16/chu8fOsTtJfERijCO8KYBZxQaW3Beej11iKkDvuYbAYtEVIZMhOl
         tpnw7RczgWT6+AilTvEW8zoxE7NdVtO8/vyp87CwhMXJTVKaAUaZpgQwRzsOS3GiKDq6
         wD3YKC7BlmVlC9chhWGYbaGNOIZfNAz0Tf0DGizjV152jrV+KCgM9LFS7QkilzWsVGHf
         zb2pZKaWPLiTb1CnUIpyDiUdq4GL6FeZQxgPRib2TLBNbs51jhYVa9ZiLumeAbirgK95
         rb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EVodwfdmivaXBlQW88UGOM7GWceRW1cuMpytLEsbEWY=;
        b=TvBW4RaLoGbsxtH3fnM+eGr8JMfJGWWS443iT9RWRilHG7Pc/QtdD8/xt1AewP7IU7
         KM8tyWxJUENFz0Mf3HbvJcYSwUTPwmJ6XnPYwU2HWFXmK8IE3xZpYUr3Ntym+xwJrsOT
         TJaUONKOBkCatMeUY4CeLKj2hU4RodrsxVV2J9pwMRQPIiGrCrIOdYNUowdMg2BXnfsK
         zUv3DX7wn3in2IcBtZC2r51RgsxMEJH6+OSlJnYWzMmnIBechaCDTyt4jxM6elht+Rjg
         5XcQtinmxkhfooPkHOJS+gLl/r0BTG2Jns4N62DGStnxPu1ck/CxBTvzhEUmkn0+EZzN
         uGLw==
X-Gm-Message-State: AJcUukeXFtdeKGODqhAT8zwaPHCl82pEMGtfQbFmUxf1jtmp/h4G8w6u
        zISv42xrdFcHg/mzmzdxBKsLjdsq
X-Google-Smtp-Source: ALg8bN7uxeAGybkzjZp/WaLhh2Xr+XDU6sOsGdpd1ox47QC6ofpdfnINP1SengWp8NLrEHdgU90siA==
X-Received: by 2002:a25:bbcc:: with SMTP id c12mr6367553ybk.82.1547820329767;
        Fri, 18 Jan 2019 06:05:29 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:586f])
        by smtp.gmail.com with ESMTPSA id k64sm1829439ywc.56.2019.01.18.06.05.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 06:05:28 -0800 (PST)
Date:   Fri, 18 Jan 2019 06:05:26 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: workqueue: Is flush_work() without INIT_WORK() OK?
Message-ID: <20190118140526.GB50184@devbig004.ftw2.facebook.com>
References: <7d751e65-e695-e23b-9cec-ef3f44289a56@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d751e65-e695-e23b-9cec-ef3f44289a56@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Tetsuo.

On Fri, Jan 18, 2019 at 08:58:49PM +0900, Tetsuo Handa wrote:
> 	struct work_struct work;
> 	memset(&work, 0, sizeof(work));
> 	flush_work(&work);
> 
> . Is this behavior defined as "safe and no-op"? If this should be "safe and no-op",

Nope, that's a bug.

> we need to check whether INIT_WORK() was called before starting lockdep checks
> at __flush_work(). If this is not "safe and no-op", I want to emit a warning if
> INIT_WORK() was not called.

Sounds like a good idea.

Thanks.

-- 
tejun
