Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34501C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 04:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F2F20866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 04:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CG35n9UQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F2F20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbeIMJ0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 05:26:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33114 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeIMJ0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 05:26:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so2068096pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 21:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Q/YTkAMLVGCPTHLC52/SmkmqC9ezsPDkogM48vYVye0=;
        b=CG35n9UQk/+H2afiuPm2F7UXFX4hWxPtYr6ZUXTjsKvHTjArFKCdUhEgul+5WkiTvm
         vVWGJRHqeledBbFkhewtdcRrNL1HsiyDqNA5iiZO8GrqQDgy5WornHGrhz3diYUV+4YT
         jN4cNMnpBrLjlvoGstR0HXJ9MVEWiF5tvVZR3lPxOSGMK7gG8NqEAVcLJ/4yqqkm+sYQ
         lKHzVSAVLBVTbNT28ba+lF3HNFqrYjQcMqaFKUtEtSKsppJKUbEMyU3gcattR0Ug1mnu
         dkSLskimwwRJrbG4T9ROMYtl/NArZmHlKnTuBtUDnhjyaJwAXQS9ykTjbQkT0QP9D+V0
         IQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Q/YTkAMLVGCPTHLC52/SmkmqC9ezsPDkogM48vYVye0=;
        b=BY+QnsexxX+M4aBGLk3cwLMSTHQvpreAaFNgzHT4hDiVBDoCHl3L2x8Fz+neSSCOcc
         5PgL7hxeSeTbckEngjd+SRg16SUad4fIxvjiZHb3Kw3cjw3b0Gdqg2cd8o7/zGdGdQ/Q
         TDDvJKUZFgsrVEMBT3S5bnPI2h61uWcsCxvuU0QVy0+MlVOhvq1fmsZTdchOV0qprxtF
         nU/XnhpscQ/lv2MWyH4qw9shbGW1IMNOvVjPHf3J8dNXhzUg5QsBo81+i2Vi2/Ezf26Z
         qpKB9APliL3M8h9PCHnVJIl+OelKkCcxRYdzKG4iQj+UBYRvN4JIBPVe7IgUD0PYFZKo
         B9jg==
X-Gm-Message-State: APzg51CLFA0wTQMZbodqlnr5lfkjWWYst6JLULMn6X0wRK6jntEG1UKW
        ZxIVCWnJ9QlIsF6mvNIF8+4ZhA==
X-Google-Smtp-Source: ANB0VdbBSTHdFwqp9m9XiyQhOF93Sp9pxHUYvqXLdMOJKQ1yRDewo5w7Y9T2fCQaTkpVmqeM/kBCMg==
X-Received: by 2002:a63:dd49:: with SMTP id g9-v6mr5066112pgj.356.1536812332761;
        Wed, 12 Sep 2018 21:18:52 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id b1-v6sm5161118pgi.91.2018.09.12.21.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 21:18:50 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: meson-axg: sort nodes consistently
Organization: BayLibre
References: <20180829154551.26729-1-jbrunet@baylibre.com>
Date:   Wed, 12 Sep 2018 21:18:50 -0700
In-Reply-To: <20180829154551.26729-1-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Wed, 29 Aug 2018 17:45:51 +0200")
Message-ID: <7h4leuxc5x.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Sort DT nodes by address when possible, by node node name otherwise.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>
> Hi Kevin,
>
> This patch is same kind of clean-up we already did on gxbb and gxl some
> time ago. In the same fashion, it ends up being and ugly and almost unreadable
> patch, sorry about that :( I don't think there was a way to avoid it.
>
> The patch applies on top v4.19-rc1 + 3 DT audio patches which are in your
> v4.19/dt64 branch [0]
>
> There should be no functional change after applying this patch.
> I've tested it in on the s400 and so far, so good.

Thanks for the cleanup,

Applied to v4.20/dt64,

Kevin
