Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F51ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BAF32081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rilvydjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BAF32081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbeJaVnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:43:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38911 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbeJaVnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 17:43:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2-v6so8911127wmh.3;
        Wed, 31 Oct 2018 05:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CJEBx8RNs8MlwdCcqvL8foLQ7Ihcx/fHPX36JTJtcHs=;
        b=RilvydjlLNLN+p0S/z9nd54rpCILOk9/TE6J5jG1c1RdDaSfZyNTAc4C4XNw6fOZ+r
         5QVqP1GCdl4YAEFHqVbsPGmXSO8/kNUYlHOahn1LQWLq2ouWegJddtZwPqkHMHg0uH15
         jkMlDFC+VB063j2I3LMQM7kzf3mLb94cr42Yewt/aSP6rl1Lg33xfweluqWRW8nBvlRe
         4d26cYmAbFuQ3T22ndftKwRFpoIEMD80x9Uf60WAtKkxJScbY1T0Oq9C6ZvK9LnONpNc
         qQmcqapzKw2RI2ndZpSBn2vnmY5X1EhQPulrAEdy/CvUSmB6VnX2XqcoOfe1fIdf4pZv
         dKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CJEBx8RNs8MlwdCcqvL8foLQ7Ihcx/fHPX36JTJtcHs=;
        b=mdQsSzZwHZfTjsu68L5WcOeGGjGej8DuwOQDSfRa+j/UkOXJcokMt/bS5VhuUd8zR/
         NkvWRuiDSwY1IPzn8f2puCRDfYjJ2EjvKxMf4fRfEtoSg1yh54LvGpz6tXHOwUH6aPQu
         j6FsvsJs7iRMxnPU2zAp+Dt+ezr8Y4ImgtGR6LDo1EappPSzi8Lh7co7HF6MglM6HdWR
         M3YLvt5K/SSttggxhbng7fa+JdMebaPrViTkmk5U5q7+SD5ghvno8qO1k71xe5H8VbLV
         dbJkV/EZsDH9EFm9LIp0g+6NsFMqR6Kd6SIEGknT6cXzvHyUsz83Cikm5vYjG/i8TQjv
         aAsw==
X-Gm-Message-State: AGRZ1gLOllZZyEUM7J7+g4pnZWGHt2jwoCYNHvMtZLF8NGvCq2T+fy+n
        2iv25NuT5WJbfdumLZn9xAw=
X-Google-Smtp-Source: AJdET5clS0Jm9MDl6kXSea+JX8fUAWs/hzlC6xdIZxKaniWHSmKPc1Xt1NjID5gQvu4/4YvYydPdQg==
X-Received: by 2002:a1c:39c1:: with SMTP id g184-v6mr2178832wma.93.1540989948749;
        Wed, 31 Oct 2018 05:45:48 -0700 (PDT)
Received: from picard ([194.207.103.1])
        by smtp.gmail.com with ESMTPSA id n2-v6sm7153690wrm.36.2018.10.31.05.45.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 05:45:48 -0700 (PDT)
Date:   Wed, 31 Oct 2018 12:45:47 +0000
From:   Dean Wallace <duffydack73@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mogens Jensen <mogens-jensen@protonmail.com>
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
Message-ID: <20181031124547.2rrhetnxuxxsxucv@picard>
References: <CAHp75VctdBE-GM60udJawBCXdmoOqZn4N=kFWz5GLHzjPG2iQQ@mail.gmail.com>
 <20181029190819.2ivlx73n6y6sx4vk@picard>
 <ffc4bcc9-62c3-8940-85d6-d0fd01f3a1b8@linux.intel.com>
 <c8fb730a-c160-41b4-dad0-8ed8594e5687@redhat.com>
 <20181030143836.feo7zcxiestylxoo@picard>
 <2d429c87-24c5-4075-683e-b0d12c3eb1c2@linux.intel.com>
 <d00df762-e4fc-06c5-701e-d5100bfd0e35@redhat.com>
 <e48696f0-aa3e-e20e-d038-9d8dda9cbfce@redhat.com>
 <20181030161534.wk5cf7nxbwhp2far@picard>
 <307c2074-d268-a87a-6040-1240a2091a4d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <307c2074-d268-a87a-6040-1240a2091a4d@redhat.com>
X-Info: Keep It Simple, Stupid.
X-Operating-System: Linux, kernel 4.19.0-arch1-1-max98090
X-Message-Flag: WARNING!! Outlook sucks
User-Agent: Every email client sucks, this one just sucks less.
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-10-18, Hans de Goede wrote:
> Thanks, can you give the attached patch a try. This does the same
> as the previous one you tested, but then only on the Swanky.
> 
> Note I've added:
> 
> Reported-and-tested-by: Dean Wallace <duffydack73@gmail.com>
> 
> To the commit message, I hope that is ok with you, if not let me
> know and I will drop it.
> 
> Once you can confirm that this version also fixes things I will
> submit this version upstream.
> 
> Regards,
> 
Thanks, I don't mind at all.  I can confirm 4.19 compiled with your
quirk has working sound.
-- 
Dean

