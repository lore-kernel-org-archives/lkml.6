Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11E7C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 16:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EAA5208D9
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 16:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="XG8P9Y3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EAA5208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754239AbeGHQNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 12:13:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43694 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753594AbeGHQNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 12:13:38 -0400
Received: by mail-lj1-f194.google.com with SMTP id r13-v6so12323865ljg.10
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 09:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CWj9WQOC3TkCavyTc8kXshtEkej+gMdgl7Aovtobg5Y=;
        b=XG8P9Y3MGCqyqcNko4Gg+WuJ3+Gkl3mT+w2BvHG1dAECN4EznwkzxIn9pMaHgEui68
         Ojy0qsbHyq7RpC1r7/fCAKXlKI8+B/FNoPoZkZSArprj920Zfd5lO1gz5qDytl3Zbmfn
         CRM7hEVGmozI48yftZ5kYapxW3q0pGf0iCLzWGsq4/bloZkATNOKSYrD9NOB3TNSVEgL
         zDt4KhJEc5rmSO9b3qNlnBnU5gctYsqa/ojN/Y9fUF6zBFtJGTNjUE+8jJ4GMVP3eceG
         l7VvEZv//MYdqiDNak9/UA/08Xim6uOizF1fR/1zv9Fuo5DeWBKsvtEGzHIlpKZjbXGX
         RjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CWj9WQOC3TkCavyTc8kXshtEkej+gMdgl7Aovtobg5Y=;
        b=TOhACzEPkJ7e+/pKmtr55q5eK3vL+wmRh3CyaU9qbpYA0+bo3IwUOgOjqRMInyKXgb
         WeQsVP3TkiRQl+E+6DDaw1K+NelMZh7mY7a5+hnoqvi3xpFPTxlGX2f83p19tRQ6yjoM
         8Q+9NfXt7VnZv/Sk538cDerL+1NOl0YuPmVZqp1j56BNvA6NB+1/1rF8WiheM2p7Ri8N
         fkGtsNGLprQ4AagWlNO8kKZztKTdnFOhYqiZ8fdA0iwXjlnbuKGp7RuMIHoQuy/zWqrD
         7OzBvSBokLRMIOHuBi5Tt2KvX+j6fo7zlW3XCOVAsAtMritjxY7N9YJHQxBnVoXos0vb
         7law==
X-Gm-Message-State: APt69E081p7l8gvra0XB30TQuhNyGm6VT9wp9U4rMkhNnq0uFWI5CttR
        8ExoT9qWYzBDELyYGuA+UNrXMg==
X-Google-Smtp-Source: AAOMgpckvFlaz0/h/IgPzS8AkjfcKN/xxCvIbkNPxmkoR46dxFDGOJi86KaT7MAfFJeQKVFjMVyiWA==
X-Received: by 2002:a2e:8950:: with SMTP id b16-v6mr10578419ljk.111.1531066417413;
        Sun, 08 Jul 2018 09:13:37 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id v136-v6sm3488206lfa.10.2018.07.08.09.13.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 09:13:35 -0700 (PDT)
Date:   Sun, 8 Jul 2018 09:10:15 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        khilman@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 1/3] ARM: Keystone DTS update for v4.19
Message-ID: <20180708161015.ddjiok77sk6jzgbl@localhost>
References: <1530912342-4641-1-git-send-email-santosh.shilimkar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530912342-4641-1-git-send-email-santosh.shilimkar@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 02:25:40PM -0700, Santosh Shilimkar wrote:
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_dts_for_4.19
> 
> for you to fetch changes up to f7e8a182a41e791cca3d7a9e25adddf2908bddde:
> 
>   ARM: dts: keystone-k2g-evm: Use sdhci-omap programming model (2018-06-29 15:57:27 -0700)

Merged, thanks.


-Olof
