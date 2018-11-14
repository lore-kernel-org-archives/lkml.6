Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48DCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE9822360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="HMwWPhfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE9822360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeKOF2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 00:28:19 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40354 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbeKOF2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 00:28:19 -0500
Received: by mail-qk1-f193.google.com with SMTP id y16so27864384qki.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 11:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gRSFnrDdEfeCnSxjAhBx/xjjgTAe561AumAUUUB4KFY=;
        b=HMwWPhfjTvn36YzA9P6hi2uCGqJZa88uh3VTTtb78zDSsYJTjzWQUXJr3SNdILjMcX
         C2Np3YqQv5ne70FfuVtUUO4GTovNe0Xa1J0mimkkYYyQhO4KdCVtM63yBUVCJX9bgzhY
         tYE7osscpI7Axzgl63zQfTSdKoyIcEbhyG9j7hiYBut8Fqm1q4OakQWAgHwiGxMpSFFx
         /NAK6ol+AvzJN1D2NNMxPWK2oMLeLVyt2S5QrA7WxAU5jBwKS7RCrKx+YcH6BbdQkaMD
         qJkgSMXer5k19IcUO7tXjB2JFQzcpdqEn5dh7O/tBF+C715tjIBZeyjEqhUIaEeMu9Up
         LI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gRSFnrDdEfeCnSxjAhBx/xjjgTAe561AumAUUUB4KFY=;
        b=Hs7i8gKa7//AdQGsRWD11yLvS2oRE6jlhT0a4vgBm0KAB2Hfiuu5zG5HdD893Z09+1
         d7rPu/6e1EeX380/uKOQRFvuUnyP34QGIyAer5e14jvKarMTxLkXkruy44CstX/HF/d5
         F9VEJVtr3bYF565Sh6XNzQMAQ0IQ4yIZEOz6Xf9Z6yMA+rIp/O73YbjwlETMh8wGlmhG
         N7e/aXIU01j5yZq3+3KKDCJj8rqCUKEhzfpov3w3tUjJMFZx2Q6KerCbAx658TDsCHP6
         N+ucmd9xsutkmHe6EhlurZZmx5X5C/VEWC5QvI4o2isF5cbIL2EdlGpNpUBukOKuylJC
         bbhw==
X-Gm-Message-State: AGRZ1gLNqfnh5ezrOQgwT0ktX4+sPT8V6AHpiaJRX0Lxk0nAyX1Ci1/I
        x/X05zo8qCvBZ9vpJDWIPOMACg==
X-Google-Smtp-Source: AJdET5cyf3WA9BmhKeQmH551O2Z4mit8VoZ+1RpTxZgqVbYui4i0oHnYhB+9K3dw1oXhJPYZIkRrVQ==
X-Received: by 2002:ac8:160b:: with SMTP id p11mr3041068qtj.113.1542223429510;
        Wed, 14 Nov 2018 11:23:49 -0800 (PST)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net ([40.117.208.181])
        by smtp.gmail.com with ESMTPSA id j95sm8386727qtb.74.2018.11.14.11.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 11:23:48 -0800 (PST)
Date:   Wed, 14 Nov 2018 19:23:46 +0000
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Arun KS <arunks@codeaurora.org>
Cc:     keescook@chromium.org, khlebnikov@yandex-team.ru,
        minchan@kernel.org, getarunks@gmail.com,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        mhocko@kernel.org, vbabka@suse.cz, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vatsa@codeaurora.org, willy@infradead.org
Subject: Re: [PATCH v5 4/4] mm: Remove managed_page_count spinlock
Message-ID: <20181114192346.vgqrricdb7to7hgr@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <1542090790-21750-1-git-send-email-arunks@codeaurora.org>
 <1542090790-21750-5-git-send-email-arunks@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542090790-21750-5-git-send-email-arunks@codeaurora.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-13 12:03:10, Arun KS wrote:
> Now that totalram_pages and managed_pages are atomic varibles, no need
> of managed_page_count spinlock. The lock had really a weak consistency
> guarantee. It hasn't been used for anything but the update but no reader
> actually cares about all the values being updated to be in sync.
> 
> Signed-off-by: Arun KS <arunks@codeaurora.org>
> Reviewed-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
