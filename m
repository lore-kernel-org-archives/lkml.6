Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4E4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 04:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64536223C8
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 04:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLru68x8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64536223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeKPOwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 09:52:10 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32905 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbeKPOwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 09:52:10 -0500
Received: by mail-ed1-f67.google.com with SMTP id r27so15604707eda.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 20:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KFL2CePL0CfF7hHpaEzXB2jB74rTdzgga0PowQtfHDM=;
        b=rLru68x82erNdIf6bZAfSBWT5l97Qz3e24FnvN62gsNkapiwByrLaAmmteo9UxZJTL
         bld7ZJ4d18pynfiG0p5NMbDK+fSWR3Jb8VF6GyOBueO0SSiC6Dlu5DVjU8ic67UTGBeN
         6t6C+rZcy7JyBwcCGcgMvp8L5/Mr8sd6OCvdmXXT55lV9FO6NtTbIfPpRxzbXu8cq4mb
         cUUEfuZjWrM/TkIzZpY9ghICKMJ8BmUgc0oiRdmdCnG5o8Fnw25+pqt0RecPpA+Ru9hi
         bc7tZ/fLHEUJToHRnLht/Yt6gZ14NczNhn9fqJpiwvnx9gRIrNm4bVq6/uhEL2yFI72g
         f3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KFL2CePL0CfF7hHpaEzXB2jB74rTdzgga0PowQtfHDM=;
        b=eeMvwkB1LI58v/CxDat4HnHLrv0K5MguXnOvSf5CkIxrghyiPQoRjb9TAIlc+0mtIO
         xLiTnVaCou67XbUJkpsDBUcjQViu0w1SsePH0OMpCymp+mN8ACY6BjF2VxsZzWmx4buS
         vB760PAJXosyw5L+gvPvXDKtRk1O/YO/XrZ3KnAC/d1+Yxwi6BB87ly+397tl6WMo2U5
         DSkRvaH8+csGiEsiY1/Z3ESeq/nKzgWBrtPeDwktVwu7XX6UXR59m2MgpRKsqePElbEN
         0r47BYN5M00BwMRzzGuALUx3VykogCqawwIsle9/Ti27ogFkmaAZrIbi9ItrCSjXBDgM
         hK5Q==
X-Gm-Message-State: AGRZ1gKmq1b7b8cxrdlQyMp6799o19sNc7xAPBfc4sci/ZA7PhRk7DSF
        TFjXMNq1vc03LDH54m+KMEI=
X-Google-Smtp-Source: AJdET5cNHJCghQUGSpn6syVCWM3Yd4hAx7W7Oteaq4YpbDJOVcYIUVV5CTIR+S9YXmrVTvBSX73Ksw==
X-Received: by 2002:a50:b1af:: with SMTP id m44mr7965730edd.47.1542343280934;
        Thu, 15 Nov 2018 20:41:20 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id y53sm2753315edd.84.2018.11.15.20.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 20:41:20 -0800 (PST)
Date:   Fri, 16 Nov 2018 04:41:19 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, mhocko@suse.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: use managed_zone() for more exact check in zone
 iteration
Message-ID: <20181116044119.evn42acahfl6fh4r@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181114235040.36180-1-richard.weiyang@gmail.com>
 <20181115133735.bb0313ec9293c415d08be550@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115133735.bb0313ec9293c415d08be550@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 01:37:35PM -0800, Andrew Morton wrote:
>On Thu, 15 Nov 2018 07:50:40 +0800 Wei Yang <richard.weiyang@gmail.com> wrote:
>
>> For one zone, there are three digits to describe its space range:
>> 
>>     spanned_pages
>>     present_pages
>>     managed_pages
>> 
>> The detailed meaning is written in include/linux/mmzone.h. This patch
>> concerns about the last two.
>> 
>>     present_pages is physical pages existing within the zone
>>     managed_pages is present pages managed by the buddy system
>> 
>> >From the definition, managed_pages is a more strict condition than
>> present_pages.
>> 
>> There are two functions using zone's present_pages as a boundary:
>> 
>>     populated_zone()
>>     for_each_populated_zone()
>> 
>> By going through the kernel tree, most of their users are willing to
>> access pages managed by the buddy system, which means it is more exact
>> to check zone's managed_pages for a validation.
>> 
>> This patch replaces those checks on present_pages to managed_pages by:
>> 
>>     * change for_each_populated_zone() to for_each_managed_zone()
>>     * convert for_each_populated_zone() to for_each_zone() and check
>>       populated_zone() where is necessary
>>     * change populated_zone() to managed_zone() at proper places
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> 
>> ---
>> 
>> Michal, after last mail, I did one more thing to replace
>> populated_zone() with managed_zone() at proper places.
>> 
>> One thing I am not sure is those places in mm/compaction.c. I have
>> chaged them. If not, please let me know.
>> 
>> BTW, I did a boot up test with the patched kernel and looks smooth.
>
>Seems sensible, but a bit scary.  A basic boot test is unlikely to
>expose subtle gremlins.
>

Agree.

>Worse, the situations in which managed_zone() != populated_zone() are
>rare(?), so it will take a long time for problems to be discovered, I
>expect.

Hmm... I created a virtual machine with 4 nodes, which has total 6
populated zones. All of them are different.

This is a little bit out of my expactation.

>
>I'll toss it in there for now, let's see who breaks :(

Thanks.

-- 
Wei Yang
Help you, Help me
