Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F7BC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 13:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E2F20875
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 13:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=markrailton-com.20150623.gappssmtp.com header.i=@markrailton-com.20150623.gappssmtp.com header.b="1iMi1iav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E2F20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=markrailton.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbeGVODy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 10:03:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38524 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbeGVODx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 10:03:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id t25-v6so4553391wmi.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 06:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=markrailton-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xI+JSRbehSZUoryQ2aZ+sONs6wwVur/poL4i9GvMfvc=;
        b=1iMi1iavUMbQaISoKeS3m36G3A6levZM76vhUgrLEP17YTA/G8uKxHJzQB6htNOZPo
         tM9OqtKd7xRtue1wm9WVAbMRzzc5c/RVVJXYpvzmg8P0QCFPMZPN7me12qel1X+mkyEB
         j+qSk0LMLUEfW7p/NsV5MaQru7WWRpyN3glWLFxutlx+9ltcWqQKdWwlFZPr4i0MXdBl
         2Q4cFpdPVoGRqUaGRSQGZGELPJEeLgUmLhABjOHge35MkjDDjc43a6/INxdYkxjgmn8R
         Q526I9uikAbPiFYjbKCuDdTOwZXxSNdbsgOrXe+tY/zCbC6BKHKR1p4SG2ALXlN9XcW1
         xJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xI+JSRbehSZUoryQ2aZ+sONs6wwVur/poL4i9GvMfvc=;
        b=KE5zTWmEkgGiX8+SXjeIik+WNM4Gnu2ZeuwFaxWh67sXdhm9AelD+vtl0X4DeFKbVi
         VvJsuK/8yY3/uvgHFmvEgzRLSxpRC9ggq0hq2MTiw1FEFOEtQxWDHW5mFKmxMsH/t/FK
         C2IFvkNkIIucxo53EOhptHfG93ywZGvFRk8CKamtbXXFesTQtSAzJangHg/ZXW1Hf2KK
         Ciyd8nByLglR/IM7oBXQkVrZvL2gdiV50sM26jk496v6r6AKjpIDxCvjNzgB5JbZEdL2
         5xPCrInR+a59YrAyD2sRu6nyvCzLlEQWxJON1GRldtoPF+sXXoLu3VWPwCCsFArlj7Tk
         dR4Q==
X-Gm-Message-State: AOUpUlEFzskYbn39FMOvbZXEHae5E6IJO2gLQv6ifRPnymx7NyZFxFwY
        +bboZ6VnxC2T6Wyp2EiPOYp78WwRxlh9zw==
X-Google-Smtp-Source: AAOMgpckGKkodJariyEthUD2CTuM9F+M7MqL7pnFTxWaYztdexuKBkuSFlJDDAg5Do+lSYUCaHU+NQ==
X-Received: by 2002:a1c:7408:: with SMTP id p8-v6mr5193657wmc.118.1532264834690;
        Sun, 22 Jul 2018 06:07:14 -0700 (PDT)
Received: from ZeroCool ([109.144.210.65])
        by smtp.gmail.com with ESMTPSA id t13-v6sm7351531wrr.74.2018.07.22.06.07.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Jul 2018 06:07:13 -0700 (PDT)
Date:   Sun, 22 Jul 2018 14:07:12 +0100
From:   Mark Railton <mark@markrailton.com>
To:     David Miller <davem@davemloft.net>
Cc:     inaky.perez-gonzalez@intel.com, linux-wimax@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: wimax: stack: fixed multi line comment issue
Message-ID: <20180722130712.GA15027@ZeroCool>
References: <20180719231146.24532-1-mark@markrailton.com>
 <20180721.193617.1393123001322216230.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180721.193617.1393123001322216230.davem@davemloft.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 07:36:17PM -0700, David Miller wrote:
> From: Mark Railton <mark@markrailton.com>
> Date: Fri, 20 Jul 2018 00:11:46 +0100
> 
> > Moved end of comment to it's own line per guide
> > 
> > Signed-off-by: Mark Railton <mark@markrailton.com>
> 
> Applied, thanks.

Thank you,

Mark
