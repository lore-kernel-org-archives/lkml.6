Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AF0C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 05:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E99121717
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 05:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2sJl8mr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E99121717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeHCHkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 03:40:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32895 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbeHCHkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 03:40:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id r5-v6so2328262pgv.0;
        Thu, 02 Aug 2018 22:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NfoWyfzdIgJNJ+XJFUeUwUA+YMWCRzomMR1Oxcqc5kA=;
        b=F2sJl8mrsppUUMcZGgQS5H9GHlme/UGOs69l9wz5IjOQv+xDnLr5rdkSeCzysP5BaQ
         O4Fo+Cgr28f/i23/p9cmckx80Isi0eBzeqCEDxGIWs9pVpd9ua9rG4PQDvHZwQJSWcaL
         ouwTPWQgk5T/KIBuiMdhf/9L5QhLu8wpp5WSbS9PrbHBy008apZwN/yJukBl5mMeb1NY
         2ePcEFtXYCN/Cp8c2bexn+08weLymaEh3a8hGKWmI5LF72sszhzaQ0sw+l/SCB9elBPN
         0WDjjo5ZOcxMH95uen/vVTvdxmA+1EBm9N7Uu9wvorIELvOOgdz6Gy4bSuSZRya040Om
         nfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NfoWyfzdIgJNJ+XJFUeUwUA+YMWCRzomMR1Oxcqc5kA=;
        b=qFpiXq9zJdBHnyR2Eg9nL+1DS65S9pHhH9rqC6ETLzZRGcU8+kSOZF/j1c5vql6STj
         ZRGtsEvJk2fNg6kWc4Z5IiTCFvcx38uAFHIkx+tDrqUTJJL/c7Kw3f9a2ULh2rK0EL5w
         lt0lZzCEO/9vLZ+aI+uUqPzpodf/y1qL7+zjYfV2+FNRsVzUj9Z+w6kHVpWpDgmTzixl
         TtK2RYXmEmvOFi/PWgA24T6M7mjZ7uRZx/qyhVacGj0ZV3zZ2qNIyfcx1CI8dm0MKaxR
         ywDcYuPxTs7Etb+cVba/1c/AcF37HYNiQyagZYV4A/iQKabYpKB5D48ZXtasdTFpijGh
         LyNg==
X-Gm-Message-State: AOUpUlGP2qMCi7Mj3iGpJ910OfWosKhd/d+DHdpqp1yNKrNAnv2NsTM7
        ksk1biyOrAXzxHqL5Kl58sQ=
X-Google-Smtp-Source: AAOMgpesIbbWE5finW4kn4XGYutmb7e0/iTjcgrdvUw6cru+DFMfXtgT2sfyvsd5nxzfXGnXV6Kufw==
X-Received: by 2002:a63:4f1a:: with SMTP id d26-v6mr2306160pgb.121.1533275155736;
        Thu, 02 Aug 2018 22:45:55 -0700 (PDT)
Received: from localhost ([175.223.10.158])
        by smtp.gmail.com with ESMTPSA id b67-v6sm6795836pfd.74.2018.08.02.22.45.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 22:45:54 -0700 (PDT)
Date:   Fri, 3 Aug 2018 14:45:51 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tino Lehnig <tino.lehnig@contabo.de>, stable@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] zram: remove BD_CAP_SYNCHRONOUS_IO with writeback
 feature
Message-ID: <20180803054550.GD502@jagdpanzerIV>
References: <20180802051112.86174-1-minchan@kernel.org>
 <20180802141304.d0589ddc5f8213429ab3b565@linux-foundation.org>
 <20180803023929.GA7500@jagdpanzerIV>
 <20180803030019.GB86818@rodete-desktop-imager.corp.google.com>
 <20180803041302.GB502@jagdpanzerIV>
 <20180803045121.GC86818@rodete-desktop-imager.corp.google.com>
 <20180803052306.GC502@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803052306.GC502@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/03/18 14:23), Sergey Senozhatsky wrote:
> 
> Hmm, any chance a WB device can be async on its own? We add a page
> to a new bio and submit it to another async device driver. Then we
> return back to the upper layer (swap), which can free a page before
> the device picks up a request. Can this happen?

Nevermind these questions.
Sorry for the noise.

	-ss
