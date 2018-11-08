Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51D7C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 04:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A64120857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 04:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PWwcuPy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A64120857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbeKHNxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 08:53:22 -0500
Received: from mail-pg1-f181.google.com ([209.85.215.181]:37566 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbeKHNxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 08:53:22 -0500
Received: by mail-pg1-f181.google.com with SMTP id 80so338713pge.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 20:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c9sdaEEThzmbtF2pQuYBcmR9cG4tXFQKQitT11qU/d8=;
        b=PWwcuPy9XeWhDAnr7tVfpkXr7DmYWRdw6+LGTJ9OkGMjRHCXTNT6PAfbEpLnBisEBe
         x2iyfNVDh5jiMph2MJ0+yWhedmeq8GMZ082dFvi5LqKHMU64XIiecCTSJsoQ6BJ0JWa7
         YjA6qkKRu9wab3pPlmRgaAfxWpqnf+gqpoaXQdzU+Wfex9/RY4m6t2+hnsV45CXp8OvP
         oUpBArjNULUnhaus1ED8TqY1VF6A40bIeXXAx+cR1eEgTmVeDHgRAT4MjAcfx+0h1PWb
         JQMNfTCB8C2scc5UupBtfv/VqZrHGLZar3lSSK1jRbsuvX5Pfda/kIthF5bhXml4VuR+
         MGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c9sdaEEThzmbtF2pQuYBcmR9cG4tXFQKQitT11qU/d8=;
        b=NHtRnZbOlsCDnpz+l0Xa5Nf54yeoogYwHgUgSOB+YpToS5JEQa+uZMfLfxkdZzRaT1
         V7tNBbnr5v0WJkHaXRqsHRIN/ZnE5GL2pgPo/u7CtiliAdNX8/BjWSLtaSVtyOqcozVs
         bH9BpfBJOrZmJSEc2jK8fWqovvuPAn16BLJKX+TnKRPER86OtB7Rev8mBuqrI/MxbrXX
         X9HMUPZnuX6SpUmI3sVc7U9+zDhnaBIc03wr+uJBTaajkA+172kPQkAbGf8b0UHnX/mc
         p47v3ir74cnOcXRnbnOyLNjjpheAsNcrL7V2ZMKbuk3R8J7f3q51dJNLmB0qb5oOBDZM
         WXBA==
X-Gm-Message-State: AGRZ1gIe4l4n2BzUs+i4EkmVlh0btFNH0mFTAkA+uxmMH49zNqoGRpzM
        t1oAXsbFfuXr3c+1mVgtFIjv+A==
X-Google-Smtp-Source: AJdET5csDAhCJ/uMpIuySRAqyxhar3tlmQlxMrXAc6MogPNg/BSXBt1gXrgs3WNstWSf00+GhC7RIw==
X-Received: by 2002:a63:5357:: with SMTP id t23-v6mr2649976pgl.40.1541650789871;
        Wed, 07 Nov 2018 20:19:49 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id s2-v6sm3409115pfk.133.2018.11.07.20.19.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 20:19:48 -0800 (PST)
Subject: Re: linux-next: build warning after merge of the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        David Miller <davem@davemloft.net>
References: <20181108143109.7dcc0a3b@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b299906b-8169-cb58-a002-526126515c0e@kernel.dk>
Date:   Wed, 7 Nov 2018 21:19:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181108143109.7dcc0a3b@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/18 8:31 PM, Stephen Rothwell wrote:
> Hi Jens,
> 
> After merging the block tree, today's linux-next build (sparc64 defconfig)
> produced this warning:
> 
> /home/sfr/next/next/drivers/block/sunvdc.c: In function 'init_queue':
> /home/sfr/next/next/drivers/block/sunvdc.c:788:6: warning: unused variable 'ret' [-Wunused-variable]
>   int ret;
>       ^~~
> 
> Introduced by commit
> 
>   fa182a1fa97d ("sunvdc: convert to blk-mq")

Thanks, leftover from v2 of the conversion that switched to the
sq init queue helper. I'll fix it.

-- 
Jens Axboe

