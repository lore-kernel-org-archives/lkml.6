Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA30C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE7621783
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="gV+UXuSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeLaVe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 16:34:58 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43604 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbeLaVez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 16:34:55 -0500
Received: by mail-lf1-f67.google.com with SMTP id u18so18840410lff.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 13:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WnbZWoy2rLro01Dt+uigzbc8yjgcIx3mAJ25r/vZItI=;
        b=gV+UXuSqxUprCMrOB/fnu1urzK3z7FXrlbV83DBYuc3nXekfwgM/ABfteyaqzLNfpl
         BQqbbZ4e340QeXe2fsLd1XyFQxX7VdMVW8Yzn6ibn7R8cXiMgGoCvklzIGu81to9K9X4
         WR7UkljSy8REQmc3zkR1Hg9eKDxfhw0gOtzGDpG6gtTT4n5kApPCGSDe6SdrGLQVh3OT
         0VERp3h0K/O4n3S4ZYQYHTty5BSxKO78bjYD6t1RoMvhgns5ZmJK35AdwAfZwI3cuv9r
         7RIAS0M24BF/Kv/byy9OGdvKRCTSbXgeJa6bizD6ZKGXF8+yqMSUjorTcJv3L7NBpnff
         hKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WnbZWoy2rLro01Dt+uigzbc8yjgcIx3mAJ25r/vZItI=;
        b=h7oz0JOKeFAWkQGYMnoxBliDWmwNFsYzqKJ7/VOKWMqI0VNutrGqaunas1lYXFmTJl
         V2tfxjwJZJt0IJmDdotcBh9cDp0o3ubZtLlwM7vDohNpeRagZOmUnjIVo/wsZTaKzEJu
         ksXzTgCPBRbyTP7gZp6CLeBCNJp0BkSRLK/jueDl2qn/GKUkm308FUoCRhMiXgrJIlIz
         SgWrnOJByL6dlyh3ZHZleJnQLuBw5a031qZJfAoIJCiVid5pieNWC8EmMAlLJZ3snxWx
         Q44kpm6pxuSpfJV0ISrt576NMLE7ENOTnyD1RlPZl4KYfeuofHY9gEJXNm8Bijs6xMUV
         RV6Q==
X-Gm-Message-State: AA+aEWYErkNyC3VFXWhCtDEe1veNSrzg5UDPRy3sPFvmydzBlxAXXzrY
        uwwuYioycz2ttevd3lH7PAOY5Q==
X-Google-Smtp-Source: AFSGD/X+JEwWLAdr4ezbBQoPRrEQaw3ZjR7oDFv0TgKlas91iD5MAtK1yFIHt6BqyebGPar1FvYC+w==
X-Received: by 2002:ac2:4116:: with SMTP id b22mr20296052lfi.19.1546292092792;
        Mon, 31 Dec 2018 13:34:52 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id d15-v6sm10336661lja.38.2018.12.31.13.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Dec 2018 13:34:51 -0800 (PST)
Date:   Mon, 31 Dec 2018 13:12:31 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Patrice CHOTARD <patrice.chotard@st.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "arm@kernel.org" <arm@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] STi SoC update for v4.21 round 1
Message-ID: <20181231211231.gtqe7lvl3nokdcx6@localhost>
References: <9459cb9d-aafe-b712-9c95-30b2ff979d34@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9459cb9d-aafe-b712-9c95-30b2ff979d34@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 01:54:20PM +0000, Patrice CHOTARD wrote:
> Hi Arnd, Olof, Kevin
> 
> Please find STi SoC update for v4.21 round 1:
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git
> tags/sti-soc-for-v4.21-round1
> 
> for you to fetch changes up to 704cfd7f5f71c6bc6cdfaa63a16ed0f72882b1a1:
> 
>   ARM: sti: remove pen_release and boot_lock (2018-12-20 14:32:15 +0100)
> 
> ----------------------------------------------------------------
> 
> Highlights:
> -----------
> - Following pen_release and boot_lock cleanup initiated by
>   Russell King, .smp_prepare_cpus and .smp_boot_secondary STi callbacks
>   must be reworked to keep secondary CPU's bringup.

Merged into next/late, will submit for upstream towards end of merge window to
get a bit of soak time.


-Olof
