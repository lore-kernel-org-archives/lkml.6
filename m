Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99333C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B0120865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hO5rT3hb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B0120865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeILEvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:51:52 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38219 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbeILEvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:51:52 -0400
Received: by mail-yb1-f195.google.com with SMTP id e18-v6so62019ybq.5;
        Tue, 11 Sep 2018 16:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eA1Y8LAM4afbJQHN/Q+Ti6OaqCzYueF4LckPdLkAuEQ=;
        b=hO5rT3hbXcIWtGDs3OyFendQ0YC+UFVYXBBAz8vglQuSdKZ4XKCHjxdrX5nhMfN1Rz
         JzEO3vKitQt3NGra8UI+JbeG4/eawXZ+wQJx74BERbdBuzteccrfAonWna6WzxgyyI6g
         /ZfKD1lTmDsw6wfcv2gi32lk5swJBb3TAbsbxrwHuhxyP6wr0lCx6HUY2iXIwwvEfz/p
         /iSQYQb0QbqfGeRP1SqPZK9PecU3YAQJwPv9ms4tVbJ42TjaUnB+aTfYF5x7NxOBfBcA
         sjv+1Z8epTLmj8sRa+tmF2Nq76HRo9dyA4fYv3GMX1Tgxe71LcwUHSjwEUsXF6vIdC75
         344Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eA1Y8LAM4afbJQHN/Q+Ti6OaqCzYueF4LckPdLkAuEQ=;
        b=Zvyrf0j/MLs5RpQOwIrFAR6QIDOX9wZfHfEt8L8kS+v2t7irTXmo7sPJtxzJZmPWvO
         PjAiz287lKQU+NhGQpO4fwuMzE0tWpNPi04iiYprpZVba1DsXR7F9hLf4lXzaKhx/koS
         rY3Ej+Q0CgtthNKHWAmFhBAisDompHB//QXuOi12gJRU9QWXD09KQmay619eK+lBaXhb
         y5QiLlsChCzrQ1nJwVLMxY64+HuRPUoC0JkHDVyUkeHZngQXMUQoszyXJ+s88A3Aap4W
         YDv0IaCfsG2RRYMwlEx6FQSofIp/SpNW0TK89nQ74BINd8fsA2JjOY63l0M8h71FWVij
         hsOg==
X-Gm-Message-State: APzg51An9/ESJimnUbJyTA7I97M15ezGoU/QqGY21IjeVlBPIysisnG1
        E2zykNQVZB7QDgxgXipJ4qQ=
X-Google-Smtp-Source: ANB0VdYkcomIHYZVcUw3bKvqxyidilxgMHzcItd7hAPDAdZ3uwhpYSJIou5fMv7Z5KUGyDzJ81PDFQ==
X-Received: by 2002:a81:7c41:: with SMTP id x62-v6mr10419558ywc.490.1536709813019;
        Tue, 11 Sep 2018 16:50:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:6304])
        by smtp.gmail.com with ESMTPSA id z7-v6sm17156739ywz.21.2018.09.11.16.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 16:50:12 -0700 (PDT)
Date:   Tue, 11 Sep 2018 16:50:09 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] blkcg: convert blkg_lookup_create to find closest
 blkg
Message-ID: <20180911235009.GC2966370@devbig004.ftw2.facebook.com>
References: <20180911184137.35897-1-dennisszhou@gmail.com>
 <20180911184137.35897-4-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911184137.35897-4-dennisszhou@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 02:41:28PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> There are several scenarios where blkg_lookup_create can fail. Examples
> include the blkcg dying, request_queue is dying, or simply being OOM. At
> the end of the day, most handle this by simply falling back to the
> q->root_blkg and calling it a day.
> 
> This patch implements the notion of closest blkg. During
> blkg_lookup_create, if it fails to create, return the closest blkg
> found or the q->root_blkg. blkg_try_get_closest is introduced and used
> during association so a bio is always attached to a blkg.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
