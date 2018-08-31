Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD7AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6382077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="ZIR6D0IY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6382077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbeHaTqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:46:04 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33809 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbeHaTqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:46:04 -0400
Received: by mail-qt0-f195.google.com with SMTP id m13-v6so15033185qth.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 08:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4horjyeJc+AP18U1mdCUwawf1Q45fUOIo0sacVoEYXQ=;
        b=ZIR6D0IYHg6u+A+5s8aeDh8kd8lRi8BapEmyS73g4N7SiM6QgrZdfo64z1j4F4NZsa
         Y22ROBc/3jomOQ9feMbV9cWEDmdaT3rXFmm9I72rjJfOVrPGc8MM/W3QpP+wFWRK7fTw
         fGEsGrYZ26w6YmTF50Qr24SUZz1rCQNSgwPOAsE3SroC9QVxI4e1/r2H2MYThYuQSz3B
         OM7MU6Z0Fyq6xk/t/jzXyNMQsvcPQ8yI/8oyWy5EnmmyWE7Rr0AvSkYUXtIBRSVvQROr
         KeNmGWK8UsUwBiwVCg/60hlrKh6x0N91ZJ1XDYKbOyKW/sb0g+/YoZ8RWgJydscCXa98
         Y5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4horjyeJc+AP18U1mdCUwawf1Q45fUOIo0sacVoEYXQ=;
        b=psMFaM0L6MARAb9DPXqMuYx1qjm2IvyuxVXpxE3+MCId5ncsCONJjA9FJLO0Q+S2vL
         eXglJF2yUzrcIqwvPetEIy7vLo9C/Cuk1gbGeSJ7I5Nlckc4il3DzK+E2OPK9IrpjduA
         Oqhi127ObmhVsapzqlGgcQ3nLmVquRDD4P/q5/0Sn/rkTp2pzFjq3BhssN02DPdeOVbo
         rUrI/Ks3FrO6nysBl0bt7z9/HQNd5ipNWNO5LCWYgD57xcQZ/3jj6uDd34jL4zVgLRv6
         oqAv7qbTELAUSpID6hjChyJmlGx+dulFKlu3iXUaTT+YahpiDdh6cRDCgCexTOKXIE+y
         WA+Q==
X-Gm-Message-State: APzg51Avp8qcw+Rdw2MNmOUjBeLlbAzVzwCTGf3unb25HGB5n7T6bF4Q
        FyEzGnb1xSaQ4S5nDWuZQgHQJg==
X-Google-Smtp-Source: ANB0VdZEs5zgD+bM4hP7hhWMzuqdoov/JToYy0XwB4A2LO2PErzxk4Y7wubMmUUKbPM3+J4ROtzOiA==
X-Received: by 2002:aed:2524:: with SMTP id v33-v6mr16672444qtc.319.1535729880835;
        Fri, 31 Aug 2018 08:38:00 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o124-v6sm6183968qkd.61.2018.08.31.08.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 08:37:59 -0700 (PDT)
Date:   Fri, 31 Aug 2018 11:37:59 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/15] blkcg: update blkg_lookup_create to do locking
Message-ID: <20180831153757.ztep3tw5j4zmlatm@destiny>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-6-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831015356.69796-6-dennisszhou@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:53:46PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> To know when to create a blkg, the general pattern is to do a
> blkg_lookup and if that fails, lock and then do a lookup again and if
> that fails finally create. It doesn't make much sense for everyone who
> wants to do creation to write this themselves.
> 
> This changes blkg_lookup_create to do locking and implement this
> pattern. The old blkg_lookup_create is renamed to __blkg_lookup_create.
> If a call site wants to do its own error handling or already owns the
> queue lock, they can use __blkg_lookup_create.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
