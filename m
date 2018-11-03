Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58257C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 05:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04FD2081F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 05:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="gL6AxD38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04FD2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeKCOl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 10:41:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40490 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeKCOl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 10:41:26 -0400
Received: by mail-lj1-f195.google.com with SMTP id t22-v6so3482618lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 22:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ajAKx5Ay+eSx5uQxrfGA8QU1a1ZljRqaMR3dacfRrlE=;
        b=gL6AxD38hE2ZXY4YmCyMj/ABYSP3ZBFizFfQ3Afx9AlD0cvegNpuJZ/BN3ejkKnsvv
         zYS74IjQAaqkrKBCsovgAzi5DcLeQqtiuG8Oi1PgEhOz3ht5z56dPZ+dmYRKFbXst8ak
         mqO24ESlBCj8w+r+A+5/yxxXgwX46AQW9cF4t2scXCQXlNBWoOYTaX9tAlRmMzoSAgUA
         g61HqBWGtT1z/ubSqVB2x71cuSJPgLSWZGET0PGkSTwU9LL02ldYqYnrc/crj/67gXSB
         yqjLc7htT5iMxfPmdha63EMXFvNO+EtbEdK095c5RzIdLCJWACW52PDDP+xjIi96vY0y
         +ADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ajAKx5Ay+eSx5uQxrfGA8QU1a1ZljRqaMR3dacfRrlE=;
        b=LmMewkPkILrGjXks6nzioeJxTep73ogl3L7IbEzhVCjXmJVSM/WazQz7o1HAQgaUVk
         Yai8Vz+Ktcj1w6+DgeZgKq4n19hIWtm6LUdzzhM1Mx0EhNPkvwcdChkgHWI5C1eey6Ld
         g7LhaYZ8+x0GFBkkcBMcDRenkyAux2JK8I5HaJQInDSNjAlR2QpKm+Zz/6iOnxgAuGfu
         IURWWlVRUoD3Fox1fhTKBdkj38sxV8k7v8kSd5Z4G+Iuku/5yP+8mtIsrl/1fnFJHySa
         MScf0LCmwlJCsa0W1kIoCdgVfTrS9s+oaqwLc/nFxw/hyHeOKBPCf7a0EesWY4136waU
         oCpA==
X-Gm-Message-State: AGRZ1gJZMj2HyJAcpzRxBZJIiiBBsf5gpYxLnwQ4yuhyhpMaBWK7tA/2
        cDe4+aKmy6sze80tnW9+PY6JdEFMHwdI/yzku358IA==
X-Google-Smtp-Source: AJdET5cBvj+Ks+RK5TYl+FiJZE1KCDWaUo7RIaPHe7bKdM36klam7+D5A30yR4KP9O3SDdkIsxN3f/xHQohGAmZQ+Ko=
X-Received: by 2002:a2e:8eca:: with SMTP id e10-v6mr9029154ljl.109.1541223078933;
 Fri, 02 Nov 2018 22:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20181103145752.6c1d10c8@canb.auug.org.au>
In-Reply-To: <20181103145752.6c1d10c8@canb.auug.org.au>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 2 Nov 2018 22:31:07 -0700
Message-ID: <CAOesGMjXPKE21tcVRurGKArUP8ogGBYZ6t7ZmDe2h0iyapneiw@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the arm-soc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like I accidentally rebased the fixes branch locally after
merging that patch in. Will fixup, thanks for reporting.


-Olof

On Fri, Nov 2, 2018 at 8:58 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commit
>
>   cda58c80fe27 ("ARM: OMAP1: ams-delta: Fix impossible .irq < 0")
>
> is missing a Signed-off-by from its committer.
>
> --
> Cheers,
> Stephen Rothwell
