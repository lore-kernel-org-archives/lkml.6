Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD454C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D9C20645
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D9C20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeHaOc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:32:58 -0400
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:49299 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727363AbeHaOc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:32:58 -0400
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
        by smtp2.it.da.ut.ee (Postfix) with ESMTP id 17DA290028;
        Fri, 31 Aug 2018 13:26:07 +0300 (EEST)
Received: by math.ut.ee (Postfix, from userid 1014)
        id 0252A220A62; Fri, 31 Aug 2018 13:26:05 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by math.ut.ee (Postfix) with ESMTP id 0B1842204AF;
        Fri, 31 Aug 2018 13:26:05 +0300 (EEST)
Date:   Fri, 31 Aug 2018 13:26:04 +0300 (EEST)
From:   Meelis Roos <mroos@linux.ee>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
cc:     linux-kbuild@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] kconfig: do not require pkg-config on make
 {menu,n}config
In-Reply-To: <1535708095-15847-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <alpine.LRH.2.21.1808311325260.31140@math.ut.ee>
References: <1535708095-15847-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Meelis Roos reported a {menu,n}config regression:
> 
>  "I have libncurses devel package installed in the default system
>   location (as do 99%+ on actual developers probably) and in this
>   case, pkg-config is useless.  pkg-config is needed only when
>   libraries and headers are installed in non-default locations but
>   it is bad to require installation of pkg-config on all the machines
>   where make menuconfig would be possibly run."
> 
> For {menu,n}config, do not use pkg-config if it is not installed.
> For {g,x}config, keep checking pkg-config since we really rely on it
> for finding the installation paths of the required packages.
> 
> Fixes: 4ab3b80159d4 ("kconfig: check for pkg-config on make {menu,n,g,x}config")
> Reported-by: Meelis Roos <mroos@linux.ee>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Tested-by: Meelis Roos <mroos@linux.ee>

-- 
Meelis Roos (mroos@linux.ee)
