Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D842C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0EC20645
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DJwH7ChO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfBVWv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:51:57 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52367 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfBVWv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:51:57 -0500
Received: by mail-it1-f194.google.com with SMTP id r11so5355789itc.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 14:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sVlqVAaj1FsAYiReXT+Bmz0kD8mvjepdGP7QYyAdkS8=;
        b=DJwH7ChOwYn/9GEi3JpM2GQhYeVyxGkFQaioQzCmeAArPcK+je6ipUsDmXVlttqMBM
         UC36qLybEZZZ7pH/cTKjD/F+V3STXoWwC7U3NpGi/q1z/VudJqPFtx6Yxm5vJ7631aoD
         TA1DoWUIoRaGgy+5NMpJO39ba7tNNo5WvJwWn/P7EE9yDk1qOkDc47gm8tOlis8n4EoQ
         dYNzspooHOQ0b/GDOq+g5fwvBf9jcVqMtjZ4K6x/hHXp3TE6WWTYRcWYRXBOWGmeGmCi
         gfjLPdX6q6/h+rw4rX4Km6Jnr24Am8iw0aUQauCFSKORL5zVhRFoMTEhpMEhirvNHM4v
         SNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sVlqVAaj1FsAYiReXT+Bmz0kD8mvjepdGP7QYyAdkS8=;
        b=CZzsc0IF6eD9Ao/5g/u5urNcMbuW593nAB5hFhlxeQTpX7e64RCIVHLpecbMkP5FZ5
         3P279I30IJntDPyBtEUZW8xtKVMqitBF+b2UVDAjPLwL4sQ8oFwK7tVk/6/ICBvMevTf
         xV8Qt5u9vt/jluBHvx9I0lPvvVVKVsE3UrVpq9jMt9CqN7WfzsLpxPur6DHZe5Caq/31
         ticoGqJhLjkf8GF+GlqS5fvvtNbUf+FrSP+BfU3woDZ8bKVL5adhyP2HQzxrhvXH7AhB
         G0hduUO1Tyu22MYLM1tFKHKYLbM4knKzifrXVO7jlSmWBcEhxsNlTYDhM4lbU1pdldPt
         CcwQ==
X-Gm-Message-State: AHQUAuYENF0+W2cc3ycTf4xdDWZi4GnjI/iBHx1K4mweKWPJhgzVRWOn
        DC7hEVVPqJzcjn2WJwSbzG6XlQ==
X-Google-Smtp-Source: AHgI3IYxfZmF3F7klAPpMstXhZJ0M8GWKq0fshn7WJvqpm7/wLCttP2ka/FArMHVKlTT9mdwqLpl/A==
X-Received: by 2002:a02:8899:: with SMTP id n25mr3947541jaj.7.1550875916548;
        Fri, 22 Feb 2019 14:51:56 -0800 (PST)
Received: from [172.19.131.32] ([8.46.76.24])
        by smtp.gmail.com with ESMTPSA id m186sm1310234ita.2.2019.02.22.14.51.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 14:51:55 -0800 (PST)
Subject: Re: [PATCH v3 0/2] loop: fix two issues introduced by prior commit
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jack@suse.cz
References: <1550844620-6550-1-git-send-email-dongli.zhang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4ffc6fe4-5baf-a502-6042-d4f5033c4cc7@kernel.dk>
Date:   Fri, 22 Feb 2019 15:51:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550844620-6550-1-git-send-email-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/19 7:10 AM, Dongli Zhang wrote:
> This patch set fix two issues introduced by prior commit.
> 
> 
> [PATCH v3 1/2] loop: do not print warn message if partition scan is successful
> [PATCH v3 1/2] fixes d57f3374ba48 ("loop: Move special partition reread
> handling in loop_clr_fd()") to not always print warn message even when
> partition scan is successful.
> 
> 
> [PATCH v3 2/2] loop: set GENHD_FL_NO_PART_SCAN after blkdev_reread_part()
> [PATCH v3 2/2] fixes 0da03cab87e6 ("loop: Fix deadlock when calling
> blkdev_reread_part()") to not set GENHD_FL_NO_PART_SCAN before partition
> scan when detaching loop device from the file.
> 
> Changed since v1:
>   * move the setting of lo->lo_state to Lo_unbound after partscan has finished as well
>     (suggested by Jan Kara)
> 
> Changed since v2:
>   * Put the code inline in __loop_clr_fd() but not introduce new function
>     (suggested by Jan Kara)

Applied, thanks.

-- 
Jens Axboe

