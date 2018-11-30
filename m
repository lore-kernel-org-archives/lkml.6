Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32874C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E543B20660
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="fgA9Mxzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E543B20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbeLALIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:08:18 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:37992 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLALIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 06:08:15 -0500
Received: by mail-lf1-f46.google.com with SMTP id p86so5325626lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 15:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SRUg4teIsAzKhA2GzqFrwwTPvHJ/4TlCsX9XzJBGB40=;
        b=fgA9MxznYKgmasQJl87t7RiJZ8uA8Bpzi/fBpMMc2I56uFQ01Rz04hcM6KARW6oqLz
         mosUbgfcOd98Fx4IeXcybSmAqXd3Y07+uIZ1okmSBKRBf1E5vu+7KIxLNmhzUC6gMMnZ
         sscsQ5lvsKZR/IgJnSKYQrGMFd2yxFOmZpWJdekDi+LXYPQK7Y5BbD4VEn6k62xjOiI9
         dUG/vdaIVKl3yQkvzGPNkHAaDvz6YDtBb4uiZQ3PPjejncyrGAyZDjU3oEj/EviTgffz
         9vdM2h2QoCvtCw+XYQ/9lE0ZlUW+k0AWGPrqEnq6OLeAJR3PBDr2gXD7enQ2VqWCvUC8
         4Mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SRUg4teIsAzKhA2GzqFrwwTPvHJ/4TlCsX9XzJBGB40=;
        b=hNE917UldEJeU1HJFSjRSb2NsVXLwYOSY0Gl/hWR0et0Ci5V7a7RUhPXTqsHKryoWU
         NPBkwC+WBqu1Z5hxVJ23o9I47Ehc4+4CU8H++iGLRAdG6eYRlO5pGwzjj2jdnnB6+Qn8
         0E4SuTXJpefvMEP1gkoGdb6K5BgANEQ8wJhtPg9n4Hqj5/nW8E6saglEtXS8bp2XdmyX
         torhVY1xSdqbhmJuKHDou0jqnRjOkcfnwvjx2H9LCJjVSu7rrueMsNrgpjTF3GFf1zcQ
         nymcY0E1+0VEMfxhv2wqFh5IIdzq10bNNEeaxQ5AmLYZNEsgfFnFJpeholAPtMpfpCnL
         auVA==
X-Gm-Message-State: AA+aEWbb5xkh5PRAhpnP+fvS0mAtRijhkzQls3+p60HO9Eh0Zlu6yKu6
        7qQyhGrwu/HCaTwBlNn+AmWd6Q==
X-Google-Smtp-Source: AFSGD/Xagp7p1T7PVDYOyorH8s+A7bwy54Qhe/6JVG/PfxPW1bhEpnt7GQa3ncMymx1m/iL+HPSrGA==
X-Received: by 2002:a19:2106:: with SMTP id h6mr4603498lfh.29.1543622231008;
        Fri, 30 Nov 2018 15:57:11 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id n16sm1034940lfl.35.2018.11.30.15.57.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 15:57:09 -0800 (PST)
Date:   Fri, 30 Nov 2018 15:38:45 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: multi_v7_defconfig: enable CONFIG_UNIPHIER_MDMAC
Message-ID: <20181130233845.ynd6dwf45jdh6hbr@localhost>
References: <1543374243-29475-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543374243-29475-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 12:04:03PM +0900, Masahiro Yamada wrote:
> Enable the UniPhier MIO DMAC driver. This is used as the DMA engine
> for accelerating the SD/eMMC controller drivers.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> The insertion context was decided by savedefconfig on next-20181127.

If we apply it now, there's a risk someone will accidentally drop it since the
config option is coming in through a different tree.

So, please resend this before -rc1 so we can include it towards the end of the
merge window. Thanks!


-Olof
