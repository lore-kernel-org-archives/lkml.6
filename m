Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA65C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A992082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="dte/4yGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A992082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbeKCD5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:57:13 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36920 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbeKCD5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:57:12 -0400
Received: by mail-lf1-f67.google.com with SMTP id p17so2015002lfh.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 11:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3Y8ZhdAFu44/oSMNmaWfQ4wVylL+PvM8CAbjqPIj+zQ=;
        b=dte/4yGYSIwAgcyaZKiFb389k/fZ2vN+tvl4JEpMWKcSp28/2C6QYq9hSrZToZ5z9m
         OHuyyGfId3dqAZX9jct/1Hwqso8I6gEgZSpxSqmwr9hsVcjEhSkensEoB/fNFIldvINz
         TS25qXqB4c6/mQGOJ8zGu+AoOHF8vRz5z8rygq+uBKPbcmZAdZCgLhQsnOzVLPMTBP05
         jCUzopMIJtdeSPTT8CbnLLmmFF2TVKBXpfOhjP3pDGLWoA3ohQeaX+Cyjedmz3u8R5iU
         6boax3pb1Sw3dxE4X9o9meE3DOv0Dde7WOmdO9WsqKSp/eD038KQQDZsgKdQ4rGDYNl+
         pzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Y8ZhdAFu44/oSMNmaWfQ4wVylL+PvM8CAbjqPIj+zQ=;
        b=Y7D5/k0zRgCNQCu7cZeSPWhRvTtbsNjxkbcObKBrqXIhEjI3UlR7+fOZgAAHp6JEkD
         AxcAerlKgW8GWy9XtLQT3qo1/y99FtBoJSLH1ptySrDddsG3JaWqrpFofUD38+PevQ0X
         K6gCnYSilC5hJwrmMA6iAFWp0aYaEjT69KcYiVILY6t58Gcct9ok4WTeJUkfjxLFRUj6
         SmjXA/qBYYAVkMg3+1LrnmUB9G+LcGipKH4w5G6CP21Xlp8LtrwKO2K2+cnOLoQtCjA1
         lireZthKy1xIynE/y16DwblanUDg0D+M/f73YObjYwwCqO3KeDJB8cv3DgOMx5S28luP
         CLSg==
X-Gm-Message-State: AGRZ1gJMumAgycXThfzIFuCjJ+TLXBMVFAJGmlMOeosSuDPkL1+drlpw
        25eIOl+F/PPc0nJUh1yuDnG38g==
X-Google-Smtp-Source: AJdET5cbjjO8OqFMV06f+1TbrY6Y4+dLMeljFYVXbBvMuNnwKROV8pNKZAbINmN+nG2cEWzi0iJYUA==
X-Received: by 2002:a19:5059:: with SMTP id z25mr7438647lfj.120.1541184536816;
        Fri, 02 Nov 2018 11:48:56 -0700 (PDT)
Received: from localhost ([85.30.9.151])
        by smtp.gmail.com with ESMTPSA id d15-v6sm2134389lja.38.2018.11.02.11.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 11:48:55 -0700 (PDT)
Date:   Fri, 2 Nov 2018 11:24:35 -0700
From:   Olof Johansson <olof@lixom.net>
To:     John Garry <john.garry@huawei.com>
Cc:     xuwei5@hisilicon.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arm@kernel.org
Subject: Re: [PATCH] arm64: defconfig: Enable some IPMI configs
Message-ID: <20181102182435.x46hvfgegxprksxq@localhost>
References: <1539879427-11816-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539879427-11816-1-git-send-email-john.garry@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Fri, Oct 19, 2018 at 12:17:07AM +0800, John Garry wrote:
> The arm64 port now runs on servers which use IPMI. This patch enables
> relevant core configs to save manually enabling them when testing
> mainline.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

I don't think these are required for booting to rootfs, so I'm applying
the patch but switching them over to modules (=m) instead. Hope that's
sufficient for your testing, let me know if it isn't.


Thanks,

-Olof
