Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE60C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF48521708
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iThxH+H9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF48521708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbeI1BPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:15:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42632 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeI1BPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:15:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id i4-v6so1997903pgq.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 11:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SafovBnitVgpsbcAqAJ3MN6jLcHpsvAFSc8k4TjohLE=;
        b=iThxH+H9h1IFaJiHqZ3OT91HPsAyA5cC1dow+31HL4VhqfT28heLbGgIDN1UrMvmVh
         4bSRF/yNPuH0P2OSZ8Gdm4EtZ9FcjitR+HGnHNDRXfXFV4WHRvBzUsTBsNRDR7vpzmoi
         Cvx3z9EaobsPaq1W9yw66ZXu8isYLNg3sQuix8zsF9p5ivXvIQupsvDrIVEATY2cJx5A
         MYf9l6hMx0UGB9T9guoSQw0DdrrkREMwS6XVJu0hJmp8rT6VYFRSrGpj7kYOyU4gNy3O
         UtHycbcH/C3UI68WhYdHVYaALgEIu6XMly1mz+h0+eJWcOzryKIWRgGeSZ+lm9ALByoz
         tA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SafovBnitVgpsbcAqAJ3MN6jLcHpsvAFSc8k4TjohLE=;
        b=W5sGPYPQbV4GOCTbS4ivTDk+Z6hb8bi7AoUfjI48RbG2cymKpkon3WYrY52kx2nswf
         8lfoQTvelNb0HaZNjUJe5rw1HcxpuqbY5GBa5MCLPj3gzH/naU6+B6csgywdieYPxbC/
         zhcWp+Nis8zI/ua8/vcQjFNTsOsptsMtQIniGv4yVVEFsfQUxZl+/h8wAkscildwqkxs
         MMTBAAABBW8MTgVc1cmlzKQDetDOoMkG1vZQn9RQaWdBKqfaYJe5s0KwgVPAdE/+6Rj0
         PFQuLRhevDwsa1vLB8tBK7ZOCUSNmNm0Q3OHPcbKMyaXDJbX/FXVoOcorhC5wb5a+ySX
         vs2g==
X-Gm-Message-State: ABuFfogDEIOuHcJhZ6FlbcUH+xMDdGTQXILD7CKYYtSyuydqOZLZSim1
        S5EdMhlXAwZJE1C9kkNOcXjr51JN6PE=
X-Google-Smtp-Source: ACcGV62n0L8eLuscp5IfYtRkx8M3dPQz7L6tX5Na2HxmQtsHitgpFL6/sv8LEBwn81+69z1HfQm8Xg==
X-Received: by 2002:a17:902:2f84:: with SMTP id t4-v6mr12535362plb.87.1538074563229;
        Thu, 27 Sep 2018 11:56:03 -0700 (PDT)
Received: from ?IPv6:2620:10d:c081:1132::1008? ([2620:10d:c090:180::1:3bbb])
        by smtp.gmail.com with ESMTPSA id r64-v6sm6628285pfk.157.2018.09.27.11.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 11:56:01 -0700 (PDT)
Subject: Re: [Xen-devel] [PATCH] xen/blkfront: When purging persistent grants,
 keep them in the buffer
To:     Sander Eikelenboom <linux@eikelenboom.it>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        konrad.wilk@oracle.com, roger.pau@citrix.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20180922195549.27953-1-boris.ostrovsky@oracle.com>
 <28aa9249-7406-21c6-f509-65411828e2d7@suse.com>
 <5bd1a695-50c6-e79f-38dd-c980fc2138ad@kernel.dk>
 <00030538-e1ce-28ad-3548-8e3b07083b05@eikelenboom.it>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b181cc24-16fc-ac94-24f8-1955efa6565d@kernel.dk>
Date:   Thu, 27 Sep 2018 12:56:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <00030538-e1ce-28ad-3548-8e3b07083b05@eikelenboom.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/18 12:52 PM, Sander Eikelenboom wrote:
> On 27/09/18 16:26, Jens Axboe wrote:
>> On 9/27/18 1:12 AM, Juergen Gross wrote:
>>> On 22/09/18 21:55, Boris Ostrovsky wrote:
>>>> Commit a46b53672b2c ("xen/blkfront: cleanup stale persistent grants")
>>>> added support for purging persistent grants when they are not in use. As
>>>> part of the purge, the grants were removed from the grant buffer, This
>>>> eventually causes the buffer to become empty, with BUG_ON triggered in
>>>> get_free_grant(). This can be observed even on an idle system, within
>>>> 20-30 minutes.
>>>>
>>>> We should keep the grants in the buffer when purging, and only free the
>>>> grant ref.
>>>>
>>>> Fixes: a46b53672b2c ("xen/blkfront: cleanup stale persistent grants")
>>>> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>>
>>> Reviewed-by: Juergen Gross <jgross@suse.com>
>>
>> Since Konrad is out, I'm going to queue this up for 4.19.
>>
> 
> Hi Boris/Juergen.
> 
> Last week i tested a linux-4.19-rc4 kernel with xen-next and this patch from Boris pulled on top. 
> Unfortunately it made a VM hang (probably because it's rootFS is shuffled from under it's feet 
> and it gave these in dom0 dmesg:
> 
> [ 9251.696090] xen-blkback: requesting a grant already in use
> [ 9251.705861] xen-blkback: trying to add a gref that's already in the tree
> [ 9251.715781] xen-blkback: requesting a grant already in use
> [ 9251.725756] xen-blkback: trying to add a gref that's already in the tree
> [ 9251.735698] xen-blkback: requesting a grant already in use
> [ 9251.745573] xen-blkback: trying to add a gref that's already in the tree
> 
> The VM was a HVM with 4 vcpu's and 2 phy disks:
> xen-blkback: backend/vbd/14/768: using 4 queues, protocol 1 (x86_64-abi) persistent grants
> xen-blkback: backend/vbd/14/832: using 4 queues, protocol 1 (x86_64-abi) persistent grants
> 
> 
> Currently i have been running 4.19-rc5 with xen-next on top and commit
> a46b53672b2c reverted, for a couple of days. That seems to run stable
> for me (since it's a small box so i'm not hit by what a46b53672b2c
> tried to fix.
> 
> If you can come up with a debug patch i can give that a spin tomorrow
> evening or in the weekend, so we are hopefully still in time for the
> 4.19 release.

At this late in the game, might make more sense to simply revert the
buggy commit.  Especially since what is currently out there doesn't fix
the issue for you.

-- 
Jens Axboe

