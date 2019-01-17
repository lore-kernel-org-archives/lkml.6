Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC63AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7688520855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tVl4eyDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfAQVMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:12:43 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40888 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfAQVMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 16:12:42 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so5421305pfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 13:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=rkUYwr1yUGtYS42fecHVfNO9mFq3t6+sC/jSxL6EfVE=;
        b=tVl4eyDstH6zMX1egoKz7EZdT2PY9+Q/941coF4mKyyI299r3M6NLSxwJvv/CHfOaF
         tI9Q4Tui0nRBWVffBW9SrZGoq2oQF8cxCUmuFF6kZ2O9d4i+2ps4sewhA+K5SKeolpRJ
         HX3jMQnV36t555JDWf4lcguYxSL3kXM1G1HFS8hHh0OKTKlB+KsCdFtpOu8VKC3bjbj9
         GMWrBcLm+fXmnMCy0k2jmE57ZE4PgQ3NPPRkMsamNBi3Xxlp+lfg/0xyKKDllqLTH/TG
         BH8vXszQUJ2Es1TFGNQkhBcisNt1euXGgfnOHBP3rZAhzpUprU0xe4sMQvSoEjo0V/Qp
         q56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=rkUYwr1yUGtYS42fecHVfNO9mFq3t6+sC/jSxL6EfVE=;
        b=osrLvxq1cyXNdKTDvObm6+1LPgKhhpJK4i4YTKaz17Q9Ck1n1nQRyQyGsNW5/u2fHN
         5c2PqQvyY9KV8HTAF5Pfp3pet6xgMKAxwNVTZ4wX8DW6+L3fX5TdHENuXVwWT1C1f4lo
         g3XA+o7XT9DEqkmm/vTfQ/AyRHWOt6u9galWNa8ZIlIjl6H8LWiTf2HJYFodO0nzy1DC
         ocTXmn3BXyVroGvaL56dFc8in36e7jw2OBcCPCC11mIO+1JOe7BZb6aWA0AJMl7MrXp9
         XmJo+DaRPzV4zLAaSvWGrZjWhuU+dS6DtXmnCotEFwXjfKZwCHIqlUkKXcrjIne4nAKY
         xqrg==
X-Gm-Message-State: AJcUukcqCylqmEVFgbviWEfmymF4aldKe3bwJbgpxkCxugh53nt70is7
        OpqgT2s2wMuqoLzb/loFSw2TMw==
X-Google-Smtp-Source: ALg8bN4gib3UkY/kZGF1h4FB9Dz+MWhWk0h7xizXFtImfzb3nJJ5F3SdOEUm9U9cpfhRnYYsJkxIMw==
X-Received: by 2002:a63:2c82:: with SMTP id s124mr14644535pgs.73.1547759561852;
        Thu, 17 Jan 2019 13:12:41 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:e076:9fe9:59e2:1e0b])
        by smtp.googlemail.com with ESMTPSA id d21sm2583819pgv.37.2019.01.17.13.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 13:12:41 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Carlo Caione <carlo@caione.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Anand Moon <linux.amoon@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "Paul Gortmaker" <paul.gortmaker@windriver.com>
Subject: Re: linux-next: Fixes tag needs work in the amlogic tree
In-Reply-To: <20190116074510.7c7e6a4a@canb.auug.org.au>
References: <20190116074510.7c7e6a4a@canb.auug.org.au>
Date:   Thu, 17 Jan 2019 13:12:40 -0800
Message-ID: <7h4la7aszb.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> [I am experimenting with checking the Fixes tags in commits in linux-next.
> Please let me know if you think I am being too strict.]
>
> Hi all,
>
> Commit
>
>   90d2bf8975cc ("ARM64: dts: meson-gxbb-odroidc2: Fix usb phy regulator power failed warning")
>
> has a malformed Fixes tag:
>
>   Fixes: 5a0803bd5ae (ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes)
>
> There should be at least 12 digits of the commit SHA1 and double quotes
> around the commit subject.

Thanks, since I hadn't submitted these yet, I fixed this up and
updated the branch.

Kevin
