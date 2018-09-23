Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2A4C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98381214C1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="UWeQYkz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98381214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeIWTFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 15:05:46 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36610 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeIWTFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 15:05:46 -0400
Received: by mail-lj1-f194.google.com with SMTP id v26-v6so15871059ljj.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 06:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wvtrh2uSOkFNCRYCef9X4FfsgFKw3mLjJABZ9+kcL5o=;
        b=UWeQYkz1jmV8yTEgMpR6YIitGF+2n4M/eeYihXUH+EmO6JBHztALAqLly4zPZZYAeX
         +/b7YsBcWRNUDItFcefUFUv6xEDI2SWIq+cT12EuJ/ItypapU3x/UzNQlqYnGMTFSMf2
         XUZHnKGNH8ozhs3S7JTFoYM52PzdCj+kMhnzKGMR+IHcDultMqROmRbrh6Hwwcrb9EE8
         drScqjihM42PVDFhN4/5cx4hb/gurHRZ0SijFCUBjMXzgm66TAJeo4cTpvzeKczYgQY1
         L+yHMPOMkEX89eWC5hIWqrVQaCumLADPxmfpYfiUBxvkqXTnsLSA2k/BexoJ3nF2GiwT
         B19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wvtrh2uSOkFNCRYCef9X4FfsgFKw3mLjJABZ9+kcL5o=;
        b=lFZfByaXH5WgkTqRH9fqLMuF3TIX7/x6pIGIuAQ0dbAKxw34lcNS/c8LVqKBxmRmef
         7fEjbpEipT737tZ9i50HUwJXk5W9/86DqOxWdgp3tnHvPiQY+ispM72bA0edEWp7Z5Th
         Nn9yS76DPdCXKSMumJLz1S4IOZm7Vy13BdVN2mqhV1P3pgP6uN8qQ1xxFo6EQ3MhZYXm
         SypYXC2fa8qQHHjXnUzdx3zV7qkIP6bpHCFK5udGODq5wPhLp/DQkfDQ4gzE4sAY7OT4
         txrg1s+w57wDcSBr6bbcZ9YNVzBJtLJJREto8Szyi4ICCglsRFc1DNa31KH8sDJ+YDQa
         zkoQ==
X-Gm-Message-State: ABuFfoiHLwtogYU8ERKV4+vmK86WymdLSyGFU3CfDIzAnaqL6QSqICuZ
        1CEQkZ52/WjRfZ45jTPrKEcjLw==
X-Google-Smtp-Source: ACcGV61OayqXK4Bo9+kQ8+RST6NupvNkKePLBwKQ46rsXhqFhu1CQ1dtxBuMO9j0ozV6Cp9YllHvLA==
X-Received: by 2002:a2e:2f19:: with SMTP id v25-v6mr7637129ljv.113.1537708098525;
        Sun, 23 Sep 2018 06:08:18 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id b90-v6sm334662ljf.94.2018.09.23.06.08.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Sep 2018 06:08:16 -0700 (PDT)
Date:   Sun, 23 Sep 2018 05:37:04 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org
Subject: Re: [GIT PULL] fixes for soc/fsl drivers for v4.19
Message-ID: <20180923123704.r47aywqfhor3ma74@localhost>
References: <20180920165656.31902-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920165656.31902-1-leoyang.li@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

On Thu, Sep 20, 2018 at 11:56:56AM -0500, Li Yang wrote:
> Hi arm-soc maintainers,
> 
> Please merge the following fixes for soc/fsl drivers.
> 
> Regards,
> Leo
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-fixes-for-4.19
> 
> for you to fetch changes up to 3cb31b634052ed458922e0c8e2b4b093d7fb60b9:
> 
>   soc: fsl: qe: Fix copy/paste bug in ucc_get_tdm_sync_shift() (2018-09-17 16:01:46 -0500)
> 
> ----------------------------------------------------------------
> soc/fsl fixes for 4.19

Please spend a bit of effort on writing up the tag for all pull requests, even
fixes. For fixes in particular, just as with the patch descriptions we want the
pull request to contain some brief information to what the bug is and why the
fix is needed.

Care to give this another go with a new tag description, please?


Thanks,

Olof
