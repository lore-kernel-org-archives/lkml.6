Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F2FECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FA32075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcbNOuDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7FA32075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbeGRQz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:55:27 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41843 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730987AbeGRQz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:55:26 -0400
Received: by mail-oi0-f66.google.com with SMTP id k12-v6so9847700oiw.8;
        Wed, 18 Jul 2018 09:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D5h25BpQ2r5RraSD1h9W3sz5Up+nTg6iZLKs581y3/o=;
        b=DcbNOuDJ5UCulnS+R0QnNXah0y9ftX1lGKOMT8wpExNDyiWdDMkOJ90P1FPUV/oLhM
         5RUlfjEOyglGNjTUOFZ9RVSaNNauL4IWpW1rSLMs5NCrA07pPGpnQNzX8FJUCUUOYoj4
         ziuJyk+qxte9WYBTEDwK2eF5xwEAzuL3dx3CB2cpk8+UAlBLmztb2lnWYlnJPUnAuaAZ
         3ljr+03dvIASPddO8X/6Mf++Xk6nbbmApE4M5kUKLPaKjJnvUQqj56uqp5G+vazYKZYz
         PGdy2s4zo12UKTmgyFsLnm4eAFmzoOuykjRXoV34PO2sGxHwXR1Eb/q5TPPjXOon10mk
         p3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D5h25BpQ2r5RraSD1h9W3sz5Up+nTg6iZLKs581y3/o=;
        b=ujnooJo9u6DWUbojq9WULbBMjLxojNxa3UZDSV58ag3mS+kKe6Td5Pm4Y8E2JNrcTe
         LaLNsEne3w9brTj0e/95m5T10Is/KIPDLri8eOpRfC3Lr54ZhoXkxMh9xgwtvDO0opqY
         47lvR3gV0SR0eBxOL6ItuC24kj+vXUAjOjchH6jDzk3YmufxsSo5zlsBJv2pW+YfCMa5
         aTMY3F6Dl7J+1CgT4jrly3Pp6fSchx7xKJefkGnZt7S791FBXdTE5CaFvL3tXcKiWYPO
         VYK55mp0tfP6cc2z12mmu/jn2znJGAFG4AhRDIXwJLzQpNl1VCelbIft/QbidASFAzmy
         LlGw==
X-Gm-Message-State: AOUpUlGuDJss1+/6wU40rKov8fO0TY8cQsI2SbySfeSCXotsYwhUPFgZ
        d/OMRFpM6z8m9PSSyhOsOec=
X-Google-Smtp-Source: AAOMgpe2HU2zR/21/5idn98y/XfTGSuGz0WfA1zqwOBByJ4f9Igk2SIuEbzGkw4DdVJyNfN7rlpxnA==
X-Received: by 2002:aca:3c02:: with SMTP id j2-v6mr7415409oia.50.1531930608810;
        Wed, 18 Jul 2018 09:16:48 -0700 (PDT)
Received: from localhost ([12.130.117.108])
        by smtp.gmail.com with ESMTPSA id r133-v6sm2999085oia.33.2018.07.18.09.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 09:16:41 -0700 (PDT)
Date:   Wed, 18 Jul 2018 16:13:55 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Christian Thoms <christian.thoms93@gmail.com>
Cc:     rydberg@bitmath.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Sebastian Hillert <sebastian.hillert1@gmail.com>
Subject: Re: [PATCH] drivers: input: Add SPDX-License-Identifier
Message-ID: <20180718161355.o7nct5jcxh4xqmgz@penguin>
References: <1530879112-3388-1-git-send-email-christian.thoms93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530879112-3388-1-git-send-email-christian.thoms93@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On Fri, Jul 06, 2018 at 02:11:52PM +0200, Christian Thoms wrote:
> diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
> index 66a46c8..3086166 100644
> --- a/drivers/input/ff-core.c
> +++ b/drivers/input/ff-core.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   *  Force feedback support for Linux input subsystem
>   *
> @@ -6,11 +7,6 @@
>   */
>  
>  /*
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
>   * This program is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the

Why did you keep this block here? Also, below, there is another
paragraph about obtaining a copy of GPL from an old FSF address. If we
are cleaning it I believe it all needs to go.

I see the similar issue in several other files in this patch.

Thanks.

-- 
Dmitry
