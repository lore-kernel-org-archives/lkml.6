Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970FFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BAF208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TRBs2p1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38BAF208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeH0VAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 17:00:33 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:44160 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeH0VAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 17:00:32 -0400
Received: by mail-io0-f194.google.com with SMTP id 75-v6so13403343iou.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 10:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=r7uh6gXRz9COXdvsDGkITIzPj90qCtDdzdEdbFIGVyo=;
        b=TRBs2p1fELvgw9OO4k3Z9YvBsP/lxbn/tNAVTbGqVk3fDH3cd/lRrlSDgNVVs7ExLK
         cuGfovewDHSVuAM9jEOD9kYvj6sJaqALt3em2OcMCMy0v7sEa1EEEMhH4Arq0dZ4DXuJ
         79V0YOm5ERHFkx4GiTH9fdyt8JP1y70zH09E/wAX++YbFBQ8lS0LWxconLxUE+PIQnF6
         no6a9rs32KTm4BSudn4W31SoF2t2GeW4MeujW0IR9C2Tbxo1Lco/ggRB9ZGq4ZyL/7Wq
         vAqNWI+7RVIHPwHEXOXZ8P1wKMLVizpl/XNMmyQ8AexLBwBarAF0UYGU4MmWpFFaOlRI
         xEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r7uh6gXRz9COXdvsDGkITIzPj90qCtDdzdEdbFIGVyo=;
        b=A3QFR0ShnXQWqDz5TfCELbiWIRaeb7lg7yTHbuiLmdfLpxKxQ9mH15lwwniIRYRkso
         8w6dxC5kkyh7wXksmi2ZrOOkFMurmcV1C3JyOLXB9P643MFLEiwzLcYSvVSr4CLwmRSf
         NDo+pbvTfOldlbGuerbe0S49VZHi/5v862ZFKPfE7540dCAkLt+eRR2xsNwu235ig4XZ
         JAC108r6UKA8TUApyxDxw95/v5PY05pShA/ECVI1y5b3b6mCJSNabOOdaxU1uJDVZGTf
         hX3WgCSyXIqD3Xrc8ofvj1uq78U3dz70+iNi2UdVttgvxXgaQkyVCOfLdiz+OOevVv18
         +RpA==
X-Gm-Message-State: APzg51Bt8NGZFmQubCYKdTfmH1Yrq2Rjkd/grzwUvS97h0MfE6WidmtH
        4NzjVYJAVLbBVTL9R4SQ2P+Izg==
X-Google-Smtp-Source: ANB0VdYLcpj49+p45W6WmjzvD43z8pNfS8JnD+HWh6WPhodbGehY+FTYuTW1G7bwoDWDIa54Ql/CgQ==
X-Received: by 2002:a5e:9745:: with SMTP id h5-v6mr10838043ioq.257.1535389985345;
        Mon, 27 Aug 2018 10:13:05 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id a79-v6sm4262066itc.33.2018.08.27.10.13.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 10:13:03 -0700 (PDT)
Subject: Re: [GIT PULL] (xen) stable/for-jens-4.19 for 4.19..
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, jgross@suse.com,
        roger.pau@citrix.com, xen-devel@lists.xensource.com
References: <20180827161949.GG29187@char.us.oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a54a78c4-14e5-140f-e18d-a23bebd4726d@kernel.dk>
Date:   Mon, 27 Aug 2018 11:13:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180827161949.GG29187@char.us.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/18 10:19 AM, Konrad Rzeszutek Wilk wrote:
> Hey Jens,
> 
> Would you be OK pulling the following branch:
>  git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.git stable/for-jens-4.19
> 
> which has a fix for flushing out persistent pages at a deterministic rate.
> 
> Thanks to the L1TF I did not manage to send this email until today - but
> hopefully it won't be an issue to push it to Linus after -rc1?
> 
> It is based on your 'b86d865cb1ca (for-4.19/block) blkcg: Make blkg_root_lookup()
> work for queues in bypass mode' branch.

Pulled, thanks.

-- 
Jens Axboe

