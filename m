Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F08FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195732083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="uK3VdRwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195732083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbeHaTwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:52:33 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36040 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbeHaTwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:52:33 -0400
Received: by mail-qt0-f194.google.com with SMTP id t5-v6so15032877qtn.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bW4HdnUXreM4ZDeViOaJVHzcCN7B4W80txKIg0Q23RQ=;
        b=uK3VdRwN8MhVYd1Nns86CO2r3GgV7tsi1u0TFyu24pZ/1o4MpqLu4Ne3KN66a/91OW
         Q47vO8uNo24yz1tI3mZpy2u7hqU2Uxr04XqsTL5NhifBpqdCaQImpEttXy5ISm2BKiKh
         B7wC1RFx6OifDBPrisbTRB604ZN7N25rfACgv1LTL3NmYCjwjNpq3yH8ho1sCCiAu2nC
         K4h4NimSyhwBvlWT42JAyEdmEwV5zwFpRYIzT1mDEeBwCjGKb7fzlVRImXhTCdeKFvna
         KJzoMRHjKeepN8ecdavYemNugPatUBN6bdez7Qlxe/pLBsUk+Va8RpAcEvAE0IxWvAoi
         rpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bW4HdnUXreM4ZDeViOaJVHzcCN7B4W80txKIg0Q23RQ=;
        b=eCLDmBu9footQ9pDn9cdDUwJ7zt6Wu3TcxbLDDM/HJ5o+jUnGvE1J4s4fHcOkdtfz0
         hk7lrz96RUV3+AmaRiobYO28CLR89/UCxVMjKgewB1AVflfm9N3FP+T9WIyj47wO9O9m
         BBlXiRAS35nmj9W9JuQThmYXHWQY5vilBV5tz3n954vvSa47bIDYiUF3K3iVo54Ii6mj
         QNrVEsE7hv+gSvd2ickwBb5dDNzTjNNn3RcBTH3uiA9aaQV6/DsTblldcqEK+IVGDStq
         gWeBBcBHX8xqh8jNtBSQH4bI8oTK85i19KdqJH9bsJOxzOtIcRhP5QflPdVgpETUC/42
         T0dA==
X-Gm-Message-State: APzg51CNLOGiMEKqMUWTjuAoBdhZiUdSJUnIh79AyeYrw+wXIMPd3ExG
        PlDrSNORS9YJso5k19MiK4sHRA==
X-Google-Smtp-Source: ANB0VdZNFrPGTcVibXqYguQt4euGkfWjqcB+sm5ED+gJ1SJq3+epqzf2MDoj//mmqm/xSJqiO2y2QA==
X-Received: by 2002:ac8:42cf:: with SMTP id g15-v6mr16465395qtm.162.1535730267788;
        Fri, 31 Aug 2018 08:44:27 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l5-v6sm5337405qte.20.2018.08.31.08.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 08:44:26 -0700 (PDT)
Date:   Fri, 31 Aug 2018 11:44:26 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] blkcg: associate a blkg for pages being evicted by
 swap
Message-ID: <20180831154425.hvh7hrz5nocs35tr@destiny>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-9-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831015356.69796-9-dennisszhou@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:53:49PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> A prior patch in this series added blkg association to bios issued by
> cgroups. There are two other paths that we want to attribute work back
> to the appropriate cgroup: swap and writeback. Here we modify the way
> swap tags bios to include the blkg. Writeback will be tackle in the next
> patch.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
