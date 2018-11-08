Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F067CC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE6F208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkRWyYVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE6F208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeKHUqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:46:11 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34019 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeKHUqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:46:11 -0500
Received: by mail-lj1-f194.google.com with SMTP id u6-v6so17638311ljd.1;
        Thu, 08 Nov 2018 03:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F5mHs7gkvffabuaktZvHmAsBVX1jW0+OfQJRtp2oh3A=;
        b=DkRWyYVSS1YUbVMa2dCN6Hv4ZY11lWDDvVN+zyllKlSStYAwkFcNMn7RNzFSuIYOBZ
         iFcM9NG5Fbv1JvwtUdWEGMt9stDOCl/uKWu19gZ13Yfd2LTu05EStvYyOoPlAQnN/7N4
         wV9cCmYSNvaXd8Q/KhvDnepz/wElZfkKnZRfJeLK0KFeV375SDQb+8xs8t38WOK5YDxv
         hnQcMQEL82d7Zf01YagcldL570jre5Zwg2Gyl6+4NG8sAtdzpbuZyhGCOmC9JAOWdMFb
         HwJ+FfYpZipyUVisekg98abAR14lofUnSBKpe/GZi1zCwn59q3FH7/kRWPRp889Jx5cR
         p1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F5mHs7gkvffabuaktZvHmAsBVX1jW0+OfQJRtp2oh3A=;
        b=audqCouCWPgDXwTL1DOjBeun32r/Bif7GwAv8zOm/+QywyXRHKWc7ZhS0bSlQA/4FY
         lpjriyS5WpJ+PU803xhzl38uEqrmz0QKa7l8tfSfCycugu+8aX9wDK3CVBnQT5BEqVvB
         NWynRnaH67V6GXCsCZl3Lfnms8OT2zJiFygBy6CoCvrQYvz4RY0eRy53zv33Q+/aWfZZ
         XkO3E8O99FQS0cPc9O54tV7qEJSKS8MWirb5S6z9uJZeXFEsxJn4po6dISzhN7sVGOov
         b03uQDOvUvE5thwyTzfXHSGsP0eluQ3D/0ZPhZq6suk59aVjH2ao/S9pvnD+nr2+qZga
         0npA==
X-Gm-Message-State: AGRZ1gLrdqMt+FcdHx8a6S2Tjhc7/YzDzufScpuZxHAqJL6B1qjLUQli
        95shirQ2ExAXAXUM+eNN8EU=
X-Google-Smtp-Source: AJdET5ej40/pfEXdAZtwWgTtxPORjQEqbfyJZ1spPjsdSbt/cCugkORxB6JW/mzBZqMtb2GSD15w1g==
X-Received: by 2002:a2e:5418:: with SMTP id i24-v6mr2754340ljb.51.1541675470408;
        Thu, 08 Nov 2018 03:11:10 -0800 (PST)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id y11-v6sm603970ljc.85.2018.11.08.03.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 03:11:09 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 8715D4607CD; Thu,  8 Nov 2018 14:11:05 +0300 (MSK)
Date:   Thu, 8 Nov 2018 14:11:05 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org
Subject: Re: [PATCH] proc: fix proc-self-map-files selftest for arm
Message-ID: <20181108111105.GC13195@uranus.lan>
References: <20181011184359.15627-1-rafael.tinoco@linaro.org>
 <20181011205601.GA32757@avx2>
 <20181011210256.GE2401@uranus.lan>
 <20181011213006.GA13485@avx2>
 <20181011220009.GF2401@uranus.lan>
 <52504bd5-b4ed-518b-f748-c634172c6c68@linaro.org>
 <20181015172140.GJ2401@uranus.lan>
 <CABdQkv_vWNbMgvR+1q9gNGHUjvvR5Pb3Z9t3YKhahp4h4P5isQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABdQkv_vWNbMgvR+1q9gNGHUjvvR5Pb3Z9t3YKhahp4h4P5isQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 08:41:46AM -0200, Rafael David Tinoco wrote:
> >
> > As to me -- yes, I would move zero page testing to a separate memory testcase.
> > But since Alexey is the former author of the tests better wait for his opinion.
> 
> Alexey,
> 
> would you care if we turn those 2 tests into 1, taking care of the
> zero page testing elsewhere ? Would you mind if I send out a patch for
> that ?

Rafael, just make it so. While we preserve old functionality
I think it is fine.

	Cyrill
