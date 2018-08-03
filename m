Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FDCC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02F121761
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vIhU8/me"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02F121761
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbeHCOBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:01:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44765 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbeHCOBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:01:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so2753069pgp.11;
        Fri, 03 Aug 2018 05:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8bwz2wig0EuW8QMjZw9ZZ70NwsEOY/RbD3W05bv/UpY=;
        b=vIhU8/me3WNgEGKopvDdqTu26Ltpo3txzqcM4qSK4jc7M7LLSpv5lVxzoyPBUw/+NT
         Z67hDiQPaReLSvWffhkUrBaupR7h4D3DmWr9tsLAshYaLhKD3nHnJE3tdqm9ujqiRjfX
         br1n9c9GUklGmkTjdTjtygIjXOYU6TYnZ+QNmadSfjA3xc8sq832vF21eeqWheF/4/Wd
         2afWylo5MppH9CELbUkK7hzFD4ioWaZQekbFUWzLPEMIk/Dvc5cZejnh2DlVKVl6os4o
         doUl6KBZtja934si6k3yD3LUEkQJAwkjlICfuHanAraD4CnArFxG4Num4fqrTLUsMRCT
         8Gjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8bwz2wig0EuW8QMjZw9ZZ70NwsEOY/RbD3W05bv/UpY=;
        b=o5ULLx34gnQPX01KSz4PW4t41hoXCO+TtROA1HhAFhjDC5MWQm4Nkxr54FG2FaMWT8
         il4Us6yst6KY0bw2buwUDrsQWUWjKdf0Ap4kPKfSqKnC0aXPDdDzPYCjbTHPIFpXbrh6
         VJxVqwLaYTT5fgzte1E+xkl+sSYNIamzFK+nmi5urA23G62RFy2KRRU4Itg7muXr8Ac3
         +IaPTyLuVVbHwcaQMv9Q3vO76FEZvWVfC4U0vXN+fvRdq20XP0LzHau4Zy+1JnDDN6uI
         GFjIi44Fq9rvHR8MmryXykOF7ljoT7YaUuHdcjqXL+UUL5ahz/t7MIsgXKXiZktbrrII
         tFCA==
X-Gm-Message-State: AOUpUlFWcBbpHmDpTX6X0GISTFtTSiQfHO0tN9UjqPRPP7/fq8fZSPtJ
        fHcgSX8uboHgyw+U6/TPQ0s=
X-Google-Smtp-Source: AAOMgpc9Cu4/uv1FIbtAklZRy9sCSPB8slbXD4S5b5Pu35SHtJU0JoKhOLiNdydA7Gfd85VMv8G6IQ==
X-Received: by 2002:aa7:83cd:: with SMTP id j13-v6mr4229539pfn.236.1533297914041;
        Fri, 03 Aug 2018 05:05:14 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id y4-v6sm6446978pfm.137.2018.08.03.05.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 05:05:13 -0700 (PDT)
Date:   Fri, 3 Aug 2018 17:35:06 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][iio-next] iio: chemical: fix spelling mistake "failted"
 -> "failed"
Message-ID: <20180803120505.GA3741@himanshu-Vostro-3559>
References: <20180803115551.18866-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803115551.18866-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 12:55:51PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> fix spelling mistake in dev_err error message text
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Oops! Thanks for the patch Colin.

Reviewed-by: Himanshu Jha <himanshujha199640@gmail.com>

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
