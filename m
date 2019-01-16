Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9203CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421F520657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="OWiUnruw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404609AbfAPOmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:42:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44840 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390714AbfAPOmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:42:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so7158020wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 06:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cKHuhb0B3dwMmwRFNVNqhG6UA2PZ46O+/pLkWFZJJD8=;
        b=OWiUnruwIGNwuqczBQKQ3jwbOxrFw07ZuqK/96jjOUNphR8ciopPO0Qux9+6upyEFm
         ByJ7LVkX9cc5vkYqDeWMVci2O0qtMKhyZqvnn7dVj/iErEahwVdcjyIerMoK6JwY7lkg
         jEbfQ69nH5jcQIpTLcEVv+VdGD94nOtmOV5zlc4AB6k/kqfH4/ezuA6qNrDepTodcTrh
         Eibu2g5825xcRvGGwTYtMdnrC6c0kypBm81FSrVYaprvj/ANByE0Fzm+9xpOHEHlUV4e
         8Bqp4PocIBXLJFB1bxfd07mnZEvWudJwVIPpEa7BEd9KtpVOhJKdjhQ1n1FBYGrEGmWc
         5IjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cKHuhb0B3dwMmwRFNVNqhG6UA2PZ46O+/pLkWFZJJD8=;
        b=H19tLSw2zk8uyw6xlxKBjYV8qTZrplizDPOZ7Bj0gLSs4uyb/FpwP+ezawXrburlon
         OyqS+zA4s8HqtIlqCXMpFsWt4+sI3OgqSRTAqKvSDABI70aeefj5v74nl60kHVJi5zex
         97yjRFntxPB9QnDaqdTsgOiaXQYgsTLx/3/usImXeeWDKTrDkycOg6Pndi6a0YaHd5h+
         ZXilPRy4DxAeUwpAeikCqITkFd8LKQyabbO4VI1iUrmkTndyEbrDNSaQqPvp3nMBvXDP
         RKZt5t3oatxD55kEUZyB2GMWa1dWnGK7hrOHDoLj+4xgvTwdCSudDqyzHLAUn5tSrZIK
         LdrA==
X-Gm-Message-State: AJcUukd/H9W+t9kShewnJHMDS+741z1P1/08T/1fZf2aLv0/oaqMAZ6u
        0l0FMoL62NR9FcrOPw3c82wxKw==
X-Google-Smtp-Source: ALg8bN5AtEXm/XNK2zA8+iDToXCx4BvJpazz0XACEQDKx6BJrZf0Y8oRpbjIJQvlhSEavCjskG1Yfg==
X-Received: by 2002:adf:c042:: with SMTP id c2mr8188278wrf.158.1547649727834;
        Wed, 16 Jan 2019 06:42:07 -0800 (PST)
Received: from localhost (ip-89-177-6-176.net.upcbroadband.cz. [89.177.6.176])
        by smtp.gmail.com with ESMTPSA id o9sm23690136wmh.3.2019.01.16.06.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 06:42:07 -0800 (PST)
Date:   Wed, 16 Jan 2019 15:33:37 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        netdev@vger.kernel.org, linux-lpwan@lists.infradead.org,
        Ben Whitten <ben.whitten@lairdtech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] net: lorawan: Refine the coding style
Message-ID: <20190116143337.GF5265@nanopsycho>
References: <20190116142048.19446-1-starnight@g.ncu.edu.tw>
 <20190116142458.19542-1-starnight@g.ncu.edu.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116142458.19542-1-starnight@g.ncu.edu.tw>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Jan 16, 2019 at 03:24:54PM CET, starnight@g.ncu.edu.tw wrote:
>Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
>---

Patches like this are in general frowned upon. Do one change in one
patch. Put some patch description.
