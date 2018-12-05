Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598B5C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130F620879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="qnxPjWmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130F620879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbeLEVwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:52:18 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38867 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbeLEVwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:52:18 -0500
Received: by mail-it1-f196.google.com with SMTP id h65so22686437ith.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 13:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vZ0c7m50AKXdy3+2iCqt+TcHB3zWQhj9RCuGnFIcAMU=;
        b=qnxPjWmLkzZ29odbg/nQeqMrd5XX4cC4bsnQasXy+yTnAJTslzypPR5HxQ0uhDgn/O
         cY1rBK48W5ql0bzjOx2e7z4FPSoJPJCKztfcSWUptrGvWOte/jepHpKG8pcP168n4uiK
         q7Vsv+NBiwFmzfFv83mO5eBUMn0aAskPlE4UEHQA8sS2+bhL/zCsAMSbNJAATNVDk71z
         /Mxgb//DL3IN4xgion4yxXtAH6SPM71R3vzrgedy2oVycXtr6oe+0fO6B9vLVUuLvk5/
         kk1uFVg8iLLGjdGONHOjP129osce5BEHR+o1+YKt847TWczvNPeMbI9I8tAv/arsIJ4R
         I81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vZ0c7m50AKXdy3+2iCqt+TcHB3zWQhj9RCuGnFIcAMU=;
        b=Lj8n+drcIkfnvteo+A/tfxgnuUgybIrpGwPYPvCJISVqDmoTFV55JhyXmnpzGl44zw
         fgX1T9c10uFW0Cd85ONIoZhTUG0iqFHnWsXg5LlMQCGnbAgYz/XpemZlnum9R5QL+8hw
         VAFTjUIGZbkVEghsIQJ+DFEqgEhgz6MLbef0w+dSFkYN6pDEVcrtzPjKs5Cad6FebCP+
         XnPiiVz/VJgGb+0+gPbupJk6TKK0O/RG3PGJS3jToCzHtVKs0L0jdqE9woZGgTpVnRlm
         7x3X5b3u3RpfvVDh9DthB2zt/mLZWLa/9BdDjIxM8yc/RDpUPi/bY+s1UkOEJ6VCY+YF
         qaKQ==
X-Gm-Message-State: AA+aEWataSFbIGjR1jCjKRDtIkAMjosJvGD2ETk7mIlGmX9wgjtbQ+Rj
        xg6zsjQ0PmC+xUP3XRwoUpPQ1A==
X-Google-Smtp-Source: AFSGD/W36nvjXeluXFicTbUnmovd9v49d6S+fb7ufA9Eu66Pa9bxJKIrM9FNCZaqUfxp2iuDg7NyXA==
X-Received: by 2002:a24:446:: with SMTP id 67mr14563343itb.64.1544046737816;
        Wed, 05 Dec 2018 13:52:17 -0800 (PST)
Received: from localhost ([8.46.75.5])
        by smtp.gmail.com with ESMTPSA id d3sm9172767itc.40.2018.12.05.13.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 13:52:17 -0800 (PST)
Date:   Wed, 5 Dec 2018 13:52:09 -0800
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org, tj@kernel.org,
        david@fromorbit.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com,
        jack@suse.cz
Subject: Re: [PATCH 2/4] filemap: kill page_cache_read usage in filemap_fault
Message-ID: <20181205215209.GA13938@cmpxchg.org>
References: <20181130195812.19536-1-josef@toxicpanda.com>
 <20181130195812.19536-3-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130195812.19536-3-josef@toxicpanda.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 02:58:10PM -0500, Josef Bacik wrote:
> If we do not have a page at filemap_fault time we'll do this weird
> forced page_cache_read thing to populate the page, and then drop it
> again and loop around and find it.  This makes for 2 ways we can read a
> page in filemap_fault, and it's not really needed.  Instead add a
> FGP_FOR_MMAP flag so that pagecache_get_page() will return a unlocked
> page that's in pagecache.  Then use the normal page locking and readpage
> logic already in filemap_fault.  This simplifies the no page in page
> cache case significantly.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

That's a great simplification. Looks correct to me.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
