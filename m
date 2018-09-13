Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2508EC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 04:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498CC2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 04:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ipP1A8PH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498CC2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbeIMJTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 05:19:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46645 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeIMJTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 05:19:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id b129-v6so2097232pga.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 21:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=P4d6+W34+nRNm0tp/SoFBBVF8pWqkat3UzTKu+hcLS0=;
        b=ipP1A8PH/9kz0bKPjD9X76tx52MjS7I7x1kUU8MT4LFsK2myyxkHHjLjko+Z7C8bnw
         clOw+ZxIijaQjEC35/etiqqjKCOlfFcKDp5pCwDazNIJkTp0Qg8BHTSumZ3LgbalnddL
         fXLxbq9VKRREyolTx28kEWCd+ISoXYJXYWhUxkUC/TolMEQDA3u0lhr10hbl1lVXiMhu
         V1yxmsFqxEpwZvOYb6CIXP5AroHMYxvx49qyYmyE6KEHQUK2C7samb18l0fRGo+tyICk
         JMuqKU/HarFcHIBkJg8/kxfgJmLhj2tv4z08RqHQMSyLAB8AF+hkXiGsWpEzXBBOv39v
         hsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=P4d6+W34+nRNm0tp/SoFBBVF8pWqkat3UzTKu+hcLS0=;
        b=aXWPJc7iFevuCy7jUblGZSV83dtNTvfzQxiukuW43WWXhORcJkYq91C/3Y4huYoCPn
         X8Ar+VgDBQ7bdeLqxihZ6pJBwDSbMSuRJNzRgdddO8S3I8ZOByBdeqs3otk3/7WapG0C
         vjY2y0F8j8/ZZIDpZhEq9Ekifl5H0PhIR9xoCE5F6+Js4kYTyUKRyT3lBdg4FD4IFSan
         h8jVMndagrOEQJjJVfVO8t9aesPqQfmtl/JuVkschSCLccpdj3y2WTN4Ja6CwjLwOqhV
         9fqzruhVa+lyc70ByahW8zL2luqwW3UvteCwa9FllylkGMq1puaCzWiVHjXcAgkgAlSp
         RFfQ==
X-Gm-Message-State: APzg51DjtjaIwUKtFkftokcQi2srEwoc+r+E2ciUbyHqp/qUVzcg/b9L
        tk61kxmksHktzELMZydDov7PmQ==
X-Google-Smtp-Source: ANB0VdaVXwq9f7nn3+Xe49Z1UJIsW6R6V1xO7T44PrzwfJLJWFAu6UNJFf1qMjEc+mgWPUemq/FkTA==
X-Received: by 2002:a63:24c:: with SMTP id 73-v6mr5377309pgc.252.1536811934402;
        Wed, 12 Sep 2018 21:12:14 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id j184-v6sm3032363pge.77.2018.09.12.21.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 21:12:13 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: meson: libretech: update board model
Organization: BayLibre
References: <20180830105317.9337-1-jbrunet@baylibre.com>
Date:   Wed, 12 Sep 2018 21:12:12 -0700
In-Reply-To: <20180830105317.9337-1-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Thu, 30 Aug 2018 12:53:17 +0200")
Message-ID: <7h8t46xcgz.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> There is actually several different libretech board with the CC suffix
> so the model name is not appropriate here. Update to something more
> specific
>
> Reported-by: Da Xue <da@lessconfused.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Applied to v4.20/dt64

Kevin
