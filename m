Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E7BC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 04:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405EF2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 04:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="meavLdu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405EF2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbeIMKED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 06:04:03 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45067 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeIMKED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 06:04:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id j8-v6so2022686pll.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 21:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Jd8aAYPLW/4/CX7bTAY/Rr7NSL59fWTvhk8XkTFpbcY=;
        b=meavLdu8ghrK8n8xGK9cuCgQQq61uhERDAILpIbjZQ5yYuQulFiMAO4EA/LLsMQ1t/
         TRfjXQ/2h6z1XS6amxNjivuOapfqT0p/Gb+yGBSMuf+qIXMIdBzAdcf3O+zeD0cZn1Rs
         Cg2dd9HcD7Zw1cqxBYcGAOldWtU7M43f3kM5zs7/U6npBPfzn8vBUUNVq572RuRn+4i3
         IBz9AAno4qh1zlUBLGJU+NtDSmCYi9P0WjJ2hN+epnvTKntfCY4f00P6/B50RIAhEtmh
         qG6PFEr4GT5/YIlvFpsfpPpW0LmOO2WT0cRxstfdsZdtZ8+3hbFytjHWYbx1qAZdHIZi
         7/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Jd8aAYPLW/4/CX7bTAY/Rr7NSL59fWTvhk8XkTFpbcY=;
        b=gN7m2b7z13zNG30js0/D7Tn5xZ7f9YilCQblsn5+4G0IlHhUqEeOGbDiWmwNAKGvDg
         PZ76fWfTxhLqx2CYk3iRZrDhJSLoXcty3ZG4eSh2FZTvWtrlNQdOJiFd1hIFEVtGfu9R
         2zsOyuT9qiPH+yUrTJFaaYjdST9roeY7QOYEpHYNHatyT4DKvLR6M4zYYfwDzc60aobg
         bSaqfWs0Papw6PJQdLjIWHqAu1Wp10zx0xWm/+ko/pBXFC8t/7fgXXWYcxw9QDMY01nh
         QHx3/actcT7D+KGguWvlaqk44ukzEOnz2Bu09OzmuuztFpOo70eWyg8xif9rm+RdUUym
         M/bQ==
X-Gm-Message-State: APzg51AJt+ghpKYDsailqT1zJhgiZ6y2hJDsR7GyXlrRQcBz20+DMHyo
        wb6Lcnlknwp102kaai006E5VWw==
X-Google-Smtp-Source: ANB0VdYGTDmCBcCTApfHyCGL880U5RUQIMuy6cYGjh0ZHjLUBwvWCsLkGkpqLxLRpLn1OFjRPKOfSQ==
X-Received: by 2002:a17:902:7c07:: with SMTP id x7-v6mr5386091pll.113.1536814575774;
        Wed, 12 Sep 2018 21:56:15 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id v72-v6sm5079336pfj.22.2018.09.12.21.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 21:56:15 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson-axg: use the proper compatible for ethmac
Organization: BayLibre
References: <1536604750-32621-1-git-send-email-narmstrong@baylibre.com>
Date:   Wed, 12 Sep 2018 21:56:13 -0700
In-Reply-To: <1536604750-32621-1-git-send-email-narmstrong@baylibre.com> (Neil
        Armstrong's message of "Mon, 10 Sep 2018 20:39:10 +0200")
Message-ID: <7h8t46vvv6.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Use the correct compatible for the AXG ethernet mac node.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.20/dt64 with Martin's ack,

Thanks,

Kevin
