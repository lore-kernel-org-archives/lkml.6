Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD6BC00319
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CAC5217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550523910;
	bh=0S5RmvtPqeOlPvpujiIlt1lkrJqxcl7eMboUeLuz6hQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hBidG1x6DhnZQODgANi4VJbCq7u8g0/oGg2ME9Ol4Npp/g/rBaO4Y6oonFkd4lmD7
	 YMOz563JS8sHa1Xw3IekR6PyPTyoszUtWVad+rRG7glq9KtQ8XVnrISU1CYcP5e3Sc
	 ZMsJKhjVO8wrzCjnYUyEsapKi9JeKl5SSnKC6D+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfBRVFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 16:05:08 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:40038 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfBRVFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 16:05:08 -0500
Received: by mail-yb1-f195.google.com with SMTP id k2so2812437ybk.7;
        Mon, 18 Feb 2019 13:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9DzCR79XKeIjL7+2ReBiux03I1IsbcYYGjv2zjhhJ2U=;
        b=IvUXzBPQJEIyKxoXbz4dX0We4ImmqwmBbZb8b00WHoEnhmrQvX86N2WSx0rP1NzXFS
         uwDuVGKTJxW0Bg0RNeRMY2lqSxHlylMUB1QW2kusIPBR/1eSRw3pLDFw0DxTiX4xKIJH
         HI39c8dzh86yRNfROF1J4MTzi+z8cRaElf9D2wcp1bxf3Ak2psiTe3TVvbaMcSCeL0xz
         0v5+CKY58TFKGjYiJixaNyF/JCodpDsL5qER8CF0AdDGaUzq7o2WyEBYDVhxhqSvThX0
         wA2HOyR7hXaqWcIJ88Uhcpnx5RhK0K7pvEyKDaPBn85ZliSQTNNAHNknlI/GapPFjD4Q
         6KrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9DzCR79XKeIjL7+2ReBiux03I1IsbcYYGjv2zjhhJ2U=;
        b=fAjXG5EPieHnFU3rj4Lxpyo+xZrUGBpAwhweIXbpCdlsECn6Yk/DHeuqCfqlXCMLeL
         Pgpw8NkuRF/APaJnw3a5iNgZufq5GYLbmEt3tpa7FcYOlHuD9Vwy1+VuVWD64uXNgNF+
         iGdH1Dsu1TToiArwa1iA0VHsQyJgty3o5WSEMt6ezAJjVcTQcQnDLBvfNaHcbonyDlDF
         Vo0KVaWtLOu63le8q4fZ0UcIAAmNp6aO14buu6VQM4fhqWKe4UUNTgwx1r4xJhGgu48P
         csdwpgFfXDM7NHo5wrcz+rDJtCcOiXEJrRf4pReI91KH6DujDQqyDUji0r5uuvwPgVPn
         Hu4A==
X-Gm-Message-State: AHQUAuawwd308SEUAbNwK99tMu4kZ8JDG/qzK22IaKPrrguSMQ53wHXk
        v3snoS5/ro8wXtN+1I68F+k=
X-Google-Smtp-Source: AHgI3IZQ85hICO8PJBHbJ2RZysx/uNUHQA80/Hg8S4A0SZHPMgNXU2TbgLlCgJHTrnqFDEdrI6avxw==
X-Received: by 2002:a25:d04b:: with SMTP id h72mr15655803ybg.152.1550523907337;
        Mon, 18 Feb 2019 13:05:07 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:2c70])
        by smtp.gmail.com with ESMTPSA id z23sm7007499ywj.36.2019.02.18.13.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 13:05:06 -0800 (PST)
Date:   Mon, 18 Feb 2019 13:05:04 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, corbet@lwn.net, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: cgroup: correct the wrong information about measure
 of memory pressure
Message-ID: <20190218210504.GT50184@devbig004.ftw2.facebook.com>
References: <1550278564-81540-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550278564-81540-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 08:56:04AM +0800, Yang Shi wrote:
> Since PSI has implemented some kind of measure of memory pressure, the
> statement about lack of such measure is not true anymore.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 7bf3f12..9a92013 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1310,8 +1310,7 @@ network to a file can use all available memory but can also operate as
>  performant with a small amount of memory.  A measure of memory
>  pressure - how much the workload is being impacted due to lack of
>  memory - is necessary to determine whether a workload needs more
> -memory; unfortunately, memory pressure monitoring mechanism isn't
> -implemented yet.
> +memory.

Maybe refer to PSI?

Thanks.

-- 
tejun
