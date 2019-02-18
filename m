Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2730C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DCE217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="KNwb38aR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfBRUBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:01:17 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42996 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbfBRUBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:01:17 -0500
Received: by mail-pl1-f196.google.com with SMTP id s1so9222543plp.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 12:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Cav/vpETMTBM1Sm3PV6grwawfdn2w3DxKQNrzJIaKos=;
        b=KNwb38aRpMN4NNhr6mSgOI3aqy2zfJMKUmEwVRTLRc/V62ArZbmhNhpZq4/7OZqT2q
         CHh+op5G02fIdnxiV+2it+ds4QbgzoJ95A4UblEHCBW8WLuhnMHyolRdbEKd0Sqzqnj0
         MaQkZ+uA+iKIKXxHnPmjCYFjG0kZpXKMCfU724b5x1J3z+43RMyeqmJCZ02HeXPwJ97K
         Z3P2v3Pch2znYlReiJgASuTo7NWGzAYTeLeWKPTb8rKFd1tUhXkful87mX1p8kjJ1hIp
         PCtrp5uGz+xZqn/HkwL+xczysPTDPzYjDdsU51P8gbvpYe1I6lvDj4hNdhge3t9RQOcm
         Kbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Cav/vpETMTBM1Sm3PV6grwawfdn2w3DxKQNrzJIaKos=;
        b=mUzlD0hkNtVrd28enUZVJRJgvP/tuXUueMTlqxuiygaEJ7b4I1FSOcmPsUDyCMqeKB
         mvIk22WxLt8Dtw0ybg6HRWh9QPplJ2lR8eWYy/vQhoD8kMcIyHcLKepj+Y0ujYuiv03x
         m17m+mokHzFCFL07X1gyyFOX/4LDrydaHwc1B9yEHBMpYTWiUiRscNqQB4qMwIZVSVzy
         xhysC11/Zfoaao2k7FrjERlnbNPtqFJ1fcerzduAoRugTbbO6RVCVoqlPmRYgnRfl1aL
         mz4AYZ0wrBv6z+QdZeX2y5J6DQEdB6fhoY4r0tD8fbMyZYyD6S8Sh2Xls3VbBB2KzQEY
         RJ5A==
X-Gm-Message-State: AHQUAuYNcz2WmUD4l62h4cRj8vTM+LvAI2SjYdowJVYYCLPvmOZ9XIuz
        hrjSjgoOW6uQ6ZeurwHV79fNNA==
X-Google-Smtp-Source: AHgI3IZEzqTt2CreleS+uR0CDwwKI/0W1D1AIqG/sh/Dntwev68zrIqZIKWHkbKJKYLGgXKcNj/c5A==
X-Received: by 2002:a17:902:8f81:: with SMTP id z1mr4256905plo.265.1550520076458;
        Mon, 18 Feb 2019 12:01:16 -0800 (PST)
Received: from cakuba.netronome.com ([2601:646:8e00:1b7a::3])
        by smtp.gmail.com with ESMTPSA id b15sm26107447pfj.44.2019.02.18.12.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 12:01:16 -0800 (PST)
Date:   Mon, 18 Feb 2019 12:01:11 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, Jiri Pirko <jiri@resnulli.us>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v3 02/21] ethtool: move to its own
 directory
Message-ID: <20190218120111.312bdd16@cakuba.netronome.com>
In-Reply-To: <2078f959ed3474c4228fd6016c892331f8e2c7b8.1550513384.git.mkubecek@suse.cz>
References: <cover.1550513384.git.mkubecek@suse.cz>
        <2078f959ed3474c4228fd6016c892331f8e2c7b8.1550513384.git.mkubecek@suse.cz>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019 19:21:34 +0100 (CET), Michal Kubecek wrote:
> The ethtool netlink interface is going to be split into multiple files so
> that it will be more convenient to put all of them in a separate directory
> net/ethtool. Start by moving current ethtool.c with ioctl interface into
> this directory and renaming it to ioct.c.

nit: s/ioct.c/ioctl.c/
