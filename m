Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBA6C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 13:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A282087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 13:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kippendief-biz.20150623.gappssmtp.com header.i=@kippendief-biz.20150623.gappssmtp.com header.b="iUVoJ3RT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A282087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kippendief.biz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbeI2Tor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 15:44:47 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44443 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbeI2Tor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 15:44:47 -0400
Received: by mail-ed1-f67.google.com with SMTP id t11-v6so10414478edq.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 06:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kippendief-biz.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9MccTDyreqT0In6a6lHkaX5W8SUzGwcrIU8DDyd2e4M=;
        b=iUVoJ3RT5V3R9yU7reSluCVuN4LnWsQrlW/XMDSRKA7d34gwEsB1ZZBmbSCb5wdoDl
         TdwcQ2rgyqUO/Y/3AvqGq3JAIi1GLTDdlRRMp+hP6o3J5M0XHaUMHHH2AG+B4o5cI75N
         P3/0o+FlMvtTvN3QwunlsdHzPDH7x6yQ0ahLXqyUNzItXG4J0/3qLUT/so9N4ZqjLINx
         DnVH6jZ4J3+ZA4c73stp9r2+cg6JAqzFDq+Ol3V1JHJc9P2/RKHRwI5aBrAvu0hBjyST
         WBqzQwp0gBKg/cXg3hZo7Qbu8AueMUQfSE1xlkxjoNdFB4EJ1qdNqkB7MyEXMNFX3QrX
         gsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9MccTDyreqT0In6a6lHkaX5W8SUzGwcrIU8DDyd2e4M=;
        b=T1j7lxk93oMwJX5GOFUFi2MJ0ZDY+/BfMD3ZpmQKz6kylmC9U9WuZpusTYdwEmp7W3
         7pPjh1lqKEaMIZig+9t1oZVQmb6i02xkrWqLEhRJtcmp3CT7B6Db1QJreVU+BRWEZSUP
         xTn2wdoNfjXpd0uUe48fmiFyc3F4TWdhPgtaGY7/8xT8Vg5YMCUdnQUIpPAHIDb2Cc3Z
         BbMnKHh39D23yt/ZGuvXy/ed+Ub36B4Jz4xoEA/wOhS4QuckwLed76nKJzONkVJMSuFM
         9dWHEoq2pkVQ1jxJYcslWBhvxXw0wNs8b4LwpbeyqT9FPK4gxGZt51SmBp123lfJw9xI
         Wm8Q==
X-Gm-Message-State: ABuFfohvYvZbccKu924MDSIqa0PuKLIOvTwiFjyqGvRgGBcvpXF896RG
        QnkqZ5CJXTfIHG6ndxFxl1JTbA==
X-Google-Smtp-Source: ACcGV63PpZ+w5YDAWn87q2CLRNeGCYOY06WvYuMm4UNBsJJCKO/Ee2tCV1RNoWVET3sgFa1Klkyotw==
X-Received: by 2002:a05:6402:547:: with SMTP id i7mr8593881edx.22.1538226980165;
        Sat, 29 Sep 2018 06:16:20 -0700 (PDT)
Received: from carbon.kippendief.biz (e0.carbon.efgh.nl. [2001:1540:801:2::2])
        by smtp.gmail.com with ESMTPSA id v49-v6sm1171787edm.6.2018.09.29.06.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 06:16:18 -0700 (PDT)
Date:   Sat, 29 Sep 2018 15:16:17 +0200
From:   Jorik Jonker <jorik@kippendief.biz>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] dts: sun8i-h3: add sy8106a to orange pi plus
Message-ID: <20180929131617.GA7940@carbon.kippendief.biz>
References: <20180927083636.5415-1-jorik@kippendief.biz>
 <20180928135516.jxhnsgaa3s2nagv7@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180928135516.jxhnsgaa3s2nagv7@flea>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 28, 2018 at 03:55:16PM +0200, Maxime Ripard wrote:
>The prefix of your commit title should be "ARM: dts: ..."

Sure, will fix it in v2.

>> I have tested this on two Orange Pi Plus boards, and they run stable
>> across a range of voltages (and frequencies).
>
>How was this tested?

Basically using intermittent cpuburn runs and monitor freq/voltage/temp.  
I've included a description of my test in the v2 commit log.

>> +		/*
>> +		 * The datasheet uses 1.1V as the minimum value of VDD-CPUX,
>> +		 * however both the Armbian DVFS table and the official one
>> +		 * have operating points with voltage under 1.1V, and both
>> +		 * DVFS table are known to work properly at the lowest
>> +		 * operating point.
>> +		 *
>> +		 * Use 1.0V as the minimum voltage instead.
>> +		 */
>
>There's not much point to that comment, since it's been that way for
>all the other SoCs from Allwinner. However, that would be great to
>have it in the commit log.

Totally agree, but I thought: there must be a good reason this text is 
in the PC dts, so let's put it in the Plus dts as well. I've moved it 
from the patch to the log in the v2 patch, which I will send right away.

Thanks for reviewing!

Jorik
