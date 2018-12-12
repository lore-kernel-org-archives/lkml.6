Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9957C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853B520870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="gzY/SQct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853B520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeLLXAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:00:48 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51057 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbeLLXAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:00:48 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so970650iti.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 15:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8CJffH8rv1hIUja93jURiqdXIsLgd17b2S6AMZrqtXY=;
        b=gzY/SQctzRG+PpcE1lbMDxItjRpUZUUJ/CgenmjZY2qgnyt4x2nwzoh/3t/EXvI2G7
         2bPLiEZd4Sbfyrypjezlb67uFP/zQd93nahOrxzIx6qwLRXUqNPUV0V+l4edDFaM94Kb
         VxIhzqnFeticnPmPvQXFzA03Op6311HJqReGgoVC3/YMCL81nQk9YNmLR+BgGCVV4cWn
         lA4pSQfTNlXo7CWTYEE6MdUpyAG4/1tz2FhpUd4I0C49taqvS9L91wcINe1eQs5T2PMC
         HIxhryPJcF+hcuoZidkUMNWNbJwMckqY96oY9gO7Vd8moArucKBDsoyuZ2VS1DrMBfdf
         FG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8CJffH8rv1hIUja93jURiqdXIsLgd17b2S6AMZrqtXY=;
        b=UKhbMKlt8w/RUV4R+lwGClQfbw4VyUGJQNCJPENzU6CWPe8rLEezNuLybA4vZfMDj3
         OJXRVJy3Xy4g4rVg9WTXzG5C+TE5tpK2Wo9VxMnW0c+tk+hKKb49bEUG8aXFfNGI0Xox
         MGW6Q1Rpkft/U+3i9ogWPEZ2AAPClUjQMw1OUEhwXR6BeEuZoIwsTaFs9XecDqI7NP0g
         3W/npl9qmLbteRp6uI3aGZlOstD9yisz+MDMkDuzho3tHpXfRae3uVPJnl5p2KmJAcQA
         bX1D0lV9uAHT/ycN5/p0Xgu7nm6CG+h7CiXpgzL/fXaPPcjoOxtoX27vv8jvvXhWWM7u
         ywGQ==
X-Gm-Message-State: AA+aEWYexXKBL62832AxUWSc6GRJJciwi1mSj3mvK2FiSEqQkjf1+IVe
        lTw7pMZnA4/u4rYqIPYBmP4GPPdDy+ku5cciw/Rw8A==
X-Google-Smtp-Source: AFSGD/VLjcIs7T27DfkddnKElJUp18co0Ey6qKWlvabngIHdKotsX02s1Dkp35eAGuvQfffSBXb3TTHLWRxjkUYeo5Q=
X-Received: by 2002:a24:f542:: with SMTP id k63mr8389489ith.162.1544655647097;
 Wed, 12 Dec 2018 15:00:47 -0800 (PST)
MIME-Version: 1.0
References: <1544103052-28191-1-git-send-email-wesley.sheng@microchip.com>
In-Reply-To: <1544103052-28191-1-git-send-email-wesley.sheng@microchip.com>
From:   Jon Mason <jdmason@kudzu.us>
Date:   Wed, 12 Dec 2018 18:00:35 -0500
Message-ID: <CAPoiz9yN9zHXxyuwmopfSwBLGr39bQ1SJjGq_ku-w_b9V13OFQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ntb_hw_switchtec: Added support of >=4G memory windows
To:     wesley.sheng@microchip.com
Cc:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org,
        linux-ntb@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        wesleyshenggit@sina.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 1:47 AM Wesley Sheng <wesley.sheng@microchip.com> wrote:
>
> Hi, Everyone,
>
> This patch series adds support of >=4G memory windows.
>
> Current Switchtec's BAR setup registers are limited to 32bits,
> corresponding to the maximum MW (memory window) size is <4G.
> Increase the MW sizes with the addition of the BAR Setup Extension
> Register for the upper 32bits of a 64bits MW size. This increases the MW
> range to between 4K and 2^63.
>
> Additionally, we've made the following changes:
>
> * debug print 64bit aligned crosslink BAR numbers
> * Fix the array size of NT req id mapping table
>
> Tested with ntb_test.sh successfully based on NTB fixes series from
> Logan Gunthorpe <logang@deltatee.com> at
> https://github.com/sbates130272/linux-p2pmem on branch of
> ntb_multiport_fixes

So, you based your patches on a series of patches not in the
ntb/ntb-next branch?  Please don't do this.  I see nothing in these
patches which requires that series, which makes this even more
unnecessary.  Since these are fairly trivial, I'm taking them and
pushing to the ntb-next branch to give these more time to be tested
(due to not being tested on the proper branch).  I would really
appreciate you testing the ntb-next branch as a sanity check.

Thanks,
Jon

>
> Regards,
> Wesley
>
> --
>
> Changed since v1:
>   - Using upper_32_bits() and lower_32_bits() marcos makes it easier
>     to read and avoids compiler warning on 32-bit arch
>   - Reorder the patches to make the bug fixes first and add a "Fixes"
>     line to the commit messages
>
> --
> Paul Selles (2):
>   ntb_hw_switchtec: debug print 64bit aligned crosslink BAR Numbers
>   ntb_hw_switchtec: Added support of >=4G memory windows
>
> Wesley Sheng (1):
>   ntb_hw_switchtec: NT req id mapping table register entry number should
>     be 512
>
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 11 ++++++++---
>  include/linux/switchtec.h              | 10 +++++++---
>  2 files changed, 15 insertions(+), 6 deletions(-)
>
> --
> 2.7.4
>
