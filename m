Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D28C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188F321104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="euxw2/x+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188F321104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeK3GYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:24:30 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40058 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbeK3GYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:24:30 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so1501161pfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 11:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=DhAIyP+/ZvYMwp5lUjN9NOSHIbBVxczhwzE7/+4Xp9U=;
        b=euxw2/x+aRau7eT8AbvzNHENjzkVVqcKhBbh3ya6GiOuxv3CdkkSTa2A0MFZFVIjbN
         q9sF83+Vc2tfinKRiib5tPEydFIbLLCBYaY8nReJ6KgIB4jlJ2tMm0MqQO88Sl6NUu5l
         a8ubJ8TZGl+yXn8CmR+XUpJ6CdvxYflGLfS1XiDzhNl9/UW+ZpMAkLhTGf7LRFnbpgMs
         uw7Ji/vHf3EcDlQknLtF2092cZ3a7aDntPBr1B6R20d4uwE/aEbRbvLQCSLjxtk/viJI
         thixW+EOikDZFHkQZjCG9bivNDo5msLrDxmvokYI0nLwaANMPeZwnMW16IxrMXh3bvyQ
         eC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DhAIyP+/ZvYMwp5lUjN9NOSHIbBVxczhwzE7/+4Xp9U=;
        b=fgfVwzCquOqI8wqF1wBlI2xJFP4ibw1+6Us4W5It2oBN0Z5+n5jmRkxhcXPPe0dMH/
         oE3tiEflSf4Tzx0QcBAh6dO8c5N0Q1FkRGKue27UDBnQNAuObZN8rNGlf86B8nRUC3Yr
         Cpejgm/2IcA2fN95fIvWIaUHKeW5eH+5zGH8b2RU72AF5jw0iTwFwQsuVZyU/c09LxeZ
         IZEkDPmtj+W0YEa6EHABAPW1Bb+FEIWwsoZSwuhXeomu4uUyVoXdAsbeAcAhXAYWIdSc
         WfSpWH2Jd8ehchSqKVI1NSFe7U3yx3ZdsGoax8LKTeeKPBP8bQ7wVRCR5N+D+IRtBak6
         jvlQ==
X-Gm-Message-State: AA+aEWaS+/0tg4oGdmbKQ9c69xJR+ltw3hFQd4T8ohYJDoKbbzJ8bkjM
        LQri0ckUGEX9Tw8Lg/qT2n9pSQ==
X-Google-Smtp-Source: AFSGD/U0vlfJP5T5YaKwqXyUbGT4RIjfqQQRXoH2mDpeBlEv9PPBorBCkeqDzaSkcfhV+GdyPpTpDA==
X-Received: by 2002:a62:1c7:: with SMTP id 190mr2647144pfb.46.1543519082636;
        Thu, 29 Nov 2018 11:18:02 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id y89sm3774915pfa.136.2018.11.29.11.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 11:18:02 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Vineet Gupta <vineet.gupta1@synopsys.com>,
        "linux-snps-arc\@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ARC: change defconfig defaults to ARCv2
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA230750146419633@US01WEMBX2.internal.synopsys.com>
References: <20181127222045.18491-1-khilman@baylibre.com> <C2D7FE5348E1B147BCA15975FBA230750146419633@US01WEMBX2.internal.synopsys.com>
Date:   Thu, 29 Nov 2018 11:18:01 -0800
Message-ID: <7h36rjae1i.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineet,

Vineet Gupta <vineet.gupta1@synopsys.com> writes:

> On 11/27/18 2:21 PM, Kevin Hilman wrote:
>> Change the default defconfig (used with 'make defconfig') to the ARCv2
>> nsim_hs_defconfig, and also switch the default Kconfig ISA selection to
>> ARCv2.
>>
>> This allows several default defconfigs (e.g. make defconfig, make
>> allnoconfig, make tinyconfig) to all work with ARCv2 by default.
>>
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>
> Applied to for-curr

If it's not too late, could you tag this for stable?

Even though this is not technicall a regression, Greg said (in a
different thread) he'd be willing to accept this for stable if it fixes
the builders like kernelCI.

Thanks,

Kevin
