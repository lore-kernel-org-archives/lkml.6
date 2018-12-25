Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035BBC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 08:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B279921773
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 08:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="XqEvdOzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbeLYIGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 03:06:17 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43698 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeLYIGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 03:06:16 -0500
Received: by mail-lj1-f193.google.com with SMTP id q2-v6so11698375lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 00:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=apGgC/c4ytMUAHmzhLsFZ5LXi2BH/2rbt146q2vlWI4=;
        b=XqEvdOzUKB8BzVO5XEV7lFh0/PpehUzo6rxZvWoRyCtYdpO2uPgVHnf08peEnoxWBP
         ymnwIY+3Am0H3FI7EsFatx4LbaEXNknBkf9qqgmpzm6zQhHLYIgnQuBkGA/C5ib+lPwK
         Zvoinykc7FQgv3yPZMza4yRKPlI1SWBQBoWQeB7L8o5s2xHXoUMnfPovywQNoTvNszx+
         St9OGPL6lGvIVB05qn6vJYGIBuqA2URAXujKjSTvF2rS4KJiSfiYp9BWJPlU+xtB0VzC
         QfbL6MEFPixSYBmAoOlfWjgJtEpKZKmC2yVZSx8Gw7nK2UvHxkDzAT6gYFb0PDjSa/ef
         XlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=apGgC/c4ytMUAHmzhLsFZ5LXi2BH/2rbt146q2vlWI4=;
        b=TA6zW4hIA0u0de9kryq9F00ZhyDaXQJGb/yMaACEXAj/VKxaZRMrRRLQWCYEB+UVDb
         dIjrdqcrwLo3HWP4Y3Gx4rAYwFpF/sDi8DIfRJOUzLB+s57KRo3CJf3Hpy3A7cIP19rd
         DxGfV536bcsOD1+8ufMtQtmaI5tiNxtGrsAVyydodmui3mTUEvXVITEB+8R5HeolBQAZ
         wy1HfgIudzeq7vb3rJyfJQw1nRbQSjldVPyYi7AfkWBnxNuscwd0MVGY0HudeMmXO7dC
         xITtX5hwXrmVN0gdzUxqCTCi8k1iS4S/TnU+cm+25C+opbxfjmODKS9tmNNkrUyXz5DQ
         6aUA==
X-Gm-Message-State: AJcUukc9VDVOBUMcCHeIvhB3pSmLdeI3MuKui5GQErOgb82jAzGF9MtU
        KQu+v2MkjnGUMi1uWr37k6E6E4TGvug=
X-Google-Smtp-Source: ALg8bN5ZkkQaIpXfpr/AVqbkK17JClsZRN/go1RaN2+NgtckoLUYQG0P19atZV2C9l0QnMwq74OFeA==
X-Received: by 2002:a2e:45d:: with SMTP id 90-v6mr8997694lje.110.1545725174315;
        Tue, 25 Dec 2018 00:06:14 -0800 (PST)
Received: from [192.168.0.199] ([31.173.83.170])
        by smtp.gmail.com with ESMTPSA id q11sm6588140lfc.92.2018.12.25.00.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Dec 2018 00:06:13 -0800 (PST)
Subject: Re: [PATCH][V2] drivers/net: appletalk/cops: remove redundant if
 statement and mask
To:     Colin King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181224194146.11511-1-colin.king@canonical.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <322fb722-cf17-896a-cbf4-27ac796d0c7a@cogentembedded.com>
Date:   Tue, 25 Dec 2018 11:06:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181224194146.11511-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.12.2018 22:41, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> The two different assignments for pkt_len are actually the same and
> so the if statement is redundant and can be removed.  Masking a u8
> return value from inb() with 0xFF is also redundant and can also be
> emoved.

    Removed. :-)

> Similarly, the two different outb calls are identical as the mask
> of 0xff on the second outb is redundant since a u8 is being written,
> so the if statement is also redundant and can be also removed.
> 
> Detected by CoverityScan, CID#1475639 ("Identical code for different
> branches")
> 
> ---
> 
> V2: Remove the if statement for the outb calls, thanks to David
> Miller for spotting this.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
[...]

MBR, Sergei
