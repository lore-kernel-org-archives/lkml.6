Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD38C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DDF2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="lL1GiKqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfBHPvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:51:18 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39627 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfBHPvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:51:17 -0500
Received: by mail-qt1-f195.google.com with SMTP id o6so4385294qtk.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 07:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=/6VVBwxJ+1rYWw3gHcPnSjlgy74CzOJh7uWUX+nBTrk=;
        b=lL1GiKqCXX37S4y4tz0rtE5IH9TKfu6TgI1ehvA5ekFYgMRdZnbGGatBZeNfMGDWlu
         mfEYLsVXUStbS3s2S8ZO/nGKR0YJXbBBt56yiZeslf3REj1q215YrW5eqE1W2Y6NmiQ6
         qEglXH9h+BMeZbPUeZ7POpM1jOWb3L1aSWfYalVTN6WKRxLZ1c1FTmIt4cZ0JEr05zVi
         Ak2ZvX3/pI3bspJCH6NCh8Y4l9/OFA8FDPnnBXtt/PMGEr987coOl9D6GuqNNpQtZ5PG
         zuXzogglzFQF5UWG1pJfpw8cnCmZNRz/kONN3cJC8WkiOBvMnNy8zTV+QN1MEziro6ZL
         ssmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=/6VVBwxJ+1rYWw3gHcPnSjlgy74CzOJh7uWUX+nBTrk=;
        b=OzT30QkRMmdk9j3s3dtjNeZxFRJ61rCnvJoufQcOMX2BjQIFOA20hgMCq5XQgQTct8
         pMig+85f7qIAB7hm27s0OXoQdMLgXmZJfj5z8wV4UEt/NIudvVOa0xBgIP4eX1zywwK7
         IOJiKrps65doL1/QV1DW/WxeRDktzk5VHd5mL77iRYvT8TI75w6YpVCNxf2NXv+Bap46
         F3A6vxWBOADhgQfWA86czgMkCJzNVZi+hBdYJpknX22JFiL3RAsk2p3i1VJ2qVSIhXpa
         5/E6OY2ul2PCnIOdvd8Dzdckt/qejwbvVUP3/E1ncRPYLTvL9JvgFcd9XgVAwKpGChuZ
         LDKQ==
X-Gm-Message-State: AHQUAubecdckj1AHc8z104bM39Bvauf31aSBgRhds2FlnPKFKRHoQkQm
        LEQq8pnT/mowYt/7rjDueJ/EQ6i9NGI=
X-Google-Smtp-Source: AHgI3IYqt0ZeJFGMLavxKpDSeaci9yR5lbaoHqD1x9kxpCNVCQLhaM0xE0tmJW/60/Y0s3ukGV5wZA==
X-Received: by 2002:a0c:806f:: with SMTP id 102mr16728304qva.89.1549641075955;
        Fri, 08 Feb 2019 07:51:15 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 8sm3956763qtr.7.2019.02.08.07.51.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 07:51:15 -0800 (PST)
Date:   Fri, 8 Feb 2019 07:51:08 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "David S. Miller" <davem@davemloft.net>, oss-drivers@netronome.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] nfp: flower: cmsg: use struct_size() helper
Message-ID: <20190208075108.68763aca@cakuba.netronome.com>
In-Reply-To: <20190208034725.GA12043@embeddedor>
References: <20190208034725.GA12043@embeddedor>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2019 21:47:25 -0600, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     void *entry[];
> };
> 
> size = sizeof(struct foo) + count * sizeof(void *);
> instance = alloc(size, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = alloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> Notice that, in this case, variable size is not necessary, hence
> it is removed.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
