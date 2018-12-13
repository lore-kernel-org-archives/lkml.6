Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F4BC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06542080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="L7MOSdzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06542080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeLMGvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:51:38 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35908 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeLMGvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 01:51:35 -0500
Received: by mail-lj1-f196.google.com with SMTP id g11-v6so799169ljk.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 22:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AJrggUJM9HyRlJ9RZduko0OXl6m94GDAOUHtfdtlTaI=;
        b=L7MOSdzSpci07saepHTj/G6h8ChTaqpt8rBDu0KVKPEOtg++x1y+z81cueVg5RpKqZ
         AvCU2QfAQAt8WLvqE+N1JvvxrcWSluzkzZza+YNpBAxC7EM7dRkraRNz3hIV2At50ala
         sbVbnQr82KX0H7SBzkoZXa+B+E87664F9IkrYPCgIcW5oYn5ydl1Tj/BJ4ZSaJjlie4+
         NhAMPqlZYmmQtxHuFE6ZpyWEWx041tfutPDrGBmkBwN2TwvJYdxSAf1dHYnLda1VC3ti
         CNcR5woaxD2NXGLziNY+MEvMJGZSSj3hSAi/CfPRz1mK1RSItZMyZ0wO/Wys/j4N5Pi0
         wA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AJrggUJM9HyRlJ9RZduko0OXl6m94GDAOUHtfdtlTaI=;
        b=NCXdze4kO/SFA9ySvc/U7cIeGo6o46VbX2SksvQ5G/kh2YXP8HZB5bXUdzguGEjTdG
         wBUEWkvd4Vb4xQCmL7lRuEqgkTefPafa6tT6eeNGMEj8T/YJX1zx0M2bEktaL3w6TDMp
         h6aGtobYx8iH4qXKGqhTs54LBu/vXt3Q40GFSG08bKcOo15bwVkU/AVwBeM7AWnURIPC
         97DoXoxLDX++FBopoQQKHFvuTg1tgGJFERyOp+M43sGwjUxvOKu6ZTDXg9OvUUGi9K2R
         Hx+ANiFqX2Q0URrtfQhcE1swORCBwtlAT81WEc9px4By4Ei79uYHiuLq6ysqxXBQd4xE
         rbhQ==
X-Gm-Message-State: AA+aEWb11L6ry0OWFMAK+6FeRSELwGGso/1nDDJ80xu/XzFNhdhky5NV
        y+NGytk1vGyrWxktmpDAL4M1qg==
X-Google-Smtp-Source: AFSGD/WACcSR0S+vuJGTwPBupwzkY1H6lTzsmuDsUZIkwEZaThISHdAIOkBsYwgpKILjQmB6CNZntQ==
X-Received: by 2002:a2e:9b15:: with SMTP id u21-v6mr13554544lji.29.1544683891988;
        Wed, 12 Dec 2018 22:51:31 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id 1-v6sm144892lju.61.2018.12.12.22.51.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 22:51:30 -0800 (PST)
Date:   Wed, 12 Dec 2018 18:09:50 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/9] arm64: defconfig: Drop NF_CONNTRACK_IPV{4,6}
Message-ID: <20181213020950.42zjgd2ime4q5olw@localhost>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <189efc09-0863-11b5-2983-f27530176307@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <189efc09-0863-11b5-2983-f27530176307@free.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 02:01:13AM +0100, Marc Gonzalez wrote:
> Commit a0ae2562c6c4 ("netfilter: conntrack: remove l3proto abstraction")
> folded NF_CONNTRACK_IPV4 and NF_CONNTRACK_IPV6 into NF_CONNTRACK.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Same here, this one is no longer needed either.

-Olof
