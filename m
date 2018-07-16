Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B493DECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBAD208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VqdjD+1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBAD208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbeGPJIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:08:07 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37620 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbeGPJIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:08:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id n17-v6so14977590wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 01:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3bkhd5Sk6QTcj9EPrm11/XSBxpIcgpqzOVlxq4ScVH8=;
        b=VqdjD+1qXKGXrnf+V+XaAlW5NZ1CymdWzyxC2gCxYwQ+ZP1o8pZg100YAB0P7+19DV
         BBs6gaFFwBSLNdLZu+qTECIaC+BxnhaWBsI1vNoCv2CzDTSkb8iPAxZYjIgW9wwmf9vK
         WbZHHi1VYpEA/b5VLTK9LtikPlxP3WIJEMr9gXqiTs+7vxQm00PEiXWkOA/19ZWIWlIP
         MARYuxRQDxOyHP5+iXgl4lyUVAUvdDfunYCJJsX2sAAtie/NwR7MSY1qvypdUicX/k+C
         X3zGZ5ShOoR+hvOLeiGkuDkfJRjZcsqN0T4j9BIgC7Mt+97IFW1Js9YzzUD0UKYipgKq
         B/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3bkhd5Sk6QTcj9EPrm11/XSBxpIcgpqzOVlxq4ScVH8=;
        b=RzgfE35APVdYD0me5rkWDR3PdIqB0b2uFYRBCoEo2RmHHkCYwWwG/bW5h1aaMJaMoY
         UXVf5UzEIjnTmaEbG6hwObnN1M6Y/LHxGbKjsG7NF0gI4mTHd5NVEhXPFcSSZo5AYrCO
         /22NDrWSv0IW5x2GS65OhTmi/F8DPnt+UJFVEgxsVj1rH67dTYGWuqsko9VSwkKVeM3C
         UBm19xu3HEzMe/1PlppZjHJpNNpo57TQJYots/SjgQHjXIsCzk/rYYLmZik+Y/9eTwJf
         9ZZ6HZauoKnStJpfmoovtwZC2HLGK1olXabprh9iXNNQ3wYE16tEfQUxkoaOdclw354U
         Ajxg==
X-Gm-Message-State: AOUpUlF+i/pe8EQK4ZEecCOQon851A/n14fZ6WlMLngou/cbrIJ/DDt2
        EGAOAVSLpJzTlimoGZH8P+tmow==
X-Google-Smtp-Source: AAOMgpeN0D/4sLi80qH0Ev1wWXdysOksBIO4+oExqMmhLCGw0yBvn3gbNYOXk4Mx84HD5vtZkJq4kQ==
X-Received: by 2002:a1c:e409:: with SMTP id b9-v6mr8662261wmh.34.1531730507387;
        Mon, 16 Jul 2018 01:41:47 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id c10-v6sm28989239wrs.6.2018.07.16.01.41.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 01:41:46 -0700 (PDT)
Message-ID: <1531730505.12853.16.camel@baylibre.com>
Subject: Re: [PATCH 1/3] soc: amlogic: Add Meson GX Clock Measure driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Mon, 16 Jul 2018 10:41:45 +0200
In-Reply-To: <CAFBinCDCbOrX8BaJcDpeiR=r6eSxj=OQ1voj-Lug=P7hyvu=hA@mail.gmail.com>
References: <1530624110-4687-1-git-send-email-narmstrong@baylibre.com>
         <1530624110-4687-2-git-send-email-narmstrong@baylibre.com>
         <CAFBinCDBEbVSEzhM2WOhxNX1DZLiSrkeo7GWdxGzBpOUH3PKQw@mail.gmail.com>
         <7d83a0a4-5cde-7e4f-78a8-372ae8cb03d0@baylibre.com>
         <CAFBinCA5B87TkfOtQd==PxDK74kJ+XWMgY-36QK2TT9p-vAEUA@mail.gmail.com>
         <7hy3eknl3l.fsf@baylibre.com>
         <fb73556d-cf18-266c-e638-9dd92224b939@baylibre.com>
         <CAFBinCDCbOrX8BaJcDpeiR=r6eSxj=OQ1voj-Lug=P7hyvu=hA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-07-14 at 16:41 +0200, Martin Blumenstingl wrote:
> > > 
> > > Even futther, Couldn't this measure IP be used by the current CCF code
> > > (as an additonal, optional property) such the the debugfs clk_summary
> > > uses it directly?
> > 
> > It will need hacking the CCF core, but as Jerome and I said, this can be done later on !
> > We can push a debugfs version and migrate it to CCF when we figure out how to integrate it
> > correctly.
> 
> Jerome already raised concerns (on IRC) that measuring the clock takes
> too much time and using a CCF clock provider would mean that "cat
> /sys/kernel/debug/clk/clk_summary" would be slow
> if that's the case then I'm happy with a debugfs solution which can be
> migrated wo whatever framework suits best in the future

Actually I'm not concerned by clk_summary much, it is debug. Slow is not
desirable but not critical either. I'm more concerned by tree recalc while
changing the tree topology and rate change if clock measure implement
get_rate(). It is worth trying ... just keep an eye ton this.

