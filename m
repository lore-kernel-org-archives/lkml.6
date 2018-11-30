Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF195C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 04:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0462145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 04:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jv5WMeB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0462145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeK3PpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 10:45:01 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43603 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeK3PpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 10:45:01 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so2149178pfk.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 20:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YYsxccKV4GfjAipx+mKa0UZHk0+8dvMN/X9SO6kCyEc=;
        b=Jv5WMeB3ciZFtkSmFYslF7i2HzWe1gcUFDA/WY5PhPYm92rLSO0ocvT7OmTr1uLgMe
         avHP9lwh5Gug87z+psRwQcrVwMyoseFHpiMxFi+c+buiLvi9qvkhlb8bTUdyN9L0/GRP
         /+wb61WtPETP+DLTCWLmoTSmA6I3bwSmAM3Ry0J1dVb5ybX7XuMq6/B58LYELTXMNerj
         C4Pu6+J7pCIJQjSQXE6z2tPOJz8fiwco7WkzrXw9qNwrNtNm+KLQxixk97I2v6o8+GBt
         0xjmY1zcAY7C3iVRHZrnI27UcnhLmUCtzM3d0ikVL/k24uhc7GTpAZMTPExgh7tJvToN
         CisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YYsxccKV4GfjAipx+mKa0UZHk0+8dvMN/X9SO6kCyEc=;
        b=XDBpm9ToQ+WdYndjbPnDsYzKvc3uAjV0Sl4wGu1VxcWjvIPJXyK/zpTSRNJCnjhNZ7
         UbEIqvVmSlFXXPAOA5pEdnVTZVbU6sVUOu+0iQ/wgxhkTPD3SStJbzTE/PS7svM28zBD
         Zbz5PPpanOFT749Y/hP7sEQt3rhFbJ5mSuptYa76pcJb7kO7kqqT/vK9vc1SjU66walF
         7yWrgmAqqUNAhPK9vhTBwv8Vbg4EqwGDNPflQBAIhx6DqJBvaKZ7qWFsBsJNabHoVg0w
         9NWU5zTk+d2TWn92yJQvgLJsBoOFnv4fqQR4w7ACti+55kLmVYrQo6IL29EucPGV7h1g
         Fs0A==
X-Gm-Message-State: AA+aEWaMEv5nVDjPKN0w1DYatbpXFXEAaPd5woj3VY1+xhCYMmjax5JI
        Sv3U5cFJPPC8M5no1EXslRc=
X-Google-Smtp-Source: AFSGD/XGWzzphHFviF4UHb9w+JSpZ7dclfUtqyRX2uL3PeLXn0YMoCl53z5fGyywKJTN9vviphQcNQ==
X-Received: by 2002:a63:88c7:: with SMTP id l190mr3548902pgd.110.1543552621298;
        Thu, 29 Nov 2018 20:37:01 -0800 (PST)
Received: from localhost ([175.223.39.43])
        by smtp.gmail.com with ESMTPSA id p24sm10266893pfk.155.2018.11.29.20.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 20:37:00 -0800 (PST)
Date:   Fri, 30 Nov 2018 13:36:56 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH v3 0/7] zram idle page writeback
Message-ID: <20181130043656.GC605@jagdpanzerIV>
References: <20181127055429.251614-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127055429.251614-1-minchan@kernel.org>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/27/18 14:54), Minchan Kim wrote:
> Inherently, swap device has many idle pages which are rare touched since
> it was allocated. It is never problem if we use storage device as swap.
> However, it's just waste for zram-swap.
> 
> This patchset supports zram idle page writeback feature.
> 
> * Admin can define what is idle page "no access since X time ago"
> * Admin can define when zram should writeback them
> * Admin can define when zram should stop writeback to prevent wearout
> 
> Detail is on each patch's description.
> 
> Below first two patches are -stable material so it could go first
> separately with others in this series.

I had some time to look at the patches
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

Will give it some testing later; next week maybe.

	-ss
