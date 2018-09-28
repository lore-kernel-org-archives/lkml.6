Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B9BC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A21221733
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6mhuuy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A21221733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbeI1IQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:16:55 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:36945 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeI1IQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:16:55 -0400
Received: by mail-qt1-f180.google.com with SMTP id n6-v6so5040079qtl.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 18:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2tpzwxmxbR05w/nJ/QKVlZRaDMF9f4iIv/BeWpZMCJg=;
        b=T6mhuuy8Y+8gn3SjG03VrtROALTlbn29lk5PTW3AhV1xWk1ZRCzYr8f/e1/DWEF0DR
         c2LtO507ktPfwxmDpzV/TxqMUn/rneKBBrAgCvjZ4KLw98tN4KCHrCkCE3uzCA3dUfpx
         bSrEKKFeOOq/8gMbRJf4i07id/+B+2F1F+Ntkl+SuaxaiC5NHQ/FoztHFF0y8nWYo8PM
         F7FujpwZmf378qtAX/VNqoqRFA8MBlOqud8lQydDXXrQ4Dhg2DuB8ErhvbROxo5vgVvQ
         kNWF9puOSHQb1RahavVNQf4zYuwug0BCpgI5wSGnEOAiMzY2oNMC3m1mxDJYodoVESPD
         cUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2tpzwxmxbR05w/nJ/QKVlZRaDMF9f4iIv/BeWpZMCJg=;
        b=q+hfLMfeK06MHwuzKXqfTtgGxLXRPFDbXk73T5rJWm/yI1Az8YbYRb98iQQ7AtDFnA
         /3t+HA1Kv903RrwwPa3GWCXdJH7hZen/UTyHMzcynbRPc3V7T4NGoIMt57QpCgMlApfr
         Nl0me/MnV2sSk+OqwX7i4k2KPslxmZ1DrDEEIfiwYIF/+x+okJPgRaWPIg3blBhY06SM
         BTiRXvYD4proZtcGqXhLssE1nNhwXwO+FIdP0O2lSnxcu2kTSIyu+NLRpXlS4oxC8PSE
         kyYUwi0JyRh+jfLFImx64s0PA+sd6Uo3BqJf2A14XLyu7ZZBgEXQXynwd58t4OCjywdy
         AMjw==
X-Gm-Message-State: ABuFfogXy2FLB8SwJkep7+tD/SIWF4diJW1uwQzHIEdUtBS7A0W+ItVH
        jwSeHfwnGuJzeOU2Hj8rzZ7/QMHQ
X-Google-Smtp-Source: ACcGV61MZSCCtiWYMmlV3AP0sMC6Uw64KiT0REvXeBZLLbIoUWvzziOSSHqDkL45nMBksGMTTh0iMg==
X-Received: by 2002:ac8:2ae6:: with SMTP id c35-v6mr10690550qta.117.1538099738132;
        Thu, 27 Sep 2018 18:55:38 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id f79-v6sm213664qke.77.2018.09.27.18.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 18:55:37 -0700 (PDT)
Date:   Thu, 27 Sep 2018 22:55:32 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/7] drivers: oprofile: Avoids building driver from
 direct make command
Message-ID: <20180928015532.GB8272@WindFlash>
References: <20180927014138.GA8988@WindFlash>
 <5236278.7dVKUIXYaR@daneel.sf-tec.de>
 <CADvQ+rFPiaGKLyzfSx4DmTnmgG15=Jk0RVy8xuYYyvLPJfDdkA@mail.gmail.com>
 <136913b41707c8556fb5d41969d2080e@sf-tec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <136913b41707c8556fb5d41969d2080e@sf-tec.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Eike,

> > Oh, it's a Makefile, and as all text files, it have to end with newline.
> > If I am wrong, please let me know.
> 
> No, that's fine. But it means it has to have one LF after "tree.". It had
> none, now it hat 2.
> 
> Eike

Oh, i haven't noticed. Sorry for the trouble.

Thanks for the feedback!

Leonardo Bras
