Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6B6C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A78720673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="V8KiOTQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A78720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbeGZIqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:46:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45654 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbeGZIqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:46:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id q5-v6so621079ljh.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 00:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+uMsDxs7AUAb2QkGVxxO9PVytlWrwNHGF8IYCOUKJJI=;
        b=V8KiOTQhVK73RBpJht7MPj7kjdza+R6RfbJOQgu39dLr23wPMLiOLOpcUeMk3WOui9
         GQpIWvYWSq+tdvoNNy5wTpDvcQq2PqcAoxKAHcitbTNNKjs3ChfPaQD1usIKWG2LvVLq
         raTC7XZwvI8+VCy5C5jUq+rOnBXGZkc7zzrYgPQ/qf042l0fajXAP7wqqqiszJ7NKqAv
         k7sYa/YhBtTfrZY6u0jywj6nenec2hXSm0Q3wZNB6vInMmlcWUtNUlymhgg/XOM54qsm
         r4QOsTAXb6kEQqe8zvSmRk/mkE1adl+3tkzDjiZYNR+dCRcy9huK3jXfuAf5qcrDt3It
         sGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+uMsDxs7AUAb2QkGVxxO9PVytlWrwNHGF8IYCOUKJJI=;
        b=sXCBvJ2/BTyfYIQcBgOkJdEpi53zNESTVHwIMJGh/RRS0V7zUrg7q/0WTg5GohFRqQ
         CfembNSXK5Rn3O1uXIu7Oc+1qgwXLi3qgPnBVGC13jPKAnXvb8RhC5h744GWQbKMpNzZ
         HJtHpkryjnoxoK7sQrNYVLxdN1YQ6dDT7rtgxf9rMj66RwbvmLcc/G4+Ko6YpYm+xDc5
         iuvYmtUieHaQUupsrS47XZUluknyoOHlycTiJU2M+jkCLN03yoLgfKRnf1M5WcaJda5f
         BrqDpn4ioZU2w5FnjNQroWJJ9hyFb/5G8QsuAJJc5CEMLbEEBl+S0T995Hz6yKMl0kXd
         DFIA==
X-Gm-Message-State: AOUpUlF/1mIXjo7IgmStOjdeGMGs5wKXGO9xBE4OHEvUVs+HnkWXT7iH
        qfn43/E/ZZ+TcTSEXvg4OFAelA==
X-Google-Smtp-Source: AAOMgpcTL24hJVllo8fqmTTaQLq1MYGyYS9IS5b8p5tjjiWOR+OJqDm5Bwi0ZbXDxgEHPI8/3FZkHA==
X-Received: by 2002:a2e:9742:: with SMTP id f2-v6mr731837ljj.5.1532590228269;
        Thu, 26 Jul 2018 00:30:28 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id x65-v6sm81362lfa.77.2018.07.26.00.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 00:30:26 -0700 (PDT)
Date:   Thu, 26 Jul 2018 00:18:47 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 3/3] ARM: samsung: Mach/soc for v4.19
Message-ID: <20180726071847.oamagjrd2mjvvqu5@localhost>
References: <20180725162340.7488-1-krzk@kernel.org>
 <20180725162340.7488-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725162340.7488-3-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 06:23:40PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> Rebased on v4.18-rc2, because at v4.18-rc1 the NFS root boot, which I use at my
> testing setup (https://krzk.eu), was broken.
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:
> 
>   Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.19
> 
> for you to fetch changes up to cd4806911cee3901bc2b5eb95603cf1958720b57:
> 
>   ARM: exynos: Clear global variable on init error path (2018-07-24 18:52:14 +0200)
> 
> ----------------------------------------------------------------
> Samsung mach/soc changes for v4.19
> 
> Minor cleanups and fixes.

Merged, thanks!


-Olof
