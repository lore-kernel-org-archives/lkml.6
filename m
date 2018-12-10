Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4663BC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 03:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F932081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 03:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JDX6hzn6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F932081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbeLJDzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 22:55:55 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38765 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbeLJDzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 22:55:55 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so4330663pgc.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 19:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5YURM+DjVIRK1vcQsaiXJgBwbGiap3d/cgnS77iIRYU=;
        b=JDX6hzn61xQWpkCJQ5I1Z8djBLDduR6YmScea/C5siJK1qP7nRBBG3BogTtvx15uXb
         nuDOXLzNSUoAbm1dHhuhmd/p2sxBgYQ8qlYNpfa17Fj9x4gOAOnTXmTyxMHxcJ2jjBkq
         US0Qidygz9+eUSuH6QndRBRku8ywnuMvu6e7oUQOIFzJzKcX1DFB5j/q1TqEM4zRrQR3
         Y/fqHxUJB8P/jAqrCypnnVk51RMYBs1ZxpzVxfRme2ul7Pn/K6oGvAlx6mjOflx4T35Z
         Yq7eiLjEqu+htismtgn41pxNqD6z6Ehz7y+UrH+4xj4ZQ/ChS0+gNlDrb0Vp9kfsjxzL
         Jj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5YURM+DjVIRK1vcQsaiXJgBwbGiap3d/cgnS77iIRYU=;
        b=as/pgfx5YGWVJU8GOhoGIRAtOzBEAXWaV1i7L5j6LUSzMzzS2Obo596+zekhCIMkoC
         TPbtwe7VhYay7q7IdNtGS6qRIFQeo3WO0cbq/ScGp4TdYz9s10wAGabPAVUTkKA5eepQ
         yRStOMt3jjppuD3UhX92I+Acywgn/bHhPDOOBxvJj6m6B3zUrQRMGM54aOp8AypZqNrr
         tDCbKMoGNbJkvVKocThJUmVVOf3tsDrHounXxY27jb0V5R0fr6ohcutT1lACLB0GQKGq
         1qJ0ZJ8Yr9vsKwVD61ZWES8Mdvi7dmlFzMynjvNv5jvhrsz3Z3pflyOYJ+dLQ0f72BTM
         Xu1g==
X-Gm-Message-State: AA+aEWblTJEGRc9vYAOXmBWCfQEeo18da10kNrJnO47x3awZB3/+tNWa
        XT3HnLoIGEbUeiAZeCATCpE7SvvYVrE=
X-Google-Smtp-Source: AFSGD/WsFSpETGBCggQAvtwTRFR02DDeF9u3/GXMwQbWsTTRiSDt7VyPh4jWAJc5zbDydi9Xn9C4kA==
X-Received: by 2002:a65:610d:: with SMTP id z13mr9666972pgu.427.1544414154257;
        Sun, 09 Dec 2018 19:55:54 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id n68sm13837082pfb.62.2018.12.09.19.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 19:55:53 -0800 (PST)
Subject: Re: linux-next: manual merge of the device-mapper tree with the block
 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181210144322.11a94d25@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1993882e-8af3-9e64-da82-195d0089d5e3@kernel.dk>
Date:   Sun, 9 Dec 2018 20:55:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210144322.11a94d25@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/18 8:43 PM, Stephen Rothwell wrote:
> Hi all,
> 
> It appears that there are a series of shared patches between the block
> and device-mapper trees that are not the same commits.  I assume that the
> block tree has been rebased, while the device mapper tree that was based
> (or includes) part of the block tree has not bee rebased (yet).

Yep that's my fault, due to a stupid mistake I had to rebase the
block tree. Didn't realize that Mike's tree was based on it. Mike,
would it be a big issue for you to rebase the dm tree?

-- 
Jens Axboe

