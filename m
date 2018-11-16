Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B71C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 02:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB32214F1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 02:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Tbf1FUiZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB32214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeKPMcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 07:32:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38478 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeKPMcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 07:32:18 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so2629692pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 18:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C8t9xXHX+uuxLqKyUveIg7bpIGH7rb1Q0avdDTbJaVs=;
        b=Tbf1FUiZ/1pT1tbSQH0ZT9MGwOeaNPmOEJQiFngW1fxRMyCJX77ec7kBqF4eRvzXHi
         xBhPoRJFVD03U9PfRCMMi5sZvhf3xHXjNiDwAGNyU5oeI6ajVcgd7kibXz1oUCGPiiCZ
         DWNJy+V/FP/AT6Vbgxbyd0OYuS+Xf0BgBwEng86dBuFGtiYkuS3a3f3L9Xr7fYzNr1lg
         D3irGRMdQH8AH0uwj1rnmVK3d3C+aRyrSveu1IKQ+3jJ6RmIwEL3SM2/o5cE2EkaSYkB
         ONNh47pZNm2kUax68buTya3i3irjKaXIfpTs1slBeA62wBjgu8RLWr0XkOeNxDJTsZFc
         qsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C8t9xXHX+uuxLqKyUveIg7bpIGH7rb1Q0avdDTbJaVs=;
        b=ZUnCkq49fev8I8HFg/CaILa5ReHWNuMR4cRQH1HGNu3C3YpMRQWok6M1WxCtW8kQuf
         xK9ueIP6NyAZvpu79hgHHF1gHsglt9Fhudh3138Wb3BaOGfaXG84hzcuZ7UnNwsQLV6j
         gR0n51ajutmdN74xo6ewZbfGsGX43u8phXAiUsssFpYXIQNQhy34aoe0XBZfbNgrvf2a
         p98yqeluFeTUq+R+dcOvZ8PH85bMT0szzmE8fuWKbszTX/X3V0mRxXs7xtUNNQoZ/0pU
         xH07O9rCaxNk9HTeiJZHtshKSBuGGgiOJiyz/lrOFF+hcJazomVOmjn9f9qMnRt9jwsa
         h8FA==
X-Gm-Message-State: AGRZ1gIlctNWPpBD4oTEEGU56Zsxx8OCVFqglg6IUB3dNI0omYlLcNJJ
        hUxAbxXZXpxFiJfatKpsAAfESw==
X-Google-Smtp-Source: AJdET5dOA5hhYhULp+Lvlud45Aa45LsWdZgsg4gESsXd09W/tL5yDiVdMncKnVA8fl2H/pMYzjTlUg==
X-Received: by 2002:a62:1e83:: with SMTP id e125-v6mr9021917pfe.231.1542334908368;
        Thu, 15 Nov 2018 18:21:48 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id m198sm28391420pga.10.2018.11.15.18.21.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 18:21:47 -0800 (PST)
Subject: Re: linux-next: manual merge of the block tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
References: <20181116131919.781539f7@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a16e526d-c0a0-50cf-702f-f9495c469b54@kernel.dk>
Date:   Thu, 15 Nov 2018 19:21:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181116131919.781539f7@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/18 7:19 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the block tree got a conflict in:
> 
>   block/blk.h
> 
> between commit:
> 
>   1adfc5e4136f ("block: make sure discard bio is aligned with logical block size")
> 
> from Linus' tree (precedes v4.20-rc2) and commit:
> 
>   079076b3416e ("block: remove deadline __deadline manipulation helpers")
> 
> from the block tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks Stephen, there's a few coming up. Come Sunday I'll pull in
-rc3 and resolve these. Not just for that, but also to ensure that
my -next branch has some important fixes from this series.

-- 
Jens Axboe

