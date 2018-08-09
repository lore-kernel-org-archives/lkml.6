Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B67C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096AC21A6D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXDe88YI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096AC21A6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeHIIax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 04:30:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37738 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbeHIIaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 04:30:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id n7-v6so2233769pgq.4;
        Wed, 08 Aug 2018 23:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nAkJPNY6eBG7OZfGOUxGF+wkMFzGan/A7giKP5d7e14=;
        b=YXDe88YIiSUpmcTjbyR09m7tvCb+03c+8X6OLCFOoII9f8MpIJQwxPYWeRs0cXaoOY
         w0SxpSduTkp1mAGvQA7ZD/ltT+a+D0BEhKsF19xqG7zTfZQ5UgIgRwmws27CA548CXAd
         eSb134fZT0wWIGlp6mUrxwtEMHxteijIwvYuRSa6JKSdPz+kiWh0+g0ag9KxXfyK2hhB
         tVgKPoUS2OIYxlywnl2rIbiXb6hC5f6fxSqfwgl582VN72m2lV8We8Yts3ZnBnAHnmeX
         nhtllbbCVv+WG2Gi1pkJBCLGQ4x2b0rF1g02E0+00Gl1lL/lKXv6eaHYd/0d5DeVeQjd
         jeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nAkJPNY6eBG7OZfGOUxGF+wkMFzGan/A7giKP5d7e14=;
        b=VPYqctRFicPwAvmoK0nqnf33y7luImrxXrPJLT0XvaEEDb1YB5y0Fv7T4kXyMlEW3q
         TlU6t37OM5eT7RFtCMK1dT/rMF4BsfO50TptmT5Guy9/04UTJypPkvCjI2iYAajSP8w7
         8z3/UY+fGppyVDTFyMDA1enWIqjk+FVyeYQIDDSD2ZbtYJs3mex4Gv8euDhaWxzmiDDy
         op2bsXkT2LrH/oeg2ZjcjuoErhtn6c8abvPS4qVhRVLlEmY1Ve1T4W2vWYCSlI8pxELy
         3L5WjMcXdqrKdeOQ90PxNLlz58RV5f4YoWLqxKYJ1gA5vlhZzGvLxnlD8pOtXvEd0esL
         Y+TQ==
X-Gm-Message-State: AOUpUlGMYiuK6DJcZ3Wm7RGuFkp9PteCa9UFfseWR5GoJDk8fS22Hl0R
        PA5ZkptFanwigbgi06qBYL4=
X-Google-Smtp-Source: AA+uWPzaGK7i+lozLp1miOIuOYTyW7fp1ODcWKoJDVcSs18sc57WJo4HHHV0slZTZrL26s4ZQagWhw==
X-Received: by 2002:a62:571b:: with SMTP id l27-v6mr871606pfb.29.1533794858745;
        Wed, 08 Aug 2018 23:07:38 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:180::1:ea8d])
        by smtp.gmail.com with ESMTPSA id f65-v6sm18537854pfj.46.2018.08.08.23.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 23:07:37 -0700 (PDT)
Date:   Wed, 8 Aug 2018 23:07:35 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/4] Convert filter.txt to RST
Message-ID: <20180809060734.rtqqu4sexbwzuqmm@ast-mbp>
References: <20180809052328.27942-1-me@tobin.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809052328.27942-1-me@tobin.cc>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 03:23:24PM +1000, Tobin C. Harding wrote:
> 
> Daniel and Alexei, can I please have permission to add GPLv2+ to the BPF
> docs?

kernel licensing is GPLv2 without +
every file (including docs) can potentially have a different
compatible license, but since they were developed
implicitly under v2 only you would need to get a buy-in from
all contributors before making such change.

