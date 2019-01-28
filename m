Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC53C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9E02147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="NxxCMCTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390101AbfA1Q2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:28:41 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39177 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbfA1Q2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:28:32 -0500
Received: by mail-pg1-f195.google.com with SMTP id w6so7417870pgl.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 08:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=j+8H9loR0eGaVhsFlffHo/M3oOIvcygakltP7+fNtm4=;
        b=NxxCMCTJz7kj7nvzHz1uv4EZGlN2kxm+FFoSZC7ki/sxvsmHiPjmzf/ffTrJBu2QsM
         xzKJpbIK/ahpHwL8MmWXEwG9h6LBCeL9DvvFMsmclK6sfXPyKTdrrTYw5yfTFT8jiHpH
         26UPukngqxKnELlkOd4yryVZ11xWmAlGkM3jTSA+XpTAyNh1kWhCZSRNOiyrjDU67h56
         4AwVzEt8YElV9TD5QTCH/rzUXlQup0lkZJXv17MAZa7Xhz4AEgSUwsn9g4Uxtp0BZ+aZ
         DHBM4Wf1mScj1hNdhsJzW0m76ULh7xXAz0e+cj3vZPKGMH2LQFtRgMl7s14Xy3AcwG2g
         8zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=j+8H9loR0eGaVhsFlffHo/M3oOIvcygakltP7+fNtm4=;
        b=oRMrNR1jDUdBxSyRJ28W2vqoyB2d2qOxbv6ROprb80Wl2dVFE1kDVfLBdafurTxSnV
         NjPxgLG5YkzBAH9Hyip33IIodC47lwB7nSzEEhBFteg7lK6dvHmKMcTt6HIURp8Apa/m
         7Bf8SHg9wgwDkIh1C1TcFsujU+QPm2VKI8jgiMA1sVz60RUQFuXqRs1RR+ab1D4CjPNW
         tJhUqoGdnVX5nks+HvEIxHJrGraksNYP/b5tYdecOsy53umyk+RZxE5JFKjIe3YOlTJo
         hyUPmv1Y/q0HgzY8tmuQwF8hUxYPSqxSyU3HXQ11TIKZNH9gatCbEY7CHYLvJNAMRTtd
         Lo/Q==
X-Gm-Message-State: AJcUukccIlLW9g1eDxhLGA1JSkhhjkEY+4PGOoPGA0S/9FbbZ4cA5vRA
        XrLPT5abuOVRQtG/vSc+8OfVlA==
X-Google-Smtp-Source: ALg8bN4YJEwHUR5EGA3g3LctCuHGdV9OORdVfl7if4NoqwgQ8sA8a57ogdrJtDbnXV7BO0c9dSw/fg==
X-Received: by 2002:a62:29c3:: with SMTP id p186mr22918293pfp.117.1548692911945;
        Mon, 28 Jan 2019 08:28:31 -0800 (PST)
Received: from cakuba.hsd1.ca.comcast.net ([2601:646:8e00:727e::2])
        by smtp.gmail.com with ESMTPSA id p24sm50443786pfk.155.2019.01.28.08.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 08:28:31 -0800 (PST)
Date:   Mon, 28 Jan 2019 08:28:25 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        oss-drivers@netronome.com, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 094/258] nfp: add locking around
 representor changes
Message-ID: <20190128082825.4c8394a6@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <20190128155924.51521-94-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
        <20190128155924.51521-94-sashal@kernel.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019 10:56:40 -0500, Sasha Levin wrote:
> From: Jakub Kicinski <jakub.kicinski@netronome.com>
> 
> [ Upstream commit 71844fac1ed459024dd2a448d63d5b28b8c87daa ]
> 
> Up until now we never needed to keep a networking locks around
> representors accesses, we only accessed them when device was
> reconfigured (under nfp pf->lock) or on fast path (under RCU).
> Now we want to be able to iterate over all representors during
> notifications, so make sure representor assignment is done
> under RTNL lock.
> 
> Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Reviewed-by: John Hurley <john.hurley@netronome.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Hi Sasha!

There is no need for backporting this unless 51a6588e8c08 ("nfp: add
offloads on representors") is also back ported (which is a feature).
