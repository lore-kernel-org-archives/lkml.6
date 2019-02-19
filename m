Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9208DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3C22146F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="dMr9A99D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbfBSMgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:36:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54371 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfBSMgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 07:36:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so2638973wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 04:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wk1ZskZt9SLsSnbGhbNQhR7+wNdHNYlLVpLOz+Fvoro=;
        b=dMr9A99Di8p/NqtLMbO3KGSBa3OjMOkED5hKAlK0Mgv/jvjjYZI3ZzPKxhd8We10CR
         YtYtienypxSfSWo2vVyX9NFMGLs+wZFG0Q2fZEb3gWI+EmaZs5DfoMvJpBmgfEDCq7lv
         mSYmsjra00KmqIMslgVWpB5Q9nRadJsLEYug7uYDsWjGcA9nbGPoiOs+lpQy+dWD43No
         59mgHHvE43oKwJJwUzLLeKOoNZKwTabJeVe/dzdjUnLMQ4LY9oO7+sl8I3t1BUXh8Kwz
         5uDFG5fJvjGOl+r63lbGK6a67gfH0lKzZyUzeu1KCGwpnz6bgmW4NkBPS2DJDerR9Bd6
         BQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wk1ZskZt9SLsSnbGhbNQhR7+wNdHNYlLVpLOz+Fvoro=;
        b=kd1pd8g4HLwpwKcqB2u6U5Mw5/7UDik4RjVTcYHwXXSBTph+Xt3/U5aPhJ0wEQbR/p
         rwje+iP5nEDYZAtCYbT7qeWvIyMj/ozB0Nf3LPKK225Bvce4tmpAHpKGdDAbI+c4BGCV
         6Drs5YlGKn138JuMmcv4+mA1hO7aWYlgj8up856x/5QMeGDipnjZwOUW+g9FYgvKIwzu
         s4U/CEfNcPRRd3B/jZ23XFNwGb44L/2r+0k0fb3jRZ23yQhxoj3zq6UvXbnpGIGNplwH
         xTw2AzFqg1vEEJrr3/ad2BsNSMM0X6Lpk8NgR72L/aCUv4NCtg6A5+3vxQkFEinzOr+L
         1q7g==
X-Gm-Message-State: AHQUAubyLnLPEWjKGbRV40ZYpjn8TWO+h5rOfEPD5meir5USadexRFNg
        FYpLH24HfR89LYxhY1tWNxC9Hg==
X-Google-Smtp-Source: AHgI3IaR7OZf7BaSSoV4WY0i7jCDuvvjCPqvSVVss2Wzp4rUNu3+/9gKesba4SFIwAM+fcVvWtSqFA==
X-Received: by 2002:a5d:68c2:: with SMTP id p2mr19196194wrw.23.1550579809761;
        Tue, 19 Feb 2019 04:36:49 -0800 (PST)
Received: from localhost (ip-213-220-234-21.net.upcbroadband.cz. [213.220.234.21])
        by smtp.gmail.com with ESMTPSA id h142sm3805927wme.33.2019.02.19.04.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 04:36:49 -0800 (PST)
Date:   Tue, 19 Feb 2019 13:27:14 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v3 00/21] ethtool netlink interface, part 1
Message-ID: <20190219122714.GE3080@nanopsycho>
References: <cover.1550513384.git.mkubecek@suse.cz>
 <20190219103508.GD3080@nanopsycho>
 <20190219115727.GE23151@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219115727.GE23151@unicorn.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Feb 19, 2019 at 12:57:27PM CET, mkubecek@suse.cz wrote:
>On Tue, Feb 19, 2019 at 11:35:08AM +0100, Jiri Pirko wrote:
>> >- some features provided by ethtool would rather belong to devlink (and
>> >  some are already superseded by devlink); however, only few drivers
>> >  provide devlink interface at the moment and as recent discussion on
>> >  flashing revealed, we cannot rely on devlink's presence
>> 
>> Could you explain why please?
>
>What I mean is the problem discussed under Jakub's devlink flash
>patchset: that he couldn't implement only the devlink callback in nfp
>and rely on the generic fallback to devlink because it wouldn't work if
>devlink is built as a module.

So let's fix that.


>
>But I think this should be addressed. If we agree that flashing (and
>other features provided by ethtool at the moment) rather belongs to
>devlink (which nobody seems to oppose), we should rather try to make it
>possible for drivers to provide only the devlink callback and gradually
>move all in-tree drivers to doing so. (And one day, remove it from
>ethtool_ops.) It doesn't seem to make much sense to have devlink as
>a module in such scenario.

Agreed.

>
>Michal
