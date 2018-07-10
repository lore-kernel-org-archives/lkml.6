Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE030C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5FC20877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jd5Y2yma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5FC20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933366AbeGJNFY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:05:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41839 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933304AbeGJNFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:05:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id j5-v6so8018983wrr.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 06:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BF+tYfdZeqFXFi+UC60TwtJ2Y+ZHW2xKkEBOV6nNBeU=;
        b=jd5Y2yma6W79O4QwkF4m9YLin90MM7xDIh9OZmlosXAFlm4ynD7fzaMk4TEdmBVq7U
         AU0lUHhybX8zL13Vpxq2yNzVZiyj4K6artM5W9b9o8YBCTd/K/9repCPv3NdOClgr09U
         llWGH1VJC4RCf2zQSZBnc81J6tiXB8PjIfskPL/eVccfAzwtvf7QUXB8C2H7Hb2SNx/w
         DfkPpYQdPkWlPuyM7hijzxvVo7ntdGrhNXK0OeYhhihhW5aT/XYHR9evA1v/x2bFnDJR
         QPdRY7V0WHPMitc4NmHnA/Lgxma3H7WRrUR3Ps+90dbtXHvmIGDsBukwcLMIT19nJXCj
         mcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BF+tYfdZeqFXFi+UC60TwtJ2Y+ZHW2xKkEBOV6nNBeU=;
        b=iPmQ6D2a00CsCqFip3d+qRer8NMRJgjArfA6mVKeFjNrKizIycs5rPvuNtI2WBDEkC
         RDSYzjPIRM5gghaPb/6ZLRlT2Yeb9oMZHGIyfPwAy7M4vtKYaamF+JhT4gh3WvokCm8L
         G+mldreJmZlXwYVnak8QgDGMOECe+hyHrwmGYkKUumleN/Gx0spwK2Nq1SFX5n40+awn
         Q/NJPbrt85adK0VhUaujixpwITW0Y6X8HeXviiOzHOXf6eHl0CDiJNXvxLY00PtMWhKX
         zhBiY44l4ts0XXpiwevcXcxLzT/fVnHz8KIV2NLNMCY3b+KK8yraoUAfkvp5kyu/g0dX
         T5oA==
X-Gm-Message-State: AOUpUlGfstbtRDWzAWK/+U9VPFkz2bg70P1KMpjqZbpzxwc5aUvBaYiM
        xDC94FsqILoP1sQp5Iz+q++W+jOb
X-Google-Smtp-Source: AAOMgpdn0g6rtDuiB8voYwyis4z9ZRK8gKdG0n1ieQ7eOlnX9HyLT/jtccpWolPfW073bAMvWDNopw==
X-Received: by 2002:adf:81c3:: with SMTP id 61-v6mr5266976wra.120.1531227920998;
        Tue, 10 Jul 2018 06:05:20 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id b7-v6sm22453856wme.39.2018.07.10.06.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 06:05:20 -0700 (PDT)
Date:   Tue, 10 Jul 2018 15:05:17 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     linux@armlinux.org.uk, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, robh+dt@kernel.org,
        tj@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 0/4] sun8i: r40: add AHCI
Message-ID: <20180710130517.GA27236@Red>
References: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
 <EF718AB4-DD07-4D67-BE2E-1B9EBA5EB25F@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EF718AB4-DD07-4D67-BE2E-1B9EBA5EB25F@aosc.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 11:44:20PM +0800, Icenowy Zheng wrote:
> 
> 
> 于 2018年7月9日 GMT+08:00 下午11:20:54, Corentin Labbe <clabbe@baylibre.com> 写到:
> >Hello
> >
> >With Moeicenowy's agreement, I have take leadership ot this patchset.
> >
> >There are no really changes appart renaming struct quirck to variant.
> >
> >Since the last serie is really old, I will answer comment here.
> >The two regulator (1.2 and 2.5V) are not for the PHY since:
> >- nothing in the schematic said that they are for the PHY, they seems
> >  only for controller
> >- all other AHCI driver use 5V for the target/PHY (vs 1.2/2.5 which
> >  cannot be used for target)
> 
> Target is not equal to PHY. Target means the supply
> of the disk, which can be usually 5v (for 2.5" HDD) or
> 12v (3.5" HDD).
> 
> By reading Wikipedia articles  about SATA and LVDS, I assume
> 2.5V is for PHY and 1.2V is for internal digital logic (VDD-SYS
> is commonly 1.2V on 40nm Allwinner SoCs; 2.5V VDD can be
> used to efficiently deliver ~1.2V LVDS.)
> 
> P.S. VDD-SATA and VDD25-SATA also exist on A20, and by checking
> Banana Pi M1 (the original Banana Pi) schematics, VDD-SATA
> is connected to common VDD-SYS (called INTVDD on the
> schematics) and VDD25-SATA is connected to an always-on
> fixed LDO, maybe due to the lack of power outputs on AXP209.
> 

So we still need to add a regulator on the controller and add an optionnal "phy" regulator for AHCI port.

