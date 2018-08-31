Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B80C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C21520661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C21520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbeHaQ0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:26:07 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33238 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbeHaQ0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:26:06 -0400
Received: by mail-qt0-f195.google.com with SMTP id r37-v6so14260947qtc.0;
        Fri, 31 Aug 2018 05:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KqSYjMYrw2EGztRkB08ocQDhT5457iGfrLd1PeWe5So=;
        b=i9cFCohtfEzk0RR1+tKAcNOtCbeXSSS/6AF20Mte5DKFUiamiJ5ytpc2cTS2NCghiw
         4qBjZnk06TmtTwLL2tnyuK1QTrZDbBsNcr8eBqp6XO9dd5YrNpb4Uc7ngTvUnCGxm6Fa
         lTBkkAoOel570q4vVdJ3Ol0JdJk8RmacJ5+l9IoNCsFAscxzbb8qI6kJJFXUu/1tGnwd
         Hz/BQEbgVX6HU2k7OQRNyGL+FKX695GrayywBmCiRBpI0BmDxUac9TasluWpn+GSJpzn
         aQ9jadKDkLogsZiHFnHyxnqD6JKn2njoug35f2fhYwd3yAPE9mrUvjxJGqhs7dIN5exz
         711g==
X-Gm-Message-State: APzg51B0M5gO/FdVW1/x5MuQ6d2A77TC4y+hWZVg9kOhBVTRuUWGX+bN
        r2IJstWcP2JUqqVM7X3tHg==
X-Google-Smtp-Source: ANB0VdatskEkTV3nqb/2OKXFHa3/zs/aRAwEyGZZ5gGu5zu8AVYF15Elksc3ht8KVVixD+EpgS3GyA==
X-Received: by 2002:ad4:50ce:: with SMTP id e14-v6mr14736429qvq.232.1535717932499;
        Fri, 31 Aug 2018 05:18:52 -0700 (PDT)
Received: from localhost (mobile-166-170-28-234.mycingular.net. [166.170.28.234])
        by smtp.gmail.com with ESMTPSA id 60-v6sm5520131qte.29.2018.08.31.05.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 05:18:52 -0700 (PDT)
Date:   Fri, 31 Aug 2018 08:18:49 -0400
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alex Smith <alex@alex-smith.me.uk>, od@zcrc.me,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 3/4] memory: jz4780-nemc: Reduce size of const array
Message-ID: <20180831121849.GA23787@bogus>
References: <20180822172953.11281-1-paul@crapouillou.net>
 <20180822172953.11281-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822172953.11281-3-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2018 19:29:52 +0200, Paul Cercueil wrote:
> The maximum value found in that array is 15, there's no need to store
> these values as uint32_t, a uint8_t is enough.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/memory/jz4780-nemc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
