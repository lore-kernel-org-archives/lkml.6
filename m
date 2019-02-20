Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E46C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2442183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="elh6EbWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfBTIpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:45:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44583 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfBTIpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:45:47 -0500
Received: by mail-wr1-f67.google.com with SMTP id w2so10368977wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 00:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nmrK6pHyAp3hQBbeF0u9w1vlK8e/A6MyHfzojf4oy6w=;
        b=elh6EbWYhoI3xngSLeyYCIhVU5V0jktsdmFA2wHVOT5dY2RBp/mYyA11Mj86PO+TlU
         H1tOOkb9EQea/NtySkcRvDjOUy8jiFzURrfXWzhuZJIMo68sNHjJ6esd2mLachvWQXXr
         zjmH8Kaq8IsUn8QNYgAYkuIX1a+FD0mP9CEphMA1UXyBmUpjdl12rF54KS6lxNVXBCEN
         d8KWl04CnweygryRmhDEx+ZoiduQ0PuLfTfkttzIbAX103UbFc/6K3NlefeczZVszIdc
         YaEdPlVGr4s+8ioN/7EjHnILnelhAjNp8HDUU7QmGk7uC/ey5fdzAM7yI8qUqGuOgfv/
         DfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nmrK6pHyAp3hQBbeF0u9w1vlK8e/A6MyHfzojf4oy6w=;
        b=a25TrTjLFLJyuw7fiOwBeQ4bCvWSuvarXjj1JSjb0JIiX9LtpQ+h1EjLFtPKwoKVs9
         4BzwTsZhUxvVGHqovJLfNUB6v9Pfk4Evct3LiPSrIUI6Ihs2xcGZPgECJmDVoD57fD3a
         KCbslhNkyYfuQVXairtnyNQ5SaUUUt8BMojJGbzqSpwH1au3dLx8M9NXnwReBcaooO0q
         RDbCHrMNRmz7z6AtY5Q72Od29QuY+AXeXeyp8w0OdWAFzOvrb4cAwhYeK6iOVPajzTC7
         1nhiD1XHhdqOlr+ftExizaX4j4Qx7pyo+LH9tcrnn460I3vemRSJj/LFJKgvZZ3ISXQw
         O77Q==
X-Gm-Message-State: AHQUAuZYZrkwdhZ0BuqhnEHu2KGNgVepN4lc5j/AHQvAAR/oL8/Xqmh5
        Y7sGAN3svQLaSFalqWK0Tz+iOg==
X-Google-Smtp-Source: AHgI3IZ8guFEpBPDpvdVin8XQowVVuNSNMsHQgQjiy47uicnTxXLmDhdX7hLxHtySZbgr6rhuDoP2A==
X-Received: by 2002:adf:c704:: with SMTP id k4mr24986743wrg.142.1550652345626;
        Wed, 20 Feb 2019 00:45:45 -0800 (PST)
Received: from localhost (ip-213-220-234-21.net.upcbroadband.cz. [213.220.234.21])
        by smtp.gmail.com with ESMTPSA id f134sm6497222wme.31.2019.02.20.00.45.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 00:45:45 -0800 (PST)
Date:   Wed, 20 Feb 2019 09:36:11 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     David Miller <davem@davemloft.net>
Cc:     vkoul@kernel.org, sfr@canb.auug.org.au, netdev@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch
Subject: Re: linux-next: Fixes tag needs some work in the net-next tree
Message-ID: <20190220083611.GJ3080@nanopsycho>
References: <20190220093136.73779781@canb.auug.org.au>
 <20190220044055.GD21884@vkoul-mobl>
 <20190219.224813.723564128666927693.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219.224813.723564128666927693.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Feb 20, 2019 at 07:48:13AM CET, davem@davemloft.net wrote:
>From: Vinod Koul <vkoul@kernel.org>
>Date: Wed, 20 Feb 2019 10:10:55 +0530
>
>> On 20-02-19, 09:31, Stephen Rothwell wrote:
>>> Hi all,
>>> 
>>> In commit
>>> 
>>>   a968b5e9d587 ("net: dsa: qca8k: Enable delay for RGMII_ID mode")
>>> 
>>> Fixes tag
>>> 
>>>   Fixes: 40269aa9f40a ("net: dsa: qca8k: disable delay for RGMII mode")
>>> 
>>> has these problem(s):
>>> 
>>>   - Target SHA1 does not exist
>>> 
>>> Did you mean:
>>> 
>>>   Fixes: 5ecdd77c61c8 ("net: dsa: qca8k: disable delay for RGMII mode")
>> 
>> Yes looks like I messed up the commit id.. Not sure why :(
>> 
>> Dave would you like to drop this and me sending updated patch or
>> something else..
>> 
>> Sorry about the miss
>
>Doesn't work that way, something in my tree is there forever.

Would be good to have some robot checking "Fixes" sanity...

