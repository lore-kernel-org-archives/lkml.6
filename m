Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8833CC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30039247B3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GbsVl35K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30039247B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934507AbeFVTvr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 15:51:47 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35335 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934257AbeFVTvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 15:51:45 -0400
Received: by mail-pf0-f193.google.com with SMTP id c22-v6so3684802pfi.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 12:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bV8rnbz9SCxm58JrOH1gWj8azW+P+qn4qIclNhAqMTg=;
        b=GbsVl35K3SiYeYpjhHcTSbXEDaVDGs5R0R1Ja9VnJz+vBLlgiEQAN60kMWbog8jiWO
         yYYNlyHt/OfvTC5DOfGCBcWYlF1G7WQ31qD35/nB3FsBkQHg6OoaRKX852Gr1XHTuCnl
         tuzBa9z+tdWrDTnL45u5HyK7Kgt2HDypAmi7wtNBYFnBz8eFI2orTlJSCIpPxod+DQGV
         RdyvC0y8Ct+ZTKBGWHLCATZmhasDZ+6mk2UZmvvxkNIjwcgFeYc9i8dqXIV4N2AvpCyw
         9Cd22jVaLw38eTwsKzv/gPQdLlwuOP/5GE5ZvGKy98BBwy1CfxhvZ8+xrVUHsVmITbnZ
         4L+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bV8rnbz9SCxm58JrOH1gWj8azW+P+qn4qIclNhAqMTg=;
        b=lI4BeLK5h+HprAKAvU0ZRgSz86Nv4Ja1kRZjSSP3Ux641zVUw1lVyMbwrbDRkbDkeV
         vKgDpRoWgqxbXthzzCvdYLEO5tDyx9d8pGrLra7d6nPgQHHik6gWA/qWHgt0JkCZ+E9z
         DN89euQEXlAuvKsK8FG+2IqotMZKgtJXc4vud7FECh1sqE527zN4guZGkIA2aeFST/jw
         w7Y3e5hsbypTEK3FmwdvEcmbWofCruQYhbHfpZdAtk69L3UMeIpIOpBMkicLOD1A2dv5
         YcH4mfQXy0WPTs3qRAu4S7zDFeIgZ2ZshLz43P7tfn/jU/WY87DTizcrdVtyukMWNKD6
         8kuw==
X-Gm-Message-State: APt69E1CqKgAtWgz5ajzWbopetFse2KlnBs0v/ZamU4mGoHOH2VcRXrO
        3x7GtkJKIksDgjohT2CPv2aQfdJsgEk=
X-Google-Smtp-Source: ADUXVKL0A3760/mYSMcsufZKid1SJ2MJaRncRCDXbEDC13XfequH1W6chHUgemAEZYWwHA017IdxRw==
X-Received: by 2002:a65:5c02:: with SMTP id u2-v6mr2591307pgr.304.1529697104886;
        Fri, 22 Jun 2018 12:51:44 -0700 (PDT)
Received: from ?IPv6:2620:10d:c081:1132::1032? ([2620:10d:c090:180::1:981b])
        by smtp.gmail.com with ESMTPSA id l85-v6sm16245154pfk.79.2018.06.22.12.51.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 12:51:43 -0700 (PDT)
Subject: Re: [PATCH 3/3] block: Change simple_strtol() to kstrtol()
To:     Kitone Elvis Peter <elviskitone@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180622113918.GA6633@kitone-HP-ProBook-4530s>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <58db0446-1e25-d2ba-3d47-33d5e19beecc@kernel.dk>
Date:   Fri, 22 Jun 2018 13:51:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180622113918.GA6633@kitone-HP-ProBook-4530s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/18 5:39 AM, Kitone Elvis Peter wrote:
> The usage of simple_strtol is discouraged, because
> strtol() is obsolete. Instead kstrtol() should be 
> used to convert a string into a long integer.

My patience is running pretty thin with you. Don't send untested
crap, you haven't even compiled this.

-- 
Jens Axboe

