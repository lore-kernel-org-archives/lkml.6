Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6352DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A46220685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcQr8cvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A46220685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404592AbeKVQXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 11:23:00 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41107 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392258AbeKVQXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 11:23:00 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so8715525plm.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 21:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fDZpJWnWMtcQ4doGOjeZw8Y2ex+G/7boRgov0990UkI=;
        b=YcQr8cvbDL6N/LfWqDoG/Wp6xi7QG1gYZnwXKh+8Ou/n+xSOYxH9Py62q1DNLB/gPI
         GpeELpvYbqW0I+CVBGcE1DdEE1+8awcDJzAChLmHA+tKgwAeFf/6L59/Jp+HdQJnddkn
         ub9sPuxiRnBWhkjg6Du5NKMa65F2k4kP38xvIyfOfs5B9gid3UR9kO+PhwhI4n8pG728
         uH6euE/aeOYTCkoexMy/zDYYbuxxw0SvTXDXSaEuOOuVrojzRMb7x5S5ConIOqXgcUMV
         Ke5Q6tWbQz/A3csflDtkouqVXzfHC57+gBfRxjx1LVBJhnM2oZ9G7vCPmuYebBCbiQcK
         mxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fDZpJWnWMtcQ4doGOjeZw8Y2ex+G/7boRgov0990UkI=;
        b=lcNGFrLGhZ8PdbmSzJGxCDD9noH/Fl4rE8Itxe+7ZNHpxUstivoiuDJSuirdVJf/pn
         dQ4yHD5BaqMoQbtDlMW42/JH/EMYDDr9AIaruFQLWLZmcnl126t1KAfKmSiYhC/Oc3RE
         tSSDkQ0buakzIG3NjbHongD0A0qfG+wDty5w60WVggLZNRVAN3kuQcch6MnoW5P+bvNU
         1KdrnPQPy8SIi6m3RIZojwQomWbrccJdVJ3B8c57b9ArRY0BR6IrFQwOBQYe9Nct6iVF
         ie8CCTs+iiXUWLWpfNXKAwxRhqljm5dDnLrVXKd3gT+zBjY1iy9hkHWHWa1KZCTVJv2X
         +etQ==
X-Gm-Message-State: AA+aEWaqwQW0y9NehKHs0o8Spi4Y0n1zRsLbJIfOT2fDlSJFfyqWM/NW
        uH6JEGd6sHrdtFs+StcZC08=
X-Google-Smtp-Source: AFSGD/UpaweB16nSfqtOWF3qhcgPpbQYZCMB1cAXcsDJ/TVm4KDB3w7+FnSZtRiSp1MEur8uNDSDpw==
X-Received: by 2002:a17:902:f83:: with SMTP id 3-v6mr9995888plz.254.1542865510625;
        Wed, 21 Nov 2018 21:45:10 -0800 (PST)
Received: from localhost ([175.223.27.1])
        by smtp.gmail.com with ESMTPSA id y184sm50038911pgd.71.2018.11.21.21.45.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 21:45:09 -0800 (PST)
Date:   Thu, 22 Nov 2018 14:45:05 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] zram: introduce ZRAM_IDLE flag
Message-ID: <20181122054505.GF3441@jagdpanzerIV>
References: <20181116072035.155108-1-minchan@kernel.org>
 <20181116072035.155108-4-minchan@kernel.org>
 <20181120024659.GC4231@jagdpanzerIV>
 <20181122051156.GB182024@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122051156.GB182024@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/22/18 14:11), Minchan Kim wrote:
> 
> It was a option when I imagined this idea first but problem from product
> division was memory waste of ac_time for every zram table.

OK, I see.

	-ss
