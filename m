Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E32C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529A3214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiR4j7+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529A3214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbeLFR7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:59:38 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38526 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbeLFR7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:59:38 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so515211plb.5;
        Thu, 06 Dec 2018 09:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T7BI5VJ9Y0pBQUt0tfp4wW0Mgl5KkwV5uNDcYnxr7Qg=;
        b=QiR4j7+mXcC2gt/9/2vNN902Y2QkLA8HocoCtacbltDBWhF6bIgxtrS2wW5NHqSE1D
         C+qHuty4UY8+lDe1JfQcBQCRYg3Lhs8rS37vP0JidhxBea95KW8a9yU77BPQUovC/UiZ
         vQgISgGD86pM8P3v+M7NKb7y2r4K6gCcZWlPWPlr38FL+peXCMNlRasqWEaYhAjLJ2kF
         vqlC7rNGkl4ViDc//Ez4ZT/z9Mny1LPnHrciDS+Fp/pfDWdzFB5+xmcSesZuOzHuN+Rs
         kcpM1Mdyif9DxYQD12ZQ70WJVpgqAiXeipGNVGK2KlStFWXp70sQ14K2RL6kxs6C5bft
         E5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=T7BI5VJ9Y0pBQUt0tfp4wW0Mgl5KkwV5uNDcYnxr7Qg=;
        b=kJ/qsb46RhM7f3wAqfYg0uRNjrbhBLisWbrXiXhtHxLSi5j4nVTHWzosMj5qQaDtaf
         XTfxN3GIj+eME1sp5ATmLGWKWrpZqBQnPO/NXq88Wr+PazKlfIAi4x4MEcAXXwzEXnK+
         EeV0vcEr5PhkrwAeKkVml3EdjXzCIY5pSVrMRX5gPyCb0rvd/PuH53rYoqqtqEOwp+87
         qUEjfRvNCpf1mJn59rFy+2bxlygki464I5DfV55P38R9mCDziOUwTke8/GhNQ4UdG0S0
         UpypWdbxYrTBfKMouZdazXG1BATj4c4uiT31rHs/Z9SKfXdtugGsD/SjHNuXu2s9NEl1
         Xp5w==
X-Gm-Message-State: AA+aEWaJtKSlCgZ1r6lCxV0kiEqE8YqUOK3aMO0bw3SQohW/xZ3pWdkk
        N1uNvblPW90rI7q35wffRKRdXMXi
X-Google-Smtp-Source: AFSGD/VHd1x2/HlGDSjZi9n/gsjDmHs/HOKaVDMQSvSsBp6keyAhUDJtw3lRUdnX6cFUVHKDa8Kkfw==
X-Received: by 2002:a17:902:161:: with SMTP id 88mr29886030plb.306.1544119177787;
        Thu, 06 Dec 2018 09:59:37 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b7sm1284932pfa.52.2018.12.06.09.59.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 09:59:36 -0800 (PST)
Date:   Thu, 6 Dec 2018 09:59:35 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH] hwmon: (lm75) Add STLM75 support
Message-ID: <20181206175935.GA10500@roeck-us.net>
References: <20181205211422.22266-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205211422.22266-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 02:44:22AM +0530, Jagan Teki wrote:
> The STLM75 is a high-precision digital CMOS temperature sensor
> IC with a sigma-delta temperature-to-digital converter.
> 
> The configuration register mapping is similar to existing lm75
> but the sample rate is 150ms(max).
> 
> Tested on real hardware and verified temperature readings are correct.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied to hwmon-next.

Thanks,
Guenter
