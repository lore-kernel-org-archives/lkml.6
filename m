Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BD4C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9336F20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRBYwUMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbfA3KRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:17:44 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36694 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfA3KRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:17:44 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so9672293itj.1;
        Wed, 30 Jan 2019 02:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Red5zHbN+lfXs3TYegn7hFfQkcfngwOiw9+CgmEYEx4=;
        b=GRBYwUMkCBmM+fjs8B0DOm3e2M43i3pzNKgORHuRgs+RkctA+fRuVTxW8qEalrywtI
         JCSyZozfbC1jNtc5+3GASxIt0tEqFJqiL2qWw9i4a6WjJnacKBL9e9ifCpKRHq2tvxvD
         bpNy4b5vsmkvovTxVoEN+9poFAnEAn8Cw2y0GR+m95uRI5SSFSLvrkIZxlhT7xVFDH2h
         Po/nX9soVLXHRuFqPKiy4QJ7ZKywS8+Ai+PHZ1a1F79YL9tOoqXme7C2V2zUuB3j04Mq
         8GzaVv4Zgk2nSE5MEXSCdIotZCv1jKwjYgU7Wg2pOy/dyM1oVumsX/qCo3rdGjpR4SW2
         LfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Red5zHbN+lfXs3TYegn7hFfQkcfngwOiw9+CgmEYEx4=;
        b=syq3G+lKoBaEmG7+MQsHW5MO0W+efft5GKUoEls2LD0fPiEnRIVEt0nqLgvikrow4J
         OiWDaOv3VWPT2l2e8e0H4drksM1g6aKAZFgUx71NxsSEMSz5DIMjixmzI9WDetwntWNY
         uiqhXdNtAHbVDhs0eGhJqfaM850xkYy6CtS5uTTCWeVjKtfcAeLOsDL/bct1IeR6pfI9
         oR5ZaVrHH4UPCY9ko56otf1yfsiOB0yW9hni1+0tyu1l90UAG5OK17sNENfthrThphnv
         409uEFqQJn9Z7PAdVKk3x+VF0MeoGR7SDAv3CCezrQmisJ0uV6+huI3XJvSlT0zo5sGy
         4kyQ==
X-Gm-Message-State: AJcUukc/zsi4gx8BfAzpxaYYztMSGemKn7XWLbZz4OGLMFKYgIY0LjuD
        QZxLU+mGlW22EQqJIYh43kk=
X-Google-Smtp-Source: ALg8bN5TrmLkzM14Wyo8DIIg1HLOoi12MTd7ep/HcZryUSXiPepcK5naikZO/oBjmICCwb2XS2ealw==
X-Received: by 2002:a24:5a8f:: with SMTP id v137mr14864048ita.65.1548843463078;
        Wed, 30 Jan 2019 02:17:43 -0800 (PST)
Received: from icarus ([2001:268:c0a5:3348:60b5:ec84:e7a7:e417])
        by smtp.gmail.com with ESMTPSA id 79sm1005090itx.11.2019.01.30.02.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 02:17:42 -0800 (PST)
Date:   Wed, 30 Jan 2019 19:18:14 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v8 0/8] Introduce the for_each_set_clump8 macro
Message-ID: <20190130101814.GA3668@icarus>
References: <cover.1547445576.git.vilhelm.gray@gmail.com>
 <20190129170734.688a6adf91267cc6f1b5fa08@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190129170734.688a6adf91267cc6f1b5fa08@linux-foundation.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 05:07:34PM -0800, Andrew Morton wrote:
> Do we have any expectation that these facilities will be used by
> anything other than GPIO?  If not then perhaps they should be sited
> within drivers/gpio (presumably as a standalone module) until such a
> need is found?

I can move it within drivers/gpio since my only use at moment is for
these gpio drivers I maintain. However, moving it to the gpio subsystem
does make it less likely to be seen by authors in other subsystems who
may have use for it -- so there is the chance that this becomes isolated
and untilized only amonst the gpio drivers. That may not be such a bad
thing in the end; I suspect it will be easy to spot if other subsystems
start implementing their own for_each_set_clump (if other subsystems
would even have such a need for it).

Linus, if I move the for_each_set_clump macro and related functions to
drivers/gpio, should I move the code into the gpiolib.h and gpiolib.c
files? Or would it be best to implement this as a separate standalone
module, and make a Kconfig dependency for those gpio drivers which
require it? A standalone module feels somewhat overkill for such little
code in my opinion.

William Breathitt Gray
