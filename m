Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EF1C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6052084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="rQw2jrcV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6052084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbeJFB3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 21:29:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46172 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbeJFB3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 21:29:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id r64-v6so5433099pfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 11:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IkZt82vpS1rScduYRnoiOlaTzLJeeVYDOsLCPujk1AE=;
        b=rQw2jrcVhGipr7k+wKlzIMWW9v1k+NuAxzR0PJqtWX86aZSJwzQ7hvOQQTSJ4odBLJ
         FfIUMyTX4wFRw4QLacMV1corWA8GV1Gjk+d/y88V8sQ3iwEMHrr/o+DsAl5pQRk+GxRO
         Q81r3BGiDwb6Up3nT9Bto0Uo4Z3fp8j+7NsYd/LQyJIJ1FG0wL/vfJuFoGP0Kq+/IZS/
         xbTG9NO+6GFzW6JUfI2Jnjua0qaKmsaZeAmigirQo8QF2xPFnD3+nOQk9CnKU+JjT4ju
         +N+bdMEE/JAnl3Q+5cz1HSFIUjmJEPUJOra7ZObB7wXRLqzJzvWX9F2Ln3gbYGWIOnfQ
         v8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IkZt82vpS1rScduYRnoiOlaTzLJeeVYDOsLCPujk1AE=;
        b=JiTgHlJ8sqFJKvDLlWl/64uO1hyDOrAf6oiq0GW5rD+f61kjNyvzuaM8fJyEdowViu
         8HjyAy4LNnLJVajk1vKXuA0+xY+tpF72ScUxN9XeJG4ixZXdsts+dZQeTGPIFUcv9iIW
         Q+2GHTsQPCObV3uDu7iFpnc7wf7vCg9Y59weLXjXl65NbmdrluawnqrnsY0vtZsM5TEs
         RqtHkVcc2bbI0+bIANn/koT3fGGEyhYw9sfGmEuuMlSfArvsR2NDEAX/VRbR0L8g+3SW
         BVbY6GP3CS+nzEBwhLiij0FRUia0FFDNf7QXecsJdK2cTWRmL8E9eEVkaOb3iiPPXjwH
         rO+g==
X-Gm-Message-State: ABuFfogjeqSfZoSUKTeY0UVJJ4aN1n4f1+wMGCRSrxL6q5qVbbkLCFEv
        F4XUmphjM4V5pIWseUCZXG3D7Q==
X-Google-Smtp-Source: ACcGV62gMLZrCrfe+nPbN5k1qdw61xEUjCxsM7JA25lpWBZIy2O6fvwBeAD64LDSi+6FIvNNQlGMPQ==
X-Received: by 2002:a63:a309:: with SMTP id s9-v6mr11273744pge.106.1538764164235;
        Fri, 05 Oct 2018 11:29:24 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::5:b418])
        by smtp.gmail.com with ESMTPSA id z22-v6sm9388572pgk.21.2018.10.05.11.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 11:29:23 -0700 (PDT)
Date:   Fri, 5 Oct 2018 11:29:22 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Huang Ying <ying.huang@intel.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 btrfs-kdave tree
Message-ID: <20181005182922.GJ25437@vader>
References: <20181005154721.4bfde639@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005154721.4bfde639@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 03:47:21PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the akpm-current tree got a conflict in:
> 
>   include/linux/swap.h
> 
> between commit:
> 
>   0f83d16b8f1f ("mm: split SWP_FILE into SWP_ACTIVATED and SWP_FS")
> 
> from the btrfs-kdave tree and commit:
> 
>   26833300651e ("mm, swap: fix race between swapoff and some swap operations")
> 
> from the akpm-current tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell

Thanks, Stephen, that looks good.

This reminds that Dave suggested that we chould route the two mm patches
in my series through Andrew's mm tree for 4.20 and get the Btrfs bits in
for 4.21. Would that make things harder for linux-next? If not, I can
resend "mm: split SWP_FILE into SWP_ACTIVATED and SWP_FS" and "mm:
export add_swap_extent()" rebased on mmotm.
