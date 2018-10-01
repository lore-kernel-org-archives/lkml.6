Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF345C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71ED9206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="h/r9Mmbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71ED9206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbeJAN41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:56:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44034 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbeJAN41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:56:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id 63-v6so5343779wra.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 00:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a07LEGunP9GFoBIPhRJeNE4A6ZR4gBuv5+IHyrDQENY=;
        b=h/r9MmbbVbz9CAUbKQI6dU92SOThAjhdLGlgnpAroFUbEESCJh33DQZQu9CeTBxXWb
         NV2/xVtzmFkG3fiQkvCer4uCmdzmEzKwJMbXF9MoAerkRmBTSN8KIVkFi5n22Rm0zPB9
         r3QDTt5n79aDAf3Uk7qJLhNBBeQAVFXyPy69TW82nmpzWPqq/6Xym15ziNm6B3EpkaFP
         D7uxdXAzgoWVntLV5woPk3QrfjDF3qR6AVqkfCWdqHbyuh7Imi1PyTWEDaS1hghkk/sB
         U2OO0HA8dN9DulxZ20b7e8xUYes35sbTOaDJqTOuajEmMnz/fmD52REMAe1trR2XaVPF
         KVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a07LEGunP9GFoBIPhRJeNE4A6ZR4gBuv5+IHyrDQENY=;
        b=JFciAvzsb7tNNtMXNTMaZmqbLua4MKwNyoJK16KiHbksTCfP/laUY1X9GccTy8kSzB
         k70DnU0YHvYp3/eWeguXAsUfmPTjhMQZqd943CKZuW2Y+ONrXaGmsBKYoNy9mIn3PFOu
         hO6VpDNaMOegDvpNAwGI08p6YEEKJq/P1gDycLB1toXY8jo3v6Aj0poZUVsBCgZCsml/
         UH+SnHv9Mi62tU81XejeP8FnIjNepcHv6dBaeSlPjIKWCQpoLyOERsfOQ0XDfVRzi287
         P3Xjq3VEFJis25DMOXGOi/kj/GZLWZqO6UDgvGmNYv6hWQxsYJ7k+IMA15EWNTOxmwbK
         4QfQ==
X-Gm-Message-State: ABuFfoij6XPq16HuDQ561nih7qsW7MhcrwWYWumCyTDRqYu2kPYUg/S8
        CWAIb5OZuV3fhaFGjTAwYBHUQA==
X-Google-Smtp-Source: ACcGV61DBV/yWJLe/3jZ9pnx22CXkMMgJgsA9O9hjn3vgvYeoKiQ6pQoQM7CzHVazb4mjBz30iwRVQ==
X-Received: by 2002:adf:fb0e:: with SMTP id c14-v6mr5883135wrr.117.1538378406490;
        Mon, 01 Oct 2018 00:20:06 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id w4-v6sm6268293wra.83.2018.10.01.00.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 00:20:05 -0700 (PDT)
Date:   Mon, 1 Oct 2018 09:20:03 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        nhorman@tuxdriver.com,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] crypto: tools: Add cryptostat userspace
Message-ID: <20181001072003.GA17784@Red>
References: <1537351855-16618-1-git-send-email-clabbe@baylibre.com>
 <1537351855-16618-3-git-send-email-clabbe@baylibre.com>
 <CAKv+Gu9VCZx=UHSoN7SexZeTzLK6yk9YAe5qMdhhDMUFnqTSCQ@mail.gmail.com>
 <CAKv+Gu8jgEyaUA2OOzxNT5nvWoC7qZgf+KazzH1Q5yWj60V2TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8jgEyaUA2OOzxNT5nvWoC7qZgf+KazzH1Q5yWj60V2TQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 07:03:11PM +0200, Ard Biesheuvel wrote:
> On 28 September 2018 at 15:13, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > On 19 September 2018 at 12:10, Corentin Labbe <clabbe@baylibre.com> wrote:
> >> This patch adds an userspace tool for displaying kernel crypto API
> >> statistics.
> >>
> >> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> >
> > How do I actually build this thing?
> >
> 
> Never mind.

Nope you are are right, this patchset clearly lack documentation.

I will send a subsequent patch with it.

Furthermore, since you seems to use cryptostat, what's your usage/opinion about it and what statistic it miss.

Regards
