Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71633ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277E820684
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="dC4eICP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277E820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbeGQSbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 14:31:16 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41403 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbeGQSbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 14:31:16 -0400
Received: by mail-qt0-f196.google.com with SMTP id e19-v6so1669633qtp.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 10:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=bmAyHcDD/Xc2tb4UqnQcDKH5J0/3De7sxMrzFlHQ2p4=;
        b=dC4eICP3eGZ+c5d22OChe8UTqQVXW5tJk0YYdB335OTslm4f/VEz5RZfSozX+gaava
         7wVFqeedHKJ5GB0YtYiIaBpzEtu4QsoMTNqoHXqMX/lM5vBE1CyIV48lhaC3iytcl4BB
         dlcOm5jX6c6qy+Ne/KIznOclHevgcYX/I59gDfiFDRyQIkpoUBvhks+2BIHTHGlf6P0M
         kKVpNb9Y2qmItJtezrQkM/QxABb1Zm0nXGNa87ce6y5YHcRQVx+1kG5fxj17PCkDQRXG
         Uet+4aPdpMvyvFrXz19QuAFJ8+7tg0+UgIpY3UeIHu/OPMDhV/sDllbDXxis39xzLW4k
         /oHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=bmAyHcDD/Xc2tb4UqnQcDKH5J0/3De7sxMrzFlHQ2p4=;
        b=DNlgsJDCE9MZKLSkaVVhxbGO+jiv9lVJWiazy0jliNDc7zEU1XNxi/CvCDu1dA4/tS
         qyW4Oaf9/PJjLUffPF3yBXwjchTz70JMuvCIHo5CU3vQKo8oEEhAp2+cMQyJmqIXmnVF
         SAnx4U6jzIH6EiI9v7WrexMK2fkoZix7nKnOZX2xmf/XoJKczxE/gUGbB9KFhV91NQ15
         zWKJiExvp2fn7eAsyOUfvpXFu/d/U1hlqO0/Qh4lrf3k3sheUnhAJz3zpXKuSUQoBoAb
         SU1MCToA+A/EreJpXqYqT7gVwGyFyusXHq7WH4RDNgcmK12s47T4TKZqhKCzsDAvMaEn
         xFyw==
X-Gm-Message-State: AOUpUlHGAzAhYBh0YcOaMDm7PWIf+zGRbZRD5BRKpgtw4XuaupboVteY
        Ol+cwzmm/utIfbj2Lg/oVJdX+A==
X-Google-Smtp-Source: AAOMgpeEOEJzw5lS4xVKsVovKVCDKmbbgRN3NPFs3u5gtIHeylT8jTEwHP7aipmpvqUD7RkXhIPw7A==
X-Received: by 2002:ac8:234f:: with SMTP id b15-v6mr2634886qtb.336.1531850249641;
        Tue, 17 Jul 2018 10:57:29 -0700 (PDT)
Received: from cakuba.lan ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id m12-v6sm1411170qkl.54.2018.07.17.10.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 10:57:29 -0700 (PDT)
Date:   Tue, 17 Jul 2018 10:57:25 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtnetlink: fix uninitialized variable
Message-ID: <20180717105725.5cb8a405@cakuba.lan>
In-Reply-To: <20180717134314.GA31127@embeddedor.com>
References: <20180717134314.GA31127@embeddedor.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018 08:43:14 -0500, Gustavo A. R. Silva wrote:
> Currently, there are execution paths in which variable err is
> returned without being properly initialized previously:
> 
> 1417        if (rtnl_xdp_report_one(skb, dev, &prog_id, &mode, XDP_ATTACHED_SKB,
> 1418                                IFLA_XDP_SKB_PROG_ID, rtnl_xdp_prog_skb))
> 1419                goto err_cancel;
> 1420        if (rtnl_xdp_report_one(skb, dev, &prog_id, &mode, XDP_ATTACHED_DRV,
> 1421                                IFLA_XDP_DRV_PROG_ID, rtnl_xdp_prog_drv))
> 1422                goto err_cancel;
> 1423        if (rtnl_xdp_report_one(skb, dev, &prog_id, &mode, XDP_ATTACHED_HW,
> 1424                                IFLA_XDP_HW_PROG_ID, rtnl_xdp_prog_hw))
> 1425                goto err_cancel;
> 
> Fix this by initializing variable err to -EMSGSIZE.
> 
> Addresses-Coverity-ID: 1471831 ("Uninitialized scalar variable")
> Fixes: a25717d2b604 ("xdp: support simultaneous driver and hw XDP attachment")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Looks like duplicate of:

http://patchwork.ozlabs.org/patch/944662/

Strage GCC doesn't catch this even with W=1, the code is fairly
straightforward :S
