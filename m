Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED96C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E23B206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="QXwFdBJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfBVVUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:20:43 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43206 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBVVUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 16:20:43 -0500
Received: by mail-qk1-f196.google.com with SMTP id f196so2001116qke.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 13:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=3UqzpPsgkxFNh3UFnvsUKpp0Hxgf3s0woej6WQmMpZ4=;
        b=QXwFdBJPBRjLa62wq+w2nwnCVCdQa2bzlx/kKX1X1Cc8OmvcHof3ZwexDon6aKJkQ7
         4s1cNVEINPi+N8vyys0vtMXhyZi7vs1VqXiXneQ0k0Mf+xlSzVIat3nZMbDT8E3bmlqK
         X4aP9cvKJr+nT+A1+KCn9A/fCaQsinps78Fc10Z+wqzrqGv9WCLqKYiDgGpmyfGlF2yX
         LI+AMbgkmEpgKt5IPq98vU7f9Z8dxbwi4Or5Il6QVLSZVEknHX/4AqecQz032nwJrWYd
         X+kIB9+B2+SZUJZpFGm6WKW3ZRFm+vPGzF+MMuItW898EwxET7M6c7OAvYnHO5NTLdHl
         GArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=3UqzpPsgkxFNh3UFnvsUKpp0Hxgf3s0woej6WQmMpZ4=;
        b=KPa+xcIDzf2gwS/po0Naw+r8Tv4wm+z9kNaYF6tJf70+NiFH0j/rvo2aNmAsryKS9O
         xJhaEqhqfmi0Ul7xyyV66tX2w89JVMjoa7u1EbSgJMCF+/xCFCAHQczaqdObT4WIpGo6
         0JPEhqGSBdw8+jXQVfDxvLAVHWNxa5SDZ+AaqMDIfurum+KaAAKkbQJExbmLJZvcnSJP
         pVHg+tvSAB1g9sNxRENoiDYWlwLZjHb2YaB3zHQSOr04v0yTXwHQNZpy4uilJ9j08dRy
         2JtKq9OlMReonTvTohk21pE/7JThDsaqL9BJzw4LGte4LC/2r3Ufz026L1mEjaaVeom1
         qWqg==
X-Gm-Message-State: AHQUAuaaebH6uV8mhaoVw4cE04HZiCCbWGzh95UNnYraRyrFymKrYrMk
        Ue6lHukIB+pQFLirsdTKj/gxwA==
X-Google-Smtp-Source: AHgI3IarY3u88X+tqreKrgZMANb9I6vbQKbXy3TXbGwAmVIX1Vx6EFTx/IBhjulpQQzP5lBah5gKrQ==
X-Received: by 2002:a37:4a4d:: with SMTP id x74mr4528752qka.61.1550870442427;
        Fri, 22 Feb 2019 13:20:42 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id l24sm1668100qtf.27.2019.02.22.13.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 13:20:42 -0800 (PST)
Date:   Fri, 22 Feb 2019 13:20:39 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        Jiri Pirko <jiri@mellanox.com>,
        oss-drivers@netronome.com (open list:NETRONOME ETHERNET DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next 1/2] nfp: Remove switchdev.h inclusion
Message-ID: <20190222132039.6ff27320@cakuba.netronome.com>
In-Reply-To: <20190222203134.19508-2-f.fainelli@gmail.com>
References: <20190222203134.19508-1-f.fainelli@gmail.com>
        <20190222203134.19508-2-f.fainelli@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 12:31:33 -0800, Florian Fainelli wrote:
> This is no longer necessary after a5084bb71fa4 ("nfp: Implement
> ndo_get_port_parent_id()")
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
