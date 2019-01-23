Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67847C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D5021850
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U6uLLelp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfAWOva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:51:30 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39540 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfAWOva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:51:30 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so1295112pld.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 06:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P/u6JqxEgKGOJa5wDES1Qh1nH3hnD1ueAoQ489nzfbE=;
        b=U6uLLelphXA/aoofqSfcqThsvHjXkYV2QP1mOD9QaN3GUoi1NNPlPMVx5iScHTpj/z
         G6G5ORe/LeLUCMwkrWTYMDqaPnh8b3QKJT0Rv7D/F2wINUdh8R6Yji+Ui4hC5zSB3+i0
         XZQf5bfI880rHc3EeGiyfvh9zX3zd04eUHki4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P/u6JqxEgKGOJa5wDES1Qh1nH3hnD1ueAoQ489nzfbE=;
        b=Mm6dVscP22fgGI9oRcVdMvBJLxD3eZKFHKcZFJ0nm0wWNDUFAf+3WByCOKqu7wO/6h
         cmQwMr/PgjBbAK57EPWlsisV/WgWzA/4v1yZXMtRXvNx7g6lv/HhpipLC6Wl+vU49DSa
         MClnbYQNV37D7qI3dX0bUNAyZKnLRAoHxeETnGRRHdC5pebQQiAaMOmHGLTUIbRxjq8g
         fsEAV9mkfrQBATHAo1CXfn+ejrbNIkl9IEHGy7jYAlldNUL7qdrPx9LUuJcpDIXSrVzJ
         3I3d4rpSGWEL489UBwVlcJrDVrux3G4jfDvO8B3npau0nbrhCc2724F9dG8Vklrnhz1m
         0CNQ==
X-Gm-Message-State: AJcUukdCCHV8FA/bWN9GxL8BYr3WM4TMexQBoH7H85tgfxSzAf8rzjOs
        r10H5eqNjo3+FDKqc5NMJpyruQ==
X-Google-Smtp-Source: ALg8bN5xaKrzgSf1da0DM+OwcMEIG1GdvXlj8s4EG45nfMlg4M6G2rgjuqfKNPed6AfS+nu6kt0Djg==
X-Received: by 2002:a17:902:f091:: with SMTP id go17mr2510534plb.235.1548255089278;
        Wed, 23 Jan 2019 06:51:29 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id s37sm23619209pgm.19.2019.01.23.06.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:51:28 -0800 (PST)
Date:   Wed, 23 Jan 2019 20:21:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the opp tree
Message-ID: <20190123145126.6nttyqr5obe7ljwl@vireshk-i7>
References: <20190124014410.5f932c52@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124014410.5f932c52@canb.auug.org.au>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-01-19, 01:44, Stephen Rothwell wrote:
> Hi Viresh,
> 
> Commit
> 
>   9389d5c08571 ("opp: no need to check return value of debugfs_create functions")
> 
> is missing a Signed-off-by from its committer.

Fixed, thanks. My regular script wasn't working while applying the
patch and had to apply by hand and forgot my sign-off :(

-- 
viresh
