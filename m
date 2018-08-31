Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993FAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FC52083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bHZ5ElZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09FC52083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeIAA7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:59:11 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37605 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeIAA7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:59:11 -0400
Received: by mail-it0-f67.google.com with SMTP id h20-v6so8824893itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 13:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X4uyyJnze8eQmgn7dZYeBfQiceoBSu//s7aDIvG4h+U=;
        b=bHZ5ElZZvw9mwSsdtRJKf3t4yaUTAiAzaWOPHinmtCSElcUgb9MejbLyVmzcIW8Nw0
         APcdfFcUXlB5BS5twjDhEkSh3M+c0i9Taw/FV2bQobku2M0kN5a9yrc4TTqsWd0Oac6v
         ndm0sVN/hSVuQ/ZSwnSk6SJMMoOWyx32wv44//arPDr/J6FCFMstB6y1sbs+L5bkYaML
         Tuvcyizzuh+IxIXHuSxyIXaVkLML8ZWVi9bW2zoD+5CSfsdG3EimrQVh5VWdhTVeORLg
         eGTWzNLerelUF14K2CN04kVpPJnCW4AaiC+2iMmn0T6pmkj8+CDPLmEcXNlMVfrjQTqS
         Kxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X4uyyJnze8eQmgn7dZYeBfQiceoBSu//s7aDIvG4h+U=;
        b=cQ/d2VWOAJyKa8tnTKUDBGqM88NvpHxKlAG/fBgTfNjID6NcxE+JVZm2mPYOgjZMWC
         iCfKSJ8W1b4UmI9Ju5sRqlBd1PcF8vymvNzTlVPsOfl3vxWB1hPAt0LmotUmeMXO69wW
         pJ60K7eWKX/M/Qtzt0NPGufcDFX7T1VC7Q/d4mZ+Qi2VUPlYv2Du9a7lw/fyQVRMD1pF
         Ql03vC7Im0vcUua/aUuCNKM7t/Y0+IzP1w0gP7GtHJucQBApk3YOSJn10JGvrA6Prkol
         UjVVREyrDkPBivAXj+vWwJp8JyumhOh5JPSOZk/OWzSaDiTVaSgtuyyrbWAs5r5vKgLh
         9oTA==
X-Gm-Message-State: APzg51BPktLrLAz3zjNvFL1RyB79RHI9Zh0DZkueh41kGVZ1bmMYgTSW
        2hlSa+Ej2VwsQB/1xom7myuhC611VBo=
X-Google-Smtp-Source: ANB0VdagLaCPXK9qQxcidbXOMgzfml0jAU+rEIiFquz+p13Jh0Za0xXnuu+LxXQz3uQCsF1khCr1XQ==
X-Received: by 2002:a02:3b55:: with SMTP id i21-v6mr13810520jaf.118.1535748598011;
        Fri, 31 Aug 2018 13:49:58 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.22.static.utbb.net. [107.191.0.22])
        by smtp.gmail.com with ESMTPSA id k142-v6sm2695525itb.0.2018.08.31.13.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 13:49:56 -0700 (PDT)
Subject: Re: [PATCH 0/3] fix blkcg offlining and destruction
To:     Dennis Zhou <dennisszhou@gmail.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180831202244.21678-1-dennisszhou@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7b5ec635-c251-7ac3-bebd-2cfd687ffed6@kernel.dk>
Date:   Fri, 31 Aug 2018 14:49:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180831202244.21678-1-dennisszhou@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/18 2:22 PM, Dennis Zhou wrote:
> Hi everyone,
> 
> This is a split of an earlier series I sent out [1] containing the first
> 3 patches with fixes from feedback. This series tackles the first
> problem where blkcgs were not being destroyed.
> 
> There is a regression in blkcg destruction where references weren't
> properly put causing blkcgs to never be destroyed. Previously, blkgs
> were destroyed during offlining of the blkcg. This puts back the blkcg
> reference a blkg holds allowing blkcg ref to reach zero. Then,
> blkcg_css_free() is called as part of the final cleanup.
> 
> To address the problem, 0001 reverts the broken commit, 0002 delays
> blkg destruction until writeback has finished, and 0003 closes the
> window on a race condition between a css migration and dying, and
> blkg association. This should fix the issue where blkg_get() was getting
> called when a blkcg had already begun exiting. If a bio finds itself
> here, it will just fall back to root. Oddly enough at one point,
> blk-throttle was using policy data from and associating with potentially
> different blkgs, thus how this was exposed.
> 
> [1] https://lore.kernel.org/lkml/20180831015356.69796-1-dennisszhou@gmail.com/T
> 
> This patchset contains the following 3 patches:
>   0001-Revert-blk-throttle-fix-race-between-blkcg_bio_issue.patch
>   0002-blkcg-delay-blkg-destruction-until-after-writeback-h.patch
>   0003-blkcg-use-tryget-logic-when-associating-a-blkg-with-.patch
> 
> 0001 reverts the broken commit.
> 0002 delays blkg destruction until after writeback.
> 0003 fixes a race condition for ongoing IO and blkcg destruction.

Applied for 4.19, thanks Dennis.

-- 
Jens Axboe

