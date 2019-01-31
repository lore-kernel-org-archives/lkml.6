Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C19AC282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2335A20857
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="xMFEGRCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfAaAwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 19:52:32 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40739 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfAaAwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 19:52:32 -0500
Received: by mail-qk1-f193.google.com with SMTP id y16so939331qki.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 16:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=gvBL5Mbhzr7YyFMTV4GvOGKr45VTxsd6dUHm5sivECQ=;
        b=xMFEGRCx0NXIjoxPP96RZP1v09KwNWv3l9i7OyqhZO1cne8yHUgkpYdaazUmlyWtl2
         ctR4b+LpW03bFjlUSmqihuMI9ivFddaHkXzxtQUQ7/YpmyQnEGViT38ye3gpYSPNp59w
         8c8SFC5hTRKb4uew9zTJ/dBwebjZwWnmX+mE74TUEkAf5gZptpp8TnQW0BWse93/DB4J
         CND8YCiOIBQwL10Mm/Zremgmlv66Gei/yQ0+Mv8H6ywmA1bVkIcoTZ7GNW25xqoUZSXT
         AAlAbBf+hlZg7PVhQPb01a79CMBPVY59McJolqyF4Rj2tkjwErWGg/GQnw0LVoA2BLPf
         Jqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=gvBL5Mbhzr7YyFMTV4GvOGKr45VTxsd6dUHm5sivECQ=;
        b=BuMlZyacndZcTLUOU+uO2AzXGPl/d2lNlHCYEU9FJdxCO+9vx5peUew1GaoKvg7SuK
         QEMag307j2qqcbFclzQFeFmWe8QeFyg7JsAvRN0dkFR8UeQPvllD4ICmFrXOUFes1SNE
         aaF2hH/ROhISF7/OEZhIWPmYyoW9jQqf6iIOhRV5wE22bgEFdZq0B/db6gPMV7FkwN6j
         kfzXcwKo4U0uSkGQF7JTvTlIH65XBnMSvUbfZxPCyPjpxWwwBF5bt1QdP+T2lNQx6S/j
         VOFww2hK5OXnuv4/znYx+hT0fXyOiJLW5s2PLEm//3R9XHwTEmOx6sic0/8Unuf17pQm
         iC1Q==
X-Gm-Message-State: AJcUukeqcyLpwokwraXcRAoKtcHrAhmNefwarZCXOYXJ6N1iJco9OQ63
        xqjI+UjHV4qsRMVOOhUGktn/ew==
X-Google-Smtp-Source: ALg8bN7j/cITU37QA9MIdVkSVQincQXfO0Pl7Yd8AXL4gbNRPX6VspGkTBYpDzeO09v8+hXb6xTW5g==
X-Received: by 2002:a37:a80a:: with SMTP id r10mr30752930qke.2.1548895951482;
        Wed, 30 Jan 2019 16:52:31 -0800 (PST)
Received: from cakuba.hsd1.ca.comcast.net ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id a185sm4279071qkb.1.2019.01.30.16.52.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 16:52:31 -0800 (PST)
Date:   Wed, 30 Jan 2019 16:52:21 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "David S. Miller" <davem@davemloft.net>, oss-drivers@netronome.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] nfp: use struct_size() in kzalloc()
Message-ID: <20190130165221.243d37f9@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <20190131003859.GA28539@embeddedor>
References: <20190131003859.GA28539@embeddedor>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 18:38:59 -0600, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     struct boo entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + count * sizeof(struct boo), GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
