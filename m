Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F020FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE9E2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="wqUG50Df"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE9E2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbeK1ID6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 03:03:58 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34666 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbeK1ID5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 03:03:57 -0500
Received: by mail-qk1-f194.google.com with SMTP id a132so15556703qkg.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 13:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DKhHMZUmO4T2JI4GxBQQCY43PdHMrucN4JTGGfDXF4A=;
        b=wqUG50DfArZzDI2OENoPA7BlkLdyZFZecJxoqhGbU8JT0QLUgpjFdZ28glcNyCIpJH
         lvr+lLx0UGFkPTk3rpMRBui/6wna+WpJuCEG5yyCTyzthtoEOhkbdpADrH710MDpqA5K
         p41XUCY6XCpQtI+G2GXbRfA5+6BVCxJHcnjN3Q/rjVlm5CdB+aI2uqdadGHA6XJCFdxd
         gqgCWUXPHoFfWikX98jJGDE/DLxV5UJXDHIx8DvkUlWLMsDrD5OebyirJ1GEM7YijMdv
         lT/Xrom2boQMjjaUHykYIVLkke9UJFiPzcPkarS5z2iT+zJE9SP3WgKg8Q0ICAX7SEKZ
         mzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DKhHMZUmO4T2JI4GxBQQCY43PdHMrucN4JTGGfDXF4A=;
        b=ZdXavND9ijTYW0PA0/0q3kX6RJdRuGag1nuf65uxA3MPywIKacKtnPUUnOjfo+lRE4
         iAyzCZ1GPG3tP4qAi3qQURvKQS/d4YpU0gW0+LVKZsnSF/EPuOD2UDuQX8P2k5l6HmGy
         X4knH9559r7qmLWX+mCyvl919LB+9ZJJDou6nzDO9jccK2grj37gwo8Q+xK9uCabsqkg
         y1q0yXIHPD5BBwdGQcr97+FG+2ho1t2h7KOpq6TFxXn635lU6Op0+0Dpcv8w3sVvAb+q
         4QR6ZN5SFXBMpuuaYJtm4xq9s0/cBj1zjZieL/s4wzwvP9LG0GNdDsHbQ1mVm4oQ1hr3
         rhSA==
X-Gm-Message-State: AA+aEWYE6xh1SNpfjND1fiTj5KuD7XHX7yfE8ulweI6+EMuqh+v9wHnC
        gX6mqDyOXJ6y4ySEdh0J7BhTnQ==
X-Google-Smtp-Source: AFSGD/VBweFeKfke3uTryRrU3AtmvjqVKtxOzIWXhtbP8prOB9czS9a0tZ35vjaIimeaMLPe9DOSCA==
X-Received: by 2002:a37:6749:: with SMTP id b70mr31414512qkc.41.1543352686559;
        Tue, 27 Nov 2018 13:04:46 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:4c40])
        by smtp.gmail.com with ESMTPSA id j36sm2901421qtk.15.2018.11.27.13.04.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 13:04:45 -0800 (PST)
Date:   Tue, 27 Nov 2018 16:04:44 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] blkcg: introduce common blkg association logic
Message-ID: <20181127210443.pornubsaa6vcbgih@macbook-pro-91.dhcp.thefacebook.com>
References: <20181126211946.77067-1-dennis@kernel.org>
 <20181126211946.77067-5-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126211946.77067-5-dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 04:19:37PM -0500, Dennis Zhou wrote:
> There are 3 ways blkg association can happen: association with the
> current css, with the page css (swap), or from the wbc css (writeback).
> 
> This patch handles how association is done for the first case where we
> are associating bsaed on the current css. If there is already a blkg
> associated, the css will be reused and association will be redone as the
> request_queue may have changed.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
