Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C73BC46464
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474C821723
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdIxjbvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474C821723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbeHODuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 23:50:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33771 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbeHODuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 23:50:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id i134-v6so4523182wmf.0;
        Tue, 14 Aug 2018 18:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lJ8Bam04eK6bFTvJrGE+FUJe777PWOOHqFmyWET8CoA=;
        b=EdIxjbvA7iW+iMMjLSrNOoJt2gc3/inFH82N8BINLmFhzimzyTQVvE+8mmcEamFMEb
         i3+8JzZSr9tn7P1ffFaMl+fPZmkR0RHS835r3C3Pj+YyGmnxc8ZfzmAv0nlQ8TDnz/gL
         iGJKWCCuW9CElrmbn6pDdb65cg1MlYB20MxinV2GEp2/YRq838QYlpBa6uGpLIxIIxeC
         SDq3uElVxxAeBSJ8nlBJW5uXdXcDRA4uTgvJPQc6LKIYHnOlM0E41lrzslyVyTwzdqPA
         FbCuZk3MnfxpaNsa2hW3Qk+epVLKA9XocUND1HzwhXg6IJlmfppH/3JxIWLSrYk3c9j4
         XyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lJ8Bam04eK6bFTvJrGE+FUJe777PWOOHqFmyWET8CoA=;
        b=KJW/yH36LYfgrPRWEb43zWefThVI2wa3MA4/w+y0MclCEXt57E5SIgGSbIzXhACI6D
         vVSgxN6ANuJ4SxNIong3860re40f+L6s/Hjgfv5HmPMacGBlaUJZa/YaLeZbhhPX+HBf
         otUCQk0DCkZ1bqZ3iffKbpVTGj0JKvs7+T6HfHdMjKLM6nrB+VuZQla4tJjCAs+rNjGb
         buqmn36hnDyN2Fbf1ZdLH8dqQtJ5L+W6oqFqTlVfrVj9Fi74dXW3zJdFDZvU+bp01pvF
         cCD+BauOd0Y2kGXsTMphgslrf9lbCIsLd3RYEyVT4b2rnz7T8T41SiDkhcjj2b8NOgyb
         818A==
X-Gm-Message-State: AOUpUlGkFpV//xLuKRQCQUut3BL2BQdYnDcAQCJC0U+75alXHC3n6hGj
        16KR9rd9zGwKsrUkKEmBz0I=
X-Google-Smtp-Source: AA+uWPzvZgYfAXxkf5dArhPqsL3K3gUt2hLkZZCwNtxmmxo9+p9p98VIOBqgrzA8PpphRrTobvyX0Q==
X-Received: by 2002:a1c:2352:: with SMTP id j79-v6mr12209138wmj.124.1534294827437;
        Tue, 14 Aug 2018 18:00:27 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id q3-v6sm363970wma.45.2018.08.14.18.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 18:00:26 -0700 (PDT)
Date:   Tue, 14 Aug 2018 18:00:24 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sebastian Gottschall <s.gottschall@dd-wrt.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/107] 4.9.120-stable review
Message-ID: <20180815010024.GA7483@flashbox>
References: <20180814171520.883143803@linuxfoundation.org>
 <891d41f8-e0e3-afa8-3274-b9a10afd3dbb@dd-wrt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <891d41f8-e0e3-afa8-3274-b9a10afd3dbb@dd-wrt.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 02:36:00AM +0200, Sebastian Gottschall wrote:
> if SWAP is disabled in kernel config, the following compile error will raise
> up with this release
> 
> arch/x86/built-in.o: in function `max_swapfile_size': (.text+0x3bba1):
> undefined reference to `generic_max_swapfile_size'
> 
> of course this is simple to fix. the function max_swapfile_size must be
> excluded if CONFIG_SWAP is disabled
> 
> Sebastian
> 

This is fixed upstream as commmit 792adb90fa72 ("x86/init: fix build
with CONFIG_SWAP=n").

Cheers,
Nathan
