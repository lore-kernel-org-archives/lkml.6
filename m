Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C954ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60802154E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZ/68Lp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60802154E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390086AbeIUTKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:10:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33928 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeIUTKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:10:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id f6-v6so5984645plo.1;
        Fri, 21 Sep 2018 06:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IRYr0pAkdFjd0cAXXvBV3qV/C/zVJ9wx14rIMyDSYoY=;
        b=lZ/68Lp4tcVtul9EJmg2zAnKdmxlFCb69ilWWRThHEjLOKsY07nGJQjQy3jNdlZnNY
         NMxjRhvc1+eMy+UrC7xMx9JHJN9ce2FTwDsrq7Z7QqzEXgRSWVJp42AaDe9YXGWbJc4a
         XCs7uPBnVZXGHv3nDfKH6I3PJA0wQGndGDaKxLGz4R3EUCAg6ZZ9Pxft6HK0a8MESqPl
         G3yo0ewMnhGNXlwsBqyS4bkNNbYbvmelBR+/3rVAjTGzjwLKOtLZnjG7VDaHpJNXvvbv
         E/kLw6IrVW+KxUTOtKcxiZ3ff0a1YuJjag9O/+B+Ky/qgKjGG16bEJCfaBNReCbe35hw
         DT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IRYr0pAkdFjd0cAXXvBV3qV/C/zVJ9wx14rIMyDSYoY=;
        b=I+dilKia7niL5T5bPP0e1NVaAzmeatbP/nZCZrmXTkOAMsALZngUSifYSEmZeKKOlI
         PkrHD/3liNivD2zBSeAw4f7YZzwOrTL72GOF4tQwQNRgH01N/tAJdjrVgnC4n7VXuixN
         DLPJi5pM/8CbnVtfDzGXukFyK2ciIZg8kKb7Y4o7aTmo37EJE+LlpWxUbjaHm+vyL8Ez
         xXVTbn5FzG9390p0/e4CTafrb6HlXQW2IRCKxBsjhew0PvJFxNy2zVk6gpnJ1lxxP8cI
         723WWIDvdjtn8fxVfLPDt1kuiwbhwdyup0WEFndUUicDwNHV1hKr1PPGh+JiMo4Z9c/5
         j+cg==
X-Gm-Message-State: APzg51CazCkrqnaeqTUijCw0xcHtTVr+oGVR6kPfmpU0VSx4pitGdfuv
        e6SfWKPqlvF2ExVJvIGIWmc=
X-Google-Smtp-Source: ANB0VdZDn/j91DEGMRz7N6g1Kys5z/AuPvWGwMQQ1RSauh8l5+cZeY3wj7RiH5VYvlhkcq51uCZNuA==
X-Received: by 2002:a17:902:680e:: with SMTP id h14-v6mr8348542plk.177.1537536072830;
        Fri, 21 Sep 2018 06:21:12 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id d19-v6sm39768526pgi.50.2018.09.21.06.21.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:21:12 -0700 (PDT)
Date:   Fri, 21 Sep 2018 06:21:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: pwm-fan: Silence error on probe deferral
Message-ID: <20180921132111.GA16424@roeck-us.net>
References: <20180921101048.11679-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921101048.11679-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 12:10:47PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Probe deferrals aren't actual errors, so silence the error message in
> case the PWM cannot yet be acquired.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Applied.

Thanks,
Guenter
