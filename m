Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A19EC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58ECB218AE
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549470693;
	bh=x4O2rKMUHneESOs/x3nZjLviZNFFCGCNSGGhzn8fLZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WFZ0X1PGYafEXqLUH+fUzIKsxZAo5N/Wl2/DOwB0zFaRQndrmuc5PGKF/6MDhtO4g
	 w+mJXYUmqW+1GZumPNnUrtfkCN7oupC6dFCtbyIivdcdrZ26SQxn2E6Iox5B+xrIsa
	 fR6WnT0suSE1HZB4p3kIO8gAGgpA+C9l4QiGAQTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731132AbfBFQbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:31:32 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45429 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbfBFQbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:31:31 -0500
Received: by mail-yw1-f68.google.com with SMTP id d190so3335619ywd.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 08:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wNdena2+B8aX2a+ugM0wS8/ZQKJ93/KLLHUWmxBvBdA=;
        b=FoyI7ozWtdHwL7oqCXYUUa27Kf/CaiprIDAZ27rG/ACpPLcrWyKa5448OHvNTwROYF
         NwPr1ZVvQRs26d03SWa2IgPykTLNmR2baqqGttPyd4YdRX2bTD0ATz7oXqJ56LbNDLqs
         n+aajVTnCVnSMj2BW6HTRm4ujB0BNTlZ5GrZJ/IntyXEoW1lE9ItV9X+hU0jtYQGGPGu
         VfWmViXqIKvfKe/zlpj5v0kpLi406kWNT2Ed9GqNjJwpZjIkIAwQTbj1/x1P94/fq+H8
         J5WBCLIdTFycbBUHFlDNjEv4pO3T67zIeW0GBSE0GGjgCxfNMQ5TGYbiq9tDAABK1t0+
         c9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wNdena2+B8aX2a+ugM0wS8/ZQKJ93/KLLHUWmxBvBdA=;
        b=S8gGmZtqXZ9IfAjSH8f7ZdjLBtieoxEw+lB6wW+HqGVuiULYY1LwkKwYGZU7Rr5HEu
         C3BZb+74wG8wsoiiF4ClnhGy2EFpQua5wwByRNtPrKEiSnruugBQOZDP4yEejtnutgZg
         bmErrK/BnQfFubVPfnEBn+n5VYIgwVhzvfcOCHCF31etSPkqmUyFTTCkHmg6npYv7NQ1
         LpeEzP6I2p4f+sOzZp7dP0MpNfTQ9T5yhzKT222Vr1LyILbkAMtfzXvm/jWjFMRZcGtc
         uJe1cGUHfvmNBo725UrKkRjOapzXJoQANJli2s3J5rNmew8SK7XjbP0tnhuCURJBBB4Q
         Yfxg==
X-Gm-Message-State: AHQUAuZbDinFkOhbeH4jSVGLi14PZZsbHVjLjfvYC7UeEVFo8qxXh3c/
        ElfM7CmYh5nRt8N2GvN2yEQ=
X-Google-Smtp-Source: AHgI3IZSfrAYkVVaIWkI0ae+BkZR3ywza4XTLtz8W+WpLFGoP2XVY2s3W+QFN91LpxAKSw2sgqk32A==
X-Received: by 2002:a81:1d44:: with SMTP id d65mr9320079ywd.483.1549470690190;
        Wed, 06 Feb 2019 08:31:30 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:3bf9])
        by smtp.gmail.com with ESMTPSA id x132sm4394382ywx.27.2019.02.06.08.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 08:31:29 -0800 (PST)
Date:   Wed, 6 Feb 2019 08:31:26 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] kernel: workqueue: clarify wq_worker_last_func() caller
 requirements
Message-ID: <20190206163126.GH50184@devbig004.ftw2.facebook.com>
References: <20190206150528.31198-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206150528.31198-1-hannes@cmpxchg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 04:05:28PM +0100, Johannes Weiner wrote:
> This function can only be called safely from very specific scheduler
> contexts. Document those.
> 
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
