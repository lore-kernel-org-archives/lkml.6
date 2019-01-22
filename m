Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E1CC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFE120854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDHBQK3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfAVG5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 01:57:36 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45660 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfAVG5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 01:57:36 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so10589201pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 22:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KX+334cYjGcXGJ66+/XHNSazHDRAsVoHbJEBzsgSUy8=;
        b=HDHBQK3yrC57RNGmwCXHYiUDgelYIsKXm6Cnw70BwclNKaxB9yTFCfgGB9aZnbs4Cp
         /D1Jso6XgMmt5JYhAsqjhTL7dR4flp9izfjia5BIq8b49F8D7tcyDemtVb9Fcn8d0AC2
         vl6IV7Qgs4WLnIG8Hy5Gg2hCedv0tf41Gykqqg4o3VZC6G830AqtGJBWgUfMD6NM+fTX
         vnkTPGOt2LpJBXdrQPhLjjquCTc8o/89z4U4GNVJAXpWsN8AqS9DS4vP3sE7Vyllx8ul
         0a1KvV27UXiuoFpyj4IS5Pxw0puoUm4PpNtP0EPTqURrYN1wGs+x6ddqqVkJxoxpZUSc
         ZANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KX+334cYjGcXGJ66+/XHNSazHDRAsVoHbJEBzsgSUy8=;
        b=imU+ziM6KeVPX/vDeJmXs73bATzEnLLrkpcvjP3Q8daDKWRsUfVLe/N3RjRRyJssOm
         u3GI52hHk11K98QVz59GdH2gQd32cFhgJXztbgL9j5tYjOzSwG/JkKUXQQM0IoX1X7SX
         BX7BXCwrXI+l3RNOf997L3qU0OfDgbYnDqplhReKBNxtfbj/toU95NRa18GeIY2uf1DB
         3A6fS83KX28WObc8HeEs5JtBbRXh346EEIWO/211aoshdIHF5guvu1wc95dXpd1LEz81
         ipYMAakAmeR2DZbmlJ0G54WXBGjFvmV/qRw15qgY+h6E1wMfTwD3DlzpiWTFxVbJTQv4
         PWOQ==
X-Gm-Message-State: AJcUukf8Ko+tMlY05/Xncf5JFpl5bcpkAuPkhwvgmHUTSRqaDROdqahP
        ZND92Qvoklr+9M37Dv9cvVE=
X-Google-Smtp-Source: ALg8bN5DUJomSqWJjrenLNwvb60XVDZPa7CvNxp4s/9KJpzHJWGe2TPuOhDIJbv2Nzki74rvO+9jNA==
X-Received: by 2002:a63:c141:: with SMTP id p1mr31029001pgi.424.1548140255085;
        Mon, 21 Jan 2019 22:57:35 -0800 (PST)
Received: from chikyu ([106.51.36.2])
        by smtp.gmail.com with ESMTPSA id l185sm20196897pfl.54.2019.01.21.22.57.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 22:57:34 -0800 (PST)
Date:   Tue, 22 Jan 2019 12:27:30 +0530
From:   Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] drivers: extcon: Add support for ptn5150
Message-ID: <20190122065730.GA29897@chikyu>
References: <20190122044216.GA23297@chikyu>
 <1548061749-15950-1-git-send-email-vijaikumar.kanagarajan@gmail.com>
 <201901220830.8kqj0YjW%fengguang.wu@intel.com>
 <CGME20190122044306epcas5p30f875260e568d5fb0e4909035060f8ff@epcms1p8>
 <20190122045746epcms1p80456e6f7c5b6cd36b47f10190dd445db@epcms1p8>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122045746epcms1p80456e6f7c5b6cd36b47f10190dd445db@epcms1p8>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 01:57:46PM +0900, MyungJoo Ham wrote:
> >Hi Chanwoo Choi,
> >
> >This is the first time I am sending a driver to LKML. I have a few doubts. Can
> >you please clarify them when you are free?
> 
> Although I'm not Chanwoo, but a guy who's about 50ft away from his cubicle,
> as he appears to be busy today... :)
:)
> 
> >
> >1. I have developed and tested this patch on 4.14.89 kernel. When trying to 
> >mainline the driver should I rebase and send the patch on top of current tree(v5.0-rc2)?
> 
> Yes, you are supposed to be based on the most recent RC.
Sure. Will do that and push an updated patch
> 
> >
> >2. Is there any specific git on which I should test this driver on? Like below?
> >https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git
> 
> I'd recommend to pull torvald's master with RC tag.
Thanks. Will took into that.
> 
> 
> Cheers,
> MyungJoo
> 
> >
> >Thanks,
> >Vijai Kumar K
