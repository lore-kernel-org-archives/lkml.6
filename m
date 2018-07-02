Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2929C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C91F24CA2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="arkb5fbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C91F24CA2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753661AbeGBX14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 19:27:56 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45136 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753449AbeGBX1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 19:27:54 -0400
Received: by mail-lf0-f67.google.com with SMTP id m13-v6so60797lfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 16:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AYVR3qULoBQWyPHG8U1UonHohtS3XlGI7uzA6cd+W+Q=;
        b=arkb5fbVJBk/QIA7PqtdZ35nGHq0vuth8t51Uhvw6HH9ruWHuSxrsl1rn13LVR89vd
         HwFSyLdNtF4K3RAtAXRppMF1QVC2SEycpQAlOO7cmBiLCUFWNVkJK2RxD+0PmMrr6RiG
         FULSQEISSArFFibH4ZFbjaAiXa75nF6iPheJ5EGPS452Yl4+PhvmIH6e+2LyqooekTr7
         y/zxVissWwE2aMKn6mmic6DnmpUarybqb5XWQxIvQrik17OdeRBFu2rouCep3gaDBRDw
         G8JPOS3gBtgi7BnN94FKMH5hVxVdrfjINGMKGhTTs6itTXXmgwBAHfJiUbVRgKoSMmFB
         UmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AYVR3qULoBQWyPHG8U1UonHohtS3XlGI7uzA6cd+W+Q=;
        b=qPzgdK/7Q8joyzX0uH575mjNc3IDuofI8jbKglWsn4Lt2XvZV6UX0J8rTCYgu9W4n8
         CX8LbpnZZjlzE+nQjNxwbvuxeGc73AeYY3vCbxupC4LKodLagTJCk5gq78qLhWYRKgNv
         2VCajqlS38SX7JMd9uPhGMs3YGHQG5zv8j5sB3tWeGNVDyayYpKnoZeleN95AyXTAzMr
         ft3XJLArIhbnmxD5u5kPKgJPNopRmyeYagmNf8q3E/MF8TqUuSwfIj3fgSNKlCAZOuMV
         UqFyyXGFGCyB6JeM+9EjkyM1NoqLhfzM12XdS/958xylAPd0rHs1AjAmq7Mv0Rs1VIDx
         8EIw==
X-Gm-Message-State: APt69E2sxnAm9NDXuD+KCNM8zwRVeMtmCWXdUQ6TgWP1Y6QzFvKV7tjB
        +fakQbWgXdMLTSFTWBKo9Y3JRA==
X-Google-Smtp-Source: AAOMgperhuxHwK9kLNbvIwHA08Iu6nfUrg6RJtqodEdBsTzu3q+nUwkzWf9CvgR8CUYfMB2lTY3ucw==
X-Received: by 2002:a19:c742:: with SMTP id x63-v6mr17179871lff.9.1530574072773;
        Mon, 02 Jul 2018 16:27:52 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id q12-v6sm2698638lfc.30.2018.07.02.16.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 16:27:51 -0700 (PDT)
Date:   Mon, 2 Jul 2018 16:27:35 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        chris.redpath@arm.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/15] arm: dts: highbank: Add missing OPP properties for
 CPUs
Message-ID: <20180702232735.eocdrdfwyj37577h@localhost>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <f8a4e5c3062397736475ec599de730206846cb9b.1527244201.git.viresh.kumar@linaro.org>
 <CAL_JsqJRKMREfJ8LoDfuda8BU3g5Eq1AX5cPZGzO3uN3vUhrAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJRKMREfJ8LoDfuda8BU3g5Eq1AX5cPZGzO3uN3vUhrAQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 02:25:40PM -0600, Rob Herring wrote:
> On Fri, May 25, 2018 at 4:32 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > The OPP properties, like "operating-points", should either be present
> > for all the CPUs of a cluster or none. If these are present only for a
> > subset of CPUs of a cluster then things will start falling apart as soon
> > as the CPUs are brought online in a different order. For example, this
> > will happen because the operating system looks for such properties in
> > the CPU node it is trying to bring up, so that it can create an OPP
> > table.
> >
> > Add such missing properties.
> >
> > Fix other missing property (clock latency) as well to make it all
> > work.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  arch/arm/boot/dts/highbank.dts | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
> ARM-SOC maintainers, Please apply this.

Applied to next/dt.


-Olof
