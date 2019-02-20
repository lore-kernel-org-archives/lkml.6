Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21959C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E216E20880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="qquYV4hI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfBTUfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:35:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50349 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfBTUfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:35:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id x7so7979592wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 12:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tVSBVQ2Knp/p4Pz8CdyIVov3lZ61k7ZnCmxAzgxDbbk=;
        b=qquYV4hIxVsRMCwDAewSONP7uvP8726KuOReABJ0awFfwxH12rZfXCOmyYh/PdJUV7
         HE3GLR04MHsDmlc3XIbQY1+SjJZ39AcxnRSdCMORrGjKTztG9M9QggfBl7x8UpmWEDwn
         ZPoXIfH6oxJ/Q7KRD8KHYCSgclQkoHAxkMJxIDjCoLPnEooXamCTdCsMJ9IrpKwxV6mB
         21VPSJg8lX6SkN+dA23T9sqE6pfFN/0llic8wPVAear7RFuDiUMdMpBqPq1wSybQVVz/
         pjA/vbJHTckdTLB0heeqV6nA1AFMETwCf4jZnZ7dirPgM7cC488rge6bQGQZ0BwsalCx
         jVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tVSBVQ2Knp/p4Pz8CdyIVov3lZ61k7ZnCmxAzgxDbbk=;
        b=ZTShHU8CO86ilUMtSW6mjqyxd15EJveXrNyAxhJOUXSQwMGsvh4KZv41FIPQSg8DAE
         Nzdcixuoqucje21k+23cYU9duckT4WaYrIZ3BuENtEZp60nlfTfTC6Hu0VDS0T6H4olY
         PJOgyA9xaVlyUo+UMOtsSwl+l5kyjbOXh5EvW/9f0PNXnOz69XRjWYKMztDt5sN9q1Mp
         HYGbqT3QZZz+x9ugSRUhVRmWZiWLoHg9g7TThnNhDNuIlTbeERF4ZQ5U5K7zX3B7vO+K
         Upv3S7AgvpMY4pQGcWOG4FePiy1eGHQB3c+/DmL4jm4xxE40THxQmxM8aR3jhFAd/wKl
         c7XQ==
X-Gm-Message-State: AHQUAuYxVnQqQq5LsLVkA6QIvRhZDsjLCfJFw3Ey9sS0/5cE44l+OxVg
        gB5//VL18XfuYR+5SlXS4b/jyrKFi2A=
X-Google-Smtp-Source: AHgI3IYhFRltqXE9aTRbDe4AS+vYE9lm0Nj3IgOOSjThQJrD0lBhwG5GMiJ3CJwJis6fJxSkimH5WA==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr2490668wmj.0.1550694942420;
        Wed, 20 Feb 2019 12:35:42 -0800 (PST)
Received: from localhost (ip-213-220-234-21.net.upcbroadband.cz. [213.220.234.21])
        by smtp.gmail.com with ESMTPSA id x3sm24982606wrd.19.2019.02.20.12.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 12:35:41 -0800 (PST)
Date:   Wed, 20 Feb 2019 21:26:08 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     David Miller <davem@davemloft.net>
Cc:     vkoul@kernel.org, sfr@canb.auug.org.au, netdev@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch
Subject: Re: linux-next: Fixes tag needs some work in the net-next tree
Message-ID: <20190220202608.GP3080@nanopsycho>
References: <20190220083611.GJ3080@nanopsycho>
 <20190220.110201.2245447687492293995.davem@davemloft.net>
 <20190220195811.GO3080@nanopsycho>
 <20190220.122522.1237657062289636264.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220.122522.1237657062289636264.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Feb 20, 2019 at 09:25:22PM CET, davem@davemloft.net wrote:
>From: Jiri Pirko <jiri@resnulli.us>
>Date: Wed, 20 Feb 2019 20:58:11 +0100
>
>> Wed, Feb 20, 2019 at 08:02:01PM CET, davem@davemloft.net wrote:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Date: Wed, 20 Feb 2019 09:36:11 +0100
>>>
>>>> Would be good to have some robot checking "Fixes" sanity...
>>>
>>>I want to add a script to my trees that locally do it for me but the
>> 
>> When it is in tree, it's already late. The robot has to check
>> emails/patchwork.
>
>It's for me, on my computer, to abort things when I try to commit
>with a bad fixes tag or missing signoff.

Okay, but still, robot checking emails/patchwork would safe you some
overhead.
