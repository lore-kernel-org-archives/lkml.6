Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B63C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63F62087C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTZmOUWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63F62087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbeKQK4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 05:56:50 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46745 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbeKQK4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 05:56:50 -0500
Received: by mail-ed1-f68.google.com with SMTP id b34-v6so21014054ede.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 16:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5dP4YTFuVMqXxExbZF1EVqh/F1hUjYjzPyUA7CvvirI=;
        b=gTZmOUWvJWN1Mph+gXcuMSnV7NSoZaGFMI2CSkqjA5wXr52IpIaPL5uslqCJLgljKZ
         a2/Wwjaidz33mPyRjejZ6vprL8Aq3ZYdeEUHprs+txmgIgGFygg+Twig2HemNw2FzGMm
         z+qebKKlKXiNOqUtQsDG/BWuA6xhox0caecf6pfNoydMflz7Tis8TeB+RfUKFXu1AIL6
         vUaRhAN4g6wMg1yCPcDU7EADPUbBB81zCYgdpLFqct+8ERm+xYZDvxv1jAk0V+XSPZUH
         0Khe1pFJxD5bSLQ4f2ow1zecn/bORTdBitO8z8f/Ftt7mT1OR73ozmNJ9EsOdUaFM/g9
         sMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5dP4YTFuVMqXxExbZF1EVqh/F1hUjYjzPyUA7CvvirI=;
        b=KRe6CbxyqkJCfNUg38j5TXhfB/050tGObmIMBhkIY2ByQ0dq1XGnFArQRQEvW6EZU5
         dhD9cgvJiCGX5exJ3ht2hKhNCB3p6++tV7MCQKuO62vhwQR8Zo3Q1ATdCz0Tl2EB8Los
         ifO6Bryi9gvB7GI+J3i/kVteCeTgxM2P7okPN7SndFCBJsU8tqhnN+ztQAikAo22RCMU
         Q4BM/SGNVjdP+fvBfHT8u0H1dChyaF53scZqKMiHLwfNAZcUCtb6qgfAwQHkTQYNPAr6
         WGEtYm7iOwBI0asidWMnM6Xq7vEaH3qOGSQvStX+WnD25mDmR3rSdtLqG6ohRnp/pTJR
         zNnA==
X-Gm-Message-State: AGRZ1gLnJk2j6tg1gjAHZqbC6baifJkQcGijGpLnpTz0v/M4PG9uqdWA
        PC3MNcZ95X6fk4g1W/XdW0UMCvGW
X-Google-Smtp-Source: AJdET5fH4IWAaGbAnoV3ZokbrIDDiDR9R700dXtfeMG3Svd8C9TDGxKMIblRKo4sJFNJ4moTYDEUMQ==
X-Received: by 2002:aa7:d8d3:: with SMTP id k19mr4791592eds.64.1542415332162;
        Fri, 16 Nov 2018 16:42:12 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40bc:4d00:787e:f271:ff1d:82b])
        by smtp.gmail.com with ESMTPSA id c29sm3204368eda.75.2018.11.16.16.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 16:42:11 -0800 (PST)
Date:   Sat, 17 Nov 2018 01:42:10 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2 1/3] compiler-gcc: hide
 COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW from sparse
Message-ID: <20181117004209.v67yalpxuswhs2vr@ltop.local>
References: <20181109093534.15121-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109093534.15121-1-johannes@sipsolutions.net>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 10:35:32AM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Sparse doesn't support all the overflow builtins, so just hide
> them from it to avoid lots of warnings/errors reported by it.

The development version of sparse support these builtins
since their introduction in the kernel and sparse's main tree
have been updated (very recently).

I strongly believe this patch shouldn't be.

Regards,
-- Luc
