Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9A9C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E002150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0Jhnwji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E002150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733134AbeITDae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:30:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46502 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbeITDae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:30:34 -0400
Received: by mail-pl1-f194.google.com with SMTP id a11-v6so161967plm.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 14:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CYWxzkPUJbrkq8RVb9ClGYpCyRZd9gENqSgUSF3/KXE=;
        b=G0JhnwjiStZ/+2QzjAhhLcWWimjePFy6AR+B6878y7XhuuZb9bFF19SdppJ91Uxhsf
         nmOLVzpscAcsupax7RugZqb4OljLR/dc/6mEFwBp/wpZOd1NEEHiZozBdrORPqWMtdNG
         Zd3HSh3uubZTwC1D8c94F1xYiLcUYrN/fqNFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CYWxzkPUJbrkq8RVb9ClGYpCyRZd9gENqSgUSF3/KXE=;
        b=CA2jV8EZA9xJ7CTuALWNq6etCLw6FyGSoz1OGvJD6yaVtllVwunuYdcbIELfJ/eg2Y
         k6kSiFhIlf2HH1jrLueQrCjxnDAh0nBQcPpuVwLWiVtYJKScgJSL5u6gG1JXf4iAiaQE
         ULD2jvvw1kWNUzHdk2yeELcUarAoNl3V9btpDzJKm1YDPIIYufophGdZTWIHLcpJmqIW
         HaYcImasp+pMXm9O6LhVhuP8wZSvpARSpcCkrFicZ2RCy60KKQqBilO0SSpws98p7WX3
         9UhazbByDZlL/en0+0yYuCecErtdwGm+XssE+14JSQm8d7nFzDY8Ult1zXBI+HqYExef
         iCZw==
X-Gm-Message-State: APzg51DetXRFzeqCJdEAmglA45dbSIL69bFrbaRhn69STvjGMrr+gHCh
        vkhyqAQsfmef14DGnglYYPTd6w==
X-Google-Smtp-Source: ANB0VdauXKHieEU8D8LJ7aFNGppHOOw11XtIPzmff7M+Vw2BPl07B4DVAPOYogW42GXFTdY/QdN8Xw==
X-Received: by 2002:a17:902:8681:: with SMTP id g1-v6mr35507520plo.302.1537393841029;
        Wed, 19 Sep 2018 14:50:41 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id f11-v6sm32535336pfa.131.2018.09.19.14.50.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 14:50:40 -0700 (PDT)
Date:   Wed, 19 Sep 2018 14:50:39 -0700
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>, ilia.lin@gmail.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cpufreq: qcom-kryo: Fix section mismatch warning
Message-ID: <20180919215039.mb7prmmfs5jek3aj@vireshk-mac-ubuntu>
References: <20180919182247.1101-1-natechancellor@gmail.com>
 <CAKwvOdnW8p4Tj2n+Y4XyMMVdD7W90W4NTLkJHKhZ6604ah4fnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnW8p4Tj2n+Y4XyMMVdD7W90W4NTLkJHKhZ6604ah4fnw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-09-18, 14:45, Nick Desaulniers wrote:
> On Wed, Sep 19, 2018 at 11:22 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > WARNING: vmlinux.o(.text+0x8aa424): Section mismatch in reference from
> > the function qcom_cpufreq_kryo_probe() to the function
> > .init.text:qcom_cpufreq_kryo_get_msm_id()
> > The function qcom_cpufreq_kryo_probe() references
> > the function __init qcom_cpufreq_kryo_get_msm_id().
> > This is often because qcom_cpufreq_kryo_probe lacks a __init
> > annotation or the annotation of qcom_cpufreq_kryo_get_msm_id is wrong.
> >
> > Add the '__init' annotation to qcom_cpufreq_kryo_probe so that there is
> > no more mismatch warning.
> 
> I wonder why this driver has an exit function marked __init rather
> than __exit?

I think it was just a mistake.

> Does that mean it gets cleaned up after kernel init, and
> so on unloading of the driver, the kernel jumps to unmapped memory?

The __init/exit sections are only useful when the driver is builtin
and so there is no unloading. Yeah, if you would have tried to call
shutdown for the kernel, it may have crashed or something. I don't
know.

> Does this patch now produce a warning for `qcom_cpufreq_kryo_driver`
> referencing `qcom_cpufreq_kryo_probe`?

Why should it ? It doesn't though.

-- 
viresh
