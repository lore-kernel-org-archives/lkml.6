Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A246C07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB71F2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChqS1lVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB71F2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbeLJAnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 19:43:53 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:46272 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeLJAnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 19:43:52 -0500
Received: by mail-pl1-f181.google.com with SMTP id t13so4370757ply.13;
        Sun, 09 Dec 2018 16:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nm5C5BQ8gRZwHiZZiWpVlv7XwU1MXfKxCCQDdm1NplU=;
        b=ChqS1lVSi6OsecfpTSEACBdYSxjxFGm29USc8rrISs/xipHm/KDGIljByKApi66TwL
         hGTFP+I7gxvSjHMf2g5zae3sOsPD8QKlYPOzrz2YxpXaUQwJLS4JTjNSspsOO3hPWWb8
         IRcw/hMXaa+LNUGp1pPc+3/Yr1J8CQ+cOW6wun5C0G9AKVpvu+97BxGWObVqyBcK+wq1
         sVZZfQkJO2hoR1ictJbMQ7n7BcnowedO4WcYBwWKerfDsgmHevQp6KKk2/fu1Bocmwwt
         LxyZjZ0TGXb/XpK7LBi8UrJwz5N9W7TAfVRY4akjEjI/bS2MiNJpI2GrBjKGXZcEms5Y
         nzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nm5C5BQ8gRZwHiZZiWpVlv7XwU1MXfKxCCQDdm1NplU=;
        b=ZGVYokPMC3r7iWLtHNTu1KcA1eq4EB027U4M/ZgVmhiNLtriJqlbxrYUaLXT5SBdWw
         ZY8jhLbsE36GqzFlseZQT6q3KZdEkrz0rCa2f8mvkCvAf7Wto8P4ZmebjgvYwXf4AYlw
         5haOi3J/C0gLn7ml6JBjFYG7cbdUDq7trUKiTiVMGf0AUzrHVSrBNmGZ0KMDK8jaK/1g
         w3s1MkJwDb1gvVSePomZQx2bt56KaXP2sWTunV1LvnbPjfHC/aS7CP3bFG+kABN/mA7N
         FLFriuLweFdQjZG8uhBN2O4uhJX+BTaiPs8xoe23s4KYZftPFrPdvua3+EBULpZjQX2W
         Bu1A==
X-Gm-Message-State: AA+aEWZJU72ltXTdBcRsJ7Br1GdMA40lwrJQQC6OAQzCIAedpxsHEsYa
        psR8ZaV1K4QRFNbhGd2mVF8=
X-Google-Smtp-Source: AFSGD/WUU/XaJiQrbS9MSfKDV9Q/ig0q/Oq0dI8N0vQoB69UP0Ph7vWOYRC71MzqUBpNheqfBS4fpg==
X-Received: by 2002:a17:902:b090:: with SMTP id p16mr10191771plr.190.1544402632226;
        Sun, 09 Dec 2018 16:43:52 -0800 (PST)
Received: from mail.google.com ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id y1sm12282927pfe.9.2018.12.09.16.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 16:43:51 -0800 (PST)
Date:   Mon, 10 Dec 2018 00:43:50 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Guy Levi(SW)" <guyle@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Changbin Du <changbin.du@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: linux-next: build failure after merge of the rdma tree
Message-ID: <20181210004349.ba2ujbontjaw4pdx@mail.google.com>
References: <20181204114731.48b18bfc@canb.auug.org.au>
 <20181204015247.GR12288@mellanox.com>
 <AM0PR05MB533192C82AA04E89004251A1C7A80@AM0PR05MB5331.eurprd05.prod.outlook.com>
 <20181206095815.6e814057@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206095815.6e814057@canb.auug.org.au>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 09:58:15AM +1100, Stephen Rothwell wrote:
> Hi Guy,
> 
> On Wed, 5 Dec 2018 12:25:57 +0000 "Guy Levi(SW)" <guyle@mellanox.com> wrote:
> >
> > > 
> > > Huh. So apparently every compiler that tested this patch (0-day, mine,
> > > the submitters) optimized this call away because is_atomic_response()
> > > always returns 0: meaning mlx5_get_atomic_laddr is never callable and
> > > can be deleted entirely, including the call to mlx5_get_send_wqe.
> > > 
> > > Not sure what compiler setup will hit this, but it is clearly wrong
> > > code..  
> > 
> > Flag -o0  ?
> 
> No, but the kbuild tree contains a change that allows turning off of
> gcc's autoinlining and the CONFIG option guarding that gets turned on
> for allmodconfig builds among others.
>
Let me turn it off to pass allmodconfig build. it is a pure debug
option.

> Masahiro, should CONFIG_NO_AUTO_INLINE maybe need to be off unless
> explicitly enabled (like CONFIG_DEBUG_INFO and others)?
> 
> -- 
> Cheers,
> Stephen Rothwell



-- 
Thanks,
Changbin Du
